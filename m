Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6B5B3FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 21:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIITgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIITgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 15:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6501116F2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 12:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662752161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0GvxAfFfB835crqmtiU98A7wbniAp5Qd55wr3Vt3ik=;
        b=gLvrqmo6rsA7F6vwvYjlEtZfAzn+w5jm5nF9YkWwq3ZYEbFmlu6DK40Ft2cSPL/9A02/c1
        z/q/JNkCZH7ClBhMYPom+F2Kxocmv1te4RlxtJVKHLfYCrddUYz/ItpAGoOrJB2/iKkjl5
        PltG5beu7eN9Lr2ZwRW5LpNuD/+Wo/c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-HcvGq-a3NIaS0UtyJte04g-1; Fri, 09 Sep 2022 15:35:58 -0400
X-MC-Unique: HcvGq-a3NIaS0UtyJte04g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1BD81818802;
        Fri,  9 Sep 2022 19:35:57 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 507FE40CF8EA;
        Fri,  9 Sep 2022 19:35:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 28ED1416D5CB; Fri,  9 Sep 2022 16:35:36 -0300 (-03)
Date:   Fri, 9 Sep 2022 16:35:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     atomlin@redhat.com, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 2/3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <YxuViCnKcIYVE02B@fuller.cnet>
References: <20220817191346.287594886@redhat.com>
 <20220817191524.201253713@redhat.com>
 <20220909121224.GA220905@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121224.GA220905@lothringen>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:12:24PM +0200, Frederic Weisbecker wrote:
> On Wed, Aug 17, 2022 at 04:13:48PM -0300, Marcelo Tosatti wrote:
> > From: Aaron Tomlin <atomlin@redhat.com>
> > 
> > In the context of the idle task and an adaptive-tick mode/or a nohz_full
> > CPU, quiet_vmstat() can be called: before stopping the idle tick,
> > entering an idle state and on exit. In particular, for the latter case,
> > when the idle task is required to reschedule, the idle tick can remain
> > stopped
> 
> Since quiet_vmstat() is only called when ts->tick_stopped = false, this
> can only happen if the idle loop did not enter into dynticks idle mode
> but the exiting idle task eventually stops the tick
> (tick_nohz_idle_update_tick()).
> 
> This can happen for example if we enter the idle loop with a timer callback
> pending in one jiffies, then once that timer fires, which wakes up a task,
> we exit the idle loop and then tick_nohz_idle_update_tick() doesn't see any
> timer callback pending left and the tick can be stopped.
> 
> Or am I missing something?

For the scenario where we re-enter idle without calling quiet_vmstat:


CPU-0			CPU-1

0) vmstat_shepherd notices its necessary to queue vmstat work 
to remote CPU, queues deferrable timer into timer wheel, and calls
trigger_dyntick_cpu (target_cpu == cpu-1).

			1) Stop the tick (get_next_timer_interrupt will not take deferrable
			   timers into account), calls quiet_vmstat, which keeps the vmstat work
			   (vmstat_update function) queued.
			2) Idle
			3) Idle exit
			4) Run thread on CPU, some activity marks vmstat dirty
			5) Idle
			6) Goto 3

At 5, since the tick is already stopped, the deferrable 
timer for the delayed work item will not execute,
and vmstat_shepherd will consider 

static void vmstat_shepherd(struct work_struct *w)
{
        int cpu;

        cpus_read_lock();
        /* Check processors whose vmstat worker threads have been disabled */
        for_each_online_cpu(cpu) {
                struct delayed_work *dw = &per_cpu(vmstat_work, cpu);

                if (!delayed_work_pending(dw) && need_update(cpu))
                        queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);

                cond_resched();
        }
        cpus_read_unlock();

        schedule_delayed_work(&shepherd,
                round_jiffies_relative(sysctl_stat_interval));
}

As far as i can tell...

