Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251E6E0984
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDMI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDMI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:58:43 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0701F49FE;
        Thu, 13 Apr 2023 01:56:32 -0700 (PDT)
Date:   Thu, 13 Apr 2023 08:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1681376188; x=1681635388;
        bh=g737EIKMRnF2623bcmw1pojpvM3xa1H2tKB2+vbIn8Y=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LyuAJogirvUQPcmeaGUpoAVY3tbakTyN2dL1/pB0jbFXDAUKtGZp6toHX4Lv6RZZS
         slFhcx29zmnwpwfwtUnLl6qxxggNl4tNPLBmTf4Ya7kOw8LIn758mwm8pajZAaNWHV
         QqiqwHVRwm251zya9RYAdsJVpuM7Bek99sC7XtlHTLJ8dunlBabmUYHX4VAV0l1jpy
         K7ZMmG682QbhKPMyPFYkfhiVZ1HQbqOXUeN6RkzQn91jUP8qv6HgaVCN+rGPa4qOgw
         qqxqdZ7Mt/MjiXVDtQ2qvVd4dEd+BHOii4eRaNXwjPsYI2Mp+N6kytvhQ2hdXoRzY6
         H7xNA9YGvtndA==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 03/13] rust: lock: introduce `Mutex`
Message-ID: <fb1ce18b-6d63-6e76-1e55-53974711cbe0@proton.me>
In-Reply-To: <20230411054543.21278-3-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-3-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.23 07:45, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is the `struct mutex` lock backend and allows Rust code to use the
> kernel mutex idiomatically.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> v4 -> v4: No changes
>
>   rust/helpers.c                 |   7 ++
>   rust/kernel/sync.rs            |   1 +
>   rust/kernel/sync/lock.rs       |   2 +
>   rust/kernel/sync/lock/mutex.rs | 118 +++++++++++++++++++++++++++++++++
>   4 files changed, 128 insertions(+)
>   create mode 100644 rust/kernel/sync/lock/mutex.rs
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 04b9be46e887..86af099d2d66 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -22,6 +22,7 @@
>   #include <linux/build_bug.h>
>   #include <linux/err.h>
>   #include <linux/refcount.h>
> +#include <linux/mutex.h>
>
>   __noreturn void rust_helper_BUG(void)
>   {
> @@ -29,6 +30,12 @@ __noreturn void rust_helper_BUG(void)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_BUG);
>
> +void rust_helper_mutex_lock(struct mutex *lock)
> +{
> +=09mutex_lock(lock);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mutex_lock);
> +
>   refcount_t rust_helper_REFCOUNT_INIT(int n)
>   {
>   =09return (refcount_t)REFCOUNT_INIT(n);
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 81b0998eaa18..693f0b7f4e4f 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -11,6 +11,7 @@ mod arc;
>   pub mod lock;
>
>   pub use arc::{Arc, ArcBorrow, UniqueArc};
> +pub use lock::mutex::Mutex;
>
>   /// Represents a lockdep class. It's a wrapper around C's `lock_class_k=
ey`.
>   #[repr(transparent)]
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 1a8ecccf4f24..98de109d9e40 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -10,6 +10,8 @@ use crate::{bindings, init::PinInit, pin_init, str::CSt=
r, types::Opaque};
>   use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned=
};
>   use macros::pin_data;
>
> +pub mod mutex;
> +
>   /// The "backend" of a lock.
>   ///
>   /// It is the actual implementation of the lock, without the need to re=
peat patterns used in all
> diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex=
.rs
> new file mode 100644
> index 000000000000..923472f04af4
> --- /dev/null
> +++ b/rust/kernel/sync/lock/mutex.rs
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A kernel mutex.
> +//!
> +//! This module allows Rust code to use the kernel's `struct mutex`.
> +
> +use crate::bindings;
> +
> +/// Creates a [`Mutex`] initialiser with the given name and a newly-crea=
ted lock class.
> +///
> +/// It uses the name if one is given, otherwise it generates one based o=
n the file name and line
> +/// number.
> +#[macro_export]
> +macro_rules! new_mutex {
> +    ($inner:expr $(, $name:literal)? $(,)?) =3D> {
> +        $crate::sync::Mutex::new(
> +            $inner, $crate::optional_name!($($name)?), $crate::static_lo=
ck_class!())
> +    };
> +}
> +
> +/// A mutual exclusion primitive.
> +///
> +/// Exposes the kernel's [`struct mutex`]. When multiple threads attempt=
 to lock the same mutex,
> +/// only one at a time is allowed to progress, the others will block (sl=
eep) until the mutex is
> +/// unlocked, at which point another thread will be allowed to wake up a=
nd make progress.
> +///
> +/// Since it may block, [`Mutex`] needs to be used with care in atomic c=
ontexts.
> +///
> +/// Instances of [`Mutex`] need a lock class and to be pinned. The recom=
mended way to create such

The first sentence reads weird, missing another 'need'?

> +/// instances is with the [`pin_init`](crate::pin_init) and [`new_mutex`=
] macros.
> +///
> +/// # Examples
> +///
> +/// The following example shows how to declare, allocate and initialise =
a struct (`Example`) that
> +/// contains an inner struct (`Inner`) that is protected by a mutex.
> +///
> +/// ```
> +/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, =
sync::Mutex};
> +///
> +/// struct Inner {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Example {
> +///     c: u32,
> +///     #[pin]
> +///     d: Mutex<Inner>,
> +/// }
> +///
> +/// impl Example {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             c: 10,
> +///             d <- new_mutex!(Inner { a: 20, b: 30 }),
> +///         })
> +///     }
> +/// }
> +///
> +/// // Allocate a boxed `Example`.
> +/// let e =3D Box::pin_init(Example::new())?;
> +/// assert_eq!(e.c, 10);
> +/// assert_eq!(e.d.lock().a, 20);
> +/// assert_eq!(e.d.lock().b, 30);
> +/// ```
> +///
> +/// The following example shows how to use interior mutability to modify=
 the contents of a struct
> +/// protected by a mutex despite only having a shared reference:

I would not bring up interior mutability here, the `Mutex` uses it, but
not the user of the `Mutex`. I would just say:

     To access the data behind a `Mutex`, simply take a shared reference to
     the `Mutex` and call `lock()` on it. This function returns a guard obj=
ect
     that dereferences to the protected data. The `Mutex` is unlocked when =
the
     guard object goes out of scope.

> +///
> +/// ```
> +/// use kernel::sync::Mutex;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// fn example(m: &Mutex<Example>) {
> +///     let mut guard =3D m.lock();
> +///     guard.a +=3D 10;
> +///     guard.b +=3D 20;
> +/// }
> +/// ```
> +///
> +/// [`struct mutex`]: ../../../../include/linux/mutex.h
> +pub type Mutex<T> =3D super::Lock<T, MutexBackend>;
> +
> +/// A kernel `struct mutex` lock backend.
> +pub struct MutexBackend;
> +
> +// SAFETY: The underlying kernel `struct mutex` object ensures mutual ex=
clusion.
> +unsafe impl super::Backend for MutexBackend {
> +    type State =3D bindings::mutex;
> +    type GuardState =3D ();
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const core::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid fo=
r writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__mutex_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::mutex_lock(ptr) };
> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardSt=
ate) {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` is valid and that the
> +        // caller is the owner of the mutex.
> +        unsafe { bindings::mutex_unlock(ptr) };
> +    }
> +}
> --
> 2.34.1
>


