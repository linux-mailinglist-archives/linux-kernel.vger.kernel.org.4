Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9D715C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjE3Ktk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjE3KtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:49:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B27F0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:48:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so44638765e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685443733; x=1688035733;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Ped768EC65FpvNMiCyFjflWJPUe7uqWkqG/5JQCsY=;
        b=FQumZwljQ98CYURCxvN7DSI2QDUGx6k3fZF4uItXCnVuzZDF2mzQ78eQ1rLdowpQoQ
         L52RkL1rvm8wyDtgTMRbGsPKOpvWwxD2DnXHhl9QJpGA7m9azx9bE3+270uHpVJzuRSm
         OjlgzAo/b3BC9iEsZgow/d+KSVmYQWKmjJd4zUwS8Jb5aj59cQiofFgGHW4SlArPrAJ2
         nBXxVPHlyCF0PGtZG+TFqM0MCwuQpcz29qxLk347R2e5WXDYnrJ86z2tkkDw4K6QtAh7
         JBiuZGhOhNrzf1/Es3X/nuD6nqrFuguS1zxohihmVqIHfsFE0X7F5ITEADDd5iwiVvi5
         c/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685443733; x=1688035733;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0Ped768EC65FpvNMiCyFjflWJPUe7uqWkqG/5JQCsY=;
        b=ap415gZi8gTxSwBx10KmH+R5oobtB9y0kWnd/5OcN8zpI32+P5HyA6tiXJrN2nB7R/
         FQmgSEJdh5XKyOhau0Nn2/b1Z23PedDtVgPksR1uqF+0Q7/JLrEzs/HL8BzBgn8h+TUt
         HhCEspyxMxwvynYZaeXtEUfT5m8DHKeajlY6FsDEh1avRipj6l47i6zMcDWBSfK9xFt7
         hcQpB3M3PcIeh2yDl4H4gHdfuE8mMcDXNuYCOu+bB3CtC4nbLtL34HVeKa63mjcqUJQn
         ycFkFqe5wRAEzjlaPBB/3h0z9vCPX++NEc1uUcX2T7XNK/+RQo7Na3EqrMiI7iWULvHR
         6ctQ==
X-Gm-Message-State: AC+VfDy3UO5bs/oeP0UbCb8cBMn68R4ZhRbxGBLA+t75jSL0CDMJyRlC
        NJLYssK6UYi/5EB/pf7JKBXbnw==
