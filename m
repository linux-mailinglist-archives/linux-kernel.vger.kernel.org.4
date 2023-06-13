Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5DA72EFB5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241385AbjFMWwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjFMWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E11BEB;
        Tue, 13 Jun 2023 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696698; x=1718232698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRcCSIse+0pgqd/VymmgSYUU5N49FGDLwpSbyMLrtOc=;
  b=ZajnNqy7Plie6LmVlTNYLzSLs2/i6heVBenLrh9cWquxQ6Mvq/df/+kh
   S8CuReH9ATQyzJM+oufWGQono5ofpGG44o6QrqDEUHnruKoZY0kI0dOAb
   k+hHS8lyBMofgAtVFYrBp7EmUpnD7MUWNGNAmcVgBZCtC2lKYNtMTRgK0
   kWRgxTmsZLNkri0V0/ewi0UnLNz9cyvNyIKUTo8kRCCaTU72oRkgxhWhN
   7nDF350KZFlkjT5kLruRmmIUuJ0OVPLnYaCvgQ0bmR2z7dex2ClHpGQJp
   pUZTrBdWqFY6UODI1I7tfxs2N3S3y1h9pLb9a96gltuEs2y4vd+O3652Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842193"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842193"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589645"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589645"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:37 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id 50C83580BEE;
        Tue, 13 Jun 2023 15:51:37 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com, Rajvi Jingar <rajvi.jingar@linux.intel.com>
Subject: [PATCH 5/8] platform/x86:intel/pmc: Discover PMC devices
Date:   Tue, 13 Jun 2023 15:53:44 -0700
Message-Id: <20230613225347.2720665-6-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
References: <20230613225347.2720665-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

On platforms with multiple PMCs, additional PMC devices are discovered
in the SSRAM device associated with the primary PMC. Add support for
discovering PMC devices from SSRAM. Use PMC devid to assign the
corresponding register map.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Makefile     |   4 +-
 drivers/platform/x86/intel/pmc/core.c       |  34 +++--
 drivers/platform/x86/intel/pmc/core.h       |  16 +++
 drivers/platform/x86/intel/pmc/core_ssram.c | 133 ++++++++++++++++++++
 drivers/platform/x86/intel/pmc/mtl.c        |   7 ++
 5 files changed, 180 insertions(+), 14 deletions(-)
 create mode 100644 drivers/platform/x86/intel/pmc/core_ssram.c

diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
index f96bc2e19503..3a4cf1cbc1ca 100644
--- a/drivers/platform/x86/intel/pmc/Makefile
+++ b/drivers/platform/x86/intel/pmc/Makefile
@@ -3,8 +3,8 @@
 # Intel x86 Platform-Specific Drivers
 #
 
-intel_pmc_core-y			:= core.o spt.o cnp.o icl.o tgl.o \
-					   adl.o mtl.o
+intel_pmc_core-y			:= core.o core_ssram.o spt.o cnp.o \
+					   icl.o tgl.o adl.o mtl.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o
 intel_pmc_core_pltdrv-y			:= pltdrv.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core_pltdrv.o
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 5864d2e85706..5a36b3f77bc5 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1183,6 +1183,26 @@ static void pmc_core_do_dmi_quirks(struct pmc *pmc)
 		pmc_core_xtal_ignore(pmc);
 }
 
+static void pmc_core_clean_structure(struct platform_device *pdev)
+{
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
+		struct pmc *pmc = pmcdev->pmcs[i];
+
+		if (pmc)
+			iounmap(pmc->regbase);
+	}
+
+	if (pmcdev->ssram_pcidev) {
+		pci_dev_put(pmcdev->ssram_pcidev);
+		pci_disable_device(pmcdev->ssram_pcidev);
+	}
+	platform_set_drvdata(pdev, NULL);
+	mutex_destroy(&pmcdev->lock);
+}
+
 static int pmc_core_probe(struct platform_device *pdev)
 {
 	static bool device_initialized;
@@ -1225,7 +1245,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	mutex_init(&pmcdev->lock);
 	ret = core_init(pmcdev);
 	if (ret) {
-		mutex_destroy(&pmcdev->lock);
+		pmc_core_clean_structure(pdev);
 		return ret;
 	}
 
@@ -1246,18 +1266,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 static void pmc_core_remove(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); ++i) {
-		struct pmc *pmc = pmcdev->pmcs[i];
-
-		if (pmc)
-			iounmap(pmc->regbase);
-	}
-
 	pmc_core_dbgfs_unregister(pmcdev);
-	platform_set_drvdata(pdev, NULL);
-	mutex_destroy(&pmcdev->lock);
+	pmc_core_clean_structure(pdev);
 }
 
 static bool warn_on_s0ix_failures;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4f21d452a033..06c444917a16 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -319,6 +319,17 @@ struct pmc_reg_map {
 	const u32 etr3_offset;
 };
 
