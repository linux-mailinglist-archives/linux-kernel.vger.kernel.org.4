Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414B6E7145
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjDSCpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjDSCpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:45:00 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FCC154;
        Tue, 18 Apr 2023 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872286; x=1713408286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jsiHg2i6UjRZGZy2aubZeGbqqNhgW3rTFkSc/x9EGZ4=;
  b=QEPOb1sq+xaGT+V1WxIG3PXwiFZm12+oXwQ0cVpoBFcXXz0SV03hEYDB
   9JsT20XQ+v+kmUGBdfzYRUerRYMnMLoNC2Ri5W8Zvf8RgDKTqet6E2OGE
   RG2WRJJ1vol/4IcxJg43OayQo31XgShkXn8E77ciaa9/zxYnS8JK60UAH
   hxxPDKIRYpUA0w0WOcnu6xnHcPk/zc54B+z2gPecRZKvdn1IkOm1a4GmX
   M9/31ZfTnqXuFcuILW4nPYV63I/YNsmh+EwjrlOvrY/+Woo4yn7w3ZOQB
   7C28xaVPrtDhYRkeksFOt+LLX/t3PO3ufZobsAOtjxj8k3SZJ13+kszH0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215302"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215302"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478028"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478028"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:44 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 07/15] powercap/intel_rapl: Change primitive order
Date:   Wed, 19 Apr 2023 10:44:11 +0800
Message-Id: <20230419024419.324436-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same set of operations are shared by different Powert Limits,
including Power Limit get/set, Power Limit enable/disable, clamping
enable/disable, time window get/set, and max power get/set, etc.

But the same operation for different Power Limit has different
primitives because they use different registers/register bits.

A lot of dirty/duplicate code was introduced to handle this difference.

Instead of using hardcoded primitive name directly, using Power Limit id
+ operation type is much cleaner.

For this sense, move POWER_LIMIT1/POWER_LIMIT2/POWER_LIMIT4 to the
beginning of enum rapl_primitives so that they can be reused as
Power Limit ids.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 4 ++--
 include/linux/intel_rapl.h           | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 97d9e1e628e2..154f93b3dee5 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -631,14 +631,14 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 
 static struct rapl_primitive_info rpi_default[NR_RAPL_PRIMITIVES] = {
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
index 936fb8c3082c..bbd03b17dc8d 100644
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

