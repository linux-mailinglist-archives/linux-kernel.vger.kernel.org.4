Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0971130B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240841AbjEYSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjEYSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:02:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCA231A6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:02:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF73E1042;
        Thu, 25 May 2023 11:03:30 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E540F3F6C4;
        Thu, 25 May 2023 11:02:42 -0700 (PDT)
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
Subject: [PATCH v4 05/24] x86/resctrl: Allow RMID allocation to be scoped by CLOSID
Date:   Thu, 25 May 2023 18:01:50 +0000
Message-Id: <20230525180209.19497-6-james.morse@arm.com>
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

MPAMs RMID values are not unique unless the CLOSID is considered as well.

alloc_rmid() expects the RMID to be an independent number.

Pass the CLOSID in to alloc_rmid(). Use this to compare indexes when
allocating. If the CLOSID is not relevant to the index, this ends up
comparing the free RMID with itself, and the first free entry will be
used. With MPAM the CLOSID is included in the index, so this becomes a
walk of the free RMID entries, until one that matches the supplied
CLOSID is found.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v2;
 * Rephrased comment in resctrl_find_free_rmid() to describe this in terms of
   list_entry_first()
 * Rephrased comment above alloc_rmid()

Changes since v3:
 * Flipped conditions in alloc_rmid()
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 51 +++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index d571da4848a4..23e20f89d2b3 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -535,7 +535,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
-int alloc_rmid(void);
+int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 bool __init rdt_cpu_has(int flag);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index bcc25f5339c0..27e731c7de72 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -337,24 +337,49 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
 	return find_first_bit(d->rmid_busy_llc, idx_limit) != idx_limit;
 }
 
-/*
- * As of now the RMIDs allocation is global.
- * However we keep track of which packages the RMIDs
- * are used to optimize the limbo list management.
- */
-int alloc_rmid(void)
+static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
 {
-	struct rmid_entry *entry;
-
-	lockdep_assert_held(&rdtgroup_mutex);
+	struct rmid_entry *itr;
+	u32 itr_idx, cmp_idx;
 
 	if (list_empty(&rmid_free_lru))
-		return rmid_limbo_count ? -EBUSY : -ENOSPC;
+		return rmid_limbo_count ? ERR_PTR(-EBUSY) : ERR_PTR(-ENOSPC);
+
+	list_for_each_entry(itr, &rmid_free_lru, list) {
+		/*
+		 * get the index of this free RMID, and the index it would need
+		 * to be if it were used with this CLOSID.
+		 * If the CLOSID is irrelevant on this architecture, these will
+		 * always be the same meaning the compiler can reduce this loop
+		 * to a single list_entry_first() call.
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
+/*
+ * For MPAM the RMID value is not unique, and has to be considered with
+ * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
+ * allows all domains to be managed by a single limbo list.
+ * Each domain also has a rmid_busy_llc to reduce the work of the limbo handler.
+ */
+int alloc_rmid(u32 closid)
+{
+	struct rmid_entry *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	entry = resctrl_find_free_rmid(closid);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
 
-	entry = list_first_entry(&rmid_free_lru,
-				 struct rmid_entry, list);
 	list_del(&entry->list);
-
 	return entry->rmid;
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index aeadaeb5df9a..5ebd6e54c7f2 100644
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
index 8346a8f2ff9f..ba0595508b2f 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3159,7 +3159,7 @@ static int mkdir_rdt_prepare_rmid_alloc(struct rdtgroup *rdtgrp)
 	if (!rdt_mon_capable)
 		return 0;
 
-	ret = alloc_rmid();
+	ret = alloc_rmid(rdtgrp->closid);
 	if (ret < 0) {
 		rdt_last_cmd_puts("Out of RMIDs\n");
 		return ret;
-- 
2.39.2

