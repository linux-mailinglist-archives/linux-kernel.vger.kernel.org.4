Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BA874DEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGJUE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjGJUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:04:23 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF61A7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:09 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-400a39d4ffcso22557911cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689019449; x=1691611449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nF2VH8kNHAb0EtloBoQBFvgN17tlh7Ri+RQTdgHw3fI=;
        b=d4Em6qLQa3BH4LlpvqmTtzM8BtlGKmeCreQAk4IBGPJ2in5x3GArlNHonRslc/NaC2
         jvojJTwZ1kgqieJGc9SYphVpN6T63RsE6hssq+mn4GIt44oZRDKMu5BfLoVR4we9ZnUP
         Qft4Qjhvs/lpck6l06Z3CDWXizIfdh3oWd2UQVXEIwweUTGPfnwoqx1oQfDjI+mCPWJ8
         6lOW33mzM1/U8I2PRIzpbcjThjtGPvzuFiuWrp46T8rZ/OHu/V7PK8JeJ7pzPTPdeiej
         7b+n/vwtLQrSA2noEgbsDqhc+zNwaa3roVojKFl55eTImyZ615rf6RCVOYVXVT5E6SfD
         CsIg==
X-Gm-Message-State: ABy/qLbqagvB0e/tJ41R3/7BvqLE0H7KOd9bjYmTedQ440ReVaUfZEe3
        2d55TZO+UQVrXbzWNGhordGnpVzvb5WSwEeC
X-Google-Smtp-Source: APBJJlF0iBlezrek5dxMiUQJvSvp+6unD/vq6IWIBbEIFOZkwfbhpuzNtWzuOB2/D+ZLjoZV1EkEpw==
X-Received: by 2002:ac8:7e95:0:b0:403:96e3:4740 with SMTP id w21-20020ac87e95000000b0040396e34740mr13111789qtj.25.1689019448421;
        Mon, 10 Jul 2023 13:04:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:4850])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8074a000000b00401e04c66fesm260118qth.37.2023.07.10.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:04:08 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: [PATCH v2 6/7] sched: Shard per-LLC shared runqueues
Date:   Mon, 10 Jul 2023 15:03:41 -0500
Message-Id: <20230710200342.358255-7-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710200342.358255-1-void@manifault.com>
References: <20230710200342.358255-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SHARED_RUNQ scheduler feature creates a FIFO queue per LLC that
tasks are put into on enqueue, and pulled from when a core in that LLC
would otherwise go idle. For CPUs with large LLCs, this can sometimes
cause significant contention, as illustrated in [0].

[0]: https://lore.kernel.org/all/c8419d9b-2b31-2190-3058-3625bdbcb13d@meta.com/

So as to try and mitigate this contention, we can instead shard the
per-LLC runqueue into multiple per-LLC shards.

While this doesn't outright prevent all contention, it does somewhat mitigate it.
For example, if we run the following schbench command which does almost
nothing other than pound the runqueue:

schbench -L -m 52 -p 512 -r 10 -t 1

we observe with lockstats that sharding significantly decreases
contention.

3 shards:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions       waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      31510503       31510711           0.08          19.98        168932319.64     5.36            31700383      31843851       0.03           17.50        10273968.33      0.32
------------
&shard->lock       15731657          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock       15756516          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock          21766          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock            772          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540
------------
&shard->lock          23458          [<00000000126ec6ab>] newidle_balance+0x45a/0x650
&shard->lock       16505108          [<000000001faf84f9>] enqueue_task_fair+0x459/0x530
&shard->lock       14981310          [<0000000068c0fd75>] pick_next_task_fair+0x4dd/0x510
&shard->lock            835          [<000000002886c365>] dequeue_task_fair+0x4c9/0x540

No sharding:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name        con-bounces    contentions         waittime-min   waittime-max waittime-total         waittime-avg    acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:     117868635      118361486           0.09           393.01       1250954097.25          10.57           119345882     119780601      0.05          343.35       38313419.51      0.32
------------
&shard->lock       59169196          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock       59084239          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0
&shard->lock         108051          [<00000000084a6193>] newidle_balance+0x45a/0x650
------------
&shard->lock       60028355          [<0000000060507011>] __enqueue_entity+0xdc/0x110
&shard->lock         119882          [<00000000084a6193>] newidle_balance+0x45a/0x650
&shard->lock       58213249          [<00000000f1c67316>] __dequeue_entity+0x78/0xa0

