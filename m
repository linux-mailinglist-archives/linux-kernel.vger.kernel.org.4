Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFC05B3A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIIOAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiIIOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:00:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7703476DC;
        Fri,  9 Sep 2022 07:00:12 -0700 (PDT)
Date:   Fri, 09 Sep 2022 14:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662732010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7smrwQ19LpwwiVsB7wGpY2axSdESsM6ShvmkkDmaIc=;
        b=htU0cAC1oQvRs9U8t9rnqJw9BEvehizsBMbV5zkRixTX+/yeY86XqVIxaK5dxs9Emm4YQr
        3nSDlLC8syvog2YlvtPldcWmAjGOE9QtHL6OQgMCnIRYrix+Z+bi3eGP5iJU+mzVJ3Fkre
        5E8+SQK8wWDd8aQB6k2VsQ8zJLOpzE/26AQeT1k8IMOZm9bvWuxcEBrqCqfcJPB7eKpdxu
        bgRWo0orNKTbFp6wTdOvQ1su9D8lqD6xGZfgrvcUqrX7rTIoGlwgIOYF7FODwJxlmrHVpq
        NERZWDVvLvNqy8GoWCq6UNNXNaaSbR8ixVNy1b3SIxz8eqU8EUiZHlL1H4028w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662732010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7smrwQ19LpwwiVsB7wGpY2axSdESsM6ShvmkkDmaIc=;
        b=+YZvgMuQ6zfMXRg34fOzh8jmIIa4ySRVv82Wvz9BNu0mC0mgtZynuhFvktvl4NxDJpygFY
        /zFQ5Wx8xl2Ar1DQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/psi] sched/psi: Per-cgroup PSI accounting
 disable/re-enable interface
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220907090332.2078-1-zhouchengming@bytedance.com>
References: <20220907090332.2078-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <166273200914.401.5856219859539168533.tip-bot2@tip-bot2>
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

Commit-ID:     34f26a15611afb03c33df6819359d36f5b382589
Gitweb:        https://git.kernel.org/tip/34f26a15611afb03c33df6819359d36f5b382589
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 07 Sep 2022 17:03:32 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Sep 2022 11:08:33 +02:00

sched/psi: Per-cgroup PSI accounting disable/re-enable interface

PSI accounts stalls for each cgroup separately and aggregates it
at each level of the hierarchy. This may cause non-negligible overhead
for some workloads when under deep level of the hierarchy.

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI to skip per-cgroup stall accounting, only account system-wide
to avoid this each level overhead.

But for our use case, we also want leaf cgroup PSI stats accounted for
userspace adjustment on that cgroup, apart from only system-wide adjustment.

So this patch introduce a per-cgroup PSI accounting disable/re-enable
interface "cgroup.pressure", which is a read-write single value file that
allowed values are "0" and "1", the defaults is "1" so per-cgroup
PSI stats is enabled by default.

Implementation details:

It should be relatively straight-forward to disable and re-enable
state aggregation, time tracking, averaging on a per-cgroup level,
if we can live with losing history from while it was disabled.
I.e. the avgs will restart from 0, total= will have gaps.

But it's hard or complex to stop/restart groupc->tasks[] updates,
which is not implemented in this patch. So we always update
groupc->tasks[] and PSI_ONCPU bit in psi_group_change() even when
the cgroup PSI stats is disabled.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20220907090332.2078-1-zhouchengming@bytedance.com
---
 Documentation/admin-guide/cgroup-v2.rst | 17 ++++++-
 include/linux/cgroup-defs.h             |  3 +-
 include/linux/psi.h                     |  2 +-
 include/linux/psi_types.h               |  3 +-
 kernel/cgroup/cgroup.c                  | 70 +++++++++++++++++++++---
 kernel/sched/psi.c                      | 70 +++++++++++++++++++++---
 6 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 971c418..4cad4e2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,6 +976,23 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+  cgroup.pressure
+	A read-write single value file that allowed values are "0" and "1".
+	The default is "1".
+
+	Writing "0" to the file will disable the cgroup PSI accounting.
+	Writing "1" to the file will re-enable the cgroup PSI accounting.
+
+	This control attribute is not hierarchical, so disable or enable PSI
+	accounting in a cgroup does not affect PSI accounting in descendants
+	and doesn't need pass enablement via ancestors from root.
+
+	The reason this control attribute exists is that PSI accounts stalls for
+	each cgroup separately and aggregates it at each level of the hierarchy.
+	This may cause non-negligible overhead for some workloads when under
+	deep level of the hierarchy, in which case this control attribute can
+	be used to disable PSI accounting in the non-leaf cgroups.
+
   irq.pressure
 	A read-write nested-keyed file.
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 4bcf56b..7df76b3 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -428,6 +428,9 @@ struct cgroup {
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
 
+	/* handles for "{cpu,memory,io,irq}.pressure" */
+	struct cgroup_file psi_files[NR_PSI_RESOURCES];
+
 	/*
 	 * The bitmask of subsystems enabled on the child cgroups.
 	 * ->subtree_control is the one configured through
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 362a74c..b029a84 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -39,6 +39,7 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
 void cgroup_move_task(struct task_struct *p, struct css_set *to);
+void psi_cgroup_restart(struct psi_group *group);
 #endif
 
 #else /* CONFIG_PSI */
@@ -60,6 +61,7 @@ static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
 {
 	rcu_assign_pointer(p->cgroups, to);
 }
+static inline void psi_cgroup_restart(struct psi_group *group) {}
 #endif
 
 #endif /* CONFIG_PSI */
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index a0b7462..6e43727 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -152,6 +152,7 @@ struct psi_trigger {
 
 struct psi_group {
 	struct psi_group *parent;
+	bool enabled;
 
 	/* Protects data used by the aggregator */
 	struct mutex avgs_lock;
@@ -194,6 +195,8 @@ struct psi_group {
 
 #else /* CONFIG_PSI */
 
+#define NR_PSI_RESOURCES	0
+
 struct psi_group { };
 
 #endif /* CONFIG_PSI */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 772b35d..fa1cf83 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3708,8 +3708,8 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 	return psi_show(seq, psi, PSI_CPU);
 }
 
-static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
-					  size_t nbytes, enum psi_res res)
+static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, enum psi_res res)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 	struct psi_trigger *new;
@@ -3746,21 +3746,21 @@ static ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_IO);
+	return pressure_write(of, buf, nbytes, PSI_IO);
 }
 
 static ssize_t cgroup_memory_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_MEM);
