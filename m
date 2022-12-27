Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2663C656A14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiL0Lvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiL0Lv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:51:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF49E9FE2;
        Tue, 27 Dec 2022 03:51:26 -0800 (PST)
Date:   Tue, 27 Dec 2022 11:51:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUaRh4s0jjHTzReO3YkF+o9YlogvhWdiOX1ZGicrJko=;
        b=R+uduPwSL+ORZab0kRsmMEpScLaYmuwQi5BNKovAwUlAPV7Jrr+Vyr4klDpanCXhZWp+US
        dclkwuhjN1WeJkL1e2KxizSV2Z4HsqYVXNEVLel3G1QKidnJ/zvNAHdA1I3BR2YoOIjLOP
        5agAnqyV4Dvq49eaudXG2dfQ/EsHpFqqtgKaahO/nhRrVQDGOlQlslyHm/aZCA6tY8l8EZ
        62F3+DOFbhUAB624eaXhTRdKj7mhNniqOjTtFZo8cI17fFnldgFu4hG5DDeMfPJlYAicnS
        LYOWN11fzCzjCMzuLrtiZzum+VduVvdMj8zML3Zrr58pE02nptIBTMCoT1hWIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672141884;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUaRh4s0jjHTzReO3YkF+o9YlogvhWdiOX1ZGicrJko=;
        b=q5kFkofawqbZmxYX4DBNxzoTq9/eVEHrYjsE3KU5OGl+gA6nIZGurHq40JM30ka3QWzDXZ
        NAmLCrSQ2bfx1rCA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix cgroup events tracking
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221207124023.66252-1-zhouchengming@bytedance.com>
References: <20221207124023.66252-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <167214188393.4906.7905421001352777277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f841b682baef90ee144df8b12e2c76aa460717c1
Gitweb:        https://git.kernel.org/tip/f841b682baef90ee144df8b12e2c76aa460717c1
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 07 Dec 2022 20:40:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:44:00 +01:00

perf/core: Fix cgroup events tracking

We encounter perf warnings when using cgroup events like:

  cd /sys/fs/cgroup
  mkdir test
  perf stat -e cycles -a -G test

Which then triggers:

  WARNING: CPU: 0 PID: 690 at kernel/events/core.c:849 perf_cgroup_switch+0xb2/0xc0
  Call Trace:
   <TASK>
   __schedule+0x4ae/0x9f0
   ? _raw_spin_unlock_irqrestore+0x23/0x40
   ? __cond_resched+0x18/0x20
   preempt_schedule_common+0x2d/0x70
   __cond_resched+0x18/0x20
   wait_for_completion+0x2f/0x160
   ? cpu_stop_queue_work+0x9e/0x130
   affine_move_task+0x18a/0x4f0

  WARNING: CPU: 0 PID: 690 at kernel/events/core.c:829 ctx_sched_in+0x1cf/0x1e0
  Call Trace:
   <TASK>
   ? ctx_sched_out+0xb7/0x1b0
   perf_cgroup_switch+0x88/0xc0
   __schedule+0x4ae/0x9f0
   ? _raw_spin_unlock_irqrestore+0x23/0x40
   ? __cond_resched+0x18/0x20
   preempt_schedule_common+0x2d/0x70
   __cond_resched+0x18/0x20
   wait_for_completion+0x2f/0x160
   ? cpu_stop_queue_work+0x9e/0x130
   affine_move_task+0x18a/0x4f0

The above two warnings are not complete here since I remove other
unimportant information. The problem is caused by the perf cgroup
events tracking:

  CPU0					CPU1
  perf_event_open()
    perf_event_alloc()
      account_event()
	account_event_cpu()
	  atomic_inc(perf_cgroup_events)
					  __perf_event_task_sched_out()
					    if (atomic_read(perf_cgroup_events))
					      perf_cgroup_switch()
						// kernel/events/core.c:849
						WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0)
						if (READ_ONCE(cpuctx->cgrp) == cgrp) // false
						  return
						perf_ctx_lock()
						ctx_sched_out()
						cpuctx->cgrp = cgrp
						ctx_sched_in()
						  perf_cgroup_set_timestamp()
						    // kernel/events/core.c:829
						    WARN_ON_ONCE(!ctx->nr_cgroups)
						perf_ctx_unlock()
    perf_install_in_context()
      cpu_function_call()
					  __perf_install_in_context()
					    add_event_to_ctx()
					      list_add_event()
						perf_cgroup_event_enable()
						  ctx->nr_cgroups++
						  cpuctx->cgrp = X

