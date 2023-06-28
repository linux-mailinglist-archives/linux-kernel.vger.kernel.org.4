Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13DC741893
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjF1TDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:03:52 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:53709 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjF1TDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:03:34 -0400
Date:   Wed, 28 Jun 2023 19:03:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687979012; x=1688238212;
        bh=WcCvBL0cCw/IzHFfDMhfCJ7DTv31iVJ5flVSHLyA5Go=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=f0jM94fePW4sDpxRlGXG1qseYnLEuB4Mj+IlVBZk0VHR7bJ3ytdt0YiTIQQSQ3p3M
         86d5QsQEIVDpgFwa7s+NqyPN1EPeJjq70qhPMg9abhnHIWw8YUjwpFR1MCSYgAdLg8
         iC7tz7YV3M/RJASvconVYU1vwQMYdtIKaJdtZ9x5rgMdgZkvVMOwKyYgKU9pwJTs9h
         xrJ7Ym2OOxM+hO/yXEmGMfFQ3btyXY1J6m09/qIWkFKikdhKIERalgbYzUMn3DaFCk
         qogkoC918sgCWSpd1wSsXzRbA0nzVD/f8CazHmbyv22Vsu01rWTW+KLuLdlHASE7tD
         kAQHVgCv4onqQ==
To:     Gary Guo <gary@garyguo.net>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
Message-ID: <K0T5KNPT6EKzSy_VRokavbT2bTKLQ51nTRV9gRcKSwyLApxIWKYoRbw1WihNZC98eARwVpQDPAS-S5w6Rw_CnlivYrBQsKAJ-A2frwCoflw=@protonmail.com>
In-Reply-To: <20230628171108.1150742-1-gary@garyguo.net>
References: <20230628171108.1150742-1-gary@garyguo.net>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 28th, 2023 at 19:11, Gary Guo <gary@garyguo.net> wrote:

> This macro provides a flexible way to concatenated identifiers together
> and it allows the resulting identifier to be used to declare new items,
> which `concat_idents!` does not allow. It also allows identifiers to be
> transformed before concatenated.
>=20
> The `concat_idents!` example
>=20
>     let x_1 =3D 42;
>     let x_2 =3D concat_idents!(x, _1);
>     assert!(x_1 =3D=3D x_2);
>=20
> can be written with `paste!` macro like this:
>=20
>     let x_1 =3D 42;
>     let x_2 =3D paste!([<x _1>]);
>     assert!(x_1 =3D=3D x_2);
>=20
> However `paste!` macro is more flexible because it can be used to create
> a new variable:
>=20
>     let x_1 =3D 42;
>     paste!(let [<x _2>] =3D [<x _1>];);
>     assert!(x_1 =3D=3D x_2);
>=20
> While this is not possible with `concat_idents!`.
>=20
> This macro is similar to the `paste!` crate [1], but this is a fresh
> implementation to avoid vendoring large amount of code directly. Also, I
> have augmented it to provide a way to specify span of the resulting
> token, allowing precise control.
>=20
> For example, this code is broken because the variable is declared inside
> the macro, so Rust macro hygiene rules prevents access from the outside:
>=20
>     macro_rules! m {
>         ($id: ident) =3D> {
>             // The resulting token has hygiene of the macro.
>             paste!(let [<$id>] =3D 1;)
>         }
>     }
>=20
>     m!(a);
>     let _ =3D a;
>=20
> In this versionn of `paste!` macro I added a `span` modifier to allow

*version

> this:
>=20
>     macro_rules! m {
>         ($id: ident) =3D> {
>             // The resulting token has hygiene of `$id`.
>             paste!(let [<$id:span>] =3D 1;)
>         }
>     }
>=20
>     m!(a);
>     let _ =3D a;
>=20
> Link: http://docs.rs/paste/ [1]
> Signed-off-by: Gary Guo <gary@garyguo.net>

With the typo above fixed:

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

I have also got a minor suggestion below, but I'm ok with keeping it as is.

