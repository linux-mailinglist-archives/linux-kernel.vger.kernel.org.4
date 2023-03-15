Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832F6BBC36
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCOSem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjCOSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E8AFF0E;
        Wed, 15 Mar 2023 11:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905254; x=1710441254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qeonfz7kPOnTnc23J/5nZOsk6/2p2FjL/PplnJo6pvk=;
  b=CHSngXhu2K90s7o4w6zGUgmviLe3m7g3gWRoR+dMbtwNOnWhHx79Q4nT
   +Uu/el8xyW+VeWSuAwfvp65PTmu7IDFpM+1iCipuFgVtE0HprWfgzATIZ
   rV0Q2hFhw7mQ/LaGMHvcCsoLOPJEDv9Ixd2lr+1qkhBwVfxSOcL/P704q
   oQwfhU+SES+XgAP5BUZ2MmmLGh9UHUYUs1T0mlbqKy/jgMEVlDmyUhXUH
   pRRJ0s2kwQCkDhlWZuJJm+9QmYzdkAd6wIADb4NIyKJYVhUNELTaANUCs
   e7PrFauvVsDIsPVQ4hPioUcL46UBPsZMG6dmDTge0gESdrj/I1tpJgShU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154564"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154564"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435221"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435221"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:08 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 1F2A0580D29;
        Wed, 15 Mar 2023 11:34:08 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 08/11] platform/x86:intel/pmc: Combine core_init and core_configure function
Date:   Wed, 15 Mar 2023 11:34:02 -0700
Message-Id: <20230315183405.2465630-9-david.e.box@linux.intel.com>
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

From: Xi Pardee <xi.pardee@intel.com>

core_init and core_configure functions can be combined to have a
cleaner setup for platforms.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  | 15 +++++----
 drivers/platform/x86/intel/pmc/cnp.c  | 15 ++++++++-
 drivers/platform/x86/intel/pmc/core.c | 48 +++++++++++++++------------
 drivers/platform/x86/intel/pmc/core.h | 20 +++++------
 drivers/platform/x86/intel/pmc/icl.c  |  3 +-
 drivers/platform/x86/intel/pmc/mtl.c  | 15 +++++----
 drivers/platform/x86/intel/pmc/spt.c  |  3 +-
 drivers/platform/x86/intel/pmc/tgl.c  | 15 +++++----
 8 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 5cbd40979f2a..a6ceaf520fd5 100644
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
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index 7fb38815c4eb..fcd07a61f88d 100644
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
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 61ca7c37fb02..4769ce0b0fbe 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -948,6 +948,26 @@ static void pmc_core_get_low_power_modes(struct platform_device *pdev)
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
+	pmcdev->regbase = ioremap(pmcdev->base_addr,
+				  pmcdev->map->regmap_length);
+	if (!pmcdev->regbase)
+		return -ENOMEM;
+	return 0;
+}
+
 static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 {
 	debugfs_remove_recursive(pmcdev->dbgfs_dir);
@@ -1100,8 +1120,8 @@ static int pmc_core_probe(struct platform_device *pdev)
 	static bool device_initialized;
 	struct pmc_dev *pmcdev;
 	const struct x86_cpu_id *cpu_id;
-	void (*core_init)(struct pmc_dev *pmcdev);
-	u64 slp_s0_addr;
+	int (*core_init)(struct pmc_dev *pmcdev);
+	int ret;
 
 	if (device_initialized)
 		return -ENODEV;
@@ -1117,7 +1137,7 @@ static int pmc_core_probe(struct platform_device *pdev)
 	if (!cpu_id)
 		return -ENODEV;
 
-	core_init = (void  (*)(struct pmc_dev *))cpu_id->driver_data;
+	core_init = (int (*)(struct pmc_dev *))cpu_id->driver_data;
 
 	/*
 	 * Coffee Lake has CPU ID of Kaby Lake and Cannon Lake PCH. So here
@@ -1128,26 +1148,12 @@ static int pmc_core_probe(struct platform_device *pdev)
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
index 810204d758ab..3ce83c837fdc 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -325,7 +325,6 @@ struct pmc_reg_map {
  * @num_lpm_modes:	Count of enabled modes
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
- * @core_configure:	Function pointer to configure the platform
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -344,7 +343,6 @@ struct pmc_dev {
 	int num_lpm_modes;
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
-	void (*core_configure)(struct pmc_dev *pmcdev);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -397,16 +395,14 @@ extern const struct pmc_reg_map mtl_reg_map;
 
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
-
-void spt_core_init(struct pmc_dev *pmcdev);
-void cnp_core_init(struct pmc_dev *pmcdev);
-void icl_core_init(struct pmc_dev *pmcdev);
-void tgl_core_init(struct pmc_dev *pmcdev);
-void adl_core_init(struct pmc_dev *pmcdev);
-void mtl_core_init(struct pmc_dev *pmcdev);
-void tgl_core_configure(struct pmc_dev *pmcdev);
-void adl_core_configure(struct pmc_dev *pmcdev);
-void mtl_core_configure(struct pmc_dev *pmcdev);
+extern int get_primary_reg_base(struct pmc_dev *pmcdev);
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
index eeb3bd8c2502..96106ffbd367 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -36,17 +36,20 @@ const struct pmc_reg_map mtl_reg_map = {
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
 };
 
-void mtl_core_configure(struct pmc_dev *pmcdev)
+int mtl_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
+	pmcdev->map = &mtl_reg_map;
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
 
-void mtl_core_init(struct pmc_dev *pmcdev)
-{
-	pmcdev->map = &mtl_reg_map;
-	pmcdev->core_configure = mtl_core_configure;
+	return ret;
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
index c245ada849d0..c69f2672fb92 100644
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
+	return ret;
 }
-- 
2.34.1

