Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7472B2AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjFKP7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:59:35 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BC97
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 08:59:29 -0700 (PDT)
Date:   Sun, 11 Jun 2023 15:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=wmlujuurajbc3egzps3vipkzli.protonmail; t=1686499167; x=1686758367;
        bh=P0V24vQn1YV8txyfTySFTO+LOFAiJb5KfxOfX58FwRM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=IoxRDFIHJAripk0eQmVAI0CsBQJEUrcA6dFafoS8MqcR32TJjIQNmdCgXhq0oLtq3
         sRTIcGyHh+aQj9SSmGmtj4KQl8k1hnFVa0M8oOHgTCUSAl3Yrkf8J+GdXCsYFylo84
         KTSjnix852EJC5JGtnzeool0Wpp0UlsWrjn8QVEk1/EFl/BNuLi0GsZUca/RvUPkR0
         gHEzDGWPqVA3e9/AN7zyNtFQpZ9W0/+7eyGrHuYhjXaarTqORFY/g/Sdj0vkT8IJ+f
         jYURHO6DOAiN418ROkT84ws7AXTYcdZWcR+lqwmfqi1mfA2ON3zVU/vCjSc0adzktA
         cMXZqxl0i1VgQ==
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
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining work_struct fields
Message-ID: <sEZfLlqyui7bU5IsD7mRZq4wIsJqQ5ZZj4qtp6oq-d8rEu4Gx1rp6MXwxTsZt4zEaO7V-5HtmmULgwpVArU4DW-9UcZsjWYg0a5pojvAlVQ=@proton.me>
In-Reply-To: <20230601134946.3887870-6-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com> <20230601134946.3887870-6-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:49, Alice Ryhl wrote:
> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
>=20
> There are three important pieces that are relevant when doing this:
>=20
>   * The pointer type.
>   * The work item struct. This is what the pointer points at.
>   * The `work_struct` field. This is a field of the work item struct.
>=20
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
>=20
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
>=20
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
>=20
> ```
> struct MyWorkItem {
>      work_field: Work<MyWorkItem, 1>,
> }
>=20
> impl_has_work! {
>      impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
>=20
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
>=20
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I really like this new design! It splits the relevant components in a much
more natural way and is easier to understand. I added some comments below,
they only affect documentation though.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/helpers.c           |   8 ++
>   rust/kernel/workqueue.rs | 219 ++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 226 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..7f0c2fe2fbeb 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/sched/signal.h>
>   #include <linux/wait.h>
> +#include <linux/workqueue.h>
>=20
>   __noreturn void rust_helper_BUG(void)
>   {
> @@ -128,6 +129,13 @@ void rust_helper_put_task_struct(struct task_struct =
*t)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>=20
> +void rust_helper___INIT_WORK(struct work_struct *work, work_func_t func,
> +=09=09=09     bool on_stack)
> +{
> +=09__INIT_WORK(work, func, on_stack);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___INIT_WORK);
> +
>   /*
>    * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t`=
 type
>    * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index e37820f253f6..dbf0aab29a85 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -2,9 +2,34 @@
>=20
>   //! Work queues.
>   //!
> +//! This file has two components: The raw work item API, and the safe wo=
rk item API.
> +//!
> +//! One pattern that is used in both APIs is the `ID` const generic, whi=
ch exists to allow a single
> +//! type to define multiple `work_struct` fields. This is done by choosi=
ng an id for each field,
> +//! and using that id to specify which field you wish to use. (The actua=
l value doesn't matter, as
> +//! long as you use different values for different fields of the same st=
ruct.) Since these IDs are
> +//! generic, they are used only at compile-time, so they shouldn't exist=
 in the final binary.
> +//!
> +//! # The raw API
> +//!
> +//! The raw API consists of the `RawWorkItem` trait, where the work item=
 needs to provide an
> +//! arbitrary function that knows how to enqueue the work item. It shoul=
d usually not be used
> +//! directly, but if you want to, you can use it without using the piece=
s from the safe API.
> +//!
> +//! # The safe API
> +//!
> +//! The safe API is used via the `Work` struct and `WorkItem` traits. Fu=
rthermore, it also includes
> +//! a trait called `WorkItemPointer`, which is usually not used directly=
 by the user.
> +//!
> +//!  * The `Work` struct is the Rust wrapper for the C `work_struct` typ=
e.
> +//!  * The `WorkItem` trait is implemented for structs that can be enque=
ued to a workqueue.
> +//!  * The `WorkItemPointer` trait is implemented for the pointer type t=
hat points at a something
> +//!    that implements `WorkItem`.
> +//!
>   //! C header: [`include/linux/workqueue.h`](../../../../include/linux/w=
orkqueue.h)
>=20
> -use crate::{bindings, types::Opaque};
> +use crate::{bindings, prelude::*, types::Opaque};
> +use core::marker::{PhantomData, PhantomPinned};
>=20
>   /// A kernel work queue.
>   ///
> @@ -106,6 +131,198 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> S=
elf::EnqueueOutput
>           F: FnOnce(*mut bindings::work_struct) -> bool;
>   }
>=20
> +/// Defines the method that should be called directly when a work item i=
s executed.
> +///
> +/// Typically you would implement [`WorkItem`] instead. The `run` method=
 on this trait will
> +/// usually just perform the appropriate `container_of` translation and =
then call into the `run`
> +/// method from the [`WorkItem`] trait.

I think it makes sense to say that `Pin<Box<T>>` and `Arc<T>` implement
this trait (adding the comment in the next commit). Just to make it less
likely that people try to implement this trait instead of WorkItem. Also,
you could mention that this trait is meant for smart pointers.

