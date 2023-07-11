Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23274E34C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjGKBR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGKBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF94F211F;
        Mon, 10 Jul 2023 18:15:56 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e3b15370so2894827b3a.0;
        Mon, 10 Jul 2023 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038119; x=1691630119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxXLQZYy7Xg5I2RsYdHs29pbxdvD0wadFLiKUk7xQ88=;
        b=DCa102rWcCyMXOwWi4fbgML130p4xf11MnOR0vH9/AUPMbJIb2sFcAPHUkxFDtImni
         oV3dQGCe8sKvBuwFlHlxXoCqPz/asa8WNbLXIbsYiJ/x4X61dZ/wqfwn946isqL7Mels
         4WwrQs9Lk1DP4f01+68kSa1dpQixCb4N7TlOMYnqMzGkyBALhlpFPy4xSksHLVj4hlAv
         iR8rmeCNouUxs7n2x3DEzlwih3dSCY3+Tv9D1E25EurmG5QDlGK8ZbpzVOaoIuk/Wdhc
         431ib6iVesnWpLlgAh4tAJ8dDlLT7JrIBsLdGy78psq9dPQHwEObWsmtZpe0fF4QUZ9R
         BS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038119; x=1691630119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RxXLQZYy7Xg5I2RsYdHs29pbxdvD0wadFLiKUk7xQ88=;
        b=iSlfY/CXelJuzA715nqFou3Y/QTXNHoHB8PmgXd2DS3GWXqHl6dUTQSpkVLXa+QrPk
         PEvzYcB5NjHZ61FCis5VviYKhA6azea0D7hIUr1HlGtbi6eFsCvII+eQsx46CxbR8Wwq
         dregXdybFa/vitclK/+hzv/qHy4xjiIwIhC15RN5vCbNIfUfWprQ5BKt4sSMxi+XFe2A
         U1/vqJVUtymRRvE/8e85wT+lmNJuVU52G8xaLJbZIpCKcZ/AYV4AgUKLp6w7JqhkkIhw
         6dLhBEoDGsFxtOpZSxO7u/EGmiGybpdBPkkobBSTPwMX4ewrD3VIMwoTj9DwuRnUREl3
         SXxQ==
X-Gm-Message-State: ABy/qLYxa+YKEdBwYlGjVTMek0+KRu3w6Aj3o9x5KrIHN5sx6lmJ0AEn
        JeLaqhZYIvWbYqX8gWGPg1k=
X-Google-Smtp-Source: APBJJlG3XO8+jfMNeDiF63s2JAf62Oi2ebyWSngKhmAo7ZfaUaFo7OD79wgxIqr7vVludK0uk+6vOA==
X-Received: by 2002:a05:6a20:1050:b0:126:7d25:b0ce with SMTP id gt16-20020a056a20105000b001267d25b0cemr10940615pzc.51.1689038118549;
        Mon, 10 Jul 2023 18:15:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902cb0f00b001ae469ca0c0sm497754ply.245.2023.07.10.18.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 31/34] sched_ext: Add vtime-ordered priority queue to dispatch_q's
Date:   Mon, 10 Jul 2023 15:13:49 -1000
Message-ID: <20230711011412.100319-32-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, a dsq is always a FIFO. A task which is dispatched earlier gets
consumed or executed earlier. While this is sufficient when dsq's are used
for simple staging areas for tasks which are ready to execute, it'd make
dsq's a lot more useful if they can implement custom ordering.

This patch adds a vtime-ordered priority queue to dsq's. When the BPF
scheduler dispatches a task with the new scx_bpf_dispatch_vtime() helper, it
can specify the vtime tha the task should be inserted at and the task is
inserted into the priority queue in the dsq which is ordered according to
time_before64() comparison of the vtime values. When executing or consuming
the dsq, the FIFO is always processed first and the priority queue is
processed iff the FIFO is empty.

The design decision was made to allow both FIFO and priority queue to be
available at the same timeq for all dsq's for three reasons. First, the new
priority queue is useful for the local dsq's too but they also need the FIFO
when consuming tasks from other dsq's as the vtimes may not be comparable
across them. Second, the interface surface is smaller this way - the only
additional interface necessary is scx_bpf_dispsatch_vtime(). Third, the
overhead isn't meaningfully different whether they're available at the same
time or not.

