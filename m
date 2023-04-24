Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495346EC7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDXIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjDXILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:11:48 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD04E58;
        Mon, 24 Apr 2023 01:11:45 -0700 (PDT)
Date:   Mon, 24 Apr 2023 08:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1682323903; x=1682583103;
        bh=RUNMyd4H4XD6TO4X8sc2wnYhEAx+HVkNXO8MNMYE5N8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Q62kl+6TuKHTrT+CMX/qBxhc7l80lq1xvUnqqeAJLDaR56S1C1rKHaKRs7oAEU8iA
         jU7ek97cmOruPkIYkPNyxVGjFshqBnwqhE/l/MMBvCPqjFra20lV5vlrVz1KbSlSsk
         Eo9uZmHoagw7g9q7tF768d/OB0N8khZ4zsK7omdd1tJNFym5LUuld+PWX9f4X/jCjq
         b39K9dw5o3uJplQPD2udnLf7cCcMX+c2Ro/ltxGySqM6F+MTRXsjqjLtkGIv2JHLbA
         XBF54msZfql8B4iFkuFau8m6wNTyzokrWpunuVgQXDrIfQ+AewfsxI/Hqy9VvNRoqx
         asVt3nwX5BjMA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Subject: [PATCH 2/4] rust: macros: refactor generics parsing of `#[pin_data]` into its own function
Message-ID: <20230424081112.99890-2-benno.lossin@proton.me>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other macros might also want to parse generics. Additionally this makes
the code easier to read, as the next commit will introduce more code in
`#[pin_data]`. Also add more comments to explain how parsing generics
work.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/macros/helpers.rs  | 86 ++++++++++++++++++++++++++++++++++++++++-
 rust/macros/pin_data.rs | 70 +++++----------------------------
 2 files changed, 94 insertions(+), 62 deletions(-)

diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
index b2bdd4d8c958..afb0f2e3a36a 100644
--- a/rust/macros/helpers.rs
+++ b/rust/macros/helpers.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0

-use proc_macro::{token_stream, Group, TokenTree};
+use proc_macro::{token_stream, Group, Punct, Spacing, TokenStream, TokenTr=
ee};

 pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String>=
 {
     if let Some(TokenTree::Ident(ident)) =3D it.next() {
@@ -69,3 +69,87 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter=
) {
         panic!("Expected end");
     }
 }
