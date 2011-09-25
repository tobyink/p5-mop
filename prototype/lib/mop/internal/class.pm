package mop::internal::class;

use strict;
use warnings;

use mop::internal::instance;

sub create {
    my %params = @_;

    my $class        = $params{'class'}        || die "A class must have a (meta) class";
    my $name         = $params{'name'}         || die "A class must have a name";
    my $version      = $params{'version'}      || '0.01';
    my $authority    = $params{'authority'}    || '';
    my $superclasses = $params{'superclasses'} || [];
    my $attributes   = $params{'attributes'}   || {};
    my $methods      = $params{'methods'}      || {};

    mop::internal::instance::create(
        $class,
        {
            '$name'         => \$name,
            '$version'      => \$version,
            '$authority'    => \$authority,
            '$superclasses' => \$superclasses,
            '$attributes'   => \$attributes,
            '$methods'      => \$methods
        }
    );
}

# These two functions are needed by the internal::dispatchers

sub get_mro {
    my $class = shift;
    return [
        $class,
        map { @{ get_mro( $_ ) } } @{ mop::internal::instance::get_data_at( $class, '$superclasses' ) }
    ]
}

sub find_method {
    my ($class, $method_name) = @_;
    mop::internal::instance::get_data_at( $class, '$methods' )->{ $method_name };
}

1;

__END__

=pod

=head1 NAME

mop::internal::class

=head1 DESCRIPTION

=head1 AUTHOR

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2011 Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut