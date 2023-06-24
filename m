Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECF73CA0F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 11:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjFXJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjFXJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 05:25:12 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F42010FD;
        Sat, 24 Jun 2023 02:25:06 -0700 (PDT)
Date:   Sat, 24 Jun 2023 09:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687598703; x=1687857903;
        bh=59XOq8B2rCdfLJSTN1omKI9iBhysqGeBftTNdO85xB4=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=dNkEWve8JU2Qz+j2G+Y3ujxGakQQHYRMlAmL07B3+9Ypdj7x0eg4YQm6bjH5oVL64
         OpPrBE3Fjs6S3x/Zbp7OKy263ur9y9HVxeXs2eykwqpz2PNNcL2d4gLwFlol7/7UQE
         t5MpCQL5UB3BzLaVyRkb+AnZlnhpY1Q7Fyluibt/XBDsEY+ZwyXZOIyhMc1SBl0F8D
         SZYvoM8C5zDZSxZIyH112lSkGg8KurcGtC1fUz9UygG2HUSm5V//HBTuK97e4DZqU/
         /a+Es9cPOy7aD/Kw0AhbjYpvXvt9g1jTBNxJ2iCyIsJ3TpOB18UHoIIH0jxzEaTDGa
         egBjOrk6IZebQ==
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
        patches@lists.linux.dev
Subject: [PATCH 1/7] rust: init: consolidate init macros
Message-ID: <20230624092330.157338-1-benno.lossin@proton.me>
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

Merges the implementations of `try_init!` and `try_pin_init!`. These two
macros are very similar, but use different traits. The new macro
`__init_internal!` that is now the implementation for both takes these
traits as parameters.

This change does not affect any users, as no public API has been
changed, but it should simplify maintaining the init macros.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/init.rs        | 388 +++----------------------------------
 rust/kernel/init/macros.rs | 237 +++++++++++++++++++++-
 2 files changed, 259 insertions(+), 366 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index b4332a4ec1f4..d9a91950cba2 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -540,11 +540,14 @@ macro_rules! pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_pin_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)?),
             @fields($($fields)*),
             @error(::core::convert::Infallible),
+            @data(PinData, use_data),
+            @has_data(HasPinData, __pin_data),
+            @construct_closure(pin_init_from_closure),
         )
     };
 }
@@ -593,205 +596,29 @@ macro_rules! try_pin_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_pin_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)? ),
             @fields($($fields)*),
             @error($crate::error::Error),
+            @data(PinData, use_data),
+            @has_data(HasPinData, __pin_data),
+            @construct_closure(pin_init_from_closure),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
-        $crate::try_pin_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)? ),
             @fields($($fields)*),
             @error($err),
+            @data(PinData, use_data),
+            @has_data(HasPinData, __pin_data),
+            @construct_closure(pin_init_from_closure),
         )
     };
