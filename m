Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3293374E340
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGKBRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjGKBQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:16 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED111736;
        Mon, 10 Jul 2023 18:15:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a3b7fafd61so4226315b6e.2;
        Mon, 10 Jul 2023 18:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038113; x=1691630113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4edjIUDP4JnZKWO/WsttWSlPIsV7n9ZBzXSToeDHOCk=;
        b=sUyi4O/m5kMg0jUg5k2uuWTgWjJwd6FXNErxRUrbrBMZAyL1Crnm9DC7fsEWMYjLOS
         WJTw89dLhE6Gpf54d7JoP7R8zUfybEJ2WbPjWs4uMp8re39qKCZXfsAvWyinD6XWaetI
         FinuY2GzPyph0NnEIltpKFgyqQYtQjj80rL+8AOeJWpi/pLlOSDJgujarMkTSg4Q6wXg
         daPXrIqd6HY/z7j3nHY/D5CEwP7EyR0HmG0YEWy/MDI2zSbWz3pfUuiziRupL6RRbiTV
         KCvZZsskazLVYSyfV7tdaCpKntcdG6LeT5ludH8whg9E28Q4TYtbliWFHDSGGguy5R0b
         GIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038113; x=1691630113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4edjIUDP4JnZKWO/WsttWSlPIsV7n9ZBzXSToeDHOCk=;
        b=ZyFI52DB8tL57lSsGusLyQkpQTXRKUFY/yYc4cNMpXEXVvHrXwg/DpdgXSY7JoxgTn
         rXLhJhODePpTZZtfOIrjPTjGUcK+KQIig8V4ycR8UwI64aTQWER0GXHRWmWuAFgxstkL
         RnN9r23GmlyUnLiHWuMEtgxxzOp2QJW5O/t5/Q4LqG6dffRFiQWareOGD4gzlbqHAv9O
         wpI2/LXdNVlQTQg6U3QOLATLecRncKPnApFQbGRCLg6PvW/Ik6UnvtYkFTeqPCnzOk7j
         nMIkqpAcErhF/1iETDltJcVSig1hABassTrTph+DLA76lIUKVQxvzZlP++v1UtB5R+bS
         prdA==
X-Gm-Message-State: ABy/qLaQPulO3S3x4+UQneoGYMA+ArtYKl3LQvlCbRg4ED8ewce28XuT
        KFVhgpTHdpf/LGJSAkKw3b4=
X-Google-Smtp-Source: APBJJlFWMKVfU9AEDiLlLE4baiWlUUGAFQ3+sHmIYIiBxvrdVIqqVup62VXvrcCy2LI3a+IYx+sidA==
X-Received: by 2002:a05:6358:5294:b0:134:eb97:ea01 with SMTP id g20-20020a056358529400b00134eb97ea01mr14685015rwa.27.1689038112536;
        Mon, 10 Jul 2023 18:15:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id x28-20020a656abc000000b00528da88275bsm269575pgu.47.2023.07.10.18.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:12 -0700 (PDT)
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
Subject: [PATCH 28/34] sched_ext: Implement sched_ext_ops.cpu_acquire/release()
Date:   Mon, 10 Jul 2023 15:13:46 -1000
Message-ID: <20230711011412.100319-29-tj@kernel.org>
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

From: David Vernet <dvernet@meta.com>

Scheduler classes are strictly ordered and when a higher priority class has
tasks to run, the lower priority ones lose access to the CPU. Being able to
monitor and act on these events are necessary for use cases includling
strict core-scheduling and latency management.

This patch adds two operations ops.cpu_acquire() and .cpu_release(). The
former is invoked when a CPU becomes available to the BPF scheduler and the
opposite for the latter. This patch also implements
scx_bpf_reenqueue_local() which can be called from .cpu_release() to trigger
requeueing of all tasks in the local dsq of the CPU so that the tasks can be
reassigned to other available CPUs.

scx_pair is updated to use .cpu_acquire/release() along with
%SCX_KICK_WAIT to make the pair scheduling guarantee strict even when a CPU
is preempted by a higher priority scheduler class.

scx_qmap is updated to use .cpu_acquire/release() to empty the local
dsq of a preempted CPU. A similar approach can be adopted by BPF schedulers
that want to have a tight control over latency.

v3: * Drop the const qualifier from scx_cpu_release_args.task. BPF enforces
      access control through the verifier, so the qualifier isn't actually
      operative and only gets in the way when interacting with various
      helpers.

