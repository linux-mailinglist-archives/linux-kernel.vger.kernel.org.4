Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3095C62880B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbiKNSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiKNSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33127B1E;
        Mon, 14 Nov 2022 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449582; x=1699985582;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qLs82u9tY13odcWMkazWJlXR3jRiCfjmp1m2wKvE3eg=;
  b=SxGo9Z1PY/5qnUmy43kLHFpJqlBKiX8C6btIFSrbpwHfYJgNxHjzo0vB
   vyxTM8H6e2/dtP2C0HcUjYYoICQBBk7Key6JtdhZn5UL3GMisFvPLgkk8
   28aMZCYR4lM8YfpM05Dw42azBMaC17/uLtGBy0omTPMt4uHhn9gTckwWt
   BpvUh0VRoCPNYWSN3YH4CDBVk/4X5/lo460/nEo2KbiLblBoKYjkYjtHF
   UIKXCL+urLTbcInxE3XJE1s60zEW0NRCaHRIqnKtvQL4+ulD9jkyfZmda
   gRUwNVDOePFeAXgTUsFf1pfXifHiSpnrL158tQq5uyjIHGtQlRZsqAdoj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="292440582"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="292440582"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:13:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="707412719"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="707412719"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 14 Nov 2022 10:13:01 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 94666580A5F;
        Mon, 14 Nov 2022 10:13:01 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 6/8] platform/x86: intel/pmc: Relocate Tiger Lake PCH support
Date:   Mon, 14 Nov 2022 10:12:05 -0800
Message-Id: <20221114181207.2062901-7-gayatri.kammela@linux.intel.com>
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

Create tgl.c for Tiger Lake PCH specific structures and init().
This file supports Tiger Lake, Elkhart Lake, Rocket Lake,
Alder Lake mobile, Alder Lake N and Raptor Lake P platforms.
There are no functional changes involved.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile |   2 +-
 drivers/platform/x86/intel/pmc/core.c   | 264 +----------------------
 drivers/platform/x86/intel/pmc/core.h   |  14 ++
 drivers/platform/x86/intel/pmc/tgl.c    | 269 ++++++++++++++++++++++++
 4 files changed, 285 insertions(+), 264 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/tgl.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index 6d153e368da1..ad34c8255584 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,7 +3,7 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o spt.o cnp.o icl.o
+intel_pmc_core-y			:= core.o spt.o cnp.o icl.o tgl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index d75e8cbaf40c..4ff176eabe3f 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -11,7 +11,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -21,10 +20,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/uaccess.h>
-#include <linux/uuid.h>
 
-#include <acpi/acpi_bus.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include <asm/msr.h>
@@ -32,9 +28,6 @@
 
 #include "core.h"
 
