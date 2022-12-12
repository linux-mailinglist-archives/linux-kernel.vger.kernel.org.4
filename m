Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA4F6498E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLLGNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiLLGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:13:50 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA032BE9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:13:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id t2so8036547ply.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdASsNtOHJ2Lo5LrW687row8z68ODDqajx+4qMPPl7M=;
        b=fdJNVzqRu4X6CO9HyI90zvc1+8yuEcfwU1AIjM4LcA9XvRSFBxbvjrVi57ZPpq79rt
         n1ElPzSbLXT7kPhvCeOSK9HPDA7223llWYkwm3LBZYJTQ4h2Brd1sAwdjg4qdaaRC3PC
         YaBnnuo9DX11FbLWDj/cmos2oqavzBxEFXdQ/dP+76qUDyKcayb5d8pwlHUSOxrL/zrO
         0BPlwGAGJM3vGk8L9mRy9r3o9e5isOnmf/0ILyjdSadwJq8dh9d+aSensJ8cnI+NuhGR
         AmAVRdhF9XE2/TfYQZ5odgmWcNGCd1Ow9yfBibbLwNbtxe+QIw628a7fuJc5k6yJtxzK
         ZAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FdASsNtOHJ2Lo5LrW687row8z68ODDqajx+4qMPPl7M=;
        b=gbh0O6H5tK1p4HQcWcYJorNTWZnZ8bLrxDGfjSbl0GhcLWipCito9hOZyH5LcMGs6x
         b//pxrLvuAvmzbVdqRYCbchM3fO8zRSGYeCcnYRalx8rbw2WZW8VOo3VmnpXUVRO/nZj
         4ejdkoIHmRDsn4/8nv3Q13j4iLMSGJM6KQhc9j656NBjaz6rVvv8Vb6Mt2i//2uoT5YP
         TX064CU+FxYGUuQuwJ13U9a5AhlUgDrKIUM1VnGODaTgAGqDvGJ1OglEq7/d6G3c6hX9
         ncwZfGFumBMSRyiL8qF05k1sXV9/nHRke4b9JTGul8MWw0muuoM42nTVH6oGkz8avcIq
         IZcQ==
X-Gm-Message-State: ANoB5pk2qPgIy1B1B+hB3e9su+usH45MF5QkWTbVsyV/99mX9pTD73Q5
        3Lut5/OW2KOlx7M+gjdIHpacwg==
X-Google-Smtp-Source: AA0mqf5mu/kjEVVSCg27opNJxcEIaSNGXg1Wh6qpgVs2jfFdLTZ2xxDZ1332OYWaCP/Xu5SF4zBpUg==
X-Received: by 2002:a05:6a21:3d06:b0:ac:9a96:9bb with SMTP id bi6-20020a056a213d0600b000ac9a9609bbmr17974686pzc.60.1670825628113;
        Sun, 11 Dec 2022 22:13:48 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id h22-20020a632116000000b0047947e7b089sm1294047pgh.60.2022.12.11.22.13.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Dec 2022 22:13:47 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RFC PATCH] sched: Throttling through task work for cfs bandwidth
Date:   Mon, 12 Dec 2022 14:13:21 +0800
Message-Id: <20221212061321.36422-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

If task holds resources and is throttled in the kernel space, it may
cause stuck. This patch tries to solve this problem by using task_work
to throttle task when the task returns to user mode.

This patch uses task_work to dequeue the task when the task returns to
user mode, and then enqueues each task when unthrottle. It seems to work,
but the implementation does not take into account all the details right
now such as race conditions, load tracking, etc. I think the greatest
disadvantage of this solution is that there may be too many tasks that
need to be enqueued during unthrottle, resulting in large overhead and
delay.

