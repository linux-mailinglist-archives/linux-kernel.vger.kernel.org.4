Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B706BCB23
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCPJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCPJif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:38:35 -0400
X-Greylist: delayed 260 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 02:38:31 PDT
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB54661317;
        Thu, 16 Mar 2023 02:38:31 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1678959509; x=1679218709;
        bh=3ItQtb131mD8/QA9wJD/+b/M+prM/3Xc35Itpml+3oo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=NHIglkGvKNzgbfJW7oLmL0h5Yu0x3CSXd1OtvPMKSbb0Fo5x8Ccwl9oL/nyAeukP+
         EeRrAVUP73pTWq+8+MZ8x7y8eouyBT9eVjVDag7AO1tq9gOwnt284/gUrOtWgyQMXT
         lia8kXCbheNqkTc8//6ftd3kgBAw70Y6HnzGS0Y4tJT6Noc4C0OPawC94DhRGREghM
         wQGUHDUm+iv54HdtbjuboeKa6D5rjfFaJF2UfmnTePB8JDyC1B9YAFSqIwhl2FMjai
         2RwUDsHGjs7a8FgBAsw3sSnHrTztmWFR1y+XMuuPB8OZW+WBNqxAdmqdHQ1nDYEdyA
         q1/KP51Mpu0rg==
