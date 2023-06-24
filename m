Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E373CA16
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFXJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjFXJ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:26:18 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07939211E;
        Sat, 24 Jun 2023 02:25:47 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:25:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687598744; x=1687857944;
        bh=4u3eXFuoov+G4R/MtGOXrWncucnn87dIfxR6A2h1gls=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cKuF3PVseiBIPHVbekskRtA5tfj9oT8WATPSFesjshLVN3uHAqe8yeQWu5+REZVbq
         2VmxbaYsYxdSXMnT1divFecszBbKOM8cL7STDOfT6J6xrZEu4rmlnNqRRx9sayKMdM
         GaK1SWGq8KHyufHHrVisp9NsfQmBouc3Svanwd7pfCeGNgmcVrRHBP3uS5bBP7R/US
         WX3JK9BY910N5z290B1ItfCwfmlFA1Eud+tCvOJdsiRucDSado5DQNXJ0DK4qXBeTt
         t7wv0M5Bt8ofR77pwJpLAUPNVJyxSNtze6fWfSixZLKWRemVfXKDRKifHWQYBwAzDR
         EHkoN7Sry55tg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: [PATCH 7/7] rust: init: add support for arbitrary paths in init macros
Message-ID: <20230624092330.157338-7-benno.lossin@proton.me>
In-Reply-To: <20230624092330.157338-1-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously only `ident` and generic types were supported in the
`{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
so for example `Foo::Bar` but also very complex paths such as
`<Foo as Baz>::Bar::<0, i32>`.

Internally this is accomplished by using `path` fragments. Due to some
peculiar declarative macro limitations, we have to "forget" certain
additional parsing information in the token trees. This is achieved by
the new `retokenize` proc macro. It does not modify the input, but just
strips this information. For example, if a declarative macro takes
`$t:path` as its input, it cannot sensibly propagate this to a macro that
takes `$($p:tt)*` as its input, since the `$t` token will only be
considered one `tt` token for the second macro. If we first pipe the
tokens through `retokenize`, then it parses as expected.

Suggested-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init/__internal.rs |  2 ++
 rust/kernel/init/macros.rs     | 42 +++++++++++++++++++---------------
 rust/macros/lib.rs             | 17 +++++++++++++-
 3 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 7abd1fb65e41..e36a706a4a1b 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -9,6 +9,8 @@

 use super::*;

+pub use ::macros::retokenize;
+
 /// See the [nomicon] for what subtyping is. See also [this table].
 ///
 /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 5dcb2e513f26..6a82be675808 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -998,7 +998,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
 macro_rules! __init_internal {
     (
         @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @typ($t:path),
         @fields($($fields:tt)*),
         @error($err:ty),
         // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
@@ -1012,7 +1012,7 @@ macro_rules! __init_internal {
     ) =3D> {
         $crate::__init_internal!(with_update_parsed:
             @this($($this)?),
-            @typ($t $(::<$($generics),*>)? ),
+            @typ($t),
             @fields($($fields)*),
             @error($err),
             @data($data, $($use_data)?),
@@ -1023,7 +1023,7 @@ macro_rules! __init_internal {
     };
     (
         @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @typ($t:path),
         @fields($($fields:tt)*),
         @error($err:ty),
         // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
@@ -1037,7 +1037,7 @@ macro_rules! __init_internal {
     ) =3D> {
         $crate::__init_internal!(with_update_parsed:
             @this($($this)?),
-            @typ($t $(::<$($generics),*>)? ),
+            @typ($t),
             @fields($($fields)*),
             @error($err),
             @data($data, $($use_data)?),
@@ -1048,7 +1048,7 @@ macro_rules! __init_internal {
     };
     (
         @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @typ($t:path),
         @fields($($fields:tt)*),
         @error($err:ty),
         // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
@@ -1062,7 +1062,7 @@ macro_rules! __init_internal {
     ) =3D> {
         $crate::__init_internal!(
             @this($($this)?),
-            @typ($t $(::<$($generics),*>)? ),
+            @typ($t),
             @fields($($fields)*),
             @error($err),
             @data($data, $($use_data)?),
@@ -1073,7 +1073,7 @@ macro_rules! __init_internal {
     };
     (with_update_parsed:
         @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @typ($t:path),
         @fields($($fields:tt)*),
         @error($err:ty),
         // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
@@ -1092,7 +1092,7 @@ macro_rules! __init_internal {
         // Get the data about fields from the supplied type.
         let data =3D unsafe {
             use $crate::init::__internal::$has_data;
-            $t$(::<$($generics),*>)?::$get_data()
+            $crate::init::__internal::retokenize!($t::$get_data())
         };
         // Ensure that `data` really is of type `$data` and help with type=
 inference:
         let init =3D $crate::init::__internal::$data::make_closure::<_, __=
InitOk, $err>(
@@ -1247,7 +1247,7 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
     };
     (make_initializer:
         @slot($slot:ident),
-        @type_name($t:ident),
+        @type_name($t:path),
         @munch_fields(..Zeroable::zeroed() $(,)?),
         @acc($($acc:tt)*),
     ) =3D> {
@@ -1263,15 +1263,17 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
             // not get executed, so it has no effect.
             ::core::ptr::write($slot, zeroed);
             zeroed =3D ::core::mem::zeroed();
-            ::core::ptr::write($slot, $t {
-                $($acc)*
-                ..zeroed
-            });
+            $crate::init::__internal::retokenize!(
+                ::core::ptr::write($slot, $t {
+                    $($acc)*
+                    ..zeroed
+                });
+            );
         }
     };
     (make_initializer:
         @slot($slot:ident),
-        @type_name($t:ident),
+        @type_name($t:path),
         @munch_fields($(,)?),
         @acc($($acc:tt)*),
     ) =3D> {
@@ -1279,14 +1281,16 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
         // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
         // get the correct type inference here:
         unsafe {
-            ::core::ptr::write($slot, $t {
-                $($acc)*
-            });
+            $crate::init::__internal::retokenize!(
+                ::core::ptr::write($slot, $t {
+                    $($acc)*
+                });
+            );
         }
     };
     (make_initializer:
         @slot($slot:ident),
-        @type_name($t:ident),
+        @type_name($t:path),
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
         @acc($($acc:tt)*),
     ) =3D> {
@@ -1299,7 +1303,7 @@ fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
     };
     (make_initializer:
         @slot($slot:ident),
-        @type_name($t:ident),
+        @type_name($t:path),
         @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
         @acc($($acc:tt)*),
     ) =3D> {
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index 9f056a5c780a..d329ab622fd4 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -12,7 +12,7 @@
 mod vtable;
 mod zeroable;

-use proc_macro::TokenStream;
+use proc_macro::{Group, TokenStream, TokenTree};

 /// Declares a kernel module.
 ///
@@ -266,3 +266,18 @@ pub fn pinned_drop(args: TokenStream, input: TokenStre=
am) -> TokenStream {
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input)
 }
+
+/// Does not modify the given TokenStream, but removes any declarative mac=
ro information.
+#[proc_macro]
+pub fn retokenize(input: TokenStream) -> TokenStream {
+    fn id(tt: TokenTree) -> TokenTree {
+        match tt {
+            TokenTree::Group(g) =3D> TokenTree::Group(Group::new(
+                g.delimiter(),
+                g.stream().into_iter().map(id).collect(),
+            )),
+            x =3D> x,
+        }
+    }
+    input.into_iter().map(id).collect()
+}
--
2.41.0


