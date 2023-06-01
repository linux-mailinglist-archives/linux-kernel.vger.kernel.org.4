Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8910F719D55
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjFANWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbjFANWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:22:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056AB19B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3295664435
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433D0C433D2;
        Thu,  1 Jun 2023 13:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685625718;
        bh=wU8Vu9bgI8KbbN4ljQAHM+Omu6PSOvAFrS2vgPhZtVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIj9aps68UB3wq/gUpFKTAq6Fog98L16LqkWWzpaCfmsmXEmZ2fAjHUNVlVtFR7Gd
         VQZ7LfKlzo5aSM1DMHU5aCfO+4gPJGZ2xcEBC/8DdEB1WI3B6Lw0xOUHmgyHklqDJs
         hC6TiIh3usXktKu4OtiWf2jbEvkVZnZQWdKgWlchCJwYweVrNysZpVAqrlzKmzzwls
         5iVUh+cPkytdH7mQewvgqxVIhHQSJlMD4hFDGS4z71z24R/Aoyv2qI/I5unewdUb4R
         hYGR2EF2Lu/1HnXqpBMX8LQxx/DpJBFXISaUYcyJIM6lL/zqGKMxwPRZDw4xR9zXpc
         ifz+UzUVzg1GA==
Date:   Thu, 1 Jun 2023 15:21:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 18/20] posix-timers: Clarify posix_timer_fn() comments
Message-ID: <ZHibcwrDgegKwQeQ@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.777610259@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425183313.777610259@linutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 08:49:24PM +0200, Thomas Gleixner wrote:
> Make the issues vs. SIG_IGN understandable and remove the 15 years old
> promise that a proper solution is already on the horizon.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/posix-timers.c |   56 +++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 29 deletions(-)
> 
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -325,11 +325,11 @@ int posix_timer_event(struct k_itimer *t
>  }
>  
>  /*
> - * This function gets called when a POSIX.1b interval timer expires.  It
> - * is used as a callback from the kernel internal timer.  The
> - * run_timer_list code ALWAYS calls with interrupts on.
> -
> - * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
> + * This function gets called when a POSIX.1b interval timer expires from
> + * the HRTIMER soft interrupt with interrupts enabled.

BTW, what arranges for this to be called in softirq with interrupts enabled?
The modes I see used here are HRTIMER_MODE_ABS or HRTIMER_MODE_REL and not
their _SOFT counterparts.

> + *
> + * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
> + * based timers.
>   */
>  static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
>  {
> @@ -358,34 +359,31 @@ static enum hrtimer_restart posix_timer_
>  			 * FIXME: What we really want, is to stop this
>  			 * timer completely and restart it in case the
>  			 * SIG_IGN is removed. This is a non trivial
> -			 * change which involves sighand locking
> -			 * (sigh !), which we don't want to do late in
> -			 * the release cycle.
> +			 * change to the signal handling code.
> +			 *
> +			 * For now let timers with an interval less than a
> +			 * jiffie expire every jiffie to avoid softirq

Or rather at least to the next jiffie, right? Because then in the next jiffie
it gets re-evaluated in case a real signal handler might have been set
in-between.

Or it could be:

 +                      * For now let timers with an interval less than a
 +                      * jiffie expire every jiffie (until a real sig handler
 +			* is found set) to avoid softirq...

> +			 * starvation in case of SIG_IGN and a very small
> +			 * interval, which would put the timer right back
> +			 * on the softirq pending list. Moving now ahead of
> +			 * time tricks hrtimer_forward() to expire the
> +			 * timer later, while it still maintains the
> +			 * overrun accuracy for the price of a slightly
> +			 * inconsistency in the timer_gettime() case. This
> +			 * is at least better than a starved softirq.
[...]
>  			 */
> -#ifdef CONFIG_HIGH_RES_TIMERS
> -			{
> +			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
>  				ktime_t kj = NSEC_PER_SEC / HZ;

Could be TICK_NSECS?

Thanks!

>  
>  				if (timr->it_interval < kj)
>  					now = ktime_add(now, kj);
>  			}
> -#endif
> -			timr->it_overrun += hrtimer_forward(timer, now,
> -							    timr->it_interval);
> +
> +			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
>  			ret = HRTIMER_RESTART;
>  			++timr->it_requeue_pending;
>  			timr->it_active = 1;
> 
