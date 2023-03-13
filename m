Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE9C6B6D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjCMCPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCMCO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:14:57 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA02E0C3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1678673693;
        bh=8XNOsuuKEdpjG/EWtF/ozQwZgJDrOO4beg9e7yREDvk=;
        h=From:To:Cc:Subject:Date:From;
        b=CCifGvEPdtw1Ttp8z5MPGaVG73YLOpgc2O8p4wmbaE/9bSony/AfAroVTRdmCUgQB
         4FAIX6kZSGPRqeCwuyEaj/2ZBsF3iwgGSQhlHX2hakruFaqsZJq4e7XWUvSa0HDtW9
         nBh/3KjGcyOjEpPNfIlFw1/8VGbIcBLHRlcjiLLEd+7OXiZY2tI35cx/6jkztzJKBy
         sAROpMGcTRGIsLoesA+BBMboHcBofyuc2obcVzmtIsqCpyuWjHV/edOb969QbOzODn
         HluBj+6LxxWj8rnzFdaGFbf6kqNvDrH+OITLbD6P+BDsSK9ibbpz6l8fIl7kB/xhjo
         LPJL5rgTC7RWw==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4PZgGN6H9Lzpdh;
        Sun, 12 Mar 2023 22:14:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH] sched/fair: scale vruntime delta on migration
Date:   Sun, 12 Mar 2023 22:14:42 -0400
Message-Id: <20230313021442.115425-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On migration, use the respective runqueue spread of the source and
destination runqueues to scale the vruntime delta of the scheduling
entity.

The intent of this change is to prevent a task migrated from a very busy
runqueue (with vruntime going fast) to a less busy runqueue (with a
vruntime with a slower pace) to enqueue the migrated task far away at
the very end of the runqueue, thus increasing the destination runqueue
spread and preventing the enqueued task from being scheduled for a while
until the vruntime reaches it.

The aim is to prevent long scheduling latencies on migration from busy
to less busy runqueues.

This should help with asymmetric workloads showing spurious long
scheduling latencies on large SMP systems.

[ Based on v6.1.18. ]
[ Testing/feedback welcome. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sched.h |  2 +
 kernel/sched/fair.c   | 86 +++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h  |  1 +
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd13..93e0b2dbe671 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -558,6 +558,8 @@ struct sched_entity {
 
 	u64				nr_migrations;
 
+	u64				src_rq_spread;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	int				depth;
 	struct sched_entity		*parent;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c3d0d49c80e..0e8159237442 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -589,6 +589,25 @@ static inline bool entity_before(struct sched_entity *a,
 #define __node_2_se(node) \
 	rb_entry((node), struct sched_entity, run_node)
 
+struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
+
+	if (!last)
+		return NULL;
+
+	return __node_2_se(last);
+}
+
+static u64 calc_cfs_rq_spread(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *last_se = __pick_last_entity(cfs_rq);
+
+	if (!last_se)
+		return 0;
+	return last_se->vruntime - cfs_rq->min_vruntime;
+}
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -615,6 +634,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	/* ensure we never gain time by being placed backwards. */
 	u64_u32_store(cfs_rq->min_vruntime,
 		      max_vruntime(cfs_rq->min_vruntime, vruntime));
+	u64_u32_store(cfs_rq->vruntime_spread, calc_cfs_rq_spread(cfs_rq));
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -656,16 +676,6 @@ static struct sched_entity *__pick_next_entity(struct sched_entity *se)
 }
 
 #ifdef CONFIG_SCHED_DEBUG
-struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
-{
-	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
-
-	if (!last)
-		return NULL;
-
-	return __node_2_se(last);
-}
-
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4683,11 +4693,13 @@ static inline bool cfs_bandwidth_used(void);
  *	dequeue
  *	  update_curr()
  *	    update_min_vruntime()
+ *	  src_rq_spread = vruntime_spread
  *	  vruntime -= min_vruntime
  *
  *	enqueue
  *	  update_curr()
  *	    update_min_vruntime()
+ *	  vruntime = vruntime * vruntime_spread / src_rq_spread
  *	  vruntime += min_vruntime
  *
  * this way the vruntime transition between RQs is done when both
@@ -4696,17 +4708,58 @@ static inline bool cfs_bandwidth_used(void);
  * WAKEUP (remote)
  *
  *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
+ *	  src_rq_spread = vruntime_spread
  *	  vruntime -= min_vruntime
  *
  *	enqueue
  *	  update_curr()
  *	    update_min_vruntime()
+ *	  vruntime = vruntime * vruntime_spread / src_rq_spread
  *	  vruntime += min_vruntime
  *
- * this way we don't have the most up-to-date min_vruntime on the originating
- * CPU and an up-to-date min_vruntime on the destination CPU.
+ * this way we don't have the most up-to-date min_vruntime nor vruntime_spread
+ * on the originating CPU and an up-to-date min_vruntime and vruntime_spread on
+ * the destination CPU.
+ *
+ * On migration, scale the vruntime delta from the source CPU vruntime spread to
+ * the destination CPU vruntime spread.
  */
 
+static void
+renorm_vruntime(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	u64 dst_rq_spread = calc_cfs_rq_spread(cfs_rq),
+	    src_rq_spread = se->src_rq_spread;
+
+	if (!dst_rq_spread) {
+		/*
+		 * If the destination rq has only a single or no task, place this entity
+		 * at min_vruntime.
+		 */
+		se->vruntime = 0;
+	} else if (!src_rq_spread) {
+		/*
+		 * If the source rq had only a single task, enqueue this entity into the
+		 * destination rq as we would do the initial placement of an entity.
+		 */
+		if (sched_feat(START_DEBIT)) {
+			se->vruntime = sched_vslice(cfs_rq, se);
+		} else {
+			se->vruntime = 0;
+		}
+	} else {
+		/*
+		 * Scale the vruntime delta from the source rq runtime spread
+		 * to the destination rq runtime spread.
+		 */
+		if (dst_rq_spread != src_rq_spread) {
+			se->vruntime *= dst_rq_spread;
+			do_div(se->vruntime, src_rq_spread);
+		}
+	}
+	se->vruntime += cfs_rq->min_vruntime;
+}
+
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -4718,7 +4771,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		renorm_vruntime(cfs_rq, se);
 
 	update_curr(cfs_rq);
 
@@ -4729,7 +4782,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		renorm_vruntime(cfs_rq, se);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -4849,8 +4902,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_min_vruntime() again, which will discount @se's position and
 	 * can move min_vruntime forward still more.
 	 */
-	if (!(flags & DEQUEUE_SLEEP))
+	if (!(flags & DEQUEUE_SLEEP)) {
+		se->src_rq_spread = calc_cfs_rq_spread(cfs_rq);
 		se->vruntime -= cfs_rq->min_vruntime;
+	}
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -7427,6 +7482,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	if (READ_ONCE(p->__state) == TASK_WAKING) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		se->src_rq_spread = u64_u32_load(cfs_rq->vruntime_spread);
 		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d6d488e8eb55..6c657d371090 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -556,6 +556,7 @@ struct cfs_rq {
 
 	u64			exec_clock;
 	u64			min_vruntime;
+	u64			vruntime_spread;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			min_vruntime_fi;
-- 
2.25.1

