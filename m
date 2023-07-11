Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1674E349
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGKBRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGKBQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206EE1BE6;
        Mon, 10 Jul 2023 18:15:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89b75dc1cso40233865ad.1;
        Mon, 10 Jul 2023 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038117; x=1691630117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPIEXKu5UJ+erUCMfzf0H9Mrvb1ke/26gXd3iaHT4Tk=;
        b=V6OFTJ2vLWUldiF7iA5CkntTm53Xjp7rdoVg5zLjP0CtLL8Vrtk8CIpgYt9Vww7gao
         5fx26ezrJtPBs7p3/uN/5jxT9s2n6XrFODjdpGepeR37vJzqZEYiOnJ1E3EtF08LTn7v
         k1AKG2tJFVgySgshPXLVaEtWRKcFQaPXfIFrz94tdrWn1n2rvBl7AnnWtC8zfPrJ5R0u
         5PKtzN7B6cRADzTlytc+YNcrcrsuZ0hIN5Oei/fhefa7Kgs7j1O7JVSfluR2QWJ6HXvx
         6hZjdnXiZwv7V64FeepWRCsv/Q3zAVMWCe9Ke5ydn9fQ1I/E6E91tFV3OvByq22ZPIOw
         wZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038117; x=1691630117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPIEXKu5UJ+erUCMfzf0H9Mrvb1ke/26gXd3iaHT4Tk=;
        b=Y2cSaQBV0DELyoeTal1A/E3XZsvdW/KswFslvS1Na1MKdMt8zA6YTlK2n8nWPdhCD+
         nmytfm8BnFGN7gT/vD9CF+Wtp0tSkn6Q9g8k+HLIqLjxCoOtOZCo6+lEM65BCqqdEmTT
         AGLSFAj45lHrytm77+vMVc+winZeOZEmvW4fGO7Y8810accURn1K8DwtYFg2d5ja0cyL
         LnmhZXAiq0O5uDR2tN4vzLeMBE+LWuHyqTE15x2jDFFrFgCqbuSPiivUM7Z4GzkU4cyj
         yE0HKuXJPNrYNnlC5yZlIwoXZNwjlkzLaug2t7fyTr9CdOLA/UZWsY/E/mFE7H2jM6iT
         1ZQA==
X-Gm-Message-State: ABy/qLZVdSFcUKuhdmXpQ3dNo08eCS4x7ZWQ/+7NFUM4fXGW2N97GfLU
        3BxiUb7AyP5bPlf12THUbpE=
X-Google-Smtp-Source: APBJJlF68weKQ2OmpNZJCboqvTK7F1LDhE2VXX7TXxR7oySgioNIbAu1t0jxQUeLziFOHDTDj9OZnw==
X-Received: by 2002:a17:902:f681:b0:1b7:f99f:63ca with SMTP id l1-20020a170902f68100b001b7f99f63camr24652913plg.34.1689038116454;
        Mon, 10 Jul 2023 18:15:16 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902eac200b001b03a1a3151sm521439pld.70.2023.07.10.18.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:16 -0700 (PDT)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 30/34] sched_ext: Implement core-sched support
Date:   Mon, 10 Jul 2023 15:13:48 -1000
Message-ID: <20230711011412.100319-31-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core-sched support is composed of the following parts:

* task_struct->scx.core_sched_at is added. This is a timestamp which can be
  used to order tasks. Depending on whether the BPF scheduler implements
  custom ordering, it tracks either global FIFO ordering of all tasks or
  local-DSQ ordering within the dispatched tasks on a CPU.

* prio_less() is updated to call scx_prio_less() when comparing SCX tasks.
  scx_prio_less() calls ops.core_sched_before() if available or uses the
  core_sched_at timestamp. For global FIFO ordering, the BPF scheduler
  doesn't need to do anything. Otherwise, it should implement
  ops.core_sched_before() which reflects the ordering.

* When core-sched is enabled, balance_scx() balances all SMT siblings so
  that they all have tasks dispatched if necessary before pick_task_scx() is
  called. pick_task_scx() picks between the current task and the first
  dispatched task on the local DSQ based on availability and the
  core_sched_at timestamps. Note that FIFO ordering is expected among the
  already dispatched tasks whether running or on the local DSQ, so this path
  always compares core_sched_at instead of calling into
  ops.core_sched_before().

