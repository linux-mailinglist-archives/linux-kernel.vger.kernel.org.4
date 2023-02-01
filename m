Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C616862F8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjBAJk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjBAJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:40:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947D5B584
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:40:51 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id dr8so28031206ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=WwWn2SiLiW7sLaC3t5z9qnIk8iNhwtCwJiitRlNyQ/8=;
        b=jogpAeWNiX1Jz4lazS8c8MTlJNpDcXZ8GDVYjJys7iQGpMmyD3GADSgxPUp+8UYu5c
         ChxJvvGr6rfWafHRold7G8ZHuXCD5DAmqTATtuDEDVzbSDnOkFAHYP1hNJS+/vJOQCMH
         4rq9rSwsbd5Oi1O3d2EcPA5J5YicWh7y+GfXZiCtxvRiTliFY2tifRx9sWmx7feNyiER
         Pdslt9srn6XvCa76BB4S0gWUc6SGdxGP6knvevyMlQBMUh34GTrB/DE/qzINR+JRAxNx
         Ekx/OBiimEfpkD2ukBeSzqvXKoB//fE+THtXv9wq2/sXeeuKii44ah9AlnW2gA0ZThY+
         e6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwWn2SiLiW7sLaC3t5z9qnIk8iNhwtCwJiitRlNyQ/8=;
        b=3BTwIqhuoZsQ89wePuOxi63jbpKtovwoSYVwydSVI7AjAr1XjFIkUvUXSK29gYEJvn
         nmTCgJqiuJun33kteVhCeHnr2gZ1SGQiyVRzcLm8VxmDTea6LlFcW6XnVPAxareCZqdF
         Zgm3rNRA8vhgOF9VA+o8I21L0IihLV4qYmDfLoZ0xPelOwynU/wJ9XiTZcQlE4qszYy1
         Er3vkBLYL3XqtEedsMyTVo1wcBZ3BTDKE0gebruJaO2QR3eWFrrEhOZauLDVe8LGogLc
         Vg885yewoGdzplXM/21TbP2LQjJE97VeKZfw6FIhEyAaXlrYOhGwIGvoYHjUE2r74FyT
         aBNw==
X-Gm-Message-State: AO0yUKUyR47l9SFcHLqSupfswMxBpZSH/785kj/AhNSJyXyYqXn7FVEs
        PCV0smCbDanuAL2dz15LEXIBvw==
X-Google-Smtp-Source: AK7set/I3ZSX+O9UcLe15Di0So9RXz1fxvTlWmnT7fw+tfog1w/9tkLzFeReshElytkmDWaw6cwZYw==
X-Received: by 2002:a17:906:9610:b0:878:5e84:e1d6 with SMTP id s16-20020a170906961000b008785e84e1d6mr1930486ejx.75.1675244449923;
        Wed, 01 Feb 2023 01:40:49 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id os25-20020a170906af7900b008874c903ec5sm5188677ejb.43.2023.02.01.01.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:40:49 -0800 (PST)
References: <20230130064404.744600-1-wedsonaf@gmail.com>
 <20230130064404.744600-2-wedsonaf@gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 2/5] rust: types: introduce `ForeignOwnable`
Date:   Wed, 01 Feb 2023 10:35:11 +0100
In-reply-to: <20230130064404.744600-2-wedsonaf@gmail.com>
Message-ID: <87sffpk9jz.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

> It was originally called `PointerWrapper`. It is used to convert
> a Rust object to a pointer representation (void *) that can be
> stored on the C side, used, and eventually returned to Rust.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

It would be cool to see a debug implementation of this trait that verify
safety properties by using a counter at runtime. Panic if borrow_mut()
is called while there are live references in existence returned by
borrow().

> v1 -> v2: Use `Self` instead of generic type in `borrow_mut`
>
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e0b0e953907d..223564f9f0cc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,6 +16,7 @@
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
> +#![feature(generic_associated_types)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index dd834bfcb57b..72710b7442a3 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -8,6 +8,60 @@ use core::{
>      ops::{Deref, DerefMut},
>  };
>  
> +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> +///
> +/// Ownership is transferred from Rust to a foreign language by calling [`Self::into_foreign`] and
> +/// later may be transferred back to Rust by calling [`Self::from_foreign`].
> +///
> +/// This trait is meant to be used in cases when Rust objects are stored in C objects and
> +/// eventually "freed" back to Rust.
> +pub trait ForeignOwnable: Sized {
> +    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> +    /// [`ForeignOwnable::from_foreign`].
> +    type Borrowed<'a>;
> +
> +    /// Converts a Rust-owned object to a foreign-owned one.
> +    ///
> +    /// The foreign representation is a pointer to void.
> +    fn into_foreign(self) -> *const core::ffi::c_void;
> +
> +    /// Borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> +    /// for this object must have been dropped.
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> +
> +    /// Mutably borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Self, fn(Self)> {
> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> +        // `into_foreign`.
> +        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d| {
> +            d.into_foreign();
> +        })
> +    }
> +
> +    /// Converts a foreign-owned object back to a Rust-owned one.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

