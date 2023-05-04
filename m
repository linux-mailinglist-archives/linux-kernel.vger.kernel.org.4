Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63336F7119
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjEDRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314A4491;
        Thu,  4 May 2023 10:36:27 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-176.ewe-ip-backbone.de [91.248.211.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F7DB6605707;
        Thu,  4 May 2023 18:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683221785;
        bh=ECt0CybBtygKRV+cG8dWptfNQKYwpjyME5jwl4Im7tY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsAvjjCL4/kYWXztzGHptCNV0E7/0BqeIJHOfBH5wFm8Q3h9/Tp/LM8Xmc4EaCRVB
         csKCOh15rsg1NWNRq0gJEL76o7+jB1rgEfKp3lj/C2gkt6rrm400T8SxX/gw6rqFwW
         +HIONHU7JQ2S/jSeXrTFjNEmYcYrYvjzCv0hcGK9HGntXkiqIDEuxiBpVAOtRfwEar
         mc7LuG1t7manfxH3nMR8JKo59qpR0H+GDGRfyfweb2UuS1QjOJ9yjJ1T3NWCUsJRXh
         3ktsdPiSOAIpSZ9AnQtDd7z06vHE5oSOXposm3pQasEgVm9DxkxU6OgPcZrcy1baNx
         lGaUNTjllhiww==
Received: by jupiter.universe (Postfix, from userid 1000)
        id DE38D4807F0; Thu,  4 May 2023 19:36:20 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com, Diederik de Haas <didi.debian@cknow.org>,
        Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH v8 06/14] mfd: rk8xx-i2c: use device_get_match_data
Date:   Thu,  4 May 2023 19:36:10 +0200
Message-Id: <20230504173618.142075-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504173618.142075-1-sebastian.reichel@collabora.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the device identification logic by supplying the relevant
information via of_match_data. This also removes the dev_info()
printing the chip version, since that's supplied by the match data
now.

Due to lack of hardware this change is compile-tested only.

Acked-for-MFD-by: Lee Jones <lee@kernel.org>
Tested-by: Diederik de Haas <didi.debian@cknow.org> # Rock64, Quartz64 Model A + B
Tested-by: Vincent Legoll <vincent.legoll@gmail.com> # Pine64 QuartzPro64
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk8xx-core.c |  2 -
 drivers/mfd/rk8xx-i2c.c  | 89 +++++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/drivers/mfd/rk8xx-core.c b/drivers/mfd/rk8xx-core.c
index 5c0a5acef34c..ddf2052c5190 100644
--- a/drivers/mfd/rk8xx-core.c
+++ b/drivers/mfd/rk8xx-core.c
@@ -597,8 +597,6 @@ int rk8xx_probe(struct device *dev, int variant, unsigned int irq, struct regmap
 		return -EINVAL;
 	}
 
-	dev_info(dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
-
 	if (!irq)
 		return dev_err_probe(dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 6d121b589fec..2822bfa8a04a 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -16,6 +16,11 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 
+struct rk8xx_i2c_platform_data {
+	const struct regmap_config *regmap_cfg;
+	int variant;
+};
+
 static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	/*
@@ -103,66 +108,46 @@ static const struct regmap_config rk817_regmap_config = {
 	.volatile_reg = rk817_is_volatile_reg,
 };
 
-static int rk8xx_i2c_get_variant(struct i2c_client *client)
-{
-	u8 pmic_id_msb, pmic_id_lsb;
-	int msb, lsb;
-
-	if (of_device_is_compatible(client->dev.of_node, "rockchip,rk817") ||
-	    of_device_is_compatible(client->dev.of_node, "rockchip,rk809")) {
-		pmic_id_msb = RK817_ID_MSB;
-		pmic_id_lsb = RK817_ID_LSB;
-	} else {
-		pmic_id_msb = RK808_ID_MSB;
-		pmic_id_lsb = RK808_ID_LSB;
-	}
+static const struct rk8xx_i2c_platform_data rk805_data = {
+	.regmap_cfg = &rk805_regmap_config,
+	.variant = RK805_ID,
+};
+
+static const struct rk8xx_i2c_platform_data rk808_data = {
+	.regmap_cfg = &rk808_regmap_config,
+	.variant = RK808_ID,
+};
 
-	/* Read chip variant */
-	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
-	if (msb < 0)
-		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
+static const struct rk8xx_i2c_platform_data rk809_data = {
+	.regmap_cfg = &rk817_regmap_config,
+	.variant = RK809_ID,
+};
 
-	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
-	if (lsb < 0)
-		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
+static const struct rk8xx_i2c_platform_data rk817_data = {
+	.regmap_cfg = &rk817_regmap_config,
+	.variant = RK817_ID,
+};
 
-	return ((msb << 8) | lsb) & RK8XX_ID_MSK;
-}
+static const struct rk8xx_i2c_platform_data rk818_data = {
+	.regmap_cfg = &rk818_regmap_config,
+	.variant = RK818_ID,
+};
 
 static int rk8xx_i2c_probe(struct i2c_client *client)
 {
-	const struct regmap_config *regmap_cfg;
+	const struct rk8xx_i2c_platform_data *data;
 	struct regmap *regmap;
-	int variant;
 
-	variant = rk8xx_i2c_get_variant(client);
-	if (variant < 0)
-		return variant;
-
-	switch (variant) {
-	case RK805_ID:
-		regmap_cfg = &rk805_regmap_config;
-		break;
-	case RK808_ID:
-		regmap_cfg = &rk808_regmap_config;
-		break;
-	case RK818_ID:
-		regmap_cfg = &rk818_regmap_config;
-		break;
-	case RK809_ID:
-	case RK817_ID:
-		regmap_cfg = &rk817_regmap_config;
-		break;
-	default:
-		return dev_err_probe(&client->dev, -EINVAL, "Unsupported RK8XX ID %x\n", variant);
-	}
+	data = device_get_match_data(&client->dev);
+	if (!data)
+		return -ENODEV;
 
-	regmap = devm_regmap_init_i2c(client, regmap_cfg);
+	regmap = devm_regmap_init_i2c(client, data->regmap_cfg);
 	if (IS_ERR(regmap))
 		return dev_err_probe(&client->dev, PTR_ERR(regmap),
 				     "regmap initialization failed\n");
 
-	return rk8xx_probe(&client->dev, variant, client->irq, regmap);
+	return rk8xx_probe(&client->dev, data->variant, client->irq, regmap);
 }
 
 static void rk8xx_i2c_shutdown(struct i2c_client *client)
@@ -173,11 +158,11 @@ static void rk8xx_i2c_shutdown(struct i2c_client *client)
 static SIMPLE_DEV_PM_OPS(rk8xx_i2c_pm_ops, rk8xx_suspend, rk8xx_resume);
 
 static const struct of_device_id rk8xx_i2c_of_match[] = {
-	{ .compatible = "rockchip,rk805" },
-	{ .compatible = "rockchip,rk808" },
-	{ .compatible = "rockchip,rk809" },
-	{ .compatible = "rockchip,rk817" },
-	{ .compatible = "rockchip,rk818" },
+	{ .compatible = "rockchip,rk805", .data = &rk805_data },
+	{ .compatible = "rockchip,rk808", .data = &rk808_data },
+	{ .compatible = "rockchip,rk809", .data = &rk809_data },
+	{ .compatible = "rockchip,rk817", .data = &rk817_data },
+	{ .compatible = "rockchip,rk818", .data = &rk818_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rk8xx_i2c_of_match);
-- 
2.39.2

