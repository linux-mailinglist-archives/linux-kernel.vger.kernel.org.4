Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66B66B6D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCMBXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMBXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:23:33 -0400
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D327D79;
        Sun, 12 Mar 2023 18:23:30 -0700 (PDT)
Date:   Mon, 13 Mar 2023 01:23:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678670608; x=1678929808;
        bh=XdinrPtR68VBR2Oe7yoV/KX84VkXWkmiSOLxXszvESk=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=biOaiB8SrAcoEGLq2xURoFLR4bbe2u0lT5ad924UQqbgNhkMmOEuErl3nlJU2qnN0
         FYkoC19X0aMQ6UKrQh6rIz68CdOXi5ivzldTOgp4cvsG1rRSHv1H1iqAcDYNHpSr/d
         /cZiRO/WaDmxzRNbWjZ4msXoOd3WhEHcoQvm/wi40j6dbndSdX32djfmNOac9tK6p7
         MEy/vs9rtmnAgrfbupV/+pN7PmYDNbE9FMvc0P4QqWoKTiboDTMuRyDoYhdlCa4Z/h
         NU0rxSJM3n0GVGQlroRGXMxDSApKu6JzBwF/NezkCiLXJ6UFOHbiLCFbjjOFRURTuj
         w9Xq9gfCo717Q==
To:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: [PATCH v1 1/3] rust: macros: add `quote!` macro
Message-ID: <u9FrnEbtGtyUPp-CmzAQIv--8hmKwHdIIPiq-3IHJPcHdaJi_VXuDdVR2Js2GzvtWgCNrBLp4PhQs3tTlWNVDBZfIStCHiS9SoMtsDgc4oM=@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 rust/macros/quote.rs | 125 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 rust/macros/quote.rs

diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index c1d385e345b9..82b520f024dd 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -2,6 +2,8 @@
=20
 //! Crate for all kernel procedural macros.
=20
+#[macro_use]
+mod quote;
 mod concat_idents;
 mod helpers;
 mod module;
diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
new file mode 100644
index 000000000000..55b663d665ec
--- /dev/null
+++ b/rust/macros/quote.rs
@@ -0,0 +1,125 @@
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
+macro_rules! quote_spanned {
+    ($span:expr =3D> $($tt:tt)*) =3D> {{
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
+macro_rules! quote {
+    ($($tt:tt)*) =3D> {
+        quote_spanned!(proc_macro::Span::mixed_site() =3D> $($tt)*)
+    }
+}
--=20
2.39.2
