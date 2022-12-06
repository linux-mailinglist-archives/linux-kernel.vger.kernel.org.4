Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506846443C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiLFM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiLFM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:59:04 -0500
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [IPv6:2001:67c:2050:102:465::105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AE7674;
        Tue,  6 Dec 2022 04:58:52 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4NRKxl3xwzz9sjV;
        Tue,  6 Dec 2022 13:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1670330987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/IyN1k4sSXgRCF+1+PEIqkIeiletM0hoWg5Wus4Inc=;
        b=C1I5Mkgg0aIUt6yc1nwq14VaB7duUSkdcsAE7ghJWi7wCbqy/E33FDUtmGliIlQ2D2tspP
        owmb0+uQ2X3y1z0dQFAUiJj8/WtyaIvEll6eJl61Q8MctAzcSqGRQBgZdS/+C/mre8JNf7
        p/JmrDun/KHtRjQHtIV9DpSwvReMWvhYXAHTcHJDreIVlgg2q6yHW07zuYHTwHI2F3XJ42
        /O9w476WQnVgy3D0eCbnVkBBu1dcIiJMI2uYf33sOopSXjTcaiv9EFV7kZh0vO+9ezNQwR
        KkKsq/1RoK+dR+R6UqACBTWZjqXVtLtdrbaNV7r9vtaTB/IjdDcpI+fCIg4SSQ==
From:   Finn Behrens <fin@nyantec.com>
To:     ojeda@kernel.org
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Subject: Re: [PATCH v2 06/28] rust: macros: add `#[vtable]` proc macro
Date:   Tue, 06 Dec 2022 13:49:40 +0100
Message-ID: <982F921F-08BF-43E3-95F3-20329AB59A69@nyantec.com>
In-Reply-To: <20221202161502.385525-7-ojeda@kernel.org>
References: <20221202161502.385525-1-ojeda@kernel.org>
 <20221202161502.385525-7-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2 Dec 2022, at 17:14, ojeda@kernel.org wrote:

> From: Gary Guo <gary@garyguo.net>
>
> This procedural macro attribute provides a simple way to declare
> a trait with a set of operations that later users can partially
> implement, providing compile-time `HAS_*` boolean associated
> constants that indicate whether a particular operation was overridden.
>
> This is useful as the Rust counterpart to structs like
> `file_operations` where some pointers may be `NULL`, indicating
> an operation is not provided.
>
> For instance:
>
>     #[vtable]
>     trait Operations {
>         fn read(...) -> Result<usize> {
>             Err(EINVAL)
>         }
>
>         fn write(...) -> Result<usize> {
>             Err(EINVAL)
>         }
>     }
>
>     #[vtable]
>     impl Operations for S {
>         fn read(...) -> Result<usize> {
>             ...
>         }
>     }
>
>     assert_eq!(<S as Operations>::HAS_READ, true);
>     assert_eq!(<S as Operations>::HAS_WRITE, false);
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Finn Behrens <fin@nyantec.com>

Regards,
Finn

> ---
>  rust/kernel/prelude.rs |  2 +-
>  rust/macros/lib.rs     | 52 +++++++++++++++++++++++
>  rust/macros/vtable.rs  | 95 ++++++++++++++++++++++++++++++++++++++++++=

>  3 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 rust/macros/vtable.rs
>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 6a1c6b38327f..7c4c35bf3c66 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -15,7 +15,7 @@ pub use core::pin::Pin;
>
>  pub use alloc::{boxed::Box, vec::Vec};
>
> -pub use macros::module;
> +pub use macros::{module, vtable};
>
>  pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info=
, pr_notice, pr_warn};
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 15555e7ff487..e40caaf0a656 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -5,6 +5,7 @@
>  mod concat_idents;
>  mod helpers;
>  mod module;
> +mod vtable;
>
>  use proc_macro::TokenStream;
>
> @@ -72,6 +73,57 @@ pub fn module(ts: TokenStream) -> TokenStream {
>      module::module(ts)
>  }
>
> +/// Declares or implements a vtable trait.
> +///
> +/// Linux's use of pure vtables is very close to Rust traits, but they=
 differ
> +/// in how unimplemented functions are represented. In Rust, traits ca=
n provide
> +/// default implementation for all non-required methods (and the defau=
lt
> +/// implementation could just return `Error::EINVAL`); Linux typically=
 use C
