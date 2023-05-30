Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00548715905
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjE3IuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjE3It6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:49:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10EB100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:49:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96fe88cd2fcso750591166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685436589; x=1688028589;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=sKvmcYNdw0/e/A3ebTbEuUOu5G8ColBz5GGjZ4+9ndk=;
        b=Vbdj6KueAzHTkZQx/3tFSDLBLrmoaxp+qeJQG9Yx46L/72isRnbTSayQMxXE5a2Qra
         a5zdb0QoE/fzNwQ4jnZxAlF4X5+jd5LL8Bkd+brSrDz1oAg8PECciFTFDYCCm5Hqb8x9
         LfIespmZFaroU1kKNOnHmWNBHeRPfN/v3ccMkLakbn3KtYdPO7TBKc/tUN+WjJrNNlIE
         Xg+4hf0POBYyhM/AHyHdLY4sC/7S9z1gWIujnWG6jHwFNciliYju7/bQ6wUNoeM9ecjw
         Wuhac5/GOYPEY0w4CVuK0+R3Ev8YfKxwV4PtTiuxsH0m1Oy7Bjw3XehRlxFwhZ1Jccrd
         nd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436589; x=1688028589;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKvmcYNdw0/e/A3ebTbEuUOu5G8ColBz5GGjZ4+9ndk=;
        b=La6n1zKfZQiK5bRUEK9eetv26QQcv0kWY36/pUTi5boyPQlF4K43dHAUgYbgk4i1QV
         H517bK5fehYsIVHTQ3fHuutVJjbpmdUVldiOsWJB9bA+jXr/0rRoGQDlmMhT6ZFheh82
         hO6boY/sUm0ARsH6EzJ4qvD3OdkHfFr3BSPoyPRG7hffx/AQKUTkZZT88ldk7Slbc+Lf
         bbryQF6cb5H2oBNIegNwrDGLY0OdiVOODDz/enD6zr6E9/0Ffvbxcbg5RV5GUZF7XbS4
         mXmzg7dfS/Fc9+Lt2mUWhBJ15JK9eLcTZHJr6SNkC5cH3kdVqik8fdbpR70MjxJOp4PM
         19+w==
X-Gm-Message-State: AC+VfDw6WTVO9wODFU5QcUQEw/0SO0T+/5usVL+53f3p81SnOu2qHAe2
        Auuc+Eotv5reoRD1AfTlOMAQZw==
X-Google-Smtp-Source: ACHHUZ7z3kEkvDHVP+7DvSK/H+8I5/Mb7V9cBL39bNad6iVtKtda2JsjDnstktVTcfupCl0tUR6XMA==
X-Received: by 2002:a17:907:7e94:b0:96f:a935:8998 with SMTP id qb20-20020a1709077e9400b0096fa9358998mr1738140ejc.39.1685436589164;
        Tue, 30 May 2023 01:49:49 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id uz16-20020a170907119000b00965a56f82absm7058798ejb.212.2023.05.30.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:49:48 -0700 (PDT)
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-6-aliceryhl@google.com>
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
Subject: Re: [PATCH v1 5/7] rust: workqueue: add helper for defining
 work_struct fields
Date:   Tue, 30 May 2023 10:44:19 +0200
In-reply-to: <20230517203119.3160435-6-aliceryhl@google.com>
Message-ID: <87leh69par.fsf@metaspace.dk>
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

> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
>
> There are three important pieces that are relevant when doing this. This
> commit will use traits so that they know about each other according to
> the following cycle:
>
>  * The pointer type. It knows the type of the work item struct.
>  * The work item struct. It knows the offset of its `work_struct` field.
>  * The `work_struct` field. It knows the pointer type.
>
> There's nothing special about making the pointer type know the type of
> the struct it points at. Pointers generally always know that
> information.
>
> However, making the `work_struct` field know about the pointer type is
> less commonly seen. This is done by using a generic parameter: the
> `work_struct` field will have the type `Work<T>`, where T will be the
> pointer type in use. The pointer type is required to implement the
> `WorkItemAdapter` trait, which defines the function pointer to store in
> the `work_struct` field. The `Work<T>` type guarantees that the
> `work_struct` inside it uses `<T as WorkItemAdapter>::run` as its
> function pointer.
>
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T>`. The trait is marked unsafe because
> the OFFSET constant must be correct, but we provide an `impl_has_work!`
> macro that can safely implement `HasWork<T>` on a type. The macro
> expands to something that only compiles if the specified field really
> has the type `Work<T>`. It is used like this:
>
> ```
> struct MyWorkItem {
>     work_field: Work<Arc<MyWorkItem>>,
> }
>
> impl_has_work! {
>     impl HasWork<Arc<MyWorkItem>> for MyWorkItem { self.work_field }
> }
> ```
>
> So to summarize, given a pointer to an allocation containing a work
> item, you can use the `HasWork<T>` trait to offset the pointer to the
> `work_struct` field. The function pointer in the `work_struct` field is
> guaranteed to be a function that knows what the original pointer type
> was, and using that information, it can undo the offset operation by
> looking up what the offset was via the `HasWork<T>` trait.
>
> This design supports work items with multiple `work_struct` fields by
> using different pointer types. For example, you might define structs
> like these:
>
> ```
> struct MyPointer1(Arc<MyWorkItem>);
> struct MyPointer2(Arc<MyWorkItem>);
>
> struct MyWorkItem {
>     work1: Work<MyPointer1>,
>     work2: Work<MyPointer2>,
> }
> ```
>
> Then, the wrapper structs `MyPointer1` and `MyPointer2` will take the
> role as the pointer type. By using one or the other, you tell the
> workqueue which `work_struct` field to use. This pattern is called the
> "newtype" pattern.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers.c           |   8 ++
>  rust/kernel/workqueue.rs | 183 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 190 insertions(+), 1 deletion(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..7f0c2fe2fbeb 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -128,6 +129,13 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +void rust_helper___INIT_WORK(struct work_struct *work, work_func_t func,
> +			     bool on_stack)
> +{
> +	__INIT_WORK(work, func, on_stack);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___INIT_WORK);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 22205d3bda72..7509618af252 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -4,7 +4,8 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
> -use crate::{bindings, types::Opaque};
> +use crate::{bindings, prelude::*, types::Opaque};
> +use core::marker::{PhantomData, PhantomPinned};
>  
>  /// A kernel work queue.
>  ///
> @@ -98,6 +99,186 @@ pub unsafe trait WorkItem {
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
>  
> +/// Defines the method that should be called when a work item is executed.
> +///
> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that [`__enqueue`] uses a `work_struct` initialized with the [`run`]
> +/// method of this trait as the function pointer.
> +///
> +/// [`__enqueue`]: WorkItem::__enqueue
> +/// [`run`]: WorkItemAdapter::run
> +pub unsafe trait WorkItemAdapter: WorkItem {
> +    /// Run this work item.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must only be called via the function pointer that [`__enqueue`] provides to the
> +    /// `queue_work_on` closure, and only as described in the documentation of `queue_work_on`.
> +    ///
> +    /// [`__enqueue`]: WorkItem::__enqueue
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
> +}
> +
> +/// Links for a work item.
> +///
> +/// This struct contains a function pointer to the `T::run` function from the [`WorkItemAdapter`]
> +/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
> +///
> +/// Wraps the kernel's C `struct work_struct`.
> +///
> +/// This is a helper type used to associate a `work_struct` with the [`WorkItemAdapter`] that uses
> +/// it.
> +#[repr(transparent)]
> +pub struct Work<T: ?Sized> {
> +    work: Opaque<bindings::work_struct>,
> +    _pin: PhantomPinned,
> +    _adapter: PhantomData<T>,
> +}
> +
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized> Send for Work<T> {}
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized> Sync for Work<T> {}
> +
> +impl<T: ?Sized> Work<T> {
> +    /// Creates a new instance of [`Work`].
> +    #[inline]
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: WorkItemAdapter,
> +    {
> +        // SAFETY: The `WorkItemAdapter` implementation promises that `T::run` can be used as the
> +        // work item function.
> +        unsafe {
> +            kernel::init::pin_init_from_closure(move |slot| {
> +                bindings::__INIT_WORK(Self::raw_get(slot), Some(T::run), false);
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Get a pointer to the inner `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must not be dangling. (But it need not be initialized.)
> +    #[inline]
> +    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        //
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
> +        // the compiler does not complain that `work` is unused.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +    }
> +}
> +
> +/// Declares that a type has a [`Work<T>`] field.
> +///
> +/// # Safety
> +///
> +/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T>`]. The methods on
> +/// this trait must have exactly the behavior that the definitions given below have.
> +///
> +/// [`Work<T>`]: Work
> +/// [`OFFSET`]: HasWork::OFFSET
> +pub unsafe trait HasWork<T> {
> +    /// The offset of the [`Work<T>`] field.
> +    ///
> +    /// [`Work<T>`]: Work
> +    const OFFSET: usize;
> +
> +    /// Returns the offset of the [`Work<T>`] field.
> +    ///
> +    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not Sized.
> +    ///
> +    /// [`Work<T>`]: Work
> +    /// [`OFFSET`]: HasWork::OFFSET
> +    #[inline]
> +    fn get_work_offset(&self) -> usize {
> +        Self::OFFSET
> +    }
> +
> +    /// Returns a pointer to the [`Work<T>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must not be dangling. (But the memory need not be initialized.)
> +    ///
> +    /// [`Work<T>`]: Work
> +    #[inline]
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T>
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: The caller promises that the pointer is not dangling.
> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T> }
> +    }
> +
> +    /// Returns a pointer to the struct containing the [`Work<T>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must not be dangling. (But the memory need not be initialized.)
> +    ///
> +    /// [`Work<T>`]: Work
> +    #[inline]
> +    unsafe fn work_container_of(ptr: *mut Work<T>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: The caller promises that the pointer is not dangling.
> +        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> +    }
> +}
> +
> +/// Used to safely implement the [`HasWork<T>`] trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct MyStruct {
> +///     work_field: Work<Arc<MyStruct>>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<Arc<MyStruct>> for MyStruct { self.work_field }
> +/// }
> +/// ```
> +///
> +/// [`HasWork<T>`]: HasWork
> +#[macro_export]
> +macro_rules! impl_has_work {
> +    ($(impl$(<$($implarg:ident),*>)?
> +       HasWork<$work_type:ty>
> +       for $self:ident $(<$($selfarg:ident),*>)?
> +       { self.$field:ident }
> +    )*) => {$(
> +        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
> +        // type.
> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize = $crate::offset_of!(Self, $field) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type> {
> +                // SAFETY: The caller promises that the pointer is not dangling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                }
> +            }

What is the reason for overriding the default implementation of `raw_get_work()`?

BR Andreas

> +        }
> +    )*};
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

