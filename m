Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203C2682E61
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjAaNtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjAaNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:49:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960254B483;
        Tue, 31 Jan 2023 05:49:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 429FFB81CDF;
        Tue, 31 Jan 2023 13:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D826CC4339B;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172980;
        bh=2a2lkU6K2uCveC71ivewBVMghpO7dbUOieeM5PNFeK0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=UJ27/uL/1ZBdH5Mqb5dOkVjo9goPIMc2eIY3HzDvbHDt1OtdwdIdOfwxgFoFAFCML
         uam8JgupPWFGTOfIPsTFZmUapQR9OZxAbaLG1QbeYWmVK7AI5FiSlIDqGza2HO/iUH
         G433WFLpod+UN0FpKctwiytA4VrWQQIN7RMYWo7om6p2m8UQTS/6fa2aYc2zjCDbsH
         1XLEzeDusOOqUpRCZOKvGLYLflt3GUIOcsFVZq18YF92siLjn2NZukr4qFD/mpzihR
         9x7pTDQZxlozu5aDeiMu3+g5oXFnt9hukwAzdDJJ7MTj8ddYElEPzGs0l8Q/WG43+V
         QYTqgL6P3r6bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C4E43C64EC3;
        Tue, 31 Jan 2023 13:49:40 +0000 (UTC)
From:   Niall Leonard via B4 Submission Endpoint 
        <devnull+nl250060.ncr.com@kernel.org>
Date:   Tue, 31 Jan 2023 13:49:38 +0000
Subject: [PATCH v2 2/2] gpio: mmio: Use new flag BGPIOF_NO_INPUT.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-gpio-mmio-fix-v2-2-38397aace340@ncr.com>
References: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
In-Reply-To: <20230126-gpio-mmio-fix-v2-0-38397aace340@ncr.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Niall Leonard <nl250060@ncr.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3171; i=nl250060@ncr.com;
 h=from:subject:message-id; bh=qw+ukSOOr1LL8jakS9qqqS7Ifx1mSYww3yijW1VYn/c=; 
 =?utf-8?q?b=3DowEBbQKS/ZANAwAKAVGiIrYFD2P/AcsmYgBj2RxzG8Rs4mvsqSBm+6z29boec?=
 =?utf-8?q?XRRXeqa8Uuy4anQ_ehqbzcSJAjMEAAEKAB0WIQSha1EPjh6hUqdtwZNRoiK2BQ9j/?=
 =?utf-8?q?wUCY9kccwAKCRBRoiK2BQ9j/9FKEA_DNju1HJb+AUeRe9LgvDDLjnqhfbAV0+NsnU?=
 =?utf-8?q?co9AgeNNsZ87CaMOIThcNTLH6kLkwxeeMb7XuWieLMe_x6CDnp9Gj2PUsvqJZBSuN?=
 =?utf-8?q?w9oX2DnxytOxXB8je/3fzhDvDTUAo4caKnXA7pna8rQbeY7NxbsItkBqy_vpRYD3L?=
 =?utf-8?q?oKFXsIrVPsvUbn7/wkW4flcjhuY5AcwCGHIzOUsiAxKqYRVhAl8oX+g7PT6xH0BeL?=
 =?utf-8?q?g6xX9x_Fldqj93K4zJXEFypyYcrwVzzWEpHE3sWPPazVYBv+0D2TJIFWaVIwgCDln?=
 =?utf-8?q?oNgbvCB7grUaeskAmrCS_Gr6val+X4RZmUcv7iQua+13bzeLWeZ9Q1yYffKpdWBB7?=
 =?utf-8?q?vJnYQIDHqQ3nkNC6Azgx8msVcSPdTDsF8Q_EvqPLSB8RvkQ73JKHwfx0R/ROdSfqN?=
 =?utf-8?q?GS9Znzbr9Qh4pLvq4OLz1F8Ao1dLlQ4XTNTBNAczNk+MOw3x_8e2LAmLv0x6CYMnP?=
 =?utf-8?q?HC3VWZ3KKOepEKneoLJ3ec0PykAkMt1GVhAskcopvCUXaWKik2dogK0nZd0aAh_RX?=
 =?utf-8?q?1R42naQaNEK0fE/tw6iZLlJz0t/UU1ZiMb87edPInPTW+wYjSsmRij1JGaoPNEskw?=
 =?utf-8?q?jZ1qgNRWcqm?=
 5VdwCAqUsIc/ocBhTdEjer4JBiYr01gvxrJginHJNWG8OcrfN+IIfg6UPiAw==
