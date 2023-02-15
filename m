Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B08697DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjBONmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBONmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:42:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD82434C37;
        Wed, 15 Feb 2023 05:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468530; x=1708004530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72poG9BNyJWgNcO4lHVwaSx+WheBWsmEuGzRhm0Pokw=;
  b=kfilNg2aA4iWyMBK/GdaraISK50PkTKLeSlFr+5VbO01wsADhUPE+FVp
   v2cNYQhxXgkV+ViMvIWlswKvU0p2V4Es0MnFlnSeZqzkaP/5j6w7C3F5/
   I6cFVl1CeiJ1X9J5kWmCtgfysuRgt5jgP01ASgRT5AGBQyoBWvRJNqBAA
   rdpP77PDRz/XGZYZPOqOrp9UDuIbW+q6ntDPyAFuscEIQGzDNqMP+gQkC
   bdxvfxoOIeouUbSnUmaeJTIThFiHso2EW51Ca8tVTBSHFRB1HO/joB/fn
   4TO/NPtwXyrkBOiZpONELlnf7wOl742zcZg4MyhTR63DviFnVv2We7u6z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="332734641"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="332734641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="812450051"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="812450051"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2023 05:42:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6F212269; Wed, 15 Feb 2023 15:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/5] pinctrl: at91: Utilise temporary variable for struct device
Date:   Wed, 15 Feb 2023 15:42:42 +0200
Message-Id: <20230215134242.37618-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
References: <20230215134242.37618-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 60 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 08f88403affb..de48a8e0f85f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1304,7 +1304,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	if (!np)
 		return -ENODEV;
 
-	info->dev = &pdev->dev;
+	info->dev = dev;
 	info->ops = of_device_get_match_data(dev);
 	at91_pinctrl_child_count(info, np);
 
@@ -1324,35 +1324,31 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
-	dev_dbg(&pdev->dev, "nmux = %d\n", info->nmux);
+	dev_dbg(dev, "nmux = %d\n", info->nmux);
 
-	dev_dbg(&pdev->dev, "mux-mask\n");
+	dev_dbg(dev, "mux-mask\n");
 	tmp = info->mux_mask;
 	for (i = 0; i < gpio_banks; i++) {
 		for (j = 0; j < info->nmux; j++, tmp++) {
-			dev_dbg(&pdev->dev, "%d:%d\t0x%x\n", i, j, tmp[0]);
+			dev_dbg(dev, "%d:%d\t0x%x\n", i, j, tmp[0]);
 		}
 	}
 
-	dev_dbg(&pdev->dev, "nfunctions = %d\n", info->nfunctions);
-	dev_dbg(&pdev->dev, "ngroups = %d\n", info->ngroups);
-	info->functions = devm_kcalloc(&pdev->dev,
-					info->nfunctions,
-					sizeof(struct at91_pmx_func),
-					GFP_KERNEL);
+	dev_dbg(dev, "nfunctions = %d\n", info->nfunctions);
+	dev_dbg(dev, "ngroups = %d\n", info->ngroups);
+	info->functions = devm_kcalloc(dev, info->nfunctions, sizeof(*info->functions),
+				       GFP_KERNEL);
 	if (!info->functions)
 		return -ENOMEM;
 
-	info->groups = devm_kcalloc(&pdev->dev,
-					info->ngroups,
-					sizeof(struct at91_pin_group),
-					GFP_KERNEL);
+	info->groups = devm_kcalloc(dev, info->ngroups, sizeof(*info->groups),
+				    GFP_KERNEL);
 	if (!info->groups)
 		return -ENOMEM;
 
-	dev_dbg(&pdev->dev, "nbanks = %d\n", gpio_banks);
-	dev_dbg(&pdev->dev, "nfunctions = %d\n", info->nfunctions);
-	dev_dbg(&pdev->dev, "ngroups = %d\n", info->ngroups);
+	dev_dbg(dev, "nbanks = %d\n", gpio_banks);
+	dev_dbg(dev, "nfunctions = %d\n", info->nfunctions);
+	dev_dbg(dev, "ngroups = %d\n", info->ngroups);
 
 	i = 0;
 
