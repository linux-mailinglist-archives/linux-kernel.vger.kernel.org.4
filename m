Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D864E124
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiLOSnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOSn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:43:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5E81F2D6;
        Thu, 15 Dec 2022 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671129808; x=1702665808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AqEHvlskx4rtrjusOKK+J8+6xy4K2wZNwLCxCtE3Z5c=;
  b=FrMbkQo19LdFseUuHWftPzlMumW6YmCLX/ZJ5kTNm/N2Wn+yqD+OiH9p
   iQ3crpJiiM3+v1adnSqzx5s/PxeMzpNkzmM+U4uZjwCW2XgE3IKi9UNc0
   /DtwAy2fyfS6Y9Rr9+x5Iiu+k7uNy0O5BD46MreMi8AVO9hKaYGk5AX9m
   I/l3OfeAHofPTAHwKVb89+KasNlB+bS3AjwNeteSVNvDtwCvGJ6EXoml1
   SMcuJFKe7PaRWP7ipndSwZVfucpGNFAb7gFqOmi3jMwB3ubg0sv9uEXzS
   0ffEPSHSSPtsfI2jQHUJpN+c5LoI6O7lvtO5fX+AbJ3w5MyDcCsorxjpf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299112637"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299112637"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="756442189"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="756442189"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2022 10:43:27 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, peterz@infradead.org, frederic@kernel.org,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT PATCH 0/2] Forced idle and Non-RCU local softirq pending
Date:   Thu, 15 Dec 2022 10:42:58 -0800
Message-Id: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux has support for idle injection for a while. To inject time
play_idle_precise() is used.

When idle time is injected using play_idle_precise(), there are couple of issues:

1. Sometimes there are Warning in kernel log:

[147777.095484] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
[147777.099719] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #288!!!
[147777.103725] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #288!!!

2. Softirq processing is delayed

A sample kernel trace is in the commit log of patch 0001.

There were offline discussion with Frederic and Peter on this issue.
Frederic sent a test patch with some todos, which I tried to address.
The solution proposed here is that if a ksoftirq is pending break the
do_idle() in loop and give 1 jiffie to process via schedule_timeout(1).

The conversation is pasted here to establish context:

On Sat, Sep 18, 2021 at 08:55:48AM +0200, Peter Zijlstra wrote:
> On Fri, Sep 17, 2021 at 11:42:21PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 13, 2021 at 02:58:59AM +0000, Pandruvada, Srinivas wrote:
> > > Hi Frederic,
> > > 
> > > Peter suggested to contact you regarding some issues with force idle
> > > and softirqs. You may have some changes in work or suggestions.
> > > 
> > > We are trying to use idle injection on some CPUs for thermal and
> > > performance reasons. This is done via Linux idle_injection interface
> > > (powercap/idle_inject.c) which calls scheduler function
> > > play_idle_precise(). This results in calling can_stop_idle_tick() via
> > > tick_nohz_idle_stop_tick(), which results in printing of:
> > > 
> > > [  185.765383] NOHZ tick-stop error: Non-RCU local softirq work is
> > > pending, CPU 207 handler #08!!!
> > > 
> > > 
> > > So when tick is about to be stopped, either this work needs to be
> > > migrated or we wait for softirq to be executed and then disable on the
> > > CPU. Please suggest.
> > 
> > You can't blindly migrate softirqs because they often depend on the CPU they
> > are queued on. So you need to wait for them to execute.
> > 
> > As for how to adapt the warning with taking idle injection into consideration,
> > I need to understand something first: how comes we reach this path without
> > need_resched() set?
> 
> It might be set, but the idle inject thread wins from ksoftirqd, it
> being FIFO.

Ah ok.

> > Also looking at play_idle_precise(), we only ever escape the idle loop once
> > the idle inject timer has fired. The need for resched is never checked to break
> > the loop.
> 
> do_idle() has a schedule() loop it it, it will happily schedule.

Oops, forgot my basics...

> The thing is that the idle injection thread is typically the highest
> priority runnable thread and as such will starve things (on purpose).
> 
> Only higher prio FIFO, any DEADLINE or the STOP thread can effectively
> preempt idle injection (and actual IRQs ofcourse).

I see... In fact need_resched() shouldn't even be set in this case I guess...

> 
> So I supopse an IRQ can happen, not finish the softirq in its tail, try
> and punt to ksoftirqd and not get scheduled because idle (injection)
> wins on priority.
> 
> The question is what do we want to do there... we could just run the
> softirq crap from the idle injection thread, seeing how the work
> shouldn't be there in the first place, but since it is, it need being
> done.
> 
> Feels gross tho...