X-Developer-Key: i=nl250060@ncr.com; a=openpgp;
 fpr=A16B510F8E1EA152A76DC19351A222B6050F63FF
X-Endpoint-Received: by B4 Submission Endpoint for nl250060@ncr.com/default with auth_id=26
X-Original-From: Niall Leonard <nl250060@ncr.com>
Reply-To: <nl250060@ncr.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niall Leonard <nl250060@ncr.com>

Add new flag BGPIOF_NO_INPUT to header file.
Use the existing shadow data register 'bgpio_data' to allow
the last written value to be returned by the read operation
when BGPIOF_NO_INPUT flag is set.
Ensure this change only applies to the specific binding "wd,mbl-gpio".

Signed-off-by: Niall Leonard <nl250060@ncr.com>
---
 drivers/gpio/gpio-mmio.c    | 24 +++++++++++++++++++++---
 include/linux/gpio/driver.h |  1 +
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index d9dff3dc92ae..9939fdbf6345 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -164,6 +164,11 @@ static int bgpio_get_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	return 0;
 }
 
+static int bgpio_get_shadow(struct gpio_chip *gc, unsigned int gpio)
+{
+	return !!(gc->bgpio_data & bgpio_line2mask(gc, gpio));
+}
+
 static int bgpio_get(struct gpio_chip *gc, unsigned int gpio)
 {
 	return !!(gc->read_reg(gc->reg_dat) & bgpio_line2mask(gc, gpio));
@@ -526,7 +531,10 @@ static int bgpio_setup_io(struct gpio_chip *gc,
 		 * reading each line individually in that fringe case.
 		 */
 	} else {
-		gc->get = bgpio_get;
+		if (flags & BGPIOF_NO_INPUT)
+			gc->get = bgpio_get_shadow;
+		else
+			gc->get = bgpio_get;
 		if (gc->be_bits)
 			gc->get_multiple = bgpio_get_multiple_be;
 		else
@@ -630,7 +638,11 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 	if (ret)
 		return ret;
 
-	gc->bgpio_data = gc->read_reg(gc->reg_dat);
+	if (flags & BGPIOF_NO_INPUT)
+		gc->bgpio_data = 0;
+	else
+		gc->bgpio_data = gc->read_reg(gc->reg_dat);
+
 	if (gc->set == bgpio_set_set &&
 			!(flags & BGPIOF_UNREADABLE_REG_SET))
 		gc->bgpio_data = gc->read_reg(gc->reg_set);
@@ -694,8 +706,9 @@ static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
 					  unsigned long *flags)
 {
 	struct bgpio_pdata *pdata;
+	const struct of_device_id *of_id;
 
-	if (!of_match_device(bgpio_of_match, &pdev->dev))
+	if (!(of_id = of_match_device(bgpio_of_match, &pdev->dev)))
 		return NULL;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
@@ -711,6 +724,11 @@ static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
 	if (of_property_read_bool(pdev->dev.of_node, "no-output"))
 		*flags |= BGPIOF_NO_OUTPUT;
 
+	if (!strcmp(of_id->compatible, "wd,mbl-gpio")) {
+		if (of_property_read_bool(pdev->dev.of_node, "no-input"))
+			*flags |= BGPIOF_NO_INPUT;
+	}
+
 	return pdata;
 }
 #else
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 44783fc16125..e8e57310e3b8 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -682,6 +682,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 #define BGPIOF_READ_OUTPUT_REG_SET	BIT(4) /* reg_set stores output value */
 #define BGPIOF_NO_OUTPUT		BIT(5) /* only input */
 #define BGPIOF_NO_SET_ON_INPUT		BIT(6)
+#define BGPIOF_NO_INPUT				BIT(7)	/* only output */
 
 int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 		     irq_hw_number_t hwirq);

-- 
2.34.1

