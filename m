Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839D370F933
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjEXOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjEXOxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:53:06 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4101A8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:52:36 -0700 (PDT)
Date:   Wed, 24 May 2023 14:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=qkvvwriddbeojgix67vuuke7hy.protonmail; t=1684939919; x=1685199119;
        bh=CL9s3PHQprbA9Ukgl2ZS7fO2vcssugR3QiwDaOjylcQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dffR/9pFMHkotKTsQh3Nq252whjndeWU2fztjO9IZkIIVrjHR+IkxTEsN22sJd8Lz
         9X8LfzEqVhpZiaIvzS1xu5+YlFHuBMcugBWoSr9wXmGxbAjANYwoNp20vHCBPsMOY0
         uWwuxXGM2w5MeNpTc4UCvrM54Ic8s0TC4tA3vNPXROZYW3kwE7lr2m34AJvtbX0uiQ
         1/qV5QsQP1jNjUYJPYePfu6LFY4juCJQ10bkXygKNDOR/vBfB7wwlF2ymQ+RQSKj09
         wjkiw1fuIBdEfBB4ugXZkmynBIPlHTp755xaAESCDYdGBRnB+fqafYq4p6r39F1pMv
         pV560yVRUWlRw==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
Message-ID: <ZWC2OS5uiRNgHMBBzQqt4FZXnOBeHw5IK5D7CAqfNC-z6nfYVLS9jXgvP2cMFvIMtVG22OGlmRGR9RkUJ53lip-SPiEkTHEiBoxMoL-K_38=@proton.me>
In-Reply-To: <20230517203119.3160435-7-aliceryhl@google.com>
References: <20230517203119.3160435-1-aliceryhl@google.com> <20230517203119.3160435-7-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 17th, 2023 at 22:31, Alice Ryhl <aliceryhl@google.com> wr=
ote:
> This commit introduces `ArcWorkItem`, `BoxWorkItem`, and
> `define_work_adapter_newtype!` that make it possible to use the
> workqueue without any unsafe code whatsoever.
>=20
> The `ArcWorkItem` and `BoxWorkItem` traits are used when a struct has a
> single `work_struct` field.
>=20
> The `define_work_adapter_newtype!` macro is used when a struct has
> multiple `work_struct` fields. For each `work_struct` field, a newtype
> struct is defined that wraps `Arc<TheStruct>`, and pushing an instance
> of the newtype to a workqueue will enqueue it using the associated
> `work_struct` field. The newtypes are matched with `work_struct` fields
> by having the T in `Work<T>` be the newtype.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 332 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 331 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 7509618af252..007005ddcaf0 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -4,8 +4,9 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/wo=
rkqueue.h)
>=20
> -use crate::{bindings, prelude::*, types::Opaque};
> +use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
>  use core::marker::{PhantomData, PhantomPinned};
> +use core::result::Result;
>=20
>  /// A kernel work queue.
>  ///
> @@ -279,6 +280,335 @@ macro_rules! impl_has_work {
>      )*};
>  }
>=20
> +/// Declares that [`Arc<Self>`] should implement [`WorkItem`].
> +///
> +/// # Examples
> +///
> +/// The example below will make [`Arc<MyStruct>`] implement the [`WorkIt=
em`] trait so that you can
> +/// enqueue it in a workqueue.
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct MyStruct {
> +///     work_field: Work<Arc<MyStruct>>,
> +/// }
> +///
> +/// kernel::impl_has_work! {
> +///     impl HasWork<Arc<MyStruct>> for MyStruct { self.work_field }
> +/// }
> +///
> +/// impl ArcWorkItem for MyStruct {
> +///     fn run(self: Arc<Self>) {
> +///         pr_info!("Executing MyStruct on a workqueue.");
> +///     }
> +/// }
> +/// ```
> +///
> +/// [`Arc<Self>`]: crate::sync::Arc
> +/// [`Arc<MyStruct>`]: crate::sync::Arc
> +pub trait ArcWorkItem {
> +    /// Called when this work item is executed.
> +    fn run(self: Arc<Self>);
> +}
> +
> +unsafe impl<T> WorkItem for Arc<T>
> +where
> +    T: ArcWorkItem + HasWork<Self> + ?Sized,
> +{
> +    type EnqueueOutput =3D Result<(), Self>;
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutpu=
t
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        let ptr =3D Arc::into_raw(self);
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_=
raw`.
> +        let off =3D unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us=
 a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr =3D unsafe { (ptr as *const u8).add(off) as *const =
Work<Self> };
> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr =3D unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {
> +            true =3D> Ok(()),
> +            // SAFETY: The work queue has not taken ownership of the poi=
nter.
> +            false =3D> Err(unsafe { Arc::from_raw(ptr) }),
> +        }
> +    }
> +}
> +
> +// Let `Work<Arc<T>>` be usable with types that are `ArcWorkItem`.
> +//
> +// We do not allow unsized types here. The `Work<Arc<T>>` field should a=
lways specify the actual
> +// concrete type stored in the `Arc`.
> +//
> +// SAFETY: The `Work<Arc<T>>` field must be initialized with this `run` =
method because the `Work`
> +// struct prevents you from initializing it in any other way. The `__enq=
ueue` trait uses the
> +// same `Work<Arc<T>>` field because `HasWork` promises to always return=
 the same field.
> +unsafe impl<T> WorkItemAdapter for Arc<T>
> +where
> +    T: ArcWorkItem + HasWork<Self> + Sized,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` st=
ored in a `Work<Self>`.
> +        let ptr =3D ptr as *mut Work<Self>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `=
Arc::into_raw`.
> +        let ptr =3D unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Arc::into_raw` and we've bee=
n given back ownership.
> +        let arc =3D unsafe { Arc::from_raw(ptr) };
> +
> +        arc.run();
> +    }
> +}
> +
> +/// Declares that [`Pin`]`<`[`Box`]`<Self>>` should implement [`WorkItem=
`].
> +///
> +/// # Examples
> +///
> +/// The example below will make [`Pin`]`<`[`Box`]`<MyStruct>>` implement=
 the [`WorkItem`] trait so
> +/// that you can enqueue it in a workqueue.
> +///
> +/// ```
> +/// struct MyStruct {
> +///     work_field: Work<Pin<Box<MyStruct>>>,
> +/// }
> +///
> +/// kernel::impl_has_work! {
> +///     impl HasWork<Pin<Box<MyStruct>>> for MyStruct { self.work_field =
}
> +/// }
> +///
> +/// impl BoxWorkItem for MyStruct {
> +///     fn run(self: Pin<Box<MyStruct>>) {
> +///         pr_info!("Executing MyStruct on a workqueue.");
> +///     }
> +/// }
> +/// ```
> +///
> +/// [`Box`]: alloc::boxed::Box
> +/// [`Pin`]: core::pin::Pin
> +pub trait BoxWorkItem {
> +    /// Called when this work item is executed.
> +    fn run(self: Pin<Box<Self>>);
> +}
> +
> +unsafe impl<T> WorkItem for Pin<Box<T>>
> +where
> +    T: BoxWorkItem + HasWork<Self> + ?Sized,
> +{
> +    // When a box is in a workqueue, the workqueue has exclusive ownersh=
ip of the box. Therefore,
> +    // it's not possible to enqueue a box while it is in a workqueue.
> +    type EnqueueOutput =3D ();
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F)
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        // SAFETY: We will not used the contents in an unpinned manner.
> +        let ptr =3D unsafe { Box::into_raw(Pin::into_inner_unchecked(sel=
f)) };
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_=
raw`.
> +        let off =3D unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us=
 a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr =3D unsafe { (ptr as *mut u8).add(off) as *mut Work=
<Self> };
> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr =3D unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {
> +            true =3D> {}
> +            // SAFETY: This method requires exclusive ownership of the b=
ox, so it cannot be in a
> +            // workqueue.
> +            false =3D> unsafe { core::hint::unreachable_unchecked() },
> +        }
> +    }
> +}
> +
> +// Let `Work<Pin<Box<T>>>` be usable with types that are `BoxWorkItem`.
> +//
> +// We do not allow unsized types here. The `Work<Pin<Box<T>>>` field sho=
uld always specify the actual
> +// concrete type stored in the `Box`.
> +//
> +// SAFETY: The `Work<Pin<Box<T>>>` field must be initialized with this r=
un method because the `Work`
> +// struct prevents you from initializing it in any other way. The `__enq=
ueue` trait uses the
> +// same `Work<Pin<Box<T>>>` field because `HasWork` promises to always r=
eturn the same field.
> +unsafe impl<T> WorkItemAdapter for Pin<Box<T>>
> +where
> +    T: BoxWorkItem + HasWork<Self> + Sized,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` st=
ored in a `Work<Self>`.
> +        let ptr =3D ptr as *mut Work<Self>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `=
Arc::into_raw`.
> +        let ptr =3D unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Box::into_raw` and we've bee=
n given back ownership.
> +        // The box was originally pinned, so pinning it again is ok.
> +        let boxed =3D unsafe { Pin::new_unchecked(Box::from_raw(ptr)) };
> +
> +        boxed.run();
> +    }
> +}
> +
> +/// Helper macro for structs with several `Work` fields that can be in s=
everal queues at once.
> +///
> +/// For each `Work` field in your type `T`, a newtype struct that wraps =
an `Arc<T>` or
> +/// `Pin<Box<T>>` should be defined.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// struct MyStruct {
> +///     work1: Work<MyStructWork1>,
> +///     work2: Work<MyStructWork2>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyStructWork1> for MyStruct { self.work1 }
> +///     impl HasWork<MyStructWork2> for MyStruct { self.work2 }
> +/// }
> +///
> +/// define_work_adapter_newtype! {
> +///     struct MyStructWork1(Arc<MyStruct>);
> +///     struct MyStructWork2(Arc<MyStruct>);
> +/// }
> +///
> +/// impl MyStructWork1 {
> +///     fn run(self) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// impl MyStructWork2 {
> +///     fn run(self) {
> +///         // ...
> +///     }
> +/// }
> +/// ```
> +///
> +/// This will let you push a `MyStructWork1(arc)` or `MyStructWork2(arc)=
` to a work queue. The [`Arc`]
> +/// can be in two work queues at the same time, and the `run` method on =
the wrapper type is called
> +/// when the work item is called.
> +///
> +/// [`Arc`]: crate::sync::Arc
> +#[macro_export]
> +macro_rules! define_work_adapter_newtype {
> +    (
> +        $(#[$outer:meta])*
> +        $pub:vis struct $name:ident(
> +            $(#[$innermeta:meta])*
> +            $fpub:vis Arc<$inner:ty> $(,)?
> +        );
> +        $($rest:tt)*
> +    ) =3D> {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub $crate::sync::Arc<$inn=
er>);

I am a bit confused as to why these types *contain* a pointer. Shouldn't
these be exactly the same `Work<$inner>`, except they allow multiple `run`
functions? So IMO they should embed a `Work<$inner>` and the
manually defined `run` function would take a `$inner`.

> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput =3D ::core::result::Result<(), $name>;
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::Enqu=
eueOutput
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struc=
t) -> bool,
> +            {
> +                let ptr =3D $crate::sync::Arc::into_raw(self.0);
> +
> +                // SAFETY: The pointer is not dangling since we just got=
 it from Arc::into_raw.
> +                let work_ptr =3D unsafe { <$inner as $crate::workqueue::=
HasWork::<$name>>::raw_get_work(ptr.cast_mut()) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr =3D unsafe { $crate::workqueue::Work::raw_g=
et(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {
> +                    true =3D> Ok(()),
> +                    // SAFETY: The work queue has not taken ownership of=
 the pointer.
> +                    false =3D> Err($name(unsafe { $crate::sync::Arc::fro=
m_raw(ptr) })),
> +                }
> +            }
> +        }
> +
> +        unsafe impl $crate::workqueue::WorkItemAdapter for $name {
> +            unsafe extern "C" fn run(ptr: *mut $crate::bindings::work_st=
ruct) {
> +                // SAFETY: The `__enqueue` method always uses a `work_st=
ruct` stored in a `Work<Self>`.
> +                let ptr =3D ptr as *mut $crate::workqueue::Work<Self>;
> +                // SAFETY: This computes the pointer that `__enqueue` go=
t from `Arc::into_raw`.
> +                let ptr =3D unsafe { <$inner as $crate::workqueue::HasWo=
rk::<$name>>::work_container_of(ptr) };
> +                // SAFETY: This pointer comes from `Arc::into_raw` and w=
e've been given back ownership.
> +                let arc =3D unsafe { $crate::sync::Arc::from_raw(ptr) };
> +
> +                $name::run($name(arc));
> +            }
> +        }
> +
> +        define_work_adapter_newtype! { $($rest)* }
> +    };
> +
> +    (
> +        $(#[$outer:meta])*
> +        $pub:vis struct $name:ident(
> +            $(#[$innermeta:meta])*
> +            $fpub:vis Pin<Box<$inner:ty>> $(,)?
> +        );
> +        $($rest:tt)*
> +    ) =3D> {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub ::core::pin::Pin<::all=
oc::boxed::Box<$inner>>);
> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput =3D ();
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F)
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struc=
t) -> bool,
> +            {
> +                // SAFETY: We will not used the contents in an unpinned =
manner.
> +                let boxed =3D unsafe { ::core::pin::Pin::into_inner_unch=
ecked(self.0) };
> +                let ptr =3D ::alloc::boxed::Box::into_raw(boxed);
> +
> +                // SAFETY: The pointer is not dangling since we just got=
 it from Box::into_raw.
> +                let work_ptr =3D unsafe { <$inner as $crate::workqueue::=
HasWork::<$name>>::raw_get_work(ptr) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr =3D unsafe { $crate::workqueue::Work::raw_g=
et(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {
> +                    true =3D> {},
> +                    // SAFETY: This method requires exclusive ownership =
of the box, so it cannot be in a
> +                    // workqueue.
> +                    false =3D> unsafe { ::core::hint::unreachable_unchec=
ked() },
> +                }
> +            }
> +        }
> +
> +        unsafe impl $crate::workqueue::WorkItemAdapter for $name {
> +            unsafe extern "C" fn run(ptr: *mut $crate::bindings::work_st=
ruct) {
> +                // SAFETY: The `__enqueue` method always uses a `work_st=
ruct` stored in a `Work<Self>`.
> +                let ptr =3D ptr as *mut $crate::workqueue::Work<Self>;
> +                // SAFETY: This computes the pointer that `__enqueue` go=
t from `Arc::into_raw`.
> +                let ptr =3D unsafe { <$inner as $crate::workqueue::HasWo=
rk::<$name>>::work_container_of(ptr) };
> +                // SAFETY: This pointer comes from `Box::into_raw` and w=
e've been given back ownership.
> +                let boxed =3D unsafe { ::alloc::boxed::Box::from_raw(ptr=
) };
> +                // SAFETY: The box was originally pinned, so pinning it =
again is ok.
> +                let boxed =3D unsafe { ::core::pin::Pin::new_unchecked(b=
oxed) };
> +
> +                $name::run($name(boxed));
> +            }
> +        }
> +
> +        define_work_adapter_newtype! { $($rest)* }
> +    };
> +
> +    // After processing the last definition, we call ourselves with no i=
nput.
> +    () =3D> {};
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU mu=
lti-threaded. There are
> --
> 2.40.1.606.ga4b1b128d6-goog
>=20

--
Cheers,
Benno