> +/// `NULL` pointers to represent these functions.
> +///
> +/// This attribute is intended to close the gap. Traits can be declare=
d and
> +/// implemented with the `#[vtable]` attribute, and a `HAS_*` associat=
ed constant
> +/// will be generated for each method in the trait, indicating if the =
implementor
> +/// has overridden a method.
> +///
> +/// This attribute is not needed if all methods are required.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// use kernel::prelude::*;
> +///
> +/// // Declares a `#[vtable]` trait
> +/// #[vtable]
> +/// pub trait Operations: Send + Sync + Sized {
> +///     fn foo(&self) -> Result<()> {
> +///         Err(EINVAL)
> +///     }
> +///
> +///     fn bar(&self) -> Result<()> {
> +///         Err(EINVAL)
> +///     }
> +/// }
> +///
> +/// struct Foo;
> +///
> +/// // Implements the `#[vtable]` trait
> +/// #[vtable]
> +/// impl Operations for Foo {
> +///     fn foo(&self) -> Result<()> {
> +/// #        Err(EINVAL)
> +///         // ...
> +///     }
> +/// }
> +///
> +/// assert_eq!(<Foo as Operations>::HAS_FOO, true);
> +/// assert_eq!(<Foo as Operations>::HAS_BAR, false);
> +/// ```
> +#[proc_macro_attribute]
> +pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
> +    vtable::vtable(attr, ts)
> +}
> +
>  /// Concatenate two identifiers.
>  ///
>  /// This is useful in macros that need to declare or reference items w=
ith names
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> new file mode 100644
> index 000000000000..34d5e7fb5768
> --- /dev/null
> +++ b/rust/macros/vtable.rs
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
> +use std::collections::HashSet;
> +use std::fmt::Write;
> +
> +pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStre=
am {
> +    let mut tokens: Vec<_> =3D ts.into_iter().collect();
> +
> +    // Scan for the `trait` or `impl` keyword.
> +    let is_trait =3D tokens
> +        .iter()
> +        .find_map(|token| match token {
> +            TokenTree::Ident(ident) =3D> match ident.to_string().as_st=
r() {
> +                "trait" =3D> Some(true),
> +                "impl" =3D> Some(false),
> +                _ =3D> None,
> +            },
> +            _ =3D> None,
> +        })
> +        .expect("#[vtable] attribute should only be applied to trait o=
r impl block");
> +
> +    // Retrieve the main body. The main body should be the last token =
tree.
> +    let body =3D match tokens.pop() {
> +        Some(TokenTree::Group(group)) if group.delimiter() =3D=3D Deli=
miter::Brace =3D> group,
> +        _ =3D> panic!("cannot locate main body of trait or impl block"=
),
> +    };
> +
> +    let mut body_it =3D body.stream().into_iter();
> +    let mut functions =3D Vec::new();
> +    let mut consts =3D HashSet::new();
> +    while let Some(token) =3D body_it.next() {
> +        match token {
> +            TokenTree::Ident(ident) if ident.to_string() =3D=3D "fn" =3D=
> {
> +                let fn_name =3D match body_it.next() {
> +                    Some(TokenTree::Ident(ident)) =3D> ident.to_string=
(),
> +                    // Possibly we've encountered a fn pointer type in=
stead.
> +                    _ =3D> continue,
> +                };
> +                functions.push(fn_name);
> +            }
> +            TokenTree::Ident(ident) if ident.to_string() =3D=3D "const=
" =3D> {
> +                let const_name =3D match body_it.next() {
> +                    Some(TokenTree::Ident(ident)) =3D> ident.to_string=
(),
> +                    // Possibly we've encountered an inline const bloc=
k instead.
> +                    _ =3D> continue,
> +                };
> +                consts.insert(const_name);
> +            }
> +            _ =3D> (),
> +        }
> +    }
> +
> +    let mut const_items;
> +    if is_trait {
> +        const_items =3D "
> +                /// A marker to prevent implementors from forgetting t=
o use [`#[vtable]`](vtable)
> +                /// attribute when implementing this trait.
> +                const USE_VTABLE_ATTR: ();
> +        "
> +        .to_owned();
> +
> +        for f in functions {
> +            let gen_const_name =3D format!("HAS_{}", f.to_uppercase())=
;
> +            // Skip if it's declared already -- this allows user overr=
ide.
> +            if consts.contains(&gen_const_name) {
> +                continue;
> +            }
> +            // We don't know on the implementation-site whether a meth=
od is required or provided
> +            // so we have to generate a const for all methods.
> +            write!(
> +                const_items,
> +                "/// Indicates if the `{f}` method is overridden by th=
e implementor.
> +                const {gen_const_name}: bool =3D false;",
> +            )
> +            .unwrap();
> +        }
> +    } else {
> +        const_items =3D "const USE_VTABLE_ATTR: () =3D ();".to_owned()=
;
> +
> +        for f in functions {
> +            let gen_const_name =3D format!("HAS_{}", f.to_uppercase())=
;
> +            if consts.contains(&gen_const_name) {
> +                continue;
> +            }
> +            write!(const_items, "const {gen_const_name}: bool =3D true=
;").unwrap();
> +        }
> +    }
> +
> +    let new_body =3D vec![const_items.parse().unwrap(), body.stream()]=

> +        .into_iter()
> +        .collect();
> +    tokens.push(TokenTree::Group(Group::new(Delimiter::Brace, new_body=
)));
> +    tokens.into_iter().collect()
> +}
> -- =

> 2.38.1
