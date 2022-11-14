Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B82628813
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbiKNSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238334AbiKNSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:27 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1EF20;
        Mon, 14 Nov 2022 10:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449605; x=1699985605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TueCXRNMxjjOdUld3YEg3z30ob9dpB+/D+OUzEGkOrw=;
  b=Su1r+A+lGH2A/2r5s+EGtKVwvXqXtM6ScIP0MCaGWoPSsprJ03z5jwd1
   tQ+a3okZZjvg2QG+3tEYDJj6ZjjDvLoMV/pTFIlKBDZpRRsWzwsx5U69B
   +9nMB/G4gC/68HK4b5MBkqOOurWKNHBJDjNQGYcqq0/ssoRjnoCdBeN2s
   TDatWVW+iVNIQktpPeTCHozSmJyCtAS5bTZw10D/VtQQzaYIkkPKlGsHq
   BEYV6+MILrdCwcxQkl5p1dG0gUwwl//5ObGb47nIW71sL2Co+vpdP2BvC
   IWefrEoJIsbXoyOYacsClqBnS0ggTBKgT8Tf40RYr8j45xAhyHSZUospy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="338832550"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="338832550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="813358477"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="813358477"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2022 10:13:24 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 8C7E858097C;
        Mon, 14 Nov 2022 10:13:24 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 8/8] platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core driver
Date:   Mon, 14 Nov 2022 10:12:07 -0800
Message-Id: <20221114181207.2062901-9-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Meteor Lake client and mobile support to pmc core driver. This patch
adds legacy support.

Cc: David E Box <david.e.box@linux.intel.com>
Suggested-by: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |  2 +-
 drivers/platform/x86/intel/pmc/core.c   |  7 +++-
 drivers/platform/x86/intel/pmc/core.h   | 13 +++++++
 drivers/platform/x86/intel/pmc/mtl.c    | 52 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/mtl.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 0135918ea718..f96bc2e19503 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -4,7 +4,7 @@
 #
 
 intel_pmc_core-y			:= core.o spt.o cnp.o icl.o tgl.o \
-					   adl.o
+					   adl.o mtl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 14dfeac73521..f1d802f6ec3f 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -901,7 +901,11 @@ static void pmc_core_get_low_power_modes(struct platform_device *pdev)
 		return;
 
 	lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
-	pmcdev->num_lpm_modes = hweight32(lpm_en);
+	/* For MTL, BIT 31 is not an lpm mode but a enable bit.
+	 * Lower byte is enough to cover the number of lpm modes for all
+	 * platforms and hence mask the upper 3 bytes.
+	 */
+	pmcdev->num_lpm_modes = hweight32(lpm_en & 0xFF);
 
 	/* Read 32 bit LPM_PRI register */
 	lpm_pri = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_priority_offset);
@@ -1024,6 +1028,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          mtl_core_init),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 129c0c98f1a6..810204d758ab 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -238,6 +238,16 @@ enum ppfear_regs {
 #define ADL_LPM_STATUS_LATCH_EN_OFFSET		0x1704
 #define ADL_LPM_LIVE_STATUS_OFFSET		0x1764
 
+/* Meteor Lake Power Management Controller register offsets */
+#define MTL_LPM_EN_OFFSET			0x1798
+#define MTL_LPM_RESIDENCY_OFFSET		0x17A0
+
+/* Meteor Lake Low Power Mode debug registers */
+#define MTL_LPM_PRI_OFFSET			0x179C
+#define MTL_LPM_STATUS_LATCH_EN_OFFSET		0x16F8
+#define MTL_LPM_STATUS_OFFSET			0x1700
+#define MTL_LPM_LIVE_STATUS_OFFSET		0x175C
+
 extern const char *pmc_lpm_modes[];
 
 struct pmc_bit_map {
@@ -383,6 +393,7 @@ extern const struct pmc_bit_map adl_vnn_req_status_3_map[];
 extern const struct pmc_bit_map adl_vnn_misc_status_map[];
 extern const struct pmc_bit_map *adl_lpm_maps[];
 extern const struct pmc_reg_map adl_reg_map;
+extern const struct pmc_reg_map mtl_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
@@ -392,8 +403,10 @@ void cnp_core_init(struct pmc_dev *pmcdev);
 void icl_core_init(struct pmc_dev *pmcdev);
 void tgl_core_init(struct pmc_dev *pmcdev);
 void adl_core_init(struct pmc_dev *pmcdev);
+void mtl_core_init(struct pmc_dev *pmcdev);
 void tgl_core_configure(struct pmc_dev *pmcdev);
 void adl_core_configure(struct pmc_dev *pmcdev);
+void mtl_core_configure(struct pmc_dev *pmcdev);
 
 #define pmc_for_each_mode(i, mode, pmcdev)		\
 	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
new file mode 100644
index 000000000000..eeb3bd8c2502
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Meteor Lake PCH.
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include "core.h"
+
+const struct pmc_reg_map mtl_reg_map = {
+	.pfear_sts = ext_tgl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.ltr_show_sts = adl_ltr_show_map,
+	.msr_sts = msr_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = ADL_NUM_IP_IGN_ALLOWED,
+	.lpm_num_modes = ADL_LPM_NUM_MODES,
+	.lpm_num_maps = ADL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.etr3_offset = ETR3_OFFSET,
+	.lpm_sts_latch_en_offset = MTL_LPM_STATUS_LATCH_EN_OFFSET,
+	.lpm_priority_offset = MTL_LPM_PRI_OFFSET,
+	.lpm_en_offset = MTL_LPM_EN_OFFSET,
+	.lpm_residency_offset = MTL_LPM_RESIDENCY_OFFSET,
+	.lpm_sts = adl_lpm_maps,
+	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+};
+
+void mtl_core_configure(struct pmc_dev *pmcdev)
+{
+	/* Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
+	 */
+	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
+	pmc_core_send_ltr_ignore(pmcdev, 3);
+}
+
+void mtl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &mtl_reg_map;
+	pmcdev->core_configure = mtl_core_configure;
+}
-- 
2.25.1

