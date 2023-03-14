Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728DF6B9C67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 18:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCNRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNRAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 13:00:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14363A6BCB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678813245; x=1710349245;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WOjIVoQLH5wDjezKUxOWulHf4jcxXSq96FWo+jaGnJg=;
  b=aaqW4WYkkVm2ZiJ+p4uo3GARj+HnmwVUEJHXAny82qNA2UkfvpkPijDv
   oyexYLpqzxLbSo7g7qXcBYc2EI7FEZ2nduEUWPAr6v84WWLYTEaqLjVEa
   /fwQ1tmHzZjnCl62CK9F14PSFQWKkB3FXJ8kWoe0h32qf5zeSM71y0gbD
   hn0r7Td4wB5yYiQmERlbWwTP/tUoR5KUGBjReX1uPbvP0B0bC0RGDv0Ux
   u4ABq5/p5YSdGTOGrOmyeT/vSZNtWwI8gmhjnDq3Y7sqOLWCEPZjU8Dip
   29AwbzMVnQ51JYDIOEpJiOjyUyOcuBH2mV+LhFo/P+cYg9O27hwebH1Ea
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="334971141"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="334971141"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="743379727"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="743379727"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga008.fm.intel.com with ESMTP; 14 Mar 2023 10:00:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf/x86/intel: Add Granite Rapids
Date:   Tue, 14 Mar 2023 10:00:39 -0700
Message-Id: <20230314170041.2967712-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From core PMU's perspective, Granite Rapids is similar to the Sapphire
Rapids. The key differences include:
- Doesn't need the AUX event workaround for the mem load event.
  (Implement in this patch).
- Support Retire Latency (Has been implemented in the commit
  c87a31093c70 ("perf/x86: Support Retire Latency"))
- The event list, which will be supported in the perf tool later.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a3fb996a86a1..070cc4ef2672 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5469,6 +5469,15 @@ pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	return x86_pmu.pebs ? attr->mode : 0;
 }
 
+static umode_t
+mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
+{
+	if (attr == &event_attr_mem_ld_aux.attr.attr)
+		return x86_pmu.flags & PMU_FL_MEM_LOADS_AUX ? attr->mode : 0;
+
+	return pebs_is_visible(kobj, attr, i);
+}
+
 static umode_t
 lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
@@ -5496,7 +5505,7 @@ static struct attribute_group group_events_td  = {
 
 static struct attribute_group group_events_mem = {
 	.name       = "events",
-	.is_visible = pebs_is_visible,
+	.is_visible = mem_is_visible,
 };
 
 static struct attribute_group group_events_tsx = {
@@ -6486,6 +6495,10 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 	case INTEL_FAM6_EMERALDRAPIDS_X:
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		fallthrough;
+	case INTEL_FAM6_GRANITERAPIDS_X:
+	case INTEL_FAM6_GRANITERAPIDS_D:
 		pmem = true;
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -6502,7 +6515,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
-		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = spr_get_event_constraints;
-- 
2.35.1

