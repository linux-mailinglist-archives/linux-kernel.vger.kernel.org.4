Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A074DEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGJUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGJUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:23 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3761B8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:11 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-635e0e6b829so37916866d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019450; x=1691611450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aywgOaCBg8taQC5AfKHDC49h4sDlP6UNnulT1NAP3Eg=;
        b=KpHcVIRLqOdeYHz7W7mMko4ses0wtKrliWuRx/7n3ciRXNMqDNWQYTPX+GjgzT5kXp
         xOwV56A9q6SEy7z+xOvDmowMtoCwx06fu7EVDf3kscvmLSOW4uS8C+ZtQkbDEgjjMMaj
         gVQ34PxNXJ5rkRWNHu6ZGMunh7tegmQ6rjFD8DdFBtNnM9ijL4eJKu7YwmAfsVsfcdnA
         2juKJLdz2Cg73zbJVcJPcFQArLA9oZK/RDi2nm/bv84IlccYr95LXoqhVonvXi3a47t0
         qPzy7x4pvZbjzo1JquyHePr4tRL4hiYNN+4Owe6byPuxthsi6aEP4RJZ4RKxiCKS9a+g
         ZeNA==
X-Gm-Message-State: ABy/qLaEFYHdSU8am6Y38Qw6BX8waGXO0SSTGUOJJzr/xC1MGCdKNm8H
        tcdmJMqW/v9krsRlfO6AC00xT87F1TaiPXd+
X-Google-Smtp-Source: APBJJlGvE1jiFDZG3UrdRG7SjCViu465mcQtH0vPiy1wBSs3JKIT19JTK52H66dznmU/uJK/8edYfw==
X-Received: by 2002:a0c:cb8e:0:b0:636:14d4:4450 with SMTP id p14-20020a0ccb8e000000b0063614d44450mr11674967qvk.3.1689019449967;
        Mon, 10 Jul 2023 13:04:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id o11-20020a0ce40b000000b006301ec0d16fsm217825qvl.0.2023.07.10.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:09 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 7/7] sched: Move shared_runq to __{enqueue,dequeue}_entity()
Date:   Mon, 10 Jul 2023 15:03:42 -0500
Message-Id: <20230710200342.358255-8-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the thread at [0], Peter suggested experimenting with putting the
shared_runq enqueue and dequeue calls in __enqueue_entity() and
__dequeue_entity() respectively. This has the advantages of improve work
conservation from utilizing the shared runq on all enqueues, as well as
automagically causing shared_runq to work for SCHED_CORE. The possible
disadvantage was that we're dong more enqueues/dequeues, which could
result in untenable overhead or contention on the shard lock(s).

[0]: https://lore.kernel.org/lkml/20230622105841.GH4253@hirez.programming.kicks-ass.net/

It turns out that this appears to improve shared_runq quite a bit:

=== Single-socket | 16 core / 32 thread | 2-CCX | AMD 7950X Zen4 ===

CPU max MHz: 5879.8818
CPU min MHz: 3000.0000

Command: make -j$(nproc) built-in.a
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 582.46s    | 3101% |
SHARED_RUNQ_WAKEUPS:        | 581.22s    | 3117% |
SHARED_RUNQ_ALL:            | 578.41s    | 3141% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_WAKEUPS performs roughly the same as
NO_SHARED_RUNQ, but SHARED_RUNQ_ALL results in a statistically
significant ~.7% improvement over NO_SHARED_RUNQ. This suggests that
enqueuing tasks in the shared runqueue on every enqueue improves work
conservation, and thanks to sharding, does not result in contention.

Note that I didn't collect data for kernel compile with SHARED_RUNQ_ALL
_without_ sharding. The reason for this is that we know that CPUs with
sufficiently large LLCs will contend, so if we've decided to accommodate
those CPUs with sharding, there's not much point in measuring the
results of not sharding on CPUs that we know won't contend.

Command: hackbench --loops 10000
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 2.1912s    | 3117% |
SHARED_RUNQ_WAKEUP:         | 2.1080s    | 3155% |
SHARED_RUNQ_ALL:            | 1.9830s    | 3144% |
			    o------------o-------o

