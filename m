Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AE66DFA49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjDLPdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjDLPd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FF7DBF;
        Wed, 12 Apr 2023 08:33:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2FACA660329C;
        Wed, 12 Apr 2023 16:33:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681313602;
        bh=cD7hv+m4LOlAXTSBkUahMUfTCdShYn+SrdLz55PfB20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0jz08gJkY7BrbexbgtcIJtUy6A/+hi9qCaThtbbbbfHFKjXnA+jzu+MuhXZbWAhX
         WkH68o8JM1qTn+WPZQZrLb9IVMG09pRYxHVxfFtuElhQx30V6K0bsLfBuRcF9wNOnK
         BDeW63iWc/Bq3X18LH4JqQW7VJ8X3wWD20YGD+vhziLvjUuLb+vG3lSfbtAno1uv1d
         50z8FSrYmL5LjlSa6EMsOdZed4Kuf5YJ8I56tR0rTkduOPRLQMh58EF/HN8EWNlZrY
         u4wsgLFE8wIL4wsANK0zLwD+fA0dLV6O+hsPOels2nHUITDgjSRQW6GFGx1wozQsTx
         EsucjZQhw/+Vg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 7/7] leds: leds-mt6323: Add support for WLEDs and MT6332
Date:   Wed, 12 Apr 2023 17:33:10 +0200
Message-Id: <20230412153310.241046-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic code to turn on and off WLEDs and wire up MT6332 support
to take advantage of it.
This is a simple approach due to to the aforementioned PMIC supporting
only on/off status so, at the time of writing, it is impossible for me
to validate more advanced functionality due to lack of hardware.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/leds/leds-mt6323.c | 171 +++++++++++++++++++++++++++++++++++--
 1 file changed, 164 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index 5d95dbd9a761..202b38ac32f6 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -20,6 +20,11 @@
 #define RG_DRV_32K_CK_PDN		BIT(11)
 #define RG_DRV_32K_CK_PDN_MASK		BIT(11)
 
