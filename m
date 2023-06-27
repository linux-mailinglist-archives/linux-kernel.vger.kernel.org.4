Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C773FB24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjF0Lcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0Lca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0289E26B8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 04:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 934DB61189
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E02C433C8;
        Tue, 27 Jun 2023 11:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687865548;
        bh=AlpMZ5iLqgAPxVW6nsDVYIyw9ZFOHeY/QxYTKuyL484=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJcvhkkvfbBXSqbGMu2QUXOoNwcdEXCxGycx2ODHftd+U8MCscjuAK9KJy4B+oWi5
         CJL7Te5EZsGPovlqAtUV4Wn9Xk2Caje/ovhJGD+LFxn01iFEn/3KiZOTytV2vG+0Iv
         zhrUQyPGGj/I3C9UtiCltVzh9qp3sWxJqZ/3GJAoDEFTMGj84ZF0npJo0MKFa2BkLB
         lSWwjY2jPm1iKfhvhPsbn9oq4aLITKjqx6beggTPrYWmxAvOeQRKvYRoiS8t/nA+W4
         qK1wfBUqxzc/OHwm6aAkBZylhXYKVQ0LA2IF2wYjyDNanY6EeXgywIsEr8tFIQk5fZ
         2/w14OcZgzHoQ==
Date:   Tue, 27 Jun 2023 13:32:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 13/45] posix-cpu-timers: Replace old expiry retrieval in
 posix_cpu_timer_set()
Message-ID: <ZJrIyGxdDYy3Ppy1@lothringen>
References: <20230606132949.068951363@linutronix.de>
 <20230606142031.761271959@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606142031.761271959@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:37:39PM +0200, Thomas Gleixner wrote:
> Reuse the split out __posix_cpu_timer_get() function which does already the
> right thing.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-cpu-timers.c |   28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -609,6 +609,8 @@ static void cpu_timer_fire(struct k_itim
>  	}
>  }
>  
> +static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64
> *itp, u64 now);

Perhaps you can move __posix_cpu_timer_get() above posix_cpu_timer_set()?

> +
>  /*
>   * Guts of sys_timer_settime for CPU timers.
>   * This is called with the timer locked and interrupts disabled.
> @@ -680,29 +682,9 @@ static int posix_cpu_timer_set(struct k_
>  	else
>  		now = cpu_clock_sample_group(clkid, p, !sigev_none);
>  
> -	if (old) {
> -		if (old_expires == 0) {
> -			old->it_value.tv_sec = 0;
> -			old->it_value.tv_nsec = 0;
> -		} else {
> -			/*
> -			 * Update the timer in case it has overrun already.
> -			 * If it has, we'll report it as having overrun and
> -			 * with the next reloaded timer already ticking,
> -			 * though we are swallowing that pending
> -			 * notification here to install the new setting.
> -			 */
> -			u64 exp = bump_cpu_timer(timer, now);
> -
> -			if (now < exp) {
> -				old_expires = exp - now;
> -				old->it_value = ns_to_timespec64(old_expires);
> -			} else {
> -				old->it_value.tv_nsec = 1;
> -				old->it_value.tv_sec = 0;
> -			}
> -		}
> -	}
> +	/* Retrieve the previous expiry value if requested. */
> +	if (old && old_expires)
> +		__posix_cpu_timer_get(timer, old, now);

The changelog should probably mention the desired side effect that sigev_none
will return a zero old value if expired.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

>  
>  	/* Retry if the timer expiry is running concurrently */
>  	if (unlikely(ret)) {
> 