qmap_core_sched_before() is added to scx_qmap. It scales the
distances from the heads of the queues to compare the tasks across different
priority queues and seems to behave as expected.

v3: * Fixed build error when !CONFIG_SCHED_SMT reported by Andrea Righi.

v2: * Sched core added the const qualifiers to prio_less task arguments.
      Explicitly drop them for ops.core_sched_before() task arguments. BPF
      enforces access control through the verifier, so the qualifier isn't
      actually operative and only gets in the way when interacting with
      various helpers.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Reviewed-by: Josh Don <joshdon@google.com>
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/sched/ext.h      |  21 ++++
 kernel/Kconfig.preempt         |   2 +-
 kernel/sched/core.c            |  10 +-
 kernel/sched/ext.c             | 220 +++++++++++++++++++++++++++++++--
 kernel/sched/ext.h             |  13 ++
 tools/sched_ext/scx_qmap.bpf.c |  87 ++++++++++++-
 tools/sched_ext/scx_qmap.c     |   5 +-
 7 files changed, 341 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index c17957bd75df..9ef4c3a90199 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -316,6 +316,24 @@ struct sched_ext_ops {
 	 */
 	bool (*yield)(struct task_struct *from, struct task_struct *to);
 
+	/**
+	 * core_sched_before - Task ordering for core-sched
+	 * @a: task A
+	 * @b: task B
+	 *
+	 * Used by core-sched to determine the ordering between two tasks. See
+	 * Documentation/admin-guide/hw-vuln/core-scheduling.rst for details on
+	 * core-sched.
+	 *
+	 * Both @a and @b are runnable and may or may not currently be queued on
+	 * the BPF scheduler. Should return %true if @a should run before @b.
+	 * %false if there's no required ordering or @b should run before @a.
+	 *
+	 * If not specified, the default is ordering them according to when they
+	 * became runnable.
+	 */
+	bool (*core_sched_before)(struct task_struct *a,struct task_struct *b);
+
 	/**
 	 * set_weight - Set task weight
 	 * @p: task to set weight for
@@ -627,6 +645,9 @@ struct sched_ext_entity {
 	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic64_t		ops_state;
 	unsigned long		runnable_at;
+#ifdef CONFIG_SCHED_CORE
+	u64			core_sched_at;	/* see scx_prio_less() */
+#endif
 
 	/* BPF scheduler modifiable fields */
 
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 0afcda19bc50..e12a057ead7b 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -135,7 +135,7 @@ config SCHED_CORE
 
 config SCHED_CLASS_EXT
 	bool "Extensible Scheduling Class"
-	depends on BPF_SYSCALL && BPF_JIT && !SCHED_CORE
+	depends on BPF_SYSCALL && BPF_JIT
 	help
 	  This option enables a new scheduler class sched_ext (SCX), which
 	  allows scheduling policies to be implemented as BPF programs to
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 878e84694a6e..972996c05263 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -167,7 +167,10 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &idle_sched_class)
 		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
 
-	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+	if (task_on_scx(p))
+		return MAX_RT_PRIO + MAX_NICE + 1; /* 120, squash ext */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 119, squash fair */
 }
 
 /*
@@ -196,6 +199,11 @@ static inline bool prio_less(const struct task_struct *a,
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (pa == MAX_RT_PRIO + MAX_NICE + 1)	/* ext */
+		return scx_prio_less(a, b, in_fi);
+#endif
+
 	return false;
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e54d8c7d19a9..115d4d76cbc6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -529,6 +529,49 @@ static int ops_sanitize_err(const char *ops_name, s32 err)
 	return -EPROTO;
 }
 