> > and the timer expiration time endless i.e., KTIME_MAX. Now,
> > indeed before a nohz_full CPU enters an idle state, CPU-specific vmstat
> > counters should be processed to ensure the respective values have been
> > reset and folded into the zone specific 'vm_stat[]'. That being said, it
> > can only occur when: the idle tick was previously stopped, and
> > reprogramming of the timer is not required.
> > 
> > A customer provided some evidence which indicates that the idle tick was
> > stopped; albeit, CPU-specific vmstat counters still remained populated.
> > Thus one can only assume quiet_vmstat() was not invoked on return to the
> > idle loop.
> > 
> > If I understand correctly, I suspect this divergence might erroneously
> > prevent a reclaim attempt by kswapd. If the number of zone specific free
> > pages are below their per-cpu drift value then
> > zone_page_state_snapshot() is used to compute a more accurate view of
> > the aforementioned statistic.  Thus any task blocked on the NUMA node
> > specific pfmemalloc_wait queue will be unable to make significant
> > progress via direct reclaim unless it is killed after being woken up by
> > kswapd (see throttle_direct_reclaim()).
> > 
> > Consider the following theoretical scenario:
> > 
> >         1.      CPU Y migrated running task A to CPU X that was
> >                 in an idle state i.e. waiting for an IRQ - not
> >                 polling; marked the current task on CPU X to
> >                 need/or require a reschedule i.e., set
> >                 TIF_NEED_RESCHED and invoked a reschedule IPI to
> >                 CPU X (see sched_move_task())
> 
> CPU Y is nohz_full right?
> 
> > 
> >         2.      CPU X acknowledged the reschedule IPI from CPU Y;
> >                 generic idle loop code noticed the
> >                 TIF_NEED_RESCHED flag against the idle task and
> >                 attempts to exit of the loop and calls the main
> >                 scheduler function i.e. __schedule().
> > 
> >                 Since the idle tick was previously stopped no
> >                 scheduling-clock tick would occur.
> >                 So, no deferred timers would be handled
> > 
> >         3.      Post transition to kernel execution Task A
> >                 running on CPU Y, indirectly released a few pages
> >                 (e.g. see __free_one_page()); CPU Y's
> >                 'vm_stat_diff[NR_FREE_PAGES]' was updated and zone
> >                 specific 'vm_stat[]' update was deferred as per the
> >                 CPU-specific stat threshold
> > 
> >         4.      Task A does invoke exit(2) and the kernel does
> >                 remove the task from the run-queue; the idle task
> >                 was selected to execute next since there are no
> >                 other runnable tasks assigned to the given CPU
> >                 (see pick_next_task() and pick_next_task_idle())
> 
> This happens on CPU X, right?
> 
> > 
> >         5.      On return to the idle loop since the idle tick
> >                 was already stopped and can remain so (see [1]
> >                 below) e.g. no pending soft IRQs, no attempt is
> >                 made to zero and fold CPU Y's vmstat counters
> >                 since reprogramming of the scheduling-clock tick
> >                 is not required/or needed (see [2])
> 
> And now back to CPU Y, confused...

Aaron, can you explain the diagram above? 

AFAIU the problem can also be understood with the simpler
explanation above.

> [...]
> > Index: linux-2.6/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/time/tick-sched.c
> > +++ linux-2.6/kernel/time/tick-sched.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/posix-timers.h>
> >  #include <linux/context_tracking.h>
> >  #include <linux/mm.h>
> > +#include <linux/rcupdate.h>
> >  
> >  #include <asm/irq_regs.h>
> >  
> > @@ -519,6 +520,20 @@ void __tick_nohz_task_switch(void)
> >  	}
> >  }
> >  
> > +void __tick_nohz_user_enter_prepare(void)
> > +{
> > +	struct tick_sched *ts;
> > +
> > +	if (tick_nohz_full_cpu(smp_processor_id())) {
> > +		ts = this_cpu_ptr(&tick_cpu_sched);
> > +
> > +		if (ts->tick_stopped)
> > +			quiet_vmstat();
> 
> Wasn't it supposed to be part of the quiescing in task isolation
> mode?

Not requiring application changes seems useful (so if we can drop
the need for task isolation ioctls from userspace, that is better).

> Because currently vmstat is a deferrable timer but that deferrability
> may not apply to nohz_full anymore (outside idle). And quiet_vmstat()
> doesn't cancel the timer so you'll still get the disturbance.
> 
> See this patch: https://lore.kernel.org/lkml/20220725104356.GA2950296@lothringen/

Right.

But i think the nohz_full applications prefer not to be interrupted 
with the vmstat_work in the first place.

> > +		rcu_nocb_flush_deferred_wakeup();
> > +	}
> > +}
> >
> > +EXPORT_SYMBOL_GPL(__tick_nohz_user_enter_prepare);
> > +
> >  /* Get the boot-time nohz CPU list from the kernel parameters. */
> >  void __init tick_nohz_full_setup(cpumask_var_t cpumask)
> >  {
> > @@ -890,6 +905,9 @@ static void tick_nohz_stop_tick(struct t
> >  		ts->do_timer_last = 0;
> >  	}
> >  
> > +	/* Attempt to fold when the idle tick is stopped or not */
> > +	quiet_vmstat();
> > +
> >  	/* Skip reprogram of event if its not changed */
> >  	if (ts->tick_stopped && (expires == ts->next_tick)) {
> >  		/* Sanity check: make sure clockevent is actually programmed */
> 
> But that chunk looks good.
> 
> Thanks.

Do you see any issue with syncing the vmstat on return to userspace as
well, if nohz_full and tick is disabled? 

Note the syscall entry/exit numbers, the overhead is minimal.

> > @@ -911,7 +929,6 @@ static void tick_nohz_stop_tick(struct t
> >  	 */
> >  	if (!ts->tick_stopped) {
> >  		calc_load_nohz_start();
> > -		quiet_vmstat();
> >  
> >  		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
> >  		ts->tick_stopped = 1;
> > 
> > 
> 
> 

