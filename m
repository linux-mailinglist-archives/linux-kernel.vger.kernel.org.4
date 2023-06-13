Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1634E72EFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbjFMWvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241135AbjFMWvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:51:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE891732;
        Tue, 13 Jun 2023 15:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686696696; x=1718232696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=liv5qZIzM+Le5APnzo6PyFKea9u3jjhGd/AsZAO4fxw=;
  b=Z1KO35VId/eEo659ZvNCWlJ2mTbaxmIE71ckLJVOvpmuUI4ZFZdxWbiJ
   Q4OLjK2Ssmk5Xzw7o8x1qfUuMPDYbtpj8SB7IkoHeCPxkii2ndwey4Nqc
   fbJrpeRDjBN4sZ0EK4puKhnUKAo3x8QRalmfEonnBJCL8P0ZayIyg2NQZ
   lZkW0Cwnodio3CXl1nmSBjtCM9r9mv/14Dlef6DloUutNKBZeXqULPDuL
   jO21dOaiU/BAp8vNpkqaVuBzdUMKAa0W1ckl6bpUtR2KPeYa9W10f+sNm
   bZgBLhf3jjatDOUegpj2vLULfiD1bzAFZDjzaH/wiKnH8tPg5ti+1EUqJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444842178"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="444842178"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824589634"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="824589634"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 15:51:35 -0700
Received: from rjingar-desk5.amr.corp.intel.com (hciettox-mobl.amr.corp.intel.com [10.212.23.107])
        by linux.intel.com (Postfix) with ESMTP id 55DE3580D61;
        Tue, 13 Jun 2023 15:51:35 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     david.e.box@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        irenic.rajneesh@gmail.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, hdegoede@redhat.com
Cc:     xi.pardee@intel.com
Subject: [PATCH 2/8] platform/x86:intel/pmc: Combine core_init() and core_configure()
Date:   Tue, 13 Jun 2023 15:53:41 -0700
Message-Id: <20230613225347.2720665-3-rajvi.jingar@linux.intel.com>
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

From: Xi Pardee <xi.pardee@intel.com>

Combine core_init() and core_configure() functions to have a
cleaner setup for platforms.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 15 +++++----
 drivers/platform/x86/intel/pmc/cnp.c  | 15 ++++++++-
 drivers/platform/x86/intel/pmc/core.c | 47 +++++++++++++++------------
 drivers/platform/x86/intel/pmc/core.h | 19 +++++------
 drivers/platform/x86/intel/pmc/icl.c  |  3 +-
 drivers/platform/x86/intel/pmc/mtl.c  | 26 ++++++++-------
 drivers/platform/x86/intel/pmc/spt.c  |  3 +-
 drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----
 8 files changed, 85 insertions(+), 58 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 5cbd40979f2a..f678ce308cc7 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -309,17 +309,20 @@ const struct pmc_reg_map adl_reg_map = {
 	.lpm_live_status_offset = ADL_LPM_LIVE_STATUS_OFFSET,
 };
 
-void adl_core_configure(struct pmc_dev *pmcdev)
+int adl_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
+	pmcdev->map = &adl_reg_map;
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 	pmc_core_send_ltr_ignore(pmcdev, 3);
-}
 
-void adl_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &adl_reg_map;
-	pmcdev->core_configure = adl_core_configure;
+	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 7fb38815c4eb..5fb2d191ce30 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -204,7 +204,20 @@ const struct pmc_reg_map cnp_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-void cnp_core_init(struct pmc_dev *pmcdev)
+int cnp_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
 	pmcdev->map = &cnp_reg_map;
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
+	/* Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
+	 */
+	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
+	pmc_core_send_ltr_ignore(pmcdev, 3);
+
+	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index ed91ef9d1cf6..0d4cda7c1833 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -948,6 +948,25 @@ static void pmc_core_get_low_power_modes(struct platform_device *pdev)
 	}
 }
 
+int get_primary_reg_base(struct pmc_dev *pmcdev)
+{
+	u64 slp_s0_addr;
+
+	if (lpit_read_residency_count_address(&slp_s0_addr)) {
+		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
+
+		if (page_is_ram(PHYS_PFN(pmcdev->base_addr)))
+			return -ENODEV;
+	} else {
+		pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
+	}
+
+	pmcdev->regbase = ioremap(pmcdev->base_addr, pmcdev->map->regmap_length);
+	if (!pmcdev->regbase)
+		return -ENOMEM;
+	return 0;
+}
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -1099,8 +1118,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 	static bool device_initialized;
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
-	void (*core_init)(struct pmc_dev *pmcdev);
-	u64 slp_s0_addr;
+	int (*core_init)(struct pmc_dev *pmcdev);
+	int ret;
 
 	if (device_initialized)
 		return -ENODEV;
@@ -1116,7 +1135,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!cpu_id)
 		return -ENODEV;
 