+/**
+ * struct pmc_info - Structure to keep pmc info
+ * @devid:		device id of the pmc device
+ * @map:		pointer to a pmc_reg_map struct that contains platform
+ *			specific attributes
+ */
+struct pmc_info {
+	u16 devid;
+	const struct pmc_reg_map *map;
+};
+
 /**
  * struct pmc - pmc private info structure
  * @base_addr:		contains pmc base address
@@ -340,6 +351,7 @@ struct pmc {
  * struct pmc_dev - pmc device structure
  * @devs:		pointer to an array of pmc pointers
  * @pdev:		pointer to platform_device struct
+ * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
@@ -356,6 +368,7 @@ struct pmc_dev {
 	struct pmc *pmcs[MAX_NUM_PMC];
 	struct dentry *dbgfs_dir;
 	struct platform_device *pdev;
+	struct pci_dev *ssram_pcidev;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
@@ -368,6 +381,7 @@ struct pmc_dev {
 	bool has_die_c6;
 	u32 die_c6_offset;
 	struct telem_endpoint *punit_ep;
+	struct pmc_info *regmap_list;
 };
 
 enum pmc_index {
@@ -450,6 +464,8 @@ extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
 int get_primary_reg_base(struct pmc *pmc);
 
+extern void pmc_core_ssram_init(struct pmc_dev *pmcdev);
+
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
 int icl_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
new file mode 100644
index 000000000000..13fa16f0d52e
--- /dev/null
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file contains functions to handle discovery of PMC metrics located
+ * in the PMC SSRAM PCI device.
+ *
+ * Copyright (c) 2023, Intel Corporation.
+ * All Rights Reserved.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+#include "core.h"
+
+#define SSRAM_HDR_SIZE		0x100
+#define SSRAM_PWRM_OFFSET	0x14
+#define SSRAM_DVSEC_OFFSET	0x1C
+#define SSRAM_DVSEC_SIZE	0x10
+#define SSRAM_PCH_OFFSET	0x60
+#define SSRAM_IOE_OFFSET	0x68
+#define SSRAM_DEVID_OFFSET	0x70
+
+static const struct pmc_reg_map *pmc_core_find_regmap(struct pmc_info *list, u16 devid)
+{
+	for (; list->map; ++list)
+		if (devid == list->devid)
+			return list->map;
+
+	return NULL;
+}
+
+static inline u64 get_base(void __iomem *addr, u32 offset)
+{
+	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
+}
+
+static void
+pmc_core_pmc_add(struct pmc_dev *pmcdev, u64 pwrm_base,
+		 const struct pmc_reg_map *reg_map, int pmc_index)
+{
+	struct pmc *pmc = pmcdev->pmcs[pmc_index];
+
+	if (!pwrm_base)
+		return;
+
+	/* Memory for primary PMC has been allocated in core.c */
+	if (!pmc) {
+		pmc = devm_kzalloc(&pmcdev->pdev->dev, sizeof(*pmc), GFP_KERNEL);
+		if (!pmc)
+			return;
+	}
+
+	pmc->map = reg_map;
+	pmc->base_addr = pwrm_base;
+	pmc->regbase = ioremap(pmc->base_addr, pmc->map->regmap_length);
+
+	if (!pmc->regbase) {
+		devm_kfree(&pmcdev->pdev->dev, pmc);
+		return;
+	}
+
+	pmcdev->pmcs[pmc_index] = pmc;
+}
+
+static void
+pmc_core_ssram_get_pmc(struct pmc_dev *pmcdev, void __iomem *ssram, u32 offset,
+		       int pmc_idx)
+{
+	u64 pwrm_base;
+	u16 devid;
+
+	if (pmc_idx != PMC_IDX_SOC) {
+		u64 ssram_base = get_base(ssram, offset);
+
+		if (!ssram_base)
+			return;
+
+		ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+		if (!ssram)
+			return;
+	}
+
+	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
+	devid = readw(ssram + SSRAM_DEVID_OFFSET);
+
+	if (pmcdev->regmap_list) {
+		const struct pmc_reg_map *map;
+
+		map = pmc_core_find_regmap(pmcdev->regmap_list, devid);
+		if (map)
+			pmc_core_pmc_add(pmcdev, pwrm_base, map, pmc_idx);
+	}
+
+	if (pmc_idx != PMC_IDX_SOC)
+		iounmap(ssram);
+}
+
+void pmc_core_ssram_init(struct pmc_dev *pmcdev)
+{
+	void __iomem *ssram;
+	struct pci_dev *pcidev;
+	u64 ssram_base;
+	int ret;
+
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
+	if (!pcidev)
+		goto out;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret)
+		goto release_dev;
+
+	ssram_base = pcidev->resource[0].start;
+	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		goto disable_dev;
+
+	pmcdev->ssram_pcidev = pcidev;
+
+	pmc_core_ssram_get_pmc(pmcdev, ssram, 0, PMC_IDX_SOC);
+	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_IOE_OFFSET, PMC_IDX_IOE);
+	pmc_core_ssram_get_pmc(pmcdev, ssram, SSRAM_PCH_OFFSET, PMC_IDX_PCH);
+
+	iounmap(ssram);
+out:
+	return;
+
+disable_dev:
+	pci_disable_device(pcidev);
+release_dev:
+	pci_dev_put(pcidev);
+}
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 69df6d7fee56..e53dc7900dbf 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -467,6 +467,10 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 };
 
+static struct pmc_info mtl_pmc_info_list[] = {
+	{}
+};
+
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -517,6 +521,9 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 
 	pmcdev->resume = mtl_resume;
 
+	pmcdev->regmap_list = mtl_pmc_info_list;
+	pmc_core_ssram_init(pmcdev);
+
 	ret = get_primary_reg_base(pmc);
 	if (ret)
 		return ret;
-- 
2.25.1