> ---
>  rust/macros/lib.rs   | 97 ++++++++++++++++++++++++++++++++++++++++++++
>  rust/macros/paste.rs | 94 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 191 insertions(+)
>  create mode 100644 rust/macros/paste.rs
>=20
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 3fc74cb4ea19..b4bc44c27bd4 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -7,6 +7,7 @@
>  mod concat_idents;
>  mod helpers;
>  mod module;
> +mod paste;
>  mod pin_data;
>  mod pinned_drop;
>  mod vtable;
> @@ -246,3 +247,99 @@ pub fn pin_data(inner: TokenStream, item: TokenStrea=
m) -> TokenStream {
>  pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream=
 {
>      pinned_drop::pinned_drop(args, input)
>  }
> +
> +/// Paste identifiers together.
> +///
> +/// Within the `paste!` macro, identifiers inside `[<` and `>]` are conc=
atenated together to form a
> +/// single identifier.
> +///
> +/// This is similar to the [`paste`] crate, but with pasting feature lim=
ited to identifiers
> +/// (literals, lifetimes and documentation strings are not supported). T=
here is a difference in
> +/// supported modifiers as well.
> +///
> +/// # Example
> +///
> +/// ```ignore
> +/// use kernel::macro::paste;
> +///
> +/// macro_rules! pub_no_prefix {
> +///     ($prefix:ident, $($newname:ident),+) =3D> {
> +///         paste! {
> +///             $(pub(crate) const $newname: u32 =3D [<$prefix $newname>=
];)+
> +///         }
> +///     };
> +/// }
> +///
> +/// pub_no_prefix!(
> +///     binder_driver_return_protocol_,
> +///     BR_OK,
> +///     BR_ERROR,
> +///     BR_TRANSACTION,
> +///     BR_REPLY,
> +///     BR_DEAD_REPLY,
> +///     BR_TRANSACTION_COMPLETE,
> +///     BR_INCREFS,
> +///     BR_ACQUIRE,
> +///     BR_RELEASE,
> +///     BR_DECREFS,
> +///     BR_NOOP,
> +///     BR_SPAWN_LOOPER,
> +///     BR_DEAD_BINDER,
> +///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
> +///     BR_FAILED_REPLY
> +/// );
> +///
> +/// assert_eq!(BR_OK, binder_driver_return_protocol_BR_OK);
> +/// ```
> +///
> +/// # Modifiers
> +///
> +/// For each identifier, it is possible to attach one or multiple modifi=
ers to
> +/// it.
> +///
> +/// Currently supported modifiers are:
> +/// * `span`: change the span of concatenated identifier to the span of =
the specified token. By
> +/// default the span of the `[< >]` group is used.
> +/// * `lower`: change the identifier to lower case.
> +/// * `upper`: change the identifier to upper case.
> +///
> +/// ```ignore
> +/// use kernel::macro::paste;
> +///
> +/// macro_rules! pub_no_prefix {
> +///     ($prefix:ident, $($newname:ident),+) =3D> {
> +///         kernel::macros::paste! {
> +///             $(pub(crate) const fn [<$newname:lower:span>]: u32 =3D [=
<$prefix $newname:span>];)+

Having multiple : when using multiple flags feels a bit weird to me. Maybe
use $newname:lower+span, $newname:lower,span or something like that? If you
prefer the current syntax that is fine with me too though.

