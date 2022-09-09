Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA635B3775
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIIMQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiIIMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:15:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407D3148587
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A026BB82244
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045D9C433D7;
        Fri,  9 Sep 2022 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662725547;
        bh=j260rCTWpcx6TsZ7QFclBNBl3Kwk7+ZchUYUFiDMh7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bjX5b1gNVQb9BUKj4LL5fRoHn/BKgKWDLK4pzAgeTLroTxzAFTx8j5+5w8ysWuiYk
         XRVr6MTMj92+zwcw1QOlyXX0C9AVqfiTk1BMMH0f5/3wdndxCXWkjrsT921T5KvbxZ
         RBLb7kYzkE5VanfLK79LlBKQZMAVoYat48sDHvLg2mLQ5QromD33RCVD6gr2hLh0aM
         0sA9B0MDmfbDKzaRbAlee/O6BOTGwUQsUQf5heZ1GYZWQiQzsK2ET8MiDi7CCqCRab
         pB2QEpxIiqjsksLVqsxVnbgaKm0I5mTsLChtqdDE6BmW32YzZeEJj/DTzEZQZwBifa
         fLypLyfMmEJoQ==
Date:   Fri, 9 Sep 2022 14:12:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220909121224.GA220905@lothringen>
References: <20220817191346.287594886@redhat.com>
 <20220817191524.201253713@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817191524.201253713@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 04:13:48PM -0300, Marcelo Tosatti wrote:
> From: Aaron Tomlin <atomlin@redhat.com>
> 
> In the context of the idle task and an adaptive-tick mode/or a nohz_full
> CPU, quiet_vmstat() can be called: before stopping the idle tick,
> entering an idle state and on exit. In particular, for the latter case,
> when the idle task is required to reschedule, the idle tick can remain
> stopped

Since quiet_vmstat() is only called when ts->tick_stopped = false, this
can only happen if the idle loop did not enter into dynticks idle mode
but the exiting idle task eventually stops the tick
(tick_nohz_idle_update_tick()).

This can happen for example if we enter the idle loop with a timer callback
pending in one jiffies, then once that timer fires, which wakes up a task,
we exit the idle loop and then tick_nohz_idle_update_tick() doesn't see any
timer callback pending left and the tick can be stopped.

Or am I missing something?

> and the timer expiration time endless i.e., KTIME_MAX. Now,
> indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> counters should be processed to ensure the respective values have been
> reset and folded into the zone specific 'vm_stat[]'. That being said, it
> can only occur when: the idle tick was previously stopped, and
> reprogramming of the timer is not required.
> 
> A customer provided some evidence which indicates that the idle tick was
> stopped; albeit, CPU-specific vmstat counters still remained populated.
> Thus one can only assume quiet_vmstat() was not invoked on return to the
> idle loop.
> 
> If I understand correctly, I suspect this divergence might erroneously
> prevent a reclaim attempt by kswapd. If the number of zone specific free
> pages are below their per-cpu drift value then
> zone_page_state_snapshot() is used to compute a more accurate view of
> the aforementioned statistic.  Thus any task blocked on the NUMA node
> specific pfmemalloc_wait queue will be unable to make significant
> progress via direct reclaim unless it is killed after being woken up by
> kswapd (see throttle_direct_reclaim()).
> 
> Consider the following theoretical scenario:
> 
>         1.      CPU Y migrated running task A to CPU X that was
>                 in an idle state i.e. waiting for an IRQ - not
>                 polling; marked the current task on CPU X to
>                 need/or require a reschedule i.e., set
>                 TIF_NEED_RESCHED and invoked a reschedule IPI to
>                 CPU X (see sched_move_task())

CPU Y is nohz_full right?

> 
>         2.      CPU X acknowledged the reschedule IPI from CPU Y;
>                 generic idle loop code noticed the
>                 TIF_NEED_RESCHED flag against the idle task and
>                 attempts to exit of the loop and calls the main
>                 scheduler function i.e. __schedule().
> 
>                 Since the idle tick was previously stopped no
>                 scheduling-clock tick would occur.
>                 So, no deferred timers would be handled
> 
>         3.      Post transition to kernel execution Task A
>                 running on CPU Y, indirectly released a few pages
>                 (e.g. see __free_one_page()); CPU Y's
>                 'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
>                 specific 'vm_stat[]' update was deferred as per the
>                 CPU-specific stat threshold
> 
>         4.      Task A does invoke exit(2) and the kernel does
>                 remove the task from the run-queue; the idle task
>                 was selected to execute next since there are no
>                 other runnable tasks assigned to the given CPU
>                 (see pick_next_task() and pick_next_task_idle())

This happens on CPU X, right?

> 
>         5.      On return to the idle loop since the idle tick
>                 was already stopped and can remain so (see [1]
>                 below) e.g. no pending soft IRQs, no attempt is
>                 made to zero and fold CPU Y's vmstat counters
>                 since reprogramming of the scheduling-clock tick
>                 is not required/or needed (see [2])

And now back to CPU Y, confused...

[...]
> Index: linux-2.6/kernel/time/tick-sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/time/tick-sched.c
> +++ linux-2.6/kernel/time/tick-sched.c
> @@ -26,6 +26,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/context_tracking.h>
>  #include <linux/mm.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/irq_regs.h>
>  
> @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
>  	}
>  }
>  
> +void __tick_nohz_user_enter_prepare(void)
> +{
> +	struct tick_sched *ts;
> +
> +	if (tick_nohz_full_cpu(smp_processor_id())) {
> +		ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +		if (ts->tick_stopped)
> +			quiet_vmstat();

Wasn't it supposed to be part of the quiescing in task isolation
mode?

Because currently vmstat is a deferrable timer but that deferrability
may not apply to nohz_full anymore (outside idle). And quiet_vmstat()
doesn't cancel the timer so you'll still get the disturbance.

See this patch: https://lore.kernel.org/lkml/20220725104356.GA2950296@lothringen/

> +		rcu_nocb_flush_deferred_wakeup();
> +	}
> +}
>
> +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> +
>  /* Get the boot-time nohz CPU list from the kernel parameters. */
>  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
>  {
> @@ -890,6 +905,9 @@ static void tick_nohz_stop_tick(struct t
>  		ts->do_timer_last = 0;
>  	}
>  
> +	/* Attempt to fold when the idle tick is stopped or not */
> +	quiet_vmstat();
> +
>  	/* Skip reprogram of event if its not changed */
>  	if (ts->tick_stopped && (expires == ts->next_tick)) {
>  		/* Sanity check: make sure clockevent is actually programmed */

But that chunk looks good.

Thanks.

> @@ -911,7 +929,6 @@ static void tick_nohz_stop_tick(struct t
>  	 */
>  	if (!ts->tick_stopped) {
>  		calc_load_nohz_start();
> -		quiet_vmstat();
>  
>  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  		ts->tick_stopped = 1;
> 
> 