Takeaway: SHARED_RUNQ in both forms performs exceptionally well compared
to NO_SHARED_RUNQ here, with SHARED_RUNQ_ALL beating NO_SHARED_RUNQ by
almost 10%. This was a surprising result given that it seems
advantageous to err on the side of avoiding migration in hackbench given
that tasks are short lived in sending only 10k bytes worth of messages,
but the results of the benchmark would seem to suggest that minimizing
runqueue delays is preferable.

Command:
for i in `seq 128`; do
    netperf -6 -t UDP_RR -c -C -l $runtime &
done
			    o_______________________o
			    |   mean  (thoughput)   |
			    o-----------------------o
NO_SHARED_RUNQ:             | 25064.12              |
SHARED_RUNQ_WAKEUP:         | 24862.16              |
SHARED_RUNQ_ALL:            | 25287.73              |
			    o-----------------------o

Takeaway: No statistical significance, though it is worth noting that
there is no regression for shared runqueue on the 7950X, while there is
a small regression on the Skylake and Milan hosts for SHARED_RUNQ_WAKEUP
as described below.

=== Single-socket | 18 core / 36 thread | 1-CCX | Intel Skylake ===

CPU max MHz: 1601.0000
CPU min MHz: 800.0000

Command: make -j$(nproc) built-in.a
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 1535.46s   | 3417% |
SHARED_RUNQ_WAKEUP:         | 1534.56s   | 3428% |
SHARED_RUNQ_ALL:            | 1531.95s   | 3429% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_ALL results in a ~.23% improvement over
NO_SHARED_RUNQ. Not a huge improvement, but consistently measurable.
The cause of this gain is presumably the same as the 7950X: improved
work conservation, with sharding preventing excessive contention on the
shard lock.

Command: hackbench --loops 10000
			    o____________o_______o
			    |    mean    | CPU   |
			    o------------o-------o
NO_SHARED_RUNQ:             | 5.5750s    | 3369% |
SHARED_RUNQ_WAKEUP:         | 5.5764s    | 3495% |
SHARED_RUNQ_ALL:            | 5.4760s    | 3481% |
			    o------------o-------o

Takeaway: SHARED_RUNQ_ALL results in a ~1.6% improvement over
NO_SHARED_RUNQ. Also statistically significant, but smaller than the
almost 10% improvement observed on the 7950X.

Command: netperf -n $(nproc) -l 60 -t TCP_RR
for i in `seq 128`; do
	netperf -6 -t UDP_RR -c -C -l $runtime &
done
				o______________________o
				|   mean  (thoughput)  |
				o----------------------o
NO_SHARED_RUNQ:			| 11963.08             |
SHARED_RUNQ_WAKEUP:		| 11943.60             |
SHARED_RUNQ_ALL:		| 11554.32             |
				o----------------------o

Takeaway: NO_SHARED_RUNQ performs the same as SHARED_RUNQ_WAKEUP, but
beats SHARED_RUNQ_ALL by ~3.4%. This result makes sense -- the workload
is very heavy on the runqueue, so enqueuing tasks in the shared runqueue
in __enqueue_entity() would intuitively result in increased contention
on the shard lock.  The fact that we're at parity with
SHARED_RUNQ_WAKEUP suggests that sharding the shared runqueue has
significantly improved the contention that was observed in v1, but that
__enqueue_entity() puts it over the edge.

NOTE: Parity for SHARED_RUNQ_WAKEUP relies on choosing the correct shard
size. If we chose, for example, a shard size of 16, there would still be
a regression between NO_SHARED_RUNQ and SHARED_RUNQ_WAKEUP. As described
below, this suggests that we may want to add a debugfs tunable for the
shard size.

=== Single-socket | 72-core | 6-CCX | AMD Milan Zen3 ===

CPU max MHz: 700.0000
CPU min MHz: 700.0000

Command: make -j$(nproc) built-in.a
				o____________o_______o
				|    mean    | CPU   |
				o------------o-------o
NO_SHARED_RUNQ:			| 1601.81s   | 6476% |
SHARED_RUNQ_WAKEUP:		| 1602.55s   | 6472% |
SHARED_RUNQ_ALL:		| 1602.49s   | 6475% |
				o------------o-------o

Takeaway: No statistically significant variance. It might be worth
experimenting with work stealing in a follow-on patch set.

Command: hackbench --loops 10000
				o____________o_______o
				|    mean    | CPU   |
				o------------o-------o
