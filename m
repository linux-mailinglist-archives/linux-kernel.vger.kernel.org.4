Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7268762880F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiKNSNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiKNSNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880E27FCF;
        Mon, 14 Nov 2022 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449586; x=1699985586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eKMJ7LyFPJ5X6+VzY2jfBd5iMgbFHvueZsgtG6paIVk=;
  b=hb9Hg72kI/uxJq4C9gwVjA1TNMJVa/3xqTI0U08mzcKRMt+Jf3sPmTNR
   y5rphe+GCabcfOOSF32gGX9mEcj6EopMNHzPVIhztgcNXgL+1l+Ki2Bv2
   uUfow8wpZiJ883nat4AXEaIZOvF0LG699i+C/nxiEhsX4EginAkGuMQfq
   siZruOSnY8vRSIWPNgXnKxE4xeIWY6Z0p5Psl7LAcwCGSMfXbYu4FVbn7
   lnBl+biscpaDYLbktKqA57Cb13mT+78XwByhzXHtsvnBGsivUOlvWnleR
   fCzJpUYhEdzssrGcLxsW56Sw1zYdnvXzIkrn0P8IbtYvAStnnRIIm7PxF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292440597"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292440597"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727626771"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727626771"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 10:13:00 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 0136358097C;
        Mon, 14 Nov 2022 10:13:00 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com, David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 5/8] platform/x86: intel/pmc: Relocate Ice Lake PCH support
Date:   Mon, 14 Nov 2022 10:12:04 -0800
Message-Id: <20221114181207.2062901-6-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xi Pardee <xi.pardee@intel.com>

Create icl.c for Ice Lake PCH specific structures and init().
This file supports Ice Lake, Ice Lake NNPI and Jasper Lake platforms.
There are no functional changes involved.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |  2 +-
 drivers/platform/x86/intel/pmc/core.c   | 45 --------------------
 drivers/platform/x86/intel/pmc/core.h   |  3 ++
 drivers/platform/x86/intel/pmc/icl.c    | 56 +++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 46 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/icl.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 2b6d4a8dd2bb..6d153e368da1 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o spt.o cnp.o
+intel_pmc_core-y			:= core.o spt.o cnp.o icl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 1cce586035f9..d75e8cbaf40c 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -60,28 +60,6 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map icl_pfear_map[] = {
-	{"RES_65",		BIT(0)},
-	{"RES_66",		BIT(1)},
-	{"RES_67",		BIT(2)},
-	{"TAM",			BIT(3)},
-	{"GBETSN",		BIT(4)},
-	{"TBTLSX",		BIT(5)},
-	{"RES_71",		BIT(6)},
-	{"RES_72",		BIT(7)},
-	{}
-};
-
-static const struct pmc_bit_map *ext_icl_pfear_map[] = {
-	/*
-	 * Check intel_pmc_core_ids[] users of icl_reg_map for
-	 * a list of core SoCs using this.
-	 */
-	cnp_pfear_map,
-	icl_pfear_map,
-	NULL
-};
-
 static const struct pmc_bit_map tgl_pfear_map[] = {
 	{"PSF9",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -103,24 +81,6 @@ static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
 	NULL
 };
 
-static const struct pmc_reg_map icl_reg_map = {
-	.pfear_sts = ext_icl_pfear_map,
-	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
-	.slp_s0_res_counter_step = ICL_PMC_SLP_S0_RES_COUNTER_STEP,
-	.slps0_dbg_maps = cnp_slps0_dbg_maps,
-	.ltr_show_sts = cnp_ltr_show_map,
-	.msr_sts = msr_map,
-	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
-	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
-	.regmap_length = CNP_PMC_MMIO_REG_LEN,
-	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
-	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
-	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
-	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
-	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
-	.etr3_offset = ETR3_OFFSET,
-};
-
 static const struct pmc_bit_map tgl_clocksource_status_map[] = {
 	{"USB2PLL_OFF_STS",			BIT(18)},
 	{"PCIe/USB3.1_Gen2PLL_OFF_STS",		BIT(19)},
@@ -1589,11 +1549,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
-void icl_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &icl_reg_map;
-}
-
 void tgl_core_configure(struct pmc_dev *pmcdev)
 {
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 2b7d681588cb..2ca564878341 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -351,6 +351,9 @@ extern const struct pmc_bit_map cnp_slps0_dbg2_map[];
 extern const struct pmc_bit_map *cnp_slps0_dbg_maps[];
 extern const struct pmc_bit_map cnp_ltr_show_map[];
 extern const struct pmc_reg_map cnp_reg_map;
+extern const struct pmc_bit_map icl_pfear_map[];
+extern const struct pmc_bit_map *ext_icl_pfear_map[];
+extern const struct pmc_reg_map icl_reg_map;
 
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
new file mode 100644
index 000000000000..2f11b1a6daeb
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Ice Lake PCH.
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include "core.h"
+
+const struct pmc_bit_map icl_pfear_map[] = {
+	{"RES_65",		BIT(0)},
+	{"RES_66",		BIT(1)},
+	{"RES_67",		BIT(2)},
+	{"TAM",			BIT(3)},
+	{"GBETSN",		BIT(4)},
+	{"TBTLSX",		BIT(5)},
+	{"RES_71",		BIT(6)},
+	{"RES_72",		BIT(7)},
+	{}
+};
+
+const struct pmc_bit_map *ext_icl_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of icl_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	cnp_pfear_map,
+	icl_pfear_map,
+	NULL
+};
+
+const struct pmc_reg_map icl_reg_map = {
+	.pfear_sts = ext_icl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = ICL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = ICL_NUM_IP_IGN_ALLOWED,
+	.etr3_offset = ETR3_OFFSET,
+};
+
+void icl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &icl_reg_map;
+}
-- 
2.25.1

