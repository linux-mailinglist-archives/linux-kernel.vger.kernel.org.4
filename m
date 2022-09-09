Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF05B389A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiIINEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiIINDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:03:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7D1174A9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:03:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id bg5-20020a05600c3c8500b003a7b6ae4eb2so4396454wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=+yJ5UA3osJaE8In6k2eqSTVByQFti3MaFQ6QdbrD9SQ=;
        b=yARDbhvlRO/J0Q88+bIt6nGh8mopYng+aeVP02JjPAKzTZdpayPzKFhguVxaQWKRGn
         Y0CpK0lo5vvDyXARpH4K50Kbizk7eaDZt+zx1EMSIB1i0Y8+mj9k9wysAsnKgjpfy1nd
         B4TAG+kjkkNGPHBtAjswB6WWpzTb3F8t2iJgfbx9R81cgCMsyJQCsZLuGV4kCRXmOBiq
         3XAQ2R3PHKWsBL0UPVgb8Oj+G+Htxp09HQRkmz+mTJPKY0JoVev/l2lnP27W+jvRGO6B
         C+1bppk0MJcMbcbbFADmRgw0BJ2y0LmfhInE0TgnzN4O3nNizz9S12yUaqIqSBojFRYH
         3mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+yJ5UA3osJaE8In6k2eqSTVByQFti3MaFQ6QdbrD9SQ=;
        b=r2pC8XWiM4CsT8U7aspTjgoFWQ4bb6wmciAu+B0fUZzQ3MIJ8/llTlH/7bHpEdG0gr
         6w+LGO5q23KYx/qNo0+v3G2Lw8nXSJcmNJcSvSLV8XQyeh53XIlvVtiQbaxsw73uBw7S
         3ShKjnKQUqJIQj+NYeAu+lOncV6ngNhPvrXzds9nZf2sUr5aTXsvtNWZkpbJq5W5jh3O
         qDtxcR1SLNDjYqM92qmd7OO77nOY8NCmymac0TaV+Idf2JK14eJOTItkTi7nqEv0ypQD
         cBKOYqyNO5jCsrSU05bdmPyOrYLu6Z7q96MFT0NaqRzzw3anJeoIj70Z6a0Xp+6RGB9O
         DniA==
X-Gm-Message-State: ACgBeo23qxuTAffnqjjci5P0+tV5TsdutZYpeuyD4MG3oSun9SPVrMdX
        vNCGO636IQt8WjtmSDZRYY/p2w==
X-Google-Smtp-Source: AA6agR4UPpyTWkYlLB+ccSEG6+CXORLSYnzeYFEgBNuPQ7yRPFJNIYWZxovN5gPVxbtgaHOGsfvbXg==
X-Received: by 2002:a05:600c:4fcf:b0:3a8:437a:8d28 with SMTP id o15-20020a05600c4fcf00b003a8437a8d28mr5436523wmq.197.1662728608483;
        Fri, 09 Sep 2022 06:03:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003a5f4fccd4asm569909wms.35.2022.09.09.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:03:27 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 8/8] sched/fair: Add latency list
Date:   Fri,  9 Sep 2022 15:03:09 +0200
Message-Id: <20220909130309.25458-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909130309.25458-1-vincent.guittot@linaro.org>
References: <20220909130309.25458-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a rb tree for latency sensitive entities so we can schedule the most
sensitive one first even when it failed to preempt current at wakeup or
when it got quickly preempted by another entity of higher priority.

In order to keep fairness, the latency is used once at wakeup to get a
minimum slice and not during the following scheduling slice to prevent
long running entity to got more running time than allocated to his nice
priority.

The rb tree nebales to cover the last corner case where latency
sensitive entity can't got schedule quickly after the wakeup.

hackbench -l 10000 -g $group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       17    19     29      17   18     30
1       65   306   7149      64   83    208
4       50   395  15731      56   80    271
8       56   781  41548      54   80    301
16      60  1392  87237      59   86    490

group = 0 means that hackbench is not running.

Both avg and max are significantly improved with nice latency -20. If we
add the histogram parameters to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    60           61
Avg Latencies:  1077           86
Max Latencies: 87311          444
50% latencies:    92           85
75% latencies:   554           90
85% latencies:  1019           93
90% latencies:  1346           96
95% latencies:  5400          100
99% latencies: 19044          110

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h |  2 +
 kernel/sched/fair.c   | 96 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |  1 +
 3 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2d2a361d65ee..8b7bf0cb4ee9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -537,6 +537,8 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	struct rb_node			latency_node;
+	unsigned int			on_latency;
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7563fb16aba1..58657cafaa9b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -664,7 +664,77 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 
 	return __node_2_se(last);
 }
+#endif
 
+/**************************************************************
+ * Scheduling class tree data structure manipulation methods:
+ * for latency
+ */
+
+static inline bool latency_before(struct sched_entity *a,
+				struct sched_entity *b)
+{
+	return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
+}
+
+#define __latency_node_2_se(node) \
+	rb_entry((node), struct sched_entity, latency_node)
+
+static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
+{
+	return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
+}
+
+/*
+ * Enqueue an entity into the latency rb-tree:
+ */
+static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+
+	/* Only latency sensitive entity can be added to the list */
+	if (se->latency_offset >= 0)
+		return;
+
+	if (se->on_latency)
+		return;
+
+	/*
+	 * An execution time less than sysctl_sched_min_granularity means that
+	 * the entity has been preempted by a higher sched class or an entity
+	 * with higher latency constraint.
+	 * Put it back in the list so it gets a chance to run 1st during the
+	 * next slice.
+	 */
+	if (!(flags & ENQUEUE_WAKEUP)) {
+		u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+		if (delta_exec >= sysctl_sched_min_granularity)
+			return;
+	}
+
+	rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
+	se->on_latency = 1;
+}
+
+static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (se->on_latency) {
+		rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
+		se->on_latency = 0;
+	}
+}
+
+struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
+
+	if (!left)
+		return NULL;
+
+	return __latency_node_2_se(left);
+}
+
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4455,8 +4525,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
-	if (!curr)
+	if (!curr) {
 		__enqueue_entity(cfs_rq, se);
+		__enqueue_latency(cfs_rq, se, flags);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -4542,8 +4614,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4631,6 +4705,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4669,7 +4744,7 @@ static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *latency, *se;
 
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
@@ -4711,6 +4786,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
+	/* Check for latency sensitive entity waiting for running */
+	latency = __pick_first_latency(cfs_rq);
+	if (latency && (latency != se) &&
+	    wakeup_preempt_entity(latency, se) < 1)
+		se = latency;
+
 	return se;
 }
 
@@ -4734,6 +4815,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
+		__enqueue_latency(cfs_rq, prev, 0);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -11718,6 +11800,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12026,8 +12109,15 @@ int sched_group_set_latency(struct task_group *tg, long latency)
 
 	for_each_possible_cpu(i) {
 		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
 
+		__dequeue_latency(se->cfs_rq, se);
 		WRITE_ONCE(se->latency_offset, latency);
+
+		rq_unlock_irqrestore(rq, &rf);
 	}
 
 	mutex_unlock(&shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 117b23dfb912..294a4a39f3eb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -597,6 +597,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.17.1