+/**
+ * touch_core_sched - Update timestamp used for core-sched task ordering
+ * @rq: rq to read clock from, must be locked
+ * @p: task to update the timestamp for
+ *
+ * Update @p->scx.core_sched_at timestamp. This is used by scx_prio_less() to
+ * implement global or local-DSQ FIFO ordering for core-sched. Should be called
+ * when a task becomes runnable and its turn on the CPU ends (e.g. slice
+ * exhaustion).
+ */
+static void touch_core_sched(struct rq *rq, struct task_struct *p)
+{
+#ifdef CONFIG_SCHED_CORE
+	/*
+	 * It's okay to update the timestamp spuriously. Use
+	 * sched_core_disabled() which is cheaper than enabled().
+	 */
+	if (!sched_core_disabled())
+		p->scx.core_sched_at = rq_clock_task(rq);
+#endif
+}
+
+/**
+ * touch_core_sched_dispatch - Update core-sched timestamp on dispatch
+ * @rq: rq to read clock from, must be locked
+ * @p: task being dispatched
+ *
+ * If the BPF scheduler implements custom core-sched ordering via
+ * ops.core_sched_before(), @p->scx.core_sched_at is used to implement FIFO
+ * ordering within each local DSQ. This function is called from dispatch paths
+ * and updates @p->scx.core_sched_at if custom core-sched ordering is in effect.
+ */
+static void touch_core_sched_dispatch(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+	assert_clock_updated(rq);
+
+#ifdef CONFIG_SCHED_CORE
+	if (SCX_HAS_OP(core_sched_before))
+		touch_core_sched(rq, p);
+#endif
+}
+
 static void update_curr_scx(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
@@ -544,8 +587,11 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	if (curr->scx.slice != SCX_SLICE_INF)
+	if (curr->scx.slice != SCX_SLICE_INF) {
 		curr->scx.slice -= min(curr->scx.slice, delta_exec);
+		if (!curr->scx.slice)
+			touch_core_sched(rq, curr);
+	}
 }
 
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
@@ -701,6 +747,8 @@ static void direct_dispatch(struct task_struct *ddsp_task, struct task_struct *p
 		return;
 	}
 
+	touch_core_sched_dispatch(task_rq(p), p);
+
 	dsq = find_dsq_for_dispatch(task_rq(p), dsq_id, p);
 	dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
 
@@ -784,12 +832,19 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	return;
 
 local:
+	/*
+	 * For task-ordering, slice refill must be treated as implying the end
+	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
+	 * higher priority it becomes from scx_prio_less()'s POV.
+	 */
+	touch_core_sched(rq, p);
 	p->scx.slice = SCX_SLICE_DFL;
 local_norefill:
 	dispatch_enqueue(&rq->scx.local_dsq, p, enq_flags);
 	return;
 
 global:
+	touch_core_sched(rq, p);	/* see the comment in local: */
 	p->scx.slice = SCX_SLICE_DFL;
 	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
 }
@@ -846,6 +901,9 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (SCX_HAS_OP(runnable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
+	if (enq_flags & SCX_ENQ_WAKEUP)
+		touch_core_sched(rq, p);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
 
@@ -1296,6 +1354,7 @@ static void finish_dispatch(struct rq *rq, struct rq_flags *rf,
 	struct scx_dispatch_q *dsq;
 	u64 opss;
 
+	touch_core_sched_dispatch(rq, p);
 retry:
 	/*
 	 * No need for _acquire here. @p is accessed only after a successful
@@ -1373,8 +1432,8 @@ static void flush_dispatch_buf(struct rq *rq, struct rq_flags *rf)
 	dspc->buf_cursor = 0;
 }
 
-static int balance_scx(struct rq *rq, struct task_struct *prev,
-		       struct rq_flags *rf)
+static int balance_one(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf, bool local)
 {
 	struct scx_rq *scx_rq = &rq->scx;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(&scx_dsp_ctx);
@@ -1398,7 +1457,7 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	}
 
 	if (prev_on_scx) {
-		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
+		WARN_ON_ONCE(local && (prev->scx.flags & SCX_TASK_BAL_KEEP));
 		update_curr_scx(rq);
 
 		/*
@@ -1410,10 +1469,16 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * disabling() test.
+		 *
+		 * When balancing a remote CPU for core-sched, there won't be a
+		 * following put_prev_task_scx() call and we don't own
+		 * %SCX_TASK_BAL_KEEP. Instead, pick_task_scx() will test the
+		 * same conditions later and pick @rq->curr accordingly.
 		 */
 		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 		    prev->scx.slice && !scx_ops_disabling()) {
-			prev->scx.flags |= SCX_TASK_BAL_KEEP;
+			if (local)
+				prev->scx.flags |= SCX_TASK_BAL_KEEP;
 			return 1;
 		}
 	}
@@ -1469,10 +1534,56 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	return 0;
 }
 
