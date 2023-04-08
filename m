Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025E6DBAE1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 14:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjDHM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 08:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjDHM1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 08:27:04 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050CFF31
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 05:26:43 -0700 (PDT)
Date:   Sat, 08 Apr 2023 12:26:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680956785; x=1681215985;
        bh=Wx+mkXJAMUZ55C6ki8WnDTtKcBxXLup6TKxHAyI1Z5o=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LdlqORiSsNmxoIt4QRBloMSFoxTFyK6z0FRrncl/KmcMtLQebpjtxrOqTAeV+aSOa
         jOYaEZSgrxlwJHNrTMlLJAPfgiC9ivEVVTp44iEucDd7TetLNo1h+fVtuJRhsxMeWH
         +vsN4BlH7TRFQxqOBlt/RttSqT3zYaxNhlTRLRoYzN3+zKmvp1M1lF9jZVVtdtBo+/
         3V1dlq0lhm4BJjgVcwUcN2coxWhS/8KFrebSFZYDcnoE7w8RhlXWQqq0CG5vKh5wCe
         OqxKRf9ZR+DH8ohdsRBy3DnOEQx70CdQLsE/vAvGhmb7hAnkPSrDdq/2z6myjOK6AM
         2+sNyW3knxJZg==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v7 11/15] rust: init: add `Zeroable` trait and `init::zeroed` function
Message-ID: <20230408122429.1103522-12-y86-dev@protonmail.com>
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

Add the `Zeroable` trait which marks types that can be initialized by
writing `0x00` to every byte of the type. Also add the `init::zeroed`
function that creates an initializer for a `Zeroable` type that writes
`0x00` to every byte.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/init.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 99751375e7c8..ffd539e2f5ef 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -195,8 +195,14 @@ use crate::{
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::AllocError, cell::Cell, convert::Infallible, marker::PhantomDat=
a, mem::MaybeUninit,
-    pin::Pin, ptr,
+    alloc::AllocError,
+    cell::Cell,
+    convert::Infallible,
+    marker::PhantomData,
+    mem::MaybeUninit,
+    num::*,
+    pin::Pin,
+    ptr::{self, NonNull},
 };

 #[doc(hidden)]
@@ -1323,3 +1329,90 @@ pub unsafe trait PinnedDrop: __internal::HasPinData =
{
     /// automatically.
     fn drop(self: Pin<&mut Self>, only_call_from_drop: __internal::OnlyCal=
lFromDrop);
 }
+
+/// Marker trait for types that can be initialized by writing just zeroes.
+///
+/// # Safety
+///
+/// The bit pattern consisting of only zeroes is a valid bit pattern for t=
his type. In other words,
+/// this is not UB:
+///
+/// ```rust,ignore
+/// let val: Self =3D unsafe { core::mem::zeroed() };
+/// ```
+pub unsafe trait Zeroable {}
+
+/// Create a new zeroed T.
+///
+/// The returned initializer will write `0x00` to every byte of the given =
`slot`.
+#[inline]
+pub fn zeroed<T: Zeroable>() -> impl Init<T> {
+    // SAFETY: Because `T: Zeroable`, all bytes zero is a valid bit patter=
n for `T`
+    // and because we write all zeroes, the memory is initialized.
+    unsafe {
+        init_from_closure(|slot: *mut T| {
+            slot.write_bytes(0, 1);
+            Ok(())
+        })
+    }
+}
+
+macro_rules! impl_zeroable {
+    ($($({$($generics:tt)*})? $t:ty, )*) =3D> {
+        $(unsafe impl$($($generics)*)? Zeroable for $t {})*
+    };
+}
+
+impl_zeroable! {
+    // SAFETY: All primitives that are allowed to be zero.
+    bool,
+    char,
+    u8, u16, u32, u64, u128, usize,
+    i8, i16, i32, i64, i128, isize,
+    f32, f64,
+
+    // SAFETY: These are ZSTs, there is nothing to zero.
+    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, Infallible,=
 (),
+
+    // SAFETY: Type is allowed to take any value, including all zeros.
+    {<T>} MaybeUninit<T>,
+
+    // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee).
+    Option<NonZeroU8>, Option<NonZeroU16>, Option<NonZeroU32>, Option<NonZ=
eroU64>,
+    Option<NonZeroU128>, Option<NonZeroUsize>,
+    Option<NonZeroI8>, Option<NonZeroI16>, Option<NonZeroI32>, Option<NonZ=
eroI64>,
+    Option<NonZeroI128>, Option<NonZeroIsize>,
+
+    // SAFETY: All zeros is equivalent to `None` (option layout optimizati=
on guarantee).
+    //
+    // In this case we are allowed to use `T: ?Sized`, since all zeros is =
the `None` variant.
+    {<T: ?Sized>} Option<NonNull<T>>,
+    {<T: ?Sized>} Option<Box<T>>,
+
+    // SAFETY: `null` pointer is valid.
+    //
+    // We cannot use `T: ?Sized`, since the VTABLE pointer part of fat poi=
nters is not allowed to be
+    // null.
+    //
+    // When `Pointee` gets stabilized, we could use
+    // `T: ?Sized where <T as Pointee>::Metadata: Zeroable`
+    {<T>} *mut T, {<T>} *const T,
+
+    // SAFETY: `null` pointer is valid and the metadata part of these fat =
pointers is allowed to be
+    // zero.
+    {<T>} *mut [T], {<T>} *const [T], *mut str, *const str,
+
+    // SAFETY: `T` is `Zeroable`.
+    {<const N: usize, T: Zeroable>} [T; N], {<T: Zeroable>} Wrapping<T>,
+}
+
+macro_rules! impl_tuple_zeroable {
+    ($(,)?) =3D> {};
+    ($first:ident, $($t:ident),* $(,)?) =3D> {
+        // SAFETY: All elements are zeroable and padding can be zero.
+        unsafe impl<$first: Zeroable, $($t: Zeroable),*> Zeroable for ($fi=
rst, $($t),*) {}
+        impl_tuple_zeroable!($($t),* ,);
+    }
+}
+
+impl_tuple_zeroable!(A, B, C, D, E, F, G, H, I, J);
--
2.39.2


