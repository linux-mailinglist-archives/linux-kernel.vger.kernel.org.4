Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9136863D08B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiK3I0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiK3IZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2706328707;
        Wed, 30 Nov 2022 00:24:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so1215908pjh.2;
        Wed, 30 Nov 2022 00:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kh4NrL+dr0sdu1195cFhZBscorFNrhboBCZ/rmCbEHU=;
        b=PYx04NfZyFn6FYHHqEuXFBc9XpU78sr1/3nnZrnlgeQVZCNB4WT+Exb4nKDj84FXbV
         vyssL1SnRfEwaHJUfVl6dWgWrvQOk3bkn807Bzx2L8heKaUeHhY1Qkk6/uyEtqmJ7fmk
         AdtyPyiQIHQ4Xzp5CPr3eU+NoHp2ErzNVTnfb/d1DAZEL3SiJHkwkRxd4OHTEdOYtZSZ
         ydaLp3N181Lywg1LigB8vH5vQubpBgbxuFDAn2lTviS40TucHlUwubmXMETZ8g9Er8oU
         xVu9/7rAc/2X5jBmITlgI3406P8zOn3Lf46sk2AEXuBUmybZ37loiRNg7dSzggjXYZR6
         xiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kh4NrL+dr0sdu1195cFhZBscorFNrhboBCZ/rmCbEHU=;
        b=cPGWM/Xeqz84q42n3Rpmqes+JRZilECZUSatZYHwFRw0fHRbl0lLWOXYh4TarBRUZD
         BjBv8tOxEWCPJOiUPGTZo1UWVy7ETQ9/E//aec0sq0FvfnSG1wqRpXZWeNk64T5wp4G8
         O15jHm4Od16PXZ4t7aFaxMtJea4sacp72exqTLIJRGqJtlm3R02ebKR+8rAPw1CLZbXq
         oYB5cfwl7LcCfZb/W2FWSZLXjvxd2Fzjbvm/jHrcQyg7Cm1urlz/0dxLvr/cg6BauoHC
         A6ifFHbs//+53mT9r3wW9wjUk25GTiDQduYh4f8j7WXdc3aRh/q0mac3XQ/afwu0E8Ad
         +Cug==
X-Gm-Message-State: ANoB5pkXt0XBgv+/XLBX9VZ8yaUR/dhmCXnzGFnGN0BaBpfpdMcTTS4J
        6fn7XQ9XtofqCWT0oLWIw9M=
X-Google-Smtp-Source: AA0mqf4uOwbcXXp4YdqoIxlc0LtxMFtvW97TLx83nqFRy/KUP9fsHuEUzGOUkSPr4B640TsjdLllaA==
X-Received: by 2002:a17:90a:3d41:b0:213:d34:a80b with SMTP id o1-20020a17090a3d4100b002130d34a80bmr64370418pjf.74.1669796662290;
        Wed, 30 Nov 2022 00:24:22 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00186b55e3cd6sm769366plf.133.2022.11.30.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:21 -0800 (PST)
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
Subject: [PATCH 21/31] sched_ext: Implement scx_bpf_kick_cpu() and task preemption support
Date:   Tue, 29 Nov 2022 22:23:03 -1000
Message-Id: <20221130082313.3241517-22-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's often useful to wake up and/or trigger reschedule on other CPUs. This
patch adds scx_bpf_kick_cpu() kfunc helper that BPF scheduler can call to
kick the target CPU into the scheduling path.

As a sched_ext task relinquishes its CPU only after its slice is depleted,
this patch also adds SCX_KICK_PREEMPT and SCX_ENQ_PREEMPT which clears the
slice of the target CPU's current task to guarantee that sched_ext's
scheduling path runs on the CPU.

This patch also adds a new example scheduler, scx_example_central, which
demonstrates central scheduling where one CPU is responsible for making all
scheduling decisions in the system. The central CPU makes scheduling
decisions for all CPUs in the system, queues tasks on the appropriate local
dsq's and preempts the worker CPUs. The worker CPUs in turn preempt the
central CPU when it needs tasks to run.