I haven't thought of a better solution for now, so I hope to refer to
anyone's ideas, any comments are welcome.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 arch/x86/include/asm/thread_info.h |   2 +
 kernel/sched/fair.c                | 163 +++++++++--------------------
 kernel/sched/sched.h               |   1 +
 3 files changed, 55 insertions(+), 111 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f0cb881c1d69..cff23468533d 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -100,6 +100,7 @@ struct thread_info {
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
+#define TIF_NEED_THROTTLED	30
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define _TIF_NEED_THROTTLED	(1 << TIF_NEED_THROTTLED)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3217bbc861fb..9545e99eeb55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5246,10 +5246,15 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static void
+enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
+
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct sched_entity *se, *tmp;
+	struct task_struct *p;
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
@@ -5259,6 +5264,12 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		/* Add cfs_rq with load or one or more already running entities to the list */
 		if (!cfs_rq_is_decayed(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
+		/* Enqueue each throttled task */
+		list_for_each_entry_safe(se, tmp, &cfs_rq->throttled_tasks, group_node) {
+			list_del_init(&se->group_node);
+			p = task_of(se);
+			enqueue_task_fair(se->cfs_rq->rq, p, ENQUEUE_WAKEUP);
+		}
 	}
 
 	return 0;
@@ -5284,7 +5295,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, dequeue = 1;
+	long dequeue = 1;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5314,49 +5325,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running -= task_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-
-		if (qcfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			break;
-		}
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		update_load_avg(qcfs_rq, se, 0);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running -= task_delta;
-		qcfs_rq->idle_h_nr_running -= idle_task_delta;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
-
-done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5371,7 +5339,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5401,46 +5368,6 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
-	idle_task_delta = cfs_rq->idle_h_nr_running;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		if (se->on_rq)
-			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running += task_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		update_load_avg(qcfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
-
-		qcfs_rq->h_nr_running += task_delta;
-		qcfs_rq->idle_h_nr_running += idle_task_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, task_delta);
-
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
@@ -6200,10 +6127,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}
 
@@ -6219,10 +6142,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6278,10 +6197,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
 
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -6309,11 +6224,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 		if (cfs_rq_is_idle(cfs_rq))
 			idle_h_nr_running = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
-
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -6323,7 +6233,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -7811,6 +7720,21 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 }
 #endif
 
+/*
+ * This function is registered into task_work (executed when returning
+ * to user mode), it sets the TIF_NEED_THROTTLED flag and reschedules
+ * when a task needs to be throttled.
+ */
+void throttle_work(struct callback_head *arg)
+{
+	test_and_set_tsk_thread_flag(current, TIF_NEED_THROTTLED);
+	schedule();
+}
+
+struct callback_head throttle_work_head = {
+	.next = NULL,
+	.func = throttle_work,
+};
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -7856,14 +7780,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 			 * Therefore the nr_running test will indeed
 			 * be correct.
 			 */
-			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
-
-				if (!cfs_rq->nr_running)
-					goto idle;
-
-				goto simple;
-			}
+			check_cfs_rq_runtime(cfs_rq);
 		}
 
 		se = pick_next_entity(cfs_rq, curr);
@@ -7872,6 +7789,19 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 
 	p = task_of(se);
 
+	/*
+	 * If TIF_NEED_THROTTLED has been set and the task should be throttled,
+	 * dequeue the task.
+	 */
+	if (read_task_thread_flags(p) & TIF_NEED_THROTTLED) {
+		clear_ti_thread_flag(task_thread_info(p), TIF_NEED_THROTTLED);
+		if (throttled_hierarchy(se->cfs_rq)) {
+			dequeue_task_fair(rq, p, DEQUEUE_SLEEP);
+			list_add(&se->group_node, &p->se.cfs_rq->throttled_tasks);
+			cfs_rq = &rq->cfs;
+			goto again;
+		}
+	}
 	/*
 	 * Since we haven't yet done put_prev_entity and if the selected task
 	 * is a different task than we started out with, try and touch the
@@ -7927,6 +7857,13 @@ done: __maybe_unused;
 
 	update_misfit_status(p, rq);
 
+	/*
+	 * If the picked task should be throttled, register task_work for it
+	 * to reschedule when returning to user mode.
+	 */
+	if (throttled_hierarchy(se->cfs_rq))
+		SCHED_WARN_ON(task_work_add(p, &throttle_work_head, TWA_RESUME));
+
 	return p;
 
 idle:
@@ -12183,6 +12120,10 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
+
+#ifdef CONFIG_CFS_BANDWIDTH
+	INIT_LIST_HEAD(&cfs_rq->throttled_tasks);
+#endif
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b3d6e819127c..783976b57bcb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -645,6 +645,7 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
+	struct list_head	throttled_tasks;
 #ifdef CONFIG_SMP
 	struct list_head	throttled_csd_list;
 #endif
-- 
2.20.1