v2: * Add p->scx.kf_mask annotation to allow calling
      scx_bpf_reenqueue_local() from ops.cpu_release() nested inside
      ops.init() and other sleepable operations.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h        |  53 ++++++++++++-
 kernel/sched/ext.c               | 131 ++++++++++++++++++++++++++++++-
 kernel/sched/ext.h               |  24 +++++-
 kernel/sched/sched.h             |   1 +
 tools/sched_ext/scx_common.bpf.h |   1 +
 tools/sched_ext/scx_pair.bpf.c   | 101 ++++++++++++++++++++++--
 tools/sched_ext/scx_qmap.bpf.c   |  37 ++++++++-
 tools/sched_ext/scx_qmap.c       |   4 +-
 8 files changed, 340 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 2d6da27bdd74..8a275ec05ee1 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -135,6 +135,32 @@ struct scx_cgroup_init_args {
 	u32			weight;
 };
 
+enum scx_cpu_preempt_reason {
+	/* next task is being scheduled by &sched_class_rt */
+        SCX_CPU_PREEMPT_RT,
+	/* next task is being scheduled by &sched_class_dl */
+        SCX_CPU_PREEMPT_DL,
+	/* next task is being scheduled by &sched_class_stop */
+        SCX_CPU_PREEMPT_STOP,
+	/* unknown reason for SCX being preempted */
+        SCX_CPU_PREEMPT_UNKNOWN,
+};
+
+/*
+ * Argument container for ops->cpu_acquire(). Currently empty, but may be
+ * expanded in the future.
+ */
+struct scx_cpu_acquire_args {};
+
+/* argument container for ops->cpu_release() */
+struct scx_cpu_release_args {
+	/* the reason the CPU was preempted */
+	enum scx_cpu_preempt_reason reason;
+
+	/* the task that's going to be scheduled on the CPU */
+	struct task_struct *task;
+};
+
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
@@ -329,6 +355,28 @@ struct sched_ext_ops {
 	 */
 	void (*update_idle)(s32 cpu, bool idle);
 
+	/**
+	 * cpu_acquire - A CPU is becoming available to the BPF scheduler
+	 * @cpu: The CPU being acquired by the BPF scheduler.
+	 * @args: Acquire arguments, see the struct definition.
+	 *
+	 * A CPU that was previously released from the BPF scheduler is now once
+	 * again under its control.
+	 */
+	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
+
+	/**
+	 * cpu_release - A CPU is taken away from the BPF scheduler
+	 * @cpu: The CPU being released by the BPF scheduler.
+	 * @args: Release arguments, see the struct definition.
+	 *
+	 * The specified CPU is no longer under the control of the BPF
+	 * scheduler. This could be because it was preempted by a higher
+	 * priority sched_class, though there may be other reasons as well. The
+	 * caller should consult @args->reason to determine the cause.
+	 */
+	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
+
 	/**
 	 * prep_enable - Prepare to enable BPF scheduling for a task
 	 * @p: task to prepare BPF scheduling for
@@ -533,12 +581,15 @@ enum scx_kf_mask {
 	/* all non-sleepables may be nested inside INIT and SLEEPABLE */
 	SCX_KF_INIT		= 1 << 0, /* running ops.init() */
 	SCX_KF_SLEEPABLE	= 1 << 1, /* other sleepable init operations */
+	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
+	SCX_KF_CPU_RELEASE	= 1 << 2, /* ops.cpu_release() */
 	/* ops.dequeue (in REST) may be nested inside DISPATCH */
 	SCX_KF_DISPATCH		= 1 << 3, /* ops.dispatch() */
 	SCX_KF_ENQUEUE		= 1 << 4, /* ops.enqueue() */
 	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
 
-	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH | SCX_KF_ENQUEUE | SCX_KF_REST,
+	__SCX_KF_RQ_LOCKED	= SCX_KF_CPU_RELEASE | SCX_KF_DISPATCH |
+				  SCX_KF_ENQUEUE | SCX_KF_REST,
 	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_REST,
 };
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 48a8881ff01f..1b83dddbdf10 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -83,6 +83,7 @@ static bool scx_warned_zero_slice;
 
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
+DEFINE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
 static DEFINE_STATIC_KEY_FALSE(scx_builtin_idle_enabled);
 
 struct static_key_false scx_has_op[SCX_NR_ONLINE_OPS] =
