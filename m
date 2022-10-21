Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C910A6077FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJUNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJUNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:12:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 064AA27083F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:12:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E400F1042;
        Fri, 21 Oct 2022 06:12:49 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B273F792;
        Fri, 21 Oct 2022 06:12:41 -0700 (PDT)
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
Subject: [PATCH 05/18] x86/resctrl: Allow RMID allocation to be scoped by CLOSID
Date:   Fri, 21 Oct 2022 13:11:51 +0000
Message-Id: <20221021131204.5581-6-james.morse@arm.com>
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

MPAMs RMID values are not unique unless the CLOSID is considered as well.

alloc_rmid() expects the RMID to be an independent number.

Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
allocating. If the CLOSID is not relevant to the index, this ends up
comparing the free RMID with itself, and the first free entry will be
used. With MPAM the CLOSID is included in the index, so this becomes a
walk of the free RMID entries, until one that matches the supplied
CLOSID is found.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 44 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index cb94c3e3fe36..c8c46fe088be 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -520,7 +520,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
-int alloc_rmid(void);
+int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index c95d259476d4..59da256a77fe 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -294,25 +294,51 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
 	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
+static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
+{
+	struct rmid_entry *itr;
+	u32 itr_idx, cmp_idx;
+
+	if (list_empty(&rmid_free_lru))
+		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
+
+	list_for_each_entry(itr, &rmid_free_lru, list) {
+		/*
+		 * get the index of this free RMID, and the index it would need
+		 * to be if it were used with this CLOSID.
+		 * If the CLOSID is irrelevant on this architecture, these will
+		 * always be the same. Otherwise they will only match if this
+		 * RMID can be used with this CLOSID.
+		 */
+		itr_idx = resctrl_arch_rmid_idx_encode(itr->closid, itr->rmid);
+		cmp_idx = resctrl_arch_rmid_idx_encode(closid, itr->rmid);
+
+		if (itr_idx == cmp_idx)
+			return itr;
+	}
+
+	return ERR_PTR(-ENOSPC);
+}
+
 /*
- * As of now the RMIDs allocation is global.
+ * As of now the RMIDs allocation is the same in each domain.
  * However we keep track of which packages the RMIDs
  * are used to optimize the limbo list management.
+ * The closid is ignored on x86.
  */
-int alloc_rmid(void)
+int alloc_rmid(u32 closid)
 {
 	struct rmid_entry *entry;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (list_empty(&rmid_free_lru))
-		return rmid_limbo_count ? -EBUSY : -ENOSPC;
+	entry = resctrl_find_free_rmid(closid);
+	if (!IS_ERR(entry)) {
+		list_del(&entry->list);
+		return entry->rmid;
+	}
 
-	entry = list_first_entry(&rmid_free_lru,
-				 struct rmid_entry, list);
-	list_del(&entry->list);
-
-	return entry->rmid;
+	return PTR_ERR(entry);
 }
 
 static void add_rmid_to_limbo(struct rmid_entry *entry)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 4d3706f71ee3..acebbc35331f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -763,7 +763,7 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
 	int ret;
 
 	if (rdt_mon_capable) {
-		ret = alloc_rmid();
+		ret = alloc_rmid(rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Out of RMIDs\n");
 			return ret;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c67083a8a5f5..ac88610a6946 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2875,7 +2875,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	if (!rdt_mon_capable)
 		return 0;
 
-	ret = alloc_rmid();
+	ret = alloc_rmid(rdtgrp->closid);
 	if (ret < 0) {
 		rdt_last_cmd_puts("Out of RMIDs\n");
 		return ret;
-- 
2.30.2

