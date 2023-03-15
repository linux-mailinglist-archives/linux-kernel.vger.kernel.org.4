Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0326BBC3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjCOSeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjCOSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30640198F;
        Wed, 15 Mar 2023 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905255; x=1710441255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqsEbmKGVD86TyjaK4FQ0KAEv5jaN0N9ShVwFwIiVJI=;
  b=dyEoCCeHkrgi7mV4oVIwdxumBp0uRx3/xKW2ocRt4FYozwVGBMVR1yMW
   YnOwl2F835xIt/5bd1aLD0aBtIQ7qSZEIEKHSYR3vjWmuTfQUQwPSTHqN
   p+AgNcDH/VdFcXXiPui7xUPDce8ZxMyKHAAymkZTxw2Vd/m4SMkdffEo6
   B+4P1BSkD/fp/f22U7HfCC4Coa/zqdgzNT5WMbPQVfmuzVKY5x8t4oMQG
   uDoxtiV1C/IVTgGQCdHJpNkMvwR0GLG+OhsnpIOZ38CKI3/tRPYS86JVy
   tTqVdH9gh6KrzHcYQGG5c98Mb/vq7/m7ptQIXhcTziSnrtwjlonWO+Enc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154571"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435224"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435224"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:08 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 6B9F9580C6E;
        Wed, 15 Mar 2023 11:34:08 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 09/11] platform/x86/intel/pmc: Add Intel PMT support for MTL PMC
Date:   Wed, 15 Mar 2023 11:34:03 -0700
Message-Id: <20230315183405.2465630-10-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315183405.2465630-1-david.e.box@linux.intel.com>
References: <20230315183405.2465630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMC SSRAM device contains PMC metrics that are structured in Intel
Platform Monitoring Technology (PMT) telemetry regions. Register these
telemetry regions from the driver so that they may be read using the
Intel PMT API.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/Kconfig |   1 +
 drivers/platform/x86/intel/pmc/core.c  |   6 ++
 drivers/platform/x86/intel/pmc/core.h  |   2 +
 drivers/platform/x86/intel/pmc/mtl.c   | 106 +++++++++++++++++++++++++
 4 files changed, 115 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
index b526597e4deb..d2f651fbec2c 100644
--- a/drivers/platform/x86/intel/pmc/Kconfig
+++ b/drivers/platform/x86/intel/pmc/Kconfig
@@ -7,6 +7,7 @@ config INTEL_PMC_CORE
 	tristate "Intel PMC Core driver"
 	depends on PCI
 	depends on ACPI
+	depends on INTEL_PMT_TELEMETRY
 	help
 	  The Intel Platform Controller Hub for Intel Core SoCs provides access
 	  to Power Management Controller registers via various interfaces. This
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 4769ce0b0fbe..8f3a5a6fc874 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1174,6 +1174,11 @@ static void pmc_core_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	mutex_destroy(&pmcdev->lock);
 	iounmap(pmcdev->regbase);
+
+	if (pmcdev->ssram_pcidev) {
+		pci_dev_put(pmcdev->ssram_pcidev);
+		pci_disable_device(pmcdev->ssram_pcidev);
+	}
 }
 
 static bool warn_on_s0ix_failures;
