Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE26D89EC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjDEV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjDEV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:59:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD797692
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:59:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50299ceefa4so837326a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680731979;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RZZVkPe4AwCbs7pG7yz8OubdmqvEAqRS47xr1RdAx9w=;
        b=ERYi2dpfiVAnS8c8CJFU01G0Zh34IwJJhXbOOe9qa65Sdogiq2+lBBlXX4UaMWXiGl
         3pByt8yzAClGmfMHTH1TurTPaJZ4sdTnyBsqNrvY83aiXY5rmrypjwccyXqmepm6h9ym
         x42ez/i70xtNQh1AvTN7FOvZJ642iGusLuWmQtoCF6B4ZL6YctoQWiFdH3TeXtoVaVAh
         PHmvF2Ymx1na1IeLk/O3quXY5YZAc+RHjMgrX3l/KYpQwIAs0oRQ2HANnnzrQeN57kcW
         +zEfc+AVNEKZOM8XEIWluADGyJUIXKaN883bVUsErupZ9C4oYzDpFTGDlU8z1ERB6d12
         AFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731979;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZZVkPe4AwCbs7pG7yz8OubdmqvEAqRS47xr1RdAx9w=;
        b=ogEZm+H2MN6u80Ix5XvIh9ApvWWwEhWArkeMJSg3ETgZ4IQFEmMhNlMJwwPOMWL1mQ
         XhwQLyfqnIR8jj2IlwrhM4jKd10VBjJU3PmVO5FN/Bzsk37IVmigNaNwwozzRaFILRgb
         iMa9lOxkD0vJv/rSRkS4cPzNwe18TXGHgsqHXDULIl/a+6MhooBW5qi25d29LCXmg+9d
         7ANk3XnD5aIzmoK7v4R+/goJcY4vuiFKZC65HjhuQBmcOek/2O7/PHYWxgS/hflrb5pZ
         aqOvbhVmXTomGjbSiflW44DHcv51XEupDx2bdpKajVn/rn0A7zMVY+n9pwAb7V6a41an
         ImkA==
X-Gm-Message-State: AAQBX9cPAeCGtsVuenymmFCQt3hBdMQSd7nBEf7mDVyddDJ8ehT0fj5U
        Vql1JK3p5fMX6i+DrHob495KYg==
X-Google-Smtp-Source: AKy350aZ5fbWqOqFqxsZjsVdzrI8BDvIV15oXyKuAnwypjN/QNgCyXKwxwCQnsSOgZUF/qv629FpHg==
X-Received: by 2002:a05:6402:b04:b0:4fd:215e:b691 with SMTP id bm4-20020a0564020b0400b004fd215eb691mr3735096edb.4.1680731978953;
        Wed, 05 Apr 2023 14:59:38 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id h5-20020a50c385000000b004ad601533a3sm7837803edf.55.2023.04.05.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 14:59:38 -0700 (PDT)
References: <20230405193445.745024-1-y86-dev@protonmail.com>
 <20230405193445.745024-15-y86-dev@protonmail.com>
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
Subject: Re: [PATCH v6 14/15] rust: sync: reduce stack usage of
 `UniqueArc::try_new_uninit`
Date:   Wed, 05 Apr 2023 23:59:01 +0200
In-reply-to: <20230405193445.745024-15-y86-dev@protonmail.com>
Message-ID: <87pm8irnw5.fsf@metaspace.dk>
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

> `UniqueArc::try_new_uninit` calls `Arc::try_new(MaybeUninit::uninit())`.
> This results in the uninitialized memory being placed on the stack,
> which may be arbitrarily large due to the generic `T` and thus could
> cause a stack overflow for large types.
>
> Change the implementation to use the pin-init API which enables in-place
> initialization. In particular it avoids having to first construct and
> then move the uninitialized memory from the stack into the final location.
>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@samsung.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/lib.rs      |  1 -
>  rust/kernel/sync/arc.rs | 16 +++++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 821bd067151c..2d7606135ef6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -28,7 +28,6 @@
>  #[cfg(not(CONFIG_RUST))]
>  compile_error!("Missing kernel configuration for conditional compilation");
>
> -#[allow(unused_extern_crates)]
>  // Allow proc-macros to refer to `::kernel` inside the `kernel` crate (this crate).
>  extern crate self as kernel;
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 43a53fbe175d..d05caa723718 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -18,7 +18,8 @@
>  use crate::{
>      bindings,
>      error::{self, Error},
> -    init::{InPlaceInit, Init, PinInit},
> +    init::{self, InPlaceInit, Init, PinInit},
> +    try_init,
>      types::{ForeignOwnable, Opaque},
>  };
>  use alloc::boxed::Box;
> @@ -30,6 +31,7 @@ use core::{
>      pin::Pin,
>      ptr::NonNull,
>  };
> +use macros::pin_data;
>
>  /// A reference-counted pointer to an instance of `T`.
>  ///
> @@ -122,6 +124,7 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<ArcInner<T>>,
>  }
>
> +#[pin_data]
>  #[repr(C)]
>  struct ArcInner<T: ?Sized> {
>      refcount: Opaque<bindings::refcount_t>,
> @@ -502,9 +505,16 @@ impl<T> UniqueArc<T> {
>
>      /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
>      pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
> -        Ok(UniqueArc::<MaybeUninit<T>> {
> +        // INVARIANT: The refcount is initialised to a non-zero value.
> +        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
> +            // SAFETY: There are no safety requirements for this FFI call.
> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
> +            data <- init::uninit::<T, AllocError>(),
> +        }? AllocError))?;
> +        Ok(UniqueArc {
>              // INVARIANT: The newly-created object has a ref-count of 1.
> -            inner: Arc::try_new(MaybeUninit::uninit())?,
> +            // SAFETY: The pointer from the `Box` is valid.
> +            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>          })
>      }
>  }