> +///
> +/// This trait is used when the `work_struct` field is defined using the=
 [`Work`] helper.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that [`__enqueue`] uses a `work_struct` ini=
tialized with the [`run`]
> +/// method of this trait as the function pointer.
> +///
> +/// [`__enqueue`]: RawWorkItem::__enqueue
> +/// [`run`]: WorkItemPointer::run
> +pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
> +    /// Run this work item.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided `work_struct` pointer must originate from a previou=
s call to `__enqueue` where
> +    /// the `queue_work_on` closure returned true, and the pointer must =
still be valid.
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
> +}
> +
> +/// Defines the method that should be called when this work item is exec=
uted.
> +///
> +/// This trait is used when the `work_struct` field is defined using the=
 [`Work`] helper.
> +pub trait WorkItem<const ID: u64 =3D 0> {
> +    /// The pointer type that this struct is wrapped in. This will typic=
ally be `Arc<Self>` or
> +    /// `Pin<Box<Self>>`.
> +    type Pointer: WorkItemPointer<ID>;
> +
> +    /// The method that should be called when this work item is executed=
.
> +    fn run(this: Self::Pointer);
> +}
> +
> +/// Links for a work item.
> +///
> +/// This struct contains a function pointer to the `run` function from t=
he [`WorkItemPointer`]
> +/// trait, and defines the linked list pointers necessary to enqueue a w=
ork item in a workqueue.
> +///
> +/// Wraps the kernel's C `struct work_struct`.
> +///
> +/// This is a helper type used to associate a `work_struct` with the [`W=
orkItem`] that uses it.
> +#[repr(transparent)]
> +pub struct Work<T: ?Sized, const ID: u64 =3D 0> {
> +    work: Opaque<bindings::work_struct>,
> +    _pin: PhantomPinned,
> +    _inner: PhantomData<T>,
> +}
> +
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually=
 contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Send for Work<T, ID> {}
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually=
 contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
> +
> +impl<T: ?Sized, const ID: u64> Work<T, ID> {
> +    /// Creates a new instance of [`Work`].
> +    #[inline]
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: WorkItem<ID>,
> +    {
> +        // SAFETY: The `WorkItemPointer` implementation promises that `r=
un` can be used as the work
> +        // item function.
> +        unsafe {
> +            kernel::init::pin_init_from_closure(move |slot| {
> +                bindings::__INIT_WORK(Self::raw_get(slot), Some(T::Point=
er::run), false);
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Get a pointer to the inner `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must not be dangling and must be properly a=
ligned. (But the memory
> +    /// need not be initialized.)
> +    #[inline]
> +    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struc=
t {
> +        // SAFETY: The caller promises that the pointer is aligned and n=
ot dangling.
> +        //
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`=
. We use `addr_of!` so that
> +        // the compiler does not complain that the `work` field is unuse=
d.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +    }
> +}
> +
> +/// Declares that a type has a [`Work<T, ID>`] field.
> +///

Please mention the macro here as well, maybe also copy the example
from the commit message into this section.

> +/// # Safety
> +///
> +/// The [`OFFSET`] constant must be the offset of a field in Self of typ=
e [`Work<T, ID>`]. The methods on
> +/// this trait must have exactly the behavior that the definitions given=
 below have.

I think you should just say "implementers are not allowed to implement
the functions defined by this trait." I see no reason to allow that, since
all functions are fully determined by the `OFFSET` constant.

--=20
Cheers,
Benno

> +///
> +/// [`Work<T, ID>`]: Work
> +/// [`OFFSET`]: HasWork::OFFSET
> +pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
> +    /// The offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    const OFFSET: usize;
> +
> +    /// Returns the offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// This method exists because the [`OFFSET`] constant cannot be acc=
essed if the type is not Sized.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    /// [`OFFSET`]: HasWork::OFFSET
> +    #[inline]
> +    fn get_work_offset(&self) -> usize {
> +        Self::OFFSET
> +    }
> +
> +    /// Returns a pointer to the [`Work<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`=
.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> =
}
> +    }
> +
> +    /// Returns a pointer to the struct containing the [`Work<T, ID>`] f=
ield.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must point at a [`Work<T, ID>`] field in a struct of=
 type `Self`.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: The caller promises that the pointer points at a fiel=
d of the right type in the
> +        // right kind of struct.
> +        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> +    }
> +}
> +
> +/// Used to safely implement the [`HasWork<T, ID>`] trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct MyStruct {
> +///     work_field: Work<MyStruct, 17>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
> +/// }
> +/// ```
> +///
> +/// [`HasWork<T, ID>`]: HasWork
> +#[macro_export]
> +macro_rules! impl_has_work {
> +    ($(impl$(<$($implarg:ident),*>)?
> +       HasWork<$work_type:ty $(, $id:tt)?>
> +       for $self:ident $(<$($selfarg:ident),*>)?
> +       { self.$field:ident }
> +    )*) =3D> {$(
> +        // SAFETY: The implementation of `raw_get_work` only compiles if=
 the field has the right
> +        // type.
> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_=
type $(, $id)?> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize =3D $crate::offset_of!(Self, $field) as =
usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workq=
ueue::Work<$work_type $(, $id)?> {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                }
> +            }
> +        }
> +    )*};
> +}
> +
>   /// Returns the system work queue (`system_wq`).
>   ///
>   /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU m=
ulti-threaded. There are
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>=20

