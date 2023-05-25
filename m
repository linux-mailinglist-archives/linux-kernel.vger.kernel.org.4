Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447E7711305
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbjEYSCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbjEYSCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:02:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644971B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:02:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F1415BF;
        Thu, 25 May 2023 11:03:20 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AB793F6C4;
        Thu, 25 May 2023 11:02:32 -0700 (PDT)
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
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
Subject: [PATCH v4 02/24] x86/resctrl: Access per-rmid structures by index
Date:   Thu, 25 May 2023 18:01:47 +0000
Message-Id: <20230525180209.19497-3-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230525180209.19497-1-james.morse@arm.com>
References: <20230525180209.19497-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the differences between Intel RDT/AMD QoS and Arm's MPAM
monitors, RMID values on arm64 are not unique unless the CLOSID is
also included. Bitmaps like rmid_busy_llc need to be sized by the
number of unique entries for this resource.

Add helpers to encode/decode the CLOSID and RMID to an index. The
domain's rmid_busy_llc and rmid_ptrs[] are then sized by index,
as are the domain mbm_local and mbm_total arrays.
On x86, the index is always just the RMID, so all these structures
remain the same size.

The index gives resctrl a unique value it can use to store monitor
values, and allows MPAM to decode the CLOSID when reading the hardware
counters.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added X86_BAD_CLOSID macro to make it clear what this value means
 * Added second WARN_ON() for closid checking, and made both _ONCE()

Changes since v2:
 * Added RESCTRL_RESERVED_CLOSID
 * Removed a newline
 * Repharsed some comments
 * Renamed a variable 'ignore'd
 * Moved X86_RESCTRL_BAD_CLOSID to a previous patch

Changes since v3:
 * Changed a variable name
 * Fixed various typos
---
 arch/x86/include/asm/resctrl.h         | 17 ++++++
 arch/x86/kernel/cpu/resctrl/core.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 84 +++++++++++++++++---------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  7 ++-
 include/linux/resctrl.h                |  3 +
 6 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index e906070285fb..dd9b638d43c8 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_struct *tsk)
 		__resctrl_sched_in(tsk);
 }
 
+static inline u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	/* RMID are independent numbers for x86. num_rmid_idx == num_rmid */
+	return boot_cpu_data.x86_cache_max_rmid + 1;
+}
+
+static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*rmid = idx;
+	*closid = X86_RESCTRL_BAD_CLOSID;
+}
+
+static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid)
+{
+	return rmid;
+}
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 030d3b409768..4bea032d072e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -600,7 +600,7 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid = 0;
 	state->cur_closid = 0;
 	state->cur_rmid = 0;
-	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
+	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
 }
 
 static int resctrl_online_cpu(unsigned int cpu)
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f2da908bb079..d571da4848a4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -7,6 +7,7 @@
 #include <linux/kernfs.h>
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
+#include <asm/resctrl.h>
 
 #define L3_QOS_CDP_ENABLE		0x01ULL
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 86574adedd64..bcc25f5339c0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -142,12 +142,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
 	return val;
 }
 
-static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
+/*
+ * x86 and arm64 differ in their handling of monitoring.
+ * x86's RMID are an independent number, there is only one source of traffic
+ * with an RMID value of '1'.
+ * arm64's PMG extend the PARTID/CLOSID space, there are multiple sources of
+ * traffic with a PMG value of '1', one for each CLOSID, meaning the RMID
+ * value is no longer unique.
+ * To account for this, resctrl uses an index. On x86 this is just the RMID,
+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
+ *
+ * The domain's rmid_busy_llc and rmid_ptrs are sized by index. The arch code
+ * must accept an attempt to read every index.
+ */
+static inline struct rmid_entry *__rmid_entry(u32 idx)
 {
 	struct rmid_entry *entry;
+	u32 closid, rmid;
 
-	entry = &rmid_ptrs[rmid];
-	WARN_ON(entry->rmid != rmid);
+	entry = &rmid_ptrs[idx];
+	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
+
+	WARN_ON_ONCE(entry->closid != closid);
+	WARN_ON_ONCE(entry->rmid != rmid);
 
 	return entry;
 }
