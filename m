Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4785D66A169
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAMSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjAMSBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E9B1E28
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:56:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF973FEC;
        Fri, 13 Jan 2023 09:56:41 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5464D3F67D;
        Fri, 13 Jan 2023 09:55:57 -0800 (PST)
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
Subject: [PATCH v2 06/18] x86/resctrl: Allow the allocator to check if a CLOSID can allocate clean RMID
Date:   Fri, 13 Jan 2023 17:54:47 +0000
Message-Id: <20230113175459.14825-7-james.morse@arm.com>
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

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
used for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Add a helper to allow the CLOSID allocator to check if a CLOSID has dirty
RMID values. This behaviour is enabled by a kconfig option selected by
the architecture, which avoids a pointless search for x86.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>

---
Changes since v1:
 * Removed superflous IS_ENABLED().
---
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  | 31 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 ++++++++------
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 013c8fc9fd28..adae6231324f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -509,6 +509,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closids_supported(void);
+bool resctrl_closid_is_dirty(u32 closid);
 void closid_free(int closid);
 int alloc_rmid(u32 closid);
 void free_rmid(u32 closid, u32 rmid);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 347be3767241..190ac183139e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -327,6 +327,37 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
 	return ERR_PTR(-ENOSPC);
 }
 
+/**
+ * resctrl_closid_is_dirty - Determine if clean RMID can be allocate for this
+ *                           CLOSID.
+ * @closid: The CLOSID that is being queried.
+ *
+ * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocate CLOSID
+ * may not be able to allocate clean RMID. To avoid this the allocator will
+ * only return clean CLOSID.
+ */
+bool resctrl_closid_is_dirty(u32 closid)
+{
+	struct rmid_entry *entry;
+	int i;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		return false;
+
+	for (i = 0; i < resctrl_arch_system_num_rmid_idx(); i++) {
+		entry = &rmid_ptrs[i];
+		if (entry->closid != closid)
+			continue;
+
+		if (entry->busy)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * As of now the RMIDs allocation is the same in each domain.
  * However we keep track of which packages the RMIDs
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index ac88610a6946..e1f879e13823 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -93,7 +93,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
  * - Our choices on how to configure each resource become progressively more
  *   limited as the number of resources grows.
  */
-static int closid_free_map;
+static unsigned long closid_free_map;
 static int closid_free_map_len;
 
 int closids_supported(void)
@@ -119,14 +119,17 @@ static void closid_init(void)
 
 static int closid_alloc(void)
 {
-	u32 closid = ffs(closid_free_map);
+	u32 closid;
 
-	if (closid == 0)
-		return -ENOSPC;
-	closid--;
-	closid_free_map &= ~(1 << closid);
+	for_each_set_bit(closid, &closid_free_map, closid_free_map_len) {
+		if (resctrl_closid_is_dirty(closid))
+			continue;
 
-	return closid;
+		clear_bit(closid, &closid_free_map);
+		return closid;
+	}
+
+	return -ENOSPC;
 }
 
 void closid_free(int closid)
-- 
2.30.2