+
+pub(crate) struct Generics {
+    pub(crate) impl_generics: Vec<TokenTree>,
+    pub(crate) ty_generics: Vec<TokenTree>,
+}
+
+/// Parses the given `TokenStream` into `Generics` and the rest.
+///
+/// The generics are not present in the rest, but a where clause might rem=
ain.
+pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTr=
ee>) {
+    // `impl_generics`, the declared generics with their bounds.
+    let mut impl_generics =3D vec![];
+    // Only the names of the generics, without any bounds.
+    let mut ty_generics =3D vec![];
+    // Tokens not related to the generics e.g. the `where` token and defin=
ition.
+    let mut rest =3D vec![];
+    // The current level of `<`.
+    let mut nesting =3D 0;
+    let mut toks =3D input.into_iter();
+    // If we are at the beginning of a generic parameter.
+    let mut at_start =3D true;
+    for tt in &mut toks {
+        match tt.clone() {
+            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
+                if nesting >=3D 1 {
+                    // This is inside of the generics and part of some bou=
nd.
+                    impl_generics.push(tt);
+                }
+                nesting +=3D 1;
+            }
+            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
+                // This is a parsing error, so we just end it here.
+                if nesting =3D=3D 0 {
+                    break;
+                } else {
+                    nesting -=3D 1;
+                    if nesting >=3D 1 {
+                        // We are still inside of the generics and part of=
 some bound.
+                        impl_generics.push(tt);
+                    }
+                    if nesting =3D=3D 0 {
+                        break;
+                    }
+                }
+            }
+            tt =3D> {
+                if nesting =3D=3D 1 {
+                    // Here depending on the token, it might be a generic =
variable name.
+                    match &tt {
+                        // Ignore const.
+                        TokenTree::Ident(i) if i.to_string() =3D=3D "const=
" =3D> {}
+                        TokenTree::Ident(_) if at_start =3D> {
+                            ty_generics.push(tt.clone());
+                            // We also already push the `,` token, this ma=
kes it easier to append
+                            // generics.
+                            ty_generics.push(TokenTree::Punct(Punct::new('=
,', Spacing::Alone)));
+                            at_start =3D false;
+                        }
+                        TokenTree::Punct(p) if p.as_char() =3D=3D ',' =3D>=
 at_start =3D true,
+                        // Lifetimes begin with `'`.
+                        TokenTree::Punct(p) if p.as_char() =3D=3D '\'' && =
at_start =3D> {
+                            ty_generics.push(tt.clone());
+                        }
+                        _ =3D> {}
+                    }
+                }
+                if nesting >=3D 1 {
+                    impl_generics.push(tt);
+                } else if nesting =3D=3D 0 {
+                    // If we haven't entered the generics yet, we still wa=
nt to keep these tokens.
+                    rest.push(tt);
+                }
+            }
+        }
+    }
+    rest.extend(toks);
+    (
+        Generics {
+            impl_generics,
+            ty_generics,
+        },
+        rest,
+    )
+}
diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
index 954149d77181..c593b05d9e8c 100644
--- a/rust/macros/pin_data.rs
+++ b/rust/macros/pin_data.rs
@@ -1,71 +1,19 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT

-use proc_macro::{Punct, Spacing, TokenStream, TokenTree};
+use crate::helpers::{parse_generics, Generics};
+use proc_macro::TokenStream;

 pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStre=
am {
     // This proc-macro only does some pre-parsing and then delegates the a=
ctual parsing to
     // `kernel::__pin_data!`.
-    //
-    // In here we only collect the generics, since parsing them in declara=
tive macros is very
-    // elaborate. We also do not need to analyse their structure, we only =
need to collect them.

-    // `impl_generics`, the declared generics with their bounds.
-    let mut impl_generics =3D vec![];
-    // Only the names of the generics, without any bounds.
-    let mut ty_generics =3D vec![];
-    // Tokens not related to the generics e.g. the `impl` token.
-    let mut rest =3D vec![];
-    // The current level of `<`.
-    let mut nesting =3D 0;
-    let mut toks =3D input.into_iter();
-    // If we are at the beginning of a generic parameter.
-    let mut at_start =3D true;
-    for tt in &mut toks {
-        match tt.clone() {
-            TokenTree::Punct(p) if p.as_char() =3D=3D '<' =3D> {
-                if nesting >=3D 1 {
-                    impl_generics.push(tt);
-                }
-                nesting +=3D 1;
-            }
-            TokenTree::Punct(p) if p.as_char() =3D=3D '>' =3D> {
-                if nesting =3D=3D 0 {
-                    break;
-                } else {
-                    nesting -=3D 1;
-                    if nesting >=3D 1 {
-                        impl_generics.push(tt);
-                    }
-                    if nesting =3D=3D 0 {
-                        break;
-                    }
-                }
-            }
-            tt =3D> {
-                if nesting =3D=3D 1 {
-                    match &tt {
-                        TokenTree::Ident(i) if i.to_string() =3D=3D "const=
" =3D> {}
-                        TokenTree::Ident(_) if at_start =3D> {
-                            ty_generics.push(tt.clone());
-                            ty_generics.push(TokenTree::Punct(Punct::new('=
,', Spacing::Alone)));
-                            at_start =3D false;
-                        }
-                        TokenTree::Punct(p) if p.as_char() =3D=3D ',' =3D>=
 at_start =3D true,
-                        TokenTree::Punct(p) if p.as_char() =3D=3D '\'' && =
at_start =3D> {
-                            ty_generics.push(tt.clone());
-                        }
-                        _ =3D> {}
-                    }
-                }
-                if nesting >=3D 1 {
-                    impl_generics.push(tt);
-                } else if nesting =3D=3D 0 {
-                    rest.push(tt);
-                }
-            }
-        }
-    }
-    rest.extend(toks);
+    let (
+        Generics {
+            impl_generics,
+            ty_generics,
+        },
+        mut rest,
+    ) =3D parse_generics(input);
     // This should be the body of the struct `{...}`.
     let last =3D rest.pop();
     quote!(::kernel::__pin_data! {
--
2.40.0


