Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F467D484
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjAZSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjAZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:42:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E4E402D8;
        Thu, 26 Jan 2023 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758552; x=1706294552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sfw55e9pOISjtn87W0zcDQDfivg/FZE8hQOsm+yl2hY=;
  b=TDv94L+z2Z7d5rlAohU44bWNGIfKDhy0ZHcIxF2eo35NDF1AButwlqSb
   rxOACzKAQbcVJuxNrnGZopohLB2SGb9l8vaKy6O4Je5FhBWeC893Q+KwG
   9SNKbDKSvGWOL/hJTR6efFf//Dgdr2NjPzN3lbXyS2/25MDQB+M8QiGiV
   R1rlS7s/8OaNQlbX4Kj2zi+BTl1Tl/25WPwAmEAVaQQPC3BDBaj9JExed
   U4HDVEIPmLdN21L76PvS9xAk6MkwLJA79YS1fXGuOqtTtGvymP9w16PD4
   uKlQ44we40M4ptYKseRgXQ0I7iHVP2/P8xBf8htkFhmw/ROdJhc505rd3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354203341"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354203341"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991745445"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991745445"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:05 -0800
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
Subject: [PATCH 3/7] x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
Date:   Thu, 26 Jan 2023 10:41:53 -0800
Message-Id: <20230126184157.27626-4-tony.luck@intel.com>
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

Add a placeholder in the array of struct rdt_hw_resource to be used
for event monitoring of systems with Sub-NUMA Cluster enabled.

Update get_domain_id() to handle SCOPE_NODE.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 15cea517efaa..39a62babd60b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -409,12 +409,14 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L3,
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_NODE,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
 };
 
 enum resctrl_scope {
+	SCOPE_NODE,
 	SCOPE_L2_CACHE = 2,
 	SCOPE_L3_CACHE = 3
 };
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6914232acf84..19be6fe42ef3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -100,6 +100,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
 			.fflags			= RFTYPE_RES_MB,
 		},
 	},
+	[RDT_RESOURCE_NODE] =
+	{
+		.r_resctrl = {
+			.rid			= RDT_RESOURCE_NODE,
+			.name			= "L3",
+			.scope			= SCOPE_NODE,
+			.domains		= domain_init(RDT_RESOURCE_NODE),
+			.fflags			= RFTYPE_RES_MB,
+		},
+	},
 };
 
 /*
@@ -464,6 +474,8 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 
 static int get_domain_id(int cpu, enum resctrl_scope scope)
 {
+	if (scope == SCOPE_NODE)
+		return cpu_to_node(cpu);
 	return get_cpu_cacheinfo_id(cpu, scope);
 }
 
-- 
2.39.1

