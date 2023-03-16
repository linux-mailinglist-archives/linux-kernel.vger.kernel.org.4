Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703476BD436
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjCPPn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjCPPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:42:59 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DFEE1FDD;
        Thu, 16 Mar 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981337; x=1710517337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xnm61tL1azQ0PB+g0zx3ldricUsBP8cFhvE38+5OrDQ=;
  b=hI6on45nPWdOaab00Edf1X+tYNI8U2jdTKPh5EnpRUPhqsszcTyrGbH5
   Q06cpLi94LyXG349PckeSMi5NY/CV6MJwGx/JmVeWSQODeI30VRULIvDo
   2x/yH/WiKP9k1eIB3SgowhfbyvoTkOeZlBYu1XC6oWzGkkHBND+ttZ8+w
   zRQWC2AJMT/QccI4Dr70p+nmuCPiSw9mCZ9fbiWptK6ygD8+u2fuy7yRH
   Fg93m6jfzp3xhXk78vc2i0IxMJc70+d1K+yuJGhQrHWch/xqNsoz++Gq4
   tDDttERNSoCP/HeION9AKAZLxrCJPXW/vaZx1WT8pTdDdvw+2xkPr5nKT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571057"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571057"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267099"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267099"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:06 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 10/15] powercap/intel_rapl: Introduce per Power Limit lock
Date:   Thu, 16 Mar 2023 23:38:36 +0800
Message-Id: <20230316153841.3666-11-rui.zhang@intel.com>
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

With RAPL MSR/MMIO Interface, each RAPL domain has one Power Limit
register. Each Power Limit register has one or two Power Limits and one
lock bit. The number of Power Limits the lock bit applies to depends on
the number of Power Limits supported by the Power Limit register.

With RAPL TPMI Interface, each RAPL domain supports multiple Power
Limits. And each Power Limit has a register with a lock bit.

To handle this, introduce per Power Limit lock support. For existing
RAPL MSR/MMIO Interfaces, the lock bit in the Power Limit register
applies to all the Power Limits controlled by this register.

