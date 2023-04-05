Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56D6D8965
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjDEVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjDEVPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:15:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAC7173C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:15:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-93071f06bd1so81576666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680729310;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=gZIfde/0UaffLDUjvn7EycIKWWoH+kOuDnBck4Al2NE=;
        b=TcmqXbZpII4Ok59CFSIY8sn12pi6Yst1CXnQAWmxxpyVTmRmBiPgIsF5RGX3GvCtEX
         mlOA10jA2Rtm+NPvh3kdvkdzIZWQjwgZjHCpy9a9J3h+KW4xkq/nw4p4uf1pKI1QbMMU
         XjpaJvA2ikxbv408f4ZoTIg/m539PVUI3bRiOHPyFECSH8kx8UPeQm7bk2id3jf++DG7
         prlspJ4E2gebD1bDKnpDc5Wv1Nh7aIN+WW9wnLd5LD4vSKH0q8NT5/2oRG+zr97QfEg/
         WD40o9/ab6lze1+T+H1HLigoWuvOUKJDT1o9QRWov67SSHy6r3WWRmWJG1v+oiHQ4G2w
         OKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680729310;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZIfde/0UaffLDUjvn7EycIKWWoH+kOuDnBck4Al2NE=;
        b=OppHxL4JvISvC0hXnlXtZP01Z0qzLtNr6+Md3WVKP/Io1QOmjZxy0QxUhLok8V62u/
         GQFn53NLBH0Gjjy5vycx3cf2yeEIWyHtCiJJzf+hwn9quo+G3CbG9sp+0K3q2vxYcbPt
         hLpkNS5VI7AGUpyGH6/FGz0Qs31u/Cw46vZsUWIuz8nvt83EYzrs/0RohxguMI6KggDA
         hDjRXFsFQLyuR776KbMX13LN3xCJBAEhoT05gmtH4gQgIi6DEg3j0u98gRMiIM+wwww6
         Gr2NAUDwMYsO/R8QwrTGQhHJyDYFH2ubXG2yimz7hfLpn4yFnZ94GmR8Rc3corQecZ4I
         0WWw==
X-Gm-Message-State: AAQBX9d10vGkYKW9LxGrMzNbA4WIUioDJ5XMHMrpjivUuxcIePFZL//R
        1qEq47Loc+nEzezrkJEs7ncNRw==
X-Google-Smtp-Source: AKy350bP6Bw/5yPMEf+lJrukmS+6WlxV8M+xoki/h0PLokbUbsW5LQwaQnBNEdIUDR526MN4rTlKrQ==
X-Received: by 2002:a05:6402:496:b0:4fd:2b0e:ce87 with SMTP id k22-20020a056402049600b004fd2b0ece87mr3036429edv.24.1680729309001;
        Wed, 05 Apr 2023 14:15:09 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d603000000b004c06f786602sm7709040edi.85.2023.04.05.14.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:15:08 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-8-y86-dev@protonmail.com>
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
Subject: Re: [PATCH v6 07/15] rust: init: add initialization macros
Date:   Wed, 05 Apr 2023 23:14:18 +0200
In-reply-to: <20230405193445.745024-8-y86-dev@protonmail.com>
Message-ID: <877cuqt4ir.fsf@metaspace.dk>
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