To:     Gary Guo <gary@garyguo.net>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     "ojeda@kernel.org" <ojeda@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v1 2/3] rust: add pin-init API
Message-ID: <ct76zcR4JhAXHG90VDfewAmzPJmEHhMvvOf-MejsM_uZsdcsBs9qVLJNYvNvTHOBLlOedgQ4Dm16M2DSDRBIF-olZfq2zp4XboRsCxsm3CA=@protonmail.com>
In-Reply-To: <20230315200722.57487341.gary@garyguo.net>
References: <D0mWM1KEcWLeFa7IIqPygHlXRTD6gRFHvJKaegYzQXo9zTx7YbSpVLeYLFfq53s2S30Wx7v0khkPMOy6Ng5HiNZ5x7TXtOyLB58vUHtq6ro=@protonmail.com> <20230315200722.57487341.gary@garyguo.net>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 15th, 2023 at 21:07, Gary Guo <gary@garyguo.net> wrote:
> On Mon, 13 Mar 2023 01:23:52 +0000
> y86-dev <y86-dev@protonmail.com> wrote:
>
> > +
> > +#[macro_export]
> > +macro_rules! pin_init {
> > +    ($(&$this:ident in)? $t:ident $(<$($generics:ty),* $(,)?>)? {
>
> For this part here, I would suggest the syntax to be
>
> $t:ident $(:: <$($generics:ty),* $(,)?>)
>
> so that it's compatible with struct expression syntax.

Sure.

> > +    (init_slot:
> > +        @typ($ty:ty),
> > +        @slot($slot:ident),
> > +        // In-place initialization syntax.
> > +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> > +    ) =3D> {
> > +        let $field =3D $val;
> > +        // Call the initializer.
> > +        //
> > +        // SAFETY: `slot` is valid, because we are inside of an initia=
lizer closure, we
> > +        // return when an error/panic occurs.
> > +        // We also use the `__PinData` to request the correct trait (`=
Init` or `PinInit`).
> > +        unsafe {
> > +            <$ty as $crate::init::__PinData>::__PinData::$field(
> > +                ::core::ptr::addr_of_mut!((*$slot).$field),
> > +                $field,
> > +            )?;
> > +        }
> > +        // Create the drop guard.
> > +        //
> > +        // SAFETY: We forget the guard later when initialization has s=
ucceeded.
> > +        let $field =3D unsafe {
> > +            $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$=
slot).$field))
> > +        };
> > +        // Only give access to `&DropGuard`, so it cannot be forgotten=
 via safe code.
> > +        let $field =3D &$field;
>
> Instead of shadowing, you can use lifetime extension of `let x =3D &v` pa=
ttern directly:
>
> let $field =3D &unsafe {
>     $crate::init::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$fiel=
d))
> };
>
> (same for the value init case and the `init!` macro)

Sure.

> > +
> > +        $crate::try_pin_init!(init_slot:
> > +            @typ($ty),
> > +            @slot($slot),
> > +            @munch_fields($($rest)*),
> > +        );
> > +    };
> > +    (init_slot:
> > +        @typ($ty:ty),
> > +        @slot($slot:ident),
> > +        // Direct value init, this is safe for every field.
> > +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> > +    ) =3D> {
> > +        $(let $field =3D $val;)?
> > +        // Call the initializer.
> > +        //
> > +        // SAFETY: The memory at `slot` is uninitialized.
> > +        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot)=
.$field), $field) };
>
> Could this be
>
> unsafe { ::core::ptr::addr_of_mut!((*$slot).$field).write($field) };

Sure.

> ? Not sure if this has any implication on type inference though.

It should not.

> > +
> > +/// Trait facilitating pinned destruction.
> > +///
> > +/// Use [`pinned_drop`] to implement this trait safely:
> > +///
> > +/// ```rust
> > +/// # use kernel::sync::Mutex;
> > +/// use kernel::macros::pinned_drop;
> > +/// use core::pin::Pin;
> > +/// #[pin_data(PinnedDrop)]
> > +/// struct Foo {
> > +///     #[pin]
> > +///     mtx: Mutex<usize>,
> > +/// }
> > +///
> > +/// #[pinned_drop]
> > +/// impl PinnedDrop for Foo {
> > +///     fn drop(self: Pin<&mut Self>) {
> > +///         pr_info!("Foo is being dropped!");
> > +///     }
> > +/// }
> > +/// ```
> > +///
> > +/// # Safety
> > +///
> > +/// This trait must be implemented with [`pinned_drop`].
> > +///
> > +/// [`pinned_drop`]: kernel::macros::pinned_drop
> > +pub unsafe trait PinnedDrop: __PinData {
> > +    /// Executes the pinned destructor of this type.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Only call this from `<Self as Drop>::drop`.
> > +    unsafe fn drop(self: Pin<&mut Self>);
> > +
> > +    // Used by the `pinned_drop` proc-macro to ensure that only safe o=
perations are used in `drop`.
> > +    // the function should not be called.
> > +    #[doc(hidden)]
> > +    fn __ensure_no_unsafe_op_in_drop(self: Pin<&mut Self>);
>
> One idea to avoid this extra function is to have an unsafe token to the
> drop function.
>
> fn drop(self: Pin<&mut Self>, token: TokenThatCanOnlyBeCreatedUnsafely);

What is wrong with having this extra function? If the problem is that this
function might be called, then we could add a parameter with an
unconstructable type.

I think that `drop` should be `unsafe`, since it really does have
the requirement of only being called in the normal drop impl.

> > +}
> > +
> > +/// Smart pointer that can initialize memory in-place.
> > +pub trait InPlaceInit<T>: Sized {
> > +    /// Use the given initializer to in-place initialize a `T`.
> > +    ///
> > +    /// If `T: !Unpin` it will not be able to move afterwards.
> > +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self=
>>
> > +    where
> > +        Error: From<E>;
> > +
> > +    /// Use the given initializer to in-place initialize a `T`.
> > +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> > +    where
> > +        Error: From<E>;
> > +}
>
> Is this trait used? Or the methods could be inherent methods?

I need an extension trait for `Box`, since it is inside of the `alloc`
crate and so I figured that I might as well use it for other types. I do
not think we can avoid the extension trait for `Box`, but I could make the
functions for `UniqueArc` inherent. What do you think?

> > +/// An initializer that leaves the memory uninitialized.
> > +///
> > +/// The initializer is a no-op. The `slot` memory is not changed.
> > +#[inline]
> > +pub fn uninit<T>() -> impl Init<MaybeUninit<T>> {
> > +    // SAFETY: The memory is allowed to be uninitialized.
> > +    unsafe { init_from_closure(|_| Ok(())) }
> > +}
>
> Do you think there's a value to have a `Uninitable` which is
> implemented for both `MaybeUninit` and `Opaque`?

If we really need it for `Opaque`, then it probably should be an inherent
function. I do not really see additional use for an `Uninitable` trait.

> > +
> > +/// Convert a value into an initializer.
> > +///
> > +/// Directly moves the value into the given `slot`.
> > +///
> > +/// Note that you can just write `field: value,` in all initializer ma=
cros. This function's purpose
> > +/// is to provide compatibility with APIs that only have `PinInit`/`In=
it` as parameters.
> > +#[inline]
> > +pub fn from_value<T>(value: T) -> impl Init<T> {
>
> How about `unsafe impl<T> Init<T> for T`?

That should work, was worried about inference issues, but I tried it and
found none. I will change it.

> > +macro_rules! impl_zeroable {
> > +    ($($t:ty),*) =3D> {
> > +        $(unsafe impl Zeroable for $t {})*
> > +    };
> > +}
>
> I personally would do ($($t:ty,)*) and then we can have
>
> impl_zeroable!(
>     // SAFETY: All primitives that are allowed to be zero.
>     bool,
>     char,
>     u8, u16, u32, u64, u128, usize,
>     i8, i16, i32, i64, i128, isize,
>     f32, f64,
>     // SAFETY: There is nothing to zero.
>     core::marker::PhantomPinned, Infallible, (),
>     ......
> );

Sure.

> > +// SAFETY: All primitives that are allowed to be zero.
> > +impl_zeroable!(
> > +    bool, char, u8, u16, u32, u64, u128, usize, i8, i16, i32, i64, i12=
8, isize, f32, f64
> > +);
> > +// SAFETY: There is nothing to zero.
> > +impl_zeroable!(core::marker::PhantomPinned, Infallible, ());
> > +
> > +// SAFETY: We are allowed to zero padding bytes.
> > +unsafe impl<const N: usize, T: Zeroable> Zeroable for [T; N] {}
> > +
> > +// SAFETY: There is nothing to zero.
> > +unsafe impl<T: ?Sized> Zeroable for PhantomData<T> {}
> > +
> > +// SAFETY: `null` pointer is valid.
> > +unsafe impl<T: ?Sized> Zeroable for *mut T {}
> > +unsafe impl<T: ?Sized> Zeroable for *const T {}
> > +
> > +macro_rules! impl_tuple_zeroable {
> > +    ($(,)?) =3D> {};
> > +    ($first:ident, $($t:ident),* $(,)?) =3D> {
> > +        // SAFETY: All elements are zeroable and padding can be zero.
> > +        unsafe impl<$first: Zeroable, $($t: Zeroable),*> Zeroable for =
($first, $($t),*) {}
> > +        impl_tuple_zeroable!($($t),* ,);
> > +    }
> > +}
> > +
> > +impl_tuple_zeroable!(A, B, C, D, E, F, G, H, I, J);
> > +
> > +// This trait is only implemented via the `#[pin_data]` proc-macro. It=
 is used to facilitate
> > +// the pin projections within the initializers.
> > +#[doc(hidden)]
> > +pub unsafe trait __PinData {
> > +    type __PinData;
> > +}
> > +
> > +/// Stack initializer helper type. Use [`stack_pin_init`] instead of t=
his primitive.
>
> `#[doc(hidden)]`?

This trait is implementation detail of the `#[pin_data]` macro. Why should
it be visible in the rust-docs?

> > diff --git a/rust/kernel/init/common.rs b/rust/kernel/init/common.rs
> > new file mode 100644
> > index 000000000000..f8c6e9dff786
> > --- /dev/null
> > +++ b/rust/kernel/init/common.rs
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: Apache-2.0 OR MIT
> > +
> > +//! Module containing common kernel initializer functions.
> > +
> > +use crate::{
> > +    init::{self, PinInit},
> > +    types::Opaque,
> > +};
> > +
> > +macro_rules! create_func {
> > +    ($name:ident $(, $arg_name:ident: $arg_typ:ident)*) =3D> {
> > +        /// Create an initializer using the given initializer function=
 from C.
> > +        ///
> > +        /// # Safety
> > +        ///
> > +        /// The given function **must** under all circumstances initia=
lize the memory location to a
> > +        /// valid `T`. If it fails to do so it results in UB.
> > +        ///
> > +        /// If any parameters are given, those need to be valid for th=
e function. Valid means that
> > +        /// calling the function with those parameters complies with t=
he above requirement **and**
> > +        /// every other requirement on the function itself.
> > +        pub unsafe fn $name<T $(, $arg_typ)*>(
> > +            init_func: unsafe extern "C" fn(*mut T $(, $arg_name: $arg=
_typ)*),
> > +            $($arg_name: $arg_typ,)*
> > +        ) -> impl PinInit<Opaque<T>> {
> > +            // SAFETY: The safety contract of this function ensures th=
at `init_func` fully
> > +            // initializes `slot`.
> > +            unsafe {
> > +                init::pin_init_from_closure(move |slot| {
> > +                    init_func(Opaque::raw_get(slot) $(, $arg_name)*);
> > +                    Ok(())
> > +                })
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +create_func!(ffi_init);
> > +create_func!(ffi_init1, arg1: A1);
> > +create_func!(ffi_init2, arg1: A1, arg2: A2);
> > +create_func!(ffi_init3, arg1: A1, arg2: A2, arg3: A3);
> > +create_func!(ffi_init4, arg1: A1, arg2: A2, arg3: A3, arg4: A4);
>
> This part can be a separate commit (or perhaps in a separate patch
> series when it's being used).

Will make a separate commit, since the sync module will use it.

> > diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> > index f2f1c83d72ba..5b4f64dd3ac8 100644
> > --- a/rust/kernel/sync/arc.rs
> > +++ b/rust/kernel/sync/arc.rs
> > @@ -17,7 +17,8 @@
> >
> >  use crate::{
> >      bindings,
> > -    error::Result,
> > +    error::{Error, Result},
> > +    init::{InPlaceInit, Init, PinInit},
> >      types::{ForeignOwnable, Opaque},
> >  };
> >  use alloc::boxed::Box;
> > @@ -163,6 +164,28 @@ impl<T> Arc<T> {
> >          // `Arc` object.
> >          Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
> >      }
> > +
> > +    /// Use the given initializer to in-place initialize a `T`.
> > +    ///
> > +    /// If `T: !Unpin` it will not be able to move afterwards.
> > +    #[inline]
> > +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
> > +    where
> > +        Error: From<E>,
> > +    {
> > +        UniqueArc::pin_init(init).map(|u| u.into())
> > +    }
> > +
> > +    /// Use the given initializer to in-place initialize a `T`.
> > +    ///
> > +    /// This is equivalent to [`pin_init`], since an `Arc` is always p=
inned.
> > +    #[inline]
> > +    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
> > +    where
> > +        Error: From<E>,
> > +    {
> > +        UniqueArc::init(init).map(|u| u.into())
> > +    }
> >  }
> >
> >  impl<T: ?Sized> Arc<T> {
> > @@ -489,6 +512,17 @@ impl<T> UniqueArc<MaybeUninit<T>> {
> >      /// Converts a `UniqueArc<MaybeUninit<T>>` into a `UniqueArc<T>` b=
y writing a value into it.
> >      pub fn write(mut self, value: T) -> UniqueArc<T> {
> >          self.deref_mut().write(value);
> > +        // SAFETY: We just wrote the value to be initialized.
> > +        unsafe { self.assume_init() }
> > +    }
> > +
> > +    /// Unsafely assume that `self` is initialized.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller guarantees that the value behind this pointer has b=
een initialized. It is
> > +    /// *immediate* UB to call this when the value is not initialized.
> > +    pub unsafe fn assume_init(self) -> UniqueArc<T> {
>
> This part should be a separate commit.

Sure.

> >          let inner =3D ManuallyDrop::new(self).inner.ptr;
> >          UniqueArc {
> >              // SAFETY: The new `Arc` is taking over `ptr` from `self.i=
nner` (which won't be
>
> Best,
> Gary

Cheers,
Benno