This makes it very easy for the BPF schedulers to implement proper vtime
based scheduling within each dsq very easy and efficient at a negligible
cost in terms of code complexity and overhead.

scx_simple and scx_example_flatcg are updated to default to weighted
vtime scheduling (the latter within each cgroup). FIFO scheduling can be
selected with -f option.

v2: p->scx.dsq_vtime was not initialized on load or across cgroup migrations
    leading to some tasks being stalled for extended period of time
    depending on how saturated the machine is. Fixed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h        |  16 +++-
 init/init_task.c                 |   2 +-
 kernel/sched/core.c              |   3 +-
 kernel/sched/ext.c               | 137 +++++++++++++++++++++++++++----
 kernel/sched/ext.h               |   1 +
 tools/sched_ext/scx_common.bpf.h |   1 +
 tools/sched_ext/scx_flatcg.bpf.c |  72 +++++++++++++++-
 tools/sched_ext/scx_flatcg.c     |   6 +-
 tools/sched_ext/scx_simple.bpf.c |  73 +++++++++++++++-
 tools/sched_ext/scx_simple.c     |   8 +-
 10 files changed, 293 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 9ef4c3a90199..446821073bd1 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -582,6 +582,7 @@ struct sched_ext_ops {
 struct scx_dispatch_q {
 	raw_spinlock_t		lock;
 	struct list_head	fifo;	/* processed in dispatching order */
+	struct rb_root_cached	priq;	/* processed in p->scx.dsq_vtime order */
 	u32			nr;
 	u64			id;
 	struct rhash_head	hash_node;
@@ -594,6 +595,7 @@ enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
 	SCX_TASK_BAL_KEEP	= 1 << 1, /* balance decided to keep current */
 	SCX_TASK_ENQ_LOCAL	= 1 << 2, /* used by scx_select_cpu_dfl() to set SCX_ENQ_LOCAL */
+	SCX_TASK_ON_DSQ_PRIQ	= 1 << 3, /* task is queued on the priority queue of a dsq */
 
 	SCX_TASK_OPS_PREPPED	= 1 << 8, /* prepared for BPF scheduler enable */
 	SCX_TASK_OPS_ENABLED	= 1 << 9, /* task has BPF scheduler enabled */
@@ -635,7 +637,10 @@ enum scx_kf_mask {
  */
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
-	struct list_head	dsq_node;
+	struct {
+		struct list_head	fifo;	/* dispatch order */
+		struct rb_node		priq;	/* p->scx.dsq_vtime order */
+	} dsq_node;
 	struct list_head	watchdog_node;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
@@ -663,6 +668,15 @@ struct sched_ext_entity {
 	 */
 	u64			slice;
 
+	/*
+	 * Used to order tasks when dispatching to the vtime-ordered priority
+	 * queue of a dsq. This is usually set through scx_bpf_dispatch_vtime()
+	 * but can also be modified directly by the BPF scheduler. Modifying it
+	 * while a task is queued on a dsq may mangle the ordering and is not
+	 * recommended.
+	 */
+	u64			dsq_vtime;
+
 	/*
 	 * If set, reject future sched_setscheduler(2) calls updating the policy
 	 * to %SCHED_EXT with -%EACCES.
diff --git a/init/init_task.c b/init/init_task.c
index 913194aab623..7ea89ccd0cf1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -105,7 +105,7 @@ struct task_struct init_task
 #endif
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
-		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.dsq_node.fifo	= LIST_HEAD_INIT(init_task.scx.dsq_node.fifo),
 		.watchdog_node	= LIST_HEAD_INIT(init_task.scx.watchdog_node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 972996c05263..9128160b6264 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4518,7 +4518,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	p->scx.dsq		= NULL;
-	INIT_LIST_HEAD(&p->scx.dsq_node);
+	INIT_LIST_HEAD(&p->scx.dsq_node.fifo);
+	RB_CLEAR_NODE(&p->scx.dsq_node.priq);
 	INIT_LIST_HEAD(&p->scx.watchdog_node);
 	p->scx.flags		= 0;
 	p->scx.weight		= 0;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 115d4d76cbc6..44ba457263bd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -594,12 +594,25 @@ static void update_curr_scx(struct rq *rq)
 	}
 }
 
+static bool scx_dsq_priq_less(struct rb_node *node_a,
+			      const struct rb_node *node_b)
+{
+	const struct task_struct *a =
+		container_of(node_a, struct task_struct, scx.dsq_node.priq);
+	const struct task_struct *b =
+		container_of(node_b, struct task_struct, scx.dsq_node.priq);
+
+	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
+}
+
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			     u64 enq_flags)
 {
 	bool is_local = dsq->id == SCX_DSQ_LOCAL;
 
-	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node));
+	WARN_ON_ONCE(p->scx.dsq || !list_empty(&p->scx.dsq_node.fifo));
+	WARN_ON_ONCE((p->scx.flags & SCX_TASK_ON_DSQ_PRIQ) ||
+		     !RB_EMPTY_NODE(&p->scx.dsq_node.priq));
 
 	if (!is_local) {
 		raw_spin_lock(&dsq->lock);
@@ -612,10 +625,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
-		list_add(&p->scx.dsq_node, &dsq->fifo);
-	else
-		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
+	if (enq_flags & SCX_ENQ_DSQ_PRIQ) {
+		p->scx.flags |= SCX_TASK_ON_DSQ_PRIQ;
+		rb_add_cached(&p->scx.dsq_node.priq, &dsq->priq,
+			      scx_dsq_priq_less);
+	} else {
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+			list_add(&p->scx.dsq_node.fifo, &dsq->fifo);
+		else
+			list_add_tail(&p->scx.dsq_node.fifo, &dsq->fifo);
+	}
 	dsq->nr++;
 	p->scx.dsq = dsq;
 
@@ -644,13 +663,31 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 	}
 }
 
+static void task_unlink_from_dsq(struct task_struct *p,
+				 struct scx_dispatch_q *dsq)
+{
+	if (p->scx.flags & SCX_TASK_ON_DSQ_PRIQ) {
+		rb_erase_cached(&p->scx.dsq_node.priq, &dsq->priq);
+		RB_CLEAR_NODE(&p->scx.dsq_node.priq);
+		p->scx.flags &= ~SCX_TASK_ON_DSQ_PRIQ;
+	} else {
+		list_del_init(&p->scx.dsq_node.fifo);
+	}
+}
+
+static bool task_linked_on_dsq(struct task_struct *p)
+{
+	return !list_empty(&p->scx.dsq_node.fifo) ||
+		!RB_EMPTY_NODE(&p->scx.dsq_node.priq);
+}
+
 static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 {
 	struct scx_dispatch_q *dsq = p->scx.dsq;
 	bool is_local = dsq == &scx_rq->local_dsq;
 
 	if (!dsq) {
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		/*
 		 * When dispatching directly from the BPF scheduler to a local
 		 * DSQ, the task isn't associated with any DSQ but
@@ -671,8 +708,8 @@ static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(list_empty(&p->scx.dsq_node));
-		list_del_init(&p->scx.dsq_node);
+		WARN_ON_ONCE(!task_linked_on_dsq(p));
+		task_unlink_from_dsq(p, dsq);
 		dsq->nr--;
 	} else {
 		/*
@@ -681,7 +718,7 @@ static void dispatch_dequeue(struct scx_rq *scx_rq, struct task_struct *p)
 		 * holding_cpu which tells dispatch_to_local_dsq() that it lost
 		 * the race.
 		 */
-		WARN_ON_ONCE(!list_empty(&p->scx.dsq_node));
+		WARN_ON_ONCE(task_linked_on_dsq(p));
 		p->scx.holding_cpu = -1;
 	}
 	p->scx.dsq = NULL;
@@ -1145,33 +1182,52 @@ static void dispatch_to_local_dsq_unlock(struct rq *rq, struct rq_flags *rf,
 #endif	/* CONFIG_SMP */
 
 
+static bool task_can_run_on_rq(struct task_struct *p, struct rq *rq)
+{
+	return likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
+		cpumask_test_cpu(cpu_of(rq), p->cpus_ptr);
+}
+
 static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 			       struct scx_dispatch_q *dsq)
 {
 	struct scx_rq *scx_rq = &rq->scx;
 	struct task_struct *p;
+	struct rb_node *rb_node;
 	struct rq *task_rq;
 	bool moved = false;
 retry:
-	if (list_empty(&dsq->fifo))
+	if (list_empty(&dsq->fifo) && !rb_first_cached(&dsq->priq))
 		return false;
 
 	raw_spin_lock(&dsq->lock);
-	list_for_each_entry(p, &dsq->fifo, scx.dsq_node) {
+
+	list_for_each_entry(p, &dsq->fifo, scx.dsq_node.fifo) {
+		task_rq = task_rq(p);
+		if (rq == task_rq)
+			goto this_rq;
+		if (task_can_run_on_rq(p, rq))
+			goto remote_rq;
+	}
+
+	for (rb_node = rb_first_cached(&dsq->priq); rb_node;
+	     rb_node = rb_next(rb_node)) {
+		p = container_of(rb_node, struct task_struct, scx.dsq_node.priq);
 		task_rq = task_rq(p);
 		if (rq == task_rq)
 			goto this_rq;
-		if (likely(test_rq_online(rq)) && !is_migration_disabled(p) &&
-		    cpumask_test_cpu(cpu_of(rq), p->cpus_ptr))
+		if (task_can_run_on_rq(p, rq))
 			goto remote_rq;
 	}
+
 	raw_spin_unlock(&dsq->lock);
 	return false;
 
 this_rq:
 	/* @dsq is locked and @p is on this rq */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_move_tail(&p->scx.dsq_node, &scx_rq->local_dsq.fifo);
+	task_unlink_from_dsq(p, dsq);
+	list_add_tail(&p->scx.dsq_node.fifo, &scx_rq->local_dsq.fifo);
 	dsq->nr--;
 	scx_rq->local_dsq.nr++;
 	p->scx.dsq = &scx_rq->local_dsq;
@@ -1188,7 +1244,7 @@ static bool consume_dispatch_q(struct rq *rq, struct rq_flags *rf,
 	 * move_task_to_local_dsq().
 	 */
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	list_del_init(&p->scx.dsq_node);
+	task_unlink_from_dsq(p, dsq);
 	dsq->nr--;
 	p->scx.holding_cpu = raw_smp_processor_id();
 	raw_spin_unlock(&dsq->lock);
@@ -1692,8 +1748,18 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 static struct task_struct *first_local_task(struct rq *rq)
 {
-	return list_first_entry_or_null(&rq->scx.local_dsq.fifo,
-					struct task_struct, scx.dsq_node);
+	struct rb_node *rb_node;
+
+	if (!list_empty(&rq->scx.local_dsq.fifo))
+		return list_first_entry(&rq->scx.local_dsq.fifo,
+					struct task_struct, scx.dsq_node.fifo);
+
+	rb_node = rb_first_cached(&rq->scx.local_dsq.priq);
+	if (rb_node)
+		return container_of(rb_node,
+				    struct task_struct, scx.dsq_node.priq);
+
+	return NULL;
 }
 
 static struct task_struct *pick_next_task_scx(struct rq *rq)
@@ -3401,6 +3467,9 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 		if (off >= offsetof(struct task_struct, scx.slice) &&
 		    off + size <= offsetofend(struct task_struct, scx.slice))
 			return SCALAR_VALUE;
+		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+			return SCALAR_VALUE;
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -3798,8 +3867,42 @@ void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 	scx_dispatch_commit(p, dsq_id, enq_flags);
 }
 
+/**
+ * scx_bpf_dispatch_vtime - Dispatch a task into the vtime priority queue of a DSQ
+ * @p: task_struct to dispatch
+ * @dsq_id: DSQ to dispatch to
+ * @slice: duration @p can run for in nsecs
+ * @vtime: @p's ordering inside the vtime-sorted queue of the target DSQ
+ * @enq_flags: SCX_ENQ_*
+ *
+ * Dispatch @p into the vtime priority queue of the DSQ identified by @dsq_id.
+ * Tasks queued into the priority queue are ordered by @vtime and always
+ * consumed after the tasks in the FIFO queue. All other aspects are identical
+ * to scx_bpf_dispatch().
+ *
+ * @vtime ordering is according to time_before64() which considers wrapping. A
+ * numerically larger vtime may indicate an earlier position in the ordering and
+ * vice-versa.
+ */
+void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice,
+			    u64 vtime, u64 enq_flags)
+{
+	if (!scx_dispatch_preamble(p, enq_flags))
+		return;
+
+	if (slice)
+		p->scx.slice = slice;
+	else
+		p->scx.slice = p->scx.slice ?: 1;
+
+	p->scx.dsq_vtime = vtime;
+
+	scx_dispatch_commit(p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
+}
+
 BTF_SET8_START(scx_kfunc_ids_enqueue_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_SET8_END(scx_kfunc_ids_enqueue_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index cd14970c239d..821515bb6580 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -63,6 +63,7 @@ enum scx_enq_flags {
 	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
 
 	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
+	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
 };
 
 enum scx_deq_flags {
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 8a210ab0eaab..5a6136dceb4d 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -58,6 +58,7 @@ s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index ab7cff4da7da..6d8c6f396577 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -38,6 +38,10 @@
  * this isn't a real concern especially given the performance gain. Also, there
  * are ways to mitigate the problem further by e.g. introducing an extra
  * scheduling layer on cgroup delegation boundaries.
+ *
+ * The scheduler first picks the cgroup to run and then schedule the tasks
+ * within by using nested weighted vtime scheduling by default. The
+ * cgroup-internal scheduling can be switched to FIFO with the -f option.
  */
 #include "scx_common.bpf.h"
 #include "user_exit_info.h"
@@ -47,6 +51,7 @@ char _license[] SEC("license") = "GPL";
 
 const volatile u32 nr_cpus = 32;	/* !0 for veristat, set during init */
 const volatile u64 cgrp_slice_ns = SCX_SLICE_DFL;
+const volatile bool fifo_sched;
 const volatile bool switch_partial;
 
 u64 cvtime_now;
@@ -350,7 +355,21 @@ void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
 	if (!cgc)
 		goto out_release;
 
-	scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, cgrp->kn->id, SCX_SLICE_DFL, enq_flags);
+	} else {
+		u64 tvtime = p->scx.dsq_vtime;
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(tvtime, cgc->tvtime_now - SCX_SLICE_DFL))
+			tvtime = cgc->tvtime_now - SCX_SLICE_DFL;
+
+		scx_bpf_dispatch_vtime(p, cgrp->kn->id, SCX_SLICE_DFL,
+				       tvtime, enq_flags);
+	}
 
 	cgrp_enqueued(cgrp, cgc);
 out_release:
@@ -462,12 +481,40 @@ void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
 	bpf_cgroup_release(cgrp);
 }
 
+void BPF_STRUCT_OPS(fcg_running, struct task_struct *p)
+{
+	struct cgroup *cgrp;
+	struct fcg_cgrp_ctx *cgc;
+
+	if (fifo_sched)
+		return;
+
+	cgrp = scx_bpf_task_cgroup(p);
+	cgc = find_cgrp_ctx(cgrp);
+	if (cgc) {
+		/*
+		 * @cgc->tvtime_now always progresses forward as tasks start
+		 * executing. The test and update can be performed concurrently
+		 * from multiple CPUs and thus racy. Any error should be
+		 * contained and temporary. Let's just live with it.
+		 */
+		if (vtime_before(cgc->tvtime_now, p->scx.dsq_vtime))
+			cgc->tvtime_now = p->scx.dsq_vtime;
+	}
+	bpf_cgroup_release(cgrp);
+}
+
 void BPF_STRUCT_OPS(fcg_stopping, struct task_struct *p, bool runnable)
 {
 	struct fcg_task_ctx *taskc;
 	struct cgroup *cgrp;
 	struct fcg_cgrp_ctx *cgc;
 
+	/* scale the execution time by the inverse of the weight and charge */
+	if (!fifo_sched)
+		p->scx.dsq_vtime +=
+			(SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
@@ -706,6 +753,7 @@ s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
 		   struct scx_enable_args *args)
 {
 	struct fcg_task_ctx *taskc;
+	struct fcg_cgrp_ctx *cgc;
 
 	/*
 	 * @p is new. Let's ensure that its task_ctx is available. We can sleep
@@ -717,6 +765,12 @@ s32 BPF_STRUCT_OPS(fcg_prep_enable, struct task_struct *p,
 		return -ENOMEM;
 
 	taskc->bypassed_at = 0;
+
+	if (!(cgc = find_cgrp_ctx(args->cgroup)))
+		return -ENOENT;
+
+	p->scx.dsq_vtime = cgc->tvtime_now;
+
 	return 0;
 }
 
@@ -804,6 +858,20 @@ void BPF_STRUCT_OPS(fcg_cgroup_exit, struct cgroup *cgrp)
 	scx_bpf_destroy_dsq(cgid);
 }
 
+void BPF_STRUCT_OPS(fcg_cgroup_move, struct task_struct *p,
+		    struct cgroup *from, struct cgroup *to)
+{
+	struct fcg_cgrp_ctx *from_cgc, *to_cgc;
+	s64 vtime_delta;
+
+	/* find_cgrp_ctx() triggers scx_ops_error() on lookup failures */
+	if (!(from_cgc = find_cgrp_ctx(from)) || !(to_cgc = find_cgrp_ctx(to)))
+		return;
+
+	vtime_delta = p->scx.dsq_vtime - from_cgc->tvtime_now;
+	p->scx.dsq_vtime = to_cgc->tvtime_now + vtime_delta;
+}
+
 s32 BPF_STRUCT_OPS(fcg_init)
 {
 	if (!switch_partial)
@@ -821,12 +889,14 @@ struct sched_ext_ops flatcg_ops = {
 	.enqueue		= (void *)fcg_enqueue,
 	.dispatch		= (void *)fcg_dispatch,
 	.runnable		= (void *)fcg_runnable,
+	.running		= (void *)fcg_running,
 	.stopping		= (void *)fcg_stopping,
 	.quiescent		= (void *)fcg_quiescent,
 	.prep_enable		= (void *)fcg_prep_enable,
 	.cgroup_set_weight	= (void *)fcg_cgroup_set_weight,
 	.cgroup_init		= (void *)fcg_cgroup_init,
 	.cgroup_exit		= (void *)fcg_cgroup_exit,
+	.cgroup_move		= (void *)fcg_cgroup_move,
 	.init			= (void *)fcg_init,
 	.exit			= (void *)fcg_exit,
 	.flags			= SCX_OPS_CGROUP_KNOB_WEIGHT | SCX_OPS_ENQ_EXITING,
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index 82afaa98d7a7..40aa464c55b1 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -26,10 +26,11 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-i INTERVAL] [-p]\n"
+"Usage: %s [-s SLICE_US] [-i INTERVAL] [-f] [-p]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -i INTERVAL   Report interval\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
@@ -149,6 +150,9 @@ int main(int argc, char **argv)
 		case 'd':
 			dump_cgrps = true;
 			break;
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			break;
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index 6302a4ea9ea5..d4528c7da450 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -2,11 +2,20 @@
 /*
  * A simple scheduler.
  *
- * A simple global FIFO scheduler. It also demonstrates the following niceties.
+ * By default, it operates as a simple global weighted vtime scheduler and can
+ * be switched to FIFO scheduling. It also demonstrates the following niceties.
  *
  * - Statistics tracking how many tasks are queued to local and global dsq's.
  * - Termination notification for userspace.
  *
+ * While very simple, this scheduler should work reasonably well on CPUs with a
+ * uniform L3 cache topology. While preemption is not implemented, the fact that
+ * the scheduling queue is shared across all CPUs means that whatever is at the
+ * front of the queue is likely to be executed fairly quickly given enough
+ * number of CPUs. The FIFO scheduling mode may be beneficial to some workloads
+ * but comes with the usual problems with FIFO scheduling where saturating
+ * threads can easily drown out interactive ones.
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
@@ -15,8 +24,10 @@
 
 char _license[] SEC("license") = "GPL";
 
+const volatile bool fifo_sched;
 const volatile bool switch_partial;
 
+static u64 vtime_now;
 struct user_exit_info uei;
 
 struct {
@@ -33,8 +44,18 @@ static void stat_inc(u32 idx)
 		(*cnt_p)++;
 }
 
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 {
+	/*
+	 * If scx_select_cpu_dfl() is setting %SCX_ENQ_LOCAL, it indicates that
+	 * running @p on its CPU directly shouldn't affect fairness. Just queue
+	 * it on the local FIFO.
+	 */
 	if (enq_flags & SCX_ENQ_LOCAL) {
 		stat_inc(0);	/* count local queueing */
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, enq_flags);
@@ -42,7 +63,52 @@ void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
 	}
 
 	stat_inc(1);	/* count global queueing */
-	scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+
+	if (fifo_sched) {
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
+	} else {
+		u64 vtime = p->scx.dsq_vtime;
+
+		/*
+		 * Limit the amount of budget that an idling task can accumulate
+		 * to one slice.
+		 */
+		if (vtime_before(vtime, vtime_now - SCX_SLICE_DFL))
+			vtime = vtime_now - SCX_SLICE_DFL;
+
+		scx_bpf_dispatch_vtime(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, vtime,
+				       enq_flags);
+	}
+}
+
+void BPF_STRUCT_OPS(simple_running, struct task_struct *p)
+{
+	if (fifo_sched)
+		return;
+
+	/*
+	 * Global vtime always progresses forward as tasks start executing. The
+	 * test and update can be performed concurrently from multiple CPUs and
+	 * thus racy. Any error should be contained and temporary. Let's just
+	 * live with it.
+	 */
+	if (vtime_before(vtime_now, p->scx.dsq_vtime))
+		vtime_now = p->scx.dsq_vtime;
+}
+
+void BPF_STRUCT_OPS(simple_stopping, struct task_struct *p, bool runnable)
+{
+	if (fifo_sched)
+		return;
+
+	/* scale the execution time by the inverse of the weight and charge */
+	p->scx.dsq_vtime += (SCX_SLICE_DFL - p->scx.slice) * 100 / p->scx.weight;
+}
+
+void BPF_STRUCT_OPS(simple_enable, struct task_struct *p,
+		    struct scx_enable_args *args)
+{
+	p->scx.dsq_vtime = vtime_now;
 }
 
 s32 BPF_STRUCT_OPS(simple_init)
@@ -60,6 +126,9 @@ void BPF_STRUCT_OPS(simple_exit, struct scx_exit_info *ei)
 SEC(".struct_ops.link")
 struct sched_ext_ops simple_ops = {
 	.enqueue		= (void *)simple_enqueue,
+	.running		= (void *)simple_running,
+	.stopping		= (void *)simple_stopping,
+	.enable			= (void *)simple_enable,
 	.init			= (void *)simple_init,
 	.exit			= (void *)simple_exit,
 	.name			= "simple",
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 1e507c0a35cd..4b2f0c16a9d1 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -19,8 +19,9 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-p]\n"
+"Usage: %s [-f] [-p]\n"
 "\n"
+"  -f            Use FIFO scheduling instead of weighted vtime scheduling\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -h            Display this help and exit\n";
 
@@ -65,8 +66,11 @@ int main(int argc, char **argv)
 	skel = scx_simple__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "ph")) != -1) {
+	while ((opt = getopt(argc, argv, "fph")) != -1) {
 		switch (opt) {
+		case 'f':
+			skel->rodata->fifo_sched = true;
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			break;
-- 
2.41.0

