Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76E6BD43C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCPPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCPPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:43:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E7E1938;
        Thu, 16 Mar 2023 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981365; x=1710517365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4GQ0qOCl+Atfv/CQFdipf14nnCdeBWAoGMrWMztiuR8=;
  b=agzQwFECNsNqIX1Sh43Ny+36uORB4dJMYf7x5ZArK+oSzy+v3eXx1fxC
   LjdUuDQrUl1lgmU1eVh/csNn9XptnU17izihAA1FwmZ1YTGppnZ8Jo9oh
   vJIh+d6XhGGhJ9xYtEA/fIbqtqTujuI2ud/EccLzYJ1vVtBLpRPB1qcWa
   6zJCIdbTrMWhZTe7Wqk+qNRDC2+6d2q8Bx+1FculqiV2mRbiOWPNsU1Wp
   5G1sv3yPYlg7lgzWcuN6H1ShGKAmSkV+tczQWUl9HDZD1++AtQpzBccii
   OydvhTzYktN4lEVhmia0eWVQEZ26xNui3DI3oUXMj5dgK/3An5h7vD2KI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339571091"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339571091"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009267198"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009267198"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:39:12 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 13/15] powercap/intel_rapl: Introduce RAPL I/F type
Date:   Thu, 16 Mar 2023 23:38:39 +0800
Message-Id: <20230316153841.3666-14-rui.zhang@intel.com>
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

Different RAPL Interfaces may have different primitive information and
rapl_defaults calls.

To better distinguish this difference in the RAPL framework code,
introduce a new enum to represent different types of RAPL Interfaces.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c           | 18 +++++++++++++-----
 drivers/powercap/intel_rapl_msr.c              |  2 ++
 .../int340x_thermal/processor_thermal_rapl.c   |  1 +
 include/linux/intel_rapl.h                     |  6 ++++++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a6a7d048d0b4..7e79066bcbcb 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -177,7 +177,7 @@ struct rapl_defaults {
 	unsigned int psys_domain_energy_unit;
 	bool spr_psys_bits;
 };
-static struct rapl_defaults *rapl_defaults;
+static struct rapl_defaults *rpd_msr;
 
 static struct rapl_defaults *get_rpd(struct rapl_package *rp)
 {
@@ -601,7 +601,7 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 	return div64_u64(value, scale);
 }
 
-static struct rapl_primitive_info rpis_default[NR_RAPL_PRIMITIVES] = {
+static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
 	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
 			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
@@ -670,8 +670,16 @@ static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
 
 static int rapl_config(struct rapl_package *rp)
 {
-	rp->priv->rpd = (void *)rapl_defaults;
-	rp->priv->rpi = (void *)rpis_default;
+	switch (rp->priv->type) {
+	/* MMIO I/F shares the same register layout as MSR registers */
+	case RAPL_IF_MMIO:
+	case RAPL_IF_MSR:
+		rp->priv->rpd = (void *)rpd_msr;
+		rp->priv->rpi = (void *)rpi_msr;
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1536,7 +1544,7 @@ static int __init rapl_init(void)
 
 	id = x86_match_cpu(rapl_ids);
 	if (id) {
-		rapl_defaults = (struct rapl_defaults *)id->driver_data;
+		rpd_msr = (struct rapl_defaults *)id->driver_data;
 
 		rapl_msr_platdev = platform_device_alloc("intel_rapl_msr", 0);
 		if (!rapl_msr_platdev)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 3e48e729050d..73c8bbcfc1bd 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -34,6 +34,7 @@
 static struct rapl_if_priv *rapl_msr_priv;
 
 static struct rapl_if_priv rapl_msr_priv_intel = {
+	.type = RAPL_IF_MSR,
 	.reg_unit = MSR_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE] = {
 		MSR_PKG_POWER_LIMIT, MSR_PKG_ENERGY_STATUS, MSR_PKG_PERF_STATUS, 0, MSR_PKG_POWER_INFO },
@@ -50,6 +51,7 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 };
 
 static struct rapl_if_priv rapl_msr_priv_amd = {
+	.type = RAPL_IF_MSR,
 	.reg_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.regs[RAPL_DOMAIN_PACKAGE] = {
 		0, MSR_AMD_PKG_ENERGY_STATUS, 0, 0, 0 },
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 140fb85cfa7b..013f1633f082 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -97,6 +97,7 @@ int proc_thermal_rapl_add(struct pci_dev *pdev, struct proc_thermal_device *proc
 						rapl_regs->regs[domain][reg];
 		rapl_mmio_priv.limits[domain] = rapl_regs->limits[domain];
 	}
+	rapl_mmio_priv.type = RAPL_IF_MMIO;
 	rapl_mmio_priv.reg_unit = (u64)proc_priv->mmio_base + rapl_regs->reg_unit;
 
 	rapl_mmio_priv.read_raw = rapl_mmio_read_raw;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index d92ded956140..e5a7b47ceac9 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -14,6 +14,11 @@
 #include <linux/powercap.h>
 #include <linux/cpuhotplug.h>
 
+enum rapl_if_type {
+	RAPL_IF_MSR,	/* RAPL I/F using MSR registers */
+	RAPL_IF_MMIO,	/* RAPL I/F using MMIO registers */
+};
+
 enum rapl_domain_type {
 	RAPL_DOMAIN_PACKAGE,	/* entire package/socket */
 	RAPL_DOMAIN_PP0,	/* core power plane */
@@ -130,6 +135,7 @@ struct reg_action {
  * @rpi:			internal pointer to interface primitive info
  */
 struct rapl_if_priv {
+	enum rapl_if_type type;
 	struct powercap_control_type *control_type;
 	enum cpuhp_state pcap_rapl_online;
 	u64 reg_unit;
-- 
2.25.1