-    (
-        @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
-        @fields($($fields:tt)*),
-        @error($err:ty),
-    ) =3D> {{
-        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
-        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
-        // no possibility of returning without `unsafe`.
-        struct __InitOk;
-        // Get the pin data from the supplied type.
-        let data =3D unsafe {
-            use $crate::init::__internal::HasPinData;
-            $t$(::<$($generics),*>)?::__pin_data()
-        };
-        // Ensure that `data` really is of type `PinData` and help with ty=
pe inference:
-        let init =3D $crate::init::__internal::PinData::make_closure::<_, =
__InitOk, $err>(
-            data,
-            move |slot| {
-                {
-                    // Shadow the structure so it cannot be used to return=
 early.
-                    struct __InitOk;
-                    // Create the `this` so it can be referenced by the us=
er inside of the
-                    // expressions creating the individual fields.
-                    $(let $this =3D unsafe { ::core::ptr::NonNull::new_unc=
hecked(slot) };)?
-                    // Initialize every field.
-                    $crate::try_pin_init!(init_slot:
-                        @data(data),
-                        @slot(slot),
-                        @munch_fields($($fields)*,),
-                    );
-                    // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
-                    // once, this struct initializer will still be type-ch=
ecked and complain with a
-                    // very natural error message if a field is forgotten/=
mentioned more than once.
-                    #[allow(unreachable_code, clippy::diverging_sub_expres=
sion)]
-                    if false {
-                        $crate::try_pin_init!(make_initializer:
-                            @slot(slot),
-                            @type_name($t),
-                            @munch_fields($($fields)*,),
-                            @acc(),
-                        );
-                    }
-                    // Forget all guards, since initialization was a succe=
ss.
-                    $crate::try_pin_init!(forget_guards:
-                        @munch_fields($($fields)*,),
-                    );
-                }
-                Ok(__InitOk)
-            }
-        );
-        let init =3D move |slot| -> ::core::result::Result<(), $err> {
-            init(slot).map(|__InitOk| ())
-        };
-        let init =3D unsafe { $crate::init::pin_init_from_closure::<_, $er=
r>(init) };
-        init
-    }};
-    (init_slot:
-        @data($data:ident),
-        @slot($slot:ident),
-        @munch_fields($(,)?),
-    ) =3D> {
-        // Endpoint of munching, no fields are left.
-    };
-    (init_slot:
-        @data($data:ident),
-        @slot($slot:ident),
-        // In-place initialization syntax.
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-    ) =3D> {
-        let $field =3D $val;
-        // Call the initializer.
-        //
-        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
-        // return when an error/panic occurs.
-        // We also use the `data` to require the correct trait (`Init` or =
`PinInit`) for `$field`.
-        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
$field)? };
-        // Create the drop guard.
-        //
-        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
-        //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
-
-        $crate::try_pin_init!(init_slot:
-            @data($data),
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
-    };
-    (init_slot:
-        @data($data:ident),
-        @slot($slot:ident),
-        // Direct value init, this is safe for every field.
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        $(let $field =3D $val;)?
-        // Initialize the field.
-        //
-        // SAFETY: The memory at `slot` is uninitialized.
-        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
-        // Create the drop guard:
-        //
-        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
-        //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
-
-        $crate::try_pin_init!(init_slot:
-            @data($data),
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields($(,)?),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        // Endpoint, nothing more to munch, create the initializer.
-        // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
-        // get the correct type inference here:
-        unsafe {
-            ::core::ptr::write($slot, $t {
-                $($acc)*
-            });
-        }
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        $crate::try_pin_init!(make_initializer:
-            @slot($slot),
-            @type_name($t),
-            @munch_fields($($rest)*),
-            @acc($($acc)* $field: ::core::panic!(),),
-        );
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        $crate::try_pin_init!(make_initializer:
-            @slot($slot),
-            @type_name($t),
-            @munch_fields($($rest)*),
-            @acc($($acc)* $field: ::core::panic!(),),
-        );
-    };
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
-        $crate::try_pin_init!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
-    (forget_guards:
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::try_pin_init!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
 }

 /// Construct an in-place initializer for `struct`s.
@@ -816,11 +643,14 @@ macro_rules! init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)?),
             @fields($($fields)*),
             @error(::core::convert::Infallible),
+            @data(InitData, /*no use_data*/),
+            @has_data(HasInitData, __init_data),
+            @construct_closure(init_from_closure),
         )
     }
 }
@@ -863,199 +693,29 @@ macro_rules! try_init {
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }) =3D> {
-        $crate::try_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)?),
             @fields($($fields)*),
             @error($crate::error::Error),