Currently, every CPU depends on its own tick to expire the current task. A
follow-up patch implementing tickless support for sched_ext will allow the
worker CPUs to go full tickless so that they can run completely undisturbed.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h                 |   4 +
 kernel/sched/ext.c                        |  88 ++++++++-
 kernel/sched/ext.h                        |  12 ++
 kernel/sched/sched.h                      |   1 +
 tools/sched_ext/.gitignore                |   1 +
 tools/sched_ext/Makefile                  |   8 +-
 tools/sched_ext/scx_common.bpf.h          |   1 +
 tools/sched_ext/scx_example_central.bpf.c | 229 ++++++++++++++++++++++
 tools/sched_ext/scx_example_central.c     |  91 +++++++++
 9 files changed, 430 insertions(+), 5 deletions(-)
 create mode 100644 tools/sched_ext/scx_example_central.bpf.c
 create mode 100644 tools/sched_ext/scx_example_central.c

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 82dcbecfcfb9..6e25c3431bb4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -394,6 +394,10 @@ struct sched_ext_entity {
 	 * scx_bpf_dispatch() but can also be modified directly by the BPF
 	 * scheduler. Automatically decreased by SCX as the task executes. On
 	 * depletion, a scheduling event is triggered.
+	 *
+	 * This value is cleared to zero if the task is preempted by
+	 * %SCX_KICK_PREEMPT and shouldn't be used to determine how long the
+	 * task ran. Use p->se.sum_exec_runtime instead.
 	 */
 	u64			slice;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ba0a7a9ea5f2..4a98047a06bc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -404,7 +404,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 		}
 	}
 
-	if (enq_flags & SCX_ENQ_HEAD)
+	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
 		list_add(&p->scx.dsq_node, &dsq->fifo);
 	else
 		list_add_tail(&p->scx.dsq_node, &dsq->fifo);
@@ -420,8 +420,16 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 
 	if (is_local) {
 		struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
+		bool preempt = false;
 
-		if (sched_class_above(&ext_sched_class, rq->curr->sched_class))
+		if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
+		    rq->curr->sched_class == &ext_sched_class) {
+			rq->curr->scx.slice = 0;
+			preempt = true;
+		}
+
+		if (preempt || sched_class_above(&ext_sched_class,
+						 rq->curr->sched_class))
 			resched_curr(rq);
 	} else {
 		raw_spin_unlock(&dsq->lock);
@@ -1707,7 +1715,9 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
  * Omitted operations:
  *
  * - check_preempt_curr: NOOP as it isn't useful in the wakeup path because the
- *   task isn't tied to the CPU at that point.
+ *   task isn't tied to the CPU at that point. Preemption is implemented by
+ *   resetting the victim task's slice to 0 and triggering reschedule on the
+ *   target CPU.
  *
  * - migrate_task_rq: Unncessary as task to cpu mapping is transient.
  *
@@ -2564,6 +2574,34 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+#ifdef CONFIG_SMP
+static void kick_cpus_irq_workfn(struct irq_work *irq_work)
+{
+	struct rq *this_rq = this_rq();
+	int this_cpu = cpu_of(this_rq);
+	int cpu;
+
+	for_each_cpu(cpu, this_rq->scx.cpus_to_kick) {
+		struct rq *rq = cpu_rq(cpu);
+		unsigned long flags;
+
+		raw_spin_rq_lock_irqsave(rq, flags);
+
+		if (cpu_online(cpu) || cpu == this_cpu) {
+			if (cpumask_test_cpu(cpu, this_rq->scx.cpus_to_preempt) &&
+			    rq->curr->sched_class == &ext_sched_class)
+				rq->curr->scx.slice = 0;
+			resched_curr(rq);
+		}
+
+		raw_spin_rq_unlock_irqrestore(rq, flags);
+	}
+
+	cpumask_clear(this_rq->scx.cpus_to_kick);
+	cpumask_clear(this_rq->scx.cpus_to_preempt);
+}
+#endif
+
 void __init init_sched_ext_class(void)
 {
 	int cpu;
@@ -2587,6 +2625,11 @@ void __init init_sched_ext_class(void)
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
 		INIT_LIST_HEAD(&rq->scx.watchdog_list);
 		rq->scx.nr_running = 0;
+#ifdef CONFIG_SMP
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_kick, GFP_KERNEL));
+		BUG_ON(!zalloc_cpumask_var(&rq->scx.cpus_to_preempt, GFP_KERNEL));
+		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
+#endif
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
@@ -2772,6 +2815,44 @@ static const struct btf_kfunc_id_set scx_kfunc_set_consume = {
 	.set			= &scx_kfunc_ids_consume,
 };
 
