Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F76C1E72
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCTRrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjCTRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:46:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 450283B22D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9AD91BCA;
        Mon, 20 Mar 2023 10:28:42 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 554AA3F67D;
        Mon, 20 Mar 2023 10:27:56 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: [PATCH v3 17/19] x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but cpu
Date:   Mon, 20 Mar 2023 17:26:18 +0000
Message-Id: <20230320172620.18254-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230320172620.18254-1-james.morse@arm.com>
References: <20230320172620.18254-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a CPU is taken offline resctrl may need to move the overflow or
limbo handlers to run on a different CPU.

Once the offline callbacks have been split, cqm_setup_limbo_handler()
will be called while the CPU that is going offline is still present
in the cpu_mask.

Pass the CPU to exclude to cqm_setup_limbo_handler() and
mbm_setup_overflow_handler(). These functions can use a variant of
cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
need excluding.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2:
 * Rephrased a comment to avoid a two letter bad-word. (we)
 * Avoid assigning mbm_work_cpu if the domain is going to be free()d
 * Added cpumask_any_housekeeping_but(), I dislike the name
---
 arch/x86/kernel/cpu/resctrl/core.c     |  8 +++--
 arch/x86/kernel/cpu/resctrl/internal.h | 37 ++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 ++--
 include/linux/resctrl.h                |  3 ++
 5 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 8e25ea49372e..aafe4b74587c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -582,12 +582,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
 		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
 			cancel_delayed_work(&d->mbm_over);
-			mbm_setup_overflow_handler(d, 0);
+			/*
+			 * exclude_cpu=-1 as this CPU has already been removed
+			 * by cpumask_clear_cpu()d
+			 */
+			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
 		    has_busy_rmid(r, d)) {
 			cancel_delayed_work(&d->cqm_limbo);
-			cqm_setup_limbo_handler(d, 0);
+			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 3eb5b307b809..47838ba6876e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -78,6 +78,37 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
 	return cpu;
 }
 
+/**
+ * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those
+ *			            that aren't marked nohz_full, excluding
+ *				    the provided CPU
+ * @mask:	The mask to pick a CPU from.
+ * @exclude_cpu:The CPU to avoid picking.
+ *
+ * Returns a CPU from @mask, but not @but. If there are houskeeping CPUs that
+ * don't use nohz_full, these are preferred.
+ * Returns >= nr_cpu_ids if no CPUs are available.
+ */
+static inline unsigned int
+cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
+{
+	int cpu, hk_cpu;
+
+	cpu = cpumask_any_but(mask, exclude_cpu);
+	if (tick_nohz_full_cpu(cpu)) {
+		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
+		if  (hk_cpu == exclude_cpu) {
+			hk_cpu = cpumask_nth_andnot(1, mask,
+						    tick_nohz_full_mask);
+		}
+
+		if (hk_cpu < nr_cpu_ids)
+			cpu = hk_cpu;
+	}
+
+	return cpu;
+}
+
 struct rdt_fs_context {
 	struct kernfs_fs_context	kfc;
 	bool				enable_cdpl2;
@@ -564,11 +595,13 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first);
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
-				unsigned long delay_ms);
+				unsigned long delay_ms,
+				int exclude_cpu);
 void mbm_handle_overflow(struct work_struct *work);
 void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f0f2e61b15d5..11fa5d79c81d 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -477,7 +477,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * setup up the limbo worker.
 		 */
 		if (!has_busy_rmid(r, d))
-			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
+			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL, -1);
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
@@ -812,15 +812,28 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
+ *                             domain.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.
+ */
+void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
+			     int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
 
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
-	dom->cqm_work_cpu = cpu;
+	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
+		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	else
+		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
+						   exclude_cpu);
 
-	schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
+	if (cpu < nr_cpu_ids) {
+		dom->cqm_work_cpu = cpu;
+		schedule_delayed_work_on(cpu, &dom->cqm_limbo, delay);
+	}
 }
 
 void mbm_handle_overflow(struct work_struct *work)
@@ -862,7 +875,14 @@ void mbm_handle_overflow(struct work_struct *work)
 	mutex_unlock(&rdtgroup_mutex);
 }
 
-void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
+/**
+ * mbm_setup_overflow_handler() - Schedule the overflow handler to run for this
+ *                                domain.
+ * @delay_ms:      How far in the future the handler should run.
+ * @exclude_cpu:   Which CPU the handler should not run on, -1 to pick any CPU.
+ */
+void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms,
+				int exclude_cpu)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
 	int cpu;
@@ -870,9 +890,16 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 	if (!resctrl_mounted || !resctrl_arch_mon_capable())
 		return;
 
-	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	if (exclude_cpu == -1)
+		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
+	else
+		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
+						   exclude_cpu);
+
 	dom->mbm_work_cpu = cpu;
-	schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
+
+	if (cpu < nr_cpu_ids)
+		schedule_delayed_work_on(cpu, &dom->mbm_over, delay);
 }
 
 static int dom_data_init(struct rdt_resource *r)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 410b2b451c30..bf206bdb21ee 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2520,7 +2520,8 @@ static int rdt_get_tree(struct fs_context *fc)
 	if (is_mbm_enabled()) {
 		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
-			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
+			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL,
+						   RESCTRL_PICK_ANY_CPU);
 	}
 
 	goto out;
@@ -3686,7 +3687,8 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 	if (is_mbm_enabled()) {
 		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
-		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
+		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL,
+					   RESCTRL_PICK_ANY_CPU);
 	}
 
 	if (is_llc_occupancy_enabled())
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5a66d034aa61..3ea7d618f33f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -9,6 +9,9 @@
 /* CLOSID value used by the default control group */
 #define RESCTRL_RESERVED_CLOSID		0
 
+/* Indicates no CPU needs to be excluded */
+#define RESCTRL_PICK_ANY_CPU		-1
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.39.2

