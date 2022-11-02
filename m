Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA861662B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiKBP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiKBP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:29:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2A1D672;
        Wed,  2 Nov 2022 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667402937; x=1698938937;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e489D8kifr+m/racweh+WkS14YJhuJ+dmY25HGLU1B8=;
  b=a3NoB4JPS6pOz+bhRc1vdnJ8pdhvfnNj5FVNJlojRR7dBPXGSHA+wcH7
   NxumtBRisBFr0EY0cuCpJsPGKRPHOy0pKgJfs5F7vu+BTFfxXpEWQRFVc
   67D6eLjIBcR37C5nRThBYd1nSzKzfdLTUL3TD22JVBG030RJOpmpMdhQT
   rl8oyLWP8/PnpujhSPeIaFSWfhROqs7/FXXqeqicdcnjXahC0VJMSP9QP
   zCkTVGpg4HsL/SzeuD4tigZ590PxChuK0BBe0sbM5Q/M8YFd3UN62Kld2
   Kp8sh7OXVYRAMSXiKFXx19fubi3k/qbhfQj4OHVCwSRVHXnZhiSYgB1oc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371532207"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371532207"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634303822"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="634303822"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2022 08:28:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B71CAF7; Wed,  2 Nov 2022 17:29:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] pinctrl: intel: Use temporary variable for struct device
Date:   Wed,  2 Nov 2022 17:29:14 +0200
Message-Id: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index fe5bf2184cbf..e15629348cb5 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1522,14 +1522,15 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 int intel_pinctrl_probe(struct platform_device *pdev,
 			const struct intel_pinctrl_soc_data *soc_data)
 {
+	struct device *dev = &pdev->dev;
 	struct intel_pinctrl *pctrl;
 	int i, ret, irq;
 
-	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
+	pctrl = devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
 	if (!pctrl)
 		return -ENOMEM;
 
-	pctrl->dev = &pdev->dev;
+	pctrl->dev = dev;
 	pctrl->soc = soc_data;
 	raw_spin_lock_init(&pctrl->lock);
 
@@ -1538,8 +1539,8 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 	 * to the registers.
 	 */
 	pctrl->ncommunities = pctrl->soc->ncommunities;
-	pctrl->communities = devm_kcalloc(&pdev->dev, pctrl->ncommunities,
-				  sizeof(*pctrl->communities), GFP_KERNEL);
+	pctrl->communities = devm_kcalloc(dev, pctrl->ncommunities,
+					  sizeof(*pctrl->communities), GFP_KERNEL);
 	if (!pctrl->communities)
 		return -ENOMEM;
 
@@ -1603,7 +1604,7 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 			offset = (value & CAPLIST_NEXT_MASK) >> CAPLIST_NEXT_SHIFT;
 		} while (offset);
 
-		dev_dbg(&pdev->dev, "Community%d features: %#08x\n", i, community->features);
+		dev_dbg(dev, "Community%d features: %#08x\n", i, community->features);
 
 		/* Read offset of the pad configuration registers */
 		offset = readl(regs + PADBAR);
@@ -1632,14 +1633,13 @@ int intel_pinctrl_probe(struct platform_device *pdev,
 		return ret;
 
 	pctrl->pctldesc = intel_pinctrl_desc;
-	pctrl->pctldesc.name = dev_name(&pdev->dev);
+	pctrl->pctldesc.name = dev_name(dev);
 	pctrl->pctldesc.pins = pctrl->soc->pins;
 	pctrl->pctldesc.npins = pctrl->soc->npins;
 
-	pctrl->pctldev = devm_pinctrl_register(&pdev->dev, &pctrl->pctldesc,
-					       pctrl);
+	pctrl->pctldev = devm_pinctrl_register(dev, &pctrl->pctldesc, pctrl);
 	if (IS_ERR(pctrl->pctldev)) {
-		dev_err(&pdev->dev, "failed to register pinctrl driver\n");
+		dev_err(dev, "failed to register pinctrl driver\n");
 		return PTR_ERR(pctrl->pctldev);
 	}
 
@@ -1681,10 +1681,11 @@ const struct intel_pinctrl_soc_data *intel_pinctrl_get_soc_data(struct platform_
 {
 	const struct intel_pinctrl_soc_data * const *table;
 	const struct intel_pinctrl_soc_data *data = NULL;
+	struct device *dev = &pdev->dev;
 
-	table = device_get_match_data(&pdev->dev);
+	table = device_get_match_data(dev);
 	if (table) {
-		struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+		struct acpi_device *adev = ACPI_COMPANION(dev);
 		unsigned int i;
 
 		for (i = 0; table[i]; i++) {
-- 
2.35.1