> +///         }
> +///     };
> +/// }
> +///
> +/// pub_no_prefix!(
> +///     binder_driver_return_protocol_,
> +///     BR_OK,
> +///     BR_ERROR,
> +///     BR_TRANSACTION,
> +///     BR_REPLY,
> +///     BR_DEAD_REPLY,
> +///     BR_TRANSACTION_COMPLETE,
> +///     BR_INCREFS,
> +///     BR_ACQUIRE,
> +///     BR_RELEASE,
> +///     BR_DECREFS,
> +///     BR_NOOP,
> +///     BR_SPAWN_LOOPER,
> +///     BR_DEAD_BINDER,
> +///     BR_CLEAR_DEATH_NOTIFICATION_DONE,
> +///     BR_FAILED_REPLY
> +/// );
> +///
> +/// assert_eq!(br_ok(), binder_driver_return_protocol_BR_OK);
> +/// ```
> +///
> +/// [`paste`]: https://docs.rs/paste/
> +#[proc_macro]
> +pub fn paste(input: TokenStream) -> TokenStream {
> +    let mut tokens =3D input.into_iter().collect();
> +    paste::expand(&mut tokens);
> +    tokens.into_iter().collect()
> +}
> diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> new file mode 100644
> index 000000000000..42fde0930b05
> --- /dev/null
> +++ b/rust/macros/paste.rs
> @@ -0,0 +1,94 @@
> +use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
> +
> +fn concat(tokens: &[TokenTree], group_span: Span) -> TokenTree {
> +    let mut tokens =3D tokens.iter();
> +    let mut segments =3D Vec::new();
> +    let mut span =3D None;
> +    loop {
> +        match tokens.next() {
> +            None =3D> break,
> +            Some(TokenTree::Literal(lit)) =3D> segments.push((lit.to_str=
ing(), lit.span())),
> +            Some(TokenTree::Ident(ident)) =3D> {
> +                let mut value =3D ident.to_string();
> +                if value.starts_with("r#") {
> +                    value.replace_range(0..2, "");
> +                }
> +                segments.push((value, ident.span()));
> +            }
> +            Some(TokenTree::Punct(p)) if p.as_char() =3D=3D ':' =3D> {
> +                let Some(TokenTree::Ident(ident)) =3D tokens.next() else=
 {
> +                    panic!("expected identifier as modifier");
> +                };
> +
> +                let (mut value, sp) =3D segments.pop().expect("expected =
identifier before modifier");
> +                match ident.to_string().as_str() {
> +                    // Set the overall span of concatenated token as cur=
rent span
> +                    "span" =3D> {
> +                        assert!(
> +                            span.is_none(),
> +                            "span modifier should only appear at most on=
ce"
> +                        );
> +                        span =3D Some(sp);
> +                    }
> +                    "lower" =3D> value =3D value.to_lowercase(),
> +                    "upper" =3D> value =3D value.to_uppercase(),
> +                    v =3D> panic!("unknown modifier `{v}`"),
> +                };
> +                segments.push((value, sp));
> +            }
> +            _ =3D> panic!("unexpected token in paste segments"),
> +        };
> +    }
> +
> +    let pasted: String =3D segments.into_iter().map(|x| x.0).collect();
> +    TokenTree::Ident(Ident::new(&pasted, span.unwrap_or(group_span)))
> +}
> +
> +pub(crate) fn expand(tokens: &mut Vec<TokenTree>) {
> +    for token in tokens.iter_mut() {
> +        if let TokenTree::Group(group) =3D token {
> +            let delimiter =3D group.delimiter();
> +            let span =3D group.span();
> +            let mut stream: Vec<_> =3D group.stream().into_iter().collec=
t();
> +            // Find groups that looks like `[< A B C D >]`
> +            if delimiter =3D=3D Delimiter::Bracket
> +                && stream.len() >=3D 3
> +                && matches!(&stream[0], TokenTree::Punct(p) if p.as_char=
() =3D=3D '<')
> +                && matches!(&stream[stream.len() - 1], TokenTree::Punct(=
p) if p.as_char() =3D=3D '>')
> +            {
> +                // Replace the group with concatenated token
> +                *token =3D concat(&stream[1..stream.len() - 1], span);
> +            } else {
> +                // Recursively expand tokens inside the group
> +                expand(&mut stream);
> +                let mut group =3D Group::new(delimiter, stream.into_iter=
().collect());
> +                group.set_span(span);
> +                *token =3D TokenTree::Group(group);
> +            }
> +        }
> +    }
> +
> +    // Path segments cannot contain invisible delimiter group, so remove=
 them if any.
> +    for i in (0..tokens.len().saturating_sub(3)).rev() {
> +        // Looking for a double colon
> +        if matches!(
> +            (&tokens[i + 1], &tokens[i + 2]),
> +            (TokenTree::Punct(a), TokenTree::Punct(b))
> +                if a.as_char() =3D=3D ':' && a.spacing() =3D=3D Spacing:=
:Joint && b.as_char() =3D=3D ':'
> +        ) {
> +            match &tokens[i + 3] {
> +                TokenTree::Group(group) if group.delimiter() =3D=3D Deli=
miter::None =3D> {
> +                    tokens.splice(i + 3..i + 4, group.stream());
> +                }
> +                _ =3D> (),
> +            }
> +
> +            match &tokens[i] {
> +                TokenTree::Group(group) if group.delimiter() =3D=3D Deli=
miter::None =3D> {
> +                    tokens.splice(i..i + 1, group.stream());
> +                }
> +                _ =3D> (),
> +            }
> +        }
> +    }
> +}
> --=20
> 2.34.1
