Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0984670F91E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjEXOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjEXOuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:50:20 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327E18E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:50:14 -0700 (PDT)
Date:   Wed, 24 May 2023 14:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1684939812; x=1685199012;
        bh=Uvc2bcYwiMlahenIY7l4o0VGT4i24GCjMIrVGHDELeY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Bk5EjfvOu0pT3HtUjfr1Ug63XLOZwdQKBlT0Yn6DltxYf86NZv9+jAJAYyeI+vr2i
         UOmChowcpv8JxFms1zj97zbKYTZZXcRYeJVY50yvw5qVTfPXoM3BcYd+Q4Xj+xhSVS
         FHPnSlyNM4JDnhcod5+OWxT2Re6VouYC86+4uBvbW0l5lNZPhA57QNuylCp9HDCXv/
         Qc8GVpoCuKRw7BWbD11s6sN0hJAIsIdjS3LwJTX2aTNwWVVC8GYc4q1LueMJYsS/af
         0tKSZz/s2wPebL1xRI7N+NASFE6SSleRPCJDeUe2ddx7lY/fED3Qf0DTXWYE5XsQ0H
         eaaBTCVSAzT+Q==
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
Subject: Re: [PATCH v1 5/7] rust: workqueue: add helper for defining work_struct fields
Message-ID: <XCPRRkwd2lV43Whaash8aIbntiiHuWHtbQgqd11Z6RClSnZnSCHu3-76r1a7bNoM4MWjofINiyH2SSf6v06e1O3GMyeIF43X33OXLX5ltec=@proton.me>
In-Reply-To: <20230517203119.3160435-6-aliceryhl@google.com>
References: <20230517203119.3160435-1-aliceryhl@google.com> <20230517203119.3160435-6-aliceryhl@google.com>
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
> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
>=20
> There are three important pieces that are relevant when doing this. This
> commit will use traits so that they know about each other according to
> the following cycle:
>=20
>  * The pointer type. It knows the type of the work item struct.
>  * The work item struct. It knows the offset of its `work_struct` field.
>  * The `work_struct` field. It knows the pointer type.
>=20
> There's nothing special about making the pointer type know the type of
> the struct it points at. Pointers generally always know that
> information.
>=20
> However, making the `work_struct` field know about the pointer type is
> less commonly seen. This is done by using a generic parameter: the
> `work_struct` field will have the type `Work<T>`, where T will be the
> pointer type in use. The pointer type is required to implement the
> `WorkItemAdapter` trait, which defines the function pointer to store in
> the `work_struct` field. The `Work<T>` type guarantees that the
> `work_struct` inside it uses `<T as WorkItemAdapter>::run` as its
> function pointer.
>=20
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T>`. The trait is marked unsafe because
> the OFFSET constant must be correct, but we provide an `impl_has_work!`
> macro that can safely implement `HasWork<T>` on a type. The macro
> expands to something that only compiles if the specified field really
> has the type `Work<T>`. It is used like this:
>=20
> ```
> struct MyWorkItem {
>     work_field: Work<Arc<MyWorkItem>>,
> }
>=20
> impl_has_work! {
>     impl HasWork<Arc<MyWorkItem>> for MyWorkItem { self.work_field }
> }
> ```
>=20
> So to summarize, given a pointer to an allocation containing a work
> item, you can use the `HasWork<T>` trait to offset the pointer to the
> `work_struct` field. The function pointer in the `work_struct` field is
> guaranteed to be a function that knows what the original pointer type
> was, and using that information, it can undo the offset operation by
> looking up what the offset was via the `HasWork<T>` trait.
>=20
> This design supports work items with multiple `work_struct` fields by
> using different pointer types. For example, you might define structs
> like these:
>=20
> ```
> struct MyPointer1(Arc<MyWorkItem>);
> struct MyPointer2(Arc<MyWorkItem>);
>=20
> struct MyWorkItem {
>     work1: Work<MyPointer1>,
>     work2: Work<MyPointer2>,
> }
> ```
>=20
> Then, the wrapper structs `MyPointer1` and `MyPointer2` will take the
> role as the pointer type. By using one or the other, you tell the
> workqueue which `work_struct` field to use. This pattern is called the
> "newtype" pattern.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers.c           |   8 ++
>  rust/kernel/workqueue.rs | 183 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 190 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..7f0c2fe2fbeb 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>=20
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -128,6 +129,13 @@ void rust_helper_put_task_struct(struct task_struct =
*t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>=20
> +void rust_helper___INIT_WORK(struct work_struct *work, work_func_t func,
> +=09=09=09     bool on_stack)
> +{
> +=09__INIT_WORK(work, func, on_stack);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___INIT_WORK);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 22205d3bda72..7509618af252 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -4,7 +4,8 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/wo=
rkqueue.h)
>=20
> -use crate::{bindings, types::Opaque};
> +use crate::{bindings, prelude::*, types::Opaque};
> +use core::marker::{PhantomData, PhantomPinned};
>=20
>  /// A kernel work queue.
>  ///
> @@ -98,6 +99,186 @@ pub unsafe trait WorkItem {
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
>=20
> +/// Defines the method that should be called when a work item is execute=
d.
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
> +/// [`__enqueue`]: WorkItem::__enqueue
> +/// [`run`]: WorkItemAdapter::run
> +pub unsafe trait WorkItemAdapter: WorkItem {
> +    /// Run this work item.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must only be called via the function pointer that [`__enqueue`] =
provides to the
> +    /// `queue_work_on` closure, and only as described in the documentat=
ion of `queue_work_on`.
> +    ///
> +    /// [`__enqueue`]: WorkItem::__enqueue
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
> +}
> +
> +/// Links for a work item.
> +///
> +/// This struct contains a function pointer to the `T::run` function fro=
m the [`WorkItemAdapter`]
> +/// trait, and defines the linked list pointers necessary to enqueue a w=
ork item in a workqueue.
> +///
> +/// Wraps the kernel's C `struct work_struct`.
> +///
> +/// This is a helper type used to associate a `work_struct` with the [`W=
orkItemAdapter`] that uses
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
> +// We do not need to constrain `T` since the work item does not actually=
 contain a `T`.
> +unsafe impl<T: ?Sized> Send for Work<T> {}
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually=
 contain a `T`.
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
> +        // SAFETY: The `WorkItemAdapter` implementation promises that `T=
::run` can be used as the
> +        // work item function.
> +        unsafe {
> +            kernel::init::pin_init_from_closure(move |slot| {
> +                bindings::__INIT_WORK(Self::raw_get(slot), Some(T::run),=
 false);
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Get a pointer to the inner `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must not be dangling. (But it need not be i=
nitialized.)
> +    #[inline]
> +    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struc=
t {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        //
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`=
. We use `addr_of!` so that
> +        // the compiler does not complain that `work` is unused.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +    }
> +}
> +
> +/// Declares that a type has a [`Work<T>`] field.
> +///
> +/// # Safety
> +///
> +/// The [`OFFSET`] constant must be the offset of a field in Self of typ=
e [`Work<T>`]. The methods on
> +/// this trait must have exactly the behavior that the definitions given=
 below have.
> +///

I don't like this safety section, since the discharging safety comment
will just be "I implemented everything correctly" which for me is the same
as just writing no safety comment at all.

I am working on improving safety comments in general, so we can defer
improving this until I have come up with a good plan. (If you still want
to improve it, feel free to do so)

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
> +    /// This method exists because the [`OFFSET`] constant cannot be acc=
essed if the type is not Sized.
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
> +    /// The pointer must not be dangling. (But the memory need not be in=
itialized.)
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
> +    /// Returns a pointer to the struct containing the [`Work<T>`] field=
.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must not be dangling. (But the memory need not be in=
itialized.)

The pointer also must point to a `Work<T>` that is embedded at `OFFSET`
inside of `Self`.

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
> +    )*) =3D> {$(
> +        // SAFETY: The implementation of `raw_get_work` only compiles if=
 the field has the right
> +        // type.
> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_=
type> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize =3D $crate::offset_of!(Self, $field) as =
usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workq=
ueue::Work<$work_type> {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                }
> +            }
> +        }
> +    )*};
> +}

I don't really like the verbosity that this creates, but for the moment it
should be fine. When/if we get field projections, we can build a much
better proc-macro, so I think we can defer improving this until then.

> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU mu=
lti-threaded. There are
> --
> 2.40.1.606.ga4b1b128d6-goog
>

--
Cheers,
Benno
