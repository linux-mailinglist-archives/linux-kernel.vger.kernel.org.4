Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241A06D4D29
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjDCQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDCQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:05:51 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24D2D6A;
        Mon,  3 Apr 2023 09:05:47 -0700 (PDT)
Date:   Mon, 03 Apr 2023 16:05:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680537945; x=1680797145;
        bh=0rd5UabrR4S8zBOjGuYiCQNZWnW9f90O2jNqLnbMfWQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UGpvUuXySKIQEtOuB55zxqpC1PpiMhJ8FMYSS/tv8ESgwa9km4t/qF4VfPGnPls4I
         jOjFfIg44ykT/vg12YzynQGnKM0+sShxvsDO4YECHqFN9Ylg6px5qy59mv4XNvPldn
         7imdbUjIDJV1uanzAoTaVXQkGGLG7PefENu5WNJg9nJ4lmdPxZj+aIfJaJMfR3Y4sq
         KXtvzOnkl4wb4XUinkV8ia3E1ARknKv5+Vb5pHelVrzRamR4nQaFqPScb2N+eZWfGZ
         AZe7NsLxr9FzXripc7x7hNjktRXeI+fNDn80ZxR8fu6DzfVLXJEGxcQKMzpqHoPbun
         Hrj3ZjOiyT7XA==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <y86-dev@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH v5 11/15] rust: init: add `Zeroable` trait and `init::zeroed` function
Message-ID: <20230403160511.174894-4-y86-dev@protonmail.com>
In-Reply-To: <20230403154422.168633-1-y86-dev@protonmail.com>
References: <20230403154422.168633-1-y86-dev@protonmail.com>
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
Cc: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/init.rs | 94 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 1343cafdd760..09bba4e86ace 100644
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
@@ -1329,3 +1335,87 @@ pub unsafe trait PinnedDrop: __internal::HasPinData =
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
+pub fn zeroed<T: Zeroable + Unpin>() -> impl Init<T> {
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