How about the other gross following solution (untested)?:

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5ce6ac..882c48441469 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -52,6 +52,12 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
+/* FIXME: handle __cpuidle / instrumentation_begin()/end() */
+static bool idle_loop_should_break(void)
+{
+	return need_resched() || task_is_running(__this_cpu_read(ksoftirqd));
+}
+
 static noinline int __cpuidle cpu_idle_poll(void)
 {
 	trace_cpu_idle(0, smp_processor_id());
@@ -59,7 +65,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	rcu_idle_enter();
 	local_irq_enable();
 
-	while (!tif_need_resched() &&
+	while (!idle_loop_should_break() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 
@@ -177,7 +183,7 @@ static void cpuidle_idle_call(void)
 	 * Check if the idle task must be rescheduled. If it is the
 	 * case, exit the function after re-enabling the local irq.
 	 */
-	if (need_resched()) {
+	if (idle_loop_should_break()) {
 		local_irq_enable();
 		return;
 	}
@@ -279,7 +285,7 @@ static void do_idle(void)
 	__current_set_polling();
 	tick_nohz_idle_enter();
 
-	while (!need_resched()) {
+	while (!idle_loop_should_break()) {
 		rmb();
 
 		local_irq_disable();
@@ -373,25 +379,31 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!duration_ns);
 	WARN_ON_ONCE(current->mm);
 
-	rcu_sleep_check();
-	preempt_disable();
-	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(latency_ns);
+	do {
+		rcu_sleep_check();
+		preempt_disable();
+		current->flags |= PF_IDLE;
+		cpuidle_use_deepest_state(latency_ns);
 
-	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function = idle_inject_timer_fn;
-	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
-		      HRTIMER_MODE_REL_PINNED_HARD);
+		it.done = 0;
+		hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+		it.timer.function = idle_inject_timer_fn;
+		hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
+			      HRTIMER_MODE_REL_PINNED_HARD);
 
-	while (!READ_ONCE(it.done))
-		do_idle();
+		while (!READ_ONCE(it.done) && !task_is_running(__this_cpu_read(ksoftirqd)))
+			do_idle();
+
+		cpuidle_use_deepest_state(0);
+		current->flags &= ~PF_IDLE;
 
-	cpuidle_use_deepest_state(0);
-	current->flags &= ~PF_IDLE;
+		preempt_fold_need_resched();
+		preempt_enable();
 
-	preempt_fold_need_resched();
-	preempt_enable();
+		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
+		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd)))
+			schedule_timeout(1);
+	} while (!READ_ONCE(it.done));
 }
 EXPORT_SYMBOL_GPL(play_idle_precise);
 


> > How about the other gross following solution (untested)?:
> > 
> It causes NMI watchdog because lockup on the CPU where the idle
> injection is done. Attached the dump.
> 
> I have to add on top the following diff to avoid lockup. With this I
> don't see the 
> " NOHZ tick-stop error: Non-RCU local softirq work is pending,"
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index a747a36330a8..e1ec5157a671 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -394,13 +394,18 @@ void play_idle_precise(u64 duration_ns, u64
> latency_ns)
>                 while (!READ_ONCE(it.done) &&
> !task_is_running(__this_cpu_read(ksoftirqd)))
>                         do_idle();
>  
> +               hrtimer_cancel(&it.timer);
> +       
>                 cpuidle_use_deepest_state(0);
>                 current->flags &= ~PF_IDLE;
>  
>                 preempt_fold_need_resched();
>                 preempt_enable();
>                 /* Give ksoftirqd 1 jiffy to get a chance to start its
> job */
> +               if (!READ_ONCE(it.done) &&
> task_is_running(__this_cpu_read(ksoftirqd))) {
> +                       __set_current_state(TASK_UNINTERRUPTIBLE);
>                         schedule_timeout(1);
> +               }
>         } while (!READ_ONCE(it.done));
>  }
>  EXPORT_SYMBOL_GPL(play_idle_precise);

Ah right.

Also, beware of a few details:

1) This can loop forever if there is a long and strong softirq activity.
   So we need to define some timeout. This also means play_idle_precise() should
   return some error.
   
<Patch 0002 adds a maximum limit as a parameter.>   

2) Do you need to make that loop interruptible? I don't know if the idle
   injection request comes directly from userspace or is it some kernel thread.
<This is done via a kernel thread. User space can't interrupt. It can change the idle percent, which will be picked up next time by powercap/idle_inject>

3) Do you need to substract some time spent waiting for softirqs execution to
   the idle injection time? Probably not, I guess it depends on the role played
   by this idle injection but I figured I should ask.
<Don't need to be that accurate as this is for thermal control, which doesn't need to be accurate>

4) An interrupt can fire in the middle of the idle injection, raising a softirq.
   In this case you need to re-injection the remaining idle time.
   eg: Imagine you program a 3 seconds idle injection. You sleep 1 second, an
   interrupt fires and raise a softirq, you schedule out, then once the softirq
   handled you need to reprogram 2 seconds.
<Handled in patch 0001 for starting timer for remaining time.>

5) We still need to handle __cpuidle sections.
<Add cpuidle section for your FIXME. But don't understand the need for noinstr and instrumentation_begin()/end().>


Frederic Weisbecker (1):
  sched/core: Check and schedule ksoftirq

Srinivas Pandruvada (1):
  sched/core: Define max duration to play_precise_idle()

 drivers/powercap/idle_inject.c |  4 ++-
 include/linux/cpu.h            |  4 +--
 kernel/sched/idle.c            | 66 ++++++++++++++++++++++++----------
 3 files changed, 52 insertions(+), 22 deletions(-)

-- 
2.38.1
