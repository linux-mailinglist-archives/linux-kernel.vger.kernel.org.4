Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025062880D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiKNSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiKNSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:07 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7B2793E;
        Mon, 14 Nov 2022 10:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449586; x=1699985586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YXzrpqDiDaMY26NI69xUVbjK18+HKdLe53H/O0Xq6yk=;
  b=QOxmI6quwbdPAGxHrZyGV2+KuQCwOVwYfNSxYzXsgj3yfwONlIlNcgYK
   K3J4+Q2SkU0JG6T1WnS53h0zZmykY8RSGWR0JdEeaAf6iEC5Q0W+is4Zs
   0fpCoZrmh36ROOM9Egf7aa6dshRQ0h0j8achwy2HPA86ZLCLh2b+Exm6D
   mChCiGamgCIGaVUafx6GVxzIlSOB3yhU6dU5S9pU8SdOObTPi6vkN/REw
   XJyPLrpDQwzRt2BJSxwWUfCB8CbVpNA81zj/0lYXtXEhu0xPTXHDvaHoD
   +1ULXNA90ylYP3/t47vl5LWcFPlsFcs/buRSOh73W8s6+EbvanU+JMhqW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292440594"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292440594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:13:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727626767"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727626767"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 10:12:57 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 7A80C58097C;
        Mon, 14 Nov 2022 10:12:57 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com, David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 4/8] platform/x86: intel/pmc: Relocate Cannon Lake Point PCH support
Date:   Mon, 14 Nov 2022 10:12:03 -0800
Message-Id: <20221114181207.2062901-5-gayatri.kammela@linux.intel.com>
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

Create cnp.c for Cannon Lake Point PCH specific structures and init().
This file supports Cannon Lake and Comet Lake platforms.
There are no functional changes involved.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |   2 +-
 drivers/platform/x86/intel/pmc/cnp.c    | 210 ++++++++++++++++++++++++
 drivers/platform/x86/intel/pmc/core.c   | 199 ----------------------
 drivers/platform/x86/intel/pmc/core.h   |   8 +
 4 files changed, 219 insertions(+), 200 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/cnp.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 1b2104e0c97f..2b6d4a8dd2bb 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o spt.o
