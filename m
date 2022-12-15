Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4D564E125
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLOSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLOSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:43:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFA620343;
        Thu, 15 Dec 2022 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671129809; x=1702665809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELcbuLbz+D9wrsIJ2hLNbj73bW27WcmKW6Jeb1abta4=;
  b=WtD5eTpnCIHaoBsh0H/xfoHHNhS5qC8i1Vxxp1KziCpbe5938V+EIMNB
   qfeNhb1UL+0lqOv0T5cuYAN71LwVqqZIVeLn+RlpyqZ5t6MYncpqO041o
   YEvqzsI9jS06BXYlIOfhmkpSbVJYajSK+TjWpIYr25o+6dKQYHh/gLRLX
   jJGL7RZXQOzDdDyZTfW30t88pLsaVBN331hsITqECGkKDh4l1/fVoIyT8
   SEOZTBhnWmQSSGVjv3XTWFNVgRsbO3S5SVxh8LDf8oWCNVGpTmlWAmpsO
   N3dKxwcFTRoSa1lJPOR0+PckSL4rB+M5p46v6iRQeTgOZoBZ1tJTsqsdp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299112641"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299112641"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="756442192"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="756442192"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2022 10:43:27 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, peterz@infradead.org, frederic@kernel.org,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
Date:   Thu, 15 Dec 2022 10:42:59 -0800
Message-Id: <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
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

From: Frederic Weisbecker <frederic@kernel.org>

It is possible that ksoftirqd is woken up and racing with forced
idle injection via play_idle_precise() called from a FIFO thread.

Here it is possible that need_resched() is false but ksoftirqd
is pending. This will result in printing of warning:

[147777.095484] NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!

Also the processing can be delayed upto the duration of forced idle.

For example in the following traces (with added traces for debug):

<idle>-0 [004] 207.087742: sched_wakeup: ksoftirqd/4
<idle>-0 [004] 207.087743: sched_switch: swapper/4:0 [120] R ==> idle_inject/4:37 [49]

idle_inject/4-37 [004] 207.087744: play_idle_enter
idle_inject/4-37 [004] 207.087746: bputs: can_stop_idle_tick.isra.16: soft irq pending

(Printed warning at this point
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!

...
...
idle_inject/4-37 [004] 207.112127: play_idle_exit: state=24000000 cpu_id=4

idle_inject/4-37 [004] 207.112134: sched_switch: idle_inject/4:37 [49] S ==> ksoftirqd/4:39 [120]
ksoftirqd/4-39   [004] 207.112142: softirq_entry: vec=3 [action=NET_RX]
ksoftirqd/4-39   [004] 207.112213: irq_handler_entry: irq=142 name=enp0s

Delayed by :  207.112142 - 207.087742 = 0.024400
(250HZ configuration) and the idle duration for play_idle_precise is 24ms.
So, the softirq entered after the expiry of forced idle time.

The solution here is to give chance to run softirq. Currently do_idle()
checks for need_resched() and break. But here in addition to need_resched()
also added a check for task_is_running(__this_cpu_read(ksoftirqd)).
So if the ksoftirq is pending break the do_idle() loop and give 1 jiffie
to process via schedule_timeout(1). If the required idle time is
not expired, start hrtimer again and call do_idle() again.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 kernel/sched/idle.c | 55 ++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..77d6168288cf 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -49,6 +49,11 @@ static int __init cpu_idle_nopoll_setup(char *__unused)
 __setup("hlt", cpu_idle_nopoll_setup);
 #endif
 
+static bool __cpuidle idle_loop_should_break(void)
+{
+	return need_resched() || task_is_running(__this_cpu_read(ksoftirqd));
+}
+
 static noinline int __cpuidle cpu_idle_poll(void)
 {
 	trace_cpu_idle(0, smp_processor_id());
@@ -56,7 +61,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 	ct_idle_enter();
 	local_irq_enable();
 
-	while (!tif_need_resched() &&
+	while (!idle_loop_should_break() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 
@@ -174,7 +179,7 @@ static void cpuidle_idle_call(void)
 	 * Check if the idle task must be rescheduled. If it is the
 	 * case, exit the function after re-enabling the local irq.
 	 */
-	if (need_resched()) {
+	if (idle_loop_should_break()) {
 		local_irq_enable();
 		return;
 	}
@@ -276,7 +281,7 @@ static void do_idle(void)
 	__current_set_polling();
 	tick_nohz_idle_enter();
 
-	while (!need_resched()) {
+	while (!idle_loop_should_break()) {
 		rmb();
 
 		local_irq_disable();
@@ -358,6 +363,7 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 void play_idle_precise(u64 duration_ns, u64 latency_ns)
 {
 	struct idle_timer it;
+	ktime_t remaining;
 
 	/*
 	 * Only FIFO tasks can disable the tick since they don't need the forced
@@ -370,25 +376,38 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!duration_ns);
 	WARN_ON_ONCE(current->mm);
 
-	rcu_sleep_check();
-	preempt_disable();
-	current->flags |= PF_IDLE;
-	cpuidle_use_deepest_state(latency_ns);
+	remaining = ns_to_ktime(duration_ns);
 
-	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	it.timer.function = idle_inject_timer_fn;
-	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
-		      HRTIMER_MODE_REL_PINNED_HARD);
+	do {
+		rcu_sleep_check();
+		preempt_disable();
+		current->flags |= PF_IDLE;
+		cpuidle_use_deepest_state(latency_ns);
 
-	while (!READ_ONCE(it.done))
-		do_idle();
+		it.done = 0;
+		hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+		it.timer.function = idle_inject_timer_fn;
+		hrtimer_start(&it.timer, remaining, HRTIMER_MODE_REL_PINNED_HARD);
+
+		while (!READ_ONCE(it.done) && !task_is_running(__this_cpu_read(ksoftirqd)))
+			do_idle();
 
-	cpuidle_use_deepest_state(0);
-	current->flags &= ~PF_IDLE;
+		remaining = hrtimer_get_remaining(&it.timer);
 
-	preempt_fold_need_resched();
-	preempt_enable();
+		hrtimer_cancel(&it.timer);
+
+		cpuidle_use_deepest_state(0);
+		current->flags &= ~PF_IDLE;
+
+		preempt_fold_need_resched();
+		preempt_enable();
+
+		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
+		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd))) {
+			__set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(1);
+		}
+	} while (!READ_ONCE(it.done));
 }
 EXPORT_SYMBOL_GPL(play_idle_precise);
 
-- 
2.38.1

