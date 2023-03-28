Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E26CBD24
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjC1LIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjC1LHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141367EF4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Z1jwqfV5ktSOWhS/j82zNm8uac5hlj1PrCAP6oYXOb8=; b=b8VqpS8o59yCaDaibvgp5SRCgx
        het7CULjxr950QMlcBDP1HNCQGa277LjtfhTRntu56qI1nkRIyMrlc8q+1Mph778wEYMGT7xzfpaQ
        SfpMvnrGAXm/qRSrZikkLEYRp3CupcRd9xa9e6lpgVhD5KJFUS8qYFC85Rb1dp10WuT8+Fr6NsNzz
        6nHnK+xMGSOOJRl1at6mV3FjVVKo0qaK7noP192gmMcE3gElkm8Oqx5gsDaZnu7YqrBlzuByUIpy9
        FPDHde8Gblv2UWxbq8ATjiGpeaOYWsCB60Dxi33Za5f4cWHBd90Dv36SI2ZzSlKd+dXQd5r6B5Er6
        3h2cmy4A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph79k-006XUs-3C;
        Tue, 28 Mar 2023 11:06:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5BCA300BE3;
        Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B492E2CB8CEBE; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110353.853385546@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:26 +0200
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
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 04/17] sched/fair: Add avg_vruntime
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to move to an eligibility based scheduling policy it is
needed to have a better approximation of the ideal scheduler.

Specifically, for a virtual time weighted fair queueing based
scheduler the ideal scheduler will be the weighted average of the
individual virtual runtimes (math in the comment).

As such, compute the weighted average to approximate the ideal
scheduler -- note that the approximation is in the individual task
behaviour, which isn't strictly conformant.

Specifically consider adding a task with a vruntime left of center, in
this case the average will move backwards in time -- something the
ideal scheduler would of course never do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |   32 ++++++--------
 kernel/sched/fair.c  |  111 +++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |    5 ++
 3 files changed, 128 insertions(+), 20 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -580,10 +580,9 @@ static void print_rq(struct seq_file *m,
 
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 MIN_vruntime = -1, min_vruntime, max_vruntime = -1,
-		spread, rq0_min_vruntime, spread0;
+	s64 left_vruntime = -1, min_vruntime, right_vruntime = -1, spread;
+	struct sched_entity *last, *first;
 	struct rq *rq = cpu_rq(cpu);
-	struct sched_entity *last;
 	unsigned long flags;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -597,26 +596,25 @@ void print_cfs_rq(struct seq_file *m, in
 			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
-	if (rb_first_cached(&cfs_rq->tasks_timeline))
-		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
+	first = __pick_first_entity(cfs_rq);
+	if (first)
+		left_vruntime = first->vruntime;
 	last = __pick_last_entity(cfs_rq);
 	if (last)
-		max_vruntime = last->vruntime;
+		right_vruntime = last->vruntime;
 	min_vruntime = cfs_rq->min_vruntime;
-	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
-			SPLIT_NS(MIN_vruntime));
+
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_vruntime",
+			SPLIT_NS(left_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
 			SPLIT_NS(min_vruntime));
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "max_vruntime",
-			SPLIT_NS(max_vruntime));
-	spread = max_vruntime - MIN_vruntime;
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread",
-			SPLIT_NS(spread));
-	spread0 = min_vruntime - rq0_min_vruntime;
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread0",
-			SPLIT_NS(spread0));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
+			SPLIT_NS(avg_vruntime(cfs_rq)));
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
+			SPLIT_NS(right_vruntime));
+	spread = right_vruntime - left_vruntime;
+	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -601,9 +601,108 @@ static inline bool entity_before(const s
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	return (s64)(se->vruntime - cfs_rq->min_vruntime);
+}
+
 #define __node_2_se(node) \
 	rb_entry((node), struct sched_entity, run_node)
 
+/*
+ * Compute virtual time from the per-task service numbers:
+ *
+ * Fair schedulers conserve lag: \Sum lag_i = 0
+ *
+ * lag_i = S - s_i = w_i * (V - v_i)
+ *
+ * \Sum lag_i = 0 -> \Sum w_i * (V - v_i) = V * \Sum w_i - \Sum w_i * v_i = 0
+ *
+ * From which we solve V:
+ *
+ *     \Sum v_i * w_i
+ * V = --------------
+ *        \Sum w_i
+ *
+ * However, since v_i is u64, and the multiplcation could easily overflow
+ * transform it into a relative form that uses smaller quantities:
+ *
+ * Substitute: v_i == (v_i - v) + v
+ *
+ *     \Sum ((v_i - v) + v) * w_i   \Sum (v_i - v) * w_i
+ * V = -------------------------- = -------------------- + v
+ *              \Sum w_i                   \Sum w_i
+ *
+ * min_vruntime = v
+ * avg_vruntime = \Sum (v_i - v) * w_i
+ * cfs_rq->load = \Sum w_i
+ *
+ * Since min_vruntime is a monotonic increasing variable that closely tracks
+ * the per-task service, these deltas: (v_i - v), will be in the order of the
+ * maximal (virtual) lag induced in the system due to quantisation.
+ */
+static void
+avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime += key * weight;
+	cfs_rq->avg_load += weight;
+}
+
+static void
+avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight = scale_load_down(se->load.weight);
+	s64 key = entity_key(cfs_rq, se);
+
+	cfs_rq->avg_vruntime -= key * weight;
+	cfs_rq->avg_load -= weight;
+}
+
+static inline
+void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+{
+	/*
+	 * v' = v + d ==> avg_vruntime' = avg_runtime - d*avg_load
+	 */
+	cfs_rq->avg_vruntime -= cfs_rq->avg_load * delta;
+}
+
+u64 avg_vruntime(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	if (load)
+		avg = div_s64(avg, load);
+
+	return cfs_rq->min_vruntime + avg;
+}
+
+static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
+{
+	u64 min_vruntime = cfs_rq->min_vruntime;
+	/*
+	 * open coded max_vruntime() to allow updating avg_vruntime
+	 */
+	s64 delta = (s64)(vruntime - min_vruntime);
+	if (delta > 0) {
+		avg_vruntime_update(cfs_rq, delta);
+		min_vruntime = vruntime;
+	}
+	return min_vruntime;
+}
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -629,7 +728,7 @@ static void update_min_vruntime(struct c
 
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
-		      max_vruntime(cfs_rq->min_vruntime, vruntime));
+		      __update_min_vruntime(cfs_rq, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -642,12 +741,14 @@ static inline bool __entity_less(struct
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	avg_vruntime_add(cfs_rq, se);
 	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
+	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
@@ -3330,6 +3431,8 @@ static void reweight_entity(struct cfs_r
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
+		else
+			avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3345,9 +3448,11 @@ static void reweight_entity(struct cfs_r
 #endif
 
 	enqueue_load_avg(cfs_rq, se);
-	if (se->on_rq)
+	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-
+		if (cfs_rq->curr != se)
+			avg_vruntime_add(cfs_rq, se);
+	}
 }
 
 void reweight_task(struct task_struct *p, int prio)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -558,6 +558,9 @@ struct cfs_rq {
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+	s64			avg_vruntime;
+	u64			avg_load;
+
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
@@ -3312,4 +3315,6 @@ static inline void switch_mm_cid(struct
 static inline void switch_mm_cid(struct task_struct *prev, struct task_struct *next) { }
 #endif
 
+extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+
 #endif /* _KERNEL_SCHED_SCHED_H */


