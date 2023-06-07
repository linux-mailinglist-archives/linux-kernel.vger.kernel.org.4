Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9AF72732E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjFGXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjFGXjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:39:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A292212B;
        Wed,  7 Jun 2023 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686181131; x=1717717131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KlCxXW3cettU4hkVoOWitZPtIUn44RhFROQOzqvvN6g=;
  b=Z7CN/rA7g2YUusFukq0iSSbPUrX0o1v1p//tMd+CLKJCiDSxX5ly1+q0
   pm6qx3bcoyr9nO22Xa1e1dJBMU3TkOEq5/UJKysbXM7wSeV10b4F2XmnD
   sJAqiladYTukjGeNi9jjXfqthtNcFtZeYYOvZ9fGVIyhwfiukRwOZIJpZ
   mqGlpyrGUmM0q91o7J3NuCKw25RyqMc3QPECYDU4HFobdE4OACTXjoH9O
   XR9ddY4EO7tP7SuvdeHI2d1L9KM6wWYrlV7i3CxXd4IGqW3t6fkpWMVHz
   HQ07AZ1UvuaFpByCzuImJlSgdFLnTESUavZqnYTj3kpWHFr1U9Vh6lyLl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="354631544"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="354631544"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 16:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739461201"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; 
   d="scan'208";a="739461201"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 16:38:50 -0700
Received: from debox1-desk4.intel.com (unknown [10.251.3.221])
        by linux.intel.com (Postfix) with ESMTP id 159CB580B54;
        Wed,  7 Jun 2023 16:38:50 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     david.e.box@linux.intel.com, markgross@kernel.org,
        hdegoede@redhat.com, irenic.rajneesh@gmail.com,
        ilpo.jarvinen@linux.intel.com, xi.pardee@intel.com,
        rajvi.jingar@linux.intel.com
Subject: [PATCH V2 1/2] platform/x86/intel/pmc: Add resume callback
Date:   Wed,  7 Jun 2023 16:38:48 -0700
Message-Id: <20230607233849.239047-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Add a resume callback to perform platform specific functions during resume
from suspend.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Change resume_fixup to just resume and use it a a replacement for
     the regular resume flow (now called pmc_core_resume_common) if it
     exist. Suggested by Ilpo.

 drivers/platform/x86/intel/pmc/core.c | 14 ++++++++++++--
 drivers/platform/x86/intel/pmc/core.h |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
index da6e7206d38b..bb2f11251f73 100644
--- a/drivers/platform/x86/intel/pmc/core.c
+++ b/drivers/platform/x86/intel/pmc/core.c
@@ -1223,11 +1223,11 @@ static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
 	return false;
 }
 
-static __maybe_unused int pmc_core_resume(struct device *dev)
+int pmc_core_resume_common(struct pmc_dev *pmcdev)
 {
-	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
 	const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
 	int offset = pmcdev->map->lpm_status_offset;
+	struct device *dev = &pmcdev->pdev->dev;
 
 	/* Check if the syspend used S0ix */
 	if (pm_suspend_via_firmware())
@@ -1257,6 +1257,16 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
 	return 0;
 }
 
+static __maybe_unused int pmc_core_resume(struct device *dev)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+
+	if (pmcdev->resume)
+		return pmcdev->resume(pmcdev);
+
+	return pmc_core_resume_common(pmcdev);
+}
+
 static const struct dev_pm_ops pmc_core_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
 };
diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 9ca9b9746719..7c95586e742b 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -327,6 +327,7 @@ struct pmc_reg_map {
  * @lpm_en_modes:	Array of enabled modes from lowest to highest priority
  * @lpm_req_regs:	List of substate requirements
  * @core_configure:	Function pointer to configure the platform
+ * @resume:		Function to perform platform specific resume
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -345,6 +346,7 @@ struct pmc_dev {
 	int lpm_en_modes[LPM_MAX_NUM_MODES];
 	u32 *lpm_req_regs;
 	void (*core_configure)(struct pmc_dev *pmcdev);
+	int (*resume)(struct pmc_dev *pmcdev);
 };
 
 extern const struct pmc_bit_map msr_map[];
@@ -398,6 +400,7 @@ extern const struct pmc_reg_map mtl_reg_map;
 extern void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev);
 extern int pmc_core_send_ltr_ignore(struct pmc_dev *pmcdev, u32 value);
 
+int pmc_core_resume_common(struct pmc_dev *pmcdev);
 void spt_core_init(struct pmc_dev *pmcdev);
 void cnp_core_init(struct pmc_dev *pmcdev);
 void icl_core_init(struct pmc_dev *pmcdev);

base-commit: 86f67fe2db439867f9476c9b78ea3ebd4a06a123
-- 
2.34.1