@@ -303,6 +304,12 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 	 * inside ops.dispatch(). We don't need to check the SCX_KF_SLEEPABLE
 	 * boundary thanks to the above in_interrupt() check.
 	 */
+	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
+		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
+		scx_ops_error("cpu_release kfunc called from a nested operation");
+		return false;
+	}
+
 	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
 		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
 		scx_ops_error("dispatch kfunc called from a nested operation");
@@ -1376,6 +1383,19 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 
 	lockdep_assert_rq_held(rq);
 
+	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
+	    unlikely(rq->scx.cpu_released)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in scx_notify_pick_next_task().
+		 */
+		if (SCX_HAS_OP(cpu_acquire))
+			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+		rq->scx.cpu_released = false;
+	}
+
 	if (prev_on_scx) {
 		WARN_ON_ONCE(prev->scx.flags & SCX_TASK_BAL_KEEP);
 		update_curr_scx(rq);
@@ -1383,7 +1403,9 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		/*
 		 * If @prev is runnable & has slice left, it has priority and
 		 * fetching more just increases latency for the fetched tasks.
-		 * Tell put_prev_task_scx() to put @prev on local_dsq.
+		 * Tell put_prev_task_scx() to put @prev on local_dsq. If the
+		 * BPF scheduler wants to handle this explicitly, it should
+		 * implement ->cpu_released().
 		 *
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * disabling() test.
@@ -1589,6 +1611,58 @@ static struct task_struct *pick_next_task_scx(struct rq *rq)
 	return p;
 }
 
+static enum scx_cpu_preempt_reason
+preempt_reason_from_class(const struct sched_class *class)
+{
+#ifdef CONFIG_SMP
+	if (class == &stop_sched_class)
+		return SCX_CPU_PREEMPT_STOP;
+#endif
+	if (class == &dl_sched_class)
+		return SCX_CPU_PREEMPT_DL;
+	if (class == &rt_sched_class)
+		return SCX_CPU_PREEMPT_RT;
+	return SCX_CPU_PREEMPT_UNKNOWN;
+}
+
+void __scx_notify_pick_next_task(struct rq *rq, struct task_struct *task,
+				 const struct sched_class *active)
+{
+	lockdep_assert_rq_held(rq);
+
+	/*
+	 * The callback is conceptually meant to convey that the CPU is no
+	 * longer under the control of SCX. Therefore, don't invoke the
+	 * callback if the CPU is is staying on SCX, or going idle (in which
+	 * case the SCX scheduler has actively decided not to schedule any
+	 * tasks on the CPU).
+	 */
+	if (likely(active >= &ext_sched_class))
+		return;
+
+	/*
+	 * At this point we know that SCX was preempted by a higher priority
+	 * sched_class, so invoke the ->cpu_release() callback if we have not
+	 * done so already. We only send the callback once between SCX being
+	 * preempted, and it regaining control of the CPU.
+	 *
+	 * ->cpu_release() complements ->cpu_acquire(), which is emitted the
+	 *  next time that balance_scx() is invoked.
+	 */
+	if (!rq->scx.cpu_released) {
+		if (SCX_HAS_OP(cpu_release)) {
+			struct scx_cpu_release_args args = {
+				.reason = preempt_reason_from_class(active),
+				.task = task,
+			};
+
+			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
+				    cpu_release, cpu_of(rq), &args);
+		}
+		rq->scx.cpu_released = true;
+	}
+}
+
 #ifdef CONFIG_SMP
 
 static bool test_and_clear_cpu_idle(int cpu)
@@ -2698,6 +2772,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 		static_branch_disable_cpuslocked(&scx_has_op[i]);
 	static_branch_disable_cpuslocked(&scx_ops_enq_last);
 	static_branch_disable_cpuslocked(&scx_ops_enq_exiting);
+	static_branch_disable_cpuslocked(&scx_ops_cpu_preempt);
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
@@ -2904,6 +2979,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	if (ops->flags & SCX_OPS_ENQ_EXITING)
 		static_branch_enable_cpuslocked(&scx_ops_enq_exiting);
+	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
+		static_branch_enable_cpuslocked(&scx_ops_cpu_preempt);
 
 	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
 		reset_idle_masks();
@@ -3584,6 +3661,56 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };
 
