Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11F76D0708
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjC3Nj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjC3Nj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:39:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B7FC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:39:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso13465907wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680183593;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=JM8HKL3778vUQkbWShLT/DOaNAA+BeiO2MSEIcKh1es=;
        b=lrsXoKtwc5CT99FxrJAn4K/hioQwQhZrvDjS0r++gn+JrXlTHEc965i/+u0ZLtsxos
         OFXwAnjnAStfkXedcwa3Mh/buf2gYTn5fRkG4rmF/sIfpVsC8/639Zw4/yDQxqZ+UrXg
         o89jqWzNZOKHwEljKC4ggty61cWJoXWsOKtOVCe0hEi3I4duZvJ8M6XRqfLGDXGzFqwO
         tJZKtBs636Jp0tPvvvDtYQeEbdPznRxEZ1ufYCwyVC2EYY16fzYZeClPc7LI3qMSZ1qx
         lhlbNkLCOJHp3pKiRieRfRiwEZzQnq9Q3++xmfBEE05wTsCKSICFosMtPQfhsuT68p7x
         /H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680183593;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM8HKL3778vUQkbWShLT/DOaNAA+BeiO2MSEIcKh1es=;
        b=ucMjiupRWt5RA3zSpdIpCTGZVdf5Yc4jFyQQgegMZEbJIW/FyU7muRZ6uOW+eWHkFC
         C9qnw8Wog0pjeDeHdGqcnLeBu2iJbF1AdKYouvL5eQ4G470QAclNzMIlDfH8WgAxieQj
         pwB2SlmmmiRDo8tJM+xIOyZw2cko0siWv1e37XsNAs1N4anLimqoBeN9aWbjcUhxdy2a
         vqzS8sPKFvUwJDGjJoNJMSSAz/pOstDqDo3Xqx+r+fEO7QULJeF4qrCJYAUhNOcCbwJt
         3VaM3osq75vIaQvcxfADhCgntmuk3az3hsOxN7Q+JgoebfvJ4z2Y0LCdmg+4GhO7Lz9C
         T7NQ==
X-Gm-Message-State: AO0yUKXLKxk/7E1+QOueyvr+ADu1EhVb6bpZkBEO8RZdWmDlo61FW1t1
        jDAyr3GzNJ6HEGJvKxo6u5WlOA==
X-Google-Smtp-Source: AK7set+k2PrWvan4zfb9OG6ybBURZnKDsRVl/hovKJ4Xp/T6XF5Jk/uqVgLrxo6+urwaOhXX/cPV7Q==
X-Received: by 2002:a1c:7516:0:b0:3ef:3ce6:7c69 with SMTP id o22-20020a1c7516000000b003ef3ce67c69mr17784934wmc.8.1680183593259;
        Thu, 30 Mar 2023 06:39:53 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b003ef5db16176sm5877756wmj.32.2023.03.30.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:39:52 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-7-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 06/13] rust: init/sync: add `InPlaceInit` trait to
 pin-initialize smart pointers
