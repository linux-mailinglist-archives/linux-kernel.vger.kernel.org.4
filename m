Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE94607800
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiJUNNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiJUNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:13:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A900F1645D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:12:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 315101D34;
        Fri, 21 Oct 2022 06:13:03 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 853C83F792;
        Fri, 21 Oct 2022 06:12:54 -0700 (PDT)
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
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, xingxin.hx@openanolis.org,
        baolin.wang@linux.alibaba.com, peternewman@google.com
Subject: [PATCH 10/18] x86/resctrl: Allow arch to allocate memory needed in resctrl_arch_rmid_read()
Date:   Fri, 21 Oct 2022 13:11:56 +0000
Message-Id: <20221021131204.5581-11-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221021131204.5581-1-james.morse@arm.com>
References: <20221021131204.5581-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the number of monitors available, Arm's MPAM may need to
allocate a monitor prior to reading the counter value. Allocating a
contended resource may involve sleeping.

All callers of resctrl_arch_rmid_read() read the counter on more than
one domain. If the monitor is allocated globally, there is no need to
allocate and free it for each call to resctrl_arch_rmid_read().

Add arch hooks for this allocation, which need calling before
resctrl_arch_rmid_read(). The allocated monitor is passed to
resctrl_arch_rmid_read(), then freed again afterwards. The helper
can be called on any CPU, and can sleep.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/include/asm/resctrl.h         | 11 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 40 +++++++++++++++++++++++---
 include/linux/resctrl.h                |  4 +--
 4 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index edf4368ea25e..4ce1376525e3 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -131,6 +131,17 @@ static inline u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
 	return rmid;
 }
 
+/* x86 can always read an rmid, nothing needs allocating */
+struct rdt_resource;
+static inline int resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, int evtid)
+{
+	might_sleep();
+	return 0;
+};
+
+static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r, int evtid,
+					     int ctx) { };
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4d2f4524fe87..8e64f1306591 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -98,6 +98,7 @@ struct rmid_read {
 	bool			first;
 	int			err;
 	u64			val;
+	int			arch_mon_ctx;
 };
 
 extern bool rdt_alloc_capable;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e4ddc2477631..670cd5b7d733 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -15,6 +15,7 @@
  * Software Developer Manual June 2016, volume 3, section 17.17.
  */
 
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -229,7 +230,7 @@ static void __rmid_read(void *arg)
 
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val)
+			   u64 *val, int ignored)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
@@ -278,9 +279,14 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
 	u32 idx, cur_idx = 1;
+	int arch_mon_ctx;
 	bool rmid_dirty;
 	u64 val = 0;
 
+	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
+	if (arch_mon_ctx < 0)
+		return;
+
 	/*
 	 * Skip RMID 0 and start from RMID 1 and check all the RMIDs that
 	 * are marked as busy for occupancy < threshold. If the occupancy
@@ -294,7 +300,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 
 		entry = __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					   QOS_L3_OCCUP_EVENT_ID, &val)) {
+					   QOS_L3_OCCUP_EVENT_ID, &val,
+					   arch_mon_ctx)) {
 			rmid_dirty = true;
 		} else {
 			rmid_dirty = (val >= resctrl_rmid_realloc_threshold);
@@ -309,6 +316,8 @@ void __check_limbo(struct rdt_domain *d, bool force_free)
 		}
 		cur_idx = idx + 1;
 	}
+
+	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
 }
 
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
@@ -400,16 +409,22 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 {
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_domain *d;
+	int arch_mon_ctx;
 	u64 val = 0;
 	u32 idx;
 	int err;
 
 	idx = resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
 
+	arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, QOS_L3_OCCUP_EVENT_ID);
+	if (arch_mon_ctx < 0)
+		return;
+
 	entry->busy = 0;
 	list_for_each_entry(d, &r->domains, list) {
 		err = resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
-					     QOS_L3_OCCUP_EVENT_ID, &val);
+					     QOS_L3_OCCUP_EVENT_ID, &val,
+					     arch_mon_ctx);
 		if (err || val <= resctrl_rmid_realloc_threshold)
 			continue;
 
@@ -422,6 +437,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
+	resctrl_arch_mon_ctx_free(r, QOS_L3_OCCUP_EVENT_ID, arch_mon_ctx);
 
 	if (entry->busy)
 		rmid_limbo_count++;
@@ -458,7 +474,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
 		resctrl_arch_reset_rmid(rr->r, rr->d, closid, rmid, rr->evtid);
 
 	rr->err = resctrl_arch_rmid_read(rr->r, rr->d, closid, rmid, rr->evtid,
-					 &tval);
+					 &tval, rr->arch_mon_ctx);
 	if (rr->err)
 		return rr->err;
 
@@ -531,6 +547,9 @@ int mon_event_count(void *info)
 	int ret;
 
 	rdtgrp = rr->rgrp;
+	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr->r, rr->evtid);
+	if (rr->arch_mon_ctx < 0)
+		return rr->arch_mon_ctx;
 
 	ret = __mon_event_count(rdtgrp->closid, rdtgrp->mon.rmid, rr);
 
@@ -557,6 +576,8 @@ int mon_event_count(void *info)
 	if (ret == 0)
 		rr->err = 0;
 
+	resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
+
 	return 0;
 }
 
@@ -693,11 +714,21 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 	if (is_mbm_total_enabled()) {
 		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
 		rr.val = 0;
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (rr.arch_mon_ctx < 0)
+			return;
+
 		__mon_event_count(closid, rmid, &rr);
+
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
 		rr.val = 0;
+		rr.arch_mon_ctx = resctrl_arch_mon_ctx_alloc(rr.r, rr.evtid);
+		if (rr.arch_mon_ctx < 0)
+			return;
+
 		__mon_event_count(closid, rmid, &rr);
 
 		/*
@@ -707,6 +738,7 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d,
 		 */
 		if (is_mba_sc(NULL))
 			mbm_bw_count(closid, rmid, &rr);
+		resctrl_arch_mon_ctx_free(rr.r, rr.evtid, rr.arch_mon_ctx);
 	}
 }
 
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 641aea580a1f..1f345d24e236 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -230,6 +230,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  * @rmid:		rmid of the counter to read.
  * @eventid:		eventid to read, e.g. L3 occupancy.
  * @val:		result of the counter read in bytes.
+ * @arch_mon_ctx:	An allocated context from resctrl_arch_mon_ctx_alloc().
  *
  * Call from process context on a CPU that belongs to domain @d.
  *
@@ -238,8 +239,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
  */
 int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val);
-
+			   u64 *val, int arch_mon_ctx);
 
 /**
  * resctrl_arch_reset_rmid() - Reset any private state associated with rmid
-- 
2.30.2

