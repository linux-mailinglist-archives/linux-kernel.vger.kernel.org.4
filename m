Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935169DB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjBUH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjBUH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40DC2596A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676964353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JPIAZdGy9OlnE1O1SS60YxZ8brGuCruddGUDSBr1OzI=;
        b=GnnTik2VVl3csxoA4i5D7J+rKeSoAiQI37DfqlJ/Y65MNdb5UmMDBF1ZtsP1LfS/QUUbj4
        7F6Uo/L0aR6WymXc4zvoX4kfesNb+P+cHyAOS33EZHE0ec8a/slHWwY/kYc9yF9SKHjvAy
        gnNo5+NsCpb3kvKTPOM4jqp0uftCQp8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-oiyqS_rYPjKd1N4SjulwEw-1; Tue, 21 Feb 2023 02:25:52 -0500
X-MC-Unique: oiyqS_rYPjKd1N4SjulwEw-1
Received: by mail-vs1-f70.google.com with SMTP id a15-20020a056102024f00b004121e7acf38so364452vsq.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPIAZdGy9OlnE1O1SS60YxZ8brGuCruddGUDSBr1OzI=;
        b=WUX7SxnN5aJzs5CYHtk82H3eU93GfoBNOg/I5P2QDSToGImWy9diKC8IEMzi4PeIQl
         qQN3KNsY/k660wrh+NLYS0r99XxopdF01dkW9PUjJcYvzAmr9af1jbHHMrcR9NoYxvH7
         pCsilrfiQqPZBeRse0LWgQ3ipvmZHTVRkvmx0nv1K/9ZyPG7pg3FUh8aKPgSMrhHZkNG
         HBmgjo/Nq6ePgXsaGmhVageJoxFLS2XZkSEj0tv1xN7hY/utLhxSgzvIaS+J8XfHR//F
         xutyeBrvUllXdUyV0Ta+O8+yVT0AFrJMe6Jm2jSNYndtlGBKlaVwgKVJEU25Xry0m+ZR
         d4vQ==
X-Gm-Message-State: AO0yUKVtOnRxazIlLmywgAl1NmtQfuaUFbRHVfHTaM9QYxPkJryvLLTT
        P+ZSeCCR5nirbo0wR/eS/wyWtBE8N4JLaemELogn0oTSQ8ETLc4oGe16I8YjvZ90cO9I4q3ncu7
        Q8enJjKRJ910/g9cUjlX2NFKTkhBgyEBSfuZzP5Ku
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id v10-20020a0561020f0a00b00411bd2e11acmr748823vss.75.1676964351943;
        Mon, 20 Feb 2023 23:25:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+QzMJrGZDcal2v3DamPgxlNnPNto6IxZHAfuHD9KBnKa+B4kexA0i1IiOd075Fe4xK51ciiQNNhbdDUty1Qpc=
X-Received: by 2002:a05:6102:f0a:b0:411:bd2e:11ac with SMTP id
 v10-20020a0561020f0a00b00411bd2e11acmr748816vss.75.1676964351730; Mon, 20 Feb
 2023 23:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
In-Reply-To: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Tue, 21 Feb 2023 07:25:35 +0000
Message-ID: <CAOgh=Fw634rgNCzx+mMEQayhGKgUiBYsqpF7rFOz+q4DS1_kag@mail.gmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 07:16, Asahi Lina <lina@asahilina.net> wrote:
>
> This module is intended to contain functions related to kernel
> timekeeping and time. Initially, this just wraps ktime_get() and
> ktime_get_boottime() and returns them as core::time::Duration instances.
> This is useful for drivers that need to implement simple retry loops and
> timeouts.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Nice and simple C interface to create Rust abstractions for.

Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

>  rust/bindings/bindings_helper.h |  4 +++-
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/time.rs             | 25 +++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 75d85bd6c592..587f3d1c0c9f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,8 +6,10 @@
>   * Sorted alphabetically.
>   */
>
> -#include <linux/slab.h>
> +#include <linux/ktime.h>
>  #include <linux/refcount.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
>
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 223564f9f0cc..371b1b17570e 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -37,6 +37,7 @@ mod static_assert;
>  pub mod std_vendor;
>  pub mod str;
>  pub mod sync;
> +pub mod time;
>  pub mod types;
>
>  #[doc(hidden)]
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> new file mode 100644
> index 000000000000..02844db47d34
> --- /dev/null
> +++ b/rust/kernel/time.rs
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Timekeeping functions.
> +//!
> +//! C header: [`include/linux/ktime.h`](../../../../include/linux/ktime.h)
> +//! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
> +
> +use crate::bindings;
> +use core::time::Duration;
> +
> +/// Returns the kernel time elapsed since boot, excluding time spent sleeping, as a [`Duration`].
> +pub fn ktime_get() -> Duration {
> +    // SAFETY: Function has no side effects and no inputs.
> +    Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
> +}
> +
> +/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
> +pub fn ktime_get_boottime() -> Duration {
> +    Duration::from_nanos(
> +        // SAFETY: Function has no side effects and no variable inputs.
> +        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
> +            .try_into()
> +            .unwrap(),
> +    )
> +}
>
> ---
> base-commit: 89f5349e0673322857bd432fa23113af56673739
> change-id: 20230221-gpu-up-time-ea9412204c3b
>
> Thank you,
> ~~ Lina
>
>

