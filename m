Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2A5E93B3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIYOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiIYOlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:41:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06E62E6AF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id cc5so6708597wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=BV3/18h/jr2lIISScNcNJ/91zKWUfVi7jy8Z+Z1DShU=;
        b=XbT1dB4mNJ4eB+Q7AFKXUYtJ33nk03jdgzqcstnPteWe5lo2FPzZpxIchq9zIOcxPt
         qH9PI7pYQQuhqJE89dhiOemceB28zXcMEMw4yN8ro2c2BSAJlT3IfpPgcJNF6SsEfkfD
         3IP/JUBBDquY1olKwAJHj5v0IEz3YQLJncnQ2jd/B1pb1LI0tO786QjTqg7RIDv1Rzpq
         Eky63SA47+2O8OrqAzgjbwBuEzXDEksdsGcKUHfgmhu8Owfc374P/PEvoPR3zoLLcBzb
         vZImRgzBaMsPVYMsCGbyUZXy3+kLfoElhXI8q6M8xQlvS25Jz7Fuh+SxiyQ7600t+LlD
         fFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BV3/18h/jr2lIISScNcNJ/91zKWUfVi7jy8Z+Z1DShU=;
        b=o5YSWrlqfCYzQkVpyicOIcUVq6ol38C5ZAat90ASG3w6Pb/+aqQh2RvpSHFC73+E5y
         Iy0w0r4RwUDrXd9zs2ttVkk7tGnzVx7e41Uzd4M8//m7c2g1QWLLBRW/lnku2UJXrdwk
         Q0qcBfV0QVYM9u7ornXGV2FztmVAhPmhZBWgGgTsCVj2y9JYIDuJxGJXyExbxQnAKX11
         XSQSU38BnShg6QLfEbx/NS9V69t+9dyNVLXe+2Z8OAghHlTZ6NOJultcPonXq1HzMy97
         IQQYKQs2vrCHCoy8vxf8cWCIjnyE9j/51HOmQ0X1kJScHAhQV0vAcsQPvdT2RjeDOPlb
         2a5w==
X-Gm-Message-State: ACrzQf2QwbXKATTo6eyYU9bRCV7r6+irVjsqjUanyQEq0rXWs7mdtV5k
        DOW+HzEDlI7KW2KR9S8itT4L4A==
X-Google-Smtp-Source: AMsMyM4MIWmrjndc/K0E0+Gc4+sqsIH4/ppuy5AqmcnXCoDXxc8jnSVQ4W0q2qHbZh5+L7sLY9EtXA==
X-Received: by 2002:a05:6000:188a:b0:22a:e4b7:c2f4 with SMTP id a10-20020a056000188a00b0022ae4b7c2f4mr10425776wri.446.1664116885091;
        Sun, 25 Sep 2022 07:41:25 -0700 (PDT)
Received: from localhost.localdomain (91-160-61-128.subs.proxad.net. [91.160.61.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c3b0a00b003b47b913901sm20774761wms.1.2022.09.25.07.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:41:24 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 7/7] sched/fair: Add latency list
Date:   Sun, 25 Sep 2022 16:39:08 +0200
Message-Id: <20220925143908.10846-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220925143908.10846-1-vincent.guittot@linaro.org>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index a74cad08e91e..0b92674e3664 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -547,6 +547,8 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	struct rb_node			latency_node;
+	unsigned int			on_latency;
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e524e892d118..1a72f34136d8 100644
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
+static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
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
@@ -11717,6 +11799,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12025,8 +12108,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
 
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
index a15fb955092c..76bca172585c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,6 +599,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.17.1