+static int balance_scx(struct rq *rq, struct task_struct *prev,
+		       struct rq_flags *rf)
+{
+	int ret;
+
+	ret = balance_one(rq, prev, rf, true);
+
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * When core-sched is enabled, this ops.balance() call will be followed
+	 * by put_prev_scx() and pick_task_scx() on this CPU and pick_task_scx()
+	 * on the SMT siblings. Balance the siblings too.
+	 */
+	if (sched_core_enabled(rq)) {
+		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
+		int scpu;
+
+		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
+			struct rq *srq = cpu_rq(scpu);
+			struct rq_flags srf;
+			struct task_struct *sprev = srq->curr;
+
+			/*
+			 * While core-scheduling, rq lock is shared among
+			 * siblings but the debug annotations and rq clock
+			 * aren't. Do pinning dance to transfer the ownership.
+			 */
+			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
+			rq_unpin_lock(rq, rf);
+			rq_pin_lock(srq, &srf);
+
+			update_rq_clock(srq);
+			balance_one(srq, sprev, &srf, false);
+
+			rq_unpin_lock(srq, &srf);
+			rq_repin_lock(rq, rf);
+		}
+	}
+#endif
+	return ret;
+}
+
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
 	if (p->scx.flags & SCX_TASK_QUEUED) {
-		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		/*
+		 * Core-sched might decide to execute @p before it is
+		 * dispatched. Call ops_dequeue() to notify the BPF scheduler.
+		 */
+		ops_dequeue(p, SCX_DEQ_CORE_SCHED_EXEC);
 		dispatch_dequeue(&rq->scx, p);
 	}
 
@@ -1555,7 +1666,8 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 		/*
 		 * If @p has slice left and balance_scx() didn't tag it for
 		 * keeping, @p is getting preempted by a higher priority
-		 * scheduler class. Leave it at the head of the local DSQ.
+		 * scheduler class or core-sched forcing a different task. Leave
+		 * it at the head of the local DSQ.
 		 */
 		if (p->scx.slice && !scx_ops_disabling()) {
 			dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
@@ -1612,6 +1724,84 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 	return p;
 }
 