+intel_pmc_core-y			:= core.o spt.o cnp.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
new file mode 100644
index 000000000000..7fb38815c4eb
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Cannon Lake Point PCH.
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include "core.h"
+
+/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
+const struct pmc_bit_map cnp_pfear_map[] = {
+	{"PMC",                 BIT(0)},
+	{"OPI-DMI",             BIT(1)},
+	{"SPI/eSPI",            BIT(2)},
+	{"XHCI",                BIT(3)},
+	{"SPA",                 BIT(4)},
+	{"SPB",                 BIT(5)},
+	{"SPC",                 BIT(6)},
+	{"GBE",                 BIT(7)},
+
+	{"SATA",                BIT(0)},
+	{"HDA_PGD0",            BIT(1)},
+	{"HDA_PGD1",            BIT(2)},
+	{"HDA_PGD2",            BIT(3)},
+	{"HDA_PGD3",            BIT(4)},
+	{"SPD",                 BIT(5)},
+	{"LPSS",                BIT(6)},
+	{"LPC",                 BIT(7)},
+
+	{"SMB",                 BIT(0)},
+	{"ISH",                 BIT(1)},
+	{"P2SB",                BIT(2)},
+	{"NPK_VNN",             BIT(3)},
+	{"SDX",                 BIT(4)},
+	{"SPE",                 BIT(5)},
+	{"Fuse",                BIT(6)},
+	{"SBR8",		BIT(7)},
+
+	{"CSME_FSC",            BIT(0)},
+	{"USB3_OTG",            BIT(1)},
+	{"EXI",                 BIT(2)},
+	{"CSE",                 BIT(3)},
+	{"CSME_KVM",            BIT(4)},
+	{"CSME_PMT",            BIT(5)},
+	{"CSME_CLINK",          BIT(6)},
+	{"CSME_PTIO",           BIT(7)},
+
+	{"CSME_USBR",           BIT(0)},
+	{"CSME_SUSRAM",         BIT(1)},
+	{"CSME_SMT1",           BIT(2)},
+	{"CSME_SMT4",           BIT(3)},
+	{"CSME_SMS2",           BIT(4)},
+	{"CSME_SMS1",           BIT(5)},
+	{"CSME_RTC",            BIT(6)},
+	{"CSME_PSF",            BIT(7)},
+
+	{"SBR0",                BIT(0)},
+	{"SBR1",                BIT(1)},
+	{"SBR2",                BIT(2)},
+	{"SBR3",                BIT(3)},
+	{"SBR4",                BIT(4)},
+	{"SBR5",                BIT(5)},
+	{"CSME_PECI",           BIT(6)},
+	{"PSF1",                BIT(7)},
+
+	{"PSF2",                BIT(0)},
+	{"PSF3",                BIT(1)},
+	{"PSF4",                BIT(2)},
+	{"CNVI",                BIT(3)},
+	{"UFS0",                BIT(4)},
+	{"EMMC",                BIT(5)},
+	{"SPF",			BIT(6)},
+	{"SBR6",                BIT(7)},
+
+	{"SBR7",                BIT(0)},
+	{"NPK_AON",             BIT(1)},
+	{"HDA_PGD4",            BIT(2)},
+	{"HDA_PGD5",            BIT(3)},
+	{"HDA_PGD6",            BIT(4)},
+	{"PSF6",		BIT(5)},
+	{"PSF7",		BIT(6)},
+	{"PSF8",		BIT(7)},
+	{}
+};
+
+const struct pmc_bit_map *ext_cnp_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	cnp_pfear_map,
+	NULL
+};
+
+const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
+	{"AUDIO_D3",		BIT(0)},
+	{"OTG_D3",		BIT(1)},
+	{"XHCI_D3",		BIT(2)},
+	{"LPIO_D3",		BIT(3)},
+	{"SDX_D3",		BIT(4)},
+	{"SATA_D3",		BIT(5)},
+	{"UFS0_D3",		BIT(6)},
+	{"UFS1_D3",		BIT(7)},
+	{"EMMC_D3",		BIT(8)},
+	{}
+};
+
+const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
+	{"SDIO_PLL_OFF",	BIT(0)},
+	{"USB2_PLL_OFF",	BIT(1)},
+	{"AUDIO_PLL_OFF",	BIT(2)},
+	{"OC_PLL_OFF",		BIT(3)},
+	{"MAIN_PLL_OFF",	BIT(4)},
+	{"XOSC_OFF",		BIT(5)},
+	{"LPC_CLKS_GATED",	BIT(6)},
+	{"PCIE_CLKREQS_IDLE",	BIT(7)},
+	{"AUDIO_ROSC_OFF",	BIT(8)},
+	{"HPET_XOSC_CLK_REQ",	BIT(9)},
+	{"PMC_ROSC_SLOW_CLK",	BIT(10)},
+	{"AON2_ROSC_GATED",	BIT(11)},
+	{"CLKACKS_DEASSERTED",	BIT(12)},
+	{}
+};
+
+const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
+	{"MPHY_CORE_GATED",	BIT(0)},
+	{"CSME_GATED",		BIT(1)},
+	{"USB2_SUS_GATED",	BIT(2)},
+	{"DYN_FLEX_IO_IDLE",	BIT(3)},
+	{"GBE_NO_LINK",		BIT(4)},
+	{"THERM_SEN_DISABLED",	BIT(5)},
+	{"PCIE_LOW_POWER",	BIT(6)},
+	{"ISH_VNNAON_REQ_ACT",	BIT(7)},
+	{"ISH_VNN_REQ_ACT",	BIT(8)},
+	{"CNV_VNNAON_REQ_ACT",	BIT(9)},
+	{"CNV_VNN_REQ_ACT",	BIT(10)},
+	{"NPK_VNNON_REQ_ACT",	BIT(11)},
+	{"PMSYNC_STATE_IDLE",	BIT(12)},
+	{"ALST_GT_THRES",	BIT(13)},
+	{"PMC_ARC_PG_READY",	BIT(14)},
+	{}
+};
+
+const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
+	cnp_slps0_dbg0_map,
+	cnp_slps0_dbg1_map,
+	cnp_slps0_dbg2_map,
+	NULL
+};
+
+const struct pmc_bit_map cnp_ltr_show_map[] = {
+	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
+	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
+	{"SATA",		CNP_PMC_LTR_SATA},
+	{"GIGABIT_ETHERNET",	CNP_PMC_LTR_GBE},
+	{"XHCI",		CNP_PMC_LTR_XHCI},
+	{"Reserved",		CNP_PMC_LTR_RESERVED},
+	{"ME",			CNP_PMC_LTR_ME},
+	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
+	{"EVA",			CNP_PMC_LTR_EVA},
+	{"SOUTHPORT_C",		CNP_PMC_LTR_SPC},
+	{"HD_AUDIO",		CNP_PMC_LTR_AZ},
+	{"CNV",			CNP_PMC_LTR_CNV},
+	{"LPSS",		CNP_PMC_LTR_LPSS},
+	{"SOUTHPORT_D",		CNP_PMC_LTR_SPD},
+	{"SOUTHPORT_E",		CNP_PMC_LTR_SPE},
+	{"CAMERA",		CNP_PMC_LTR_CAM},
+	{"ESPI",		CNP_PMC_LTR_ESPI},
+	{"SCC",			CNP_PMC_LTR_SCC},
+	{"ISH",			CNP_PMC_LTR_ISH},
+	{"UFSX2",		CNP_PMC_LTR_UFSX2},
+	{"EMMC",		CNP_PMC_LTR_EMMC},
+	/*
+	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	{"WIGIG",		ICL_PMC_LTR_WIGIG},
+	{"THC0",                TGL_PMC_LTR_THC0},
+	{"THC1",                TGL_PMC_LTR_THC1},
+	/* Below two cannot be used for LTR_IGNORE */
+	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
+	{"AGGREGATED_SYSTEM",	CNP_PMC_LTR_CUR_ASLT},
+	{}
+};
+
+const struct pmc_reg_map cnp_reg_map = {
+	.pfear_sts = ext_cnp_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
+	.slps0_dbg_maps = cnp_slps0_dbg_maps,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
+	.etr3_offset = ETR3_OFFSET,
+};
+
+void cnp_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &cnp_reg_map;
+}
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 18b6e87f7c73..1cce586035f9 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -60,91 +60,6 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
-/* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
-static const struct pmc_bit_map cnp_pfear_map[] = {
-	{"PMC",                 BIT(0)},
-	{"OPI-DMI",             BIT(1)},
-	{"SPI/eSPI",            BIT(2)},
-	{"XHCI",                BIT(3)},
-	{"SPA",                 BIT(4)},
-	{"SPB",                 BIT(5)},
-	{"SPC",                 BIT(6)},
-	{"GBE",                 BIT(7)},
-
-	{"SATA",                BIT(0)},
-	{"HDA_PGD0",            BIT(1)},
-	{"HDA_PGD1",            BIT(2)},
-	{"HDA_PGD2",            BIT(3)},
-	{"HDA_PGD3",            BIT(4)},
-	{"SPD",                 BIT(5)},
-	{"LPSS",                BIT(6)},
-	{"LPC",                 BIT(7)},
-
-	{"SMB",                 BIT(0)},
-	{"ISH",                 BIT(1)},
-	{"P2SB",                BIT(2)},
-	{"NPK_VNN",             BIT(3)},
-	{"SDX",                 BIT(4)},
-	{"SPE",                 BIT(5)},
-	{"Fuse",                BIT(6)},
-	{"SBR8",		BIT(7)},
-
-	{"CSME_FSC",            BIT(0)},
-	{"USB3_OTG",            BIT(1)},
-	{"EXI",                 BIT(2)},
-	{"CSE",                 BIT(3)},
-	{"CSME_KVM",            BIT(4)},
-	{"CSME_PMT",            BIT(5)},
-	{"CSME_CLINK",          BIT(6)},
-	{"CSME_PTIO",           BIT(7)},
-
-	{"CSME_USBR",           BIT(0)},
-	{"CSME_SUSRAM",         BIT(1)},
-	{"CSME_SMT1",           BIT(2)},
-	{"CSME_SMT4",           BIT(3)},
-	{"CSME_SMS2",           BIT(4)},
-	{"CSME_SMS1",           BIT(5)},
-	{"CSME_RTC",            BIT(6)},
-	{"CSME_PSF",            BIT(7)},
-
-	{"SBR0",                BIT(0)},
-	{"SBR1",                BIT(1)},
-	{"SBR2",                BIT(2)},
-	{"SBR3",                BIT(3)},
-	{"SBR4",                BIT(4)},
-	{"SBR5",                BIT(5)},
-	{"CSME_PECI",           BIT(6)},
-	{"PSF1",                BIT(7)},
-
-	{"PSF2",                BIT(0)},
-	{"PSF3",                BIT(1)},
-	{"PSF4",                BIT(2)},
-	{"CNVI",                BIT(3)},
-	{"UFS0",                BIT(4)},
-	{"EMMC",                BIT(5)},
-	{"SPF",			BIT(6)},
-	{"SBR6",                BIT(7)},
-
-	{"SBR7",                BIT(0)},
-	{"NPK_AON",             BIT(1)},
-	{"HDA_PGD4",            BIT(2)},
-	{"HDA_PGD5",            BIT(3)},
-	{"HDA_PGD6",            BIT(4)},
-	{"PSF6",		BIT(5)},
-	{"PSF7",		BIT(6)},
-	{"PSF8",		BIT(7)},
-	{}
-};
-
-static const struct pmc_bit_map *ext_cnp_pfear_map[] = {
-	/*
-	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
-	 * a list of core SoCs using this.
-	 */
-	cnp_pfear_map,
-	NULL
-};
-
 static const struct pmc_bit_map icl_pfear_map[] = {
 	{"RES_65",		BIT(0)},
 	{"RES_66",		BIT(1)},
@@ -188,115 +103,6 @@ static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
 	NULL
 };
 
