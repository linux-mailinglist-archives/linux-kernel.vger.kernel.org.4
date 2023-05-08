Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76A56FB409
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjEHPn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEHPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:43:19 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 970529006;
        Mon,  8 May 2023 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=weABc
        fwPfTFz49Ysejg6Ozz6T7XVNrerGmHs9xcKMbw=; b=Gkca7KTTOR5QTQ4SVGopI
        3Ovv8wusCTQO6CzWWyY9CSOzDvbAXGpZs+tz2+0u7PoAMciyS16uP439Vfm4r7lU
        DG44Ww5zTpepdOVw4UjhW8/IU+mGQHO41zASLb3YUILnnJI0Zvm85gFP0vt3q0c7
        zJ4mpls25HtHRgb1U6h14Y=
Received: from lizhe.. (unknown [120.245.132.9])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wBXLFX9F1lkWLGdAw--.17901S4;
        Mon, 08 May 2023 23:41:16 +0800 (CST)
From:   Lizhe <sensor1010@163.com>
To:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        linus.walleij@linaro.org, neil.armstrong@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-oxnas@groups.io, linux-stm32@st-md-mailman.stormreply.com,
        Lizhe <sensor1010@163.com>
Subject: [PATCH] dirvers/pinctrl.c : using pinctrl_dev->dev to obtain struct device * dev
Date:   Mon,  8 May 2023 23:40:43 +0800
Message-Id: <20230508154043.11859-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXLFX9F1lkWLGdAw--.17901S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww4UXFy3KF47Zw1xXFW8JFb_yoWxuryDpa
        1fXay5Kr17JF4xJry5A3yUuFy3Kan7J3yxG34UKasrZa15XF97J3y5KF40yFs5KFWkAw43
        Xa15XryY9w1UAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR8OzxUUUUU=
