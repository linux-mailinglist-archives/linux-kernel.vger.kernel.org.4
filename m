Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46882738D54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFURkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFURkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:40:40 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB86193;
        Wed, 21 Jun 2023 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369239; x=1718905239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aUw1ko8XN5kSoQKed9FOjszj0DPEXH1X0Jv1dS7/3l4=;
  b=NsfwqCvjdEyHOkI9BAMocFPGur1SDxQda3pc0G+s7Z9oW9bycOvxb9xG
   MQdvgdlreGcL3vmun9UvCjTWkOyw+PstasP2oV/QlifutBFziBD1tv2zO
   l09T36t6AZW2SvQPDwvCWtYGu8ZD7BPWWJShYdhQ3cfZp9jhrmIoMANg+
   TWp8VCPJD2aAnkSinw8eDjq5GXlyppQOyw7mqOHHcuBuzRlcYmjWMQp4o
   GKcKd1Bm35YuCIFzk7HyXIglgLBma/F0vj8f/swixiZ6AbXI6FXj2jpTZ
   HCUpEfvGCorYL3VFaiy+X0qiwphexfyiJMqQ4ut3g46RPQODFiK2M4hWv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120523"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120523"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779921568"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="779921568"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:16 -0700
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
Subject: [PATCH v2 3/7] x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
Date:   Wed, 21 Jun 2023 10:40:02 -0700
Message-Id: <20230621174006.42533-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621174006.42533-1-tony.luck@intel.com>
References: <20230621174006.42533-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +++-
 arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 8275b8a74f7e..243017096ddf 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -435,6 +435,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_NODE,
 
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -442,7 +443,8 @@ enum resctrl_res_level {
 
 enum resctrl_scope {
 	SCOPE_L2_CACHE = 2,
-	SCOPE_L3_CACHE = 3
+	SCOPE_L3_CACHE = 3,
+	SCOPE_NODE,
 };
 
 static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6571514752f3..e4bd3072927c 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -112,6 +112,16 @@ struct rdt_hw_resource rdt_resources_all[] = {
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
+			.fflags			= 0,
+		},
+	},
 };
 
 /*
@@ -489,6 +499,8 @@ static int arch_domain_mbm_alloc(u32 num_rmid, struct rdt_hw_domain *hw_dom)
 
 static int get_domain_id(int cpu, enum resctrl_scope scope)
 {
+	if (scope == SCOPE_NODE)
+		return cpu_to_node(cpu);
 	return get_cpu_cacheinfo_id(cpu, scope);
 }
 
-- 
2.40.1