Date:   Thu, 30 Mar 2023 15:39:20 +0200
In-reply-to: <20230329223239.138757-7-y86-dev@protonmail.com>
Message-ID: <87cz4q4atz.fsf@metaspace.dk>
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
> The `InPlaceInit` trait that provides two functions, for initializing
> using `PinInit<T, E>` and `Init<T>`. It is implemented by `Arc<T>`,
> `UniqueArc<T>` and `Box<T>`.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/init.rs     | 97 +++++++++++++++++++++++++++++++++++------
>  rust/kernel/sync/arc.rs | 25 ++++++++++-
>  2 files changed, 108 insertions(+), 14 deletions(-)
>
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 85e8d5f41b60..3d89c7e3bdb5 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -114,10 +114,13 @@
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
> +use core::{cell::Cell, convert::Infallible, marker::PhantomData, mem::MaybeUninit, pin::Pin, ptr};
>
>  #[doc(hidden)]
>  pub mod __internal;
> @@ -309,7 +312,6 @@ pub mod macros;
>  ///
>  /// [`try_pin_init!`]: kernel::try_pin_init
>  /// [`NonNull<Self>`]: core::ptr::NonNull
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -366,8 +368,6 @@ macro_rules! pin_init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -589,8 +589,6 @@ macro_rules! try_pin_init {
>  ///
>  /// This initializer is for initializing data in-place that might later be moved. If you want to
>  /// pin-initialize, use [`pin_init!`].
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -641,8 +639,6 @@ macro_rules! init {
>  ///     }
>  /// }
>  /// ```
> -///
> -/// [`Error`]: kernel::error::Error
>  // For a detailed example of how this macro works, see the module documentation of the hidden
>  // module `__internal` inside of `init/__internal.rs`.
>  #[macro_export]
> @@ -848,7 +844,8 @@ macro_rules! try_init {
>  /// A pinned initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`].
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::pin_init`] function of a
> +/// smart pointer like [`Arc<T>`] on this.
>  ///
>  /// Also see the [module description](self).
>  ///
> @@ -867,7 +864,6 @@ macro_rules! try_init {
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
>  /// [`Arc::pin_init`]: crate::sync::Arc::pin_init
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>      /// Initializes `slot`.
> @@ -884,7 +880,8 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// An initializer for `T`.
>  ///
>  /// To use this initializer, you will need a suitable memory location that can hold a `T`. This can
> -/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Because [`PinInit<T, E>`] is a super trait, you can
> +/// be [`Box<T>`], [`Arc<T>`], [`UniqueArc<T>`]. Use the [`InPlaceInit::init`] function of a smart
> +/// pointer like [`Arc<T>`] on this. Because [`PinInit<T, E>`] is a super trait, you can
>  /// use every function that takes it as well.
>  ///
>  /// Also see the [module description](self).
> @@ -909,7 +906,6 @@ pub unsafe trait PinInit<T: ?Sized, E = Infallible>: Sized {
>  /// move the pointee after initialization.
>  ///
>  /// [`Arc<T>`]: crate::sync::Arc
> -/// [`UniqueArc<T>`]: kernel::sync::UniqueArc
>  #[must_use = "An initializer must be used in order to create its value."]
>  pub unsafe trait Init<T: ?Sized, E = Infallible>: PinInit<T, E> {
>      /// Initializes `slot`.
> @@ -1014,3 +1010,78 @@ unsafe impl<T> Init<T> for T {
>          Ok(())
>      }
>  }
> +
> +/// Smart pointer that can initialize memory in-place.
> +pub trait InPlaceInit<T>: Sized {
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>;
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>;
> +}
> +
> +impl<T> InPlaceInit<T> for Box<T> {
> +    #[inline]
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved because of the `Pin::new_unchecked`
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
> +    }
> +
> +    #[inline]
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = Box::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { this.assume_init() })
> +    }
> +}
> +
> +impl<T> InPlaceInit<T> for UniqueArc<T> {
> +    #[inline]
> +    fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
> +    where
> +        Error: From<E>,
> +    {
> +        let mut this = UniqueArc::try_new_uninit()?;
> +        let slot = this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> +        // slot is valid and will not be moved because of the `Pin::new_unchecked`.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { Pin::new_unchecked(this.assume_init()) })
> +    }
> +
> +    #[inline]
> +    fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
> +    where
> +        Error: From<E>,
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
> index 16ec174637b2..77a3833cc265 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -17,7 +17,8 @@
>
>  use crate::{
>      bindings,
> -    error::Result,
> +    error::{Error, Result},
> +    init::{InPlaceInit, Init, PinInit},
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -163,6 +164,28 @@ impl<T> Arc<T> {
>          // `Arc` object.
>          Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>      }
> +
> +    /// Use the given initializer to in-place initialize a `T`.
> +    ///
> +    /// If `T: !Unpin` it will not be able to move afterwards.
> +    #[inline]
> +    pub fn pin_init<E>(init: impl PinInit<T, E>) -> Result<Self>
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
> +    pub fn init<E>(init: impl Init<T, E>) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        UniqueArc::init(init).map(|u| u.into())
> +    }
>  }
>
>  impl<T: ?Sized> Arc<T> {

