Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BB6BD43E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCPPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCPPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:43:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001302197C;
        Thu, 16 Mar 2023 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981375; x=1710517375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhgqSNBcFEaqD2pgrxFzkPcdx9DgTm+GYplXJSHR7CQ=;
  b=HcOelp46oLZRGNuIwTChwcjKpNI+F0H7wW1EaKe0q1XU+kOvrTJvLegW
   I6iTVT9AT0w3PGv2eG39F3ml4bpAvKcDHE35XWV/EFvlJ1SYTEUKsURPm
   NzmhiWaRdsgOrxrViMwcSzZaYG3/k0diQDbBTdjOSS7ynrISexHI/VfOK
   raV7Xlps1DofwKDVVtNDxFy+eT+xeTit/c8iDP2MdmuPewoINmVii6t4C
   PF3LRS6EUkHL4xizjen3XvWuC8oRGq38idiKTPfwuXaJilhoEf9vISnBK
   Y1kRU+D/ZP0IBXrP7/EfN4YhIoVcYwYli4SFEnKaU+YbiaeLQ8NWPBVq8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571100"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571100"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267220"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267220"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:14 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 14/15] powercap/intel_rapl: Introduce core support for TPMI interface
Date:   Thu, 16 Mar 2023 23:38:40 +0800
Message-Id: <20230316153841.3666-15-rui.zhang@intel.com>
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

Compared with existing RAPL MSR/MMIO Interface, the RAPL TPMI Interface
1. has per Power Limit register, thus has per Power Limit Lock and
   Enable bit.
2. doesn't have Power Limit Clamp bit.
3. the Power Limit Lock and Enable bits have different bit offsets.
These mean RAPL TPMI Interface needs its own primitive information.

RAPL TPMI Interface also has per domain unit register but with a
different register layout. This requires a TPMI specific rapl_defaults
call to decode the unit register.

Introduce the RAPL core support for TPMI Interface.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 126 +++++++++++++++++++++++++--
 include/linux/intel_rapl.h           |   5 ++
 2 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 7e79066bcbcb..ef0b180fd8b7 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -75,6 +75,15 @@
 #define PSYS_TIME_WINDOW1_MASK       (0x7FULL<<19)
 #define PSYS_TIME_WINDOW2_MASK       (0x7FULL<<51)
 
+/* bitmasks for RAPL TPMI, used by primitive access functions */
+#define TPMI_POWER_LIMIT_MASK	0x3FFFF
+#define TPMI_POWER_LIMIT_ENABLE	BIT_ULL(62)
+#define TPMI_TIME_WINDOW_MASK	(0x7FULL<<18)
+#define TPMI_INFO_SPEC_MASK	0x3FFFF
+#define TPMI_INFO_MIN_MASK	(0x3FFFFULL << 18)
+#define TPMI_INFO_MAX_MASK	(0x3FFFFULL << 36)
+#define TPMI_INFO_MAX_TIME_WIN_MASK	(0x7FULL << 54)
+
 /* Non HW constants */
 #define RAPL_PRIMITIVE_DERIVED       BIT(1)	/* not from raw data */
 #define RAPL_PRIMITIVE_DUMMY         BIT(2)
@@ -123,7 +132,7 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 	case POWER_LIMIT1:
 		if (prim == PL_ENABLE)
 			return PL1_ENABLE;
-		if (prim == PL_CLAMP)
+		if (prim == PL_CLAMP && rd->rp->priv->type != RAPL_IF_TPMI)
 			return PL1_CLAMP;
 		if (prim == PL_LIMIT)
 			return POWER_LIMIT1;
@@ -131,14 +140,18 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 			return TIME_WINDOW1;
 		if (prim == PL_MAX_POWER)
 			return THERMAL_SPEC_POWER;
