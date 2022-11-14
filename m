Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B314628808
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiKNSNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiKNSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:12:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECA24976;
        Mon, 14 Nov 2022 10:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449565; x=1699985565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8ktWPCQxOcOq1xO3BnSVMNmnc14R0+VcwCvbZeVecY=;
  b=Jvjl5EpjVvVShouyXyMpKgvC1W/piSn6Un36il5zcN0NBRnMoSnD8HMf
   W1pPdH1NnsgguI5ceOTjviZk+ZFSYrO20AOE4vDIS1sL6pq/tdUvMqYyF
   jYoU5m+amgmuAXn7kQBFIFRuTdYur9O10Hm6cc5y0e2fjuiTvAaiJbQfq
   wYwKytQQqSDFv2uRULHKotvf7u7RhFODSNaLgZM/RrD3Qi+nIsK5hq73Z
   4JCcwF/VBNvJNfpqsQMPjI70HTchXhHwhECVsLd/QiscUDZxaTPPTjsmI
   ZWzaMcaliE7eJeEoVSy392C/+atmLCPxjb+TLhAQXGzBalcpf2G79GxMI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310751748"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310751748"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="967672973"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="967672973"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 14 Nov 2022 10:12:45 -0800
Received: from otcpl-manager.jf.intel.com (otcpl-manager.jf.intel.com [10.54.77.21])
        by linux.intel.com (Postfix) with ESMTP id 05057580A5F;
        Mon, 14 Nov 2022 10:12:45 -0800 (PST)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
Subject: [PATCH v3 1/8] platform/x86: intel/pmc: Replace all the reg_map with init functions
Date:   Mon, 14 Nov 2022 10:12:00 -0800
Message-Id: <20221114181207.2062901-2-gayatri.kammela@linux.intel.com>
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

The current implementation of pmc core driver has the reg_map assigned
to the CPUID of each platform. Replace the reg_map with init functions
that are defined for each platform.

This is a preparatory patch for redesigning the pmc core driver.

Cc: David E Box <david.e.box@linux.intel.com>
Reviewed-by: "David E. Box" <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
Signed-off-by: "David E. Box" <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c | 114 +++++++++++++++++---------
 drivers/platform/x86/intel/pmc/core.h |  13 +++
 2 files changed, 90 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 17ec5825d13d..b434cf5b094b 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/uaccess.h>
@@ -1895,27 +1894,73 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
 	}
 }
 
+void spt_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &spt_reg_map;
+}
+
+void cnp_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &cnp_reg_map;
+}
+
+void icl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &icl_reg_map;
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
+
+void adl_core_configure(struct pmc_dev *pmcdev)
+{
+	/* Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
+	 */
+	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
+	pmc_core_send_ltr_ignore(pmcdev, 3);
+}
+
+void adl_core_init(struct pmc_dev *pmcdev)
+{
+	pmcdev->map = &adl_reg_map;
+	pmcdev->core_configure = adl_core_configure;
+}
+
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&spt_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&spt_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&spt_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&spt_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&cnp_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&cnp_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&cnp_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&icl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_reg_map),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_reg_map),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		spt_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		spt_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		spt_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		spt_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	cnp_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		icl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	icl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		cnp_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		cnp_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	icl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		adl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        tgl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		adl_core_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	adl_core_init),
 	{}
 };
 
@@ -1975,6 +2020,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	static bool device_initialized;
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
+	void (*core_init)(struct pmc_dev *pmcdev);
 	u64 slp_s0_addr;
 
 	if (device_initialized)
@@ -1985,20 +2031,25 @@ static int pmc_core_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, pmcdev);
+	pmcdev->pdev = pdev;
 
 	cpu_id = x86_match_cpu(intel_pmc_core_ids);
 	if (!cpu_id)
 		return -ENODEV;
 
-	pmcdev->map = (struct pmc_reg_map *)cpu_id->driver_data;
+	core_init = (void  (*)(struct pmc_dev *))cpu_id->driver_data;
 
 	/*
 	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
 	 * Sunrisepoint PCH regmap can't be used. Use Cannon Lake PCH regmap
 	 * in this case.
 	 */
-	if (pmcdev->map == &spt_reg_map && !pci_dev_present(pmc_pci_ids))
-		pmcdev->map = &cnp_reg_map;
+	if (core_init == spt_core_init && !pci_dev_present(pmc_pci_ids))
+		core_init = cnp_core_init;
+
+	mutex_init(&pmcdev->lock);
+	core_init(pmcdev);
+
 
 	if (lpit_read_residency_count_address(&slp_s0_addr)) {
 		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
@@ -2014,24 +2065,13 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!pmcdev->regbase)
 		return -ENOMEM;
 
-	mutex_init(&pmcdev->lock);
+	if (pmcdev->core_configure)
+		pmcdev->core_configure(pmcdev);
 
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
 	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
-	if (pmcdev->map == &tgl_reg_map)
-		pmc_core_get_tgl_lpm_reqs(pdev);
-
-	/*
-	 * On TGL and ADL, due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	if (pmcdev->map == &tgl_reg_map || pmcdev->map == &adl_reg_map) {
-		dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
-		pmc_core_send_ltr_ignore(pmcdev, 3);
-	}
-
 	pmc_core_dbgfs_register(pmcdev);
 
 	device_initialized = true;
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 4c7e77f1ccac..e64b33e46397 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -13,6 +13,7 @@
 #define PMC_CORE_H
 
 #include <linux/bits.h>
+#include <linux/platform_device.h>
 
 #define PMC_BASE_ADDR_DEFAULT			0xFE000000
 
@@ -312,6 +313,7 @@ struct pmc_reg_map {
  * @regbase:		pointer to io-remapped memory location
  * @map:		pointer to pmc_reg_map struct that contains platform
  *			specific attributes
+ * @pdev:		pointer to platform_device struct
  * @dbgfs_dir:		path to debugfs interface
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
@@ -322,6 +324,7 @@ struct pmc_reg_map {
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
+ * @core_configure:	Function pointer to configure the platform
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -330,6 +333,7 @@ struct pmc_dev {
 	void __iomem *regbase;
 	const struct pmc_reg_map *map;
 	struct dentry *dbgfs_dir;
+	struct platform_device *pdev;
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
 
@@ -339,8 +343,17 @@ struct pmc_dev {
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
+	void (*core_configure)(struct pmc_dev *pmcdev);
 };
 
+void spt_core_init(struct pmc_dev *pmcdev);
+void cnp_core_init(struct pmc_dev *pmcdev);
+void icl_core_init(struct pmc_dev *pmcdev);
+void tgl_core_init(struct pmc_dev *pmcdev);
+void adl_core_init(struct pmc_dev *pmcdev);
+void tgl_core_configure(struct pmc_dev *pmcdev);
+void adl_core_configure(struct pmc_dev *pmcdev);
+
 #define pmc_for_each_mode(i, mode, pmcdev)		\
 	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
 	     i < pmcdev->num_lpm_modes;			\
-- 
2.25.1

