Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3786967D485
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjAZSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjAZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:42:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA7845F74;
        Thu, 26 Jan 2023 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758552; x=1706294552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b/uxKduTxOxhRTdknRQRA39FqoLPxucgbMsljFn2K+0=;
  b=DdliaEVWjUrRs1Wc5IuIrZ5iHW/zadQS2UJ9SWe7e+NMUtdMIh5okzhV
   pgM70QlRwCTGbf39lsXn29r+gEK/kcpLUM1K/xa/5S9L6MTjdo208J2F4
   5y0etbDfK2gZK1E0N2dyFEaOuGX6atJJD3vy+YmqwY7o1bi/mvj8KJ5Eo
   UjQNrgLukkPEL0VkDZZlcxS4NK4XRs2TI82O7drt63P40UCwJ4CS4nJT3
   zf3fk9Xz9vZVWpIl8hl3Ywo/iBbvZPiw2OxwrI5K2Fq3Zr6CMmz02gFG8
   kJcfwGWwiNBdWqIfnxP8Pg0phrZMaeTJVBf4CmqtWmWk0BN0K1I0cXeHO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354203351"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354203351"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991745449"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991745449"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/7] x86/resctrl: Add code to setup monitoring at L3 or NODE scope.
Date:   Thu, 26 Jan 2023 10:41:54 -0800
Message-Id: <20230126184157.27626-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126184157.27626-1-tony.luck@intel.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Sub-NUMA cluster is enabled (snc_ways > 1) use the RDT_RESOURCE_NODE
instead of RDT_RESOURCE_L3 for all monitoring operations.

The mon_scale and num_rmid values from CPUID(0xf,0x1),(EBX,ECX) must be
scaled down by the number of Sub-NUMA Clusters.

A subsequent change will detect sub-NUMA cluster mode and set
"snc_ways". For now set to one (meaning each L3 cache spans one
node).

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     | 13 ++++++++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 ++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 39a62babd60b..ad26d008dafa 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -405,6 +405,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
 
 extern struct dentry *debugfs_resctrl;
 
+extern int snc_ways;
+
 enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19be6fe42ef3..53b2ab37af2f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -48,6 +48,11 @@ int max_name_width, max_data_width;
  */
 bool rdt_alloc_capable;
 
+/*
+ * How many Sub-Numa Cluster nodes share a single L3 cache
+ */
+int snc_ways = 1;
+
 static void
 mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
 		struct rdt_resource *r);
@@ -786,7 +791,13 @@ static __init bool get_rdt_alloc_resources(void)
 
 static __init bool get_rdt_mon_resources(void)
 {
-	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	struct rdt_resource *r;
+
+	/* When SNC enabled, monitor functions at node instead of L3 cache scope */
+	if (snc_ways > 1)
+		r = &rdt_resources_all[RDT_RESOURCE_NODE].r_resctrl;
+	else
+		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC))
 		rdt_mon_features |= (1 << QOS_L3_OCCUP_EVENT_ID);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d05bbd4f6b2d..3fc63aa68130 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -777,8 +777,8 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 	int ret;
 
 	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
-	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
-	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
+	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_ways;
+	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_ways;
 	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
 
 	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a6ba3080e5db..a0dc64a70d01 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2238,7 +2238,10 @@ static int rdt_get_tree(struct fs_context *fc)
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+		if (snc_ways > 1)
+			r = &rdt_resources_all[RDT_RESOURCE_NODE].r_resctrl;
+		else
+			r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
-- 
2.39.1

