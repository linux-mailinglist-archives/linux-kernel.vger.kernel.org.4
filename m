Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B729066A16A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjAMSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjAMSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB54839D
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:55:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49D64176A;
        Fri, 13 Jan 2023 09:56:39 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19433F67D;
        Fri, 13 Jan 2023 09:55:54 -0800 (PST)
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
Subject: [PATCH v2 05/18] x86/resctrl: Allow RMID allocation to be scoped by CLOSID
Date:   Fri, 13 Jan 2023 17:54:46 +0000
Message-Id: <20230113175459.14825-6-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230113175459.14825-1-james.morse@arm.com>
References: <20230113175459.14825-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 44 ++++++++++++++++++-----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  2 +-
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index af71401c57e2..013c8fc9fd28 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -510,7 +510,7 @@ void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
 void closid_free(int closid);
-int alloc_rmid(void);
+int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
 int rdt_get_mon_l3_config(struct rdt_resource *r);
 void mon_event_count(void *info);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index dbae380e3d1c..347be3767241 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -301,25 +301,51 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
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
index c51932516965..3b724a40d3a2 100644
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

