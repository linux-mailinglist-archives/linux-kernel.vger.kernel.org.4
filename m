Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B56D89D1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjDEVwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjDEVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:52:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E076A2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:52:46 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-500349a5139so4025587a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680731564;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CQlHkLe0nciRyVqFq9sfsFmRt63ff4HXDstgqyEXBdc=;
        b=2SdNqxnbBITR/O+AJmQJkuOWPBpyU19T64bURPo7FYbe8N7ac2SnQDJiLwbWMbsliT
         yt+VlMkjnx63f7z0OZiCGnp7CdbkrB2XcPBlZ5DStE21HdXBd9XKPNL7bYR8yjEZtai/
         aJdjQqlmSUYvdjhy/PRRoU/EKCmFdxsGckqxutWP2GJCd+Qw+fwj9iBNRURYrCpTvzMZ
         T6VzSmpG0hlLoQaE3ckpevECyGb7nbZo+iBMeFRfpipy16GZD6otdEHbi+9dPhVh0dJH
         w9KF0zuQPYHEIvUIs97D67GuhYbZmcnZshUbp9aJAIUpBJSrKOWpQrFf+8LecVkSVMhW
         /JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731564;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQlHkLe0nciRyVqFq9sfsFmRt63ff4HXDstgqyEXBdc=;
        b=M9plAF1nFLjlys3PjCT5zx+Ai2NY59IcbWi8mxWSS0jX/olVEjnMIKMo9EC9rSKsLL
         dMeoCsCM6rnAeOJGVTTiaZq6dbXerZ9XPEHB/zzrvQRYxjhI5oaJ0z7YuPdA0Y+gMJ2O
         vS/lLFwKuj2OetNlK+zmpxp7M7k9oBv0KyjI5X8wvVbDg++ijhVmcIx07GJaluVEHnbL
         jPuLwhKknhBotvM9CV5j484etKMn5NoqC64wXRWxg5rQ1YStObma7NpNRhzzigp00iS6
         M5+Hl6b5EPyYlVNyP5rgd2rfwpSCjOWa+M33thsyXdcbRWcdNPfMtJfKX+kt47KAmplU
         5NUQ==
X-Gm-Message-State: AAQBX9eUVPsyV68a03MuuUYc4HFJa+AilmrMynRWjmLlqTmM94h3CLHw
        grhMstmisIxZRnnHb7KZMH09zw==
X-Google-Smtp-Source: AKy350Z/7W3HPZNePzh8LaWKcOFTjs9BugvO4cW1sMP8sNpcuUsjHWzecPNIp8jeFnCbx3jBUA6rGw==
X-Received: by 2002:aa7:cd0b:0:b0:502:2953:c0b2 with SMTP id b11-20020aa7cd0b000000b005022953c0b2mr2976829edw.12.1680731564424;
        Wed, 05 Apr 2023 14:52:44 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id cx7-20020a05640222a700b004fd1ee3f723sm7635921edb.67.2023.04.05.14.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:52:44 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-11-y86-dev@protonmail.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v6 10/15] rust: init: add `stack_pin_init!` macro
Date:   Wed, 05 Apr 2023 23:51:52 +0200
In-reply-to: <20230405193445.745024-11-y86-dev@protonmail.com>
Message-ID: <87ttxuro7n.fsf@metaspace.dk>
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


Benno Lossin <y86-dev@protonmail.com> writes:

> The `stack_pin_init!` macro allows pin-initializing a value on the
> stack. It accepts a `impl PinInit<T, E>` to initialize a `T`. It allows
> propagating any errors via `?` or handling it normally via `match`.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> Cc: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/init.rs            | 140 +++++++++++++++++++++++++++++++--
>  rust/kernel/init/__internal.rs |  50 ++++++++++++
>  2 files changed, 184 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 37e8159df24d..99751375e7c8 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -12,7 +12,8 @@
>  //!
>  //! To initialize a `struct` with an in-place constructor you will need two things:
>  //! - an in-place constructor,
> -//! - a memory location that can hold your `struct`.
> +//! - a memory location that can hold your `struct` (this can be the [stack], an [`Arc<T>`],
> +//!   [`UniqueArc<T>`], [`Box<T>`] or any other smart pointer that implements [`InPlaceInit`]).
>  //!
>  //! To get an in-place constructor there are generally three options:
>  //! - directly creating an in-place constructor using the [`pin_init!`] macro,
> @@ -180,6 +181,7 @@
>  //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
>  //! [structurally pinned fields]:
>  //!     https://doc.rust-lang.org/std/pin/index.html#pinning-is-structural-for-field
> +//! [stack]: crate::stack_pin_init
>  //! [`Arc<T>`]: crate::sync::Arc
>  //! [`impl PinInit<Foo>`]: PinInit
>  //! [`impl PinInit<T, E>`]: PinInit
> @@ -202,6 +204,132 @@ pub mod __internal;
>  #[doc(hidden)]
>  pub mod macros;
>
> +/// Initialize and pin a type directly on the stack.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::pin::Pin;
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Bar,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// stack_pin_init!(let foo = pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Bar {
> +///         x: 64,
> +///     },
> +/// }));
> +/// let foo: Pin<&mut Foo> = foo;
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// ```
> +///
> +/// # Syntax
> +///
> +/// A normal `let` binding with optional type annotation. The expression is expected to implement
> +/// [`PinInit`]/[`Init`] with the error type [`Infallible`]. If you want to use a different error
> +/// type, then use [`stack_try_pin_init!`].
> +#[macro_export]
> +macro_rules! stack_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = match $crate::init::__internal::StackInit::init($var, val) {
> +            Ok(res) => res,
> +            Err(x) => {
> +                let x: ::core::convert::Infallible = x;
> +                match x {}
> +            }
> +        };
> +    };
> +}
> +
> +/// Initialize and pin a type directly on the stack.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::{alloc::AllocError, pin::Pin};
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Box<Bar>,
> +/// }
> +///
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Box::try_new(Bar {
> +///         x: 64,
> +///     })?,
> +/// }));
> +/// let foo = foo.unwrap();
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// ```
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, stack_try_pin_init, init::*, sync::Mutex, new_mutex};
> +/// # use macros::pin_data;
> +/// # use core::{alloc::AllocError, pin::Pin};
> +/// #[pin_data]
> +/// struct Foo {
> +///     #[pin]
> +///     a: Mutex<usize>,
> +///     b: Box<Bar>,
> +/// }
> +///
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
> +///     a <- new_mutex!(42),
> +///     b: Box::try_new(Bar {
> +///         x: 64,
> +///     })?,
> +/// }));
> +/// pr_info!("a: {}", &*foo.a.lock());
> +/// # Ok::<_, AllocError>(())
> +/// ```
> +///
> +/// # Syntax
> +///
> +/// A normal `let` binding with optional type annotation. The expression is expected to implement
> +/// [`PinInit`]/[`Init`]. This macro assigns a result to the given variable, adding a `?` after the
> +/// `=` will propagate this error.
> +#[macro_export]
> +macro_rules! stack_try_pin_init {
> +    (let $var:ident $(: $t:ty)? = $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = $crate::init::__internal::StackInit::init($var, val);
> +    };
> +    (let $var:ident $(: $t:ty)? =? $val:expr) => {
> +        let val = $val;
> +        let mut $var = ::core::pin::pin!($crate::init::__internal::StackInit$(::<$t>)?::uninit());
> +        let mut $var = $crate::init::__internal::StackInit::init($var, val)?;
> +    };
> +}
> +
>  /// Construct an in-place, pinned initializer for `struct`s.
>  ///
>  /// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> @@ -913,8 +1041,8 @@ macro_rules! try_init {
>  /// A pin-initializer for the type `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> -/// smart pointer like [`Arc<T>`] on this.
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::pin_init`] function of a smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -949,9 +1077,9 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> -/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
> -/// use every function that takes it as well.
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`] or even the stack (see [`stack_pin_init!`]). Use the
> +/// [`InPlaceInit::init`] function of a smart pointer like [`Arc<T>`] on this. Because
> +/// [`PinInit<T, E>`] is a super trait, you can use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
>  ///
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 69be03e17c1f..600b6442c6e9 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -112,6 +112,56 @@ unsafe impl<T: ?Sized> HasInitData for T {
>      }
>  }
>
> +/// Stack initializer helper type. Use [`stack_pin_init`] instead of this primitive.
> +///
> +/// # Invariants
> +///
> +/// If `self.1` is true, then `self.0` is initialized.
> +///
> +/// [`stack_pin_init`]: kernel::stack_pin_init
> +pub struct StackInit<T>(MaybeUninit<T>, bool);
> +
> +impl<T> Drop for StackInit<T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        if self.1 {
> +            // SAFETY: As we are being dropped, we only call this once. And since `self.1 == true`,
> +            // `self.0` has to be initialized.
> +            unsafe { self.0.assume_init_drop() };
> +        }
> +    }
> +}
> +
> +impl<T> StackInit<T> {
> +    /// Creates a new [`StackInit<T>`] that is uninitialized. Use [`stack_pin_init`] instead of this
> +    /// primitive.
> +    ///
> +    /// [`stack_pin_init`]: kernel::stack_pin_init
> +    #[inline]
> +    pub fn uninit() -> Self {
> +        Self(MaybeUninit::uninit(), false)
> +    }
> +
> +    /// Initializes the contents and returns the result.
> +    #[inline]
> +    pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mut T>, E> {
> +        // SAFETY: We never move out of `this`.
> +        let this = unsafe { Pin::into_inner_unchecked(self) };
> +        // The value is currently initialized, so it needs to be dropped before we can reuse
> +        // the memory (this is a safety guarantee of `Pin`).
> +        if this.1 {
> +            this.1 = false;
> +            // SAFETY: `this.1` was true and we set it to false.
> +            unsafe { this.0.assume_init_drop() };
> +        }
> +        // SAFETY: The memory slot is valid and this type ensures that it will stay pinned.
> +        unsafe { init.__pinned_init(this.0.as_mut_ptr())? };
> +        this.1 = true;
> +        // SAFETY: The slot is now pinned, since we will never give access to `&mut T`.
> +        Ok(unsafe { Pin::new_unchecked(this.0.assume_init_mut()) })
> +    }
> +}
> +
>  /// When a value of this type is dropped, it drops a `T`.
>  ///
>  /// Can be forgotton to prevent the drop.

