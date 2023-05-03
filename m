Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D46F5C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjECQge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjECQgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091967A84;
        Wed,  3 May 2023 09:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B6462EBE;
        Wed,  3 May 2023 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D37C433D2;
        Wed,  3 May 2023 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683131766;
        bh=O3m/u3ocvZ9zeQzZekMGUUnTmnwHWmHggwDg5mrYb2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmqAZ5Sh5JmnqWJidSWnctf26DAw65oz5DWa7piONtMBsNffqtp5WvDrrhkCKZtfN
         RZuFMd9h3QiPxobDIzysv6Po4DTcwxojLvHpm6RoEPx4OnU/3mb/woqRy0SXZYPmaL
         n4YtuH4yONhKUUpkCOXlixs6Oi1xXJPF9tBBXBzlrevo21xBdC+O7esAOmimzu2kbj
         vk507USReGKPsmxFdlnz876y5nq6B2nHgAe0B/C9lSVn/z7sF5iQYl0kOwCKdP4ygF
         ArXGFziZ+VuxiqxR4Ez260tkYb1NODOQswbHeT1NkQ/2y1lFEBL5b9DXcE4N76dXv6
         4XZ+v3ojfFvSg==
Date:   Wed, 3 May 2023 18:36:03 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [tip: timers/core] timers/nohz: Switch to ONESHOT_STOPPED in the
 low-res handler when the tick is stopped
Message-ID: <ZFKNc+ysfDX+iAsF@lothringen>
References: <20220422141446.915024-1-npiggin@gmail.com>
 <165089105607.4207.3022534114716811208.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165089105607.4207.3022534114716811208.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:50:56PM -0000, tip-bot2 for Nicholas Piggin wrote:
> The following commit has been merged into the timers/core branch of tip:
> 
> Commit-ID:     62c1256d544747b38e77ca9b5bfe3a26f9592576
> Gitweb:        https://git.kernel.org/tip/62c1256d544747b38e77ca9b5bfe3a26f9592576
> Author:        Nicholas Piggin <npiggin@gmail.com>
> AuthorDate:    Sat, 23 Apr 2022 00:14:46 +10:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Mon, 25 Apr 2022 14:45:22 +02:00
> 
> timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped
> 
> When tick_nohz_stop_tick() stops the tick and high resolution timers are
> disabled, then the clock event device is not put into ONESHOT_STOPPED
> mode. This can lead to spurious timer interrupts with some clock event
> device drivers that don't shut down entirely after firing.
> 
> Eliminate these by putting the device into ONESHOT_STOPPED mode at points
> where it is not being reprogrammed. When there are no timers active, then
> tick_program_event() with KTIME_MAX can be used to stop the device. When
> there is a timer active, the device can be stopped at the next tick (any
> new timer added by timers will reprogram the tick).

I'm confused by the above, why are we handling the timer active part here?

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20220422141446.915024-1-npiggin@gmail.com
> ---
>  kernel/time/tick-sched.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 2d76c91..b1b105d 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -928,6 +928,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	if (unlikely(expires == KTIME_MAX)) {
>  		if (ts->nohz_mode == NOHZ_MODE_HIGHRES)
>  			hrtimer_cancel(&ts->sched_timer);
> +		else
> +			tick_program_event(KTIME_MAX, 1);
>  		return;
>  	}
>  
> @@ -1364,9 +1366,15 @@ static void tick_nohz_handler(struct clock_event_device *dev)
>  	tick_sched_do_timer(ts, now);
>  	tick_sched_handle(ts, regs);
>  
> -	/* No need to reprogram if we are running tickless  */
> -	if (unlikely(ts->tick_stopped))
> +	if (unlikely(ts->tick_stopped)) {
> +		/*
> +		 * The clockevent device is not reprogrammed, so change the
> +		 * clock event device to ONESHOT_STOPPED to avoid spurious
> +		 * interrupts on devices which might not be truly one shot.
> +		 */
> +		tick_program_event(KTIME_MAX, 1);

More specifically why are we stopping the tick here entirely and
unconditionally? If the tick is stopped (actually meaning it is delayed
or _might_ be totally stopped), then the next tick is going to be re-evaluated
shortly after:

* On the idle loop if within idle
* On IRQ exit if nohz_full

And then tick_nohz_stop_tick() will be called and stop the tick entirely
if necessary.

Am I missing something else?

Thanks.