-static const struct pmc_bit_map cnp_slps0_dbg0_map[] = {
-	{"AUDIO_D3",		BIT(0)},
-	{"OTG_D3",		BIT(1)},
-	{"XHCI_D3",		BIT(2)},
-	{"LPIO_D3",		BIT(3)},
-	{"SDX_D3",		BIT(4)},
-	{"SATA_D3",		BIT(5)},
-	{"UFS0_D3",		BIT(6)},
-	{"UFS1_D3",		BIT(7)},
-	{"EMMC_D3",		BIT(8)},
-	{}
-};
-
-static const struct pmc_bit_map cnp_slps0_dbg1_map[] = {
-	{"SDIO_PLL_OFF",	BIT(0)},
-	{"USB2_PLL_OFF",	BIT(1)},
-	{"AUDIO_PLL_OFF",	BIT(2)},
-	{"OC_PLL_OFF",		BIT(3)},
-	{"MAIN_PLL_OFF",	BIT(4)},
-	{"XOSC_OFF",		BIT(5)},
-	{"LPC_CLKS_GATED",	BIT(6)},
-	{"PCIE_CLKREQS_IDLE",	BIT(7)},
-	{"AUDIO_ROSC_OFF",	BIT(8)},
-	{"HPET_XOSC_CLK_REQ",	BIT(9)},
-	{"PMC_ROSC_SLOW_CLK",	BIT(10)},
-	{"AON2_ROSC_GATED",	BIT(11)},
-	{"CLKACKS_DEASSERTED",	BIT(12)},
-	{}
-};
-
-static const struct pmc_bit_map cnp_slps0_dbg2_map[] = {
-	{"MPHY_CORE_GATED",	BIT(0)},
-	{"CSME_GATED",		BIT(1)},
-	{"USB2_SUS_GATED",	BIT(2)},
-	{"DYN_FLEX_IO_IDLE",	BIT(3)},
-	{"GBE_NO_LINK",		BIT(4)},
-	{"THERM_SEN_DISABLED",	BIT(5)},
-	{"PCIE_LOW_POWER",	BIT(6)},
-	{"ISH_VNNAON_REQ_ACT",	BIT(7)},
-	{"ISH_VNN_REQ_ACT",	BIT(8)},
-	{"CNV_VNNAON_REQ_ACT",	BIT(9)},
-	{"CNV_VNN_REQ_ACT",	BIT(10)},
-	{"NPK_VNNON_REQ_ACT",	BIT(11)},
-	{"PMSYNC_STATE_IDLE",	BIT(12)},
-	{"ALST_GT_THRES",	BIT(13)},
-	{"PMC_ARC_PG_READY",	BIT(14)},
-	{}
-};
-
-static const struct pmc_bit_map *cnp_slps0_dbg_maps[] = {
-	cnp_slps0_dbg0_map,
-	cnp_slps0_dbg1_map,
-	cnp_slps0_dbg2_map,
-	NULL
-};
-
-static const struct pmc_bit_map cnp_ltr_show_map[] = {
-	{"SOUTHPORT_A",		CNP_PMC_LTR_SPA},
-	{"SOUTHPORT_B",		CNP_PMC_LTR_SPB},
-	{"SATA",		CNP_PMC_LTR_SATA},
-	{"GIGABIT_ETHERNET",	CNP_PMC_LTR_GBE},
-	{"XHCI",		CNP_PMC_LTR_XHCI},
-	{"Reserved",		CNP_PMC_LTR_RESERVED},
-	{"ME",			CNP_PMC_LTR_ME},
-	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
-	{"EVA",			CNP_PMC_LTR_EVA},
-	{"SOUTHPORT_C",		CNP_PMC_LTR_SPC},
-	{"HD_AUDIO",		CNP_PMC_LTR_AZ},
-	{"CNV",			CNP_PMC_LTR_CNV},
-	{"LPSS",		CNP_PMC_LTR_LPSS},
-	{"SOUTHPORT_D",		CNP_PMC_LTR_SPD},
-	{"SOUTHPORT_E",		CNP_PMC_LTR_SPE},
-	{"CAMERA",		CNP_PMC_LTR_CAM},
-	{"ESPI",		CNP_PMC_LTR_ESPI},
-	{"SCC",			CNP_PMC_LTR_SCC},
-	{"ISH",			CNP_PMC_LTR_ISH},
-	{"UFSX2",		CNP_PMC_LTR_UFSX2},
-	{"EMMC",		CNP_PMC_LTR_EMMC},
-	/*
-	 * Check intel_pmc_core_ids[] users of cnp_reg_map for
-	 * a list of core SoCs using this.
-	 */
-	{"WIGIG",		ICL_PMC_LTR_WIGIG},
-	{"THC0",                TGL_PMC_LTR_THC0},
-	{"THC1",                TGL_PMC_LTR_THC1},
-	/* Below two cannot be used for LTR_IGNORE */
-	{"CURRENT_PLATFORM",	CNP_PMC_LTR_CUR_PLT},
-	{"AGGREGATED_SYSTEM",	CNP_PMC_LTR_CUR_ASLT},
-	{}
-};
-
-static const struct pmc_reg_map cnp_reg_map = {
-	.pfear_sts = ext_cnp_pfear_map,
-	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
-	.slp_s0_res_counter_step = SPT_PMC_SLP_S0_RES_COUNTER_STEP,
-	.slps0_dbg_maps = cnp_slps0_dbg_maps,
-	.ltr_show_sts = cnp_ltr_show_map,
-	.msr_sts = msr_map,
-	.slps0_dbg_offset = CNP_PMC_SLPS0_DBG_OFFSET,
-	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
-	.regmap_length = CNP_PMC_MMIO_REG_LEN,
-	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
-	.ppfear_buckets = CNP_PPFEAR_NUM_ENTRIES,
-	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
-	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
-	.ltr_ignore_max = CNP_NUM_IP_IGN_ALLOWED,
-	.etr3_offset = ETR3_OFFSET,
-};
-
 static const struct pmc_reg_map icl_reg_map = {
 	.pfear_sts = ext_icl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
@@ -1783,11 +1589,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
-void cnp_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &cnp_reg_map;
-}
-
 void icl_core_init(struct pmc_dev *pmcdev)
 {
 	pmcdev->map = &icl_reg_map;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 65189353cc2b..2b7d681588cb 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -343,6 +343,14 @@ extern const struct pmc_bit_map spt_pfear_map[];
 extern const struct pmc_bit_map *ext_spt_pfear_map[];
 extern const struct pmc_bit_map spt_ltr_show_map[];
 extern const struct pmc_reg_map spt_reg_map;
+extern const struct pmc_bit_map cnp_pfear_map[];
+extern const struct pmc_bit_map *ext_cnp_pfear_map[];
+extern const struct pmc_bit_map cnp_slps0_dbg0_map[];
+extern const struct pmc_bit_map cnp_slps0_dbg1_map[];
+extern const struct pmc_bit_map cnp_slps0_dbg2_map[];
+extern const struct pmc_bit_map *cnp_slps0_dbg_maps[];
+extern const struct pmc_bit_map cnp_ltr_show_map[];
+extern const struct pmc_reg_map cnp_reg_map;
 
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
-- 
2.25.1