-#define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
-#define ACPI_GET_LOW_MODE_REGISTERS	1
-
 /* Maximum number of modes supported by platfoms that has low power mode capability */
 const char *pmc_lpm_modes[] = {
 	"S0i2.0",
@@ -60,245 +53,6 @@ const struct pmc_bit_map msr_map[] = {
 	{}
 };
 
-static const struct pmc_bit_map tgl_pfear_map[] = {
-	{"PSF9",		BIT(0)},
-	{"RES_66",		BIT(1)},
-	{"RES_67",		BIT(2)},
-	{"RES_68",		BIT(3)},
-	{"RES_69",		BIT(4)},
-	{"RES_70",		BIT(5)},
-	{"TBTLSX",		BIT(6)},
-	{}
-};
-
-static const struct pmc_bit_map *ext_tgl_pfear_map[] = {
-	/*
-	 * Check intel_pmc_core_ids[] users of tgl_reg_map for
-	 * a list of core SoCs using this.
-	 */
-	cnp_pfear_map,
-	tgl_pfear_map,
-	NULL
-};
-
-static const struct pmc_bit_map tgl_clocksource_status_map[] = {
-	{"USB2PLL_OFF_STS",			BIT(18)},
-	{"PCIe/USB3.1_Gen2PLL_OFF_STS",		BIT(19)},
-	{"PCIe_Gen3PLL_OFF_STS",		BIT(20)},
-	{"OPIOPLL_OFF_STS",			BIT(21)},
-	{"OCPLL_OFF_STS",			BIT(22)},
-	{"MainPLL_OFF_STS",			BIT(23)},
-	{"MIPIPLL_OFF_STS",			BIT(24)},
-	{"Fast_XTAL_Osc_OFF_STS",		BIT(25)},
-	{"AC_Ring_Osc_OFF_STS",			BIT(26)},
-	{"MC_Ring_Osc_OFF_STS",			BIT(27)},
-	{"SATAPLL_OFF_STS",			BIT(29)},
-	{"XTAL_USB2PLL_OFF_STS",		BIT(31)},
-	{}
-};
-
-static const struct pmc_bit_map tgl_power_gating_status_map[] = {
-	{"CSME_PG_STS",				BIT(0)},
-	{"SATA_PG_STS",				BIT(1)},
-	{"xHCI_PG_STS",				BIT(2)},
-	{"UFSX2_PG_STS",			BIT(3)},
-	{"OTG_PG_STS",				BIT(5)},
-	{"SPA_PG_STS",				BIT(6)},
-	{"SPB_PG_STS",				BIT(7)},
-	{"SPC_PG_STS",				BIT(8)},
-	{"SPD_PG_STS",				BIT(9)},
-	{"SPE_PG_STS",				BIT(10)},
-	{"SPF_PG_STS",				BIT(11)},
-	{"LSX_PG_STS",				BIT(13)},
-	{"P2SB_PG_STS",				BIT(14)},
-	{"PSF_PG_STS",				BIT(15)},
-	{"SBR_PG_STS",				BIT(16)},
-	{"OPIDMI_PG_STS",			BIT(17)},
-	{"THC0_PG_STS",				BIT(18)},
-	{"THC1_PG_STS",				BIT(19)},
-	{"GBETSN_PG_STS",			BIT(20)},
-	{"GBE_PG_STS",				BIT(21)},
-	{"LPSS_PG_STS",				BIT(22)},
-	{"MMP_UFSX2_PG_STS",			BIT(23)},
-	{"MMP_UFSX2B_PG_STS",			BIT(24)},
-	{"FIA_PG_STS",				BIT(25)},
-	{}
-};
-
-static const struct pmc_bit_map tgl_d3_status_map[] = {
-	{"ADSP_D3_STS",				BIT(0)},
-	{"SATA_D3_STS",				BIT(1)},
-	{"xHCI0_D3_STS",			BIT(2)},
-	{"xDCI1_D3_STS",			BIT(5)},
-	{"SDX_D3_STS",				BIT(6)},
-	{"EMMC_D3_STS",				BIT(7)},
-	{"IS_D3_STS",				BIT(8)},
-	{"THC0_D3_STS",				BIT(9)},
-	{"THC1_D3_STS",				BIT(10)},
-	{"GBE_D3_STS",				BIT(11)},
-	{"GBE_TSN_D3_STS",			BIT(12)},
-	{}
-};
-
-static const struct pmc_bit_map tgl_vnn_req_status_map[] = {
-	{"GPIO_COM0_VNN_REQ_STS",		BIT(1)},
-	{"GPIO_COM1_VNN_REQ_STS",		BIT(2)},
-	{"GPIO_COM2_VNN_REQ_STS",		BIT(3)},
-	{"GPIO_COM3_VNN_REQ_STS",		BIT(4)},
-	{"GPIO_COM4_VNN_REQ_STS",		BIT(5)},
-	{"GPIO_COM5_VNN_REQ_STS",		BIT(6)},
-	{"Audio_VNN_REQ_STS",			BIT(7)},
-	{"ISH_VNN_REQ_STS",			BIT(8)},
-	{"CNVI_VNN_REQ_STS",			BIT(9)},
-	{"eSPI_VNN_REQ_STS",			BIT(10)},
-	{"Display_VNN_REQ_STS",			BIT(11)},
-	{"DTS_VNN_REQ_STS",			BIT(12)},
-	{"SMBUS_VNN_REQ_STS",			BIT(14)},
-	{"CSME_VNN_REQ_STS",			BIT(15)},
-	{"SMLINK0_VNN_REQ_STS",			BIT(16)},
-	{"SMLINK1_VNN_REQ_STS",			BIT(17)},
-	{"CLINK_VNN_REQ_STS",			BIT(20)},
-	{"DCI_VNN_REQ_STS",			BIT(21)},
-	{"ITH_VNN_REQ_STS",			BIT(22)},
-	{"CSME_VNN_REQ_STS",			BIT(24)},
-	{"GBE_VNN_REQ_STS",			BIT(25)},
-	{}
-};
-
-static const struct pmc_bit_map tgl_vnn_misc_status_map[] = {
-	{"CPU_C10_REQ_STS_0",			BIT(0)},
-	{"PCIe_LPM_En_REQ_STS_3",		BIT(3)},
-	{"ITH_REQ_STS_5",			BIT(5)},
-	{"CNVI_REQ_STS_6",			BIT(6)},
-	{"ISH_REQ_STS_7",			BIT(7)},
-	{"USB2_SUS_PG_Sys_REQ_STS_10",		BIT(10)},
-	{"PCIe_Clk_REQ_STS_12",			BIT(12)},
-	{"MPHY_Core_DL_REQ_STS_16",		BIT(16)},
-	{"Break-even_En_REQ_STS_17",		BIT(17)},
-	{"Auto-demo_En_REQ_STS_18",		BIT(18)},
-	{"MPHY_SUS_REQ_STS_22",			BIT(22)},
-	{"xDCI_attached_REQ_STS_24",		BIT(24)},
-	{}
-};
-
-static const struct pmc_bit_map tgl_signal_status_map[] = {
-	{"LSX_Wake0_En_STS",			BIT(0)},
-	{"LSX_Wake0_Pol_STS",			BIT(1)},
-	{"LSX_Wake1_En_STS",			BIT(2)},
-	{"LSX_Wake1_Pol_STS",			BIT(3)},
-	{"LSX_Wake2_En_STS",			BIT(4)},
-	{"LSX_Wake2_Pol_STS",			BIT(5)},
-	{"LSX_Wake3_En_STS",			BIT(6)},
-	{"LSX_Wake3_Pol_STS",			BIT(7)},
-	{"LSX_Wake4_En_STS",			BIT(8)},
-	{"LSX_Wake4_Pol_STS",			BIT(9)},
-	{"LSX_Wake5_En_STS",			BIT(10)},
-	{"LSX_Wake5_Pol_STS",			BIT(11)},
-	{"LSX_Wake6_En_STS",			BIT(12)},
-	{"LSX_Wake6_Pol_STS",			BIT(13)},
-	{"LSX_Wake7_En_STS",			BIT(14)},
-	{"LSX_Wake7_Pol_STS",			BIT(15)},
-	{"Intel_Se_IO_Wake0_En_STS",		BIT(16)},
-	{"Intel_Se_IO_Wake0_Pol_STS",		BIT(17)},
-	{"Intel_Se_IO_Wake1_En_STS",		BIT(18)},
-	{"Intel_Se_IO_Wake1_Pol_STS",		BIT(19)},
-	{"Int_Timer_SS_Wake0_En_STS",		BIT(20)},
-	{"Int_Timer_SS_Wake0_Pol_STS",		BIT(21)},
-	{"Int_Timer_SS_Wake1_En_STS",		BIT(22)},
-	{"Int_Timer_SS_Wake1_Pol_STS",		BIT(23)},
-	{"Int_Timer_SS_Wake2_En_STS",		BIT(24)},
-	{"Int_Timer_SS_Wake2_Pol_STS",		BIT(25)},
-	{"Int_Timer_SS_Wake3_En_STS",		BIT(26)},
-	{"Int_Timer_SS_Wake3_Pol_STS",		BIT(27)},
-	{"Int_Timer_SS_Wake4_En_STS",		BIT(28)},
-	{"Int_Timer_SS_Wake4_Pol_STS",		BIT(29)},
-	{"Int_Timer_SS_Wake5_En_STS",		BIT(30)},
-	{"Int_Timer_SS_Wake5_Pol_STS",		BIT(31)},
-	{}
-};
-
-static const struct pmc_bit_map *tgl_lpm_maps[] = {
-	tgl_clocksource_status_map,
-	tgl_power_gating_status_map,
-	tgl_d3_status_map,
-	tgl_vnn_req_status_map,
-	tgl_vnn_misc_status_map,
-	tgl_signal_status_map,
-	NULL
-};
-
-static const struct pmc_reg_map tgl_reg_map = {
-	.pfear_sts = ext_tgl_pfear_map,
-	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
-	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
-	.ltr_show_sts = cnp_ltr_show_map,
-	.msr_sts = msr_map,
-	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
-	.regmap_length = CNP_PMC_MMIO_REG_LEN,
-	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
-	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
-	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
-	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
-	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
-	.lpm_num_maps = TGL_LPM_NUM_MAPS,
-	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
-	.lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
-	.lpm_en_offset = TGL_LPM_EN_OFFSET,
-	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
-	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
-	.lpm_sts = tgl_lpm_maps,
-	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
-	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
-	.etr3_offset = ETR3_OFFSET,
-};
-
-static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
-{
-	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
-	const int num_maps = pmcdev->map->lpm_num_maps;
-	u32 lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
-	union acpi_object *out_obj;
-	struct acpi_device *adev;
-	guid_t s0ix_dsm_guid;
-	u32 *lpm_req_regs, *addr;
-
-	adev = ACPI_COMPANION(&pdev->dev);
-	if (!adev)
-		return;
-
-	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
-
-	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
-				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
-	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
-		u32 size = out_obj->buffer.length;
-
-		if (size != lpm_size) {
-			acpi_handle_debug(adev->handle,
-				"_DSM returned unexpected buffer size, have %u, expect %u\n",
-				size, lpm_size);
-			goto free_acpi_obj;
-		}
-	} else {
-		acpi_handle_debug(adev->handle,
-				  "_DSM function 0 evaluation failed\n");
-		goto free_acpi_obj;
-	}
-
-	addr = (u32 *)out_obj->buffer.pointer;
-
-	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
-				     GFP_KERNEL);
-	if (!lpm_req_regs)
-		goto free_acpi_obj;
-
-	memcpy(lpm_req_regs, addr, lpm_size);
-	pmcdev->lpm_req_regs = lpm_req_regs;
-
-free_acpi_obj:
-	ACPI_FREE(out_obj);
-}
-
 /* Alder Lake: PGD PFET Enable Ack Status Register(s) bitmap */
 static const struct pmc_bit_map adl_pfear_map[] = {
 	{"SPI/eSPI",		BIT(2)},
@@ -981,7 +735,7 @@ static int pmc_core_pll_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
 
-static int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
+int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value)
 {
 	const struct pmc_reg_map *map = pmcdev->map;
 	u32 reg;
@@ -1549,22 +1303,6 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
-void tgl_core_configure(struct pmc_dev *pmcdev)
-{
-	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-}
-
-void tgl_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &tgl_reg_map;
-	pmcdev->core_configure = tgl_core_configure;
-}
-
 void adl_core_configure(struct pmc_dev *pmcdev)
 {
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 2ca564878341..38fca2a54d23 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -12,6 +12,7 @@
 #ifndef PMC_CORE_H
 #define PMC_CORE_H
 
+#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/platform_device.h>
 
@@ -354,6 +355,19 @@ extern const struct pmc_reg_map cnp_reg_map;
 extern const struct pmc_bit_map icl_pfear_map[];
 extern const struct pmc_bit_map *ext_icl_pfear_map[];
 extern const struct pmc_reg_map icl_reg_map;
+extern const struct pmc_bit_map tgl_pfear_map[];
+extern const struct pmc_bit_map *ext_tgl_pfear_map[];
+extern const struct pmc_bit_map tgl_clocksource_status_map[];
+extern const struct pmc_bit_map tgl_power_gating_status_map[];
+extern const struct pmc_bit_map tgl_d3_status_map[];
+extern const struct pmc_bit_map tgl_vnn_req_status_map[];
+extern const struct pmc_bit_map tgl_vnn_misc_status_map[];
+extern const struct pmc_bit_map tgl_signal_status_map[];
+extern const struct pmc_bit_map *tgl_lpm_maps[];
+extern const struct pmc_reg_map tgl_reg_map;
+
+extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
+extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
new file mode 100644
index 000000000000..e3e50538465d
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains platform specific structure definitions
+ * and init function used by Tiger Lake PCH.
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include "core.h"
+
+#define ACPI_S0IX_DSM_UUID		"57a6512e-3979-4e9d-9708-ff13b2508972"
+#define ACPI_GET_LOW_MODE_REGISTERS	1
+
+const struct pmc_bit_map tgl_pfear_map[] = {
+	{"PSF9",		BIT(0)},
+	{"RES_66",		BIT(1)},
+	{"RES_67",		BIT(2)},
+	{"RES_68",		BIT(3)},
+	{"RES_69",		BIT(4)},
+	{"RES_70",		BIT(5)},
+	{"TBTLSX",		BIT(6)},
+	{}
+};
+
+const struct pmc_bit_map *ext_tgl_pfear_map[] = {
+	/*
+	 * Check intel_pmc_core_ids[] users of tgl_reg_map for
+	 * a list of core SoCs using this.
+	 */
+	cnp_pfear_map,
+	tgl_pfear_map,
+	NULL
+};
+
+const struct pmc_bit_map tgl_clocksource_status_map[] = {
+	{"USB2PLL_OFF_STS",			BIT(18)},
+	{"PCIe/USB3.1_Gen2PLL_OFF_STS",		BIT(19)},
+	{"PCIe_Gen3PLL_OFF_STS",		BIT(20)},
+	{"OPIOPLL_OFF_STS",			BIT(21)},
+	{"OCPLL_OFF_STS",			BIT(22)},
+	{"MainPLL_OFF_STS",			BIT(23)},
+	{"MIPIPLL_OFF_STS",			BIT(24)},
+	{"Fast_XTAL_Osc_OFF_STS",		BIT(25)},
+	{"AC_Ring_Osc_OFF_STS",			BIT(26)},
+	{"MC_Ring_Osc_OFF_STS",			BIT(27)},
+	{"SATAPLL_OFF_STS",			BIT(29)},
+	{"XTAL_USB2PLL_OFF_STS",		BIT(31)},
+	{}
+};
+
+const struct pmc_bit_map tgl_power_gating_status_map[] = {
+	{"CSME_PG_STS",				BIT(0)},
+	{"SATA_PG_STS",				BIT(1)},
+	{"xHCI_PG_STS",				BIT(2)},
+	{"UFSX2_PG_STS",			BIT(3)},
+	{"OTG_PG_STS",				BIT(5)},
+	{"SPA_PG_STS",				BIT(6)},
+	{"SPB_PG_STS",				BIT(7)},
+	{"SPC_PG_STS",				BIT(8)},
+	{"SPD_PG_STS",				BIT(9)},
+	{"SPE_PG_STS",				BIT(10)},
+	{"SPF_PG_STS",				BIT(11)},
+	{"LSX_PG_STS",				BIT(13)},
+	{"P2SB_PG_STS",				BIT(14)},
+	{"PSF_PG_STS",				BIT(15)},
+	{"SBR_PG_STS",				BIT(16)},
+	{"OPIDMI_PG_STS",			BIT(17)},
+	{"THC0_PG_STS",				BIT(18)},
+	{"THC1_PG_STS",				BIT(19)},
+	{"GBETSN_PG_STS",			BIT(20)},
+	{"GBE_PG_STS",				BIT(21)},
+	{"LPSS_PG_STS",				BIT(22)},
+	{"MMP_UFSX2_PG_STS",			BIT(23)},
+	{"MMP_UFSX2B_PG_STS",			BIT(24)},
+	{"FIA_PG_STS",				BIT(25)},
+	{}
+};
+
+const struct pmc_bit_map tgl_d3_status_map[] = {
+	{"ADSP_D3_STS",				BIT(0)},
+	{"SATA_D3_STS",				BIT(1)},
+	{"xHCI0_D3_STS",			BIT(2)},
+	{"xDCI1_D3_STS",			BIT(5)},
+	{"SDX_D3_STS",				BIT(6)},
+	{"EMMC_D3_STS",				BIT(7)},
+	{"IS_D3_STS",				BIT(8)},
+	{"THC0_D3_STS",				BIT(9)},
+	{"THC1_D3_STS",				BIT(10)},
+	{"GBE_D3_STS",				BIT(11)},
+	{"GBE_TSN_D3_STS",			BIT(12)},
+	{}
+};
+
+const struct pmc_bit_map tgl_vnn_req_status_map[] = {
+	{"GPIO_COM0_VNN_REQ_STS",		BIT(1)},
+	{"GPIO_COM1_VNN_REQ_STS",		BIT(2)},
+	{"GPIO_COM2_VNN_REQ_STS",		BIT(3)},
+	{"GPIO_COM3_VNN_REQ_STS",		BIT(4)},
+	{"GPIO_COM4_VNN_REQ_STS",		BIT(5)},
+	{"GPIO_COM5_VNN_REQ_STS",		BIT(6)},
+	{"Audio_VNN_REQ_STS",			BIT(7)},
+	{"ISH_VNN_REQ_STS",			BIT(8)},
+	{"CNVI_VNN_REQ_STS",			BIT(9)},
+	{"eSPI_VNN_REQ_STS",			BIT(10)},
+	{"Display_VNN_REQ_STS",			BIT(11)},
+	{"DTS_VNN_REQ_STS",			BIT(12)},
+	{"SMBUS_VNN_REQ_STS",			BIT(14)},
+	{"CSME_VNN_REQ_STS",			BIT(15)},
+	{"SMLINK0_VNN_REQ_STS",			BIT(16)},
+	{"SMLINK1_VNN_REQ_STS",			BIT(17)},
+	{"CLINK_VNN_REQ_STS",			BIT(20)},
+	{"DCI_VNN_REQ_STS",			BIT(21)},
+	{"ITH_VNN_REQ_STS",			BIT(22)},
+	{"CSME_VNN_REQ_STS",			BIT(24)},
+	{"GBE_VNN_REQ_STS",			BIT(25)},
+	{}
+};
+
+const struct pmc_bit_map tgl_vnn_misc_status_map[] = {
+	{"CPU_C10_REQ_STS_0",			BIT(0)},
+	{"PCIe_LPM_En_REQ_STS_3",		BIT(3)},
+	{"ITH_REQ_STS_5",			BIT(5)},
+	{"CNVI_REQ_STS_6",			BIT(6)},
+	{"ISH_REQ_STS_7",			BIT(7)},
+	{"USB2_SUS_PG_Sys_REQ_STS_10",		BIT(10)},
+	{"PCIe_Clk_REQ_STS_12",			BIT(12)},
+	{"MPHY_Core_DL_REQ_STS_16",		BIT(16)},
+	{"Break-even_En_REQ_STS_17",		BIT(17)},
+	{"Auto-demo_En_REQ_STS_18",		BIT(18)},
+	{"MPHY_SUS_REQ_STS_22",			BIT(22)},
+	{"xDCI_attached_REQ_STS_24",		BIT(24)},
+	{}
+};
+
+const struct pmc_bit_map tgl_signal_status_map[] = {
+	{"LSX_Wake0_En_STS",			BIT(0)},
+	{"LSX_Wake0_Pol_STS",			BIT(1)},
+	{"LSX_Wake1_En_STS",			BIT(2)},
+	{"LSX_Wake1_Pol_STS",			BIT(3)},
+	{"LSX_Wake2_En_STS",			BIT(4)},
+	{"LSX_Wake2_Pol_STS",			BIT(5)},
+	{"LSX_Wake3_En_STS",			BIT(6)},
+	{"LSX_Wake3_Pol_STS",			BIT(7)},
+	{"LSX_Wake4_En_STS",			BIT(8)},
+	{"LSX_Wake4_Pol_STS",			BIT(9)},
+	{"LSX_Wake5_En_STS",			BIT(10)},
+	{"LSX_Wake5_Pol_STS",			BIT(11)},
+	{"LSX_Wake6_En_STS",			BIT(12)},
+	{"LSX_Wake6_Pol_STS",			BIT(13)},
+	{"LSX_Wake7_En_STS",			BIT(14)},
+	{"LSX_Wake7_Pol_STS",			BIT(15)},
+	{"Intel_Se_IO_Wake0_En_STS",		BIT(16)},
+	{"Intel_Se_IO_Wake0_Pol_STS",		BIT(17)},
+	{"Intel_Se_IO_Wake1_En_STS",		BIT(18)},
+	{"Intel_Se_IO_Wake1_Pol_STS",		BIT(19)},
+	{"Int_Timer_SS_Wake0_En_STS",		BIT(20)},
+	{"Int_Timer_SS_Wake0_Pol_STS",		BIT(21)},
+	{"Int_Timer_SS_Wake1_En_STS",		BIT(22)},
+	{"Int_Timer_SS_Wake1_Pol_STS",		BIT(23)},
+	{"Int_Timer_SS_Wake2_En_STS",		BIT(24)},
+	{"Int_Timer_SS_Wake2_Pol_STS",		BIT(25)},
+	{"Int_Timer_SS_Wake3_En_STS",		BIT(26)},
+	{"Int_Timer_SS_Wake3_Pol_STS",		BIT(27)},
+	{"Int_Timer_SS_Wake4_En_STS",		BIT(28)},
+	{"Int_Timer_SS_Wake4_Pol_STS",		BIT(29)},
+	{"Int_Timer_SS_Wake5_En_STS",		BIT(30)},
+	{"Int_Timer_SS_Wake5_Pol_STS",		BIT(31)},
+	{}
+};
+
+const struct pmc_bit_map *tgl_lpm_maps[] = {
+	tgl_clocksource_status_map,
+	tgl_power_gating_status_map,
+	tgl_d3_status_map,
+	tgl_vnn_req_status_map,
+	tgl_vnn_misc_status_map,
+	tgl_signal_status_map,
+	NULL
+};
+
+const struct pmc_reg_map tgl_reg_map = {
+	.pfear_sts = ext_tgl_pfear_map,
+	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
+	.slp_s0_res_counter_step = TGL_PMC_SLP_S0_RES_COUNTER_STEP,
+	.ltr_show_sts = cnp_ltr_show_map,
+	.msr_sts = msr_map,
+	.ltr_ignore_offset = CNP_PMC_LTR_IGNORE_OFFSET,
+	.regmap_length = CNP_PMC_MMIO_REG_LEN,
+	.ppfear0_offset = CNP_PMC_HOST_PPFEAR0A,
+	.ppfear_buckets = ICL_PPFEAR_NUM_ENTRIES,
+	.pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
+	.pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
+	.ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
+	.lpm_num_maps = TGL_LPM_NUM_MAPS,
+	.lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
+	.lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
+	.lpm_en_offset = TGL_LPM_EN_OFFSET,
+	.lpm_priority_offset = TGL_LPM_PRI_OFFSET,
+	.lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
+	.lpm_sts = tgl_lpm_maps,
+	.lpm_status_offset = TGL_LPM_STATUS_OFFSET,
+	.lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
+	.etr3_offset = ETR3_OFFSET,
+};
+
+void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	const int num_maps = pmcdev->map->lpm_num_maps;
+	u32 lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
+	union acpi_object *out_obj;
+	struct acpi_device *adev;
+	guid_t s0ix_dsm_guid;
+	u32 *lpm_req_regs, *addr;
+
+	adev = ACPI_COMPANION(&pdev->dev);
+	if (!adev)
+		return;
+
+	guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
+
+	out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
+				    ACPI_GET_LOW_MODE_REGISTERS, NULL);
+	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
+		u32 size = out_obj->buffer.length;
+
+		if (size != lpm_size) {
+			acpi_handle_debug(adev->handle,
+				"_DSM returned unexpected buffer size, have %u, expect %u\n",
+				size, lpm_size);
+			goto free_acpi_obj;
+		}
+	} else {
+		acpi_handle_debug(adev->handle,
+				  "_DSM function 0 evaluation failed\n");
+		goto free_acpi_obj;
+	}
+
+	addr = (u32 *)out_obj->buffer.pointer;
+
+	lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
+				     GFP_KERNEL);
+	if (!lpm_req_regs)
+		goto free_acpi_obj;
+
+	memcpy(lpm_req_regs, addr, lpm_size);
+	pmcdev->lpm_req_regs = lpm_req_regs;
+
+free_acpi_obj:
+	ACPI_FREE(out_obj);
+}
+
+void tgl_core_configure(struct pmc_dev *pmcdev)
+{
+	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
+	/* Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
+	 */
+	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
+	pmc_core_send_ltr_ignore(pmcdev, 3);
+}
+
+void tgl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &tgl_reg_map;
+	pmcdev->core_configure = tgl_core_configure;
+}
-- 
2.25.1

