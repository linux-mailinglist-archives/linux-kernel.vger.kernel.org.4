Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CD6AC300
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCFOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjCFOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:19:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A924202
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/yjun6vpYpWqA4dqrl5sx2H+6lfV4e1BW4iWFGQBepI=; b=l7U5421aD9xrKYMWHcamAUrvJm
        7NRNPm+WtuEplUmwyYZod1CUtQFPipEyuqkp/UINMTrFYNdgN3Pt7imzmm/EmKrydOhogbP7USb57
        +nPEFojXPsknUi2rLVSYDbblYj0zgIrwFF1xzq3uY5EjIbEnUhMhEXOnvDrkuqfYc8+hf76hUM6BT
        HYiBJ7KXIeoyRayy0xauPcVBQGuho//5cwDhK/RqxuYR8Lj2WEVDgm9K0QSuMDema0lHSYyO7VO+o
        vI6VK4b/NLV44QEJh4HmxSMe3H8b5CkmLOb6XaIM81DjL1EODRllGknRmHLQHWtHgaSAMtkv2BpQu
        iPIJS0Bg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZBe6-005P2h-D3; Mon, 06 Mar 2023 14:16:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92358302D60;
        Mon,  6 Mar 2023 15:16:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1E81523BC8E30; Mon,  6 Mar 2023 15:16:55 +0100 (CET)
Message-ID: <20230306141502.810909205@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 06 Mar 2023 14:25:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: [PATCH 10/10] sched/fair: Implement an EEVDF like policy
References: <20230306132521.968182689@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Where CFS is currently a WFQ based scheduler with only a single knob,
the weight. The addition of a second, latency oriented parameter,
makes something like WF2Q or EEVDF based a much better fit.

Specifically, EEVDF does EDF like scheduling in the left half of the
tree -- those entities that are owed service. Except because this is a
virtual time scheduler, the deadlines are in virtual time as well,
which is what allows over-subscription.

EEVDF has two parameters:

 - weight; which is mapped to nice just as before
 - relative deadline; which is related to slice length and mapped
   to the new latency nice.

Basically, by setting a smaller slice, the deadline will be earlier
and the task will be more eligible and ran earlier.

Preemption (both tick and wakeup) is driven by testing against a fresh
pick. Because the tree is now effectively an interval tree, and the
selection is no longer 'leftmost', over-scheduling is less of a
problem.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    4 
 kernel/sched/debug.c    |    6 -
 kernel/sched/fair.c     |  265 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |    2 
 kernel/sched/sched.h    |    1 
 5 files changed, 247 insertions(+), 31 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,6 +548,9 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	u64				deadline;
+	u64				min_deadline;
+
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
@@ -556,6 +559,7 @@ struct sched_entity {
 	u64				vruntime;
 	u64				prev_sum_exec_runtime;
 	s64				lag;
+	u64				slice;
 
 	u64				nr_migrations;
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -535,9 +535,13 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
+		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
+		SPLIT_NS(p->se.deadline),
+		SPLIT_NS(p->se.slice),
+		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -47,6 +47,7 @@
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
+#include <linux/rbtree_augmented.h>
 
 #include <asm/switch_to.h>
 
@@ -683,6 +684,34 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 	return cfs_rq->min_vruntime + lag;
 }
 