@@ -1376,7 +1372,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pdesc;
 	int ret, i, j, k;
 
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -1384,13 +1380,10 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	at91_pinctrl_desc.name = dev_name(&pdev->dev);
+	at91_pinctrl_desc.name = dev_name(dev);
 	at91_pinctrl_desc.npins = gpio_banks * MAX_NB_GPIO_PER_BANK;
 	at91_pinctrl_desc.pins = pdesc =
-		devm_kcalloc(&pdev->dev,
-			     at91_pinctrl_desc.npins, sizeof(*pdesc),
-			     GFP_KERNEL);
-
+		devm_kcalloc(dev, at91_pinctrl_desc.npins, sizeof(*pdesc), GFP_KERNEL);
 	if (!at91_pinctrl_desc.pins)
 		return -ENOMEM;
 
@@ -1413,8 +1406,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, info);
-	info->pctl = devm_pinctrl_register(&pdev->dev, &at91_pinctrl_desc,
-					   info);
+	info->pctl = devm_pinctrl_register(dev, &at91_pinctrl_desc, info);
 	if (IS_ERR(info->pctl))
 		return dev_err_probe(dev, PTR_ERR(info->pctl), "could not register AT91 pinctrl driver\n");
 
@@ -1423,7 +1415,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 		if (gpio_chips[i])
 			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
 
-	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
+	dev_info(dev, "initialized AT91 pinctrl driver\n");
 
 	return 0;
 }
@@ -1714,6 +1706,7 @@ static void gpio_irq_handler(struct irq_desc *desc)
 static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 				  struct at91_gpio_chip *at91_gpio)
 {
+	struct device		*dev = &pdev->dev;
 	struct gpio_chip	*gpiochip_prev = NULL;
 	struct at91_gpio_chip   *prev = NULL;
 	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
@@ -1721,8 +1714,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	struct gpio_irq_chip	*girq;
 	int i;
 
-	gpio_irqchip = devm_kzalloc(&pdev->dev, sizeof(*gpio_irqchip),
-				    GFP_KERNEL);
+	gpio_irqchip = devm_kzalloc(dev, sizeof(*gpio_irqchip), GFP_KERNEL);
 	if (!gpio_irqchip)
 		return -ENOMEM;
 
@@ -1758,7 +1750,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	if (!gpiochip_prev) {
 		girq->parent_handler = gpio_irq_handler;
 		girq->num_parents = 1;
-		girq->parents = devm_kcalloc(&pdev->dev, 1,
+		girq->parents = devm_kcalloc(dev, girq->num_parents,
 					     sizeof(*girq->parents),
 					     GFP_KERNEL);
 		if (!girq->parents)
@@ -1824,7 +1816,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	at91_chip = devm_kzalloc(&pdev->dev, sizeof(*at91_chip), GFP_KERNEL);
+	at91_chip = devm_kzalloc(dev, sizeof(*at91_chip), GFP_KERNEL);
 	if (!at91_chip)
 		return -ENOMEM;
 
@@ -1836,7 +1828,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
 
-	at91_chip->clock = devm_clk_get_enabled(&pdev->dev, NULL);
+	at91_chip->clock = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(at91_chip->clock))
 		return dev_err_probe(dev, PTR_ERR(at91_chip->clock), "failed to get clock, ignoring.\n");
 
@@ -1844,8 +1836,8 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	at91_chip->id = alias_idx;
 
 	chip = &at91_chip->chip;
-	chip->label = dev_name(&pdev->dev);
-	chip->parent = &pdev->dev;
+	chip->label = dev_name(dev);
+	chip->parent = dev;
 	chip->owner = THIS_MODULE;
 	chip->base = alias_idx * MAX_NB_GPIO_PER_BANK;
 
@@ -1886,7 +1878,7 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, at91_chip);
 	gpio_banks = max(gpio_banks, alias_idx + 1);
 
-	dev_info(&pdev->dev, "at address %p\n", at91_chip->regbase);
+	dev_info(dev, "at address %p\n", at91_chip->regbase);
 
 	return 0;
 }
-- 
2.39.1