-	core_init = (void  (*)(struct pmc_dev *))cpu_id->driver_data;
+	core_init = (int (*)(struct pmc_dev *))cpu_id->driver_data;
 
 	/*
 	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
@@ -1127,26 +1146,12 @@ static int pmc_core_probe(struct platform_device *pdev)
 		core_init = cnp_core_init;
 
 	mutex_init(&pmcdev->lock);
-	core_init(pmcdev);
-
-
-	if (lpit_read_residency_count_address(&slp_s0_addr)) {
-		pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
-
-		if (page_is_ram(PHYS_PFN(pmcdev->base_addr)))
-			return -ENODEV;
-	} else {
-		pmcdev->base_addr = slp_s0_addr - pmcdev->map->slp_s0_offset;
+	ret = core_init(pmcdev);
+	if (ret) {
+		mutex_destroy(&pmcdev->lock);
+		return ret;
 	}
 
-	pmcdev->regbase = ioremap(pmcdev->base_addr,
-				  pmcdev->map->regmap_length);
-	if (!pmcdev->regbase)
-		return -ENOMEM;
-
-	if (pmcdev->core_configure)
-		pmcdev->core_configure(pmcdev);
-
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
 	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 86d38270000a..a672659b8659 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -334,7 +334,6 @@ struct pmc_reg_map {
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
- * @core_configure:	Function pointer to configure the platform
  * @resume:		Function to perform platform specific resume
  *
  * pmc_dev contains info about power management controller device.
@@ -353,7 +352,6 @@ struct pmc_dev {
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
-	void (*core_configure)(struct pmc_dev *pmcdev);
 	int (*resume)(struct pmc_dev *pmcdev);
 };
 
@@ -427,15 +425,14 @@ extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
 int pmc_core_resume_common(struct pmc_dev *pmcdev);
-void spt_core_init(struct pmc_dev *pmcdev);
-void cnp_core_init(struct pmc_dev *pmcdev);
-void icl_core_init(struct pmc_dev *pmcdev);
-void tgl_core_init(struct pmc_dev *pmcdev);
-void adl_core_init(struct pmc_dev *pmcdev);
-void mtl_core_init(struct pmc_dev *pmcdev);
-void tgl_core_configure(struct pmc_dev *pmcdev);
-void adl_core_configure(struct pmc_dev *pmcdev);
-void mtl_core_configure(struct pmc_dev *pmcdev);
+int get_primary_reg_base(struct pmc_dev *pmcdev);
+
+int spt_core_init(struct pmc_dev *pmcdev);
+int cnp_core_init(struct pmc_dev *pmcdev);
+int icl_core_init(struct pmc_dev *pmcdev);
+int tgl_core_init(struct pmc_dev *pmcdev);
+int adl_core_init(struct pmc_dev *pmcdev);
+int mtl_core_init(struct pmc_dev *pmcdev);
 
 #define pmc_for_each_mode(i, mode, pmcdev)		\
 	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index 2f11b1a6daeb..a671d7e86431 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -50,7 +50,8 @@ const struct pmc_reg_map icl_reg_map = {
 	.etr3_offset = ETR3_OFFSET,
 };
 
-void icl_core_init(struct pmc_dev *pmcdev)
+int icl_core_init(struct pmc_dev *pmcdev)
 {
 	pmcdev->map = &icl_reg_map;
+	return get_primary_reg_base(pmcdev);
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index cdcf743b5e2c..a2fc96f9ef11 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -467,15 +467,6 @@ const struct pmc_reg_map mtl_socm_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 };
 
-void mtl_core_configure(struct pmc_dev *pmcdev)
-{
-	/* Due to a hardware limitation, the GBE LTR blocks PC10
-	 * when a cable is attached. Tell the PMC to ignore it.
-	 */
-	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
-	pmc_core_send_ltr_ignore(pmcdev, 3);
-}
-
 #define MTL_GNA_PCI_DEV	0x7e4c
 #define MTL_IPU_PCI_DEV	0x7d19
 #define MTL_VPU_PCI_DEV	0x7d1d
@@ -515,12 +506,25 @@ static int mtl_resume(struct pmc_dev *pmcdev)
 	return pmc_core_resume_common(pmcdev);
 }
 
-void mtl_core_init(struct pmc_dev *pmcdev)
+int mtl_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
 	pmcdev->map = &mtl_socm_reg_map;
-	pmcdev->core_configure = mtl_core_configure;
 
 	mtl_d3_fixup();
 
 	pmcdev->resume = mtl_resume;
+
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
+	/* Due to a hardware limitation, the GBE LTR blocks PC10
+	 * when a cable is attached. Tell the PMC to ignore it.
+	 */
+	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
+	pmc_core_send_ltr_ignore(pmcdev, 3);
+
+	return 0;
 }
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index e16982236778..f34015692bb8 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -134,7 +134,8 @@ const struct pmc_reg_map spt_reg_map = {
 	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
-void spt_core_init(struct pmc_dev *pmcdev)
+int spt_core_init(struct pmc_dev *pmcdev)
 {
 	pmcdev->map = &spt_reg_map;
+	return get_primary_reg_base(pmcdev);
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index c245ada849d0..90807bd947ed 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -252,18 +252,21 @@ void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
 	ACPI_FREE(out_obj);
 }
 
-void tgl_core_configure(struct pmc_dev *pmcdev)
+int tgl_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
+	pmcdev->map = &tgl_reg_map;
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
 	dev_dbg(&pmcdev->pdev->dev, "ignoring GBE LTR\n");
 	pmc_core_send_ltr_ignore(pmcdev, 3);
-}
 
-void tgl_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &tgl_reg_map;
-	pmcdev->core_configure = tgl_core_configure;
+	return 0;
 }
-- 
2.25.1