+#ifdef CONFIG_SCHED_CORE
+/**
+ * scx_prio_less - Task ordering for core-sched
+ * @a: task A
+ * @b: task B
+ *
+ * Core-sched is implemented as an additional scheduling layer on top of the
+ * usual sched_class'es and needs to find out the expected task ordering. For
+ * SCX, core-sched calls this function to interrogate the task ordering.
+ *
+ * Unless overridden by ops.core_sched_before(), @p->scx.core_sched_at is used
+ * to implement the default task ordering. The older the timestamp, the higher
+ * prority the task - the global FIFO ordering matching the default scheduling
+ * behavior.
+ *
+ * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
+ * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ */
+bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
+		   bool in_fi)
+{
+	/*
+	 * The const qualifiers are dropped from task_struct pointers when
+	 * calling ops.core_sched_before(). Accesses are controlled by the
+	 * verifier.
+	 */
+	if (SCX_HAS_OP(core_sched_before) && !scx_ops_disabling())
+		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, core_sched_before,
+					      (struct task_struct *)a,
+					      (struct task_struct *)b);
+	else
+		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
+}
+
+/**
+ * pick_task_scx - Pick a candidate task for core-sched
+ * @rq: rq to pick the candidate task from
+ *
+ * Core-sched calls this function on each SMT sibling to determine the next
+ * tasks to run on the SMT siblings. balance_one() has been called on all
+ * siblings and put_prev_task_scx() has been called only for the current CPU.
+ *
+ * As put_prev_task_scx() hasn't been called on remote CPUs, we can't just look
+ * at the first task in the local dsq. @rq->curr has to be considered explicitly
+ * to mimic %SCX_TASK_BAL_KEEP.
+ */
+static struct task_struct *pick_task_scx(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct task_struct *first = first_local_task(rq);
+
+	if (curr->scx.flags & SCX_TASK_QUEUED) {
+		/* is curr the only runnable task? */
+		if (!first)
+			return curr;
+
+		/*
+		 * Does curr trump first? We can always go by core_sched_at for
+		 * this comparison as it represents global FIFO ordering when
+		 * the default core-sched ordering is used and local-DSQ FIFO
+		 * ordering otherwise.
+		 *
+		 * We can have a task with an earlier timestamp on the DSQ. For
+		 * example, when a current task is preempted by a sibling
+		 * picking a different cookie, the task would be requeued at the
+		 * head of the local DSQ with an earlier timestamp than the
+		 * core-sched picked next task. Besides, the BPF scheduler may
+		 * dispatch any tasks to the local DSQ anytime.
+		 */
+		if (curr->scx.slice && time_before64(curr->scx.core_sched_at,
+						     first->scx.core_sched_at))
+			return curr;
+	}
+
+	return first;	/* this may be %NULL */
+}
+#endif	/* CONFIG_SCHED_CORE */
+
 static enum scx_cpu_preempt_reason
 preempt_reason_from_class(const struct sched_class *class)
 {
@@ -1921,11 +2111,13 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	update_curr_scx(rq);
 
 	/*
-	 * While disabling, always resched as we can't trust the slice
-	 * management.
+	 * While disabling, always resched and refresh core-sched timestamp as
+	 * we can't trust the slice management or ops.core_sched_before().
 	 */
-	if (scx_ops_disabling())
+	if (scx_ops_disabling()) {
 		curr->scx.slice = 0;
+		touch_core_sched(rq, curr);
+	}
 
 	if (!curr->scx.slice)
 		resched_curr(rq);
@@ -2388,6 +2580,10 @@ DEFINE_SCHED_CLASS(ext) = {
 	.rq_offline		= rq_offline_scx,
 #endif
 
+#ifdef CONFIG_SCHED_CORE
+	.pick_task		= pick_task_scx,
+#endif
+
 	.task_tick		= task_tick_scx,
 
 	.switching_to		= switching_to_scx,
@@ -2716,9 +2912,11 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	 *
 	 * b. balance_scx() never sets %SCX_TASK_BAL_KEEP as the slice value
 	 *    can't be trusted. Whenever a tick triggers, the running task is
-	 *    rotated to the tail of the queue.
+	 *    rotated to the tail of the queue with core_sched_at touched.
 	 *
 	 * c. pick_next_task() suppresses zero slice warning.
+	 *
+	 * d. scx_prio_less() reverts to the default core_sched_at order.
 	 */
 	scx_ops.enqueue = scx_ops_fallback_enqueue;
 	scx_ops.dispatch = scx_ops_fallback_dispatch;
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c71bf641f7a5..cd14970c239d 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -68,6 +68,14 @@ enum scx_enq_flags {
 enum scx_deq_flags {
 	/* expose select DEQUEUE_* flags as enums */
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
+
+	/* high 32bits are SCX specific */
+
+	/*
+	 * The generic core-sched layer decided to execute the task even though
+	 * it hasn't been dispatched yet. Dequeue from the BPF side.
+	 */
+	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
 };
 
 enum scx_pick_idle_cpu_flags {
@@ -193,6 +201,11 @@ static inline const struct sched_class *next_active_class(const struct sched_cla
 	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
 			       &ext_sched_class : (prev_class), (end_class))
 
+#ifdef CONFIG_SCHED_CORE
+bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
+		   bool in_fi);
+#endif
+
 #else	/* CONFIG_SCHED_CLASS_EXT */
 
 #define scx_enabled()		false
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index bfffbfd3368b..b6365df0fb64 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -13,6 +13,7 @@
  * - Sleepable per-task storage allocation using ops.prep_enable().
  * - Using ops.cpu_release() to handle a higher priority scheduling class taking
  *   the CPU away.
+ * - Core-sched support.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
  * features and unlikely to be useful for actual workloads.
@@ -62,9 +63,21 @@ struct {
 	},
 };
 
+/*
+ * Per-queue sequence numbers to implement core-sched ordering.
+ *
+ * Tail seq is assigned to each queued task and incremented. Head seq tracks the
+ * sequence number of the latest dispatched task. The distance between the a
+ * task's seq and the associated queue's head seq is called the queue distance
+ * and used when comparing two tasks for ordering. See qmap_core_sched_before().
+ */
+static u64 core_sched_head_seqs[5];
+static u64 core_sched_tail_seqs[5];
+
 /* Per-task scheduling context */
 struct task_ctx {
 	bool	force_local;	/* Dispatch directly to local_dsq */
+	u64	core_sched_seq;
 };
 
 struct {
@@ -84,6 +97,7 @@ struct {
 
 /* Statistics */
 unsigned long nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
+unsigned long nr_core_sched_execed;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -150,8 +164,18 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
-	/* Is select_cpu() is telling us to enqueue locally? */
-	if (tctx->force_local) {
+	/*
+	 * All enqueued tasks must have their core_sched_seq updated for correct
+	 * core-sched ordering, which is why %SCX_OPS_ENQ_LAST is specified in
+	 * qmap_ops.flags.
+	 */
+	tctx->core_sched_seq = core_sched_tail_seqs[idx]++;
+
+	/*
+	 * If qmap_select_cpu() is telling us to or this is the last runnable
+	 * task on the CPU, enqueue locally.
+	 */
+	if (tctx->force_local || (enq_flags & SCX_ENQ_LAST)) {
 		tctx->force_local = false;
 		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, slice_ns, enq_flags);
 		return;
@@ -195,6 +219,19 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 void BPF_STRUCT_OPS(qmap_dequeue, struct task_struct *p, u64 deq_flags)
 {
 	__sync_fetch_and_add(&nr_dequeued, 1);
+	if (deq_flags & SCX_DEQ_CORE_SCHED_EXEC)
+		__sync_fetch_and_add(&nr_core_sched_execed, 1);
+}
+
+static void update_core_sched_head_seq(struct task_struct *p)
+{
+	struct task_ctx *tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	int idx = weight_to_idx(p->scx.weight);
+
+	if (tctx)
+		core_sched_head_seqs[idx] = tctx->core_sched_seq;
+	else
+		scx_bpf_error("task_ctx lookup failed");
 }
 
 void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
@@ -247,6 +284,7 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 
 			p = bpf_task_from_pid(pid);
 			if (p) {
+				update_core_sched_head_seq(p);
 				__sync_fetch_and_add(&nr_dispatched, 1);
 				scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, slice_ns, 0);
 				bpf_task_release(p);
@@ -258,6 +296,49 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+/*
+ * The distance from the head of the queue scaled by the weight of the queue.
+ * The lower the number, the older the task and the higher the priority.
+ */
+static s64 task_qdist(struct task_struct *p)
+{
+	int idx = weight_to_idx(p->scx.weight);
+	struct task_ctx *tctx;
+	s64 qdist;
+
+	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
+	if (!tctx) {
+		scx_bpf_error("task_ctx lookup failed");
+		return 0;
+	}
+
+	qdist = tctx->core_sched_seq - core_sched_head_seqs[idx];
+
+	/*
+	 * As queue index increments, the priority doubles. The queue w/ index 3
+	 * is dispatched twice more frequently than 2. Reflect the difference by
+	 * scaling qdists accordingly. Note that the shift amount needs to be
+	 * flipped depending on the sign to avoid flipping priority direction.
+	 */
+	if (qdist >= 0)
+		return qdist << (4 - idx);
+	else
+		return qdist << idx;
+}
+
+/*
+ * This is called to determine the task ordering when core-sched is picking
+ * tasks to execute on SMT siblings and should encode about the same ordering as
+ * the regular scheduling path. Use the priority-scaled distances from the head
+ * of the queues to compare the two tasks which should be consistent with the
+ * dispatch path behavior.
+ */
+bool BPF_STRUCT_OPS(qmap_core_sched_before,
+		    struct task_struct *a, struct task_struct *b)
+{
+	return task_qdist(a) > task_qdist(b);
+}
+
 void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
 {
 	u32 cnt;
@@ -309,10 +390,12 @@ struct sched_ext_ops qmap_ops = {
 	.enqueue		= (void *)qmap_enqueue,
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
+	.core_sched_before	= (void *)qmap_core_sched_before,
 	.cpu_release		= (void *)qmap_cpu_release,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
+	.flags			= SCX_OPS_ENQ_LAST,
 	.timeout_ms		= 5000U,
 	.name			= "qmap",
 };
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index b47be72ee66e..0a02aa166b47 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -92,9 +92,10 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu, deq=%lu\n",
+		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu, deq=%lu, core=%lu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued);
+		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
+		       skel->bss->nr_core_sched_execed);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.41.0

