Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790876BBC39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjCOSe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjCOSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160601715F;
        Wed, 15 Mar 2023 11:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905256; x=1710441256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w54rzDIFvclAC/9zKRmf3nOrZJbpqYh8AxeBdQIJTS0=;
  b=hGsxbOcjbmAfJ6fU00AZXNz9shc3g/OE4WJsDAWczNnn2B87f86GTF3F
   6VnFgSacDuWQPNCy9irU2uiosQLOZUKnQr/ytXATgtoCABFKwe7dEDvIG
   lxNr3sZz9TUqwIuPghRr5wnWO+PQniw87B+RWxF+rcQJPfpplkXzkYK4/
   553w8uds46rLgHJZnvcPNg04oi/ezFIffLlLJBZrz74GBtzrYfv+Z/EOn
   MCFXTNptYJIAWsCV3LxRpPZmjjvY7P4qgpQ/jO+ci4WxAMnu2bxMg2JlI
   Dz7CpM/YigEhcNVQrevwVMLKoZCPN4R8kjshECqQJYOZ7iu/RUXkT7XpR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154584"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154584"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435229"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435229"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:09 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id 0C6C3580BF6;
        Wed, 15 Mar 2023 11:34:09 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 11/11] platform/x86/intel/pmc/mtl: get LPM information using Intel PMT
Date:   Wed, 15 Mar 2023 11:34:05 -0700
Message-Id: <20230315183405.2465630-12-david.e.box@linux.intel.com>
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

For Meteor Lake, retrieve the PMC Lower Power Mode (LPM) information using
Intel PMT Telemetry API.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.c |  1 +
 drivers/platform/x86/intel/pmc/core.h |  1 +
 drivers/platform/x86/intel/pmc/mtl.c  | 64 +++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 3833ea4a758e..2e4a9ca1be62 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1291,4 +1291,5 @@ module_platform_driver(pmc_core_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
+MODULE_IMPORT_NS(INTEL_PMT);
 MODULE_IMPORT_NS(INTEL_VSEC);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index f4b69861c17b..e5d33999c865 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -306,6 +306,7 @@ struct pmc_reg_map {
 	const u32 lpm_status_offset;
 	const u32 lpm_live_status_offset;
 	const u32 etr3_offset;
+	const u8  *lpm_reg_index;
 };
 
 /**
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 74f1f4c44812..d51ec35e085d 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -21,6 +21,13 @@
 #define SSRAM_PCH_OFFSET	0x60
 #define SSRAM_IOE_OFFSET	0x68
 
+#define SOCS_LPM_REQ_GUID	0x2625030
+#define LPM_REG_INDEX_OFFSET	2
+#define LPM_REG_NUM		28
+#define LPM_SUBSTATE_NUM	1
+
+static const u8 MTL_LPM_REG_INDEX[] = {0, 4, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20};
+
 const struct pmc_reg_map mtl_reg_map = {
 	.pfear_sts = ext_tgl_pfear_map,
 	.slp_s0_offset = CNP_PMC_SLP_S0_RES_COUNTER_OFFSET,
@@ -45,8 +52,60 @@ const struct pmc_reg_map mtl_reg_map = {
 	.lpm_sts = adl_lpm_maps,
 	.lpm_status_offset = MTL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = MTL_LPM_LIVE_STATUS_OFFSET,
+	.lpm_reg_index = MTL_LPM_REG_INDEX,
 };
 
+/*
+ * Only return error EPROBE_DEFER when telem handle is not yet available,
+ * otherwise returns 0.
+ */
+static int pmc_core_get_mtl_lpm_reqs(struct pmc_dev *pmcdev)
+{
+	const u8 *reg_index = pmcdev->map->lpm_reg_index;
+	const int num_maps = pmcdev->map->lpm_num_maps;
+	struct pci_dev *pcidev = pmcdev->ssram_pcidev;
+	u32 lpm_size = LPM_MAX_NUM_MODES * num_maps;
+	struct telem_handle *handle;
+	int i, j, map_offset = 0;
+	u32 *lpm_req_regs;
+
+	if (!pcidev)
+		return 0;
+
+	handle = pmt_telem_find_and_register_handle(pcidev, SOCS_LPM_REQ_GUID, 0);
+	if (IS_ERR(handle)) {
+		dev_err(&pmcdev->pdev->dev,
+				"pmc_core: couldn't get telem handle %ld", PTR_ERR(handle));
+		return -EPROBE_DEFER;
+	}
+
+	lpm_req_regs = devm_kzalloc(&pmcdev->pdev->dev, lpm_size * sizeof(u32),
+				     GFP_KERNEL);
+
+	for (j = 0; j < pmcdev->num_lpm_modes; j++) {
+		int mode = pmcdev->lpm_en_modes[j];
+		u32 *ptr = lpm_req_regs + mode * num_maps;
+
+		for (i = 0; i < num_maps; ++i) {
+			u8 index = reg_index[i] + LPM_REG_INDEX_OFFSET + map_offset;
+			int err;
+
+			err = pmt_telem_read32(handle, index, ptr, 1);
+			if (err) {
+				dev_err(&pmcdev->pdev->dev, "pmt_telem read failed: %d", err);
+				pmt_telem_unregister_handle(handle);
+				return 0;
+			}
+			++ptr;
+		}
+		map_offset += LPM_REG_NUM + LPM_SUBSTATE_NUM;
+	}
+	pmcdev->lpm_req_regs = lpm_req_regs;
+	pmt_telem_unregister_handle(handle);
+
+	return 0;
+}
+
 static void
 mtl_pmc_add_pmt(struct pmc_dev *pmcdev, struct pci_dev *pdev, u64 ssram_base)
 {
@@ -152,6 +211,11 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 	mtl_pmc_ssram_init(pmcdev);
 
 	pmc_core_get_low_power_modes(pmcdev->pdev);
+	ret = pmc_core_get_mtl_lpm_reqs(pmcdev);
+	if (ret) {
+		iounmap(pmcdev->regbase);
+		return ret;
+	}
 
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
-- 
2.34.1