Remove the per domain DOMAIN_STATE_BIOS_LOCKED flag at the same time
because it can be replaced by the per Power Limit lock.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 40 ++++++++++++++--------------
 include/linux/intel_rapl.h           |  2 ++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3e9141dedc1d..636e05aa711b 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -94,7 +94,6 @@ enum unit_type {
 
 #define	DOMAIN_STATE_INACTIVE           BIT(0)
 #define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
-#define DOMAIN_STATE_BIOS_LOCKED        BIT(2)
 
 static const char *pl_names[NR_POWER_LIMITS] = {
 	[POWER_LIMIT1] = "long_term",
@@ -108,6 +107,7 @@ enum pl_prims {
 	PL_LIMIT,
 	PL_TIME_WINDOW,
 	PL_MAX_POWER,
+	PL_LOCK,
 };
 
 static bool is_pl_valid(struct rapl_domain *rd, int pl)
@@ -117,7 +117,7 @@ static bool is_pl_valid(struct rapl_domain *rd, int pl)
 	return rd->rpl[pl].name ? true : false;
 }
 
-static int get_pl_prim(int pl, enum pl_prims prim)
+static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 {
 	switch (pl) {
 	case POWER_LIMIT1:
@@ -131,6 +131,9 @@ static int get_pl_prim(int pl, enum pl_prims prim)
 			return TIME_WINDOW1;
 		if (prim == PL_MAX_POWER)
 			return THERMAL_SPEC_POWER;
+		if (prim == PL_LOCK)
+			return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
+			       FW_HIGH_LOCK : FW_LOCK;
 		return -EINVAL;
 	case POWER_LIMIT2:
 		if (prim == PL_ENABLE)
@@ -143,6 +146,9 @@ static int get_pl_prim(int pl, enum pl_prims prim)
 			return TIME_WINDOW2;
 		if (prim == PL_MAX_POWER)
 			return MAX_POWER;
+		if (prim == PL_LOCK)
+			return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
+			       FW_HIGH_LOCK : FW_LOCK;
 		return -EINVAL;
 	case POWER_LIMIT4:
 		if (prim == PL_LIMIT)
@@ -314,7 +320,7 @@ static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
 	u64 val;
 	int ret;
 
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
+	if (rd->rpl[POWER_LIMIT1].locked) {
 		*mode = false;
 		return 0;
 	}
@@ -599,6 +605,8 @@ static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
 			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
 	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[FW_HIGH_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
+			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
 			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
 	[PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
@@ -719,11 +727,6 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 
 	cpu = rd->rp->lead_cpu;
 
-	/* domain with 2 limits has different bit */
-	if (prim == FW_LOCK && (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))) {
-		rpi->mask = POWER_HIGH_LOCK;
-		rpi->shift = 63;
-	}
 	/* non-hardware data are collected by the polling thread */
 	if (rpi->flag & RAPL_PRIMITIVE_DERIVED) {
 		*data = rd->rdd.primitives[prim];
@@ -781,7 +784,7 @@ static int rapl_write_data_raw(struct rapl_domain *rd,
 static int rapl_read_pl_data(struct rapl_domain *rd, int pl,
 			      enum pl_prims pl_prim, bool xlate, u64 *data)
 {
-	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+	enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
 
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
@@ -793,12 +796,12 @@ static int rapl_write_pl_data(struct rapl_domain *rd, int pl,
 			       enum pl_prims pl_prim,
 			       unsigned long long value)
 {
-	enum rapl_primitives prim = get_pl_prim(pl, pl_prim);
+	enum rapl_primitives prim = get_pl_prim(rd, pl, pl_prim);
 
 	if (!is_pl_valid(rd, pl))
 		return -EINVAL;
 
-	if (rd->state & DOMAIN_STATE_BIOS_LOCKED) {
+	if (rd->rpl[pl].locked) {
 		pr_warn("%s:%s:%s locked by BIOS\n", rd->rp->name, rd->name, pl_names[pl]);
 		return -EACCES;
 	}
@@ -1305,17 +1308,14 @@ static void rapl_detect_powerlimit(struct rapl_domain *rd)
 	u64 val64;
 	int i;
 
-	/* check if the domain is locked by BIOS, ignore if MSR doesn't exist */
-	if (!rapl_read_data_raw(rd, FW_LOCK, false, &val64)) {
-		if (val64) {
-			pr_info("RAPL %s domain %s locked by BIOS\n",
-				rd->rp->name, rd->name);
-			rd->state |= DOMAIN_STATE_BIOS_LOCKED;
+	for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
+		if (!rapl_read_pl_data(rd, i, PL_LOCK, false, &val64)) {
+			rd->rpl[i].locked = val64;
+			if (val64)
+				pr_info("%s:%s:%s locked by BIOS\n",
+					rd->rp->name, rd->name, pl_names[i]);
 		}
-	}
 
-	/* check if power limit exists, otherwise domain is monitoring only */
-	for (i = POWER_LIMIT1; i < NR_POWER_LIMITS; i++) {
 		if (rapl_read_pl_data(rd, i, PL_ENABLE, false, &val64))
 			rd->rpl[i].name = NULL;
 	}
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 86cd06bbea0c..325ec00be7a7 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -42,6 +42,7 @@ enum rapl_primitives {
 	POWER_LIMIT4,
 	ENERGY_COUNTER,
 	FW_LOCK,
+	FW_HIGH_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
 	PL1_CLAMP,		/* allow frequency to go below OS request */
@@ -81,6 +82,7 @@ struct rapl_power_limit {
 	struct powercap_zone_constraint *constraint;
 	struct rapl_domain *domain;
 	const char *name;
+	bool locked;
 	u64 last_power_limit;
 };
 
-- 
2.25.1

