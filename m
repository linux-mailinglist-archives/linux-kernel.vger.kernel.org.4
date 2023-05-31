Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D11718042
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjEaMtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjEaMs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:48:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D0612B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5PvF4f/r+K/UwfM+HZkdbF5YC4UF0KRIlWJ5Q6ebNuQ=; b=hlRNhfTRkwhZy3PksvaM5KIWLz
        uh5hyF0ZJcVyqntvVcXqhYR2ZyySurq8KbNEIS++zPP5+glONMFHEJaQoykSRjIywwLLJgCwG6+sw
        g5lziX4nw/J8TLcWT20OjOrMYConCALWyKu1Zi1N54LsBmmMK1ZP1kuHvsJQJna1sUnhm6xqsTCcw
        dhDn8oVbZDnJ+ISy/okz3Q5Ulif2pvCuySZK8yUvVSzEviRl6IMzY4oUPkJuxN6sF3kmttjtelHor
        kmu0TIUpklFS7wZ2ipva047sy9aLskk/5hHXujxto6a8bM38e289nQ6TipP1ehx/WI0qAcjNMLAez
        ZrzJkbZg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4LEo-00FSL2-2t;
        Wed, 31 May 2023 12:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 058EB3002F0;
        Wed, 31 May 2023 14:47:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D8A1C203E4ADE; Wed, 31 May 2023 14:47:33 +0200 (CEST)
Message-ID: <20230531124603.654144274@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:40 +0200
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
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 01/15] sched/fair: Add avg_vruntime
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 kernel/sched/debug.c |   32 +++++------
 kernel/sched/fair.c  |  137 +++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |    5 +
 3 files changed, 154 insertions(+), 20 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -626,10 +626,9 @@ static void print_rq(struct seq_file *m,
 
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
@@ -643,26 +642,25 @@ void print_cfs_rq(struct seq_file *m, in
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
@@ -601,9 +601,134 @@ static inline bool entity_before(const s
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
+ * Fair schedulers conserve lag:
+ *
+ *   \Sum lag_i = 0
+ *
+ * Where lag_i is given by:
+ *
+ *   lag_i = S - s_i = w_i * (V - v_i)
+ *
+ * Where S is the ideal service time and V is it's virtual time counterpart.
+ * Therefore:
+ *
+ *   \Sum lag_i = 0
+ *   \Sum w_i * (V - v_i) = 0
+ *   \Sum w_i * V - w_i * v_i = 0
+ *
+ * From which we can solve an expression for V in v_i (which we have in
+ * se->vruntime):
+ *
+ *       \Sum v_i * w_i   \Sum v_i * w_i
+ *   V = -------------- = --------------
+ *          \Sum w_i            W
+ *
+ * Specifically, this is the weighted average of all entity virtual runtimes.
+ *
+ * [[ NOTE: this is only equal to the ideal scheduler under the condition
+ *          that join/leave operations happen at lag_i = 0, otherwise the
+ *          virtual time has non-continguous motion equivalent to:
+ *
+ *	      V +-= lag_i / W
+ *
+ *	    Also see the comment in place_entity() that deals with this. ]]
+ *
+ * However, since v_i is u64, and the multiplcation could easily overflow
+ * transform it into a relative form that uses smaller quantities:
+ *
+ * Substitute: v_i == (v_i - v0) + v0
+ *
+ *     \Sum ((v_i - v0) + v0) * w_i   \Sum (v_i - v0) * w_i
+ * V = ---------------------------- = --------------------- + v0
+ *                  W                            W
+ *
+ * Which we track using:
+ *
+ *                    v0 := cfs_rq->min_vruntime
+ * \Sum (v_i - v0) * w_i := cfs_rq->avg_vruntime
+ *              \Sum w_i := cfs_rq->avg_load
+ *
+ * Since min_vruntime is a monotonic increasing variable that closely tracks
+ * the per-task service, these deltas: (v_i - v), will be in the order of the
+ * maximal (virtual) lag induced in the system due to quantisation.
+ *
+ * Also, we use scale_load_down() to reduce the size.
+ *
+ * As measured, the max (key * weight) value was ~44 bits for a kernel build.
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
@@ -629,7 +754,7 @@ static void update_min_vruntime(struct c
 
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
-		      max_vruntime(cfs_rq->min_vruntime, vruntime));
+		      __update_min_vruntime(cfs_rq, vruntime));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -642,12 +767,14 @@ static inline bool __entity_less(struct
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
@@ -3379,6 +3506,8 @@ static void reweight_entity(struct cfs_r
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
+		else
+			avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3394,9 +3523,11 @@ static void reweight_entity(struct cfs_r
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
@@ -554,6 +554,9 @@ struct cfs_rq {
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
+	s64			avg_vruntime;
+	u64			avg_load;
+
 	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
@@ -3503,4 +3506,6 @@ static inline void task_tick_mm_cid(stru
 static inline void init_sched_mm_cid(struct task_struct *t) { }
 #endif
 
+extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+
 #endif /* _KERNEL_SCHED_SCHED_H */


