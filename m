Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522C6D2050
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjCaMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCaMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:31:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D811EFD3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:31:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n19so12799953wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680265913;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6BWVHcqR1MbaxWbwHH9zzhlC4JQ/IKhvWCHiA/FEDTA=;
        b=7n2P5zBfCez8hc9EKwdB5ecxo8xhvd3O44ce/jvq9B46hBW0m0dyjMjNt3Z4ozCqDS
         cG2XJ1wXadNiwYDKh264meqrDu+eQlKZKRSXAsjzu3Wjn8sJ9tbsjhDQwC6a3dTEIy2S
         ccTRFi+MeqkSgZWpjcdWnAmIGCl+rrMAPiaeetmXo76FWKUZB0XSpvErRekg4zVZPdk3
         Eah1A1l0BofMBHkrWmEAAvSih5NXP2YzJP4NcAmsNjjRbDSssFeJfZxK46aN4qLfJ5bi
         GXI26FKsQbIOyf6y1aEsgUH9Dk5zyYdaZHrn69qGlBN31COVp1yoyaFwn/ay+WdSAM+9
         KhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265913;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BWVHcqR1MbaxWbwHH9zzhlC4JQ/IKhvWCHiA/FEDTA=;
        b=SJ3MkDLF1tvkVVG2h2Z6+cH6G+HwfSBBDGhsPUu2tGDN0j3ypglnU3IqwwrDIxoHI/
         cUDH5MbRxNxQwLHeRf4um3UnKJbrs5vFcU5K23YOHx+55KB6Qeu9pcuJK7BXNkCe4ZOS
         UPN0iahfWQ6OYYBem7Jn9axZImcr+7IUrB48obp8VN0FwWC+vg71/0cLyWeKQNSszbQU
         9xH5f4wYNumBaic/TtPk+U1bOFvBM0bTuZG4Xa0EZykuItVX8eCbO2xc8bp+i1swYZ7k
         wOTfjVT1qeweuqV7fyiXdckPIgHnh3iB82lHPs/kzJevixJPn8QN89ostPtv+mnInEKp
         CXhQ==
X-Gm-Message-State: AAQBX9dy6hy69OPpBs4vxiM/mjp3ijtVe+GmYZnyto/zJqc6SPSshOkF
        H+ULO2IgjghSxWSUDtkpYKRR5Q==
X-Google-Smtp-Source: AKy350Y6EjNK8S8KFtaFaiPTfvWfENmcqdr87ZBmohuX7u/YajXY2CEHLXniEGXnJcEsgizwVI7kIg==
X-Received: by 2002:a7b:c8c5:0:b0:3ef:62cd:1ef with SMTP id f5-20020a7bc8c5000000b003ef62cd01efmr16295236wml.25.1680265912771;
        Fri, 31 Mar 2023 05:31:52 -0700 (PDT)
Received: from localhost ([165.225.195.122])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003e203681b26sm2538233wme.29.2023.03.31.05.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 05:31:52 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-8-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v3 07/13] rust: init: add `PinnedDrop` trait and macros
Date:   Fri, 31 Mar 2023 14:31:06 +0200
In-reply-to: <20230329223239.138757-8-y86-dev@protonmail.com>
Message-ID: <87jzyx2jbc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


y86-dev@protonmail.com writes:

> From: Benno Lossin <y86-dev@protonmail.com>
>
> The `PinnedDrop` trait that facilitates destruction of pinned types.
> It has to be implemented via the `#[pinned_drop]` macro, since the
> `drop` function should not be called by normal code, only by other
> destructors. It also only works on structs that are annotated with
> `#[pin_data(PinnedDrop)]`.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