+/**
+ * scx_bpf_kick_cpu - Trigger reschedule on a CPU
+ * @cpu: cpu to kick
+ * @flags: SCX_KICK_* flags
+ *
+ * Kick @cpu into rescheduling. This can be used to wake up an idle CPU or
+ * trigger rescheduling on a busy CPU. This can be called from any online
+ * scx_ops operation and the actual kicking is performed asynchronously through
+ * an irq work.
+ */
+void scx_bpf_kick_cpu(s32 cpu, u64 flags)
+{
+	if (!ops_cpu_valid(cpu)) {
+		scx_ops_error("invalid cpu %d", cpu);
+		return;
+	}
+#ifdef CONFIG_SMP
+	{
+		struct rq *rq;
+
+		preempt_disable();
+		rq = this_rq();
+
+		/*
+		 * Actual kicking is bounced to kick_cpus_irq_workfn() to avoid
+		 * nesting rq locks. We can probably be smarter and avoid
+		 * bouncing if called from ops which don't hold a rq lock.
+		 */
+		cpumask_set_cpu(cpu, rq->scx.cpus_to_kick);
+		if (flags & SCX_KICK_PREEMPT)
+			cpumask_set_cpu(cpu, rq->scx.cpus_to_preempt);
+
+		irq_work_queue(&rq->scx.kick_cpus_irq_work);
+		preempt_enable();
+	}
+#endif
+}
+
 /**
  * scx_bpf_dsq_nr_queued - Return the number of queued tasks
  * @dsq_id: id of the dsq
@@ -2845,6 +2926,7 @@ s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed)
 }
 
 BTF_SET8_START(scx_kfunc_ids_online)
+BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_test_and_clear_cpu_idle)
 BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 142dce30764d..3597b7b5829e 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -19,6 +19,14 @@ enum scx_enq_flags {
 
 	/* high 32bits are ext specific flags */
 
