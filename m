Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC51E62880A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238294AbiKNSNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiKNSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DD240A6;
        Mon, 14 Nov 2022 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449576; x=1699985576;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mR24jK6uyciuagee6d+slhFkxGxNismeOypB70bcrWU=;
  b=jC12v/qqE50IxLHs/1SUZoS2+0ae6roCtd+EZ1/DTkmEXmuCIDOUKouw
   Ff+5qcELKWtYvUpni/92TUgJqmbHtIUbZ+bbuWzZzwt3hGKiEe4YT2YWz
   Dxvkdj1w5lnijPIvR5nVDhtYk8aS8kBxt7pRNpU8WOkWtWelWiBRZPSLA
   Ubuju00y5UxZ0OZxlp8DhGdorxrXpP1bxg+6Jw7uGKZnQtAkFpRhaZDBk
   kbLSMGGiBK2WgmI8qYAhAH6qMRwxOvjq7FwYfqs+m4LiBsZCf5UTgbCNB
   Py4kE0Ep5C/A4PKYBoYJNazBJ/GsTgUC6Bd5CXSyokjBS2RCCT/nVnA3r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="313849564"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="313849564"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967673047"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="967673047"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 10:12:55 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id F0E8C58097C;
        Mon, 14 Nov 2022 10:12:54 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 3/8] platform/x86: intel/pmc: Relocate Sunrise Point PCH support
Date:   Mon, 14 Nov 2022 10:12:02 -0800
Message-Id: <20221114181207.2062901-4-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Create spt.c for Sunrise Point PCH specific structures and init().
This file supports Sky Lake and Kaby Lake platforms. There are no
functional changes involved.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |   2 +-
 drivers/platform/x86/intel/pmc/core.c   | 129 ----------------------
 drivers/platform/x86/intel/pmc/core.h   |   7 ++
 drivers/platform/x86/intel/pmc/spt.c    | 140 ++++++++++++++++++++++++
 4 files changed, 148 insertions(+), 130 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/spt.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 8966fcdc0e1d..1b2104e0c97f 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o
