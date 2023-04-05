Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3126D899A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjDEVfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjDEVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:35:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6A7A9F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:35:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w9so144556946edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680730509;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=XsbPLOoZy3IpCVle9f3gfXkiDPXo3wFa1tXKUWRKGVg=;
        b=p0m+HR1QQ3N+oi6geD/qwqW7kEa4uqZsXJHk3StcmFJTsjTxSXLBuJzEZeKbVTf69X
         kFBbgPdfJSIEl/j6MZSWFMzNZGHFg5HKSvg6l11ehsHq/GnWjreNi6Q1bZkhL9sYl95b
         4Z25B1HJt1GmR9s+9S8Co0m+ZRaLZ4ybI+ycA+nqBqoG8oIP5cnStCEvCoy5dIDcNmhJ
         ngslMDl5mQT3FdIBE8Kvt9U7M09W8YG6drbBl7KKd5rxT3Sh/N4po3g64M7coBnRUg9S
         vtXRjhhaRDha82MZ8NK1Q5cptG4C0r7yeCUIwSSgB4sXhHpjyFnsjnwbVxrbLBud7xU4
         oSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680730509;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsbPLOoZy3IpCVle9f3gfXkiDPXo3wFa1tXKUWRKGVg=;
        b=Fm7vh84slozWA0TNG1+LeS34twAYNpFkVSe7VRhIOdk4MR0RlncaZsCvXPHbO+a3W/
         U8gbuz5KDl9wMivaOkRYgTmdrqe4S/EDMzJHx2HYcUkppRB65dqigggoDJvwej1VL86I
         JujMASa8HAQdauQq2LkPG5PgSHk7uMT7lmGFBlnWIyiLOsfQsy1/Ebztwqph3iyqOvaE
         F2t8XH1sv++jB8T5g0DNEpuZ8w+DFKjwOo4hR9P0+PgfLV+YN5RzQ1p9qQANaAvdHNb9
         //pd+lv/EUbfU0Ry8H8LD0/hU2LxMSa9Yo8rggYhaP9WfB+otlVui0hoWrstg//bhGtG
         u4lA==
X-Gm-Message-State: AAQBX9eDHsWD7h5gVU6M14cRRFhA0sE20LQ8Slfj5NNVa0Idjqvl1tk8
        DhvTwGYpeYInonHbk50riuokwg==
X-Google-Smtp-Source: AKy350Y1d7gbDVVNTMqhI+CI6pBTgOs7TRKtMFmndCYIelLHIglwKV/vWSWJO9AopwvBlNldCSA+6A==
X-Received: by 2002:a17:906:d79b:b0:93f:9b68:a0f4 with SMTP id pj27-20020a170906d79b00b0093f9b68a0f4mr3707529ejb.26.1680730509442;
        Wed, 05 Apr 2023 14:35:09 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id qp24-20020a170907207800b0093f822321fesm7799826ejb.137.2023.04.05.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:35:09 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-9-y86-dev@protonmail.com>
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
Subject: Re: [PATCH v6 08/15] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Date:   Wed, 05 Apr 2023 23:34:35 +0200
In-reply-to: <20230405193445.745024-9-y86-dev@protonmail.com>
Message-ID: <87355et3lf.fsf@metaspace.dk>
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

> The `InPlaceInit` trait that provides two functions, for initializing
> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
> `UniqueArc<T>` and `Box<T>`.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/init.rs     | 128 ++++++++++++++++++++++++++++++++++++----
>  rust/kernel/sync/arc.rs |  24 ++++++++
>  2 files changed, 139 insertions(+), 13 deletions(-)
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index ecef0376d726..6499cf5c9c20 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -114,10 +114,16 @@
>  //! [`impl Init<T, E>`]: Init
>  //! [`Opaque`]: kernel::types::Opaque
>  //! [`pin_data`]: ::macros::pin_data
> -//! [`UniqueArc<T>`]: kernel::sync::UniqueArc
>
> +use crate::{
> +    error::{self, Error},
> +    sync::UniqueArc,
> +};
>  use alloc::boxed::Box;
> -use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit, ptr};
> +use core::{
> +    alloc::AllocError, cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit,
> +    pin::Pin, ptr,
> +};
>
>  #[doc(hidden)]
>  pub mod __internal;
> @@ -309,7 +315,6 @@ pub mod macros;
>  ///
>  /// [`try_pin_init!`]: kernel::try_pin_init
>  /// [`NonNull<Self>`]: core::ptr::NonNull
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -363,8 +368,6 @@ macro_rules! pin_init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -586,8 +589,6 @@ macro_rules! try_pin_init {
>  ///
>  /// This initializer is for initializing data in-place that might later be moved. If you want to
>  /// pin-initialize, use [`pin_init!`].
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -635,8 +636,6 @@ macro_rules! init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -842,7 +841,8 @@ macro_rules! try_init {
>  /// A pin-initializer for the type `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> +/// smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -861,7 +861,6 @@ macro_rules! try_init {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -878,7 +877,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`] is a super trait, you can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> +/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
>  /// use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
> @@ -903,7 +903,6 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// move the pointee after initialization.
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait Init<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -982,3 +981,106 @@ unsafe impl<T> Init<T> for T {
>          Ok(())
>      }
>  }
> +
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
> +    /// type.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>;
> +
> +    /// Use the given pin-initializer to pin-initialize a `T` inside of a new smart pointer of this
> +    /// type.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        // SAFETY: We delegate to `init` and only change the error type.
> +        let init = unsafe {
> +            pin_init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
> +        };
> +        Self::try_pin_init(init)
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        // SAFETY: We delegate to `init` and only change the error type.
> +        let init = unsafe {
> +            init_from_closure(|slot| init.__pinned_init(slot).map_err(|e| Error::from(e)))
> +        };
> +        Self::try_init(init)
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for Box<T> {
> +    #[inline]
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() }.into())
> +    }
> +
> +    #[inline]
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for UniqueArc<T> {
> +    #[inline]
> +    fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() }.into())
> +    }
> +
> +    #[inline]
> +    fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index eee7008e5e3e..43a53fbe175d 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,6 +17,8 @@
>
>  use crate::{
>      bindings,
> +    error::{self, Error},
> +    init::{InPlaceInit, Init, PinInit},
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -163,6 +165,28 @@ impl<T> Arc<T> {
>          // `Arc` object.
>          Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>      }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[inline]
> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::pin_init(init).map(|u| u.into())
> +    }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// This is equivalent to [`pin_init`], since an [`Arc`] is always pinned.
> +    #[inline]
> +    pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::init(init).map(|u| u.into())
> +    }
>  }
>
>  impl<T: ?Sized> Arc<T> {

