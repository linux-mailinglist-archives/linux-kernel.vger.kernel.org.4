Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191F673CA11
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFXJZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjFXJZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:25:30 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79312128
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 02:25:23 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:25:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687598721; x=1687857921;
        bh=F442EJD8L22HB05UPRQHv+35aOiE4fN5MpCVafEtbng=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RZe4r4hGwC3X2Yf8meMtLPnpHuNbbt3hvvQm5OhFulqj51Wfeh9O2oJymyLFULk3U
         0zzW9fXpxc5suiaGFJv2NhGQEqWE5FybAA5U47qT6r46PPw465AADoJE/fQitdHMzS
         T4XA7V/Va3kcasO3EnMB/N6iiC6llValzVIO+HPOrE4irfHExbaV5RE9JmJ8wi9r7x
         9Zr2iQZ4Wns1P+JV44Pc3upL/Z7Z2TrFKiORmrB8sDfgLaixFynMw/c/fGpG3dzC+9
         /pTPm10InbpJYHhyZ62yHXRYl92iHZgIl63yH+E2LwToIfkaWyTt95DsuSVMKOm1xs
         OxF863zALlKCg==
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
Subject: [PATCH 3/7] rust: init: make guards in the init macros hygienic
Message-ID: <20230624092330.157338-3-benno.lossin@proton.me>
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

Use hygienic identifiers for the guards instead of the field names. This
makes the init macros feel more like normal struct initializers, since
assigning identifiers with the name of a field does not create
conflicts.
Also change the internals of the guards, no need to make the `forget`
function `unsafe`, since users cannot access the guards anyways. Now the
guards are carried directly on the stack and have no extra `Cell<bool>`
field that marks if they have been forgotten or not, instead they are
just forgotten via `mem::forget`.

Suggested-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs            |  1 -
 rust/kernel/init/__internal.rs | 25 +++------------
 rust/kernel/init/macros.rs     | 56 ++++++++++++----------------------
 3 files changed, 23 insertions(+), 59 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index d9a91950cba2..ecf6a4bd0ce4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -206,7 +206,6 @@
 use alloc::boxed::Box;
 use core::{
     alloc::AllocError,
-    cell::Cell,
     convert::Infallible,
     marker::PhantomData,
     mem::MaybeUninit,
diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.r=
s
index 44751fb62b51..7abd1fb65e41 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -174,7 +174,6 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit=
<T, E>) -> Result<Pin<&mu
 /// Can be forgotten to prevent the drop.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
-    do_drop: Cell<bool>,
 }

 impl<T: ?Sized> DropGuard<T> {
@@ -190,32 +189,16 @@ impl<T: ?Sized> DropGuard<T> {
     /// - will not be dropped by any other means.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
-        Self {
-            ptr,
-            do_drop: Cell::new(true),
-        }
-    }
-
-    /// Prevents this guard from dropping the supplied pointer.
-    ///
-    /// # Safety
-    ///
-    /// This function is unsafe in order to prevent safe code from forgett=
ing this guard. It should
-    /// only be called by the macros in this module.
-    #[inline]
-    pub unsafe fn forget(&self) {
-        self.do_drop.set(false);
+        Self { ptr }
     }
 }

 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        if self.do_drop.get() {
-            // SAFETY: A `DropGuard` can only be constructed using the uns=
afe `new` function
-            // ensuring that this operation is safe.
-            unsafe { ptr::drop_in_place(self.ptr) }
-        }
+        // SAFETY: A `DropGuard` can only be constructed using the unsafe =
`new` function
+        // ensuring that this operation is safe.
+        unsafe { ptr::drop_in_place(self.ptr) }
     }
 }

diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index e8165ff53a94..df4281743175 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -992,7 +992,6 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
 /// - `init_slot`: recursively creates the code that initializes all field=
s in `slot`.
 /// - `make_initializer`: recursively create the struct initializer that g=
uarantees that every
 ///   field has been initialized exactly once.
-/// - `forget_guards`: recursively forget the drop guards for every field.
 #[doc(hidden)]
 #[macro_export]
 macro_rules! __init_internal {
@@ -1032,6 +1031,7 @@ macro_rules! __init_internal {
                     $crate::__init_internal!(init_slot($($use_data)?):
                         @data(data),
                         @slot(slot),
+                        @guards(),
                         @munch_fields($($fields)*,),
                     );
                     // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
@@ -1046,10 +1046,6 @@ macro_rules! __init_internal {
                             @acc(),
                         );
                     }
-                    // Forget all guards, since initialization was a succe=
ss.
-                    $crate::__init_internal!(forget_guards:
-                        @munch_fields($($fields)*,),
-                    );
                 }
                 Ok(__InitOk)
             }
@@ -1063,13 +1059,17 @@ macro_rules! __init_internal {
     (init_slot($($use_data:ident)?):
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         @munch_fields($(,)?),
     ) =3D> {
-        // Endpoint of munching, no fields are left.
+        // Endpoint of munching, no fields are left. If execution reaches =
this point, all fields
+        // have been initialized. Therefore we can now dismiss the guards =
by forgetting them.
+        $(::core::mem::forget($guards);)*
     };
     (init_slot($use_data:ident): // use_data is present, so we use the `da=
ta` to init fields.
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
@@ -1080,24 +1080,26 @@ macro_rules! __init_internal {
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or =
`PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
$field)? };
-        // Create the drop guard.
+        // Create the drop guard:
         //
-        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         //
         // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
+        let guard =3D unsafe {
             $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
         };

         $crate::__init_internal!(init_slot($use_data):
             @data($data),
             @slot($slot),
+            @guards(guard, $($guards,)*),
             @munch_fields($($rest)*),
         );
     };
     (init_slot(): // no use_data, so we use `Init::__init` directly.
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // In-place initialization syntax.
         @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
     ) =3D> {
@@ -1107,24 +1109,26 @@ macro_rules! __init_internal {
         // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_m=
ut!((*$slot).$field))? };
-        // Create the drop guard.
+        // Create the drop guard:
         //
-        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         //
         // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
+        let guard =3D unsafe {
             $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
         };

         $crate::__init_internal!(init_slot():
             @data($data),
             @slot($slot),
+            @guards(guard, $($guards,)*),
             @munch_fields($($rest)*),
         );
     };
     (init_slot($($use_data:ident)?):
         @data($data:ident),
         @slot($slot:ident),
+        @guards($($guards:ident,)*),
         // Init by-value.
         @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
     ) =3D> {
@@ -1135,16 +1139,17 @@ macro_rules! __init_internal {
         unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
         // Create the drop guard:
         //
-        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
+        // We rely on macro hygiene to make it impossible for users to acc=
ess this local variable.
         //
         // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
+        let guard =3D unsafe {
             $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
         };

         $crate::__init_internal!(init_slot($($use_data)?):
             @data($data),
             @slot($slot),
+            @guards(guard, $($guards,)*),
             @munch_fields($($rest)*),
         );
     };
@@ -1189,29 +1194,6 @@ macro_rules! __init_internal {
             @acc($($acc)* $field: ::core::panic!(),),
         );
     };
-    (forget_guards:
-        @munch_fields($(,)?),
-    ) =3D> {
-        // Munching finished.
-    };
-    (forget_guards:
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::__init_internal!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
-    (forget_guards:
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::__init_internal!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
 }

 #[doc(hidden)]
--
2.41.0