X-Originating-IP: [120.245.132.9]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBdBxpq1gi6EszigAAsK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the execution of the devm_pinctrl_register() function,
the member 'dev' in the 'pinctrl_dev' points to the
'struct device' structure. see pinctrl_init_controller().

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/pinctrl/pinctrl-apple-gpio.c |  2 +-
 drivers/pinctrl/pinctrl-oxnas.c      | 12 ++++++------
 drivers/pinctrl/pinctrl-pic32.c      | 12 ++++++------
 drivers/pinctrl/pinctrl-stmfx.c      |  6 +++---
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c |  4 ++--
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
index 3751c7de37aa..9dac920a3619 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -119,7 +119,7 @@ static int apple_gpio_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	ret = of_property_count_u32_elems(node, "pinmux");
 	if (ret <= 0) {
-		dev_err(pctl->dev,
+		dev_err(pctldev->dev,
 			"missing or empty pinmux property in node %pOFn.\n",
 			node);
 		return ret ? ret : -EINVAL;
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index fb10a8473ebe..88b03bd9f4dc 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -596,7 +596,7 @@ static int oxnas_ox810se_pinmux_enable(struct pinctrl_dev *pctldev,
 
 	while (functions->name) {
 		if (!strcmp(functions->name, fname)) {
-			dev_dbg(pctl->dev,
+			dev_dbg(pctldev->dev,
 				"setting function %s bank %d pin %d fct %d mask %x\n",
 				fname, pg->bank, pg->pin,
 				functions->fct, mask);
@@ -647,7 +647,7 @@ static int oxnas_ox820_pinmux_enable(struct pinctrl_dev *pctldev,
 
 	while (functions->name) {
 		if (!strcmp(functions->name, fname)) {
-			dev_dbg(pctl->dev,
+			dev_dbg(pctldev->dev,
 				"setting function %s bank %d pin %d fct %d mask %x\n",
 				fname, pg->bank, pg->pin,
 				functions->fct, mask);
@@ -697,7 +697,7 @@ static int oxnas_ox810se_gpio_request_enable(struct pinctrl_dev *pctldev,
 	struct oxnas_gpio_bank *bank = gpiochip_get_data(range->gc);
 	u32 mask = BIT(offset - bank->gpio_chip.base);
 
-	dev_dbg(pctl->dev, "requesting gpio %d in bank %d (id %d) with mask 0x%x\n",
+	dev_dbg(pctldev->dev, "requesting gpio %d in bank %d (id %d) with mask 0x%x\n",
 		offset, bank->gpio_chip.base, bank->id, mask);
 
 	regmap_write_bits(pctl->regmap,
@@ -909,7 +909,7 @@ static int oxnas_ox810se_pinconf_set(struct pinctrl_dev *pctldev,
 	u32 offset = pin - bank->gpio_chip.base;
 	u32 mask = BIT(offset);
 
-	dev_dbg(pctl->dev, "setting pin %d bank %d mask 0x%x\n",
+	dev_dbg(pctldev->dev, "setting pin %d bank %d mask 0x%x\n",
 		pin, bank->gpio_chip.base, mask);
 
 	for (i = 0; i < num_configs; i++) {
@@ -946,7 +946,7 @@ static int oxnas_ox820_pinconf_set(struct pinctrl_dev *pctldev,
 	u32 offset = pin - bank->gpio_chip.base;
 	u32 mask = BIT(offset);
 
-	dev_dbg(pctl->dev, "setting pin %d bank %d mask 0x%x\n",
+	dev_dbg(pctldev->dev, "setting pin %d bank %d mask 0x%x\n",
 		pin, bank->gpio_chip.base, mask);
 
 	for (i = 0; i < num_configs; i++) {
@@ -960,7 +960,7 @@ static int oxnas_ox820_pinconf_set(struct pinctrl_dev *pctldev,
 					  mask, mask);
 			break;
 		default:
-			dev_err(pctl->dev, "Property %u not supported\n",
+			dev_err(pctldev->dev, "Property %u not supported\n",
 				param);
 			return -ENOTSUPP;
 		}
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index dad05294fa72..bc98888acb7c 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -1937,23 +1937,23 @@ static int pic32_pinconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_PULL_UP:
-			dev_dbg(pctl->dev, "   pullup\n");
+			dev_dbg(pctldev->dev, "   pullup\n");
 			writel(mask, bank->reg_base +PIC32_SET(CNPU_REG));
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			dev_dbg(pctl->dev, "   pulldown\n");
+			dev_dbg(pctl_dev->dev, "   pulldown\n");
 			writel(mask, bank->reg_base + PIC32_SET(CNPD_REG));
 			break;
 		case PIN_CONFIG_MICROCHIP_DIGITAL:
-			dev_dbg(pctl->dev, "   digital\n");
+			dev_dbg(pctl_dev->dev, "   digital\n");
 			writel(mask, bank->reg_base + PIC32_CLR(ANSEL_REG));
 			break;
 		case PIN_CONFIG_MICROCHIP_ANALOG:
-			dev_dbg(pctl->dev, "   analog\n");
+			dev_dbg(pctldev->dev, "   analog\n");
 			writel(mask, bank->reg_base + PIC32_SET(ANSEL_REG));
 			break;
 		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
-			dev_dbg(pctl->dev, "   opendrain\n");
+			dev_dbg(pctldev->dev, "   opendrain\n");
 			writel(mask, bank->reg_base + PIC32_SET(ODCU_REG));
 			break;
 		case PIN_CONFIG_INPUT_ENABLE:
@@ -1964,7 +1964,7 @@ static int pic32_pinconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 						    offset, arg);
 			break;
 		default:
-			dev_err(pctl->dev, "Property %u not supported\n",
+			dev_err(pctldev->dev, "Property %u not supported\n",
 				param);
 			return -ENOTSUPP;
 		}
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index ab23d7ac3107..396996201856 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -711,7 +711,7 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 
 	ret = devm_gpiochip_add_data(pctl->dev, &pctl->gpio_chip, pctl);
 	if (ret) {
-		dev_err(pctl->dev, "gpio_chip registration failed\n");
+		dev_err(pctldev->dev, "gpio_chip registration failed\n");
 		return ret;
 	}
 
@@ -724,11 +724,11 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 					IRQF_ONESHOT,
 					dev_name(pctl->dev), pctl);
 	if (ret) {
-		dev_err(pctl->dev, "cannot request irq%d\n", irq);
+		dev_err(pctldev->dev, "cannot request irq%d\n", irq);
 		return ret;
 	}
 
-	dev_info(pctl->dev,
+	dev_info(pctldev->dev,
 		 "%ld GPIOs available\n", hweight_long(pctl->gpio_valid_mask));
 
 	return 0;
diff --git a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
index d2568dab8c78..f997cc26f01f 100644
--- a/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
+++ b/drivers/pinctrl/pxa/pinctrl-pxa2xx.c
@@ -91,7 +91,7 @@ static int pxa2xx_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	void __iomem *gpdr;
 
 	gpdr = pctl->base_gpdr[pin / 32];
-	dev_dbg(pctl->dev, "set_direction(pin=%d): dir=%d\n",
+	dev_dbg(pctldev->dev, "set_direction(pin=%d): dir=%d\n",
 		pin, !input);
 
 	spin_lock_irqsave(&pctl->lock, flags);
@@ -156,7 +156,7 @@ static int pxa2xx_pmx_set_mux(struct pinctrl_dev *pctldev, unsigned function,
 	gafr = pctl->base_gafr[pin / 16];
 	gpdr = pctl->base_gpdr[pin / 32];
 	shift = (pin % 16) << 1;
-	dev_dbg(pctl->dev, "set_mux(pin=%d): af=%d dir=%d\n",
+	dev_dbg(pctldev->dev, "set_mux(pin=%d): af=%d dir=%d\n",
 		pin, df->muxval >> 1, df->muxval & 0x1);
 
 	spin_lock_irqsave(&pctl->lock, flags);
-- 
2.34.1

