Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8E73CA12
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjFXJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjFXJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:25:34 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93271FFD;
        Sat, 24 Jun 2023 02:25:24 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687598722; x=1687857922;
        bh=e1sXKJCCxLmpy0ulsQW4r9ABVvH3CCi6eWCJaK/m/J8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AKUodPJCL5jU2Ry/mdoLY25kCZxnIwD6WpjGc0d7R7r7oYlwoG6Nt92wA7U4IIAfZ
         5pUf2OhLYtWf0YJT+EgsmNvlmhNpoxym4E899jND9VoT8J1D5qoKUjCCC1W47wEs1I
         XmmhfK/A0DNBAIqzOasd6dNwk34hbXF/Peuo+P4PNikryOwoY4zoYvB5044X9VWRVo
         xZYN9E85PbGzC4fdIw+8cnjUgcLDHfEcbiV+QwTpZPUHGsXEAhd0kWCwUP3czUumDn
         UyqoOIRJ4OxpPjUWLN7cv6WLm0IyNf8ODSHFzLviR7rr2PWnijAMw6BzZZhlsxWAzT
         E0oxTs4W/HCmQ==
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
Subject: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
Message-ID: <20230624092330.157338-5-benno.lossin@proton.me>
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

Add the struct update syntax to the init macros, but only for
`..Zeroable::zeroed()`. Adding this at the end of the struct initializer
allows one to omit fields from the initializer, these fields will be
initialized with 0x00 set to every byte. Only types that implement the
`Zeroable` trait can utilize this.

Suggested-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs        |  16 +++++-
 rust/kernel/init/macros.rs | 114 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index ecf6a4bd0ce4..44bc3e77419a 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -508,14 +508,18 @@ macro_rules! stack_try_pin_init {
 /// - Fields that you want to initialize in-place have to use `<-` instead=
 of `:`.
 /// - In front of the initializer you can write `&this in` to have access =
to a [`NonNull<Self>`]
 ///   pointer named `this` inside of the initializer.
+/// - Using struct update syntax one can place `..Zeroable::zeroed()` at t=
he very end of the
+///   struct, this initializes every field with 0 and then runs all initia=
lizers specified in the
+///   body. This can only be done if [`Zeroable`] is implemented for the s=
truct.
 ///
 /// For instance:
 ///
 /// ```rust
 /// # use kernel::pin_init;
-/// # use macros::pin_data;
+/// # use macros::{pin_data, Zeroable};
 /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
 /// #[pin_data]
+/// #[derive(Zeroable)]
 /// struct Buf {
 ///     // `ptr` points into `buf`.
 ///     ptr: *mut u8,
@@ -528,6 +532,10 @@ macro_rules! stack_try_pin_init {
 ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
 ///     pin: PhantomPinned,
 /// });
+/// pin_init!(Buf {
+///     buf: [1; 64],
+///     ..Zeroable::zeroed(),
+/// });
 /// ```
 ///
 /// [`try_pin_init!`]: kernel::try_pin_init
@@ -547,6 +555,7 @@ macro_rules! pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
@@ -603,6 +612,7 @@ macro_rules! try_pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -616,6 +626,7 @@ macro_rules! try_pin_init {
             @data(PinData, use_data),
             @has_data(HasPinData, __pin_data),
             @construct_closure(pin_init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
@@ -650,6 +661,7 @@ macro_rules! init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     }
 }
@@ -700,6 +712,7 @@ macro_rules! try_init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
@@ -713,6 +726,7 @@ macro_rules! try_init {
             @data(InitData, /*no use_data*/),
             @has_data(HasInitData, __init_data),
             @construct_closure(init_from_closure),
+            @munch_fields($($fields)*),
         )
     };
 }
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 1e0c4aca055a..5dcb2e513f26 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -989,6 +989,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
 ///
 /// This macro has multiple internal call configurations, these are always=
 the very first ident:
 /// - nothing: this is the base case and called by the `{try_}{pin_}init!`=
 macros.
+/// - `with_update_parsed`: when the `..Zeroable::zeroed()` syntax has bee=
n handled.
 /// - `init_slot`: recursively creates the code that initializes all field=
s in `slot`.
 /// - `make_initializer`: recursively create the struct initializer that g=
uarantees that every
 ///   field has been initialized exactly once.