-		if (prim == PL_LOCK)
-			return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
-			       FW_HIGH_LOCK : FW_LOCK;
+		if (prim == PL_LOCK) {
+			if (rd->rp->priv->type == RAPL_IF_TPMI)
+				return PL1_LOCK;
+			else
+				return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
+				       FW_HIGH_LOCK : FW_LOCK;
+		}
 		return -EINVAL;
 	case POWER_LIMIT2:
 		if (prim == PL_ENABLE)
 			return PL2_ENABLE;
-		if (prim == PL_CLAMP)
+		if (prim == PL_CLAMP && rd->rp->priv->type != RAPL_IF_TPMI)
 			return PL2_CLAMP;
 		if (prim == PL_LIMIT)
 			return POWER_LIMIT2;
@@ -146,9 +159,13 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 			return TIME_WINDOW2;
 		if (prim == PL_MAX_POWER)
 			return MAX_POWER;
-		if (prim == PL_LOCK)
-			return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
-			       FW_HIGH_LOCK : FW_LOCK;
+		if (prim == PL_LOCK) {
+			if (rd->rp->priv->type == RAPL_IF_TPMI)
+				return PL2_LOCK;
+			else
+				return rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2) ?
+				       FW_HIGH_LOCK : FW_LOCK;
+		}
 		return -EINVAL;
 	case POWER_LIMIT4:
 		if (prim == PL_LIMIT)
@@ -158,6 +175,8 @@ static int get_pl_prim(struct rapl_domain *rd, int pl, enum pl_prims prim)
 		/* PL4 would be around two times PL2, use same prim as PL2. */
 		if (prim == PL_MAX_POWER)
 			return MAX_POWER;
+		if (prim == PL_LOCK && rd->rp->priv->type == RAPL_IF_TPMI)
+			return PL4_LOCK;
 		return -EINVAL;
 	default:
 		return -EINVAL;
@@ -178,6 +197,7 @@ struct rapl_defaults {
 	bool spr_psys_bits;
 };
 static struct rapl_defaults *rpd_msr;
+static const struct rapl_defaults rapl_defaults_tpmi;
 
 static struct rapl_defaults *get_rpd(struct rapl_package *rp)
 {
@@ -601,6 +621,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	return div64_u64(value, scale);
 }
 
+/* RAPL primitives for MSR and MMIO I/F */
 static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
 	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
@@ -658,6 +679,48 @@ static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 			    RAPL_PRIMITIVE_DERIVED),
 };
 
+/* RAPL primitives for TPMI I/F */
+static struct rapl_primitive_info rpi_tpmi[NR_RAPL_PRIMITIVES] = {
+	/* name, mask, shift, msr index, unit divisor */
+	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, TPMI_POWER_LIMIT_MASK, 0,
+		RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, TPMI_POWER_LIMIT_MASK, 0,
+		RAPL_DOMAIN_REG_PL2, POWER_UNIT, 0),
+	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, TPMI_POWER_LIMIT_MASK, 0,
+		RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+		RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[PL1_LOCK] = PRIMITIVE_INFO_INIT(PL1_LOCK, POWER_HIGH_LOCK, 63,
+		RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_LOCK] = PRIMITIVE_INFO_INIT(PL2_LOCK, POWER_HIGH_LOCK, 63,
+		RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_LOCK] = PRIMITIVE_INFO_INIT(PL4_LOCK, POWER_HIGH_LOCK, 63,
+		RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+		RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE] = PRIMITIVE_INFO_INIT(PL2_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+		RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+		RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TPMI_TIME_WINDOW_MASK, 18,
+		RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TPMI_TIME_WINDOW_MASK, 18,
+		RAPL_DOMAIN_REG_PL2, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER] = PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, TPMI_INFO_SPEC_MASK, 0,
+		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER] = PRIMITIVE_INFO_INIT(MAX_POWER, TPMI_INFO_MAX_MASK, 36,
+		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER] = PRIMITIVE_INFO_INIT(MIN_POWER, TPMI_INFO_MIN_MASK, 18,
+		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW] = PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, TPMI_INFO_MAX_TIME_WIN_MASK, 54,
+		RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME] = PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
+		RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+	/* non-hardware */
+	[AVERAGE_POWER] = PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0,
+		POWER_UNIT, RAPL_PRIMITIVE_DERIVED),
+};
+
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 {
 	struct rapl_primitive_info *rpi = rp->priv->rpi;
@@ -677,6 +740,10 @@ static int rapl_config(struct rapl_package *rp)
 		rp->priv->rpd = (void *)rpd_msr;
 		rp->priv->rpi = (void *)rpi_msr;
 		break;
+	case RAPL_IF_TPMI:
+		rp->priv->rpd = (void *)&rapl_defaults_tpmi;
+		rp->priv->rpi = (void *)rpi_tpmi;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1037,6 +1104,49 @@ static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 	return value;
 }
 
