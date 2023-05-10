Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866726FE588
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjEJUue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjEJUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30B7A8A;
        Wed, 10 May 2023 13:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 429E861380;
        Wed, 10 May 2023 20:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BDDC433D2;
        Wed, 10 May 2023 20:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751782;
        bh=xl6G8yc6vNmG4q6vayBP1pskVK69TK32jZsANQIhq2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=U340RIukB7baPgt9agjTBeVSf0I2JkNzxfhDFLP7oYxGG+7zcoMBSM3CGS6pj5Dn9
         kmzyldnBt9eR7fM5SAXG/V3Hk6HlyJc4+f9c3tJQiPD/VLwEVVgi65azR1EfNYzF2R
         h2uIzZ69NsoFtAKimR86GNySntTgsn6cHJdsn8ArSyme4g/g4SEumynP3Riy92z0ke
         euIPW0i+umh2oYIQ+qYZpDdXd2NXWPQYMO8oHcb95eBWUJ4GBN6mc8KKG2GzuMli5U
         YorjC1PNWJo7t0NY/UxbLhBzqfxIU0NDITIy6E0qkzkYfgD4TCZuHwTWcuDyPLzZd2
         VLWBe9d04evRg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 1/9] pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
Date:   Wed, 10 May 2023 16:49:18 -0400
Message-Id: <20230510204926.104747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f494c1913cbb34b9e2078b7b045c87c1ca6df791 ]

Use devm_kasprintf() instead of kasprintf() to avoid any potential
leaks. At the moment drivers have no remove functionality hence
there is no need for fixes tag.

While at it, switch to use devm_kasprintf_strarray().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230215134242.37618-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index c405296e49896..2a081b13846e2 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
@@ -1364,6 +1365,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 
 static int at91_pinctrl_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct at91_pinctrl *info;
 	struct pinctrl_pin_desc *pdesc;
 	int ret, i, j, k, ngpio_chips_enabled = 0;
@@ -1404,9 +1406,19 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0, k = 0; i < gpio_banks; i++) {
+		char **names;
+
+		names = devm_kasprintf_strarray(dev, "pio", MAX_NB_GPIO_PER_BANK);
+		if (!names)
+			return -ENOMEM;
+
 		for (j = 0; j < MAX_NB_GPIO_PER_BANK; j++, k++) {
+			char *name = names[j];
+
+			strreplace(name, '-', i + 'A');
+
 			pdesc->number = k;
-			pdesc->name = kasprintf(GFP_KERNEL, "pio%c%d", i + 'A', j);
+			pdesc->name = name;
 			pdesc++;
 		}
 	}
@@ -1807,7 +1819,8 @@ static const struct of_device_id at91_gpio_of_match[] = {
 
 static int at91_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct at91_gpio_chip *at91_chip = NULL;
 	struct gpio_chip *chip;
 	struct pinctrl_gpio_range *range;
@@ -1876,16 +1889,14 @@ static int at91_gpio_probe(struct platform_device *pdev)
 			chip->ngpio = ngpio;
 	}
 
-	names = devm_kcalloc(&pdev->dev, chip->ngpio, sizeof(char *),
-			     GFP_KERNEL);
-
+	names = devm_kasprintf_strarray(dev, "pio", chip->ngpio);
 	if (!names) {
 		ret = -ENOMEM;
 		goto clk_enable_err;
 	}
 
 	for (i = 0; i < chip->ngpio; i++)
-		names[i] = devm_kasprintf(&pdev->dev, GFP_KERNEL, "pio%c%d", alias_idx + 'A', i);
+		strreplace(names[i], '-', alias_idx + 'A');
 
 	chip->names = (const char *const *)names;
 
-- 
2.39.2