+	/*
+	 * Set the following to trigger preemption when calling
+	 * scx_bpf_dispatch() with a local dsq as the target. The slice of the
+	 * current task is cleared to zero and the CPU is kicked into the
+	 * scheduling path. Implies %SCX_ENQ_HEAD.
+	 */
+	SCX_ENQ_PREEMPT		= 1LLU << 32,
+
 	/*
 	 * The task being enqueued is the only task available for the cpu. By
 	 * default, ext core keeps executing such tasks but when
@@ -51,6 +59,10 @@ enum scx_deq_flags {
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
 };
 
+enum scx_kick_flags {
+	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
+};
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 
 struct sched_enq_and_set_ctx {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 40692fa7cb3c..0d8b52c52e2b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -698,6 +698,7 @@ struct scx_rq {
 #ifdef CONFIG_SMP
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
+	struct irq_work		kick_cpus_irq_work;
 #endif
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index 6734f7fd9324..389f0e5b0970 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,5 +1,6 @@
 scx_example_dummy
 scx_example_qmap
+scx_example_central
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index db99745e566d..d406b7586e08 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -114,7 +114,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_example_dummy scx_example_qmap
+all: scx_example_dummy scx_example_qmap scx_example_central
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -173,10 +173,14 @@ scx_example_qmap: scx_example_qmap.c scx_example_qmap.skel.h user_exit_info.h
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_example_central: scx_example_central.c scx_example_central.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_example_dummy scx_example_qmap
+	rm -f scx_example_dummy scx_example_qmap scx_example_central
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_common.bpf.h b/tools/sched_ext/scx_common.bpf.h
index 212cb934db2d..dc4d3f7b461f 100644
--- a/tools/sched_ext/scx_common.bpf.h
+++ b/tools/sched_ext/scx_common.bpf.h
@@ -53,6 +53,7 @@ extern s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 extern bool scx_bpf_consume(u64 dsq_id) __ksym;
 extern u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym;
+extern void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 extern s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 extern bool scx_bpf_test_and_clear_cpu_idle(s32 cpu) __ksym;
 extern s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed) __ksym;
diff --git a/tools/sched_ext/scx_example_central.bpf.c b/tools/sched_ext/scx_example_central.bpf.c
new file mode 100644
index 000000000000..f53ed4baf92d
--- /dev/null
+++ b/tools/sched_ext/scx_example_central.bpf.c
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A central FIFO sched_ext scheduler which demonstrates the followings:
+ *
+ * a. Making all scheduling decisions from one CPU:
+ *
+ *    The central CPU is the only one making scheduling decisions. All other
+ *    CPUs kick the central CPU when they run out of tasks to run.
+ *
+ *    There is one global BPF queue and the central CPU schedules all CPUs by
+ *    dispatching from the global queue to each CPU's local dsq from dispatch().
+ *    This isn't the most straight-forward. e.g. It'd be easier to bounce
+ *    through per-CPU BPF queues. The current design is chosen to maximally
+ *    utilize and verify various scx mechanisms such as LOCAL_ON dispatching and
+ *    consume_final().
+ *
+ * b. Preemption
+ *
+ *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
+ *    next tasks.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	FALLBACK_DSQ_ID		= 0,
+	MAX_CPUS		= 4096,
+	MS_TO_NS		= 1000LLU * 1000,
+	TIMER_INTERVAL_NS	= 1 * MS_TO_NS,
+};
+
+const volatile bool switch_all;
+const volatile s32 central_cpu;
+const volatile u32 nr_cpu_ids;
+
+u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
+u64 nr_dispatches, nr_mismatches, nr_overflows;
+
+struct user_exit_info uei;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, s32);
+} central_q SEC(".maps");
+
+/* can't use percpu map due to bad lookups */
+static bool cpu_gimme_task[MAX_CPUS];
+
+struct central_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct central_timer);
+} central_timer SEC(".maps");
+
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/*
+	 * Steer wakeups to the central CPU as much as possible to avoid
+	 * disturbing other CPUs. It's safe to blindly return the central cpu as
+	 * select_cpu() is a hint and if @p can't be on it, the kernel will
+	 * automatically pick a fallback CPU.
+	 */
+	return central_cpu;
+}
+
+void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	if (bpf_map_push_elem(&central_q, &pid, 0)) {
+		__sync_fetch_and_add(&nr_overflows, 1);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_queued, 1);
+
+	if (!scx_bpf_task_running(p))
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+}
+
+static int dispatch_a_task_loopfn(u32 idx, void *data)
+{
+	s32 cpu = *(s32 *)data;
+	s32 pid;
+	struct task_struct *p;
+	bool *gimme;
+
+	if (bpf_map_pop_elem(&central_q, &pid))
+		return 1;
+
+	__sync_fetch_and_sub(&nr_queued, 1);
+
+	p = scx_bpf_find_task_by_pid(pid);
+	if (!p) {
+		__sync_fetch_and_add(&nr_lost_pids, 1);
+		return 0;
+	}
+
+	/*
+	 * If we can't run the task at the top, do the dumb thing and bounce it
+	 * to the fallback dsq.
+	 */
+	if (!scx_bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+		__sync_fetch_and_add(&nr_mismatches, 1);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+		return 0;
+	}
+
+	/* dispatch to the local and mark that @cpu doesn't need more tasks */
+	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+
+	if (cpu != central_cpu)
+		scx_bpf_kick_cpu(cpu, 0);
+
+	gimme = MEMBER_VPTR(cpu_gimme_task, [cpu]);
+	if (gimme)
+		*gimme = false;
+
+	return 1;
+}
+
+static int dispatch_to_one_cpu_loopfn(u32 idx, void *data)
+{
+	s32 cpu = idx;
+
+	if (cpu >= 0 && cpu < MAX_CPUS) {
+		bool *gimme = MEMBER_VPTR(cpu_gimme_task, [cpu]);
+		if (gimme && !*gimme)
+			return 0;
+	}
+
+	bpf_loop(1 << 23, dispatch_a_task_loopfn, &cpu, 0);
+	return 0;
+}
+
+void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
+{
+	/* if out of tasks to run, gimme more */
+	if (!scx_bpf_dsq_nr_queued(FALLBACK_DSQ_ID)) {
+		bool *gimme = MEMBER_VPTR(cpu_gimme_task, [cpu]);
+		if (gimme)
+			*gimme = true;
+	}
+
+	if (cpu == central_cpu) {
+		/* we're the scheduling CPU, dispatch for every CPU */
+		__sync_fetch_and_add(&nr_dispatches, 1);
+		bpf_loop(nr_cpu_ids, dispatch_to_one_cpu_loopfn, NULL, 0);
+	} else {
+		/*
+		 * Force dispatch on the scheduling CPU so that it finds a task
+		 * to run for us.
+		 */
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+	}
+}
+
+void BPF_STRUCT_OPS(central_consume, s32 cpu)
+{
+	/*
+	 * When preempted, we want the central CPU to always run dispatch() as
+	 * soon as possible so that it can schedule other CPUs. Don't consume
+	 * the fallback dsq if central.
+	 */
+	if (cpu != central_cpu)
+		scx_bpf_consume(FALLBACK_DSQ_ID);
+}
+
+void BPF_STRUCT_OPS(central_consume_final, s32 cpu)
+{
+	/*
+	 * Now that the central CPU has dispatched, we can let it consume the
+	 * fallback dsq.
+	 */
+	if (cpu == central_cpu)
+		scx_bpf_consume(FALLBACK_DSQ_ID);
+}
+
+int BPF_STRUCT_OPS(central_init)
+{
+	if (switch_all)
+		scx_bpf_switch_all();
+
+	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+}
+
+void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops central_ops = {
+	/*
+	 * We are offloading all scheduling decisions to the central CPU and
+	 * thus being the last task on a given CPU doesn't mean anything
+	 * special. Enqueue the last tasks like any other tasks.
+	 */
+	.flags			= SCX_OPS_ENQ_LAST,
+
+	.select_cpu		= (void *)central_select_cpu,
+	.enqueue		= (void *)central_enqueue,
+	.dispatch		= (void *)central_dispatch,
+	.consume		= (void *)central_consume,
+	.consume_final		= (void *)central_consume_final,
+	.init			= (void *)central_init,
+	.exit			= (void *)central_exit,
+	.name			= "central",
+};
diff --git a/tools/sched_ext/scx_example_central.c b/tools/sched_ext/scx_example_central.c
new file mode 100644
index 000000000000..c85e84459c58
--- /dev/null
+++ b/tools/sched_ext/scx_example_central.c
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_central.skel.h"
+
+const char help_fmt[] =
+"A central FIFO sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-a] [-c CPU]\n"
+"\n"
+"  -a            Switch all tasks\n"
+"  -c CPU        Override the central CPU (default: 0)\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_central *skel;
+	struct bpf_link *link;
+	u64 seq = 0;
+	s32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_central__open();
+	assert(skel);
+
+	skel->rodata->central_cpu = 0;
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "ahc:")) != -1) {
+		switch (opt) {
+		case 'a':
+			skel->rodata->switch_all = true;
+			break;
+		case 'c':
+			skel->rodata->central_cpu = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	assert(!scx_example_central__load(skel));
+
+	link = bpf_map__attach_struct_ops(skel->maps.central_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %lu]\n", seq++);
+		printf("total:%10lu    local:%10lu   queued:%10lu     lost:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_locals,
+		       skel->bss->nr_queued,
+		       skel->bss->nr_lost_pids);
+		printf("                 dispatch:%10lu mismatch:%10lu overflow:%10lu\n",
+		       skel->bss->nr_dispatches,
+		       skel->bss->nr_mismatches,
+		       skel->bss->nr_overflows);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_central__destroy(skel);
+	return 0;
+}
-- 
2.38.1