>  rust/kernel/init.rs            | 111 ++++++++++++++
>  rust/kernel/init/__internal.rs |  15 ++
>  rust/kernel/init/macros.rs     | 263 +++++++++++++++++++++++++++++++++
>  rust/macros/lib.rs             |  49 ++++++
>  rust/macros/pinned_drop.rs     |  49 ++++++
>  5 files changed, 487 insertions(+)
>  create mode 100644 rust/macros/pinned_drop.rs
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 3d89c7e3bdb5..428b5c2ac516 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -104,6 +104,78 @@
>  //! }
>  //! ```
>  //!
> +//! ## Manual creation of an initializer
> +//!
> +//! Often when working with primitives the previous approaches are not sufficient. That is where
> +//! [`pin_init_from_closure()`] comes in. This `unsafe` function allows you to create a
> +//! [`impl PinInit<T, E>`] directly from a closure. Of course you have to ensure that the closure
> +//! actually does the initialization in the correct way. Here are the things to look out for
> +//! (we are calling the parameter to the closure `slot`):
> +//! - when the closure returns `Ok(())`, then it has completed the initialization successfully, so
> +//!   `slot` now contains a valid bit pattern for the type `T`,
> +//! - when the closure returns `Err(e)`, then the caller may deallocate the memory at `slot`, so
> +//!   you need to take care to clean up anything if your initialization fails mid-way,
> +//! - you may assume that `slot` will stay pinned even after the closure returns until `drop` of
> +//!   `slot` gets called.
> +//!
> +//! ```rust
> +//! use kernel::{prelude::*, init};
> +//! use core::{ptr::addr_of_mut, marker::PhantomPinned};
> +//! # mod bindings {
> +//! #     pub struct foo;
> +//! #     pub unsafe fn init_foo(_ptr: *mut foo) {}
> +//! #     pub unsafe fn destroy_foo(_ptr: *mut foo) {}
> +//! #     pub unsafe fn enable_foo(_ptr: *mut foo, _flags: u32) -> i32 { 0 }
> +//! # }
> +//! /// # Invariants
> +//! ///
> +//! /// `foo` is always initialized
> +//! #[pin_data(PinnedDrop)]
> +//! pub struct RawFoo {
> +//!     #[pin]
> +//!     foo: Opaque<bindings::foo>,
> +//!     #[pin]
> +//!     _p: PhantomPinned,
> +//! }
> +//!
> +//! impl RawFoo {
> +//!     pub fn new(flags: u32) -> impl PinInit<Self, Error> {
> +//!         // SAFETY:
> +//!         // - when the closure returns `Ok(())`, then it has successfully initialized and
> +//!         //   enabled `foo`,
> +//!         // - when it returns `Err(e)`, then it has cleaned up before
> +//!         unsafe {
> +//!             init::pin_init_from_closure(move |slot: *mut Self| {
> +//!                 // `slot` contains uninit memory, avoid creating a reference.
> +//!                 let foo = addr_of_mut!((*slot).foo);
> +//!
> +//!                 // Initialize the `foo`
> +//!                 bindings::init_foo(Opaque::raw_get(foo));
> +//!
> +//!                 // Try to enable it.
> +//!                 let err = bindings::enable_foo(Opaque::raw_get(foo), flags);
> +//!                 if err != 0 {
> +//!                     // Enabling has failed, first clean up the foo and then return the error.
> +//!                     bindings::destroy_foo(Opaque::raw_get(foo));
> +//!                     return Err(Error::from_kernel_errno(err));
> +//!                 }
> +//!
> +//!                 // All fields of `RawFoo` have been initialized, since `_p` is a ZST.
> +//!                 Ok(())
> +//!             })
> +//!         }
> +//!     }
> +//! }
> +//!
> +//! #[pinned_drop]
> +//! impl PinnedDrop for RawFoo {
> +//!     fn drop(self: Pin<&mut Self>) {
> +//!         // SAFETY: Since `foo` is initialized, destroying is safe.
> +//!         unsafe { bindings::destroy_foo(self.foo.get()) };
> +//!     }
> +//! }
> +//! ```
> +//!
>  //! [`sync`]: kernel::sync
>  //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
>  //! [structurally pinned fields]:
> @@ -1085,3 +1157,42 @@ impl<T> InPlaceInit<T> for UniqueArc<T> {
>          Ok(unsafe { this.assume_init() })
>      }
>  }
> +
> +/// Trait facilitating pinned destruction.
> +///
> +/// Use [`pinned_drop`] to implement this trait safely:
> +///
> +/// ```rust
> +/// # use kernel::sync::Mutex;
> +/// use kernel::macros::pinned_drop;
> +/// use core::pin::Pin;
> +/// #[pin_data(PinnedDrop)]
> +/// struct Foo {
> +///     #[pin]
> +///     mtx: Mutex<usize>,
> +/// }
> +///
> +/// #[pinned_drop]
> +/// impl PinnedDrop for Foo {
> +///     fn drop(self: Pin<&mut Self>) {
> +///         pr_info!("Foo is being dropped!");
> +///     }
> +/// }
> +/// ```
> +///
> +/// # Safety
> +///
> +/// This trait must be implemented via the [`pinned_drop`] proc-macro attribute on the impl.
> +///
> +/// [`pinned_drop`]: kernel::macros::pinned_drop
> +pub unsafe trait PinnedDrop: __internal::HasPinData {
> +    /// Executes the pinned destructor of this type.
> +    ///
> +    /// While this function is marked safe, it is actually unsafe to call it manually. For this
> +    /// reason it takes an additional parameter. This type can only be constructed by `unsafe` code
> +    /// and thus prevents this function from being called where it should not.
> +    ///
> +    /// This extra parameter will be generated by the `#[pinned_drop]` proc-macro attribute
> +    /// automatically.
> +    fn drop(self: Pin<&mut Self>, only_call_from_drop: __internal::OnlyCallFromDrop);
> +}
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 692942a008b3..4a3c7bf27a06 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -132,3 +132,18 @@ impl<T: ?Sized> Drop for DropGuard<T> {
>          }
>      }
>  }
> +
> +/// Token used by `PinnedDrop` to prevent calling the function without creating this unsafely
> +/// created struct. This is needed, because the `drop` function is safe, but should not be called
> +/// manually.
> +pub struct OnlyCallFromDrop(());
> +
> +impl OnlyCallFromDrop {
> +    /// # Safety
> +    ///
> +    /// This function should only be called from the [`Drop::drop`] function and only be used to
> +    /// delegate the destruction to the pinned destructor [`PinnedDrop::drop`] of the same type.
> +    pub unsafe fn create() -> Self {
> +        Self(())
> +    }
> +}
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index 2b7b31fd35ce..6e47a75adbe4 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -31,6 +31,26 @@
>  //!         pin_init!(Self { t, x: 0 })
>  //!     }
>  //! }
> +//!
> +//! #[pin_data(PinnedDrop)]
> +//! struct Foo {
> +//!     a: usize,
> +//!     #[pin]
> +//!     b: Bar<u32>,
> +//! }
> +//!
> +//! #[pinned_drop]
> +//! impl PinnedDrop for Foo {
> +//!     fn drop(self: Pin<&mut Self>) {
> +//!         println!("{self:p} is getting dropped.");
> +//!     }
> +//! }
> +//!
> +//! let a = 42;
> +//! let initializer = pin_init!(Foo {
> +//!     a,
> +//!     b <- Bar::new(36),
> +//! });
>  //! ```
>  //!
>  //! This example includes the most common and important features of the pin-init API.
> @@ -155,6 +175,14 @@
>  //!     #[allow(drop_bounds)]
>  //!     impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
>  //!     impl<T> MustNotImplDrop for Bar<T> {}
> +//!     // Here comes a convenience check, if one implemented `PinnedDrop`, but forgot to add it to
> +//!     // `#[pin_data]`, then this will error with the same mechanic as above, this is not needed
> +//!     // for safety, but a good sanity check, since no normal code calls `PinnedDrop::drop`.
> +//!     #[allow(non_camel_case_types)]
> +//!     trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
> +//!     impl<T: ::pinned_init::PinnedDrop>
> +//!         UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
> +//!     impl<T> UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for Bar<T> {}
>  //! };
>  //! ```
>  //!
> @@ -265,6 +293,209 @@
>  //!     }
>  //! }
>  //! ```
> +//!
> +//! ## `#[pin_data]` on `Foo`
> +//!
> +//! Since we already took a look at `#[pin_data]` on `Bar`, this section will only explain the
> +//! differences/new things in the expansion of the `Foo` definition:
> +//!
> +//! ```rust
> +//! #[pin_data(PinnedDrop)]
> +//! struct Foo {
> +//!     a: usize,
> +//!     #[pin]
> +//!     b: Bar<u32>,
> +//! }
> +//! ```
> +//!
> +//! This expands to the following code:
> +//!
> +//! ```rust
> +//! struct Foo {
> +//!     a: usize,
> +//!     b: Bar<u32>,
> +//! }
> +//! const _: () = {
> +//!     struct __ThePinData {
> +//!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
> +//!     }
> +//!     impl ::core::clone::Clone for __ThePinData {
> +//!         fn clone(&self) -> Self {
> +//!             *self
> +//!         }
> +//!     }
> +//!     impl ::core::marker::Copy for __ThePinData {}
> +//!     #[allow(dead_code)]
> +//!     impl __ThePinData {
> +//!         unsafe fn b<E>(
> +//!             self,
> +//!             slot: *mut Bar<u32>,
> +//!             // Note that this is `PinInit` instead of `Init`, this is because `b` is
> +//!             // structurally pinned, as marked by the `#[pin]` attribute.
> +//!             init: impl ::pinned_init::PinInit<Bar<u32>, E>,
> +//!         ) -> ::core::result::Result<(), E> {
> +//!             unsafe { ::pinned_init::PinInit::__pinned_init(init, slot) }
> +//!         }
> +//!         unsafe fn a<E>(
> +//!             self,
> +//!             slot: *mut usize,
> +//!             init: impl ::pinned_init::Init<usize, E>,
> +//!         ) -> ::core::result::Result<(), E> {
> +//!             unsafe { ::pinned_init::Init::__init(init, slot) }
> +//!         }
> +//!     }
> +//!     unsafe impl ::pinned_init::__internal::HasPinData for Foo {
> +//!         type PinData = __ThePinData;
> +//!         unsafe fn __pin_data() -> Self::PinData {
> +//!             __ThePinData {
> +//!                 __phantom: ::core::marker::PhantomData,
> +//!             }
> +//!         }
> +//!     }
> +//!     unsafe impl ::pinned_init::__internal::PinData for __ThePinData {
> +//!         type Datee = Foo;
> +//!     }
> +//!     #[allow(dead_code)]
> +//!     struct __Unpin<'__pin> {
> +//!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &'__pin ()>,
> +//!         __phantom: ::core::marker::PhantomData<fn(Foo) -> Foo>,
> +//!         // Since this field is `#[pin]`, it is listed here.
> +//!         b: Bar<u32>,
> +//!     }
> +//!     #[doc(hidden)]
> +//!     impl<'__pin> ::core::marker::Unpin for Foo where __Unpin<'__pin>: ::core::marker::Unpin {}
> +//!     // Since we specified `PinnedDrop` as the argument to `#[pin_data]`, we expect `Foo` to
> +//!     // implement `PinnedDrop`. Thus we do not need to prevent `Drop` implementations like
> +//!     // before, instead we implement it here and delegate to `PinnedDrop`.
> +//!     impl ::core::ops::Drop for Foo {
> +//!         fn drop(&mut self) {
> +//!             // Since we are getting dropped, no one else has a reference to `self` and thus we
> +//!             // can assume that we never move.
> +//!             let pinned = unsafe { ::core::pin::Pin::new_unchecked(self) };
> +//!             // Create the unsafe token that proves that we are inside of a destructor, this
> +//!             // type is only allowed to be created in a destructor.
> +//!             let token = unsafe { ::pinned_init::__internal::OnlyCallFromDrop::create() };
> +//!             ::pinned_init::PinnedDrop::drop(pinned, token);
> +//!         }
> +//!     }
> +//! };
> +//! ```
> +//!
> +//! ## `#[pinned_drop]` on `impl PinnedDrop for Foo`
> +//!
> +//! This macro is used to implement the `PinnedDrop` trait, since that trait is `unsafe` and has an
> +//! extra parameter that should not be used at all. The macro hides that parameter.
> +//!
> +//! Here is the `PinnedDrop` impl for `Foo`:
> +//!
> +//! ```rust
> +//! #[pinned_drop]
> +//! impl PinnedDrop for Foo {
> +//!     fn drop(self: Pin<&mut Self>) {
> +//!         println!("{self:p} is getting dropped.");
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! This expands to the following code:
> +//!
> +//! ```rust
> +//! // `unsafe`, full path and the token parameter are added, everything else stays the same.
> +//! unsafe impl ::pinned_init::PinnedDrop for Foo {
> +//!     fn drop(self: Pin<&mut Self>, _: ::pinned_init::__internal::OnlyCallFromDrop) {
> +//!         println!("{self:p} is getting dropped.");
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! ## `pin_init!` on `Foo`
> +//!
> +//! Since we already took a look at `pin_init!` on `Bar`, this section will only explain the
> +//! differences/new things in the expansion of `pin_init!` on `Foo`:
> +//!
> +//! ```rust
> +//! let a = 42;
> +//! let initializer = pin_init!(Foo {
> +//!     a,
> +//!     b <- Bar::new(36),
> +//! });
> +//! ```
> +//!
> +//! This expands to the following code:
> +//!
> +//! ```rust
> +//! let a = 42;
> +//! let initializer = {
> +//!     struct __InitOk;
> +//!     let data = unsafe {
> +//!         use pinned_init::__internal::HasPinData;
> +//!         Foo::__pin_data()
> +//!     };
> +//!     let init = ::pinned_init::__internal::PinData::make_closure::<
> +//!         _,
> +//!         __InitOk,
> +//!         ::core::convert::Infallible,
> +//!     >(data, move |slot| {
> +//!         {
> +//!             struct __InitOk;
> +//!             unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
> +//!             let a = &unsafe { ::pinned_init::__internal::DropGuard::new(&raw mut (*slot).a) };
> +//!             let b = Bar::new(36);
> +//!             // Here we use `data` to access the correct field and require that `b` is of type
> +//!             // `PinInit<Bar<u32>, Infallible>`.
> +//!             unsafe { data.b(&raw mut (*slot).b, b)? };
> +//!             let b = &unsafe { ::pinned_init::__internal::DropGuard::new(&raw mut (*slot).b) };
> +//!
> +//!             #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +//!             if false {
> +//!                 unsafe {
> +//!                     ::core::ptr::write(
> +//!                         slot,
> +//!                         Foo {
> +//!                             a: ::core::panic!(),
> +//!                             b: ::core::panic!(),
> +//!                         },
> +//!                     );
> +//!                 };
> +//!             }
> +//!             unsafe { ::pinned_init::__internal::DropGuard::forget(a) };
> +//!             unsafe { ::pinned_init::__internal::DropGuard::forget(b) };
> +//!         }
> +//!         Ok(__InitOk)
> +//!     });
> +//!     let init = move |slot| -> ::core::result::Result<(), ::core::convert::Infallible> {
> +//!         init(slot).map(|__InitOk| ())
> +//!     };
> +//!     let init =
> +//!         unsafe { ::pinned_init::pin_init_from_closure::<_, ::core::convert::Infallible>(init) };
> +//!     init
> +//! };
> +//! ```
> +
> +/// Creates a `unsafe impl<...> PinnedDrop for $type` block.
> +///
> +/// See [`PinnedDrop`] for more information.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! __pinned_drop {
> +    (
> +        @impl_sig($($impl_sig:tt)*),
> +        @impl_body(
> +            $(#[$($attr:tt)*])*
> +            fn drop($self:ident: $st:ty) {
> +                $($inner:stmt)*
> +            }
> +        ),
> +    ) => {
> +        unsafe $($impl_sig)* {
> +            // Inherit all attributes and the type/ident tokens for the signature.
> +            $(#[$($attr)*])*
> +            fn drop($self: $st, _: $crate::init::__internal::OnlyCallFromDrop) {
> +                $($inner)*
> +            }
> +        }
> +    }
> +}
>
>  /// This macro first parses the struct definition such that it separates pinned and not pinned
>  /// fields. Afterwards it declares the struct and implement the `PinData` trait safely.
> @@ -653,6 +884,38 @@ macro_rules! __pin_data {
>          impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
>          impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)*>
>          where $($whr)* {}
> +        // We also take care to prevent users from writing a useless `PinnedDrop` implementation.
> +        // They might implement `PinnedDrop` correctly for the struct, but forget to give
> +        // `PinnedDrop` as the parameter to `#[pin_data]`.
> +        #[allow(non_camel_case_types)]
> +        trait UselessPinnedDropImpl_you_need_to_specify_PinnedDrop {}
> +        impl<T: $crate::init::PinnedDrop>
> +            UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for T {}
> +        impl<$($impl_generics)*>
> +            UselessPinnedDropImpl_you_need_to_specify_PinnedDrop for $name<$($ty_generics)*>
> +        where $($whr)* {}
> +    };
> +    // When `PinnedDrop` was specified we just implement `Drop` and delegate.
> +    (drop_prevention:
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        @pinned_drop(PinnedDrop),
> +    ) => {
> +        impl<$($impl_generics)*> ::core::ops::Drop for $name<$($ty_generics)*>
> +        where $($whr)*
> +        {
> +            fn drop(&mut self) {
> +                // SAFETY: Since this is a destructor, `self` will not move after this function
> +                // terminates, since it is inaccessible.
> +                let pinned = unsafe { ::core::pin::Pin::new_unchecked(self) };
> +                // SAFETY: Since this is a drop function, we can create this token to call the
> +                // pinned destructor of this type.
> +                let token = unsafe { $crate::init::__internal::OnlyCallFromDrop::create() };
> +                $crate::init::PinnedDrop::drop(pinned, token);
> +            }
> +        }
>      };
>      // If some other parameter was specified, we emit a readable error.
>      (drop_prevention:
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 4def038fe71a..86eb06f2d9fe 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -8,6 +8,7 @@ mod concat_idents;
>  mod helpers;
>  mod module;
>  mod pin_data;
> +mod pinned_drop;
>  mod vtable;
>
>  use proc_macro::TokenStream;
> @@ -180,6 +181,10 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
>  /// This macro enables the use of the [`pin_init!`] macro. When pin-initializing a `struct`,
>  /// then `#[pin]` directs the type of intializer that is required.
>  ///
> +/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` as arguments to this
> +/// macro, and change your `Drop` implementation to `PinnedDrop` annotated with
> +/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires extra care.
> +///
>  /// # Examples
>  ///
>  /// ```rust,ignore
> @@ -191,9 +196,53 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream {
>  /// }
>  /// ```
>  ///
> +/// ```rust,ignore
> +/// #[pin_data(PinnedDrop)]
> +/// struct DriverData {
> +///     #[pin]
> +///     queue: Mutex<Vec<Command>>,
> +///     buf: Box<[u8; 1024 * 1024]>,
> +///     raw_info: *mut Info,
> +/// }
> +///
> +/// #[pinned_drop]
> +/// impl PinnedDrop for DriverData {
> +///     fn drop(self: Pin<&mut Self>) {
> +///         unsafe { bindings::destroy_info(self.raw_info) };
> +///     }
> +/// }
> +/// ```
> +///
>  /// [`pin_init!`]: ../kernel/macro.pin_init.html
>  //  ^ cannot use direct link, since `kernel` is not a dependency of `macros`.
>  #[proc_macro_attribute]
>  pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
>      pin_data::pin_data(inner, item)
>  }
> +
> +/// Used to implement `PinnedDrop` safely.
> +///
> +/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore
> +/// #[pin_data(PinnedDrop)]
> +/// struct DriverData {
> +///     #[pin]
> +///     queue: Mutex<Vec<Command>>,
> +///     buf: Box<[u8; 1024 * 1024]>,
> +///     raw_info: *mut Info,
> +/// }
> +///
> +/// #[pinned_drop]
> +/// impl PinnedDrop for DriverData {
> +///     fn drop(self: Pin<&mut Self>) {
> +///         unsafe { bindings::destroy_info(self.raw_info) };
> +///     }
> +/// }
> +/// ```
> +#[proc_macro_attribute]
> +pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
> +    pinned_drop::pinned_drop(args, input)
> +}
> diff --git a/rust/macros/pinned_drop.rs b/rust/macros/pinned_drop.rs
> new file mode 100644
> index 000000000000..88fb72b20660
> --- /dev/null
> +++ b/rust/macros/pinned_drop.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +use proc_macro::{TokenStream, TokenTree};
> +
> +pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream {
> +    let mut toks = input.into_iter().collect::<Vec<_>>();
> +    assert!(!toks.is_empty());
> +    // Ensure that we have an `impl` item.
> +    assert!(matches!(&toks[0], TokenTree::Ident(i) if i.to_string() == "impl"));
> +    // Ensure that we are implementing `PinnedDrop`.
> +    let mut nesting: usize = 0;
> +    let mut pinned_drop_idx = None;
> +    for (i, tt) in toks.iter().enumerate() {
> +        match tt {
> +            TokenTree::Punct(p) if p.as_char() == '<' => {
> +                nesting += 1;
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '>' => {
> +                nesting = nesting.checked_sub(1).unwrap();
> +                continue;
> +            }
> +            _ => {}
> +        }
> +        if i >= 1 && nesting == 0 {
> +            // Found the end of the generics, this should be `PinnedDrop`.
> +            assert!(
> +                matches!(tt, TokenTree::Ident(i) if i.to_string() == "PinnedDrop"),
> +                "expected 'PinnedDrop', found: '{:?}'",
> +                tt
> +            );
> +            pinned_drop_idx = Some(i);
> +            break;
> +        }
> +    }
> +    let idx = pinned_drop_idx
> +        .unwrap_or_else(|| panic!("Expected an `impl` block implementing `PinnedDrop`."));
> +    // Fully qualify the `PinnedDrop`, as to avoid any tampering.
> +    toks.splice(idx..idx, quote!(::kernel::init::));
> +    // Take the `{}` body and call the declarative macro.
> +    if let Some(TokenTree::Group(last)) = toks.pop() {
> +        let last = last.stream();
> +        quote!(::kernel::__pinned_drop! {
> +            @impl_sig(#(#toks)*),
> +            @impl_body(#last),
> +        })
> +    } else {
> +        TokenStream::from_iter(toks)
> +    }
> +}

