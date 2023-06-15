Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E1731F2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbjFOReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbjFOReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:34:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D51FF9;
        Thu, 15 Jun 2023 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686850441; x=1718386441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+NwFs4+og2uCPUm6VzVvVeB7ddBS4TzUbKnCattLObI=;
  b=XSTGDmEx9i+eVBwVF0iZ+xjAOaDhiQEbthq4lMQQlTGImT4CmvAtBgPA
   sq+ouNnOiXS+XjBzCdYCMLke/gAKuvlxLNgFwit2+yjfCqqOwwrHZ8s4f
   hVGHqk+5hxRMouZeMIkHB1SgGXCiUnrzlc+9ShTgYmBK0IsKC4763ujLL
   F0GDvtSIs2H46jkAuwoxy3HUlOLXaZLikqbgXm2OM1byAhRdN7Jhng96M
   VDbd2J86/fn377IxzO2Z3aiyaodjJKAqFNnMP7Aplbjzvic53GfJ0ACtJ
   KmqsCbxSBXdfn/tjn9xACkUgyhkOPils2n8s7tg6828XkjOr/18XQyJYk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="338614021"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="338614021"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:33:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689863272"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689863272"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 10:33:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix the FRONTEND encoding on GNR and MTL
Date:   Thu, 15 Jun 2023 10:32:42 -0700
Message-Id: <20230615173242.3726364-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When counting a FRONTEND event, the MSR_PEBS_FRONTEND is not correctly
set on GNR and MTL p-core.

The umask value for the FRONTEND events is changed on GNR and MTL. The
new umask is missing in the extra_regs[] table.

Add a dedicated intel_gnr_extra_regs[] for GNR and MTL p-core.

Fixes: bc4000fdb009 ("perf/x86/intel: Add Granite Rapids")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 89b9c1cebb61..27f3a7b34bd5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -349,6 +349,16 @@ static struct event_constraint intel_spr_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct extra_reg intel_gnr_extra_regs[] __read_mostly = {
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x012b, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0x7, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
 
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
@@ -6496,6 +6506,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		x86_pmu.extra_regs = intel_spr_extra_regs;
 		fallthrough;
 	case INTEL_FAM6_GRANITERAPIDS_X:
 	case INTEL_FAM6_GRANITERAPIDS_D:
@@ -6506,7 +6517,8 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.event_constraints = intel_spr_event_constraints;
 		x86_pmu.pebs_constraints = intel_spr_pebs_event_constraints;
-		x86_pmu.extra_regs = intel_spr_extra_regs;
+		if (!x86_pmu.extra_regs)
+			x86_pmu.extra_regs = intel_gnr_extra_regs;
 		x86_pmu.limit_period = spr_limit_period;
 		x86_pmu.pebs_ept = 1;
 		x86_pmu.pebs_aliases = NULL;
@@ -6650,6 +6662,7 @@ __init int intel_pmu_init(void)
 		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
 		pmu->extra_regs = intel_grt_extra_regs;
 		if (is_mtl(boot_cpu_data.x86_model)) {
+			x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].extra_regs = intel_gnr_extra_regs;
 			x86_pmu.pebs_latency_data = mtl_latency_data_small;
 			extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 				mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
-- 
2.35.1

