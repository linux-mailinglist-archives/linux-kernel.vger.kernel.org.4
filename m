Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF99692133
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjBJO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBJO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:56:22 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E16C7E0;
        Fri, 10 Feb 2023 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676040981; x=1707576981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yF1vTEf/Cj8uQR7zMwL8EK6cJrGK3YEQj9wTzr3teZY=;
  b=jMwb+tGZAL8NsfFwug+rpel8CS6Z/fq183wcwW9Q+bI4zV8qjnHydieQ
   VJmg1dxtO5dnqvX6226AkrbpLAUPqaAB0vDuI9OfjD+IQGxAV3VJG3B/k
   PxXj+m/9CPt4I+r1zIx2CB1Q+ZlvGFAcHAtSR4BIYNMFvd7quJk6lzzIz
   e6RtdrFkK438ldF1H1lKnEevW0CkEmmTBhDqX5odmrRnu0dJtn5YLQGzg
   ffDJvUylJtaM9ovTsnbIxTJ1dI2y2KdVPmSB/4Py5yPGr26GyhfkFesWW
   79VhunVPLAM1OlTK1S3TXU117GLDnON5Aq84U9e+A6bL+oY37AxA+fkby
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="357836316"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="357836316"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 06:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="668079982"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="668079982"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2023 06:56:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD30F1A6; Fri, 10 Feb 2023 16:56:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] pinctrl: at91: use devm_kasprintf() to avoid potential leaks (part 2)
Date:   Fri, 10 Feb 2023 16:56:52 +0200
Message-Id: <20230210145656.71838-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210145656.71838-1-andriy.shevchenko@linux.intel.com>
References: <20230210145656.71838-1-andriy.shevchenko@linux.intel.com>
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

Use devm_kasprintf() instead of kasprintf() to avoid any potential
leaks. At the moment drivers have no remove functionality hence
there is no need for fixes tag.

While at it, switch to use devm_kasprintf_strarray().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/pinctrl-at91.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 735c501e7a06..bb93d8bcfd08 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -18,6 +18,7 @@
 #include <linux/pm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 
 /* Since we request GPIOs from ourself */
 #include <linux/pinctrl/consumer.h>
@@ -1371,6 +1372,7 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
 
 static int at91_pinctrl_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct at91_pinctrl *info;
 	struct pinctrl_pin_desc *pdesc;
 	int ret, i, j, k;
@@ -1394,9 +1396,19 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0, k = 0; i < gpio_banks; i++) {
+		char **pin_names;
+
+		pin_names = devm_kasprintf_strarray(dev, "pio", MAX_NB_GPIO_PER_BANK);
+		if (!names)
+			return -ENOMEM;
+
 		for (j = 0; j < MAX_NB_GPIO_PER_BANK; j++, k++) {
+			char *pin_name = pin_names[j];
+
+			strreplace(pin_name, '-', i + 'A');
+
 			pdesc->number = k;
-			pdesc->name = kasprintf(GFP_KERNEL, "pio%c%d", i + 'A', j);
+			pdesc->name = pin_name;
 			pdesc++;
 		}
 	}
@@ -1797,7 +1809,8 @@ static const struct of_device_id at91_gpio_of_match[] = {
 
 static int at91_gpio_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct at91_gpio_chip *at91_chip = NULL;
 	struct gpio_chip *chip;
 	struct pinctrl_gpio_range *range;
@@ -1866,16 +1879,14 @@ static int at91_gpio_probe(struct platform_device *pdev)
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
+		strreplace('-', alias_idx + 'A');
 
 	chip->names = (const char *const *)names;
 
-- 
2.39.1