+/* 32K/1M/6M clock common for WLED device */
+#define RG_VWLED_1M_CK_PDN		BIT(0)
+#define RG_VWLED_32K_CK_PDN		BIT(12)
+#define RG_VWLED_6M_CK_PDN		BIT(13)
+
 /*
  * Register field for TOP_CKPDN2 to enable
  * individual clock for LED device.
@@ -73,7 +78,7 @@ struct mt6323_led {
 	int			id;
 	struct mt6323_leds	*parent;
 	struct led_classdev	cdev;
-	enum led_brightness	current_brightness;
+	unsigned int		current_brightness;
 };
 
 /**
@@ -86,6 +91,7 @@ struct mt6323_led {
  * @num_isink_con:	Number of ISINKx_CON registers
  * @isink_max_regs:	Number of ISINK[0..x] registers
  * @isink_en_ctrl:	Offset to ISINK_EN_CTRL register
+ * @iwled_en_ctrl:	Offset to IWLED_EN_CTRL register
  */
 struct mt6323_regs {
 	const u16 *top_ckpdn;
@@ -96,18 +102,21 @@ struct mt6323_regs {
 	u8 num_isink_con;
 	u8 isink_max_regs;
 	u16 isink_en_ctrl;
+	u16 iwled_en_ctrl;
 };
 
 /**
  * struct mt6323_hwspec - hardware specific parameters
  * @max_period:		Maximum period for all LEDs
  * @max_leds:		Maximum number of supported LEDs
+ * @max_wleds:		Maximum number of WLEDs
  * @max_brightness:	Maximum brightness for all LEDs
  * @unit_duty:		Steps of duty per period
  */
 struct mt6323_hwspec {
 	u16 max_period;
 	u8 max_leds;
+	u8 max_wleds;
 	u16 max_brightness;
 	u16 unit_duty;
 };
@@ -379,6 +388,117 @@ static int mt6323_led_set_brightness(struct led_classdev *cdev,
 	return ret;
 }
 
+static int mtk_wled_hw_on(struct led_classdev *cdev)
+{
+	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
+	struct mt6323_leds *leds = led->parent;
+	const struct mt6323_regs *regs = leds->pdata->regs;
+	struct regmap *regmap = leds->hw->regmap;
+	int ret;
+
+	ret = regmap_clear_bits(regmap, regs->top_ckpdn[0], RG_VWLED_32K_CK_PDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(regmap, regs->top_ckpdn[0], RG_VWLED_6M_CK_PDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(regmap, regs->top_ckpdn[0], RG_VWLED_1M_CK_PDN);
+	if (ret)
+		return ret;
+
+	usleep_range(5000, 6000);
+
+	/* Enable WLED channel pair */
+	ret = regmap_set_bits(regmap, regs->iwled_en_ctrl, BIT(led->id));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, regs->iwled_en_ctrl, BIT(led->id + 1));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mtk_wled_hw_off(struct led_classdev *cdev)
+{
+	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
+	struct mt6323_leds *leds = led->parent;
+	const struct mt6323_regs *regs = leds->pdata->regs;
+	struct regmap *regmap = leds->hw->regmap;
+	int ret;
+
+	ret = regmap_clear_bits(regmap, regs->iwled_en_ctrl, BIT(led->id + 1));
+	if (ret)
+		return ret;
+
+	ret = regmap_clear_bits(regmap, regs->iwled_en_ctrl, BIT(led->id));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, regs->top_ckpdn[0], RG_VWLED_32K_CK_PDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, regs->top_ckpdn[0], RG_VWLED_6M_CK_PDN);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(regmap, regs->top_ckpdn[0], RG_VWLED_1M_CK_PDN);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static unsigned int mt6323_get_wled_brightness(struct led_classdev *cdev)
+{
+	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
+	struct mt6323_leds *leds = led->parent;
+	const struct mt6323_regs *regs = leds->pdata->regs;
+	struct regmap *regmap = leds->hw->regmap;
+	unsigned int status;
+	int ret;
+
+	ret = regmap_read(regmap, regs->iwled_en_ctrl, &status);
+	if (ret)
+		return 0;
+
+	/* Always two channels per WLED */
+	status &= BIT(led->id) | BIT(led->id + 1);
+
+	return status ? led->current_brightness : 0;
+}
+
+static int mt6323_wled_set_brightness(struct led_classdev *cdev,
+				      unsigned int brightness)
+{
+	struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
+	struct mt6323_leds *leds = led->parent;
+	int ret = 0;
+
+	mutex_lock(&leds->lock);
+
+	if (brightness) {
+		if (!led->current_brightness)
+			ret = mtk_wled_hw_on(cdev);
+		if (ret)
+			goto out;
+	} else {
+		ret = mtk_wled_hw_off(cdev);
+		if (ret)
+			goto out;
+	}
+
+	led->current_brightness = brightness;
+out:
+	mutex_unlock(&leds->lock);
+
+	return ret;
+}
+
 static int mt6323_led_set_dt_default(struct led_classdev *cdev,
 				     struct device_node *np)
 {
@@ -418,6 +538,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
 	int ret;
 	unsigned int status;
 	u32 reg;
+	u8 max_leds;
 
 	leds = devm_kzalloc(dev, sizeof(*leds), GFP_KERNEL);
 	if (!leds)
@@ -428,6 +549,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
 	leds->pdata = device_get_match_data(dev);
 	regs = leds->pdata->regs;
 	spec = leds->pdata->spec;
+	max_leds = spec->max_leds + spec->max_wleds;
 
 	/*
 	 * leds->hw points to the underlying bus for the register
@@ -447,6 +569,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node(np, child) {
 		struct led_init_data init_data = {};
+		bool is_wled;
 
 		ret = of_property_read_u32(child, "reg", &reg);
 		if (ret) {
@@ -454,7 +577,7 @@ static int mt6323_led_probe(struct platform_device *pdev)
 			goto put_child_node;
 		}
 
-		if (reg >= spec->max_leds || reg >= MAX_SUPPORTED_LEDS ||
+		if (reg >= max_leds || reg >= MAX_SUPPORTED_LEDS ||
 		    leds->led[reg]) {
 			dev_err(dev, "Invalid led reg %u\n", reg);
 			ret = -EINVAL;
@@ -467,14 +590,24 @@ static int mt6323_led_probe(struct platform_device *pdev)
 			goto put_child_node;
 		}
 
+		is_wled = of_property_read_bool(child, "mediatek,is-wled");
+
 		leds->led[reg] = led;
 		leds->led[reg]->id = reg;
 		leds->led[reg]->cdev.max_brightness = spec->max_brightness;
-		leds->led[reg]->cdev.brightness_set_blocking =
-					mt6323_led_set_brightness;
-		leds->led[reg]->cdev.blink_set = mt6323_led_set_blink;
-		leds->led[reg]->cdev.brightness_get =
-					mt6323_get_led_hw_brightness;
+
+		if (is_wled) {
+			leds->led[reg]->cdev.brightness_set_blocking =
+						mt6323_wled_set_brightness;
+			leds->led[reg]->cdev.brightness_get =
+						mt6323_get_wled_brightness;
+		} else {
+			leds->led[reg]->cdev.brightness_set_blocking =
+						mt6323_led_set_brightness;
+			leds->led[reg]->cdev.blink_set = mt6323_led_set_blink;
+			leds->led[reg]->cdev.brightness_get =
+						mt6323_get_led_hw_brightness;
+		}
 		leds->led[reg]->parent = leds;
 
 		ret = mt6323_led_set_dt_default(&leds->led[reg]->cdev, child);
@@ -542,6 +675,17 @@ static const struct mt6323_regs mt6331_registers = {
 	.isink_en_ctrl = 0x43a,
 };
 
+static const struct mt6323_regs mt6332_registers = {
+	.top_ckpdn = (const u16[]){ 0x8094, 0x809a, 0x80a0 },
+	.num_top_ckpdn = 3,
+	.top_ckcon = (const u16[]){ 0x80a6, 0x80ac },
+	.num_top_ckcon = 2,
+	.isink_con = (const u16[]){ 0x8cd4 },
+	.num_isink_con = 1,
+	.isink_max_regs = 12, /* IWLED[0..2, 3..9] */
+	.iwled_en_ctrl = 0x8cda,
+};
+
 static const struct mt6323_hwspec mt6323_spec = {
 	.max_period = 10000,
 	.max_leds = 4,
@@ -549,6 +693,13 @@ static const struct mt6323_hwspec mt6323_spec = {
 	.unit_duty = 3125,
 };
 
+static const struct mt6323_hwspec mt6332_spec = {
+	/* There are no LEDs in MT6332. Only WLEDs are present. */
+	.max_leds = 0,
+	.max_wleds = 1,
+	.max_brightness = 1024,
+};
+
 static const struct mt6323_data mt6323_pdata = {
 	.regs = &mt6323_registers,
 	.spec = &mt6323_spec,
@@ -559,9 +710,15 @@ static const struct mt6323_data mt6331_pdata = {
 	.spec = &mt6323_spec,
 };
 
+static const struct mt6323_data mt6332_pdata = {
+	.regs = &mt6332_registers,
+	.spec = &mt6332_spec,
+};
+
 static const struct of_device_id mt6323_led_dt_match[] = {
 	{ .compatible = "mediatek,mt6323-led", .data = &mt6323_pdata},
 	{ .compatible = "mediatek,mt6331-led", .data = &mt6331_pdata },
+	{ .compatible = "mediatek,mt6332-led", .data = &mt6332_pdata },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mt6323_led_dt_match);
-- 
2.40.0