+/**
+ * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ *
+ * Iterate over all of the tasks currently enqueued on the local DSQ of the
+ * caller's CPU, and re-enqueue them in the BPF scheduler. Returns the number of
+ * processed tasks. Can only be called from ops.cpu_release().
+ */
+u32 scx_bpf_reenqueue_local(void)
+{
+	u32 nr_enqueued, i;
+	struct rq *rq;
+	struct scx_rq *scx_rq;
+
+	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
+		return 0;
+
+	rq = cpu_rq(smp_processor_id());
+	lockdep_assert_rq_held(rq);
+	scx_rq = &rq->scx;
+
+	/*
+	 * Get the number of tasks on the local DSQ before iterating over it to
+	 * pull off tasks. The enqueue callback below can signal that it wants
+	 * the task to stay on the local DSQ, and we want to prevent the BPF
+	 * scheduler from causing us to loop indefinitely.
+	 */
+	nr_enqueued = scx_rq->local_dsq.nr;
+	for (i = 0; i < nr_enqueued; i++) {
+		struct task_struct *p;
+
+		p = first_local_task(rq);
+		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
+		WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
+		WARN_ON_ONCE(p->scx.holding_cpu != -1);
+		dispatch_dequeue(scx_rq, p);
+		do_enqueue_task(rq, p, SCX_ENQ_REENQ, -1);
+	}
+
+	return nr_enqueued;
+}
+
+BTF_SET8_START(scx_kfunc_ids_cpu_release)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
+BTF_SET8_END(scx_kfunc_ids_cpu_release)
+
+static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
+	.owner			= THIS_MODULE,
+	.set			= &scx_kfunc_ids_cpu_release,
+};
+
 /**
  * scx_bpf_kick_cpu - Trigger reschedule on a CPU
  * @cpu: cpu to kick
@@ -3968,6 +4095,8 @@ static int __init register_ext_kfuncs(void)
 					     &scx_kfunc_set_enqueue_dispatch)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_dispatch)) ||
+	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					     &scx_kfunc_set_cpu_release)) ||
 	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					     &scx_kfunc_set_any))) {
 		pr_err("sched_ext: failed to register kfunc sets (%d)\n", ret);
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index abb283ac3bc7..c71bf641f7a5 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -27,6 +27,17 @@ enum scx_enq_flags {
 	 */
 	SCX_ENQ_PREEMPT		= 1LLU << 32,
 
+	/*
+	 * The task being enqueued was previously enqueued on the current CPU's
+	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
+	 * bpf_scx_reenqueue_local() kfunc. If bpf_scx_reenqueue_local() was
+	 * invoked in a ->cpu_release() callback, and the task is again
+	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
+	 * task will not be scheduled on the CPU until at least the next invocation
+	 * of the ->cpu_acquire() callback.
+	 */
+	SCX_ENQ_REENQ		= 1LLU << 40,
+
 	/*
 	 * The task being enqueued is the only task available for the cpu. By
 	 * default, ext core keeps executing such tasks but when
@@ -97,6 +108,8 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
 #define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
 
+DECLARE_STATIC_KEY_FALSE(scx_ops_cpu_preempt);
+
 static inline bool task_on_scx(struct task_struct *p)
 {
 	return scx_enabled() && p->sched_class == &ext_sched_class;
@@ -116,13 +129,17 @@ __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
 #define scx_ops_error(fmt, args...)						\
 	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
 
+void __scx_notify_pick_next_task(struct rq *rq,
+				 struct task_struct *p,
+				 const struct sched_class *active);
+
 static inline void scx_notify_pick_next_task(struct rq *rq,
-					     const struct task_struct *p,
+					     struct task_struct *p,
 					     const struct sched_class *active)
 {
-#ifdef CONFIG_SMP
 	if (!scx_enabled())
 		return;
+#ifdef CONFIG_SMP
 	/*
 	 * Pairs with the smp_load_acquire() issued by a CPU in
 	 * kick_cpus_irq_workfn() who is waiting for this CPU to perform a
@@ -130,6 +147,9 @@ static inline void scx_notify_pick_next_task(struct rq *rq,
 	 */
 	smp_store_release(&rq->scx.pnt_seq, rq->scx.pnt_seq + 1);
 #endif