+            @data(InitData, /*no use_data*/),
+            @has_data(HasInitData, __init_data),
+            @construct_closure(init_from_closure),
         )
     };
     ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
         $($fields:tt)*
     }? $err:ty) =3D> {
-        $crate::try_init!(
+        $crate::__init_internal!(
             @this($($this)?),
             @typ($t $(::<$($generics),*>)?),
             @fields($($fields)*),
             @error($err),
+            @data(InitData, /*no use_data*/),
+            @has_data(HasInitData, __init_data),
+            @construct_closure(init_from_closure),
         )
     };
-    (
-        @this($($this:ident)?),
-        @typ($t:ident $(::<$($generics:ty),*>)?),
-        @fields($($fields:tt)*),
-        @error($err:ty),
-    ) =3D> {{
-        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
-        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
-        // no possibility of returning without `unsafe`.
-        struct __InitOk;
-        // Get the init data from the supplied type.
-        let data =3D unsafe {
-            use $crate::init::__internal::HasInitData;
-            $t$(::<$($generics),*>)?::__init_data()
-        };
-        // Ensure that `data` really is of type `InitData` and help with t=
ype inference:
-        let init =3D $crate::init::__internal::InitData::make_closure::<_,=
 __InitOk, $err>(
-            data,
-            move |slot| {
-                {
-                    // Shadow the structure so it cannot be used to return=
 early.
-                    struct __InitOk;
-                    // Create the `this` so it can be referenced by the us=
er inside of the
-                    // expressions creating the individual fields.
-                    $(let $this =3D unsafe { ::core::ptr::NonNull::new_unc=
hecked(slot) };)?
-                    // Initialize every field.
-                    $crate::try_init!(init_slot:
-                        @slot(slot),
-                        @munch_fields($($fields)*,),
-                    );
-                    // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
-                    // once, this struct initializer will still be type-ch=
ecked and complain with a
-                    // very natural error message if a field is forgotten/=
mentioned more than once.
-                    #[allow(unreachable_code, clippy::diverging_sub_expres=
sion)]
-                    if false {
-                        $crate::try_init!(make_initializer:
-                            @slot(slot),
-                            @type_name($t),
-                            @munch_fields($($fields)*,),
-                            @acc(),
-                        );
-                    }
-                    // Forget all guards, since initialization was a succe=
ss.
-                    $crate::try_init!(forget_guards:
-                        @munch_fields($($fields)*,),
-                    );
-                }
-                Ok(__InitOk)
-            }
-        );
-        let init =3D move |slot| -> ::core::result::Result<(), $err> {
-            init(slot).map(|__InitOk| ())
-        };
-        let init =3D unsafe { $crate::init::init_from_closure::<_, $err>(i=
nit) };
-        init
-    }};
-    (init_slot:
-        @slot($slot:ident),
-        @munch_fields( $(,)?),
-    ) =3D> {
-        // Endpoint of munching, no fields are left.
-    };
-    (init_slot:
-        @slot($slot:ident),
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-    ) =3D> {
-        let $field =3D $val;
-        // Call the initializer.
-        //
-        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
-        // return when an error/panic occurs.
-        unsafe {
-            $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((=
*$slot).$field))?;
-        }
-        // Create the drop guard.
-        //
-        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
-        //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
-
-        $crate::try_init!(init_slot:
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
-    };
-    (init_slot:
-        @slot($slot:ident),
-        // Direct value init.
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        $(let $field =3D $val;)?
-        // Call the initializer.
-        //
-        // SAFETY: The memory at `slot` is uninitialized.
-        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
-        // Create the drop guard.
-        //
-        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
-        //
-        // SAFETY: We forget the guard later when initialization has succe=
eded.
-        let $field =3D &unsafe {
-            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
-        };
-
-        $crate::try_init!(init_slot:
-            @slot($slot),
-            @munch_fields($($rest)*),
-        );
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields( $(,)?),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        // Endpoint, nothing more to munch, create the initializer.
-        // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
-        // get the correct type inference here:
-        unsafe {
-            ::core::ptr::write($slot, $t {
-                $($acc)*
-            });
-        }
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        $crate::try_init!(make_initializer:
-            @slot($slot),
-            @type_name($t),
-            @munch_fields($($rest)*),
-            @acc($($acc)*$field: ::core::panic!(),),
-        );
-    };
-    (make_initializer:
-        @slot($slot:ident),
-        @type_name($t:ident),
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-        @acc($($acc:tt)*),
-    ) =3D> {
-        $crate::try_init!(make_initializer:
-            @slot($slot),
-            @type_name($t),
-            @munch_fields($($rest)*),
-            @acc($($acc)*$field: ::core::panic!(),),
-        );
-    };
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
-        $crate::try_init!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
-    (forget_guards:
-        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
-    ) =3D> {
-        unsafe { $crate::init::__internal::DropGuard::forget($field) };
-
-        $crate::try_init!(forget_guards:
-            @munch_fields($($rest)*),
-        );
-    };
 }

 /// A pin-initializer for the type `T`.
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 00aa4e956c0a..fbaebd34f218 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT

 //! This module provides the macros that actually implement the proc-macro=
