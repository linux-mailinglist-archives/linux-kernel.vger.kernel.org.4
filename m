Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E94C697DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBONmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBONmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:42:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E7305F5;
        Wed, 15 Feb 2023 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676468527; x=1708004527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMKeJvWpmtoiaMn2I8gXdst5FiDonPYpqv3saTRG0Wc=;
  b=lo1xfOfqhB7+H4w8eTjdAbJkrPjHbrXTiwSFZCRD3EUOB8h34nWyq+Zf
   PLSToa9Iy9n0ANMEcvpkDQr0Mqsmw5u4AnXWSiziqRXj8bBeizMnZFLZ1
   aDtodphbNDIftNQdqPTEUubIPzHfoWoEpP6FwEEIx6aU7MEsOR4IJkJ9c
   zoqf03BEtLhHOkN9lVJNs4VbjXCkKrfpHNYIm+NEi1d1vOtWnuWGMHC/o
   lq0LJV9QBwDhinK0yT4LCgXJ2+nAaYuXAOiHvyO3IbiB7ZUKtaw9Kq7Aj
   pInbp+9ZNWyztUdmLf2F/29Dg5Ea7+VM7LtE5IzVE2q3iWRJPuEvzEPaU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="358849416"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="358849416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 05:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793502742"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="793502742"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Feb 2023 05:42:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 674A7252; Wed, 15 Feb 2023 15:42:44 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] pinctrl: at91: Use dev_err_probe() instead of custom messaging
Date:   Wed, 15 Feb 2023 15:42:41 +0200
Message-Id: <20230215134242.37618-5-andriy.shevchenko@linux.intel.com>
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

The custom message has no value except printing the error code,
the same does dev_err_probe(). Let's use the latter for the sake
of unification.

Note that some APIs already have messaging in them and some simply
do not require the current noise.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/pinctrl/pinctrl-at91.c | 64 +++++++++++-----------------------
 1 file changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 055a88b2dacc..08f88403affb 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1294,10 +1294,11 @@ static const struct of_device_id at91_pinctrl_of_match[] = {
 static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 				 struct at91_pinctrl *info)
 {
+	struct device *dev = &pdev->dev;
 	int ret = 0;
 	int i, j, ngpio_chips_enabled = 0;
 	uint32_t *tmp;
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = dev->of_node;
 	struct device_node *child;
 
 	if (!np)
@@ -1360,9 +1361,8 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 			continue;
 		ret = at91_pinctrl_parse_functions(child, info, i++);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to parse function\n");
 			of_node_put(child);
-			return ret;
+			return dev_err_probe(dev, ret, "failed to parse function\n");
 		}
 	}
 
@@ -1415,11 +1415,8 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 	info->pctl = devm_pinctrl_register(&pdev->dev, &at91_pinctrl_desc,
 					   info);
-
-	if (IS_ERR(info->pctl)) {
-		dev_err(&pdev->dev, "could not register AT91 pinctrl driver\n");
-		return PTR_ERR(info->pctl);
-	}
+	if (IS_ERR(info->pctl))
+		return dev_err_probe(dev, PTR_ERR(info->pctl), "could not register AT91 pinctrl driver\n");
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < gpio_banks; i++)
@@ -1820,39 +1817,28 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	char **names;
 
 	BUG_ON(alias_idx >= ARRAY_SIZE(gpio_chips));
-	if (gpio_chips[alias_idx]) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (gpio_chips[alias_idx])
+		return dev_err_probe(dev, -EBUSY, "%d slot is occupied.\n", alias_idx);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err;
-	}
+	if (irq < 0)
+		return irq;
 
 	at91_chip = devm_kzalloc(&pdev->dev, sizeof(*at91_chip), GFP_KERNEL);
-	if (!at91_chip) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!at91_chip)
+		return -ENOMEM;
 
 	at91_chip->regbase = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(at91_chip->regbase)) {
-		ret = PTR_ERR(at91_chip->regbase);
-		goto err;
-	}
+	if (IS_ERR(at91_chip->regbase))
+		return PTR_ERR(at91_chip->regbase);
 
 	at91_chip->ops = of_device_get_match_data(dev);
 	at91_chip->pioc_virq = irq;
 	at91_chip->pioc_idx = alias_idx;
 
 	at91_chip->clock = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(at91_chip->clock)) {
-		dev_err(&pdev->dev, "failed to get clock, ignoring.\n");
-		ret = PTR_ERR(at91_chip->clock);
-		goto err;
-	}
+	if (IS_ERR(at91_chip->clock))
+		return dev_err_probe(dev, PTR_ERR(at91_chip->clock), "failed to get clock, ignoring.\n");
 
 	at91_chip->chip = at91_gpio_template;
 	at91_chip->id = alias_idx;
@@ -1865,17 +1851,15 @@ static int at91_gpio_probe(struct platform_device *pdev)
 
 	if (!of_property_read_u32(np, "#gpio-lines", &ngpio)) {
 		if (ngpio >= MAX_NB_GPIO_PER_BANK)
-			pr_err("at91_gpio.%d, gpio-nb >= %d failback to %d\n",
-			       alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
+			dev_err(dev, "at91_gpio.%d, gpio-nb >= %d failback to %d\n",
+				alias_idx, MAX_NB_GPIO_PER_BANK, MAX_NB_GPIO_PER_BANK);
 		else
 			chip->ngpio = ngpio;
 	}
 
 	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
-	if (!names) {
-		ret = -ENOMEM;
-		goto err;
-	}
+	if (!names)
+		return -ENOMEM;
 
 	for (i = 0; i < chip->ngpio; i++)
 		strreplace(names[i], '-', alias_idx + 'A');
@@ -1892,11 +1876,11 @@ static int at91_gpio_probe(struct platform_device *pdev)
 
 	ret = at91_gpio_of_irq_setup(pdev, at91_chip);
 	if (ret)
-		goto gpiochip_add_err;
+		return ret;
 
 	ret = gpiochip_add_data(chip, at91_chip);
 	if (ret)
-		goto gpiochip_add_err;
+		return ret;
 
 	gpio_chips[alias_idx] = at91_chip;
 	platform_set_drvdata(pdev, at91_chip);
@@ -1905,12 +1889,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "at address %p\n", at91_chip->regbase);
 
 	return 0;
-
-gpiochip_add_err:
-err:
-	dev_err(&pdev->dev, "Failure %i for GPIO %i\n", ret, alias_idx);
-
-	return ret;
 }
 
 static const struct dev_pm_ops at91_gpio_pm_ops = {
-- 
2.39.1

