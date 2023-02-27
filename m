Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD66A4123
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjB0LsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0LsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:48:10 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB32728A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:48:08 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cq23so24706616edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=t1OjyobwWiaHh7+rjZmP3kOsw+ZJ6qE24StYRceK6RM=;
        b=MfdeUyIDihZkqJ66TOuvcdrwIcHQ75gXPd4mefzW/M7pgeUQx+DEGAJAHTMwMz1Nkf
         s7nbTMT5hdOhZoImaVrzzn6m69X7sWn39jYWNsTGPS09Qf/4elBPgqk4XM/w7ZiKNl4i
         Qgy082SanNeIZThw+apmfj9ki5WIKRMJk1E+01j9HQRGrDVTnb5pM9yQHqyEA2JyyUZ5
         oddyYRJhtc7Cvup9vnC+qhDWI7eWsSEDFizdpGdck57dtwE4hiNfARcqsPw9nNF8wLYY
         jG623rPtKr6+hAJm0lv+xaIiz+VUHHGpDoJvkJXBPk9EsQLL1RqYEAp75UfzYLAn1tl4
         3ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1OjyobwWiaHh7+rjZmP3kOsw+ZJ6qE24StYRceK6RM=;
        b=eHYk6oCt9k2klvjvw9fHc1S1dqf0KH1M+e6Mv8oj7Nb/SU7puZdlLOSXoORr+wwyEz
         UXuUQAybHEKBqjfXjhvm6ofxAKhXnAD4ij0GQ66pr5nlHTyg/VKFtv6jUv56m56jmGqd
         R3yZdpRjWthV0iXqoHWxT0br19ajETR6XOugbjjrS1cDqndOBWC4pZxmQkRyHlmh3YEH
         DZhaBhtUwUgT1uvmgGuJGpLwFk8wDK0crwWIt/Az8eeIzjxbECMyvrOyYwDkV3qz5ZFt
         BBGIV/yHniguutdPZWmzfVwTi7MCqAFL0CirJW6oQUDFQ1EdqfKN6N6/y/Yap20mMzm1
         g7Vg==
X-Gm-Message-State: AO0yUKXJ4UHgxF0Ss8gMSdQk86X3JWmvP/1Kanp1EL7vv/PurM43iSzu
        rlBAPBKPEPsSOBgNuTye/nxiZpPLVkzJiWPm
X-Google-Smtp-Source: AK7set9v950DkyFJ1v+RucxsNpv6om7VK65PomdteoJ7mIeN1x5e3U9BeP6uh30f6f8UjJi+wGVFPA==
X-Received: by 2002:a17:906:730c:b0:878:79e6:4672 with SMTP id di12-20020a170906730c00b0087879e64672mr41427544ejc.42.1677498486597;
        Mon, 27 Feb 2023 03:48:06 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id ky7-20020a170907778700b008db605598b9sm3166679ejc.67.2023.02.27.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 03:48:06 -0800 (PST)
References: <20230224-rust-arc-v1-0-568eea613a41@asahilina.net>
 <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 1/2] rust: sync: arc: implement Arc<dyn Any + Send +
 Sync>::downcast()
Date:   Mon, 27 Feb 2023 12:46:45 +0100
In-reply-to: <20230224-rust-arc-v1-1-568eea613a41@asahilina.net>
Message-ID: <87356rba8a.fsf@metaspace.dk>
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


Asahi Lina <lina@asahilina.net> writes:

> This mirrors the standard library's alloc::sync::Arc::downcast().
>
> Based on the Rust standard library implementation, ver 1.62.0,
> licensed under "Apache-2.0 OR MIT", from:
>
>     https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src
>
> For copyright details, please see:
>
>     https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/sync/arc.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a94e303217c6..752bd7c4699e 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    any::Any,
>      fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
> @@ -220,6 +221,27 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
>      }
>  }
>  
> +impl Arc<dyn Any + Send + Sync> {
> +    /// Attempt to downcast the `Arc<dyn Any + Send + Sync>` to a concrete type.
> +    // Based on the Rust standard library implementation, ver 1.62.0, which is
> +    // Apache-2.0 OR MIT.
> +    pub fn downcast<T>(self) -> core::result::Result<Arc<T>, Self>
> +    where
> +        T: Any + Send + Sync,
> +    {
> +        if (*self).is::<T>() {
> +            // SAFETY: We have just checked that the type is correct, so we can cast the pointer.
> +            unsafe {
> +                let ptr = self.ptr.cast::<ArcInner<T>>();
> +                core::mem::forget(self);
> +                Ok(Arc::from_inner(ptr))
> +            }
> +        } else {
> +            Err(self)
> +        }
> +    }
> +}
> +
>  impl<T: ?Sized> Deref for Arc<T> {
>      type Target = T;