@@ -277,8 +294,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 void __check_limbo(struct rdt_domain *d, bool force_free)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
-	u32 crmid = 1, nrmid;
+	u32 idx, cur_idx = 1;
 	bool rmid_dirty;
 	u64 val = 0;
 
@@ -289,12 +307,11 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	 * RMID and move it to the free list when the counter reaches 0.
 	 */
 	for (;;) {
-		nrmid = find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
-		if (nrmid >= r->num_rmid)
+		idx = find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
+		if (idx >= idx_limit)
 			break;
 
-		entry = __rmid_entry(X86_RESCTRL_BAD_CLOSID, nrmid);// temporary
-
+		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty = true;
@@ -303,19 +320,21 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		}
 
 		if (force_free || !rmid_dirty) {
-			clear_bit(entry->rmid, d->rmid_busy_llc);
+			clear_bit(idx, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
 				list_add_tail(&entry->list, &rmid_free_lru);
 			}
 		}
-		crmid = nrmid + 1;
+		cur_idx = idx + 1;
 	}
 }
 
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
 {
-	return find_first_bit(d->rmid_busy_llc, r->num_rmid) != r->num_rmid;
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
+
+	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
 /*
@@ -345,6 +364,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val = 0;
+	u32 idx;
+
+	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
 	entry->busy = 0;
 	cpu = get_cpu();
@@ -364,7 +386,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 */
 		if (!has_busy_rmid(r, d))
 			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
-		set_bit(entry->rmid, d->rmid_busy_llc);
+		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
 	put_cpu();
@@ -377,14 +399,16 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 
 void free_rmid(u32 closid, u32 rmid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
 	struct rmid_entry *entry;
 
-	if (!rmid)
-		return;
-
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	entry = __rmid_entry(closid, rmid);
+	/* do not allow the default rmid to be free'd */
+	if (!idx)
+		return;
+
+	entry = __rmid_entry(idx);
 
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
@@ -395,11 +419,13 @@ void free_rmid(u32 closid, u32 rmid)
 static struct mbm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)
 {
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[rmid];
+		return &d->mbm_total[idx];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[rmid];
+		return &d->mbm_local[idx];
 	default:
 		return NULL;
 	}
@@ -441,7 +467,8 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
 {
-	struct mbm_state *m = &rr->d->mbm_local[rmid];
+	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *m = &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
 
 	cur_bytes = rr->val;
@@ -531,7 +558,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
+	u32 cur_bw, delta_bw, user_bw, idx;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
@@ -544,7 +571,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	pmbm_data = &dom_mbm->mbm_local[rmid];
+	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
+	pmbm_data = &dom_mbm->mbm_local[idx];
 
 	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -727,19 +755,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
 
 static int dom_data_init(struct rdt_resource *r)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry = NULL;
-	int i, nr_rmids;
+	u32 idx;
+	int i;
 
-	nr_rmids = r->num_rmid;
-	rmid_ptrs = kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
+	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
 	if (!rmid_ptrs)
 		return -ENOMEM;
 
-	for (i = 0; i < nr_rmids; i++) {
+	for (i = 0; i < idx_limit; i++) {
 		entry = &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
 
-		entry->rmid = i;
+		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
 		list_add_tail(&entry->list, &rmid_free_lru);
 	}
 
@@ -748,7 +777,8 @@ static int dom_data_init(struct rdt_resource *r)
 	 * default_rdtgroup control group, which will be setup later. See
 	 * rdtgroup_setup_root().
 	 */
-	entry = __rmid_entry(0, 0);
+	idx = resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID, 0);
+	entry = __rmid_entry(idx);
 	list_del(&entry->list);
 
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ff9ccfcd18bd..023eae69f29e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3604,16 +3604,17 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
 
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 {
+	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		d->rmid_busy_llc = bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
 	if (is_mbm_total_enabled()) {
 		tsize = sizeof(*d->mbm_total);
-		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_total = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
 			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
@@ -3621,7 +3622,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	}
 	if (is_mbm_local_enabled()) {
 		tsize = sizeof(*d->mbm_local);
-		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_local = kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
 			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 7d80bae05f59..ff7452f644e4 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -6,6 +6,9 @@
 #include <linux/list.h>
 #include <linux/pid.h>
 
+/* CLOSID value used by the default control group */
+#define RESCTRL_RESERVED_CLOSID		0
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.39.2