+	if (!static_branch_unlikely(&scx_ops_cpu_preempt))
+		return;
+	__scx_notify_pick_next_task(rq, p, active);
 }
 
 static inline void scx_notify_sched_tick(void)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ce6e0a73135b..e7b15bd7adbc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -708,6 +708,7 @@ struct scx_rq {
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			flags;
+	bool			cpu_released;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 4f8e447f66d3..8a210ab0eaab 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -70,6 +70,7 @@ void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
+u32 scx_bpf_reenqueue_local(void) __ksym;
 
 #define BPF_STRUCT_OPS(name, args...)						\
 SEC("struct_ops/"#name)								\
diff --git a/tools/sched_ext/scx_pair.bpf.c b/tools/sched_ext/scx_pair.bpf.c
index f980d301dbbe..cda126980ed5 100644
--- a/tools/sched_ext/scx_pair.bpf.c
+++ b/tools/sched_ext/scx_pair.bpf.c
@@ -89,6 +89,28 @@
  * be resolved in the near future which should allow greatly simplifying this
  * scheduler.
  *
+ * Dealing with preemption
+ * -----------------------
+ *
+ * SCX is the lowest priority sched_class, and could be preempted by them at
+ * any time. To address this, the scheduler implements pair_cpu_release() and
+ * pair_cpu_acquire() callbacks which are invoked by the core scheduler when
+ * the scheduler loses and gains control of the CPU respectively.
+ *
+ * In pair_cpu_release(), we mark the pair_ctx as having been preempted, and
+ * then invoke:
+ *
+ * scx_bpf_kick_cpu(pair_cpu, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
+ *
+ * This preempts the pair CPU, and waits until it has re-entered the scheduler
+ * before returning. This is necessary to ensure that the higher priority
+ * sched_class that preempted our scheduler does not schedule a task
+ * concurrently with our pair CPU.
+ *
+ * When the CPU is re-acquired in pair_cpu_acquire(), we unmark the preemption
+ * in the pair_ctx, and send another resched IPI to the pair CPU to re-enable
+ * pair scheduling.
+ *
  * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
  * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
  * Copyright (c) 2022 David Vernet <dvernet@meta.com>
@@ -129,6 +151,12 @@ struct pair_ctx {
 
 	/* the CPUs that are currently active on the cgroup */
 	u32			active_mask;
+
+	/*
+	 * the CPUs that are currently preempted and running tasks in a
+	 * different scheduler.
+	 */
+	u32			preempted_mask;
 };
 
 struct {
@@ -295,7 +323,7 @@ static int try_dispatch(s32 cpu)
 	struct task_struct *p;
 	u64 now = bpf_ktime_get_ns();
 	bool kick_pair = false;
-	bool expired;
+	bool expired, pair_preempted;
 	u32 *vptr, in_pair_mask;
 	s32 pid, q_idx;
 	u64 cgid;
@@ -324,10 +352,14 @@ static int try_dispatch(s32 cpu)
 		 */
 		pairc->draining = true;
 
-		if (pairc->active_mask) {
+		pair_preempted = pairc->preempted_mask;
+		if (pairc->active_mask || pair_preempted) {
 			/*
-			 * The other CPU is still active We want to wait until
-			 * this cgroup expires.
+			 * The other CPU is still active, or is no longer under
+			 * our control due to e.g. being preempted by a higher
+			 * priority sched_class. We want to wait until this
+			 * cgroup expires, or until control of our pair CPU has
+			 * been returned to us.
 			 *
 			 * If the pair controls its CPU, and the time already
 			 * expired, kick.  When the other CPU arrives at
@@ -336,7 +368,7 @@ static int try_dispatch(s32 cpu)
 			 */
 			__sync_fetch_and_add(&nr_exp_waits, 1);
 			bpf_spin_unlock(&pairc->lock);
-			if (expired)
+			if (expired && !pair_preempted)
 				kick_pair = true;
 			goto out_maybe_kick;
 		}
@@ -475,6 +507,63 @@ void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(pair_cpu_acquire, s32 cpu, struct scx_cpu_acquire_args *args)
+{
+	int ret;
+	u32 in_pair_mask;
+	struct pair_ctx *pairc;
+	bool kick_pair;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret)
+		return;
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->preempted_mask &= ~in_pair_mask;
+	/* Kick the pair CPU, unless it was also preempted. */
+	kick_pair = !pairc->preempted_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	if (kick_pair) {
+		s32 *pair = (s32 *)MEMBER_VPTR(pair_cpu, [cpu]);
+
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+}
+
+void BPF_STRUCT_OPS(pair_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+{
+	int ret;
+	u32 in_pair_mask;
+	struct pair_ctx *pairc;
+	bool kick_pair;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret)
+		return;
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->preempted_mask |= in_pair_mask;
+	pairc->active_mask &= ~in_pair_mask;
+	/* Kick the pair CPU if it's still running. */
+	kick_pair = pairc->active_mask;
+	pairc->draining = true;
+	bpf_spin_unlock(&pairc->lock);
+
+	if (kick_pair) {
+		s32 *pair = (s32 *)MEMBER_VPTR(pair_cpu, [cpu]);
+
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT | SCX_KICK_WAIT);
+		}
+	}
+	__sync_fetch_and_add(&nr_preemptions, 1);
+}
+
 s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
 {
 	u64 cgid = cgrp->kn->id;
@@ -528,6 +617,8 @@ SEC(".struct_ops.link")
 struct sched_ext_ops pair_ops = {
 	.enqueue		= (void *)pair_enqueue,
 	.dispatch		= (void *)pair_dispatch,
+	.cpu_acquire		= (void *)pair_cpu_acquire,
+	.cpu_release		= (void *)pair_cpu_release,
 	.cgroup_init		= (void *)pair_cgroup_init,
 	.cgroup_exit		= (void *)pair_cgroup_exit,
 	.init			= (void *)pair_init,
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 1c3a7d050e32..bfffbfd3368b 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -11,6 +11,8 @@
  *
  * - BPF-side queueing using PIDs.
  * - Sleepable per-task storage allocation using ops.prep_enable().
+ * - Using ops.cpu_release() to handle a higher priority scheduling class taking
+ *   the CPU away.
  *
  * This scheduler is primarily for demonstration and testing of sched_ext
  * features and unlikely to be useful for actual workloads.
@@ -81,7 +83,7 @@ struct {
 } dispatch_idx_cnt SEC(".maps");
 
 /* Statistics */
-unsigned long nr_enqueued, nr_dispatched, nr_dequeued;
+unsigned long nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -155,6 +157,22 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 		return;
 	}
 
+	/*
+	 * If the task was re-enqueued due to the CPU being preempted by a
+	 * higher priority scheduling class, just re-enqueue the task directly
+	 * on the global DSQ. As we want another CPU to pick it up, find and
+	 * kick an idle CPU.
+	 */
+	if (enq_flags & SCX_ENQ_REENQ) {
+		s32 cpu;
+
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, 0, enq_flags);
+		cpu = scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
+		if (cpu >= 0)
+			scx_bpf_kick_cpu(cpu, 0);
+		return;
+	}
+
 	ring = bpf_map_lookup_elem(&queue_arr, &idx);
 	if (!ring) {
 		scx_bpf_error("failed to find ring %d", idx);
@@ -240,6 +258,22 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(qmap_cpu_release, s32 cpu, struct scx_cpu_release_args *args)
+{
+	u32 cnt;
+
+	/*
+	 * Called when @cpu is taken by a higher priority scheduling class. This
+	 * makes @cpu no longer available for executing sched_ext tasks. As we
+	 * don't want the tasks in @cpu's local dsq to sit there until @cpu
+	 * becomes available again, re-enqueue them into the global dsq. See
+	 * %SCX_ENQ_REENQ handling in qmap_enqueue().
+	 */
+	cnt = scx_bpf_reenqueue_local();
+	if (cnt)
+		__sync_fetch_and_add(&nr_reenqueued, cnt);
+}
+
 s32 BPF_STRUCT_OPS(qmap_prep_enable, struct task_struct *p,
 		   struct scx_enable_args *args)
 {
@@ -275,6 +309,7 @@ struct sched_ext_ops qmap_ops = {
 	.enqueue		= (void *)qmap_enqueue,
 	.dequeue		= (void *)qmap_dequeue,
 	.dispatch		= (void *)qmap_dispatch,
+	.cpu_release		= (void *)qmap_cpu_release,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.init			= (void *)qmap_init,
 	.exit			= (void *)qmap_exit,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 805ac453698f..b47be72ee66e 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -92,9 +92,9 @@ int main(int argc, char **argv)
 		long nr_enqueued = skel->bss->nr_enqueued;
 		long nr_dispatched = skel->bss->nr_dispatched;
 
-		printf("enq=%lu, dsp=%lu, delta=%ld, deq=%lu\n",
+		printf("enq=%lu, dsp=%lu, delta=%ld, reenq=%lu, deq=%lu\n",
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
-		       skel->bss->nr_dequeued);
+		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.41.0