s `pin_data` and
-//! `pinned_drop`.
+//! `pinned_drop`. It also contains `__init_internal` the implementation o=
f the `{try_}{pin_}init!`
+//! macros.
 //!
 //! These macros should never be called directly, since they expect their =
input to be
-//! in a certain format which is internal. Use the proc-macros instead.
+//! in a certain format which is internal. If used incorrectly, these macr=
os can lead to UB even in
+//! safe code! Use the public facing macros instead.
 //!
 //! This architecture has been chosen because the kernel does not yet have=
 access to `syn` which
 //! would make matters a lot easier for implementing these as proc-macros.
@@ -980,3 +982,234 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
         }
     };
 }
+
+/// The internal init macro. Do not call manually!
+///
+/// This is called by the `{try_}{pin_}init!` macros with various inputs.
+///
+/// This macro has multiple internal call configurations, these are always=
 the very first ident:
+/// - nothing: this is the base case and called by the `{try_}{pin_}init!`=
 macros.
+/// - `init_slot`: recursively creates the code that initializes all field=
s in `slot`.
+/// - `make_initializer`: recursively create the struct initializer that g=
uarantees that every
+///   field has been initialized exactly once.
+/// - `forget_guards`: recursively forget the drop guards for every field.
+#[doc(hidden)]
+#[macro_export]
+macro_rules! __init_internal {
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
+    ) =3D> {{
+        // We do not want to allow arbitrary returns, so we declare this t=
ype as the `Ok` return
+        // type and shadow it later when we insert the arbitrary user code=
. That way there will be
+        // no possibility of returning without `unsafe`.
+        struct __InitOk;
+        // Get the data about fields from the supplied type.
+        let data =3D unsafe {
+            use $crate::init::__internal::$has_data;
+            $t$(::<$($generics),*>)?::$get_data()
+        };
+        // Ensure that `data` really is of type `$data` and help with type=
 inference:
+        let init =3D $crate::init::__internal::$data::make_closure::<_, __=
InitOk, $err>(
+            data,
+            move |slot| {
+                {
+                    // Shadow the structure so it cannot be used to return=
 early.
+                    struct __InitOk;
+                    // Create the `this` so it can be referenced by the us=
er inside of the
+                    // expressions creating the individual fields.
+                    $(let $this =3D unsafe { ::core::ptr::NonNull::new_unc=
hecked(slot) };)?
+                    // Initialize every field.
+                    $crate::__init_internal!(init_slot($($use_data)?):
+                        @data(data),
+                        @slot(slot),
+                        @munch_fields($($fields)*,),
+                    );
+                    // We use unreachable code to ensure that all fields h=
ave been mentioned exactly
+                    // once, this struct initializer will still be type-ch=
ecked and complain with a
+                    // very natural error message if a field is forgotten/=
mentioned more than once.
+                    #[allow(unreachable_code, clippy::diverging_sub_expres=
sion)]
+                    if false {
+                        $crate::__init_internal!(make_initializer:
+                            @slot(slot),
+                            @type_name($t),
+                            @munch_fields($($fields)*,),
+                            @acc(),
+                        );
+                    }
+                    // Forget all guards, since initialization was a succe=
ss.
+                    $crate::__init_internal!(forget_guards:
+                        @munch_fields($($fields)*,),
+                    );
+                }
+                Ok(__InitOk)
+            }
+        );
+        let init =3D move |slot| -> ::core::result::Result<(), $err> {
+            init(slot).map(|__InitOk| ())
+        };
+        let init =3D unsafe { $crate::init::$construct_closure::<_, $err>(=
init) };
+        init
+    }};
+    (init_slot($($use_data:ident)?):
+        @data($data:ident),
+        @slot($slot:ident),
+        @munch_fields($(,)?),
+    ) =3D> {
+        // Endpoint of munching, no fields are left.
+    };
+    (init_slot($use_data:ident): // use_data is present, so we use the `da=
ta` to init fields.
+        @data($data:ident),
+        @slot($slot:ident),
+        // In-place initialization syntax.
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        let $field =3D $val;
+        // Call the initializer.
+        //
+        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
+        // return when an error/panic occurs.
+        // We also use the `data` to require the correct trait (`Init` or =
`PinInit`) for `$field`.
+        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), =
$field)? };
+        // Create the drop guard.
+        //
+        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
+        };
+
+        $crate::__init_internal!(init_slot($use_data):
+            @data($data),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (init_slot(): // no use_data, so we use `Init::__init` directly.
+        @data($data:ident),
+        @slot($slot:ident),
+        // In-place initialization syntax.
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        let $field =3D $val;
+        // Call the initializer.
+        //
+        // SAFETY: `slot` is valid, because we are inside of an initialize=
r closure, we
+        // return when an error/panic occurs.
+        unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of_m=
ut!((*$slot).$field))? };
+        // Create the drop guard.
+        //
+        // We only give access to `&DropGuard`, so it cannot be forgotten =
via safe code.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
+        };
+
+        $crate::__init_internal!(init_slot():
+            @data($data),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (init_slot($($use_data:ident)?):
+        @data($data:ident),
+        @slot($slot:ident),
+        // Init by-value.
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        $(let $field =3D $val;)?
+        // Initialize the field.
+        //
+        // SAFETY: The memory at `slot` is uninitialized.
+        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$fi=
eld), $field) };
+        // Create the drop guard:
+        //
+        // We only give access to `&DropGuard`, so it cannot be accidental=
ly forgotten.
+        //
+        // SAFETY: We forget the guard later when initialization has succe=
eded.
+        let $field =3D &unsafe {
+            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_=
mut!((*$slot).$field))
+        };
+
+        $crate::__init_internal!(init_slot($($use_data)?):
+            @data($data),
+            @slot($slot),
+            @munch_fields($($rest)*),
+        );
+    };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:ident),
+        @munch_fields($(,)?),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        // Endpoint, nothing more to munch, create the initializer.
+        // Since we are in the `if false` branch, this will never get exec=
uted. We abuse `slot` to
+        // get the correct type inference here:
+        unsafe {
+            ::core::ptr::write($slot, $t {
+                $($acc)*
+            });
+        }
+    };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:ident),
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::__init_internal!(make_initializer:
+            @slot($slot),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)* $field: ::core::panic!(),),
+        );
+    };
+    (make_initializer:
+        @slot($slot:ident),
+        @type_name($t:ident),
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+        @acc($($acc:tt)*),
+    ) =3D> {
+        $crate::__init_internal!(make_initializer:
+            @slot($slot),
+            @type_name($t),
+            @munch_fields($($rest)*),
+            @acc($($acc)* $field: ::core::panic!(),),
+        );
+    };
+    (forget_guards:
+        @munch_fields($(,)?),
+    ) =3D> {
+        // Munching finished.
+    };
+    (forget_guards:
+        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::__internal::DropGuard::forget($field) };
+
+        $crate::__init_internal!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+    (forget_guards:
+        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
+    ) =3D> {
+        unsafe { $crate::init::__internal::DropGuard::forget($field) };
+
+        $crate::__init_internal!(forget_guards:
+            @munch_fields($($rest)*),
+        );
+    };
+}

base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
--
2.41.0


