Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F1A6CBD19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjC1LHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbjC1LHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5977DA9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Xd5Db/jfk2Mhrb2v5Fzhu4reHhPhqOf/4VIb1HzrBa4=; b=N1wWa1NPLtQHJitmKAkpBKRKa2
        6iSZnZpWiCSq1AuaFkppCGuboSyDO14SKorZHiWA5xXcQJnbP6WRUar0+I9CTMUf83iAm55T1acQ4
        YhlWBn1zb4n4cy2SaPuOmfsctNrcH9z5MPM/J+ezGVdtI8WRo1hSBen5/eJ+odT/5qHJHd0btyqYe
        jvK2r0gXVF5neGHbV1nmy+5vNbF3G7KDXulNbYi534Mucg+p+JQsDc/KHyobDR326/6mpPknlGI6x
        xLiBgEzuEw+p7Uz4dK3ExYH1xNsZj+RaWTraDlx8smyyYZRm8i/iPoj645dPscVQHHr/1JBCHnH1t
        NjnyOO1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79m-008MDE-17; Tue, 28 Mar 2023 11:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B291302E8A;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D25CE2CB8CEC6; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110354.279334987@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:32 +0200
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
Subject: [PATCH 10/17] sched/smp: Use lag to simplify cross-runqueue placement
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

Using lag is both more correct and simpler when moving between
runqueues.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |  145 ++++++----------------------------------------------
 1 file changed, 19 insertions(+), 126 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4985,7 +4985,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -5040,61 +5040,21 @@ static void check_enqueue_throttle(struc
 
 static inline bool cfs_bandwidth_used(void);
 
-/*
- * MIGRATION
- *
- *	dequeue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime -= min_vruntime
- *
- *	enqueue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime += min_vruntime
- *
- * this way the vruntime transition between RQs is done when both
- * min_vruntime are up-to-date.
- *
- * WAKEUP (remote)
- *
- *	->migrate_task_rq_fair() (p->state == TASK_WAKING)
- *	  vruntime -= min_vruntime
- *
- *	enqueue
- *	  update_curr()
- *	    update_min_vruntime()
- *	  vruntime += min_vruntime
- *
- * this way we don't have the most up-to-date min_vruntime on the originating
- * CPU and an up-to-date min_vruntime on the destination CPU.
- */
-
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool renorm = !(flags & ENQUEUE_WAKEUP) || (flags & ENQUEUE_MIGRATED);
 	bool curr = cfs_rq->curr == se;
 
 	/*
 	 * If we're the current task, we must renormalise before calling
 	 * update_curr().
 	 */
-	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+	if (curr)
+		place_entity(cfs_rq, se, 0);
 
 	update_curr(cfs_rq);
 
 	/*
-	 * Otherwise, renormalise after, such that we're placed at the current
-	 * moment in time, instead of some random moment in the past. Being
-	 * placed in the past could significantly boost this task to the
-	 * fairness detriment of existing tasks.
-	 */
-	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
-
-	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
@@ -5105,11 +5065,22 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
+	/*
+	 * XXX update_load_avg() above will have attached us to the pelt sum;
+	 * but update_cfs_group() here will re-adjust the weight and have to
+	 * undo/redo all that. Seems wasteful.
+	 */
 	update_cfs_group(se);
-	account_entity_enqueue(cfs_rq, se);
 
-	if (flags & ENQUEUE_WAKEUP)
+	/*
+	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
+	 * we can place the entity.
+	 */
+	if (!curr)
 		place_entity(cfs_rq, se, 0);
+
+	account_entity_enqueue(cfs_rq, se);
+
 	/* Entity has migrated, no longer consider this task hot */
 	if (flags & ENQUEUE_MIGRATED)
 		se->exec_start = 0;
@@ -5204,23 +5175,12 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	clear_buddies(cfs_rq, se);
 
-	if (flags & DEQUEUE_SLEEP)
-		update_entity_lag(cfs_rq, se);
-
+	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
-	/*
-	 * Normalize after update_curr(); which will also have moved
-	 * min_vruntime if @se is the one holding it back. But before doing
-	 * update_min_vruntime() again, which will discount @se's position and
-	 * can move min_vruntime forward still more.
-	 */
-	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
-
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
 
@@ -7975,18 +7935,6 @@ static void migrate_task_rq_fair(struct
 {
 	struct sched_entity *se = &p->se;
 
-	/*
-	 * As blocked tasks retain absolute vruntime the migration needs to
-	 * deal with this by subtracting the old and adding the new
-	 * min_vruntime -- the latter is done by enqueue_entity() when placing
-	 * the task on the new runqueue.
-	 */
-	if (READ_ONCE(p->__state) == TASK_WAKING) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-		se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
-	}
-
 	if (!task_on_rq_migrating(p)) {
 		remove_entity_load_avg(se);
 
@@ -12331,8 +12279,8 @@ static void task_tick_fair(struct rq *rq
  */
 static void task_fork_fair(struct task_struct *p)
 {
-	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se, *curr;
+	struct cfs_rq *cfs_rq;
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
 
@@ -12341,22 +12289,9 @@ static void task_fork_fair(struct task_s
 
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
-	if (curr) {
+	if (curr)
 		update_curr(cfs_rq);
-		se->vruntime = curr->vruntime;
-	}
 	place_entity(cfs_rq, se, 1);
-
-	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
-		/*
-		 * Upon rescheduling, sched_class::put_prev_task() will place
-		 * 'current' within the tree based on its new key value.
-		 */
-		swap(curr->vruntime, se->vruntime);
-		resched_curr(rq);
-	}
-
-	se->vruntime -= cfs_rq->min_vruntime;
 	rq_unlock(rq, &rf);
 }
 
@@ -12385,34 +12320,6 @@ prio_changed_fair(struct rq *rq, struct
 		check_preempt_curr(rq, p, 0);
 }
 
-static inline bool vruntime_normalized(struct task_struct *p)
-{
-	struct sched_entity *se = &p->se;
-
-	/*
-	 * In both the TASK_ON_RQ_QUEUED and TASK_ON_RQ_MIGRATING cases,
-	 * the dequeue_entity(.flags=0) will already have normalized the
-	 * vruntime.
-	 */
-	if (p->on_rq)
-		return true;
-
-	/*
-	 * When !on_rq, vruntime of the task has usually NOT been normalized.
-	 * But there are some cases where it has already been normalized:
-	 *
-	 * - A forked child which is waiting for being woken up by
-	 *   wake_up_new_task().
-	 * - A task which has been woken up by try_to_wake_up() and
-	 *   waiting for actually being woken up by sched_ttwu_pending().
-	 */
-	if (!se->sum_exec_runtime ||
-	    (READ_ONCE(p->__state) == TASK_WAKING && p->sched_remote_wakeup))
-		return true;
-
-	return false;
-}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 /*
  * Propagate the changes of the sched_entity across the tg tree to make it
@@ -12483,16 +12390,6 @@ static void attach_entity_cfs_rq(struct
 static void detach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-	if (!vruntime_normalized(p)) {
-		/*
-		 * Fix up our vruntime so that the current sleep doesn't
-		 * cause 'unlimited' sleep bonus.
-		 */
-		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
-	}
 
 	detach_entity_cfs_rq(se);
 }
@@ -12500,12 +12397,8 @@ static void detach_task_cfs_rq(struct ta
 static void attach_task_cfs_rq(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	attach_entity_cfs_rq(se);
-
-	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)


