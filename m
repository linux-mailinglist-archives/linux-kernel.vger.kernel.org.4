Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20C63323A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiKVBiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKVBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:37:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7392A3422
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 17:37:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 502DE6142A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49E3C433C1;
        Tue, 22 Nov 2022 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669081074;
        bh=QcONz78rL0Sk+f9V0abznXKrHZ2DoMdZuXQELbeKy4A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iooDK4IBUeRwKAN/9vC+xPpwR+SCQ88Cbf4UYRDhNWFqJMe/W8RY3wYdidBBWBL6a
         Rxw4IZTlwYJos4i4Q5y/dtUWlm9FvusqNf3F+/hNqspeQNSWUk6CGV7cjbbHlFgc1z
         1KUkKENH/g5ZpK23jaMUlqH5wJ4Kj/xkQpre1ft7+lleVFA6KrsZuQAYQamonAZr0/
         /I3pd1plrVjPtJVCWbatStdIz65msSoTNPGGoyZfgqut0+Xcbf08yFQpua27sFQEoj
         y/1WGq00HPY16Kvm8MXEDbgEe97iPq8qpbp2KEUf6iQe1xF8POKHWP1cvAdBn36IuX
         kouHFTFN32u9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 36CF05C0641; Mon, 21 Nov 2022 17:37:54 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:37:54 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        dave@stgolabs.net, josh@joshtriplett.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next][RFC]torture: avoid offline tick_do_timer_cpu
Message-ID: <20221122013754.GY4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221121035140.118651-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121035140.118651-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:51:40AM +0800, Zhouyi Zhou wrote:
> During CPU-hotplug torture (CONFIG_NO_HZ_FULL=y), if we try to
> offline tick_do_timer_cpu, the operation will fail because in
> function tick_nohz_cpu_down:
> ```
> if (tick_nohz_full_running && tick_do_timer_cpu == cpu)
>       return -EBUSY;
> ```
> Above bug was first discovered in torture tests performed in PPC VM
> of Open Source Lab of Oregon State University, and reproducable in RISC-V
> and X86-64 (with additional kernel commandline cpu0_hotplug).
> 
> In this patch, we avoid offline tick_do_timer_cpu by distribute
> the offlining cpu among remaining cpus.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Good show chasing this down!

A couple of questions below.

> ---
>  include/linux/tick.h        |  1 +
>  kernel/time/tick-common.c   |  1 +
>  kernel/time/tick-internal.h |  1 -
>  kernel/torture.c            | 10 ++++++++++
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/tick.h b/include/linux/tick.h
> index bfd571f18cfd..23cc0b205853 100644
> --- a/include/linux/tick.h
> +++ b/include/linux/tick.h
> @@ -14,6 +14,7 @@
>  #include <linux/rcupdate.h>
>  
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> +extern int tick_do_timer_cpu __read_mostly;
>  extern void __init tick_init(void);
>  /* Should be core only, but ARM BL switcher requires it */
>  extern void tick_suspend_local(void);
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index 46789356f856..87b9b9afa320 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -48,6 +48,7 @@ ktime_t tick_next_period;
>   *    procedure also covers cpu hotplug.
>   */
>  int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
> +EXPORT_SYMBOL_GPL(tick_do_timer_cpu);
>  #ifdef CONFIG_NO_HZ_FULL
>  /*
>   * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 649f2b48e8f0..8953dca10fdd 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -15,7 +15,6 @@
>  
>  DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
>  extern ktime_t tick_next_period;
> -extern int tick_do_timer_cpu __read_mostly;
>  
>  extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
>  extern void tick_handle_periodic(struct clock_event_device *dev);
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 789aeb0e1159..bccbdd33dda2 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -33,6 +33,7 @@
>  #include <linux/delay.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
> +#include <linux/tick.h>
>  #include <linux/trace_clock.h>
>  #include <linux/ktime.h>
>  #include <asm/byteorder.h>
> @@ -358,7 +359,16 @@ torture_onoff(void *arg)
>  			schedule_timeout_interruptible(HZ / 10);
>  			continue;
>  		}
> +#ifdef CONFIG_NO_HZ_FULL
> +		/* do not offline tick do timer cpu */
> +		if (tick_nohz_full_running) {
> +			cpu = (torture_random(&rand) >> 4) % maxcpu;
> +			if (cpu >= tick_do_timer_cpu)

Why is this ">=" instead of "=="?

> +				cpu = (cpu + 1) % (maxcpu + 1);
> +		} else
> +#else
>  		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
> +#endif

What happens if the value of tick_do_timer_cpu changes between the time of
the check above and the call to torture_offline() below?  Alternatively,
how is such a change in value prevented?

							Thanx, Paul

>  		if (!torture_offline(cpu,
>  				     &n_offline_attempts, &n_offline_successes,
>  				     &sum_offline, &min_offline, &max_offline))
> -- 
> 2.34.1
> 