+/*
+ * Entity is eligible once it received less service than it ought to have,
+ * eg. lag >= 0.
+ *
+ * lag_i = S - s_i = w_i*(V - w_i)
+ *
+ * lag_i >= 0 -> V >= v_i
+ *
+ *     \Sum (v_i - v)*w_i
+ * V = ------------------ + v
+ *          \Sum w_i
+ *
+ * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
+ */
+int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg_vruntime = cfs_rq->avg_vruntime;
+	long avg_load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		avg_vruntime += entity_key(cfs_rq, curr) * curr->load.weight;
+		avg_load += curr->load.weight;
+	}
+
+	return avg_vruntime >= entity_key(cfs_rq, se) * avg_load;
+}
+
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
@@ -699,8 +728,8 @@ static u64 __update_min_vruntime(struct
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
 	u64 vruntime = cfs_rq->min_vruntime;
 
@@ -711,9 +740,7 @@ static void update_min_vruntime(struct c
 			curr = NULL;
 	}
 
-	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se = __node_2_se(leftmost);
-
+	if (se) {
 		if (!curr)
 			vruntime = se->vruntime;
 		else
@@ -730,18 +757,50 @@ static inline bool __entity_less(struct
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
 
+#define deadline_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
+
+static inline void __update_min_deadline(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (deadline_gt(min_deadline, se, rse))
+			se->min_deadline = rse->min_deadline;
+	}
+}
+
+/*
+ * se->min_deadline = min(se->deadline, left->min_deadline, right->min_deadline)
+ */
+static inline bool min_deadline_update(struct sched_entity *se, bool exit)
+{
+	u64 old_min_deadline = se->min_deadline;
+	struct rb_node *node = &se->run_node;
+
+	se->min_deadline = se->deadline;
+	__update_min_deadline(se, node->rb_right);
+	__update_min_deadline(se, node->rb_left);
+
+	return se->min_deadline == old_min_deadline;
+}
+
+RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
+		     run_node, min_deadline, min_deadline_update);
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
-	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
+	se->min_deadline = se->deadline;
+	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				__entity_less, &min_deadline_cb);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
+	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				  &min_deadline_cb);
 	avg_vruntime_sub(cfs_rq, se);
 }
 
@@ -765,6 +824,101 @@ static struct sched_entity *__pick_next_
 	return __node_2_se(next);
 }
 
+static struct sched_entity *pick_cfs(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	struct sched_entity *left = __pick_first_entity(cfs_rq);
+
+	/*
+	 * If curr is set we have to see if its left of the leftmost entity
+	 * still in the tree, provided there was anything in the tree at all.
+	 */
+	if (!left || (curr && entity_before(curr, left)))
+		left = curr;
+
+	return left;
+}
+
+/*
+ * Earliest Eligible Virtual Deadline First
+ *
+ * In order to provide latency guarantees for different request sizes
+ * EEVDF selects the best runnable task from two criteria:
+ *
+ *  1) the task must be eligible (must be owed service)
+ *
+ *  2) from those tasks that meet 1), we select the one
+ *     with the earliest virtual deadline.
+ *
+ * We can do this in O(log n) time due to an augmented RB-tree. The
+ * tree keeps the entries sorted on service, but also functions as a
+ * heap based on the deadline by keeping:
+ *
+ *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
+ *
+ * Which allows an EDF like search on (sub)trees.
+ */
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *best = NULL;
+
+	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+		curr = NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 *
+		 * XXX: would it be worth it to do the single division for
+		 *      avg_vruntime() once, instead of the multiplication
+		 *      in entity_eligible() O(log n) times?
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/*
+		 * If this entity has an earlier deadline than the previous
+		 * best, take this one. If it also has the earliest deadline
+		 * of its subtree, we're done.
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			best = se;
+			if (best->deadline == best->min_deadline)
+				break;
+		}
+
+		/*
+		 * If the earlest deadline in this subtree is in the fully
+		 * eligible left half of our space, go there.
+		 */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		node = node->rb_right;
+	}
+
+	if (!best || (curr && deadline_gt(deadline, best, curr)))
+		best = curr;
+
+	if (unlikely(!best)) {
+		struct sched_entity *left = __pick_first_entity(cfs_rq);
+		if (left) {
+			pr_err("EEVDF scheduling fail, picking leftmost\n");
+			return left;
+		}
+	}
+
+	return best;
+}
+
 #ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
@@ -882,6 +1036,32 @@ static u64 sched_slice(struct cfs_rq *cf
 	return slice;
 }
 