NO_SHARED_RUNQ:			| 5.2672s    | 6463% |
SHARED_RUNQ_WAKEUP:		| 5.1476s    | 6583% |
SHARED_RUNQ_ALL:		| 5.1003s    | 6598% |
				o------------o-------o

Takeaway: SHARED_RUNQ_ALL again wins, by about 3% over NO_SHARED_RUNQ in
this case.

Command: netperf -n $(nproc) -l 60 -t TCP_RR
for i in `seq 128`; do
	netperf -6 -t UDP_RR -c -C -l $runtime &
done
				o_______________________o
				|   mean  (thoughput)   |
				o-----------------------o
NO_SHARED_RUNQ:			| 13819.08              |
SHARED_RUNQ_WAKEUP:		| 13907.74              |
SHARED_RUNQ_ALL:		| 13569.69              |
				o-----------------------o

Takeaway: Similar to the Skylake runs, NO_SHARED_RUNQ still beats
SHARED_RUNQ_ALL, though by a slightly lower margin of ~1.8%.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 97985f28a627..bddb2bed4297 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -140,8 +140,8 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 /**
- * struct shared_runq - Per-LLC queue structure for enqueuing and pulling
- * waking tasks.
+ * struct shared_runq - Per-LLC queue structure for enqueuing and migrating
+ * runnable tasks within an LLC.
  *
  * struct shared_runq_shard - A structure containing a task list and a spinlock
  * for a subset of cores in a struct shared_runq.
@@ -161,10 +161,9 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * 2. The shard inside of the per-LLC struct shared_runq which contains the
  *    list of runnable tasks for that shard.
  *
- * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard at
- * the end of enqueue_task_fair(), and are opportunistically pulled from the
- * shared_runq in newidle_balance(). Pulling from shards is an O(# shards)
- * operation.
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard in
+ * __enqueue_entity(), and are opportunistically pulled from the shared_runq in
+ * newidle_balance(). Pulling from shards is an O(# shards) operation.
  *
  * There is currently no task-stealing between shared_runqs in different LLCs,
  * which means that shared_runq is not fully work conserving. This could be
@@ -253,22 +252,15 @@ static void shared_runq_push_task(struct shared_runq_shard *shard,
 	spin_unlock_irqrestore(&shard->lock, flags);
 }
 
-static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
-				     int enq_flags)
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
 {
-	bool task_migrated = enq_flags & ENQUEUE_MIGRATED;
-	bool task_wakeup = enq_flags & ENQUEUE_WAKEUP;
-
 	/*
 	 * Only enqueue the task in the shared runqueue if:
 	 *
 	 * - SWQUEUE is enabled
-	 * - The task is on the wakeup path
-	 * - The task wasn't purposefully migrated to the current rq by
-	 *   select_task_rq()
 	 * - The task isn't pinned to a specific CPU
 	 */
-	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
+	if (p->nr_cpus_allowed == 1)
 		return;
 
 	shared_runq_push_task(rq_shared_runq_shard(rq), p);
@@ -357,8 +349,7 @@ int __weak arch_asym_cpu_priority(int cpu)
  */
 #define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
 #else
-static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
-				     int enq_flags)
+static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p)
 {}
 
 static void shared_runq_dequeue_task(struct task_struct *p)
@@ -843,11 +834,15 @@ static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (sched_feat(SHARED_RUNQ) && entity_is_task(se))
+		shared_runq_enqueue_task(rq_of(cfs_rq), task_of(se));
 	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	if (sched_feat(SHARED_RUNQ) && entity_is_task(se))
+		shared_runq_dequeue_task(task_of(se));
 	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
 }
 
@@ -6587,9 +6582,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
-	if (sched_feat(SHARED_RUNQ))
-		shared_runq_enqueue_task(rq, p, flags);
-
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
@@ -6671,9 +6663,6 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 dequeue_throttle:
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
-
-	if (sched_feat(SHARED_RUNQ))
-		shared_runq_dequeue_task(p);
 }
 
 #ifdef CONFIG_SMP
@@ -8380,9 +8369,6 @@ done: __maybe_unused;
 
 	update_misfit_status(p, rq);
 
-	if (sched_feat(SHARED_RUNQ))
-		shared_runq_dequeue_task(p);
-
 	return p;
 
 idle:
-- 
2.40.1