+/* TPMI Unit register has different layout */
+#define TPMI_POWER_UNIT_OFFSET	POWER_UNIT_OFFSET
+#define TPMI_POWER_UNIT_MASK	POWER_UNIT_MASK
+#define TPMI_ENERGY_UNIT_OFFSET	0x06
+#define TPMI_ENERGY_UNIT_MASK	0x7C0
+#define TPMI_TIME_UNIT_OFFSET	0x0C
+#define TPMI_TIME_UNIT_MASK	0xF000
+
+static int rapl_check_unit_tpmi(struct rapl_domain *rd)
+{
+	struct reg_action ra;
+	u32 value;
+
+	ra.reg = rd->regs[RAPL_DOMAIN_REG_UNIT];
+	ra.mask = ~0;
+	if (rd->rp->priv->read_raw(get_rid(rd->rp), &ra)) {
+		pr_err("Failed to read power unit REG 0x%llx on %s:%s, exit.\n",
+			ra.reg, rd->rp->name, rd->name);
+		return -ENODEV;
+	}
+
+	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
+	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+
+	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
+	rd->power_unit = 1000000 / (1 << value);
+
+	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
+	rd->time_unit = 1000000 / (1 << value);
+
+	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
+		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
+
+	return 0;
+}
+
+static const struct rapl_defaults rapl_defaults_tpmi = {
+	.check_unit = rapl_check_unit_tpmi,
+	/* Reuse existing logic, ignore the PL_CLAMP failures and enable all Power Limits */
+	.set_floor_freq = set_floor_freq_default,
+	.compute_time_window = rapl_compute_time_window_core,
+};
+
 static const struct rapl_defaults rapl_defaults_core = {
 	.floor_freq_reg_addr = 0,
 	.check_unit = rapl_check_unit_core,
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index e5a7b47ceac9..2d5e75c6a67c 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -17,6 +17,7 @@
 enum rapl_if_type {
 	RAPL_IF_MSR,	/* RAPL I/F using MSR registers */
 	RAPL_IF_MMIO,	/* RAPL I/F using MMIO registers */
+	RAPL_IF_TPMI,	/* RAPL I/F using TPMI registers */
 };
 
 enum rapl_domain_type {
@@ -36,6 +37,7 @@ enum rapl_domain_reg_id {
 	RAPL_DOMAIN_REG_INFO,
 	RAPL_DOMAIN_REG_PL4,
 	RAPL_DOMAIN_REG_UNIT,
+	RAPL_DOMAIN_REG_PL2,
 	RAPL_DOMAIN_REG_MAX,
 };
 
@@ -48,6 +50,9 @@ enum rapl_primitives {
 	ENERGY_COUNTER,
 	FW_LOCK,
 	FW_HIGH_LOCK,
+	PL1_LOCK,
+	PL2_LOCK,
+	PL4_LOCK,
 
 	PL1_ENABLE,		/* power limit 1, aka long term */
 	PL1_CLAMP,		/* allow frequency to go below OS request */
-- 
2.25.1

