Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25932686338
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBAJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjBAJ5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:57:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E27F4FCE4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:57:12 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw4so11954267edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=CbGtVMl4D3yAuumXbuiDf4eoHhp70SUjpqszqwRehuY=;
        b=ku/8EGPkKZsZ3drqjgkomJrMaaPJk0SMovwbqH7AV+iZKme0iN7iKfGIyD0Aul2xHf
         nXh3+QWPDODDQpIXtBxlKvPm107LKg+bQq1OM1wCB6D5aj8gW0BB6AHjmhJrRihwb/s1
         stOyeLCMvIMaQNUB+5vodtt/PNd2e0HwvOi/IpfA67+LmFfnZCGUuhfk/P7406J4s0uu
         824vZAbc7PYGPSS5QWfE9qgMu2kFF1qEvz4iHtm5xMWPvyEkGypEQANw1UGcv9tjRRrx
         e5GwGO77i68NEf6fHfIJ1EDrBUGMGwSbMBaG39usiTn6iRvdEpSZZVksKQ11TT8WKYzb
         ixiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbGtVMl4D3yAuumXbuiDf4eoHhp70SUjpqszqwRehuY=;
        b=LvXbexaNsjpGVRbzbjLdXy/rNG0sChzIHvavLH8lyLyL/gkeojWOpn++zmDHyYU0r1
         1I3sLdwK9Cl6EXmwCibOfPP/9hozmk2SuaPjhpeF0sSTSvHZdsFEn7LjC2p6hFA58WON
         ANMSnRkg2MJyhPdbsKqF0jkFITdEHPbsfulGmChFgiI1AJkoWUMsh8sFSI3eCL65P7Tc
         5vCIApewyvwlVuyMOoeFzUJVOyg01r/kjIBvsQoybbGn4KBCevB7Yoz/9b7H4eGpRFa9
         vkL9zEJIpEYc+Fn5E1iUD/1JgO6/d563uGM1ZzuJKOcce9dHNffCdrIazC1xDb28+wOC
         4KvA==
X-Gm-Message-State: AO0yUKXda4UQCxDvP2Nl7066V8/RNYZ5+ojRmKE8e31sX2A8+52F8YzE
        LQb0KVZd6ZdkZTTdbXC6DL9mfg==
X-Google-Smtp-Source: AK7set8hXkmW8vgNk6vWNpzWGXYB6GZ1r8BKTHUx3yZJbg0dAVcbOw11U87cEtM8NmxoCY47lUQtuQ==
X-Received: by 2002:a50:d688:0:b0:49c:91d8:e989 with SMTP id r8-20020a50d688000000b0049c91d8e989mr1314187edi.42.1675245430690;
        Wed, 01 Feb 2023 01:57:10 -0800 (PST)
Received: from localhost ([79.142.230.49])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906010b00b0088272bac7c5sm6810698eje.121.2023.02.01.01.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:57:10 -0800 (PST)
References: <20230130064404.744600-1-wedsonaf@gmail.com>
 <20230130064404.744600-3-wedsonaf@gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2 3/5] rust: types: implement `ForeignOwnable` for
 `Box<T>`
Date:   Wed, 01 Feb 2023 10:56:24 +0100
In-reply-to: <20230130064404.744600-3-wedsonaf@gmail.com>
Message-ID: <87o7qdk8sq.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

> This allows us to hand ownership of Rust dynamically allocated
> objects to the C side of the kernel.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> Reviewed-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> v1 -> v2: Add `use alloc::boxed::Box`, which wasn't needed before
>
>  rust/kernel/types.rs | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 72710b7442a3..411655eca3e9 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,6 +2,7 @@
>  
>  //! Kernel types.
>  
> +use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
>      mem::MaybeUninit,
> @@ -62,6 +63,28 @@ pub trait ForeignOwnable: Sized {
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>  }
>  
> +impl<T: 'static> ForeignOwnable for Box<T> {
> +    type Borrowed<'a> = &'a T;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        Box::into_raw(self) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> +        // the lifetime of the returned value.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { Box::from_raw(ptr as _) }
> +    }
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.

