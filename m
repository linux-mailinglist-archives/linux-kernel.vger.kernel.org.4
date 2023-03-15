Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310566BBC38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjCOSer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjCOSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:34:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31337E3BE;
        Wed, 15 Mar 2023 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905255; x=1710441255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hgPn91lasy9XxNu+0Ue+s0aleZeJjAiqqDGwHrAoS/A=;
  b=aFjSTzOsggk6Dtv7UA3wdbnONbY1FIw2qSe/jdsYKZSnFg9hmF6IOwbN
   tMMRS2LN0NgnTURbnubQNEDnzKUSmGB7Ivr/H83m3DS76FwT4gNaZz6uE
   tJ7Vm7LPqkcPEzelLEXSWjBQU84fcYKoCi6ZZN2t1OTGAHFTGhLmlecK/
   UdFCKZGZAn8iamt8OgRwhv7EwG9wKQB74ekmPoD2ACkvliseg9qJsYwtD
   yqtLDywTtiTshfDQV9mrpDvZmvgxugBD55Wf4JsWwPyNuaGD/Che8Fyka
   DyvT54/4FqJFh3Fqvc4kNEhfIcg9JI70s2dnNSv3LQO+0Ua+E38WKNBgK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340154578"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340154578"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="925435227"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925435227"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 15 Mar 2023 11:34:09 -0700
Received: from debox1-desk4.intel.com (unknown [10.209.75.205])
        by linux.intel.com (Postfix) with ESMTP id B9FD8580BF2;
        Wed, 15 Mar 2023 11:34:08 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        andy.shevchenko@gmail.com, rajvi.jingar@linux.intel.com,
        xi.pardee@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 10/11] platform/x86:intel/pmc: Move get_low_power_modes function
Date:   Wed, 15 Mar 2023 11:34:04 -0700
Message-Id: <20230315183405.2465630-11-david.e.box@linux.intel.com>
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

Move the pmc_core_get_low_power_modes function call from probe to init
function. This is the preparation work for retrieving LPM information
using Intel PMT API patch as available low power modes need to be known.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c  |  2 ++
 drivers/platform/x86/intel/pmc/cnp.c  |  2 ++
 drivers/platform/x86/intel/pmc/core.c |  3 +--
 drivers/platform/x86/intel/pmc/core.h |  1 +
 drivers/platform/x86/intel/pmc/icl.c  | 10 +++++++++-
 drivers/platform/x86/intel/pmc/mtl.c  |  2 ++
 drivers/platform/x86/intel/pmc/spt.c  | 10 +++++++++-
 drivers/platform/x86/intel/pmc/tgl.c  |  2 ++
 8 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index a6ceaf520fd5..6101c9c2aa9c 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -318,6 +318,8 @@ int adl_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev->pdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/cnp.c b/drivers/platform/x86/intel/pmc/cnp.c
index fcd07a61f88d..68e7ac7f7a11 100644
--- a/drivers/platform/x86/intel/pmc/cnp.c
+++ b/drivers/platform/x86/intel/pmc/cnp.c
@@ -213,6 +213,8 @@ int cnp_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev->pdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index 8f3a5a6fc874..3833ea4a758e 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -898,7 +898,7 @@ static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
 	return true;
 }
 
-static void pmc_core_get_low_power_modes(struct platform_device *pdev)
+void pmc_core_get_low_power_modes(struct platform_device *pdev)
 {
 	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
 	u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
@@ -1155,7 +1155,6 @@ static int pmc_core_probe(struct platform_device *pdev)
 	}
 
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
-	pmc_core_get_low_power_modes(pdev);
 	pmc_core_do_dmi_quirks(pmcdev);
 
 	pmc_core_dbgfs_register(pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index ba30db31f439..f4b69861c17b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -398,6 +398,7 @@ extern const struct pmc_reg_map mtl_reg_map;
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 extern int get_primary_reg_base(struct pmc_dev *pmcdev);
+extern void pmc_core_get_low_power_modes(struct platform_device *pdev);
 
 int spt_core_init(struct pmc_dev *pmcdev);
 int cnp_core_init(struct pmc_dev *pmcdev);
diff --git a/drivers/platform/x86/intel/pmc/icl.c b/drivers/platform/x86/intel/pmc/icl.c
index a671d7e86431..8315e6c90efa 100644
--- a/drivers/platform/x86/intel/pmc/icl.c
+++ b/drivers/platform/x86/intel/pmc/icl.c
@@ -52,6 +52,14 @@ const struct pmc_reg_map icl_reg_map = {
 
 int icl_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
 	pmcdev->map = &icl_reg_map;
-	return get_primary_reg_base(pmcdev);
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
+	pmc_core_get_low_power_modes(pmcdev->pdev);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/mtl.c b/drivers/platform/x86/intel/pmc/mtl.c
index 48c7ec094af8..74f1f4c44812 100644
--- a/drivers/platform/x86/intel/pmc/mtl.c
+++ b/drivers/platform/x86/intel/pmc/mtl.c
@@ -151,6 +151,8 @@ int mtl_core_init(struct pmc_dev *pmcdev)
 
 	mtl_pmc_ssram_init(pmcdev);
 
+	pmc_core_get_low_power_modes(pmcdev->pdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
diff --git a/drivers/platform/x86/intel/pmc/spt.c b/drivers/platform/x86/intel/pmc/spt.c
index f34015692bb8..1f6bcd40ba76 100644
--- a/drivers/platform/x86/intel/pmc/spt.c
+++ b/drivers/platform/x86/intel/pmc/spt.c
@@ -136,6 +136,14 @@ const struct pmc_reg_map spt_reg_map = {
 
 int spt_core_init(struct pmc_dev *pmcdev)
 {
+	int ret;
+
 	pmcdev->map = &spt_reg_map;
-	return get_primary_reg_base(pmcdev);
+	ret = get_primary_reg_base(pmcdev);
+	if (ret)
+		return ret;
+
+	pmc_core_get_low_power_modes(pmcdev->pdev);
+
+	return ret;
 }
diff --git a/drivers/platform/x86/intel/pmc/tgl.c b/drivers/platform/x86/intel/pmc/tgl.c
index c69f2672fb92..05b7cc6f59a0 100644
--- a/drivers/platform/x86/intel/pmc/tgl.c
+++ b/drivers/platform/x86/intel/pmc/tgl.c
@@ -261,7 +261,9 @@ int tgl_core_init(struct pmc_dev *pmcdev)
 	if (ret)
 		return ret;
 
+	pmc_core_get_low_power_modes(pmcdev->pdev);
 	pmc_core_get_tgl_lpm_reqs(pmcdev->pdev);
+
 	/* Due to a hardware limitation, the GBE LTR blocks PC10
 	 * when a cable is attached. Tell the PMC to ignore it.
 	 */
-- 
2.34.1

