Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0E6C3AF9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCUTuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCUTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:50:04 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550D5976F;
        Tue, 21 Mar 2023 12:49:58 -0700 (PDT)
Date:   Tue, 21 Mar 2023 19:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679428196; x=1679687396;
        bh=G5OcfJ1sRCppIjvccB3dNK4jRstnIpG0oGXnr2BMLSs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bHvk1Ac6pHL1Afyx6ou/eLGrvVaRYvERQsJeRAoexo24UmVJqgmqvvdOXPZPrFOrd
         GCM0mZBrWS+WbSjx1EK1rf5EAyhWxLCGo02NsFUgf48HdZiEiW3Od+d/oFo7P1zE68
         WJoztjM+mAl51Ou63bBjHuh1I+ButYNT2pYoG4KcwNukLo4C77VifWr+yL3GRezN7J
         8QkOauGfoSnv/Zr+cl/ybjMTuCgb4ZJJ4O+aT7tbgHzIvCW8ccBeQxcDSnyZCnrYrs
         iQp6vcWcaY3sAoWsGC1GeM/nhVseJKJ1YVO8yZBY30bq9U/bnSUtc2t3ohM22CMlkE
         T2VnyFRGIC77Q==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v2 1/5] rust: macros: add `quote!` macro
Message-ID: <20230321194934.908891-2-y86-dev@protonmail.com>
In-Reply-To: <20230321194934.908891-1-y86-dev@protonmail.com>
References: <20230321194934.908891-1-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
---
 rust/macros/lib.rs   |   2 +
 rust/macros/quote.rs | 143 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
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
index 000000000000..00fc75fecd03
--- /dev/null
+++ b/rust/macros/quote.rs
@@ -0,0 +1,143 @@
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
+macro_rules! quote_spanned {
+    ($span:expr =3D> $($tt:tt)*) =3D> {
+    #[allow(clippy::vec_init_then_push)]
+    {
+        let mut tokens =3D Vec::new();
+        let span =3D $span;
+        quote_spanned!(@proc tokens span $($tt)*);
+        proc_macro::TokenStream::from_iter(tokens)
+    }};
+    (@proc $v:ident $span:ident) =3D> {};
+    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) =3D> {
+        let mut ts =3D proc_macro::TokenStream::new();
+        crate::quote::ToTokens::to_tokens(&$id, &mut ts);
+        $v.extend(ts.into_iter());
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) =3D> {
+        for token in $id {
+            let mut ts =3D proc_macro::TokenStream::new();
+            crate::quote::ToTokens::to_tokens(&token, &mut ts);
+            $v.extend(ts.into_iter());
+        }
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) =3D> {
+        let mut tokens =3D Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
+            proc_macro::Delimiter::Parenthesis,
+            proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) =3D> {
+        let mut tokens =3D Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
+            proc_macro::Delimiter::Bracket,
+            proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) =3D> {
+        let mut tokens =3D Vec::new();
+        quote_spanned!(@proc tokens $span $($inner)*);
+        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
+            proc_macro::Delimiter::Brace,
+            proc_macro::TokenStream::from_iter(tokens)
+        )));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident :: $($tt:tt)*) =3D> {
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_=
macro::Spacing::Joint))
+        );
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_=
macro::Spacing::Alone))
+        );
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident : $($tt:tt)*) =3D> {
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_=
macro::Spacing::Alone))
+        );
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident , $($tt:tt)*) =3D> {
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new(',', proc_=
macro::Spacing::Alone))
+        );
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident @ $($tt:tt)*) =3D> {
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new('@', proc_=
macro::Spacing::Alone))
+        );
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident ! $($tt:tt)*) =3D> {
+        $v.push(
+            proc_macro::TokenTree::Punct(proc_macro::Punct::new('!', proc_=
macro::Spacing::Alone))
+        );
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
+        $v.push(proc_macro::TokenTree::Ident(proc_macro::Ident::new(string=
ify!($id), $span)));
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
+macro_rules! quote {
+    ($($tt:tt)*) =3D> {
+        quote_spanned!(proc_macro::Span::mixed_site() =3D> $($tt)*)
+    }
+}
--
2.39.2


