Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7766DBAD8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDHMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDHMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:25:36 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B49FF0E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 05:25:35 -0700 (PDT)
Date:   Sat, 08 Apr 2023 12:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680956733; x=1681215933;
        bh=K9JbIFZF8PegFhJuUFtlmmuNCJL0YgKAbcJnn1iYflI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xyxNIwI5rbLIDZRXv6V8QWw/emXcOZO2V0U++S4GLVil8TNtAseaDnoeznUnGmurX
         RQHjT5gNMUSagRlWnmJWeoyIfxzaSHrhbSph+8Sh5rCoF2GWB69LDHqOdzq4PKpd//
         MX4dRnj23UDTjI7PsNOf2PPnvq08qepMmmiuQU3fX0E/6oGVIalymfvUrE44V47P6G
         bDgG3c7e7djLmNm+qypzrWcxlvi7+B7NI8jH4bDMuuqxLi3El19b4wYGqLO/OsGMyF
         pV9ms3oQnFKdXNVlrychje6q0MaT6hMBnfuRA912x3lFBCX2zdC+z0CYodga3UA/qG
         WAE8i05K/bp5g==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v7 02/15] rust: macros: add `quote!` macro
Message-ID: <20230408122429.1103522-3-y86-dev@protonmail.com>
In-Reply-To: <20230408122429.1103522-1-y86-dev@protonmail.com>
References: <20230408122429.1103522-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gary Guo <gary@garyguo.net>

Add the `quote!` macro for creating `TokenStream`s directly via the
given Rust tokens. It also supports repetitions using iterators.

It will be used by the pin-init API proc-macros to generate code.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/macros/lib.rs   |   2 +
 rust/macros/quote.rs | 145 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 rust/macros/quote.rs

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index c1d385e345b9..82b520f024dd 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -2,6 +2,8 @@

 //! Crate for all kernel procedural macros.

+#[macro_use]
+mod quote;
 mod concat_idents;
 mod helpers;
 mod module;
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
new file mode 100644
index 000000000000..94a6277182ee
--- /dev/null
+++ b/rust/macros/quote.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
+use proc_macro::{TokenStream, TokenTree};
+
+pub(crate) trait ToTokens {
+    fn to_tokens(&self, tokens: &mut TokenStream);
+}
+
+impl<T: ToTokens> ToTokens for Option<T> {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        if let Some(v) =3D self {
+            v.to_tokens(tokens);
+        }
+    }
+}
+
+impl ToTokens for proc_macro::Group {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        tokens.extend([TokenTree::from(self.clone())]);
+    }
+}
+
+impl ToTokens for TokenTree {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        tokens.extend([self.clone()]);
+    }
+}
+
+impl ToTokens for TokenStream {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        tokens.extend(self.clone());
+    }
+}
+
+/// Converts tokens into [`proc_macro::TokenStream`] and performs variable=
 interpolations with
+/// the given span.
+///
+/// This is a similar to the
+/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_span=
ned.html) macro from the
+/// `quote` crate but provides only just enough functionality needed by th=
e current `macros` crate.
+#[allow(unused_macros)]
+macro_rules! quote_spanned {
+    ($span:expr =3D> $($tt:tt)*) =3D> {
+    #[allow(clippy::vec_init_then_push)]
+    {
+        let mut tokens =3D ::std::vec::Vec::new();
+        let span =3D $span;
+        quote_spanned!(@proc tokens span $($tt)*);
+        ::proc_macro::TokenStream::from_iter(tokens)
+    }};
+    (@proc $v:ident $span:ident) =3D> {};
+    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) =3D> {
+        let mut ts =3D ::proc_macro::TokenStream::new();
+        $crate::quote::ToTokens::to_tokens(&$id, &mut ts);
+        $v.extend(ts);
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) =3D> {
+        for token in $id {
+            let mut ts =3D ::proc_macro::TokenStream::new();
+            $crate::quote::ToTokens::to_tokens(&token, &mut ts);
+            $v.extend(ts);
+        }
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) =3D> {
+        let mut tokens =3D ::std::vec::Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+            ::proc_macro::Delimiter::Parenthesis,
+            ::proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) =3D> {
+        let mut tokens =3D ::std::vec::Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+            ::proc_macro::Delimiter::Bracket,
+            ::proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) =3D> {
+        let mut tokens =3D ::std::vec::Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
+            ::proc_macro::Delimiter::Brace,
+            ::proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident :: $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Joint=
)
+        ));
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident : $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident , $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident @ $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident ! $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone=
)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
+        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(st=
ringify!($id), $span)));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+}
+
+/// Converts tokens into [`proc_macro::TokenStream`] and performs variable=
 interpolations with
+/// mixed site span ([`Span::mixed_site()`]).
+///
+/// This is a similar to the [`quote!`](https://docs.rs/quote/latest/quote=
/macro.quote.html) macro
+/// from the `quote` crate but provides only just enough functionality nee=
ded by the current
+/// `macros` crate.
+///
+/// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.Sp=
an.html#method.mixed_site
+#[allow(unused_macros)]
+macro_rules! quote {
+    ($($tt:tt)*) =3D> {
+        quote_spanned!(::proc_macro::Span::mixed_site() =3D> $($tt)*)
+    }
+}
--
2.39.2