We can see from above that we wrongly use percpu atomic perf_cgroup_events
to check if we need to perf_cgroup_switch(), which should only be used
when we know this CPU has cgroup events enabled.

The commit bd2756811766 ("perf: Rewrite core context handling") change
to have only one context per-CPU, so we can just use cpuctx->cgrp to
check if this CPU has cgroup events enabled.

So percpu atomic perf_cgroup_events is not needed.

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20221207124023.66252-1-zhouchengming@bytedance.com
---
 kernel/events/core.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4bd2434..37c0f04 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -380,7 +380,6 @@ enum event_type_t {
 
 /*
  * perf_sched_events : >0 events exist
- * perf_cgroup_events: >0 per-cpu cgroup events exist on this cpu
  */
 
 static void perf_sched_delayed(struct work_struct *work);
@@ -389,7 +388,6 @@ static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
 static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
-static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -844,9 +842,16 @@ static void perf_cgroup_switch(struct task_struct *task)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
 	struct perf_cgroup *cgrp;
 
-	cgrp = perf_cgroup_from_task(task, NULL);
+	/*
+	 * cpuctx->cgrp is set when the first cgroup event enabled,
+	 * and is cleared when the last cgroup event disabled.
+	 */
+	if (READ_ONCE(cpuctx->cgrp) == NULL)
+		return;
 
 	WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
+
+	cgrp = perf_cgroup_from_task(task, NULL);
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
 
@@ -3631,8 +3636,7 @@ void __perf_event_task_sched_out(struct task_struct *task,
 	 * to check if we have to switch out PMU state.
 	 * cgroup event are system-wide mode only
 	 */
-	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_switch(next);
+	perf_cgroup_switch(next);
 }
 
 static bool perf_less_group_idx(const void *l, const void *r)
@@ -4974,15 +4978,6 @@ static void unaccount_pmu_sb_event(struct perf_event *event)
 		detach_sb_event(event);
 }
 
-static void unaccount_event_cpu(struct perf_event *event, int cpu)
-{
-	if (event->parent)
-		return;
-
-	if (is_cgroup_event(event))
-		atomic_dec(&per_cpu(perf_cgroup_events, cpu));
-}
-
 #ifdef CONFIG_NO_HZ_FULL
 static DEFINE_SPINLOCK(nr_freq_lock);
 #endif
@@ -5048,8 +5043,6 @@ static void unaccount_event(struct perf_event *event)
 			schedule_delayed_work(&perf_sched_work, HZ);
 	}
 
-	unaccount_event_cpu(event, event->cpu);
-
 	unaccount_pmu_sb_event(event);
 }
 
@@ -11679,15 +11672,6 @@ static void account_pmu_sb_event(struct perf_event *event)
 		attach_sb_event(event);
 }
 
-static void account_event_cpu(struct perf_event *event, int cpu)
-{
-	if (event->parent)
-		return;
-
-	if (is_cgroup_event(event))
-		atomic_inc(&per_cpu(perf_cgroup_events, cpu));
-}
-
 /* Freq events need the tick to stay alive (see perf_event_task_tick). */
 static void account_freq_event_nohz(void)
 {
@@ -11775,8 +11759,6 @@ static void account_event(struct perf_event *event)
 	}
 enabled:
 
-	account_event_cpu(event, event->cpu);
-
 	account_pmu_sb_event(event);
 }
 
@@ -12822,13 +12804,11 @@ static void __perf_pmu_remove(struct perf_event_context *ctx,
 
 	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
 		perf_remove_from_context(event, 0);
-		unaccount_event_cpu(event, cpu);
 		put_pmu_ctx(event->pmu_ctx);
 		list_add(&event->migrate_entry, events);
 
 		for_each_sibling_event(sibling, event) {
 			perf_remove_from_context(sibling, 0);
-			unaccount_event_cpu(sibling, cpu);
 			put_pmu_ctx(sibling->pmu_ctx);
 			list_add(&sibling->migrate_entry, events);
 		}
@@ -12847,7 +12827,6 @@ static void __perf_pmu_install_event(struct pmu *pmu,
 
 	if (event->state >= PERF_EVENT_STATE_OFF)
 		event->state = PERF_EVENT_STATE_INACTIVE;
-	account_event_cpu(event, cpu);
 	perf_install_in_context(ctx, event, cpu);
 }
 
@@ -13742,8 +13721,7 @@ static int __perf_cgroup_move(void *info)
 	struct task_struct *task = info;
 
 	preempt_disable();
-	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
-		perf_cgroup_switch(task);
+	perf_cgroup_switch(task);
 	preempt_enable();
 
 	return 0;