+intel_pmc_core-y			:= core.o spt.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index cfa654672cba..18b6e87f7c73 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -60,130 +60,6 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map spt_pll_map[] = {
-	{"MIPI PLL",			SPT_PMC_BIT_MPHY_CMN_LANE0},
-	{"GEN2 USB2PCIE2 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE1},
-	{"DMIPCIE3 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE2},
-	{"SATA PLL",			SPT_PMC_BIT_MPHY_CMN_LANE3},
-	{}
-};
-
-static const struct pmc_bit_map spt_mphy_map[] = {
-	{"MPHY CORE LANE 0",           SPT_PMC_BIT_MPHY_LANE0},
-	{"MPHY CORE LANE 1",           SPT_PMC_BIT_MPHY_LANE1},
-	{"MPHY CORE LANE 2",           SPT_PMC_BIT_MPHY_LANE2},
-	{"MPHY CORE LANE 3",           SPT_PMC_BIT_MPHY_LANE3},
-	{"MPHY CORE LANE 4",           SPT_PMC_BIT_MPHY_LANE4},
-	{"MPHY CORE LANE 5",           SPT_PMC_BIT_MPHY_LANE5},
-	{"MPHY CORE LANE 6",           SPT_PMC_BIT_MPHY_LANE6},
-	{"MPHY CORE LANE 7",           SPT_PMC_BIT_MPHY_LANE7},
-	{"MPHY CORE LANE 8",           SPT_PMC_BIT_MPHY_LANE8},
-	{"MPHY CORE LANE 9",           SPT_PMC_BIT_MPHY_LANE9},
-	{"MPHY CORE LANE 10",          SPT_PMC_BIT_MPHY_LANE10},
-	{"MPHY CORE LANE 11",          SPT_PMC_BIT_MPHY_LANE11},
-	{"MPHY CORE LANE 12",          SPT_PMC_BIT_MPHY_LANE12},
-	{"MPHY CORE LANE 13",          SPT_PMC_BIT_MPHY_LANE13},
-	{"MPHY CORE LANE 14",          SPT_PMC_BIT_MPHY_LANE14},
-	{"MPHY CORE LANE 15",          SPT_PMC_BIT_MPHY_LANE15},
-	{}
-};
-
-static const struct pmc_bit_map spt_pfear_map[] = {
-	{"PMC",				SPT_PMC_BIT_PMC},
-	{"OPI-DMI",			SPT_PMC_BIT_OPI},
-	{"SPI / eSPI",			SPT_PMC_BIT_SPI},
-	{"XHCI",			SPT_PMC_BIT_XHCI},
-	{"SPA",				SPT_PMC_BIT_SPA},
-	{"SPB",				SPT_PMC_BIT_SPB},
-	{"SPC",				SPT_PMC_BIT_SPC},
-	{"GBE",				SPT_PMC_BIT_GBE},
-	{"SATA",			SPT_PMC_BIT_SATA},
-	{"HDA-PGD0",			SPT_PMC_BIT_HDA_PGD0},
-	{"HDA-PGD1",			SPT_PMC_BIT_HDA_PGD1},
-	{"HDA-PGD2",			SPT_PMC_BIT_HDA_PGD2},
-	{"HDA-PGD3",			SPT_PMC_BIT_HDA_PGD3},
-	{"RSVD",			SPT_PMC_BIT_RSVD_0B},
-	{"LPSS",			SPT_PMC_BIT_LPSS},
-	{"LPC",				SPT_PMC_BIT_LPC},
-	{"SMB",				SPT_PMC_BIT_SMB},
-	{"ISH",				SPT_PMC_BIT_ISH},
-	{"P2SB",			SPT_PMC_BIT_P2SB},
-	{"DFX",				SPT_PMC_BIT_DFX},
-	{"SCC",				SPT_PMC_BIT_SCC},
-	{"RSVD",			SPT_PMC_BIT_RSVD_0C},
-	{"FUSE",			SPT_PMC_BIT_FUSE},
-	{"CAMERA",			SPT_PMC_BIT_CAMREA},
-	{"RSVD",			SPT_PMC_BIT_RSVD_0D},
-	{"USB3-OTG",			SPT_PMC_BIT_USB3_OTG},
-	{"EXI",				SPT_PMC_BIT_EXI},
-	{"CSE",				SPT_PMC_BIT_CSE},
-	{"CSME_KVM",			SPT_PMC_BIT_CSME_KVM},
-	{"CSME_PMT",			SPT_PMC_BIT_CSME_PMT},
-	{"CSME_CLINK",			SPT_PMC_BIT_CSME_CLINK},
-	{"CSME_PTIO",			SPT_PMC_BIT_CSME_PTIO},
-	{"CSME_USBR",			SPT_PMC_BIT_CSME_USBR},
-	{"CSME_SUSRAM",			SPT_PMC_BIT_CSME_SUSRAM},
-	{"CSME_SMT",			SPT_PMC_BIT_CSME_SMT},
-	{"RSVD",			SPT_PMC_BIT_RSVD_1A},
-	{"CSME_SMS2",			SPT_PMC_BIT_CSME_SMS2},
-	{"CSME_SMS1",			SPT_PMC_BIT_CSME_SMS1},
-	{"CSME_RTC",			SPT_PMC_BIT_CSME_RTC},
-	{"CSME_PSF",			SPT_PMC_BIT_CSME_PSF},
-	{}
-};
-
-static const struct pmc_bit_map *ext_spt_pfear_map[] = {
-	/*
-	 * Check intel_pmc_core_ids[] users of spt_reg_map for
-	 * a list of core SoCs using this.
-	 */
-	spt_pfear_map,
-	NULL
-};
-
-static const struct pmc_bit_map spt_ltr_show_map[] = {
-	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
-	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
-	{"SATA",		SPT_PMC_LTR_SATA},
-	{"GIGABIT_ETHERNET",	SPT_PMC_LTR_GBE},
-	{"XHCI",		SPT_PMC_LTR_XHCI},
-	{"Reserved",		SPT_PMC_LTR_RESERVED},
-	{"ME",			SPT_PMC_LTR_ME},
-	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
-	{"EVA",			SPT_PMC_LTR_EVA},
-	{"SOUTHPORT_C",		SPT_PMC_LTR_SPC},
-	{"HD_AUDIO",		SPT_PMC_LTR_AZ},
-	{"LPSS",		SPT_PMC_LTR_LPSS},
-	{"SOUTHPORT_D",		SPT_PMC_LTR_SPD},
-	{"SOUTHPORT_E",		SPT_PMC_LTR_SPE},
-	{"CAMERA",		SPT_PMC_LTR_CAM},
-	{"ESPI",		SPT_PMC_LTR_ESPI},
-	{"SCC",			SPT_PMC_LTR_SCC},
-	{"ISH",			SPT_PMC_LTR_ISH},
-	/* Below two cannot be used for LTR_IGNORE */
-	{"CURRENT_PLATFORM",	SPT_PMC_LTR_CUR_PLT},
-	{"AGGREGATED_SYSTEM",	SPT_PMC_LTR_CUR_ASLT},
-	{}
-};
-
-static const struct pmc_reg_map spt_reg_map = {
-	.pfear_sts = ext_spt_pfear_map,
-	.mphy_sts = spt_mphy_map,
-	.pll_sts = spt_pll_map,
-	.ltr_show_sts = spt_ltr_show_map,
-	.msr_sts = msr_map,
-	.slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
-	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
-	.ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
-	.regmap_length = SPT_PMC_MMIO_REG_LEN,
-	.ppfear0_offset = SPT_PMC_XRAM_PPFEAR0A,
-	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
-	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
-	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
-	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
-	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
-};
-
 /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 static const struct pmc_bit_map cnp_pfear_map[] = {
 	{"PMC",                 BIT(0)},
@@ -1907,11 +1783,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
-void spt_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &spt_reg_map;
-}
-
 void cnp_core_init(struct pmc_dev *pmcdev)
 {
 	pmcdev->map = &cnp_reg_map;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index b4279ed59bbe..65189353cc2b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -337,6 +337,13 @@ struct pmc_dev {
 };
 
 extern const struct pmc_bit_map msr_map[];
+extern const struct pmc_bit_map spt_pll_map[];
+extern const struct pmc_bit_map spt_mphy_map[];
+extern const struct pmc_bit_map spt_pfear_map[];
+extern const struct pmc_bit_map *ext_spt_pfear_map[];
+extern const struct pmc_bit_map spt_ltr_show_map[];
+extern const struct pmc_reg_map spt_reg_map;
+
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
 void icl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
new file mode 100644
index 000000000000..e16982236778
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Sunrise Point PCH.
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include "core.h"
+
+const struct pmc_bit_map spt_pll_map[] = {
+	{"MIPI PLL",			SPT_PMC_BIT_MPHY_CMN_LANE0},
+	{"GEN2 USB2PCIE2 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE1},
+	{"DMIPCIE3 PLL",		SPT_PMC_BIT_MPHY_CMN_LANE2},
+	{"SATA PLL",			SPT_PMC_BIT_MPHY_CMN_LANE3},
+	{}
+};
+
+const struct pmc_bit_map spt_mphy_map[] = {
+	{"MPHY CORE LANE 0",           SPT_PMC_BIT_MPHY_LANE0},
+	{"MPHY CORE LANE 1",           SPT_PMC_BIT_MPHY_LANE1},
+	{"MPHY CORE LANE 2",           SPT_PMC_BIT_MPHY_LANE2},
+	{"MPHY CORE LANE 3",           SPT_PMC_BIT_MPHY_LANE3},
+	{"MPHY CORE LANE 4",           SPT_PMC_BIT_MPHY_LANE4},
+	{"MPHY CORE LANE 5",           SPT_PMC_BIT_MPHY_LANE5},
+	{"MPHY CORE LANE 6",           SPT_PMC_BIT_MPHY_LANE6},
+	{"MPHY CORE LANE 7",           SPT_PMC_BIT_MPHY_LANE7},
+	{"MPHY CORE LANE 8",           SPT_PMC_BIT_MPHY_LANE8},
+	{"MPHY CORE LANE 9",           SPT_PMC_BIT_MPHY_LANE9},
+	{"MPHY CORE LANE 10",          SPT_PMC_BIT_MPHY_LANE10},
+	{"MPHY CORE LANE 11",          SPT_PMC_BIT_MPHY_LANE11},
+	{"MPHY CORE LANE 12",          SPT_PMC_BIT_MPHY_LANE12},
+	{"MPHY CORE LANE 13",          SPT_PMC_BIT_MPHY_LANE13},
+	{"MPHY CORE LANE 14",          SPT_PMC_BIT_MPHY_LANE14},
+	{"MPHY CORE LANE 15",          SPT_PMC_BIT_MPHY_LANE15},
+	{}
+};
+
+const struct pmc_bit_map spt_pfear_map[] = {
+	{"PMC",				SPT_PMC_BIT_PMC},
+	{"OPI-DMI",			SPT_PMC_BIT_OPI},
+	{"SPI / eSPI",			SPT_PMC_BIT_SPI},
+	{"XHCI",			SPT_PMC_BIT_XHCI},
+	{"SPA",				SPT_PMC_BIT_SPA},
+	{"SPB",				SPT_PMC_BIT_SPB},
+	{"SPC",				SPT_PMC_BIT_SPC},
+	{"GBE",				SPT_PMC_BIT_GBE},
+	{"SATA",			SPT_PMC_BIT_SATA},
+	{"HDA-PGD0",			SPT_PMC_BIT_HDA_PGD0},
+	{"HDA-PGD1",			SPT_PMC_BIT_HDA_PGD1},
+	{"HDA-PGD2",			SPT_PMC_BIT_HDA_PGD2},
+	{"HDA-PGD3",			SPT_PMC_BIT_HDA_PGD3},
+	{"RSVD",			SPT_PMC_BIT_RSVD_0B},
+	{"LPSS",			SPT_PMC_BIT_LPSS},
+	{"LPC",				SPT_PMC_BIT_LPC},
+	{"SMB",				SPT_PMC_BIT_SMB},
+	{"ISH",				SPT_PMC_BIT_ISH},
+	{"P2SB",			SPT_PMC_BIT_P2SB},
+	{"DFX",				SPT_PMC_BIT_DFX},
+	{"SCC",				SPT_PMC_BIT_SCC},
+	{"RSVD",			SPT_PMC_BIT_RSVD_0C},
+	{"FUSE",			SPT_PMC_BIT_FUSE},
+	{"CAMERA",			SPT_PMC_BIT_CAMREA},
+	{"RSVD",			SPT_PMC_BIT_RSVD_0D},
+	{"USB3-OTG",			SPT_PMC_BIT_USB3_OTG},
+	{"EXI",				SPT_PMC_BIT_EXI},
+	{"CSE",				SPT_PMC_BIT_CSE},
+	{"CSME_KVM",			SPT_PMC_BIT_CSME_KVM},
+	{"CSME_PMT",			SPT_PMC_BIT_CSME_PMT},
+	{"CSME_CLINK",			SPT_PMC_BIT_CSME_CLINK},
+	{"CSME_PTIO",			SPT_PMC_BIT_CSME_PTIO},
+	{"CSME_USBR",			SPT_PMC_BIT_CSME_USBR},
+	{"CSME_SUSRAM",			SPT_PMC_BIT_CSME_SUSRAM},
+	{"CSME_SMT",			SPT_PMC_BIT_CSME_SMT},
+	{"RSVD",			SPT_PMC_BIT_RSVD_1A},
+	{"CSME_SMS2",			SPT_PMC_BIT_CSME_SMS2},
+	{"CSME_SMS1",			SPT_PMC_BIT_CSME_SMS1},
+	{"CSME_RTC",			SPT_PMC_BIT_CSME_RTC},
+	{"CSME_PSF",			SPT_PMC_BIT_CSME_PSF},
+	{}
+};
+
+const struct pmc_bit_map *ext_spt_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of spt_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	spt_pfear_map,
+	NULL
+};
+
+const struct pmc_bit_map spt_ltr_show_map[] = {
+	{"SOUTHPORT_A",		SPT_PMC_LTR_SPA},
+	{"SOUTHPORT_B",		SPT_PMC_LTR_SPB},
+	{"SATA",		SPT_PMC_LTR_SATA},
+	{"GIGABIT_ETHERNET",	SPT_PMC_LTR_GBE},
+	{"XHCI",		SPT_PMC_LTR_XHCI},
+	{"Reserved",		SPT_PMC_LTR_RESERVED},
+	{"ME",			SPT_PMC_LTR_ME},
+	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
+	{"EVA",			SPT_PMC_LTR_EVA},
+	{"SOUTHPORT_C",		SPT_PMC_LTR_SPC},
+	{"HD_AUDIO",		SPT_PMC_LTR_AZ},
+	{"LPSS",		SPT_PMC_LTR_LPSS},
+	{"SOUTHPORT_D",		SPT_PMC_LTR_SPD},
+	{"SOUTHPORT_E",		SPT_PMC_LTR_SPE},
+	{"CAMERA",		SPT_PMC_LTR_CAM},
+	{"ESPI",		SPT_PMC_LTR_ESPI},
+	{"SCC",			SPT_PMC_LTR_SCC},
+	{"ISH",			SPT_PMC_LTR_ISH},
+	/* Below two cannot be used for LTR_IGNORE */
+	{"CURRENT_PLATFORM",	SPT_PMC_LTR_CUR_PLT},
+	{"AGGREGATED_SYSTEM",	SPT_PMC_LTR_CUR_ASLT},
+	{}
+};
+
+const struct pmc_reg_map spt_reg_map = {
+	.pfear_sts = ext_spt_pfear_map,
+	.mphy_sts = spt_mphy_map,
+	.pll_sts = spt_pll_map,
+	.ltr_show_sts = spt_ltr_show_map,
+	.msr_sts = msr_map,
+	.slp_s0_offset = SPT_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
+	.ltr_ignore_offset = SPT_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = SPT_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = SPT_PMC_XRAM_PPFEAR0A,
+	.ppfear_buckets = SPT_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
+	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
+};
+
+void spt_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &spt_reg_map;
+}
-- 
2.25.1

