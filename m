Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC46BD42F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCPPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjCPPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:42:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C66311152;
        Thu, 16 Mar 2023 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981299; x=1710517299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9n542YknTu5AzGGFBMZdJmBnE3cCXEiUiHZze/teN1I=;
  b=BbecMVzPd/UdS499jaENiz/i/zHP/mpRDhH4vMDhWuQQEBRmoILeYM4Y
   C+UlF99z/7cy2d8eCVfNSfUMBkYnIvsUjs6Bea+8SdswQeatNQ5qiGK7/
   0R9zNU64Cy/x5ZDNrbSLypK1ZaxiWANLRqC0cJ9MUKepcsyLEPPcHwdoZ
   b7pl8bNIxWUqYxVLac6VteM4aWi8LLHuKauJL3w8ii6F18ATPkTAgq7IJ
   C6hXLmJqUvVs95nPr69LG0cux1U9ZYPQrfvqX1X+Q95RWWvOABI8Qk+xa
   0frI3k0XC3JZm7P1gDeOySaMkEzpSAyg1ewjxs2lEWeQYLmtnwfAMUyMi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571018"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267044"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267044"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:01 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 07/15] powercap/intel_rapl: Change primitive order
Date:   Thu, 16 Mar 2023 23:38:33 +0800
Message-Id: <20230316153841.3666-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
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

Move POWER_LIMIT1/POWER_LIMIT2/POWER_LIMIT4 to the beginning of enum
rapl_primitives so that they can be reused to represent different Power
Limits.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 4 ++--
 include/linux/intel_rapl.h           | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 9e29e56f4900..3a8940d3bec8 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -631,14 +631,14 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 
 static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
 	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
 				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 1648923f694d..856b739fd194 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -37,10 +37,10 @@ enum rapl_domain_reg_id {
 struct rapl_domain;
 
 enum rapl_primitives {
-	ENERGY_COUNTER,
 	POWER_LIMIT1,
 	POWER_LIMIT2,
 	POWER_LIMIT4,
+	ENERGY_COUNTER,
 	FW_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
@@ -75,7 +75,8 @@ struct rapl_domain_data {
 	unsigned long timestamp;
 };
 
-#define NR_POWER_LIMITS (3)
+#define NR_POWER_LIMITS	(POWER_LIMIT4 + 1)
+
 struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
 	int prim_id;		/* primitive ID used to enable */
-- 
2.25.1