@@ -1007,6 +1008,82 @@ macro_rules! __init_internal {
         @has_data($has_data:ident, $get_data:ident),
         // `pin_init_from_closure` or `init_from_closure`.
         @construct_closure($construct_closure:ident),
+        @munch_fields(),
+    ) =3D> {
+        $crate::__init_internal!(with_update_parsed:
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @zeroed(), // nothing means default behavior.
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @munch_fields(..Zeroable::zeroed()),
+    ) =3D> {
+        $crate::__init_internal!(with_update_parsed:
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @zeroed(()), // `()` means zero all fields not mentioned.
+        )
+    };
+    (
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @munch_fields($ignore:tt $($rest:tt)*),
+    ) =3D> {
+        $crate::__init_internal!(
+            @this($($this)?),
+            @typ($t $(::<$($generics),*>)? ),
+            @fields($($fields)*),
+            @error($err),
+            @data($data, $($use_data)?),
+            @has_data($has_data, $get_data),
+            @construct_closure($construct_closure),
+            @munch_fields($($rest)*),
+        )
+    };
+    (with_update_parsed:
+        @this($($this:ident)?),
+        @typ($t:ident $(::<$($generics:ty),*>)?),
+        @fields($($fields:tt)*),
+        @error($err:ty),
+        // Either `PinData` or `InitData`, `$use_data` should only be pres=
ent in the `PinData`
+        // case.
+        @data($data:ident, $($use_data:ident)?),
+        // `HasPinData` or `HasInitData`.
+        @has_data($has_data:ident, $get_data:ident),
+        // `pin_init_from_closure` or `init_from_closure`.
+        @construct_closure($construct_closure:ident),
+        @zeroed($($init_zeroed:expr)?),
     ) =3D> {{
         // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
         // type and shadow it later when we insert the arbitrary user code=
. That way there will be
@@ -1024,6 +1101,17 @@ macro_rules! __init_internal {
                 {
                     // Shadow the structure so it cannot be used to return=
 early.
                     struct __InitOk;
+                    // If `$init_zeroed` is present we should zero the slo=
t now and not emit an
+                    // error when fields are missing (since they will be z=
eroed). We also have to
+                    // check that the type actually implements `Zeroable`.
+                    $(
+                        fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
+                        // Ensure that the struct is indeed `Zeroable`.
+                        is_zeroable(slot);
+                        // SAFETY:  The type implements `Zeroable` by the =
check above.
+                        unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
+                        $init_zeroed // this will be `()` if set.
+                    )?
                     // Create the `this` so it can be referenced by the us=
er inside of the
                     // expressions creating the individual fields.
                     $(let $this =3D unsafe { ::core::ptr::NonNull::new_unc=
hecked(slot) };)?
@@ -1064,7 +1152,7 @@ macro_rules! __init_internal {
         @data($data:ident),
         @slot($slot:ident),
         @guards($($guards:ident,)*),
-        @munch_fields($(,)?),
+        @munch_fields($(..Zeroable::zeroed())? $(,)?),
     ) =3D> {
         // Endpoint of munching, no fields are left. If execution reaches =
this point, all fields
         // have been initialized. Therefore we can now dismiss the guards =
by forgetting them.
@@ -1157,6 +1245,30 @@ macro_rules! __init_internal {
             @munch_fields($($rest)*),
         );
     };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:ident),
+        @munch_fields(..Zeroable::zeroed() $(,)?),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        // Endpoint, nothing more to munch, create the initializer. Since =
the users specified
+        // `..Zeroable::zeroed()`, the slot will already have been zeroed =
and all field that have
+        // not been overwritten are thus zero and initialized. We still ch=
eck that all fields are
+        // actually accessible by using the struct update syntax ourselves=
.
+        // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
+        // get the correct type inference here:
+        unsafe {
+            let mut zeroed =3D ::core::mem::zeroed();
+            // We have to use type inference her to make zeroed have the c=
orrect type. This does
+            // not get executed, so it has no effect.
+            ::core::ptr::write($slot, zeroed);
+            zeroed =3D ::core::mem::zeroed();
+            ::core::ptr::write($slot, $t {
+                $($acc)*
+                ..zeroed
+            });
+        }
+    };
     (make_initializer:
         @slot($slot:ident),
         @type_name($t:ident),
--
2.41.0


