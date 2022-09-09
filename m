Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019625B3A27
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiIIOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiIIOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964815C9DB;
        Fri,  9 Sep 2022 07:00:15 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVXAtUhNfJ3olAOKgL1sk2xbobOhZtCTQq82WdvYMsI=;
        b=qVBOS0PkFveRFWy07QxtaPZUobgp31j+POL/b7IeDttCC+77ix56yGCBzZ8c5twJacoiqy
        8/AQSkEW7j4kN8EZ70D9JrQwkdU4/+zf0ouJ41hFhmMNILLv6J5dLeklzs61Amna7Qpgzq
        DJI3UsUtHH1FkEjnPEWIL7Pz7ctPyMfJoSizegkP5Vg3gSpzIgux6tNkScBfSCtvNsx8WC
        r/kSZ/uDnx8+5rTtyfDkk+ET4Wlr9hFh9AchfH99gIQjiHbGUaMUzyNsgTxBYoHEsiK+Co
        57n1Yruvf6hyUvULd6/pg8hqH/Ta9JZX1UkhaNZR+fCLEvn8G0/rroGFGy6rCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVXAtUhNfJ3olAOKgL1sk2xbobOhZtCTQq82WdvYMsI=;
        b=an8TCjEoeTcVVTdohwI2hmZa+g3KiPtBK90JNHs5qCSdUXvdmdcKEBVkL8ttLIJrZBynJT
        hT0Qmd8xyaX9okBA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220825164111.29534-8-zhouchengming@bytedance.com>
References: <20220825164111.29534-8-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273201263.401.14957314590742548008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/psi branch of tip:

Commit-ID:     52b1364ba0b105122d6de0e719b36db705011ac1
Gitweb:        https://git.kernel.org/tip/52b1364ba0b105122d6de0e719b36db705011ac1
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Fri, 26 Aug 2022 00:41:08 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:32 +02:00

sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ pressure

Now PSI already tracked workload pressure stall information for
CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
obvious impact on some workload productivity, such as web service
workload.

When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
from update_rq_clock_task(), in which we can record that delta
to CPU curr task's cgroups as PSI_IRQ_FULL status.

Note we don't use PSI_IRQ_SOME since IRQ/SOFTIRQ always happen in
the current task on the CPU, make nothing productive could run
even if it were runnable, so we only use PSI_IRQ_FULL.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lore.kernel.org/r/20220825164111.29534-8-zhouchengming@bytedance.com
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++-
 include/linux/psi_types.h               | 10 ++-
 kernel/cgroup/cgroup.c                  | 27 +++++++++-
 kernel/sched/core.c                     |  1 +-
 kernel/sched/psi.c                      | 74 +++++++++++++++++++++++-
 kernel/sched/stats.h                    |  2 +-
 6 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index be4a77b..971c418 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,6 +976,12 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+  irq.pressure
+	A read-write nested-keyed file.
+
+	Shows pressure stall information for IRQ/SOFTIRQ. See
+	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+
 Controllers
 ===========
 
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 54cb749..40c2817 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -42,7 +42,10 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES = 3,
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	PSI_IRQ,
+#endif
+	NR_PSI_RESOURCES,
 };
 
 /*
@@ -58,9 +61,12 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	PSI_IRQ_FULL,
+#endif
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES,
 };
 
 /* Use one bit in the state mask to track TSK_ONCPU */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 96aefdb..b46d39b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3763,6 +3763,23 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static int cgroup_irq_pressure_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+
+	return psi_show(seq, psi, PSI_IRQ);
+}
+
+static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes,
+					 loff_t off)
+{
+	return cgroup_pressure_write(of, buf, nbytes, PSI_IRQ);
+}
+#endif
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5179,6 +5196,16 @@ static struct cftype cgroup_base_files[] = {
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
 	},
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	{
+		.name = "irq.pressure",
+		.flags = CFTYPE_PRESSURE,
+		.seq_show = cgroup_irq_pressure_show,
+		.write = cgroup_irq_pressure_write,
+		.poll = cgroup_pressure_poll,
+		.release = cgroup_pressure_release,
+	},
+#endif
 #endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253..7d1ea92 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -708,6 +708,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
+	psi_account_irqtime(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 4702a77..2545a78 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -904,6 +904,36 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+void psi_account_irqtime(struct task_struct *task, u32 delta)
+{
+	int cpu = task_cpu(task);
+	void *iter = NULL;
+	struct psi_group *group;
+	struct psi_group_cpu *groupc;
+	u64 now;
+
+	if (!task->pid)
+		return;
+
+	now = cpu_clock(cpu);
+
+	while ((group = iterate_groups(task, &iter))) {
+		groupc = per_cpu_ptr(group->pcpu, cpu);
+
+		write_seqcount_begin(&groupc->seq);
+
+		record_times(groupc, now);
+		groupc->times[PSI_IRQ_FULL] += delta;
+
+		write_seqcount_end(&groupc->seq);
+
+		if (group->poll_states & (1 << PSI_IRQ_FULL))
+			psi_schedule_poll_work(group, 1);
+	}
+}
+#endif
+
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
@@ -1065,6 +1095,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
+	bool only_full = false;
 	int full;
 	u64 now;
 
@@ -1079,7 +1110,11 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2; full++) {
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	only_full = res == PSI_IRQ;
+#endif
+
+	for (full = 0; full < 2 - only_full; full++) {
 		unsigned long avg[3] = { 0, };
 		u64 total = 0;
 		int w;
@@ -1093,7 +1128,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		}
 
 		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
-			   full ? "full" : "some",
+			   full || only_full ? "full" : "some",
 			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
 			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
 			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
@@ -1121,6 +1156,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	else
 		return ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	if (res == PSI_IRQ && --state != PSI_IRQ_FULL)
+		return ERR_PTR(-EINVAL);
+#endif
+
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
@@ -1405,6 +1445,33 @@ static const struct proc_ops psi_cpu_proc_ops = {
 	.proc_release	= psi_fop_release,
 };
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static int psi_irq_show(struct seq_file *m, void *v)
+{
+	return psi_show(m, &psi_system, PSI_IRQ);
+}
+
+static int psi_irq_open(struct inode *inode, struct file *file)
+{
+	return psi_open(file, psi_irq_show);
+}
+
+static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
+			     size_t nbytes, loff_t *ppos)
+{
+	return psi_write(file, user_buf, nbytes, PSI_IRQ);
+}
+
+static const struct proc_ops psi_irq_proc_ops = {
+	.proc_open	= psi_irq_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_write	= psi_irq_write,
+	.proc_poll	= psi_fop_poll,
+	.proc_release	= psi_fop_release,
+};
+#endif
+
 static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
@@ -1412,6 +1479,9 @@ static int __init psi_proc_init(void)
 		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
 		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
 		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+		proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops);
+#endif
 	}
 	return 0;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index c39b467..84a1889 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,6 +110,7 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
+void psi_account_irqtime(struct task_struct *task, u32 delta);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -205,6 +206,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
+static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