> Add the following initializer macros:
> - `#[pin_data]` to annotate structurally pinned fields of structs,
>   needed for `pin_init!` and `try_pin_init!` to select the correct
>   initializer of fields.
> - `pin_init!` create a pin-initializer for a struct with the
>   `Infallible` error type.
> - `try_pin_init!` create a pin-initializer for a struct with a custom
>   error type (`kernel::error::Error` is the default).
> - `init!` create an in-place-initializer for a struct with the
>   `Infallible` error type.
> - `try_init!` create an in-place-initializer for a struct with a custom
>   error type (`kernel::error::Error` is the default).
>
> Also add their needed internal helper traits and structs.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/init.rs            | 807 ++++++++++++++++++++++++++++++++-
>  rust/kernel/init/__internal.rs | 124 +++++
>  rust/kernel/init/macros.rs     | 707 +++++++++++++++++++++++++++++
>  rust/macros/lib.rs             |  29 ++
>  rust/macros/pin_data.rs        |  79 ++++
>  rust/macros/quote.rs           |   2 -
>  6 files changed, 1741 insertions(+), 7 deletions(-)
>  create mode 100644 rust/kernel/init/macros.rs
>  create mode 100644 rust/macros/pin_data.rs
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index d041f0daf71e..ecef0376d726 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -14,7 +14,8 @@
>  //! - an in-place constructor,
>  //! - a memory location that can hold your `struct`.
>  //!
> -//! To get an in-place constructor there are generally two options:
> +//! To get an in-place constructor there are generally three options:
> +//! - directly creating an in-place constructor using the [`pin_init!`] macro,
>  //! - a custom function/macro returning an in-place constructor provided by someone else,
>  //! - using the unsafe function [`pin_init_from_closure()`] to manually create an initializer.
>  //!
> @@ -22,6 +23,87 @@
>  //! the macros/types/functions are generally named like the pinned variants without the `pin`
>  //! prefix.
>  //!
> +//! # Examples
> +//!
> +//! ## Using the [`pin_init!`] macro
> +//!
> +//! If you want to use [`PinInit`], then you will have to annotate your `struct` with
> +//! `#[`[`pin_data`]`]`. It is a macro that uses `#[pin]` as a marker for
> +//! [structurally pinned fields]. After doing this, you can then create an in-place constructor via
> +//! [`pin_init!`]. The syntax is almost the same as normal `struct` initializers. The difference is
> +//! that you need to write `<-` instead of `:` for fields that you want to initialize in-place.
> +//!
> +//! ```rust
> +//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +//! use kernel::{prelude::*, sync::Mutex, new_mutex};
> +//! # use core::pin::Pin;
> +//! #[pin_data]
> +//! struct Foo {
> +//!     #[pin]
> +//!     a: Mutex<usize>,
> +//!     b: u32,
> +//! }
> +//!
> +//! let foo = pin_init!(Foo {
> +//!     a <- new_mutex!(42, "Foo::a"),
> +//!     b: 24,
> +//! });
> +//! ```
> +//!
> +//! `foo` now is of the type [`impl PinInit<Foo>`]. We can now use any smart pointer that we like
> +//! (or just the stack) to actually initialize a `Foo`:
> +//!
> +//! ```rust
> +//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +//! # use kernel::{prelude::*, sync::Mutex, new_mutex};
> +//! # use core::pin::Pin;
> +//! # #[pin_data]
> +//! # struct Foo {
> +//! #     #[pin]
> +//! #     a: Mutex<usize>,
> +//! #     b: u32,
> +//! # }
> +//! # let foo = pin_init!(Foo {
> +//! #     a <- new_mutex!(42, "Foo::a"),
> +//! #     b: 24,
> +//! # });
> +//! let foo: Result<Pin<Box<Foo>>> = Box::pin_init(foo);
> +//! ```
> +//!
> +//! For more information see the [`pin_init!`] macro.
> +//!
> +//! ## Using a custom function/macro that returns an initializer
> +//!
> +//! Many types from the kernel supply a function/macro that returns an initializer, because the
> +//! above method only works for types where you can access the fields.
> +//!
> +//! ```rust
> +//! # use kernel::{new_mutex, sync::{Arc, Mutex}};
> +//! let mtx: Result<Arc<Mutex<usize>>> = Arc::pin_init(new_mutex!(42, "example::mtx"));
> +//! ```
> +//!
> +//! To declare an init macro/function you just return an [`impl PinInit<T, E>`]:
> +//!
> +//! ```rust
> +//! # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +//! # use kernel::{sync::Mutex, prelude::*, new_mutex, init::PinInit, try_pin_init};
> +//! #[pin_data]
> +//! struct DriverData {
> +//!     #[pin]
> +//!     status: Mutex<i32>,
> +//!     buffer: Box<[u8; 1_000_000]>,
> +//! }
> +//!
> +//! impl DriverData {
> +//!     fn new() -> impl PinInit<Self, Error> {
> +//!         try_pin_init!(Self {
> +//!             status <- new_mutex!(0, "DriverData::status"),
> +//!             buffer: Box::init(kernel::init::zeroed())?,
> +//!         })
> +//!     }
> +//! }
> +//! ```
> +//!
>  //! [`sync`]: kernel::sync
>  //! [pinning]: https://doc.rust-lang.org/std/pin/index.html
>  //! [structurally pinned fields]:
> @@ -33,12 +115,729 @@
>  //! [`Opaque`]: kernel::types::Opaque
>  //! [`pin_data`]: ::macros::pin_data
>  //! [`UniqueArc<T>`]: kernel::sync::UniqueArc
> -//! [`Box<T>`]: alloc::boxed::Box
>
> -use core::{convert::Infallible, marker::PhantomData, mem::MaybeUninit};
> +use alloc::boxed::Box;
> +use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit, ptr};
>
>  #[doc(hidden)]
>  pub mod __internal;
> +#[doc(hidden)]
> +pub mod macros;
> +
> +/// Construct an in-place, pinned initializer for `struct`s.
> +///
> +/// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> +/// [`try_pin_init!`].
> +///
> +/// The syntax is almost identical to that of a normal `struct` initializer:
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, macros::pin_data, init::*};
> +/// # use core::pin::Pin;
> +/// #[pin_data]
> +/// struct Foo {
> +///     a: usize,
> +///     b: Bar,
> +/// }
> +///
> +/// #[pin_data]
> +/// struct Bar {
> +///     x: u32,
> +/// }
> +///
> +/// # fn demo() -> impl PinInit<Foo> {
> +/// let a = 42;
> +///
> +/// let initializer = pin_init!(Foo {
> +///     a,
> +///     b: Bar {
> +///         x: 64,
> +///     },
> +/// });
> +/// # initializer }
> +/// # Box::pin_init(demo()).unwrap();
> +/// ```
> +///
> +/// Arbitrary Rust expressions can be used to set the value of a variable.
> +///
> +/// The fields are initialized in the order that they appear in the initializer. So it is possible
> +/// to read already initialized fields using raw pointers.
> +///
> +/// IMPORTANT: You are not allowed to create references to fields of the struct inside of the
> +/// initializer.
> +///
> +/// # Init-functions
> +///
> +/// When working with this API it is often desired to let others construct your types without
> +/// giving access to all fields. This is where you would normally write a plain function `new`
> +/// that would return a new instance of your type. With this API that is also possible.
> +/// However, there are a few extra things to keep in mind.
> +///
> +/// To create an initializer function, simply declare it like this:
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, prelude::*, init::*};
> +/// # use core::pin::Pin;
> +/// # #[pin_data]
> +/// # struct Foo {
> +/// #     a: usize,
> +/// #     b: Bar,
> +/// # }
> +/// # #[pin_data]
> +/// # struct Bar {
> +/// #     x: u32,
> +/// # }
> +/// impl Foo {
> +///     fn new() -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             a: 42,
> +///             b: Bar {
> +///                 x: 64,
> +///             },
> +///         })
> +///     }
> +/// }
> +/// ```
> +///
> +/// Users of `Foo` can now create it like this:
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, macros::pin_data, init::*};
> +/// # use core::pin::Pin;
> +/// # #[pin_data]
> +/// # struct Foo {
> +/// #     a: usize,
> +/// #     b: Bar,
> +/// # }
> +/// # #[pin_data]
> +/// # struct Bar {
> +/// #     x: u32,
> +/// # }
> +/// # impl Foo {
> +/// #     fn new() -> impl PinInit<Self> {
> +/// #         pin_init!(Self {
> +/// #             a: 42,
> +/// #             b: Bar {
> +/// #                 x: 64,
> +/// #             },
> +/// #         })
> +/// #     }
> +/// # }
> +/// let foo = Box::pin_init(Foo::new());
> +/// ```
> +///
> +/// They can also easily embed it into their own `struct`s:
> +///
> +/// ```rust
> +/// # #![allow(clippy::disallowed_names, clippy::new_ret_no_self)]
> +/// # use kernel::{init, pin_init, macros::pin_data, init::*};
> +/// # use core::pin::Pin;
> +/// # #[pin_data]
> +/// # struct Foo {
> +/// #     a: usize,
> +/// #     b: Bar,
> +/// # }
> +/// # #[pin_data]
> +/// # struct Bar {
> +/// #     x: u32,
> +/// # }
> +/// # impl Foo {
> +/// #     fn new() -> impl PinInit<Self> {
> +/// #         pin_init!(Self {
> +/// #             a: 42,
> +/// #             b: Bar {
> +/// #                 x: 64,
> +/// #             },
> +/// #         })
> +/// #     }
> +/// # }
> +/// #[pin_data]
> +/// struct FooContainer {
> +///     #[pin]
> +///     foo1: Foo,
> +///     #[pin]
> +///     foo2: Foo,
> +///     other: u32,
> +/// }
> +///
> +/// impl FooContainer {
> +///     fn new(other: u32) -> impl PinInit<Self> {
> +///         pin_init!(Self {
> +///             foo1 <- Foo::new(),
> +///             foo2 <- Foo::new(),
> +///             other,
> +///         })
> +///     }
> +/// }
> +/// ```
> +///
> +/// Here we see that when using `pin_init!` with `PinInit`, one needs to write `<-` instead of `:`.
> +/// This signifies that the given field is initialized in-place. As with `struct` initializers, just
> +/// writing the field (in this case `other`) without `:` or `<-` means `other: other,`.
> +///
> +/// # Syntax
> +///
> +/// As already mentioned in the examples above, inside of `pin_init!` a `struct` initializer with
> +/// the following modifications is expected:
> +/// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
> +/// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
> +///   pointer named `this` inside of the initializer.
> +///
> +/// For instance:
> +///
> +/// ```rust
> +/// # use kernel::pin_init;
> +/// # use macros::pin_data;
> +/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
> +/// #[pin_data]
> +/// struct Buf {
> +///     // `ptr` points into `buf`.
> +///     ptr: *mut u8,
> +///     buf: [u8; 64],
> +///     #[pin]
> +///     pin: PhantomPinned,
> +/// }
> +/// pin_init!(&this in Buf {
> +///     buf: [0; 64],
> +///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
> +///     pin: PhantomPinned,
> +/// });
> +/// ```
> +///
> +/// [`try_pin_init!`]: kernel::try_pin_init
> +/// [`NonNull<Self>`]: core::ptr::NonNull
> +/// [`Error`]: kernel::error::Error
> +// For a detailed example of how this macro works, see the module documentation of the hidden
> +// module `__internal` inside of `init/__internal.rs`.
> +#[macro_export]
> +macro_rules! pin_init {
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error(::core::convert::Infallible),
> +        )
> +    };
> +}
> +
> +/// Construct an in-place, fallible pinned initializer for `struct`s.
> +///
> +/// If the initialization can complete without error (or [`Infallible`]), then use [`pin_init!`].
> +///
> +/// You can use the `?` operator or use `return Err(err)` inside the initializer to stop
> +/// initialization and return the error.
> +///
> +/// IMPORTANT: if you have `unsafe` code inside of the initializer you have to ensure that when
> +/// initialization fails, the memory can be safely deallocated without any further modifications.
> +///
> +/// This macro defaults the error to [`Error`].
> +///
> +/// The syntax is identical to [`pin_init!`] with the following exception: you can append `? $type`
> +/// after the `struct` initializer to specify the error type you want to use.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// # #![feature(new_uninit)]
> +/// use kernel::{init::{self, PinInit}, error::Error};
> +/// #[pin_data]
> +/// struct BigBuf {
> +///     big: Box<[u8; 1024 * 1024 * 1024]>,
> +///     small: [u8; 1024 * 1024],
> +///     ptr: *mut u8,
> +/// }
> +///
> +/// impl BigBuf {
> +///     fn new() -> impl PinInit<Self, Error> {
> +///         try_pin_init!(Self {
> +///             big: Box::init(init::zeroed())?,
> +///             small: [0; 1024 * 1024],
> +///             ptr: core::ptr::null_mut(),
> +///         }? Error)
> +///     }
> +/// }
> +/// ```
> +///
> +/// [`Error`]: kernel::error::Error
> +// For a detailed example of how this macro works, see the module documentation of the hidden
> +// module `__internal` inside of `init/__internal.rs`.
> +#[macro_export]
> +macro_rules! try_pin_init {
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)? ),
> +            @fields($($fields)*),
> +            @error($crate::error::Error),
> +        )
> +    };
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }? $err:ty) => {
> +        $crate::try_pin_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)? ),
> +            @fields($($fields)*),
> +            @error($err),
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +    ) => {{
> +        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
> +        // type and shadow it later when we insert the arbitrary user code. That way there will be
> +        // no possibility of returning without `unsafe`.
> +        struct __InitOk;
> +        // Get the pin data from the supplied type.
> +        let data = unsafe {
> +            use $crate::init::__internal::HasPinData;
> +            $t$(::<$($generics),*>)?::__pin_data()
> +        };
> +        // Ensure that `data` really is of type `PinData` and help with type inference:
> +        let init = $crate::init::__internal::PinData::make_closure::<_, __InitOk, $err>(
> +            data,
> +            move |slot| {
> +                {
> +                    // Shadow the structure so it cannot be used to return early.
> +                    struct __InitOk;
> +                    // Create the `this` so it can be referenced by the user inside of the
> +                    // expressions creating the individual fields.
> +                    $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
> +                    // Initialize every field.
> +                    $crate::try_pin_init!(init_slot:
> +                        @data(data),
> +                        @slot(slot),
> +                        @munch_fields($($fields)*,),
> +                    );
> +                    // We use unreachable code to ensure that all fields have been mentioned exactly
> +                    // once, this struct initializer will still be type-checked and complain with a
> +                    // very natural error message if a field is forgotten/mentioned more than once.
> +                    #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +                    if false {
> +                        $crate::try_pin_init!(make_initializer:
> +                            @slot(slot),
> +                            @type_name($t),
> +                            @munch_fields($($fields)*,),
> +                            @acc(),
> +                        );
> +                    }
> +                    // Forget all guards, since initialization was a success.
> +                    $crate::try_pin_init!(forget_guards:
> +                        @munch_fields($($fields)*,),
> +                    );
> +                }
> +                Ok(__InitOk)
> +            }
> +        );
> +        let init = move |slot| -> ::core::result::Result<(), $err> {
> +            init(slot).map(|__InitOk| ())
> +        };
> +        let init = unsafe { $crate::init::pin_init_from_closure::<_, $err>(init) };
> +        init
> +    }};
> +    (init_slot:
> +        @data($data:ident),
> +        @slot($slot:ident),
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Endpoint of munching, no fields are left.
> +    };
> +    (init_slot:
> +        @data($data:ident),
> +        @slot($slot:ident),
> +        // In-place initialization syntax.
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        let $field = $val;
> +        // Call the initializer.
> +        //
> +        // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
> +        // return when an error/panic occurs.
> +        // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
> +        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), $field)? };
> +        // Create the drop guard.
> +        //
> +        // We only give access to `&DropGuard`, so it cannot be forgotten via safe code.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = &unsafe {
> +            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +
> +        $crate::try_pin_init!(init_slot:
> +            @data($data),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (init_slot:
> +        @data($data:ident),
> +        @slot($slot:ident),
> +        // Direct value init, this is safe for every field.
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        $(let $field = $val;)?
> +        // Initialize the field.
> +        //
> +        // SAFETY: The memory at `slot` is uninitialized.
> +        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
> +        // Create the drop guard:
> +        //
> +        // We only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = &unsafe {
> +            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +
> +        $crate::try_pin_init!(init_slot:
> +            @data($data),
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields($(,)?),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch, create the initializer.
> +        // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
> +        // get the correct type inference here:
> +        unsafe {
> +            ::core::ptr::write($slot, $t {
> +                $($acc)*
> +            });
> +        }
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_pin_init!(make_initializer:
> +            @slot($slot),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)* $field: ::core::panic!(),),
> +        );
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_pin_init!(make_initializer:
> +            @slot($slot),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)* $field: ::core::panic!(),),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Munching finished.
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> +
> +        $crate::try_pin_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> +
> +        $crate::try_pin_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +}
> +
> +/// Construct an in-place initializer for `struct`s.
> +///
> +/// This macro defaults the error to [`Infallible`]. If you need [`Error`], then use
> +/// [`try_init!`].
> +///
> +/// The syntax is identical to [`pin_init!`] and its safety caveats also apply:
> +/// - `unsafe` code must guarantee either full initialization or return an error and allow
> +///   deallocation of the memory.
> +/// - the fields are initialized in the order given in the initializer.
> +/// - no references to fields are allowed to be created inside of the initializer.
> +///
> +/// This initializer is for initializing data in-place that might later be moved. If you want to
> +/// pin-initialize, use [`pin_init!`].
> +///
> +/// [`Error`]: kernel::error::Error
> +// For a detailed example of how this macro works, see the module documentation of the hidden
> +// module `__internal` inside of `init/__internal.rs`.
> +#[macro_export]
> +macro_rules! init {
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error(::core::convert::Infallible),
> +        )
> +    }
> +}
> +
> +/// Construct an in-place fallible initializer for `struct`s.
> +///
> +/// This macro defaults the error to [`Error`]. If you need [`Infallible`], then use
> +/// [`init!`].
> +///
> +/// The syntax is identical to [`try_pin_init!`]. If you want to specify a custom error,
> +/// append `? $type` after the `struct` initializer.
> +/// The safety caveats from [`try_pin_init!`] also apply:
> +/// - `unsafe` code must guarantee either full initialization or return an error and allow
> +///   deallocation of the memory.
> +/// - the fields are initialized in the order given in the initializer.
> +/// - no references to fields are allowed to be created inside of the initializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::{init::PinInit, error::Error, InPlaceInit};
> +/// struct BigBuf {
> +///     big: Box<[u8; 1024 * 1024 * 1024]>,
> +///     small: [u8; 1024 * 1024],
> +/// }
> +///
> +/// impl BigBuf {
> +///     fn new() -> impl Init<Self, Error> {
> +///         try_init!(Self {
> +///             big: Box::init(zeroed())?,
> +///             small: [0; 1024 * 1024],
> +///         }? Error)
> +///     }
> +/// }
> +/// ```
> +///
> +/// [`Error`]: kernel::error::Error
> +// For a detailed example of how this macro works, see the module documentation of the hidden
> +// module `__internal` inside of `init/__internal.rs`.
> +#[macro_export]
> +macro_rules! try_init {
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($crate::error::Error),
> +        )
> +    };
> +    ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
> +        $($fields:tt)*
> +    }? $err:ty) => {
> +        $crate::try_init!(
> +            @this($($this)?),
> +            @typ($t $(::<$($generics),*>)?),
> +            @fields($($fields)*),
> +            @error($err),
> +        )
> +    };
> +    (
> +        @this($($this:ident)?),
> +        @typ($t:ident $(::<$($generics:ty),*>)?),
> +        @fields($($fields:tt)*),
> +        @error($err:ty),
> +    ) => {{
> +        // We do not want to allow arbitrary returns, so we declare this type as the `Ok` return
> +        // type and shadow it later when we insert the arbitrary user code. That way there will be
> +        // no possibility of returning without `unsafe`.
> +        struct __InitOk;
> +        // Get the init data from the supplied type.
> +        let data = unsafe {
> +            use $crate::init::__internal::HasInitData;
> +            $t$(::<$($generics),*>)?::__init_data()
> +        };
> +        // Ensure that `data` really is of type `InitData` and help with type inference:
> +        let init = $crate::init::__internal::InitData::make_closure::<_, __InitOk, $err>(
> +            data,
> +            move |slot| {
> +                {
> +                    // Shadow the structure so it cannot be used to return early.
> +                    struct __InitOk;
> +                    // Create the `this` so it can be referenced by the user inside of the
> +                    // expressions creating the individual fields.
> +                    $(let $this = unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)?
> +                    // Initialize every field.
> +                    $crate::try_init!(init_slot:
> +                        @slot(slot),
> +                        @munch_fields($($fields)*,),
> +                    );
> +                    // We use unreachable code to ensure that all fields have been mentioned exactly
> +                    // once, this struct initializer will still be type-checked and complain with a
> +                    // very natural error message if a field is forgotten/mentioned more than once.
> +                    #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +                    if false {
> +                        $crate::try_init!(make_initializer:
> +                            @slot(slot),
> +                            @type_name($t),
> +                            @munch_fields($($fields)*,),
> +                            @acc(),
> +                        );
> +                    }
> +                    // Forget all guards, since initialization was a success.
> +                    $crate::try_init!(forget_guards:
> +                        @munch_fields($($fields)*,),
> +                    );
> +                }
> +                Ok(__InitOk)
> +            }
> +        );
> +        let init = move |slot| -> ::core::result::Result<(), $err> {
> +            init(slot).map(|__InitOk| ())
> +        };
> +        let init = unsafe { $crate::init::init_from_closure::<_, $err>(init) };
> +        init
> +    }};
> +    (init_slot:
> +        @slot($slot:ident),
> +        @munch_fields( $(,)?),
> +    ) => {
> +        // Endpoint of munching, no fields are left.
> +    };
> +    (init_slot:
> +        @slot($slot:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        let $field = $val;
> +        // Call the initializer.
> +        //
> +        // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
> +        // return when an error/panic occurs.
> +        unsafe {
> +            $crate::init::Init::__init($field, ::core::ptr::addr_of_mut!((*$slot).$field))?;
> +        }
> +        // Create the drop guard.
> +        //
> +        // We only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = &unsafe {
> +            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +
> +        $crate::try_init!(init_slot:
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (init_slot:
> +        @slot($slot:ident),
> +        // Direct value init.
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        $(let $field = $val;)?
> +        // Call the initializer.
> +        //
> +        // SAFETY: The memory at `slot` is uninitialized.
> +        unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
> +        // Create the drop guard.
> +        //
> +        // We only give access to `&DropGuard`, so it cannot be accidentally forgotten.
> +        //
> +        // SAFETY: We forget the guard later when initialization has succeeded.
> +        let $field = &unsafe {
> +            $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
> +        };
> +
> +        $crate::try_init!(init_slot:
> +            @slot($slot),
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields( $(,)?),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // Endpoint, nothing more to munch, create the initializer.
> +        // Since we are in the `if false` branch, this will never get executed. We abuse `slot` to
> +        // get the correct type inference here:
> +        unsafe {
> +            ::core::ptr::write($slot, $t {
> +                $($acc)*
> +            });
> +        }
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_init!(make_initializer:
> +            @slot($slot),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)*$field: ::core::panic!(),),
> +        );
> +    };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:ident),
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        $crate::try_init!(make_initializer:
> +            @slot($slot),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)*$field: ::core::panic!(),),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($(,)?),
> +    ) => {
> +        // Munching finished.
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> +
> +        $crate::try_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +    (forget_guards:
> +        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> +    ) => {
> +        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> +
> +        $crate::try_init!(forget_guards:
> +            @munch_fields($($rest)*),
> +        );
> +    };
> +}
>
>  /// A pin-initializer for the type `T`.
>  ///
> @@ -63,7 +862,6 @@ pub mod __internal;
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
>  /// [`UniqueArc<T>`]: kernel::sync::UniqueArc
> -/// [`Box<T>`]: alloc::boxed::Box
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -106,7 +904,6 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`UniqueArc<T>`]: kernel::sync::UniqueArc
> -/// [`Box<T>`]: alloc::boxed::Box
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
> index 08cbb5333438..681494a3d38f 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -31,3 +31,127 @@ where
>          (self.0)(slot)
>      }
>  }
> +
> +/// This trait is only implemented via the `#[pin_data]` proc-macro. It is used to facilitate
> +/// the pin projections within the initializers.
> +///
> +/// # Safety
> +///
> +/// Only the `init` module is allowed to use this trait.
> +pub unsafe trait HasPinData {
> +    type PinData: PinData;
> +
> +    unsafe fn __pin_data() -> Self::PinData;
> +}
> +
> +/// Marker trait for pinning data of structs.
> +///
> +/// # Safety
> +///
> +/// Only the `init` module is allowed to use this trait.
> +pub unsafe trait PinData: Copy {
> +    type Datee: ?Sized + HasPinData;
> +
> +    /// Type inference helper function.
> +    fn make_closure<F, O, E>(self, f: F) -> F
> +    where
> +        F: FnOnce(*mut Self::Datee) -> Result<O, E>,
> +    {
> +        f
> +    }
> +}
> +
> +/// This trait is automatically implemented for every type. It aims to provide the same type
> +/// inference help as `HasPinData`.
> +///
> +/// # Safety
> +///
> +/// Only the `init` module is allowed to use this trait.
> +pub unsafe trait HasInitData {
> +    type InitData: InitData;
> +
> +    unsafe fn __init_data() -> Self::InitData;
> +}
> +
> +/// Same function as `PinData`, but for arbitrary data.
> +///
> +/// # Safety
> +///
> +/// Only the `init` module is allowed to use this trait.
> +pub unsafe trait InitData: Copy {
> +    type Datee: ?Sized + HasInitData;
> +
> +    /// Type inference helper function.
> +    fn make_closure<F, O, E>(self, f: F) -> F
> +    where
> +        F: FnOnce(*mut Self::Datee) -> Result<O, E>,
> +    {
> +        f
> +    }
> +}
> +
> +pub struct AllData<T: ?Sized>(PhantomData<fn(Box<T>) -> Box<T>>);
> +
> +impl<T: ?Sized> Clone for AllData<T> {
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<T: ?Sized> Copy for AllData<T> {}
> +
> +unsafe impl<T: ?Sized> InitData for AllData<T> {
> +    type Datee = T;
> +}
> +
> +unsafe impl<T: ?Sized> HasInitData for T {
> +    type InitData = AllData<T>;
> +
> +    unsafe fn __init_data() -> Self::InitData {
> +        AllData(PhantomData)
> +    }
> +}
> +
> +/// When a value of this type is dropped, it drops a `T`.
> +///
> +/// Can be forgotton to prevent the drop.
> +pub struct DropGuard<T: ?Sized>(*mut T, Cell<bool>);
> +
> +impl<T: ?Sized> DropGuard<T> {
> +    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be a valid pointer.
> +    ///
> +    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
> +    /// - has not been dropped,
> +    /// - is not accessible by any other means,
> +    /// - will not be dropped by any other means.
> +    #[inline]
> +    pub unsafe fn new(ptr: *mut T) -> Self {
> +        Self(ptr, Cell::new(true))
> +    }
> +
> +    /// Prevents this guard from dropping the supplied pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This function is unsafe in order to prevent safe code from forgetting this guard. It should
> +    /// only be called by the macros in this module.
> +    #[inline]
> +    pub unsafe fn forget(&self) {
> +        self.1.set(false);
> +    }
> +}
> +
> +impl<T: ?Sized> Drop for DropGuard<T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        if self.1.get() {
> +            // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> +            // ensuring that this operation is safe.
> +            unsafe { ptr::drop_in_place(self.0) }
> +        }
> +    }
> +}
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> new file mode 100644
> index 000000000000..e27c309c7ffd
> --- /dev/null
> +++ b/rust/kernel/init/macros.rs
> @@ -0,0 +1,707 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! This module provides the macros that actually implement the proc-macros `pin_data` and
> +//! `pinned_drop`.
> +//!
> +//! These macros should never be called directly, since they expect their input to be
> +//! in a certain format which is internal. Use the proc-macros instead.
> +//!
> +//! This architecture has been chosen because the kernel does not yet have access to `syn` which
> +//! would make matters a lot easier for implementing these as proc-macros.
> +//!
> +//! # Macro expansion example
> +//!
> +//! This section is intended for readers trying to understand the macros in this module and the
> +//! `pin_init!` macros from `init.rs`.
> +//!
> +//! We will look at the following example:
> +//!
> +//! ```rust
> +//! # use kernel::init::*;
> +//! #[pin_data]
> +//! #[repr(C)]
> +//! struct Bar<T> {
> +//!     #[pin]
> +//!     t: T,
> +//!     pub x: usize,
> +//! }
> +//!
> +//! impl<T> Bar<T> {
> +//!     fn new(t: T) -> impl PinInit<Self> {
> +//!         pin_init!(Self { t, x: 0 })
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! This example includes the most common and important features of the pin-init API.
> +//!
> +//! Below you can find individual section about the different macro invocations. Here are some
> +//! general things we need to take into account when designing macros:
> +//! - use global paths, similarly to file paths, these start with the separator: `::core::panic!()`
> +//!   this ensures that the correct item is used, since users could define their own `mod core {}`
> +//!   and then their own `panic!` inside to execute arbitrary code inside of our macro.
> +//! - macro `unsafe` hygene: we need to ensure that we do not expand arbitrary, user-supplied
> +//!   expressions inside of an `unsafe` block in the macro, because this would allow users to do
> +//!   `unsafe` operations without an associated `unsafe` block.
> +//!
> +//! ## `#[pin_data]` on `Bar`
> +//!
> +//! This macro is used to specify which fields are structurally pinned and which fields are not. It
> +//! is placed on the struct definition and allows `#[pin]` to be placed on the fields.
> +//!
> +//! Here is the definition of `Bar` from our example:
> +//!
> +//! ```rust
> +//! # use kernel::init::*;
> +//! #[pin_data]
> +//! #[repr(C)]
> +//! struct Bar<T> {
> +//!     t: T,
> +//!     pub x: usize,
> +//! }
> +//! ```
> +//!
> +//! This expands to the following code:
> +//!
> +//! ```rust
> +//! // Firstly the normal definition of the struct, attributes are preserved:
> +//! #[repr(C)]
> +//! struct Bar<T> {
> +//!     t: T,
> +//!     pub x: usize,
> +//! }
> +//! // Then an anonymous constant is defined, this is because we do not want any code to access the
> +//! // types that we define inside:
> +//! const _: () = {
> +//!     // We define the pin-data carrying struct, it is a ZST and needs to have the same generics,
> +//!     // since we need to implement access functions for each field and thus need to know its
> +//!     // type.
> +//!     struct __ThePinData<T> {
> +//!         __phantom: ::core::marker::PhantomData<fn(Bar<T>) -> Bar<T>>,
> +//!     }
> +//!     // We implement `Copy` for the pin-data struct, since all functions it defines will take
> +//!     // `self` by value.
> +//!     impl<T> ::core::clone::Clone for __ThePinData<T> {
> +//!         fn clone(&self) -> Self {
> +//!             *self
> +//!         }
> +//!     }
> +//!     impl<T> ::core::marker::Copy for __ThePinData<T> {}
> +//!     // For every field of `Bar`, the pin-data struct will define a function with the same name
> +//!     // and accessor (`pub` or `pub(crate)` etc.). This function will take a pointer to the
> +//!     // field (`slot`) and a `PinInit` or `Init` depending on the projection kind of the field
> +//!     // (if pinning is structural for the field, then `PinInit` otherwise `Init`).
> +//!     #[allow(dead_code)]
> +//!     impl<T> __ThePinData<T> {
> +//!         unsafe fn t<E>(
> +//!             self,
> +//!             slot: *mut T,
> +//!             init: impl ::kernel::init::Init<T, E>,
> +//!         ) -> ::core::result::Result<(), E> {
> +//!             unsafe { ::kernel::init::Init::__init(init, slot) }
> +//!         }
> +//!         pub unsafe fn x<E>(
> +//!             self,
> +//!             slot: *mut usize,
> +//!             init: impl ::kernel::init::Init<usize, E>,
> +//!         ) -> ::core::result::Result<(), E> {
> +//!             unsafe { ::kernel::init::Init::__init(init, slot) }
> +//!         }
> +//!     }
> +//!     // Implement the internal `HasPinData` trait that associates `Bar` with the pin-data struct
> +//!     // that we constructed beforehand.
> +//!     unsafe impl<T> ::kernel::init::__internal::HasPinData for Bar<T> {
> +//!         type PinData = __ThePinData<T>;
> +//!         unsafe fn __pin_data() -> Self::PinData {
> +//!             __ThePinData {
> +//!                 __phantom: ::core::marker::PhantomData,
> +//!             }
> +//!         }
> +//!     }
> +//!     // Implement the internal `PinData` trait that marks the pin-data struct as a pin-data
> +//!     // struct. This is important to ensure that no user can implement a rouge `__pin_data`
> +//!     // function without using `unsafe`.
> +//!     unsafe impl<T> ::kernel::init::__internal::PinData for __ThePinData<T> {
> +//!         type Datee = Bar<T>;
> +//!     }
> +//!     // Now we only want to implement `Unpin` for `Bar` when every structurally pinned field is
> +//!     // `Unpin`. In other words, whether `Bar` is `Unpin` only depends on structurally pinned
> +//!     // fields (those marked with `#[pin]`). These fields will be listed in this struct, in our
> +//!     // case no such fields exist, hence this is almost empty. The two phantomdata fields exist
> +//!     // for two reasons:
> +//!     // - `__phantom`: every generic must be used, since we cannot really know which generics
> +//!     //   are used, we declere all and then use everything here once.
> +//!     // - `__phantom_pin`: uses the `'__pin` lifetime and ensures that this struct is invariant
> +//!     //   over it. The lifetime is needed to work around the limitation that trait bounds must
> +//!     //   not be trivial, e.g. the user has a `#[pin] PhantomPinned` field -- this is
> +//!     //   unconditionally `!Unpin` and results in an error. The lifetime tricks the compiler
> +//!     //   into accepting these bounds regardless.
> +//!     #[allow(dead_code)]
> +//!     struct __Unpin<'__pin, T> {
> +//!         __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &'__pin ()>,
> +//!         __phantom: ::core::marker::PhantomData<fn(Bar<T>) -> Bar<T>>,
> +//!     }
> +//!     #[doc(hidden)]
> +//!     impl<'__pin, T>
> +//!         ::core::marker::Unpin for Bar<T> where __Unpin<'__pin, T>: ::core::marker::Unpin {}
> +//!     // Now we need to ensure that `Bar` does not implement `Drop`, since that would give users
> +//!     // access to `&mut self` inside of `drop` even if the struct was pinned. This could lead to
> +//!     // UB with only safe code, so we disallow this by giving a trait implementation error using
> +//!     // a direct impl and a blanket implementation.
> +//!     trait MustNotImplDrop {}
> +//!     // Normally `Drop` bounds do not have the correct semantics, but for this purpose they do
> +//!     // (normally people want to know if a type has any kind of drop glue at all, here we want
> +//!     // to know if it has any kind of custom drop glue, which is exactly what this bound does).
> +//!     #[allow(drop_bounds)]
> +//!     impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
> +//!     impl<T> MustNotImplDrop for Bar<T> {}
> +//! };
> +//! ```
> +//!
> +//! ## `pin_init!` in `impl Bar`
> +//!
> +//! This macro creates an pin-initializer for the given struct. It requires that the struct is
> +//! annotated by `#[pin_data]`.
> +//!
> +//! Here is the impl on `Bar` defining the new function:
> +//!
> +//! ```rust
> +//! impl<T> Bar<T> {
> +//!     fn new(t: T) -> impl PinInit<Self> {
> +//!         pin_init!(Self { t, x: 0 })
> +//!     }
> +//! }
> +//! ```
> +//!
> +//! This expands to the following code:
> +//!
> +//! ```rust
> +//! impl<T> Bar<T> {
> +//!     fn new(t: T) -> impl PinInit<Self> {
> +//!         {
> +//!             // We do not want to allow arbitrary returns, so we declare this type as the `Ok`
> +//!             // return type and shadow it later when we insert the arbitrary user code. That way
> +//!             // there will be no possibility of returning without `unsafe`.
> +//!             struct __InitOk;
> +//!             // Get the pin-data type from the initialized type.
> +//!             // - the function is unsafe, hence the unsafe block
> +//!             // - we `use` the `HasPinData` trait in the block, it is only available in that
> +//!             //   scope.
> +//!             let data = unsafe {
> +//!                 use ::kernel::init::__internal::HasPinData;
> +//!                 Self::__pin_data()
> +//!             };
> +//!             // Use `data` to help with type inference, the closure supplied will have the type
> +//!             // `FnOnce(*mut Self) -> Result<__InitOk, Infallible>`.
> +//!             let init = ::kernel::init::__internal::PinData::make_closure::<
> +//!                 _,
> +//!                 __InitOk,
> +//!                 ::core::convert::Infallible,
> +//!             >(data, move |slot| {
> +//!                 {
> +//!                     // Shadow the structure so it cannot be used to return early. If a user
> +//!                     // tries to write `return Ok(__InitOk)`, then they get a type error, since
> +//!                     // that will refer to this struct instead of the one defined above.
> +//!                     struct __InitOk;
> +//!                     // This is the expansion of `t,`, which is syntactic sugar for `t: t,`.
> +//!                     unsafe { ::core::ptr::write(&raw mut (*slot).t, t) };
> +//!                     // Since initialization could fail later (not in this case, since the error
> +//!                     // type is `Infallible`) we will need to drop this field if it fails. This
> +//!                     // `DropGuard` will drop the field when it gets dropped and has not yet
> +//!                     // been forgotten. We make a reference to it, so users cannot `mem::forget`
> +//!                     // it from the initializer, since the name is the same as the field.
> +//!                     let t = &unsafe {
> +//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).t)
> +//!                     };
> +//!                     // Expansion of `x: 0,`:
> +//!                     // Since this can be an arbitrary expression we cannot place it inside of
> +//!                     // the `unsafe` block, so we bind it here.
> +//!                     let x = 0;
> +//!                     unsafe { ::core::ptr::write(&raw mut (*slot).x, x) };
> +//!                     let x = &unsafe {
> +//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).x)
> +//!                     };
> +//!
> +//!                     // Here we use the type checker to ensuer that every field has been
> +//!                     // initialized exactly once, since this is `if false` it will never get
> +//!                     // executed, but still type-checked.
> +//!                     // Additionally we abuse `slot` to automatically infer the correct type for
> +//!                     // the struct. This is also another check that every field is accessible
> +//!                     // from this scope.
> +//!                     #[allow(unreachable_code, clippy::diverging_sub_expression)]
> +//!                     if false {
> +//!                         unsafe {
> +//!                             ::core::ptr::write(
> +//!                                 slot,
> +//!                                 Self {
> +//!                                     // We only care about typecheck finding every field here,
> +//!                                     // the expression does not matter, just conjure one using
> +//!                                     // `panic!()`:
> +//!                                     t: ::core::panic!(),
> +//!                                     x: ::core::panic!(),
> +//!                                 },
> +//!                             );
> +//!                         };
> +//!                     }
> +//!                     // Since initialization has successfully completed, we can now forget the
> +//!                     // guards.
> +//!                     unsafe { ::kernel::init::__internal::DropGuard::forget(t) };
> +//!                     unsafe { ::kernel::init::__internal::DropGuard::forget(x) };
> +//!                 }
> +//!                 // We leave the scope above and gain access to the previously shadowed
> +//!                 // `__InitOk` that we need to return.
> +//!                 Ok(__InitOk)
> +//!             });
> +//!             // Change the return type of the closure.
> +//!             let init = move |slot| -> ::core::result::Result<(), ::core::convert::Infallible> {
> +//!                 init(slot).map(|__InitOk| ())
> +//!             };
> +//!             // Construct the initializer.
> +//!             let init = unsafe {
> +//!                 ::kernel::init::pin_init_from_closure::<_, ::core::convert::Infallible>(init)
> +//!             };
> +//!             init
> +//!         }
> +//!     }
> +//! }
> +//! ```
> +
> +/// This macro first parses the struct definition such that it separates pinned and not pinned
> +/// fields. Afterwards it declares the struct and implement the `PinData` trait safely.
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! __pin_data {
> +    // Proc-macro entry point, this is supplied by the proc-macro pre-parsing.
> +    (parse_input:
> +        @args($($pinned_drop:ident)?),
> +        @sig(
> +            $(#[$($struct_attr:tt)*])*
> +            $vis:vis struct $name:ident
> +            $(where $($whr:tt)*)?
> +        ),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @body({ $($fields:tt)* }),
> +    ) => {
> +        // We now use token munching to iterate through all of the fields. While doing this we
> +        // identify fields marked with `#[pin]`, these fields are the 'pinned fields'. The user
> +        // wants these to be structurally pinned. The rest of the fields are the
> +        // 'not pinned fields'. Additionally we collect all fields, since we need them in the right
> +        // order to declare the struct.
> +        //
> +        // In this call we also put some explaining comments for the parameters.
> +        $crate::__pin_data!(find_pinned_fields:
> +            // Attributes on the struct itself, these will just be propagated to be put onto the
> +            // struct definition.
> +            @struct_attrs($(#[$($struct_attr)*])*),
> +            // The visibility of the struct.
> +            @vis($vis),
> +            // The name of the struct.
> +            @name($name),
> +            // The 'impl generics', the generics that will need to be specified on the struct inside
> +            // of an `impl<$ty_generics>` block.
> +            @impl_generics($($impl_generics)*),
> +            // The 'ty generics', the generics that will need to be specified on the impl blocks.
> +            @ty_generics($($ty_generics)*),
> +            // The where clause of any impl block and the declaration.
> +            @where($($($whr)*)?),
> +            // The remaining fields tokens that need to be processed.
> +            // We add a `,` at the end to ensure correct parsing.
> +            @fields_munch($($fields)* ,),
> +            // The pinned fields.
> +            @pinned(),
> +            // The not pinned fields.
> +            @not_pinned(),
> +            // All fields.
> +            @fields(),
> +            // The accumulator containing all attributes already parsed.
> +            @accum(),
> +            // Contains `yes` or `` to indicate if `#[pin]` was found on the current field.
> +            @is_pinned(),
> +            // The proc-macro argument, this should be `PinnedDrop` or ``.
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We found a PhantomPinned field, this should generally be pinned!
> +        @fields_munch($field:ident : $($($(::)?core::)?marker::)?PhantomPinned, $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        // This field is not pinned.
> +        @is_pinned(),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        ::core::compile_error!(concat!(
> +            "The field `",
> +            stringify!($field),
> +            "` of type `PhantomPinned` only has an effect, if it has the `#[pin]` attribute.",
> +        ));
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($($rest)*),
> +            @pinned($($pinned)* $($accum)* $field: ::core::marker::PhantomPinned,),
> +            @not_pinned($($not_pinned)*),
> +            @fields($($fields)* $($accum)* $field: ::core::marker::PhantomPinned,),
> +            @accum(),
> +            @is_pinned(),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We reached the field declaration.
> +        @fields_munch($field:ident : $type:ty, $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        // This field is pinned.
> +        @is_pinned(yes),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($($rest)*),
> +            @pinned($($pinned)* $($accum)* $field: $type,),
> +            @not_pinned($($not_pinned)*),
> +            @fields($($fields)* $($accum)* $field: $type,),
> +            @accum(),
> +            @is_pinned(),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We reached the field declaration.
> +        @fields_munch($field:ident : $type:ty, $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        // This field is not pinned.
> +        @is_pinned(),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($($rest)*),
> +            @pinned($($pinned)*),
> +            @not_pinned($($not_pinned)* $($accum)* $field: $type,),
> +            @fields($($fields)* $($accum)* $field: $type,),
> +            @accum(),
> +            @is_pinned(),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We found the `#[pin]` attr.
> +        @fields_munch(#[pin] $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        @is_pinned($($is_pinned:ident)?),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($($rest)*),
> +            // We do not include `#[pin]` in the list of attributes, since it is not actually an
> +            // attribute that is defined somewhere.
> +            @pinned($($pinned)*),
> +            @not_pinned($($not_pinned)*),
> +            @fields($($fields)*),
> +            @accum($($accum)*),
> +            // Set this to `yes`.
> +            @is_pinned(yes),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We reached the field declaration with visibility, for simplicity we only munch the
> +        // visibility and put it into `$accum`.
> +        @fields_munch($fvis:vis $field:ident $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        @is_pinned($($is_pinned:ident)?),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($field $($rest)*),
> +            @pinned($($pinned)*),
> +            @not_pinned($($not_pinned)*),
> +            @fields($($fields)*),
> +            @accum($($accum)* $fvis),
> +            @is_pinned($($is_pinned)?),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // Some other attribute, just put it into `$accum`.
> +        @fields_munch(#[$($attr:tt)*] $($rest:tt)*),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum($($accum:tt)*),
> +        @is_pinned($($is_pinned:ident)?),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        $crate::__pin_data!(find_pinned_fields:
> +            @struct_attrs($($struct_attrs)*),
> +            @vis($vis),
> +            @name($name),
> +            @impl_generics($($impl_generics)*),
> +            @ty_generics($($ty_generics)*),
> +            @where($($whr)*),
> +            @fields_munch($($rest)*),
> +            @pinned($($pinned)*),
> +            @not_pinned($($not_pinned)*),
> +            @fields($($fields)*),
> +            @accum($($accum)* #[$($attr)*]),
> +            @is_pinned($($is_pinned)?),
> +            @pinned_drop($($pinned_drop)?),
> +        );
> +    };
> +    (find_pinned_fields:
> +        @struct_attrs($($struct_attrs:tt)*),
> +        @vis($vis:vis),
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        // We reached the end of the fields, plus an optional additional comma, since we added one
> +        // before and the user is also allowed to put a trailing comma.
> +        @fields_munch($(,)?),
> +        @pinned($($pinned:tt)*),
> +        @not_pinned($($not_pinned:tt)*),
> +        @fields($($fields:tt)*),
> +        @accum(),
> +        @is_pinned(),
> +        @pinned_drop($($pinned_drop:ident)?),
> +    ) => {
> +        // Declare the struct with all fields in the correct order.
> +        $($struct_attrs)*
> +        $vis struct $name <$($impl_generics)*>
> +        where $($whr)*
> +        {
> +            $($fields)*
> +        }
> +
> +        // We put the rest into this const item, because it then will not be accessible to anything
> +        // outside.
> +        const _: () = {
> +            // We declare this struct which will host all of the projection function for our type.
> +            // it will be invariant over all generic parameters which are inherited from the
> +            // struct.
> +            $vis struct __ThePinData<$($impl_generics)*>
> +            where $($whr)*
> +            {
> +                __phantom: ::core::marker::PhantomData<
> +                    fn($name<$($ty_generics)*>) -> $name<$($ty_generics)*>
> +                >,
> +            }
> +
> +            impl<$($impl_generics)*> ::core::clone::Clone for __ThePinData<$($ty_generics)*>
> +            where $($whr)*
> +            {
> +                fn clone(&self) -> Self { *self }
> +            }
> +
> +            impl<$($impl_generics)*> ::core::marker::Copy for __ThePinData<$($ty_generics)*>
> +            where $($whr)*
> +            {}
> +
> +            // Make all projection functions.
> +            $crate::__pin_data!(make_pin_data:
> +                @pin_data(__ThePinData),
> +                @impl_generics($($impl_generics)*),
> +                @ty_generics($($ty_generics)*),
> +                @where($($whr)*),
> +                @pinned($($pinned)*),
> +                @not_pinned($($not_pinned)*),
> +            );
> +
> +            // SAFETY: We have added the correct projection functions above to `__ThePinData` and
> +            // we also use the least restrictive generics possible.
> +            unsafe impl<$($impl_generics)*>
> +                $crate::init::__internal::HasPinData for $name<$($ty_generics)*>
> +            where $($whr)*
> +            {
> +                type PinData = __ThePinData<$($ty_generics)*>;
> +
> +                unsafe fn __pin_data() -> Self::PinData {
> +                    __ThePinData { __phantom: ::core::marker::PhantomData }
> +                }
> +            }
> +
> +            unsafe impl<$($impl_generics)*>
> +                $crate::init::__internal::PinData for __ThePinData<$($ty_generics)*>
> +            where $($whr)*
> +            {
> +                type Datee = $name<$($ty_generics)*>;
> +            }
> +
> +            // This struct will be used for the unpin analysis. Since only structurally pinned
> +            // fields are relevant whether the struct should implement `Unpin`.
> +            #[allow(dead_code)]
> +            struct __Unpin <'__pin, $($impl_generics)*>
> +            where $($whr)*
> +            {
> +                __phantom_pin: ::core::marker::PhantomData<fn(&'__pin ()) -> &'__pin ()>,
> +                __phantom: ::core::marker::PhantomData<
> +                    fn($name<$($ty_generics)*>) -> $name<$($ty_generics)*>
> +                >,
> +                // Only the pinned fields.
> +                $($pinned)*
> +            }
> +
> +            #[doc(hidden)]
> +            impl<'__pin, $($impl_generics)*> ::core::marker::Unpin for $name<$($ty_generics)*>
> +            where
> +                __Unpin<'__pin, $($ty_generics)*>: ::core::marker::Unpin,
> +                $($whr)*
> +            {}
> +
> +            // We need to disallow normal `Drop` implementation, the exact behavior depends on
> +            // whether `PinnedDrop` was specified as the parameter.
> +            $crate::__pin_data!(drop_prevention:
> +                @name($name),
> +                @impl_generics($($impl_generics)*),
> +                @ty_generics($($ty_generics)*),
> +                @where($($whr)*),
> +                @pinned_drop($($pinned_drop)?),
> +            );
> +        };
> +    };
> +    // When no `PinnedDrop` was specified, then we have to prevent implementing drop.
> +    (drop_prevention:
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        @pinned_drop(),
> +    ) => {
> +        // We prevent this by creating a trait that will be implemented for all types implementing
> +        // `Drop`. Additionally we will implement this trait for the struct leading to a conflict,
> +        // if it also implements `Drop`
> +        trait MustNotImplDrop {}
> +        #[allow(drop_bounds)]
> +        impl<T: ::core::ops::Drop> MustNotImplDrop for T {}
> +        impl<$($impl_generics)*> MustNotImplDrop for $name<$($ty_generics)*>
> +        where $($whr)* {}
> +    };
> +    // If some other parameter was specified, we emit a readable error.
> +    (drop_prevention:
> +        @name($name:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        @pinned_drop($($rest:tt)*),
> +    ) => {
> +        compile_error!(
> +            "Wrong parameters to `#[pin_data]`, expected nothing or `PinnedDrop`, got '{}'.",
> +            stringify!($($rest)*),
> +        );
> +    };
> +    (make_pin_data:
> +        @pin_data($pin_data:ident),
> +        @impl_generics($($impl_generics:tt)*),
> +        @ty_generics($($ty_generics:tt)*),
> +        @where($($whr:tt)*),
> +        @pinned($($(#[$($p_attr:tt)*])* $pvis:vis $p_field:ident : $p_type:ty),* $(,)?),
> +        @not_pinned($($(#[$($attr:tt)*])* $fvis:vis $field:ident : $type:ty),* $(,)?),
> +    ) => {
> +        // For every field, we create a projection function according to its projection type. If a
> +        // field is structurally pinned, then it must be initialized via `PinInit`, if it is not
> +        // structurally pinned, then it can be initialized via `Init`.
> +        //
> +        // The functions are `unsafe` to prevent accidentally calling them.
> +        #[allow(dead_code)]
> +        impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
> +        where $($whr)*
> +        {
> +            $(
> +                $pvis unsafe fn $p_field<E>(
> +                    self,
> +                    slot: *mut $p_type,
> +                    init: impl $crate::init::PinInit<$p_type, E>,
> +                ) -> ::core::result::Result<(), E> {
> +                    unsafe { $crate::init::PinInit::__pinned_init(init, slot) }
> +                }
> +            )*
> +            $(
> +                $fvis unsafe fn $field<E>(
> +                    self,
> +                    slot: *mut $type,
> +                    init: impl $crate::init::Init<$type, E>,
> +                ) -> ::core::result::Result<(), E> {
> +                    unsafe { $crate::init::Init::__init(init, slot) }
> +                }
> +            )*
> +        }
> +    };
> +}
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 82b520f024dd..4def038fe71a 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -7,6 +7,7 @@ mod quote;
>  mod concat_idents;
>  mod helpers;
>  mod module;
> +mod pin_data;
>  mod vtable;
>
>  use proc_macro::TokenStream;
> @@ -168,3 +169,31 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
>  pub fn concat_idents(ts: TokenStream) -> TokenStream {
>      concat_idents::concat_idents(ts)
>  }
> +
> +/// Used to specify the pinning information of the fields of a struct.
> +///
> +/// This is somewhat similar in purpose as
> +/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
> +/// Place this macro on a struct definition and then `#[pin]` in front of the attributes of each
> +/// field you want to structurally pin.
> +///
> +/// This macro enables the use of the [`pin_init!`] macro. When pin-initializing a `struct`,
> +/// then `#[pin]` directs the type of intializer that is required.
> +///
> +/// # Examples
> +///
> +/// ```rust,ignore
> +/// #[pin_data]
> +/// struct DriverData {
> +///     #[pin]
> +///     queue: Mutex<Vec<Command>>,
> +///     buf: Box<[u8; 1024 * 1024]>,
> +/// }
> +/// ```
> +///
> +/// [`pin_init!`]: ../kernel/macro.pin_init.html
> +//  ^ cannot use direct link, since `kernel` is not a dependency of `macros`.
> +#[proc_macro_attribute]
> +pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
> +    pin_data::pin_data(inner, item)
> +}
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> new file mode 100644
> index 000000000000..954149d77181
> --- /dev/null
> +++ b/rust/macros/pin_data.rs
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +use proc_macro::{Punct, Spacing, TokenStream, TokenTree};
> +
> +pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
> +    // This proc-macro only does some pre-parsing and then delegates the actual parsing to
> +    // `kernel::__pin_data!`.
> +    //
> +    // In here we only collect the generics, since parsing them in declarative macros is very
> +    // elaborate. We also do not need to analyse their structure, we only need to collect them.
> +
> +    // `impl_generics`, the declared generics with their bounds.
> +    let mut impl_generics = vec![];
> +    // Only the names of the generics, without any bounds.
> +    let mut ty_generics = vec![];
> +    // Tokens not related to the generics e.g. the `impl` token.
> +    let mut rest = vec![];
> +    // The current level of `<`.
> +    let mut nesting = 0;
> +    let mut toks = input.into_iter();
> +    // If we are at the beginning of a generic parameter.
> +    let mut at_start = true;
> +    for tt in &mut toks {
> +        match tt.clone() {
> +            TokenTree::Punct(p) if p.as_char() == '<' => {
> +                if nesting >= 1 {
> +                    impl_generics.push(tt);
> +                }
> +                nesting += 1;
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '>' => {
> +                if nesting == 0 {
> +                    break;
> +                } else {
> +                    nesting -= 1;
> +                    if nesting >= 1 {
> +                        impl_generics.push(tt);
> +                    }
> +                    if nesting == 0 {
> +                        break;
> +                    }
> +                }
> +            }
> +            tt => {
> +                if nesting == 1 {
> +                    match &tt {
> +                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> +                        TokenTree::Ident(_) if at_start => {
> +                            ty_generics.push(tt.clone());
> +                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> +                            at_start = false;
> +                        }
> +                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> +                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> +                            ty_generics.push(tt.clone());
> +                        }
> +                        _ => {}
> +                    }
> +                }
> +                if nesting >= 1 {
> +                    impl_generics.push(tt);
> +                } else if nesting == 0 {
> +                    rest.push(tt);
> +                }
> +            }
> +        }
> +    }
> +    rest.extend(toks);
> +    // This should be the body of the struct `{...}`.
> +    let last = rest.pop();
> +    quote!(::kernel::__pin_data! {
> +        parse_input:
> +        @args(#args),
> +        @sig(#(#rest)*),
> +        @impl_generics(#(#impl_generics)*),
> +        @ty_generics(#(#ty_generics)*),
> +        @body(#last),
> +    })
> +}
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index 94a6277182ee..c8e08b3c1e4c 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -38,7 +38,6 @@ impl ToTokens for TokenStream {
>  /// This is a similar to the
>  /// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
>  /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
> -#[allow(unused_macros)]
>  macro_rules! quote_spanned {
>      ($span:expr => $($tt:tt)*) => {
>      #[allow(clippy::vec_init_then_push)]
> @@ -137,7 +136,6 @@ macro_rules! quote_spanned {
>  /// `macros` crate.
>  ///
>  /// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.Span.html#method.mixed_site
> -#[allow(unused_macros)]
>  macro_rules! quote {
>      ($($tt:tt)*) => {
>          quote_spanned!(::proc_macro::Span::mixed_site() => $($tt)*)

