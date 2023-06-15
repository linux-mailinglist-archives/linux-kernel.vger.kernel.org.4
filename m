Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C59731D42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbjFOQA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbjFOQAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:00:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D2294E;
        Thu, 15 Jun 2023 09:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D8C462118;
        Thu, 15 Jun 2023 16:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735A0C433C0;
        Thu, 15 Jun 2023 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686844851;
        bh=h/6t7DwDjA3p+BAZ2sQtK/aU1fbTz3A8IeHUPH5Jep4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SV5IxU0dpgPZ7fXfIUCGRNy7QrQkryzp/8BbBqvMIrsaB6UqwdNi1tCY+eV/ZilK7
         LyxrHXlChvx/Bn/IFU/3i9h7T5GagC73RoCt0mnCE0Xr76fzaQ+voFdSFVsl++5rgr
         +mnTYUkzTy9tnhmagAS65d8WaEodJ6Y+w6cPTUaJISRGYzSkiHwPwxRA0Y8RAnpoMA
         o1ePrQbpfKbXCuLTT9H+eCBJ5g3vyLuxGNLEWAkb8uNmgvy3rA8ddHKNNXmCKSnNDr
         GNW8J7ICGJpIRQreTm4WI84n1WIyv76HWQB9bZB0QYnUwIx/yonXeallCa8uVyPgef
         WZ7sv0G19K/8A==
From:   SeongJae Park <sj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
Date:   Thu, 15 Jun 2023 16:00:48 +0000
Message-Id: <20230615160048.84518-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 11:18:30 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tick period is aligned very early while the first clock_event_device
> is registered. The system runs in periodic mode and switches later to
> one-shot mode if possible.
> 
> The next wake-up event is programmed based on aligned value
> (tick_next_period) but the delta value, that is used to program the
> clock_event_device, is computed based on ktime_get().
> 
> With the subtracted offset, the devices fires in less than the exacted
> time frame. With a large enough offset the system programs the timer for
> the next wake-up and the remaining time left is too little to make any
> boot progress. The system hangs.
> 
> Move the alignment later to the setup of tick_sched timer. At this point
> the system switches to oneshot mode and a highres clocksource is
> available. It safe to update tick_next_period ktime_get() will now
> return accurate (not jiffies based) time.
> 
> [bigeasy: Patch description + testing].
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
> Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
> Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com

I guess adding 'Cc: stable@' might further help stable maintainers?

I also left one very tirival cosmetic comment below, but I dont think those
could be blockers.

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  kernel/time/tick-common.c | 11 +----------
>  kernel/time/tick-sched.c  | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 65b8658da829e..b85f2f9c32426 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -218,19 +218,10 @@ static void tick_setup_device(struct tick_device *td,
>  		 * this cpu:
>  		 */
>  		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
> -			ktime_t next_p;
> -			u32 rem;
>  

Nit: I guess we'd like to remove above one blank line together?

>  			tick_do_timer_cpu = cpu;
>  
> -			next_p = ktime_get();
> -			div_u64_rem(next_p, TICK_NSEC, &rem);
> -			if (rem) {
> -				next_p -= rem;
> -				next_p += TICK_NSEC;
> -			}
> -
> -			tick_next_period = next_p;
> +			tick_next_period = ktime_get();
>  #ifdef CONFIG_NO_HZ_FULL
>  			/*
>  			 * The boot CPU may be nohz_full, in which case set
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 52254679ec489..42c0be3080bde 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
>  	raw_spin_lock(&jiffies_lock);
>  	write_seqcount_begin(&jiffies_seq);
>  	/* Did we start the jiffies update yet ? */
> -	if (last_jiffies_update == 0)
> +	if (last_jiffies_update == 0) {
> +		u32 rem;
> +
> +		/*
> +		 * Ensure that the tick is aligned to a multiple of
> +		 * TICK_NSEC.
> +		 */
> +		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
> +		if (rem)
> +			tick_next_period += TICK_NSEC - rem;
> +
>  		last_jiffies_update = tick_next_period;
> +	}
>  	period = last_jiffies_update;
>  	write_seqcount_end(&jiffies_seq);
>  	raw_spin_unlock(&jiffies_lock);
> -- 
> 2.40.1
