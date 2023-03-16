Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478636BD42E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCPPmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCPPmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:42:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50402DCF4F;
        Thu, 16 Mar 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981296; x=1710517296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyQGRkcCkCnjrWBz+liEVb78sQ6ZmIENoJ65Gr8jR6o=;
  b=R+o5PhleS5Go6laWIa1tNtWDPdxp8X5YmMYAUP/egVEFSnuzWB3tAyvk
   knYYeu7j+cj21Xz/Wcwos9yxEsDKp6vlPaKaZf0nx7sWOWwWUe8+176Ce
   6z1fDHuj2c0DfpJD/5a2fm6760tLX9Dzpr+VrOdYOSCbm1d75/JNBLzl1
   kPGtVPcfjcfJKnIvFkcvzQlEr2wgTdRtyQ/zH6n6/oPH7j/6vo4lK+a7m
   b+/Ax5cSD6sXPzg2D+6OXUwDPMysXFIf3ZvmE62xWkkwxh39f63iwf6lQ
   qKBYPqaKKFe9ig7qD4hZxwOzNIyFvt1cKyfNyerZQkKh0qO+zXwsLWmfJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571005"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571005"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267029"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267029"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:59 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 06/15] powercap/intel_rapl: Use index to initialize primitive information
Date:   Thu, 16 Mar 2023 23:38:32 +0800
Message-Id: <20230316153841.3666-7-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RAPL primitive information array is required to be
initialized in the order of enum rapl_primitives.
This can break easily, especially when different RAPL Interfaces may
support different sets of primitives.

Convert the code to initialize the primitive information using array
index explicitly.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 54 ++++++++++++++--------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 8c1e46877745..9e29e56f4900 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -629,61 +629,59 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	return div64_u64(value, scale);
 }
 
-/* in the order of enum rapl_primitives */
-static struct rapl_primitive_info rpis_default[] = {
+static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
+	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
+	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
+	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
+	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
+	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
+	[PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
+	[PL2_ENABLE] = PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
+	[PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
+	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
+	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
+	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
+	[THERMAL_SPEC_POWER] = PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
 			    0, RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
+	[MAX_POWER] = PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
 			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
+	[MIN_POWER] = PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
 			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
+	[MAX_TIME_WINDOW] = PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
 			    RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
+	[THROTTLED_TIME] = PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
 			    RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
+	[PRIORITY_LEVEL] = PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
 			    RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
+	[PSYS_POWER_LIMIT1] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
+	[PSYS_POWER_LIMIT2] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
+	[PSYS_PL1_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
+	[PSYS_PL2_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
+	[PSYS_TIME_WINDOW1] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
+	[PSYS_TIME_WINDOW2] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
 			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	/* non-hardware */
-	PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
+	[AVERAGE_POWER] = PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
 			    RAPL_PRIMITIVE_DERIVED),
-	{NULL, 0, 0, 0},
 };
 
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
-- 
2.25.1

