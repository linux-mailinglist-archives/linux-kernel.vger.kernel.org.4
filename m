Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62CD645A04
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLGMlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLGMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:40:54 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E95442FB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:40:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so1313739pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptv27xkLcPwoIm7YaEwuBfgKBwoJAskqJVYvfBmMC1A=;
        b=tARSdsz4QyyMBb1L8siswGjbZjP5jkhLVm6o7lFBhiFFOXLMaqTunxrgnj0ddmZ9zB
         9v7rkhXJyns7x4JTRpd0ZNsfH7g98WLXE4PXgNE/FiRkXw3FCxP6zmVNDwxQxn0Wtb/l
         ak/eb+Oc4mE6pCXzE7oKa1qmKmS5sygsrBzsjesW6WS0EzaJtNH03HMIa5WwSkHEcjvX
         15V8qg6toaKTgMTkwv3+ptlRxVBy7GpXpqVxmj77kExcwdX2H6omSlnu9FX/8NHj+cue
         KEQiAyH3zLOlFA/5te4kqUm47oG/GMKI/eJWlrC/0zfYe67pYQezKDOOUy44QvqogaFc
         BnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ptv27xkLcPwoIm7YaEwuBfgKBwoJAskqJVYvfBmMC1A=;
        b=lrv91AbaM8KwPUXxfBr8FP4nnRCtc1IH2UmOFZ7sbUPma94+n2jnKoL0PL6mDgtStG
         1KQSZ4gUKSQWY2gcwaOEhda2bTowB4F8HTtFaJJ92kPKs5HyTq48czRhVLIkE7rhlMwX
         1AjKsMbZGRMA8NkRTUedMhQjSrTzl9nLveALRsdF0uEKRizqxPWhqlGIQe1jUoVR5tOJ
         70Sv4hwirSFGKOVevOcjK/WT9RAfUUoClpqAqBxfFPmib2ytU645Bk1fX4j3j4D/WCQf
         +v5+GUjdn75Fd0wB0r93cRnsfY0/+PcEj0gcW6P5QKXLnN07C+RdWcjpSf8SPZJyM4Ay
         N0lA==
X-Gm-Message-State: ANoB5plevFvq9/KhHzN/JH8JkwBiN07xA0FYKTzyRaeq+AQIO5dbkDrM
        mOfu0WZr8nSHHA3WSBbZl7E7Qw==
X-Google-Smtp-Source: AA0mqf6PRoEnGMEjE90788F4cNilng4isoxRqmXXEbh6COq9RjiyCkuYudPs89jSL4qDUooXXJDV2g==
X-Received: by 2002:a17:902:6b47:b0:189:cd43:6c0d with SMTP id g7-20020a1709026b4700b00189cd436c0dmr17944322plt.161.1670416847616;
        Wed, 07 Dec 2022 04:40:47 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id v124-20020a626182000000b00574e4fe6118sm13467222pfb.162.2022.12.07.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 04:40:46 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, ravi.bangoria@amd.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] perf/core: Fix cgroup events tracking
Date:   Wed,  7 Dec 2022 20:40:23 +0800
Message-Id: <20221207124023.66252-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encounter perf warnings when using cgroup events like:
```
cd /sys/fs/cgroup
mkdir test
perf stat -e cycles -a -G test
```

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
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
v2:
 - Remove timestamps and fix race graph in commit log per Ravi Bangoria.
 - Add Fixes tag and Tested-by tag.
---
 kernel/events/core.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eacc3702654d..5d97a9f26003 100644
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
-- 
2.37.2