+static void set_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (sched_feat(EEVDF)) {
+		/*
+		 * For EEVDF the virtual time slope is determined by w_i (iow.
+		 * nice) while the request time r_i is determined by
+		 * latency-nice.
+		 */
+		se->slice = se->latency_offset;
+	} else {
+		/*
+		 * When many tasks blow up the sched_period; it is possible
+		 * that sched_slice() reports unusually large results (when
+		 * many tasks are very light for example). Therefore impose a
+		 * maximum.
+		 */
+		se->slice = min_t(u64, sched_slice(cfs_rq, se), sysctl_sched_latency);
+	}
+
+	/*
+	 * vd_i = ve_i + r_i / w_i
+	 */
+	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+	se->min_deadline = se->deadline;
+}
+
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -1014,6 +1194,13 @@ static void update_curr(struct cfs_rq *c
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	/*
+	 * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
+	 * this is probably good enough.
+	 */
+	if ((s64)(curr->vruntime - curr->deadline) > 0)
+		set_slice(cfs_rq, curr);
+
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -4788,6 +4975,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		vruntime -= se->lag;
 
 	se->vruntime = vruntime;
+	set_slice(cfs_rq, se);
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -4996,19 +5184,20 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	unsigned long ideal_runtime, delta_exec;
+	unsigned long delta_exec;
 	struct sched_entity *se;
 	s64 delta;
 
-	/*
-	 * When many tasks blow up the sched_period; it is possible that
-	 * sched_slice() reports unusually large results (when many tasks are
-	 * very light for example). Therefore impose a maximum.
-	 */
-	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
+	if (sched_feat(EEVDF)) {
+		if (pick_eevdf(cfs_rq) != curr)
+			goto preempt;
+
+		return;
+	}
 
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
-	if (delta_exec > ideal_runtime) {
+	if (delta_exec > curr->slice) {
+preempt:
 		resched_curr(rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
@@ -5032,7 +5221,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > curr->slice)
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5087,17 +5276,20 @@ wakeup_preempt_entity(struct sched_entit
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *left, *se;
 
-	/*
-	 * If curr is set we have to see if its left of the leftmost entity
-	 * still in the tree, provided there was anything in the tree at all.
-	 */
-	if (!left || (curr && entity_before(curr, left)))
-		left = curr;
+	if (sched_feat(EEVDF)) {
+		/*
+		 * Enabling NEXT_BUDDY will affect latency but not fairness.
+		 */
+		if (sched_feat(NEXT_BUDDY) &&
+		    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+			return cfs_rq->next;
+
+		return pick_eevdf(cfs_rq);
+	}
 
-	se = left; /* ideally we run the leftmost entity */
+	se = left = pick_cfs(cfs_rq, curr);
 
 	/*
 	 * Avoid running the skip buddy, if running something else can
@@ -6192,13 +6384,12 @@ static inline void unthrottle_offline_cf
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
 	if (rq->cfs.h_nr_running > 1) {
-		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+		u64 slice = se->slice;
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
@@ -7921,7 +8112,19 @@ static void check_preempt_wakeup(struct
 	if (cse_is_idle != pse_is_idle)
 		return;
 
-	update_curr(cfs_rq_of(se));
+	cfs_rq = cfs_rq_of(se);
+	update_curr(cfs_rq);
+
+	if (sched_feat(EEVDF)) {
+		/*
+		 * XXX pick_eevdf(cfs_rq) != se ?
+		 */
+		if (pick_eevdf(cfs_rq) == pse)
+			goto preempt;
+
+		return;
+	}
+
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
@@ -8167,7 +8370,7 @@ static void yield_task_fair(struct rq *r
 
 	clear_buddies(cfs_rq, se);
 
-	if (curr->policy != SCHED_BATCH) {
+	if (sched_feat(EEVDF) || curr->policy != SCHED_BATCH) {
 		update_rq_clock(rq);
 		/*
 		 * Update run-time statistics of the 'current'.
@@ -8180,6 +8383,8 @@ static void yield_task_fair(struct rq *r
 		 */
 		rq_clock_skip_update(rq);
 	}
+	if (sched_feat(EEVDF))
+		se->deadline += calc_delta_fair(se->slice, se);
 
 	set_skip_buddy(se);
 }
@@ -11923,8 +12128,8 @@ static void rq_offline_fair(struct rq *r
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
 {
-	u64 slice = sched_slice(cfs_rq_of(se), se);
 	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+	u64 slice = se->slice;
 
 	return (rtime * min_nr_tasks > slice);
 }
@@ -12639,7 +12844,7 @@ static unsigned int get_rr_interval_fair
 	 * idle runqueue:
 	 */
 	if (rq->cfs.load.weight)
-		rr_interval = NS_TO_JIFFIES(sched_slice(cfs_rq_of(se), se));
+		rr_interval = NS_TO_JIFFIES(se->slice);
 
 	return rr_interval;
 }
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -103,3 +103,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(EEVDF, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3316,5 +3316,6 @@ static inline void switch_mm_cid(struct
 #endif
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #endif /* _KERNEL_SCHED_SCHED_H */


