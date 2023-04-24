Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCB6EC7B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjDXIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjDXIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:12:05 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A71733
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:11:57 -0700 (PDT)
Date:   Mon, 24 Apr 2023 08:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1682323916; x=1682583116;
        bh=xsbkQLlU/8z2bpso9Wuc5fgrVJCsTlQwnkd8h5OEwvU=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kqFIpKXHsXe4ce/a6ZebDqdoMZtkzYCsVdVV/oVVFk9qV/N8DvQP7fcO6BJDb/5xd
         rE7h4WP7hnTkSOzFte4OMLFvaqIJkaJxiKdG4N5nw4aDMMBB0DrmYGaXFqG1N50UJR
         XnYrRYSG/cdD0YtH/21BZj3Qcou4nRjSWQocJ0NWMCMd4QC+RAKB8dbm+9+Iu9gUdL
         nl4JTBvGUuCys0ordxlD0m/dxla8zNLDMSuQgl8zcE1h9o85Tna0W/I4Tv8wpF8a2t
         lfypQCpWvRd72Bf7pfQVrpoSDlsvYSsbpKY9+HFTlh3j9rEr2W6649rQUxwaJAzlZn
         O8esjaT61K8eQ==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH 3/4] rust: macros: replace Self with the concrete type in #[pin_data]
Message-ID: <20230424081112.99890-3-benno.lossin@proton.me>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
References: <20230424081112.99890-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using `#[pin_data]` on a struct that used `Self` in the field
types, a type error would be emitted when trying to use `pin_init!`.
Since an internal type would be referenced by `Self` instead of the
defined struct.
This patch fixes this issue by replacing all occurrences of `Self` in
the `#[pin_data]` macro with the concrete type circumventing the issue.
Since rust allows type definitions inside of blocks, which are
expressions, the macro also checks for these and emits a compile error
when it finds `trait`, `enum`, `union`, `struct` or `impl`. These
keywords allow creating new `Self` contexts, which conflicts with the
current implementation of replacing every `Self` ident. If these were
allowed, some `Self` idents would be replaced incorrectly.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reported-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/macros/pin_data.rs | 108 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 104 insertions(+), 4 deletions(-)

diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
index c593b05d9e8c..6d58cfda9872 100644
--- a/rust/macros/pin_data.rs
+++ b/rust/macros/pin_data.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT

 use crate::helpers::{parse_generics, Generics};
-use proc_macro::TokenStream;
+use proc_macro::{Group, Punct, Spacing, TokenStream, TokenTree};

 pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStre=
am {
     // This proc-macro only does some pre-parsing and then delegates the a=
ctual parsing to
@@ -12,16 +12,116 @@ pub(crate) fn pin_data(args: TokenStream, input: Token=
Stream) -> TokenStream {
             impl_generics,
             ty_generics,
         },
-        mut rest,
+        rest,
     ) =3D parse_generics(input);
+    // The struct definition might contain the `Self` type. Since `__pin_d=
ata!` will define a new
+    // type with the same generics and bounds, this poses a problem, since=
 `Self` will refer to the
+    // new type as opposed to this struct definition. Therefore we have to=
 replace `Self` with the
+    // concrete name.
+
+    // Errors that occur when replacing `Self` with `struct_name`.
+    let mut errs =3D TokenStream::new();
+    // The name of the struct with ty_generics.
+    let struct_name =3D rest
+        .iter()
+        .skip_while(|tt| !matches!(tt, TokenTree::Ident(i) if i.to_string(=
) =3D=3D "struct"))
+        .nth(1)
+        .and_then(|tt| match tt {
+            TokenTree::Ident(_) =3D> {
+                let tt =3D tt.clone();
+                let mut res =3D vec![tt];
+                if !ty_generics.is_empty() {
+                    // We add this, so it is maximally compatible with e.g=
. `Self::CONST` which
+                    // will be replaced by `StructName::<$generics>::CONST=
`.
+                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Joi=
nt)));
+                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Alo=
ne)));
+                    res.push(TokenTree::Punct(Punct::new('<', Spacing::Alo=
ne)));
+                    res.extend(ty_generics.iter().cloned());
+                    res.push(TokenTree::Punct(Punct::new('>', Spacing::Alo=
ne)));
+                }
+                Some(res)
+            }
+            _ =3D> None,
+        })
+        .unwrap_or_else(|| {
+            // If we did not find the name of the struct then we will use =
`Self` as the replacement
+            // and add a compile error to ensure it does not compile.
+            errs.extend(
+                "::core::compile_error!(\"Could not locate type name.\");"
+                    .parse::<TokenStream>()
+                    .unwrap(),
+            );
+            "Self".parse::<TokenStream>().unwrap().into_iter().collect()
+        });
+    let impl_generics =3D impl_generics
+        .into_iter()
+        .flat_map(|tt| replace_self_and_deny_type_defs(&struct_name, tt, &=
mut errs))
+        .collect::<Vec<_>>();
+    let mut rest =3D rest
+        .into_iter()
+        .flat_map(|tt| {
+            // We ignore top level `struct` tokens, since they would emit =
a compile error.
+            if matches!(&tt, TokenTree::Ident(i) if i.to_string() =3D=3D "=
struct") {
+                vec![tt]
+            } else {
+                replace_self_and_deny_type_defs(&struct_name, tt, &mut err=
s)
+            }
+        })
+        .collect::<Vec<_>>();
     // This should be the body of the struct `{...}`.
     let last =3D rest.pop();
-    quote!(::kernel::__pin_data! {
+    let mut quoted =3D quote!(::kernel::__pin_data! {
         parse_input:
         @args(#args),
         @sig(#(#rest)*),
         @impl_generics(#(#impl_generics)*),
         @ty_generics(#(#ty_generics)*),
         @body(#last),
-    })
+    });
+    quoted.extend(errs);
+    quoted
+}
+
+/// Replaces `Self` with `struct_name` and errors on `enum`, `trait`, `str=
uct` `union` and `impl`
+/// keywords.
+///
+/// The error is appended to `errs` to allow normal parsing to continue.
+fn replace_self_and_deny_type_defs(
+    struct_name: &Vec<TokenTree>,
+    tt: TokenTree,
+    errs: &mut TokenStream,
+) -> Vec<TokenTree> {
+    match tt {
+        TokenTree::Ident(ref i)
+            if i.to_string() =3D=3D "enum"
+                || i.to_string() =3D=3D "trait"
+                || i.to_string() =3D=3D "struct"
+                || i.to_string() =3D=3D "union"
+                || i.to_string() =3D=3D "impl" =3D>
+        {
+            errs.extend(
+                format!(
+                    "::core::compile_error!(\"Cannot use `{i}` inside of s=
truct definition with \
+                        `#[pin_data]`.\");"
+                )
+                .parse::<TokenStream>()
+                .unwrap()
+                .into_iter()
+                .map(|mut tok| {
+                    tok.set_span(tt.span());
+                    tok
+                }),
+            );
+            vec![tt]
+        }
+        TokenTree::Ident(i) if i.to_string() =3D=3D "Self" =3D> struct_nam=
e.clone(),
+        TokenTree::Literal(_) | TokenTree::Punct(_) | TokenTree::Ident(_) =
=3D> vec![tt],
+        TokenTree::Group(g) =3D> vec![TokenTree::Group(Group::new(
+            g.delimiter(),
+            g.stream()
+                .into_iter()
+                .flat_map(|tt| replace_self_and_deny_type_defs(struct_name=
, tt, errs))
+                .collect(),
+        ))],
+    }
 }
--
2.40.0