@@ -1287,3 +1292,4 @@ module_platform_driver(pmc_core_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
+MODULE_IMPORT_NS(INTEL_VSEC);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 3ce83c837fdc..ba30db31f439 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -315,6 +315,7 @@ struct pmc_reg_map {
  * @map:		pointer to pmc_reg_map struct that contains platform
  *			specific attributes
  * @pdev:		pointer to platform_device struct
+ * @ssram_pcidev:	pointer to pci device struct for the PMC SSRAM
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
@@ -334,6 +335,7 @@ struct pmc_dev {
 	const struct pmc_reg_map *map;
 	struct dentry *dbgfs_dir;
 	struct platform_device *pdev;
+	struct pci_dev *ssram_pcidev;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 96106ffbd367..48c7ec094af8 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -8,7 +8,18 @@
  *
  */
 
+#include <linux/pci.h>
+
 #include "core.h"
+#include "../vsec.h"
+#include "../pmt/telemetry.h"
+
+#define SSRAM_HDR_SIZE		0x100
+#define SSRAM_PWRM_OFFSET	0x14
+#define SSRAM_DVSEC_OFFSET	0x1C
+#define SSRAM_DVSEC_SIZE	0x10
+#define SSRAM_PCH_OFFSET	0x60
+#define SSRAM_IOE_OFFSET	0x68
 
 const struct pmc_reg_map mtl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
@@ -36,6 +47,99 @@ const struct pmc_reg_map mtl_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 };
 
+static void
+mtl_pmc_add_pmt(struct pmc_dev *pmcdev, struct pci_dev *pdev, u64 ssram_base)
+{
+	struct intel_vsec_platform_info info = {};
+	struct intel_vsec_header *headers[2] = {};
+	struct intel_vsec_header header;
+	void __iomem *ssram, *dvsec;
+	u32 dvsec_offset;
+	u32 table, hdr;
+
+	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram)
+		return;
+
+	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
+	iounmap(ssram);
+
+	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
+	if (!dvsec)
+		return;
+
+	hdr = readl(dvsec + PCI_DVSEC_HEADER1);
+	header.id = readw(dvsec + PCI_DVSEC_HEADER2);
+	header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+	header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+	header.num_entries = readb(dvsec + INTEL_DVSEC_ENTRIES);
+	header.entry_size = readb(dvsec + INTEL_DVSEC_SIZE);
+
+	table = readl(dvsec + INTEL_DVSEC_TABLE);
+	header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+	header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+	iounmap(dvsec);
+
+	headers[0] = &header;
+	info.caps = VSEC_CAP_TELEMETRY;
+	info.headers = headers;
+	info.base_addr = ssram_base;
+
+	intel_vsec_register(pdev, &info);
+}
+
+static inline u64 get_ssram_base(void __iomem *addr, u32 offset)
+{
+	u64 low, high;
+
+	low = readl(addr + offset) & GENMASK(31, 3);
+	high = readl(addr + offset + 4);
+
+	return (high << 32) + low;
+}
+
+static void mtl_pmc_ssram_init(struct pmc_dev *pmcdev)
+{
+	void __iomem *ssram;
+	struct pci_dev *pcidev;
+	u64 socs_ssram_base;
+	u64 ioe_ssram_base;
+	u64 pch_ssram_base;
+	int ret;
+
+	pcidev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(20, 2));
+	if (!pcidev) {
+		dev_err(&pmcdev->pdev->dev, "pci_dev is not found.");
+		return;
+	}
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		pci_dev_put(pcidev);
+		return;
+	}
+
+	socs_ssram_base = pcidev->resource[0].start;
+	ssram = ioremap(socs_ssram_base, SSRAM_HDR_SIZE);
+	if (!ssram) {
+		pci_dev_put(pcidev);
+		pci_disable_device(pcidev);
+		return;
+	}
+
+	pmcdev->ssram_pcidev = pcidev;
+
+	ioe_ssram_base = get_ssram_base(ssram, SSRAM_IOE_OFFSET);
+	pch_ssram_base = get_ssram_base(ssram, SSRAM_PCH_OFFSET);
+	iounmap(ssram);
+
+	mtl_pmc_add_pmt(pmcdev, pcidev, socs_ssram_base);
+	if (ioe_ssram_base)
+		mtl_pmc_add_pmt(pmcdev, pcidev, ioe_ssram_base);
+	if (pch_ssram_base)
+		mtl_pmc_add_pmt(pmcdev, pcidev, pch_ssram_base);
+}
+
 int mtl_core_init(struct pmc_dev *pmcdev)
 {
 	int ret;
@@ -45,6 +149,8 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	mtl_pmc_ssram_init(pmcdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
-- 
2.34.1

