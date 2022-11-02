Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A253261662E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKBP31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiKBP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:29:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF317E3A;
        Wed,  2 Nov 2022 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667402941; x=1698938941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v0fHpdGAbu0arnH6xgJnxwue3Lb0+yaD3o4o1bu4gMc=;
  b=aqstbC/TO/2bBEPXECsE3XvCtdR5t9ana0+pUJkSe/hxv5tqEazZm5xQ
   j6wcMpq0TjD6zouPf3gI82IZ2sKZm7k7Gpe3tMhPJVy9Urh9Be0OxM+wf
   GZdxYngOprEtSS/Mws6kydhZUpqTQjDUu2v+QFCbqVdSuKXl9UrFz7L7a
   VkCQbaLnTaTTUDb50fRPZBY3TLe+Sq8BCFT0x2u7HacT5MSaTMZNl/H36
   irwCzdSf9GtG1+M83v212ngjdRVCTbhm02VFByHn78zv9yjIcHSxZrNgB
   GFKfZveTBNE9FPR/PbbuINlfBcfV+w41v5xDGSMnXN81+to/PAxkhlK5L
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371532208"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371532208"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634303823"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="634303823"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 02 Nov 2022 08:28:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C1D6AB7; Wed,  2 Nov 2022 17:29:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] pinctrl: merrifield: Use temporary variable for struct device
Date:   Wed,  2 Nov 2022 17:29:15 +0200
Message-Id: <20221102152915.22995-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
References: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-merrifield.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-merrifield.c b/drivers/pinctrl/intel/pinctrl-merrifield.c
index 527957ea35b7..c0845bb1e9e3 100644
--- a/drivers/pinctrl/intel/pinctrl-merrifield.c
+++ b/drivers/pinctrl/intel/pinctrl-merrifield.c
@@ -897,17 +897,18 @@ static const struct pinctrl_desc mrfld_pinctrl_desc = {
 
 static int mrfld_pinctrl_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct mrfld_family *families;
 	struct mrfld_pinctrl *mp;
 	void __iomem *regs;
 	size_t nfamilies;
 	unsigned int i;
 
-	mp = devm_kzalloc(&pdev->dev, sizeof(*mp), GFP_KERNEL);
+	mp = devm_kzalloc(dev, sizeof(*mp), GFP_KERNEL);
 	if (!mp)
 		return -ENOMEM;
 
-	mp->dev = &pdev->dev;
+	mp->dev = dev;
 	raw_spin_lock_init(&mp->lock);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
@@ -919,9 +920,7 @@ static int mrfld_pinctrl_probe(struct platform_device *pdev)
 	 * to the registers.
 	 */
 	nfamilies = ARRAY_SIZE(mrfld_families),
-	families = devm_kmemdup(&pdev->dev, mrfld_families,
-					    sizeof(mrfld_families),
-					    GFP_KERNEL);
+	families = devm_kmemdup(dev, mrfld_families, sizeof(mrfld_families), GFP_KERNEL);
 	if (!families)
 		return -ENOMEM;
 
@@ -939,13 +938,13 @@ static int mrfld_pinctrl_probe(struct platform_device *pdev)
 	mp->groups = mrfld_groups;
 	mp->ngroups = ARRAY_SIZE(mrfld_groups);
 	mp->pctldesc = mrfld_pinctrl_desc;
-	mp->pctldesc.name = dev_name(&pdev->dev);
+	mp->pctldesc.name = dev_name(dev);
 	mp->pctldesc.pins = mrfld_pins;
 	mp->pctldesc.npins = ARRAY_SIZE(mrfld_pins);
 
-	mp->pctldev = devm_pinctrl_register(&pdev->dev, &mp->pctldesc, mp);
+	mp->pctldev = devm_pinctrl_register(dev, &mp->pctldesc, mp);
 	if (IS_ERR(mp->pctldev)) {
-		dev_err(&pdev->dev, "failed to register pinctrl driver\n");
+		dev_err(dev, "failed to register pinctrl driver\n");
 		return PTR_ERR(mp->pctldev);
 	}
 
-- 
2.35.1