+	return pressure_write(of, buf, nbytes, PSI_MEM);
 }
 
 static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
+	return pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -3776,10 +3776,58 @@ static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
 					 char *buf, size_t nbytes,
 					 loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_IRQ);
+	return pressure_write(of, buf, nbytes, PSI_IRQ);
 }
 #endif
 
+static int cgroup_pressure_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_psi(cgrp);
+
+	seq_printf(seq, "%d\n", psi->enabled);
+
+	return 0;
+}
+
+static ssize_t cgroup_pressure_write(struct kernfs_open_file *of,
+				     char *buf, size_t nbytes,
+				     loff_t off)
+{
+	ssize_t ret;
+	int enable;
+	struct cgroup *cgrp;
+	struct psi_group *psi;
+
+	ret = kstrtoint(strstrip(buf), 0, &enable);
+	if (ret)
+		return ret;
+
+	if (enable < 0 || enable > 1)
+		return -ERANGE;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+
+	psi = cgroup_psi(cgrp);
+	if (psi->enabled != enable) {
+		int i;
+
+		/* show or hide {cpu,memory,io,irq}.pressure files */
+		for (i = 0; i < NR_PSI_RESOURCES; i++)
+			cgroup_file_show(&cgrp->psi_files[i], enable);
+
+		psi->enabled = enable;
+		if (enable)
+			psi_cgroup_restart(psi);
+	}
+
+	cgroup_kn_unlock(of->kn);
+
+	return nbytes;
+}
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5175,6 +5223,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "io.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5183,6 +5232,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "memory.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5191,6 +5241,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "cpu.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5200,12 +5251,19 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "irq.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
 	},
 #endif
+	{
+		.name = "cgroup.pressure",
+		.flags = CFTYPE_PRESSURE,
+		.seq_show = cgroup_pressure_show,
+		.write = cgroup_pressure_write,
+	},
 #endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9a8aee8..9711827 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -181,6 +181,7 @@ static void group_init(struct psi_group *group)
 {
 	int cpu;
 
+	group->enabled = true;
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
@@ -696,17 +697,16 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
-	 * First we assess the aggregate resource states this CPU's
-	 * tasks have been in since the last change, and account any
-	 * SOME and FULL time these may have resulted in.
-	 *
-	 * Then we update the task counts according to the state
+	 * First we update the task counts according to the state
 	 * change requested through the @clear and @set bits.
+	 *
+	 * Then if the cgroup PSI stats accounting enabled, we
+	 * assess the aggregate resource states this CPU's tasks
+	 * have been in since the last change, and account any
+	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, now);
-
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
 	 * task count - it's just a boolean flag directly encoded in
@@ -745,6 +745,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
+	if (!group->enabled) {
+		/*
+		 * On the first group change after disabling PSI, conclude
+		 * the current state and flush its time. This is unlikely
+		 * to matter to the user, but aggregation (get_recent_times)
+		 * may have already incorporated the live state into times_prev;
+		 * avoid a delta sample underflow when PSI is later re-enabled.
+		 */
+		if (unlikely(groupc->state_mask & (1 << PSI_NONIDLE)))
+			record_times(groupc, now);
+
+		groupc->state_mask = state_mask;
+
+		write_seqcount_end(&groupc->seq);
+		return;
+	}
+
 	for (s = 0; s < NR_PSI_STATES; s++) {
 		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
 			state_mask |= (1 << s);
@@ -761,6 +778,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
+	record_times(groupc, now);
+
 	groupc->state_mask = state_mask;
 
 	write_seqcount_end(&groupc->seq);
@@ -907,6 +926,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 	group = task_psi_group(task);
 	do {
+		if (!group->enabled)
+			continue;
+
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
@@ -1080,6 +1102,40 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	task_rq_unlock(rq, task, &rf);
 }
+
+void psi_cgroup_restart(struct psi_group *group)
+{
+	int cpu;
+
+	/*
+	 * After we disable psi_group->enabled, we don't actually
+	 * stop percpu tasks accounting in each psi_group_cpu,
+	 * instead only stop test_state() loop, record_times()
+	 * and averaging worker, see psi_group_change() for details.
+	 *
+	 * When disable cgroup PSI, this function has nothing to sync
+	 * since cgroup pressure files are hidden and percpu psi_group_cpu
+	 * would see !psi_group->enabled and only do task accounting.
+	 *
+	 * When re-enable cgroup PSI, this function use psi_group_change()
+	 * to get correct state mask from test_state() loop on tasks[],
+	 * and restart groupc->state_start from now, use .clear = .set = 0
+	 * here since no task status really changed.
+	 */
+	if (!group->enabled)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		u64 now;
+
+		rq_lock_irq(rq, &rf);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+		rq_unlock_irq(rq, &rf);
+	}
+}
 #endif /* CONFIG_CGROUPS */
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
