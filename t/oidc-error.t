use Mojo::Base -strict;
use Test::More;
use Test::Mojo;
use MIME::Base64 qw(encode_base64url);
use Mojo::JSON qw(decode_json encode_json);
use Mojo::URL;
use Mojolicious::Plugin::OAuth2;

plan skip_all => "Mojo::JWT, Crypt::OpenSSL::RSA and Crypt::OpenSSL::Bignum required for openid tests"
  unless Mojolicious::Plugin::OAuth2::MOJO_JWT;

use Mojolicious::Lite;

my $error = '';

plugin OAuth2 => {
  mocked => {
    key                   => 'invalid',
    well_known_url        => '/mocked/oauth2/.well-known/configuration',
    warmup_error_callback => sub { $error = $_[1] },
  }
};

like($error, qr/^Bad Request/, 'invalid key triggers callback');

done_testing;
