Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45FD65737E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1HKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1HKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:10:13 -0500
Received: from mr85p00im-ztdg06021701.me.com (mr85p00im-ztdg06021701.me.com [17.58.23.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D610A458
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1672211409; bh=bcNtYuQZlJwpGTNKEC4GZVBkqp1+IA7MdYYDJXwfYTM=;
        h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
        b=wf1JPcIcVx12uduPIeinC03H38EFjXk1Wx4c/+TPSDdiWaBw+wm9TEY8J3dDXIKVF
         8z711/30cCABo0Msb/WPeZ4g+y5fNeaNyW8iUvnzohTB3S7e9DyWN+Vk/HgCRsoWZH
         GBYdvDzc2g0Hi5YqafrTwhmj1u5OxCaeTjeePMYK3Vymgj2DEDvXu18ulnKCR8Wh7m
         ZT5QfpH2+7MD+O/CAojx6QQG00pKJOaRHWJMyLeun/w22LaP6R4oPmPI+11gWOsvL7
         WAVmBM6iRq9UZ5GbYClaAFaEyXlFlCuwx1L8xvMKHmyzn/vkI0MD3vs/KbfoQ85NGs
         qM0WEQ+YO6ang==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-ztdg06021701.me.com (Postfix) with ESMTPSA id 97A3E26340DD;
        Wed, 28 Dec 2022 07:10:08 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.23\))
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
From:   Laine Taffin Altman <alexanderaltman@me.com>
In-Reply-To: <20221228060346.352362-1-wedsonaf@gmail.com>
Date:   Tue, 27 Dec 2022 23:09:57 -0800
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3B7C271-4C96-455E-A990-2AC7C52F703E@me.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
X-Mailer: Apple Mail (2.3731.400.23)
X-Proofpoint-GUID: UoIZ98A_cIOTpmpXc_HiHJxG83PX_Do3
X-Proofpoint-ORIG-GUID: UoIZ98A_cIOTpmpXc_HiHJxG83PX_Do3
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 clxscore=1011
 spamscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212280057
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 27, 2022, at 10:03 PM, Wedson Almeida Filho <wedsonaf@gmail.com> =
wrote:
>=20
> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
> allows Rust code to idiomatically allocate memory that is ref-counted.
>=20
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
> rust/bindings/bindings_helper.h |   1 +
> rust/bindings/lib.rs            |   1 +
> rust/helpers.c                  |  19 ++++
> rust/kernel/lib.rs              |   1 +
> rust/kernel/sync.rs             |  10 ++
> rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
> 6 files changed, 189 insertions(+)
> create mode 100644 rust/kernel/sync.rs
> create mode 100644 rust/kernel/sync/arc.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h =
b/rust/bindings/bindings_helper.h
> index c48bc284214a..75d85bd6c592 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>  */
>=20
> #include <linux/slab.h>
> +#include <linux/refcount.h>
>=20
> /* `bindgen` gets confused at certain things. */
> const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 6c50ee62c56b..7b246454e009 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -41,6 +41,7 @@ mod bindings_raw {
> #[allow(dead_code)]
> mod bindings_helper {
>     // Import the generated bindings for types.
> +    use super::bindings_raw::*;
>     include!(concat!(
>         env!("OBJTREE"),
>         "/rust/bindings/bindings_helpers_generated.rs"
> diff --git a/rust/helpers.c b/rust/helpers.c
> index b4f15eee2ffd..09a4d93f9d62 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>=20
> #include <linux/bug.h>
> #include <linux/build_bug.h>
> +#include <linux/refcount.h>
>=20
> __noreturn void rust_helper_BUG(void)
> {
> @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
> }
> EXPORT_SYMBOL_GPL(rust_helper_BUG);
>=20
> +refcount_t rust_helper_REFCOUNT_INIT(int n)
> +{
> + return (refcount_t)REFCOUNT_INIT(n);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
> +
> +void rust_helper_refcount_inc(refcount_t *r)
> +{
> + refcount_inc(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
> +
> +bool rust_helper_refcount_dec_and_test(refcount_t *r)
> +{
> + return refcount_dec_and_test(r);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> +
> /*
>  * We use `bindgen`'s `--size_t-is-usize` option to bind the C =
`size_t` type
>  * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 53040fa9e897..ace064a3702a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -31,6 +31,7 @@ mod static_assert;
> #[doc(hidden)]
> pub mod std_vendor;
> pub mod str;
> +pub mod sync;
> pub mod types;
>=20
> #[doc(hidden)]
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> new file mode 100644
> index 000000000000..39b379dd548f
> --- /dev/null
> +++ b/rust/kernel/sync.rs
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Synchronisation primitives.
> +//!
> +//! This module contains the kernel APIs related to synchronisation =
that have been ported or
> +//! wrapped for usage by Rust code in the kernel.
> +
> +mod arc;
> +
> +pub use arc::Arc;
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> new file mode 100644
> index 000000000000..22290eb5ab9b
> --- /dev/null
> +++ b/rust/kernel/sync/arc.rs
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A reference-counted pointer.
> +//!
> +//! This module implements a way for users to create =
reference-counted objects and pointers to
> +//! them. Such a pointer automatically increments and decrements the =
count, and drops the
> +//! underlying object when it reaches zero. It is also safe to use =
concurrently from multiple
> +//! threads.
> +//!
> +//! It is different from the standard library's [`Arc`] in a few =
ways:
> +//! 1. It is backed by the kernel's `refcount_t` type.
> +//! 2. It does not support weak references, which allows it to be =
half the size.
> +//! 3. It saturates the reference count instead of aborting when it =
goes over a threshold.

This makes me worry, and the rest of the code confirms it.  This is not =
a safe abstraction:  what happens if the count saturates and then =
everything is dropped again?  The count =E2=80=9Cgoes negative=E2=80=9D =
(which is to say, use-after-free).

> +//! 4. It does not provide a `get_mut` method, so the ref counted =
object is pinned.
> +//!
> +//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
> +
> +use crate::{bindings, error::Result, types::Opaque};
> +use alloc::boxed::Box;
> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
> +
> +/// A reference-counted pointer to an instance of `T`.
> +///
> +/// The reference count is incremented when new instances of [`Arc`] =
are created, and decremented
> +/// when they are dropped. When the count reaches zero, the =
underlying `T` is also dropped.
> +///
> +/// # Invariants
> +///
> +/// The reference count on an instance of [`Arc`] is always non-zero.
> +/// The object pointed to by [`Arc`] is always pinned.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// // Create a ref-counted instance of `Example`.
> +/// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
> +///
> +/// // Get a new pointer to `obj` and increment the refcount.
> +/// let cloned =3D obj.clone();
> +///
> +/// // Assert that both `obj` and `cloned` point to the same =
underlying object.
> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> +///
> +/// // Destroy `obj` and decrement its refcount.
> +/// drop(obj);
> +///
> +/// // Check that the values are still accessible through `cloned`.
> +/// assert_eq!(cloned.a, 10);
> +/// assert_eq!(cloned.b, 20);
> +///
> +/// // The refcount drops to zero when `cloned` goes out of scope, =
and the memory is freed.
> +/// ```
> +pub struct Arc<T: ?Sized> {
> +    ptr: NonNull<ArcInner<T>>,
> +    _p: PhantomData<ArcInner<T>>,
> +}
> +
> +#[repr(C)]
> +struct ArcInner<T: ?Sized> {
> +    refcount: Opaque<bindings::refcount_t>,
> +    data: T,
> +}
> +
> +// SAFETY: It is safe to send `Arc<T>` to another thread when the =
underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is =
`Sync`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `Arc<T>` may =
ultimately access `T` directly, for
> +// example, when the reference count reaches zero and `T` is dropped.
> +unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
> +
> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the =
underlying `T` is `Sync` for the
> +// same reason as above. `T` needs to be `Send` as well because a =
thread can clone an `&Arc<T>`
> +// into an `Arc<T>`, which may lead to `T` being accessed by the same =
reasoning as above.
> +unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
> +
> +impl<T> Arc<T> {
> +    /// Constructs a new reference counted instance of `T`.
> +    pub fn try_new(contents: T) -> Result<Self> {
> +        // INVARIANT: The refcount is initialised to a non-zero =
value.
> +        let value =3D ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI =
call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) =
}),
> +            data: contents,
> +        };
> +
> +        let inner =3D Box::try_new(value)?;
> +
> +        // SAFETY: We just created `inner` with a reference count of =
1, which is owned by the new
> +        // `Arc` object.
> +        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
> +    }
> +}
> +
> +impl<T: ?Sized> Arc<T> {
> +    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `inner` points to a valid =
location and has a non-zero reference
> +    /// count, one of which will be owned by the new [`Arc`] =
instance.
> +    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
> +        // INVARIANT: By the safety requirements, the invariants =
hold.
> +        Arc {
> +            ptr: inner,
> +            _p: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized> Deref for Arc<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: By the type invariant, there is necessarily a =
reference to the object, so it is
> +        // safe to dereference it.
> +        unsafe { &self.ptr.as_ref().data }
> +    }
> +}
> +
> +impl<T: ?Sized> Clone for Arc<T> {
> +    fn clone(&self) -> Self {
> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it =
cannot overflow to zero.
> +        // SAFETY: By the type invariant, there is necessarily a =
reference to the object, so it is
> +        // safe to increment the refcount.
> +        unsafe { =
bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };

This needs to be a fallible process; maybe provide a try_clone inherent =
method instead of the trait impl.  It=E2=80=99s not worth the =
=E2=80=9Cconvenience=E2=80=9D to have something that can break safety =
(see above).  There is a reason for the original one panicking here!

> +
> +        // SAFETY: We just incremented the refcount. This increment =
is now owned by the new `Arc`.
> +        unsafe { Self::from_inner(self.ptr) }
> +    }
> +}
> +
> +impl<T: ?Sized> Drop for Arc<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariant, there is necessarily a =
reference to the object. We cannot
> +        // touch `refcount` after it's decremented to a non-zero =
value because another thread/CPU
> +        // may concurrently decrement it to zero and free it. It is =
ok to have a raw pointer to
> +        // freed/invalid memory as long as it is never dereferenced.
> +        let refcount =3D unsafe { self.ptr.as_ref() }.refcount.get();
> +
> +        // INVARIANT: If the refcount reaches zero, there are no =
other instances of `Arc`, and
> +        // this instance is being dropped, so the broken invariant is =
not observable.
> +        // SAFETY: Also by the type invariant, we are allowed to =
decrement the refcount.
> +        let is_zero =3D unsafe { =
bindings::refcount_dec_and_test(refcount) };
> +        if is_zero {
> +            // The count reached zero, we must free the memory.
> +            //
> +            // SAFETY: The pointer was initialised from the result of =
`Box::leak`.
> +            unsafe { Box::from_raw(self.ptr.as_ptr()) };
> +        }
> +    }
> +}
> --=20
> 2.34.1
>=20
>=20

