Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1668A705557
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjEPRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjEPRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:48:14 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB087DBF;
        Tue, 16 May 2023 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=WuwLzoPe50r5og7BLUtbSp+J5xPioNFelvYHJR4Aa7I=; b=wKQxH/2lssHzfY4uos4gmmjwg1
        ACeyMFeHTS0av97awKhfo5zX2D4p59o2g0cOyrOfKe+fYWYb995HUokiBGH9dRKs5kiE2LTgmY2Tj
        8pCn9oIkxfJHSbi00djouGPJf5mnCliZLuz+l8J2jhjisXEK+8WpNb39LglCOhvZvXv8cWT71VXv1
        0j4mBHUGt9C5/yOywEt2UOI1KcJHX743EF3zyYY7qjzeOWPEGWXsJeaePbsWBXSD3L5LVYRDIXuLv
        ZbMcly5AAetLvCqEplfm9gMhH0LuSrk+VBAX8jUsHenrZQCJpb5xTVWmTkSHLvSFVgeQzWNpBnkgO
        D/UC1hzQ==;
Received: from [2001:4d48:ad59:1403::16a3] (helo=earth.li)
        by the.earth.li with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1pyylq-00GMrn-OZ; Tue, 16 May 2023 18:47:34 +0100
Date:   Tue, 16 May 2023 18:47:29 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/5] pinctrl: axp209: Add support for GPIO3 on the AXP209
Message-ID: <dde40307f0ebc23b9841c32e702b481ab5193dc4.1684258957.git.noodles@earth.li>
References: <cover.1683719613.git.noodles@earth.li>
 <cover.1684258957.git.noodles@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1684258957.git.noodles@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP209 device has a 4th GPIO which has a slightly different register
setup, where the control + status bits are held in a single register
rather than sharing AXP20X_GPIO20_SS with GPIOs 0-2.

Signed-off-by: Jonathan McDowell <noodles@earth.li>
---
 drivers/pinctrl/pinctrl-axp209.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 0bc1b381a2b8..b3ba25435c34 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -30,6 +30,11 @@
 #define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
 #define AXP20X_GPIO_FUNCTION_INPUT	2
 
+#define AXP20X_GPIO3_FUNCTIONS		GENMASK(2, 1)
+#define AXP20X_GPIO3_FUNCTION_OUT_LOW	0
+#define AXP20X_GPIO3_FUNCTION_OUT_HIGH	2
+#define AXP20X_GPIO3_FUNCTION_INPUT	4
+
 #define AXP20X_FUNC_GPIO_OUT		0
 #define AXP20X_FUNC_GPIO_IN		1
 #define AXP20X_FUNC_LDO			2
@@ -73,6 +78,7 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
 	PINCTRL_PIN(0, "GPIO0"),
 	PINCTRL_PIN(1, "GPIO1"),
 	PINCTRL_PIN(2, "GPIO2"),
+	PINCTRL_PIN(3, "GPIO3"),
 };
 
 static const struct pinctrl_pin_desc axp22x_pins[] = {
@@ -130,6 +136,14 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	unsigned int val;
 	int ret;
 
+	/* AXP209 has GPIO3 status sharing the settings register */
+	if (offset == 3) {
+		ret = regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val);
+		if (ret)
+			return ret;
+		return !!(val & BIT(0));
+	}
+
 	ret = regmap_read(pctl->regmap, AXP20X_GPIO20_SS, &val);
 	if (ret)
 		return ret;
@@ -144,6 +158,17 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int val;
 	int reg, ret;
 
+	/* AXP209 GPIO3 settings have a different layout */
+	if (offset == 3) {
+		ret = regmap_read(pctl->regmap, AXP20X_GPIO3_CTRL, &val);
+		if (ret)
+			return ret;
+		if (val & AXP20X_GPIO3_FUNCTION_INPUT)
+			return GPIO_LINE_DIRECTION_IN;
+
+		return GPIO_LINE_DIRECTION_OUT;
+	}
+
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
 		return reg;
@@ -184,6 +209,15 @@ static void axp20x_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
 	int reg;
 
+	/* AXP209 has GPIO3 status sharing the settings register */
+	if (offset == 3) {
+		regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL,
+				   AXP20X_GPIO3_FUNCTIONS,
+				   value ? AXP20X_GPIO3_FUNCTION_OUT_HIGH :
+				   AXP20X_GPIO3_FUNCTION_OUT_LOW);
+		return;
+	}
+
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
 		return;
@@ -200,6 +234,14 @@ static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
 	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	int reg;
 
+	/* AXP209 GPIO3 settings have a different layout */
+	if (offset == 3) {
+		return regmap_update_bits(pctl->regmap, AXP20X_GPIO3_CTRL,
+				   AXP20X_GPIO3_FUNCTIONS,
+				   config == AXP20X_MUX_GPIO_OUT ? AXP20X_GPIO3_FUNCTION_OUT_LOW :
+				   AXP20X_GPIO3_FUNCTION_INPUT);
+	}
+
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
 		return reg;
-- 
2.39.2