The contention is ~3-4x worse if we don't shard at all. This roughly
matches the fact that we had 3 shards on the host where this was
collected. This could be addressed in future patch sets by adding a
debugfs knob to control the sharding granularity. If we make the shards
even smaller (what's in this patch, i.e. a size of 6), the contention
goes away almost entirely:

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name    	   con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min  holdtime-max holdtime-total   holdtime-avg
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&shard->lock:      13839849       13877596      0.08          13.23        5389564.95       0.39           46910241      48069307       0.06          16.40        16534469.35      0.34
------------
&shard->lock           3559          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        6992418          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock        6881619          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        6640140          [<000000002266f400>] __dequeue_entity+0x78/0xa0
&shard->lock           3523          [<00000000ea455dcc>] newidle_balance+0x45a/0x650
&shard->lock        7233933          [<000000002a62f2e0>] __enqueue_entity+0xdc/0x110

Interestingly, SHARED_RUNQ performs worse than NO_SHARED_RUNQ on the schbench
benchmark on Milan, but we contend even more on the rq lock:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name         con-bounces    contentions   waittime-min  waittime-max waittime-total   waittime-avg   acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:       9617614        9656091       0.10          79.64        69665812.00      7.21           18092700      67652829       0.11           82.38        344524858.87     5.09
-----------
&rq->__lock        6301611          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        2530807          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock         109360          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         178218          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock        3245506          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock        1294355          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
&rq->__lock        2837804          [<000000003e63bf26>] task_rq_lock+0x43/0xe0
&rq->__lock        1627866          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10

..................................................................................................................................................................................................

&shard->lock:       7338558       7343244       0.10          35.97        7173949.14       0.98           30200858      32679623       0.08           35.59        16270584.52      0.50
------------
&shard->lock        2004142          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2611264          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        2727838          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110
------------
&shard->lock        2737232          [<00000000473978cc>] newidle_balance+0x45a/0x650
&shard->lock        1693341          [<00000000f8aa2c91>] __dequeue_entity+0x78/0xa0
&shard->lock        2912671          [<0000000028f55bb5>] __enqueue_entity+0xdc/0x110

...................................................................................................................................................................................................

If we look at the lock stats with SHARED_RUNQ disabled, the rq lock still
contends the most, but it's significantly less than with it enabled:

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
class name          con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

&rq->__lock:        791277         791690        0.12           110.54       4889787.63       6.18            1575996       62390275       0.13           112.66       316262440.56     5.07
-----------
&rq->__lock         263343          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock          19394          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock           4143          [<000000003b542e83>] __task_rq_lock+0x51/0xf0
&rq->__lock          51094          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170
-----------
&rq->__lock          23756          [<0000000011be1562>] raw_spin_rq_lock_nested+0xa/0x10
&rq->__lock         379048          [<00000000516703f0>] __schedule+0x72/0xaa0
&rq->__lock            677          [<000000003b542e83>] __task_rq_lock+0x51/0xf0
&rq->__lock          47962          [<00000000c38a30f9>] sched_ttwu_pending+0x3d/0x170

In general, the takeaway here is that sharding does help with
contention, but it's not necessarily one size fits all, and it's
workload dependent. For now, let's include sharding to try and avoid
contention, and because it doesn't seem to regress CPUs that don't need
it such as the AMD 7950X.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c  | 139 +++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h |   3 +-
 2 files changed, 96 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff2491387201..97985f28a627 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -143,21 +143,28 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * struct shared_runq - Per-LLC queue structure for enqueuing and pulling
  * waking tasks.
  *
+ * struct shared_runq_shard - A structure containing a task list and a spinlock
+ * for a subset of cores in a struct shared_runq.
+ *
  * WHAT
  * ====
  *
  * This structure enables the scheduler to be more aggressively work
- * conserving, by placing waking tasks on a per-LLC FIFO queue that can then be
- * pulled from when another core in the LLC is going to go idle.
- *
- * struct rq stores a pointer to its LLC's shared_runq via struct cfs_rq.
- * Waking tasks are enqueued in a shared_runq at the end of
- * enqueue_task_fair(), and are opportunistically pulled from the shared_runq
- * in newidle_balance(). Tasks enqueued in a shared_runq may be scheduled prior
- * to being pulled from the shared_runq, in which case they're simply dequeued
- * from the shared_runq. A waking task is only enqueued to a shared_runq when
- * it was _not_ manually migrated to the current runqueue by
- * select_task_rq_fair().
+ * conserving, by placing waking tasks on a per-LLC FIFO queue shard that can
+ * then be pulled from when another core in the LLC is going to go idle.
+ *
+ * struct rq stores two pointers in its struct cfs_rq:
+ *
+ * 1. The per-LLC struct shared_runq which contains one or more shards of
+ *    enqueued tasks.
+ *
+ * 2. The shard inside of the per-LLC struct shared_runq which contains the
+ *    list of runnable tasks for that shard.
+ *
+ * Waking tasks are enqueued in the calling CPU's struct shared_runq_shard at
+ * the end of enqueue_task_fair(), and are opportunistically pulled from the
+ * shared_runq in newidle_balance(). Pulling from shards is an O(# shards)
+ * operation.
  *
  * There is currently no task-stealing between shared_runqs in different LLCs,
  * which means that shared_runq is not fully work conserving. This could be
@@ -167,11 +174,12 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * HOW
  * ===
  *
- * An shared_runq is comprised of a list, and a spinlock for synchronization.
- * Given that the critical section for a shared_runq is typically a fast list
- * operation, and that the shared_runq is localized to a single LLC, the
- * spinlock will typically only be contended on workloads that do little else
- * other than hammer the runqueue.
+ * A struct shared_runq_shard is comprised of a list, and a spinlock for
+ * synchronization.  Given that the critical section for a shared_runq is
+ * typically a fast list operation, and that the shared_runq_shard is localized
+ * to a subset of cores on a single LLC (plus other cores in the LLC that pull
+ * from the shard in newidle_balance()), the spinlock will typically only be
+ * contended on workloads that do little else other than hammer the runqueue.
  *
  * WHY
  * ===
@@ -185,48 +193,64 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
  * it, as well as to strike a balance between work conservation, and L3 cache
  * locality.
  */
-struct shared_runq {
+struct shared_runq_shard {
 	struct list_head list;
 	spinlock_t lock;
 } ____cacheline_aligned;
 
+struct shared_runq {
+	u32 num_shards;
+	struct shared_runq_shard shards[];
+} ____cacheline_aligned;
+
+/* This would likely work better as a configurable knob via debugfs */
+#define SHARED_RUNQ_SHARD_SZ 6
+
 #ifdef CONFIG_SMP
 static struct shared_runq *rq_shared_runq(struct rq *rq)
 {
 	return rq->cfs.shared_runq;
 }
 
-static struct task_struct *shared_runq_pop_task(struct rq *rq)
+static struct shared_runq_shard *rq_shared_runq_shard(struct rq *rq)
+{
+	return rq->cfs.shard;
+}
+
+static int shared_runq_shard_idx(const struct shared_runq *runq, int cpu)
+{
+	return cpu % runq->num_shards;
+}
+
+static struct task_struct *
+shared_runq_pop_task(struct shared_runq_shard *shard, int target)
 {
 	unsigned long flags;
 	struct task_struct *p;
-	struct shared_runq *shared_runq;
 
-	shared_runq = rq_shared_runq(rq);
-	if (list_empty(&shared_runq->list))
+	if (list_empty(&shard->list))
 		return NULL;
 
-	spin_lock_irqsave(&shared_runq->lock, flags);
-	p = list_first_entry_or_null(&shared_runq->list, struct task_struct,
+	spin_lock_irqsave(&shard->lock, flags);
+	p = list_first_entry_or_null(&shard->list, struct task_struct,
 				     shared_runq_node);
-	if (p && is_cpu_allowed(p, cpu_of(rq)))
+	if (p && is_cpu_allowed(p, target))
 		list_del_init(&p->shared_runq_node);
 	else
 		p = NULL;
-	spin_unlock_irqrestore(&shared_runq->lock, flags);
+	spin_unlock_irqrestore(&shard->lock, flags);
 
 	return p;
 }
 
-static void shared_runq_push_task(struct rq *rq, struct task_struct *p)
+static void shared_runq_push_task(struct shared_runq_shard *shard,
+				  struct task_struct *p)
 {
 	unsigned long flags;
-	struct shared_runq *shared_runq;
 
-	shared_runq = rq_shared_runq(rq);
-	spin_lock_irqsave(&shared_runq->lock, flags);
-	list_add_tail(&p->shared_runq_node, &shared_runq->list);
-	spin_unlock_irqrestore(&shared_runq->lock, flags);
+	spin_lock_irqsave(&shard->lock, flags);
+	list_add_tail(&p->shared_runq_node, &shard->list);
+	spin_unlock_irqrestore(&shard->lock, flags);
 }
 
 static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
@@ -247,7 +271,7 @@ static void shared_runq_enqueue_task(struct rq *rq, struct task_struct *p,
 	if (!task_wakeup || task_migrated || p->nr_cpus_allowed == 1)
 		return;
 
-	shared_runq_push_task(rq, p);
+	shared_runq_push_task(rq_shared_runq_shard(rq), p);
 }
 
 static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
@@ -256,8 +280,21 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 	struct rq *src_rq;
 	struct rq_flags src_rf;
 	int ret;
+	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
+	u32 i, starting_idx, curr_idx, num_shards;
 
-	p = shared_runq_pop_task(rq);
+	shared_runq = rq_shared_runq(rq);
+	starting_idx = shared_runq_shard_idx(shared_runq, cpu_of(rq));
+	num_shards = shared_runq->num_shards;
+	for (i = 0; i < num_shards; i++) {
+		curr_idx = (starting_idx + i) % num_shards;
+		shard = &shared_runq->shards[curr_idx];
+
+		p = shared_runq_pop_task(shard, cpu_of(rq));
+		if (p)
+			break;
+	}
 	if (!p)
 		return 0;
 
@@ -287,13 +324,13 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
 static void shared_runq_dequeue_task(struct task_struct *p)
 {
 	unsigned long flags;
-	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
 
 	if (!list_empty(&p->shared_runq_node)) {
-		shared_runq = rq_shared_runq(task_rq(p));
-		spin_lock_irqsave(&shared_runq->lock, flags);
+		shard = rq_shared_runq_shard(task_rq(p));
+		spin_lock_irqsave(&shard->lock, flags);
 		list_del_init(&p->shared_runq_node);
-		spin_unlock_irqrestore(&shared_runq->lock, flags);
+		spin_unlock_irqrestore(&shard->lock, flags);
 	}
 }
 
@@ -13003,19 +13040,31 @@ __init void init_sched_fair_class(void)
 __init void init_sched_fair_class_late(void)
 {
 #ifdef CONFIG_SMP
-	int i;
+	int i, j;
 	struct shared_runq *shared_runq;
+	struct shared_runq_shard *shard;
 	struct rq *rq;
 	struct rq *llc_rq;
+	size_t shared_runq_size;
+	u32 num_shards, shard_idx;
 
 	for_each_possible_cpu(i) {
 		if (per_cpu(sd_llc_id, i) == i) {
 			llc_rq = cpu_rq(i);
-
-			shared_runq = kzalloc_node(sizeof(struct shared_runq),
-					       GFP_KERNEL, cpu_to_node(i));
-			INIT_LIST_HEAD(&shared_runq->list);
-			spin_lock_init(&shared_runq->lock);
+			num_shards = max(per_cpu(sd_llc_size, i) /
+					 SHARED_RUNQ_SHARD_SZ, 1);
+			shared_runq_size = sizeof(struct shared_runq) +
+				num_shards * sizeof(struct shared_runq_shard);
+
+			shared_runq = kzalloc_node(shared_runq_size,
+						   GFP_KERNEL, cpu_to_node(i));
+			shared_runq->num_shards = num_shards;
+			for (j = 0; j < num_shards; j++) {
+				shard = &shared_runq->shards[j];
+
+				INIT_LIST_HEAD(&shard->list);
+				spin_lock_init(&shard->lock);
+			}
 			llc_rq->cfs.shared_runq = shared_runq;
 		}
 	}
@@ -13024,9 +13073,9 @@ __init void init_sched_fair_class_late(void)
 		rq = cpu_rq(i);
 		llc_rq = cpu_rq(per_cpu(sd_llc_id, i));
 
-		if (rq == llc_rq)
-			continue;
 		rq->cfs.shared_runq = llc_rq->cfs.shared_runq;
+		shard_idx = shared_runq_shard_idx(rq->cfs.shared_runq, i);
+		rq->cfs.shard = &rq->cfs.shared_runq->shards[shard_idx];
 	}
 #endif /* SMP */
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8b573dfaba33..ca56a8120088 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -576,7 +576,8 @@ struct cfs_rq {
 #endif
 
 #ifdef CONFIG_SMP
-	struct shared_runq	*shared_runq;
+	struct shared_runq	 *shared_runq;
+	struct shared_runq_shard *shard;
 	/*
 	 * CFS load tracking
 	 */
-- 
2.40.1

