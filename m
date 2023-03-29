Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2324A6CF673
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjC2We5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjC2Wed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:34:33 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD16A42
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:34:01 -0700 (PDT)
Date:   Wed, 29 Mar 2023 22:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680129221; x=1680388421;
        bh=CqqTxRO7PGWaLkf8AosWoBeoOehZuoxHX0UaJT8k+Lg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=koq4wetAKqlFccSGms/+P/N5JD44HC5I7nSJGPQL9gze0kK9Xiqzgnc/DxM/P9WtS
         CVbYV1dyO3bkSBI7v123sA+9UyWX+UsePaMP6564+UMQzq/fjzQrKkAVktY/5KydCQ
         TzoNFxV172B+DcyBMIqgXXF4oiMVU5WqO0nYS2RJZE97nUbhhZSjJsa5AlAGVh/wZh
         2EnduvYS4iP+56bcmI1+VYq3yDR03G2CHBhmYA3EH4X/3WqCoUuJvOJt+esUXSf1c3
         7la0Zs9JcQibKI7GKKFzo/wuUBykw3gYI/4pspUTsUaq3ZStwbjhUXmi//1XigS6xr
         QGRpoy64ii58g==
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>
From:   y86-dev@protonmail.com
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH v3 09/13] rust: init: add `Zeroable` trait and `init::zeroed` function
Message-ID: <20230329223239.138757-10-y86-dev@protonmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benno Lossin <y86-dev@protonmail.com>

Add the `Zeroable` trait which marks types that can be initialized by
writing `0x00` to every byte of the type. Also add the `init::zeroed`
function that creates an initializer for a `Zeroable` type that writes
`0x00` to every byte.

Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
---
 rust/kernel/init.rs | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 3358f14beffb..a923546696ce 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1254,3 +1254,68 @@ pub unsafe trait PinnedDrop: __internal::HasPinData =
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
+    ($($t:ty, )*) =3D> {
+        $(unsafe impl Zeroable for $t {})*
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
+    // SAFETY: There is nothing to zero.
+    core::marker::PhantomPinned, Infallible, (),
+}
+
+// SAFETY: We are allowed to zero padding bytes.
+unsafe impl<const N: usize, T: Zeroable> Zeroable for [T; N] {}
+
+// SAFETY: There is nothing to zero.
+unsafe impl<T: ?Sized> Zeroable for PhantomData<T> {}
+
+// SAFETY: `null` pointer is valid.
+unsafe impl<T: ?Sized> Zeroable for *mut T {}
+unsafe impl<T: ?Sized> Zeroable for *const T {}
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


