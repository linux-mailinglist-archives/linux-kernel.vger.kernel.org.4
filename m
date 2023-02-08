Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA57968EC3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBHKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBHKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:01:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9325287
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:01:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so19622402eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=eeGfW4z6DR5FCDDPp99LuFiBGzrlsUiKM2Xtf5r9Spg=;
        b=Q35X9pQB7z7acMAk8N1lf4lpB9pRWfFhMg9/+ZNSCShVqOmi/7Yc3xYxzvhSk7EB/U
         wa4BfxKxAY/zPX+rlAWWun81z9vISf287M0zP9GIoq5v1lCWFE3u/Gh9bvDZzNo5QAge
         AQxyF3VwxnT3hvJpjGGdcUt1guKLMxFE+l+NHZFQte3QO58X43/ZGuelUeEu84BVf3Tm
         j6uXWXb/7UFRleXEPoV3bpsZEAzxT95rDk4VPL3A2fBh5xdhuUSbDWCVBZavq81inBQu
         +Pv2dxu2SfCzd4oXsXMrVcjUOrYmP5EZRu02FAHjdntb643cPoVsgY24irXb11ubmWQF
         cUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeGfW4z6DR5FCDDPp99LuFiBGzrlsUiKM2Xtf5r9Spg=;
        b=tF0anhCafmz9/ZUPaBSjP5Ts5p+mj2H4ZYRlZaykwk9RD/isObgxQdgaYxc/2HiAJd
         8je5PbpYtTaCdFooajLvn44EjmVS8EdITDi1JvZXuplOgHtC24KsEWfWAVUqsuAWf6M4
         6/2XawDjqJDedEPeFe2oWIf9yqGYFCvDElWunzFyX33nxbcVJf4xxx0G9b1K+jY2LX2s
         6PNWrQFQ7vwjqkX/ObUOTUJ6chiKhpUCJBhYhsu7hORAXNN1UcTQLM1FAAu024aKYgaF
         tu/JbfANgVfTnRp0J+UUdtkumRwsgAgwJmZYXvzKuG28gJD/L46BK48BepH3JzqCFR3k
         osQA==
X-Gm-Message-State: AO0yUKXZil2VQ7k5ZcLzMnoSA+RyPVd5nglFbL1Tu4o/72GCcs1JF2Qd
        iJZHxYpTZTbLGn6RaZgg49OLGw==
X-Google-Smtp-Source: AK7set+tXQjvPEauyW3PiTsEQ4id4qhGbr4KlYpHJmNWM3ybw290VchBSY0hknR5Morp5fdFa6BpBQ==
X-Received: by 2002:a50:ccc2:0:b0:4aa:ab08:3240 with SMTP id b2-20020a50ccc2000000b004aaab083240mr7119477edj.18.1675850476334;
        Wed, 08 Feb 2023 02:01:16 -0800 (PST)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7c854000000b004a24b8b58cbsm7508762edt.16.2023.02.08.02.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:01:15 -0800 (PST)
References: <20230207185216.1314638-1-boqun.feng@gmail.com>
 <20230207185216.1314638-2-boqun.feng@gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio =?utf-8?Q?Gonz=C3=A1le?= =?utf-8?Q?z?= Collado 
        <sergio.collado@gmail.com>, Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 1/2] rust: sync: impl {Debug,Display} for {Unique,}Arc
Date:   Wed, 08 Feb 2023 11:00:25 +0100
In-reply-to: <20230207185216.1314638-2-boqun.feng@gmail.com>
Message-ID: <875ycciihg.fsf@metaspace.dk>
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


Boqun Feng <boqun.feng@gmail.com> writes:

> This allows printing the inner data of `Arc` and its friends if the
> inner data implements `Display` or `Debug`. It's useful for logging and
> debugging purpose.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/sync/arc.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 519a6ec43644..e6176d9b5b29 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -22,6 +22,7 @@ use crate::{
>  };
>  use alloc::boxed::Box;
>  use core::{
> +    fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
> @@ -522,3 +523,27 @@ impl<T: ?Sized> DerefMut for UniqueArc<T> {
>          unsafe { &mut self.inner.ptr.as_mut().data }
>      }
>  }
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Display + ?Sized> fmt::Display for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Display::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for UniqueArc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}
> +
> +impl<T: fmt::Debug + ?Sized> fmt::Debug for Arc<T> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(self.deref(), f)
> +    }
> +}