X-Google-Smtp-Source: ACHHUZ5XgjXAJ7EU0WYL1sZ5Pv3H4wM+dNIlOco2MNI1PiYk3FXN7Ct525tw0UGuSXnArq6fae8w9Q==
X-Received: by 2002:a5d:5008:0:b0:30a:e647:fc2e with SMTP id e8-20020a5d5008000000b0030ae647fc2emr1853866wrt.19.1685443732623;
        Tue, 30 May 2023 03:48:52 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id y15-20020a056000108f00b003079ed1f0a0sm2867180wrw.44.2023.05.30.03.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 03:48:52 -0700 (PDT)
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-7-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
Date:   Tue, 30 May 2023 10:51:14 +0200
In-reply-to: <20230517203119.3160435-7-aliceryhl@google.com>
Message-ID: <87bki29jsc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This commit introduces `ArcWorkItem`, `BoxWorkItem`, and
> `define_work_adapter_newtype!` that make it possible to use the
> workqueue without any unsafe code whatsoever.
>
> The `ArcWorkItem` and `BoxWorkItem` traits are used when a struct has a
> single `work_struct` field.
>
> The `define_work_adapter_newtype!` macro is used when a struct has
> multiple `work_struct` fields. For each `work_struct` field, a newtype
> struct is defined that wraps `Arc<TheStruct>`, and pushing an instance
> of the newtype to a workqueue will enqueue it using the associated
> `work_struct` field. The newtypes are matched with `work_struct` fields
> by having the T in `Work<T>` be the newtype.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 332 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 331 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 7509618af252..007005ddcaf0 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -4,8 +4,9 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
> -use crate::{bindings, prelude::*, types::Opaque};
> +use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
>  use core::marker::{PhantomData, PhantomPinned};
> +use core::result::Result;
>  
>  /// A kernel work queue.
>  ///
> @@ -279,6 +280,335 @@ macro_rules! impl_has_work {
>      )*};
>  }
>  
> +/// Declares that [`Arc<Self>`] should implement [`WorkItem`].
> +///
> +/// # Examples
> +///
> +/// The example below will make [`Arc<MyStruct>`] implement the [`WorkItem`] trait so that you can
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
> +    type EnqueueOutput = Result<(), Self>;
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        let ptr = Arc::into_raw(self);
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_raw`.
> +        let off = unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr = unsafe { (ptr as *const u8).add(off) as *const Work<Self> };

We have this functionality in the default impl of
`HasWork<T>::raw_get_work() where Self: Sized`. I am uncertain about the
`Sized` bound. If it is sound to do the offset calculation here where
`T: ?Sized`, it should also be sound in the default implementation of
`HasWork<T>`. Should we not be able to change the bound on
`HasWork<T>::raw_get_work()` to `Self: ?Sized` and call into that from
here?

        let work_ptr = unsafe { <T as HasWork<Self>>::raw_get_work(ptr as _) };

Same for Box.

BR Andreas

> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {
> +            true => Ok(()),
> +            // SAFETY: The work queue has not taken ownership of the pointer.
> +            false => Err(unsafe { Arc::from_raw(ptr) }),
> +        }
> +    }
> +}
> +
> +// Let `Work<Arc<T>>` be usable with types that are `ArcWorkItem`.
> +//
> +// We do not allow unsized types here. The `Work<Arc<T>>` field should always specify the actual
> +// concrete type stored in the `Arc`.
> +//
> +// SAFETY: The `Work<Arc<T>>` field must be initialized with this `run` method because the `Work`
> +// struct prevents you from initializing it in any other way. The `__enqueue` trait uses the
> +// same `Work<Arc<T>>` field because `HasWork` promises to always return the same field.
> +unsafe impl<T> WorkItemAdapter for Arc<T>
> +where
> +    T: ArcWorkItem + HasWork<Self> + Sized,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<Self>`.
> +        let ptr = ptr as *mut Work<Self>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +        let ptr = unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
> +        let arc = unsafe { Arc::from_raw(ptr) };
> +
> +        arc.run();
> +    }
> +}
> +
> +/// Declares that [`Pin`]`<`[`Box`]`<Self>>` should implement [`WorkItem`].
> +///
> +/// # Examples
> +///
> +/// The example below will make [`Pin`]`<`[`Box`]`<MyStruct>>` implement the [`WorkItem`] trait so
> +/// that you can enqueue it in a workqueue.
> +///
> +/// ```
> +/// struct MyStruct {
> +///     work_field: Work<Pin<Box<MyStruct>>>,
> +/// }
> +///
> +/// kernel::impl_has_work! {
> +///     impl HasWork<Pin<Box<MyStruct>>> for MyStruct { self.work_field }
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
> +    // When a box is in a workqueue, the workqueue has exclusive ownership of the box. Therefore,
> +    // it's not possible to enqueue a box while it is in a workqueue.
> +    type EnqueueOutput = ();
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F)
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        // SAFETY: We will not used the contents in an unpinned manner.
> +        let ptr = unsafe { Box::into_raw(Pin::into_inner_unchecked(self)) };
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_raw`.
> +        let off = unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr = unsafe { (ptr as *mut u8).add(off) as *mut Work<Self> };
> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {
> +            true => {}
> +            // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
> +            // workqueue.
> +            false => unsafe { core::hint::unreachable_unchecked() },
> +        }
> +    }
> +}
> +
> +// Let `Work<Pin<Box<T>>>` be usable with types that are `BoxWorkItem`.
> +//
> +// We do not allow unsized types here. The `Work<Pin<Box<T>>>` field should always specify the actual
> +// concrete type stored in the `Box`.
> +//
> +// SAFETY: The `Work<Pin<Box<T>>>` field must be initialized with this run method because the `Work`
> +// struct prevents you from initializing it in any other way. The `__enqueue` trait uses the
> +// same `Work<Pin<Box<T>>>` field because `HasWork` promises to always return the same field.
> +unsafe impl<T> WorkItemAdapter for Pin<Box<T>>
> +where
> +    T: BoxWorkItem + HasWork<Self> + Sized,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<Self>`.
> +        let ptr = ptr as *mut Work<Self>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +        let ptr = unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Box::into_raw` and we've been given back ownership.
> +        // The box was originally pinned, so pinning it again is ok.
> +        let boxed = unsafe { Pin::new_unchecked(Box::from_raw(ptr)) };
> +
> +        boxed.run();
> +    }
> +}
> +
> +/// Helper macro for structs with several `Work` fields that can be in several queues at once.
> +///
> +/// For each `Work` field in your type `T`, a newtype struct that wraps an `Arc<T>` or
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
> +/// This will let you push a `MyStructWork1(arc)` or `MyStructWork2(arc)` to a work queue. The [`Arc`]
> +/// can be in two work queues at the same time, and the `run` method on the wrapper type is called
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
> +    ) => {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub $crate::sync::Arc<$inner>);
> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput = ::core::result::Result<(), $name>;
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struct) -> bool,
> +            {
> +                let ptr = $crate::sync::Arc::into_raw(self.0);
> +
> +                // SAFETY: The pointer is not dangling since we just got it from Arc::into_raw.
> +                let work_ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::raw_get_work(ptr.cast_mut()) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr = unsafe { $crate::workqueue::Work::raw_get(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {
> +                    true => Ok(()),
> +                    // SAFETY: The work queue has not taken ownership of the pointer.
> +                    false => Err($name(unsafe { $crate::sync::Arc::from_raw(ptr) })),
> +                }
> +            }
> +        }
> +
> +        unsafe impl $crate::workqueue::WorkItemAdapter for $name {
> +            unsafe extern "C" fn run(ptr: *mut $crate::bindings::work_struct) {
> +                // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<Self>`.
> +                let ptr = ptr as *mut $crate::workqueue::Work<Self>;
> +                // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +                let ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::work_container_of(ptr) };
> +                // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
> +                let arc = unsafe { $crate::sync::Arc::from_raw(ptr) };
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
> +    ) => {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub ::core::pin::Pin<::alloc::boxed::Box<$inner>>);
> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput = ();
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F)
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struct) -> bool,
> +            {
> +                // SAFETY: We will not used the contents in an unpinned manner.
> +                let boxed = unsafe { ::core::pin::Pin::into_inner_unchecked(self.0) };
> +                let ptr = ::alloc::boxed::Box::into_raw(boxed);
> +
> +                // SAFETY: The pointer is not dangling since we just got it from Box::into_raw.
> +                let work_ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::raw_get_work(ptr) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr = unsafe { $crate::workqueue::Work::raw_get(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {
> +                    true => {},
> +                    // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
> +                    // workqueue.
> +                    false => unsafe { ::core::hint::unreachable_unchecked() },
> +                }
> +            }
> +        }
> +
> +        unsafe impl $crate::workqueue::WorkItemAdapter for $name {
> +            unsafe extern "C" fn run(ptr: *mut $crate::bindings::work_struct) {
> +                // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<Self>`.
> +                let ptr = ptr as *mut $crate::workqueue::Work<Self>;
> +                // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +                let ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::work_container_of(ptr) };
> +                // SAFETY: This pointer comes from `Box::into_raw` and we've been given back ownership.
> +                let boxed = unsafe { ::alloc::boxed::Box::from_raw(ptr) };
> +                // SAFETY: The box was originally pinned, so pinning it again is ok.
> +                let boxed = unsafe { ::core::pin::Pin::new_unchecked(boxed) };
> +
> +                $name::run($name(boxed));
> +            }
> +        }
> +
> +        define_work_adapter_newtype! { $($rest)* }
> +    };
> +
> +    // After processing the last definition, we call ourselves with no input.
> +    () => {};
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

