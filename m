Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9873A3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjFVO6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjFVO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:58:16 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FA7170C;
        Thu, 22 Jun 2023 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sjxcNmJUMrkxXyd7HIf7H5sQeEy7LKNuRpoBhXqqIPM=; b=rxXDZ/Tyc/XK7Wx8nw/9VMAr6z
        +VBaQFuEhZxlzs1c1VtN78Ke8HfQpQTU1Uwgii4H5Wmn2NrulKDEAxa371PxKrU1OY/Lxhhk6Jd7x
        RwTa5wNnsznPxmIE+jkHVV6TJIoR6J3pdim9RxUzojSyw3XVAGOmhnoSGlgS4voy4L8k=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:55382 helo=localhost.localdomain)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qCLlB-0002fr-67; Thu, 22 Jun 2023 10:58:10 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Thu, 22 Jun 2023 10:57:48 -0400
Message-Id: <20230622145800.2442116-6-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230622145800.2442116-1-hugo@hugovil.com>
References: <20230622145800.2442116-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v4 05/17] rtc: pcf2127: add variant-specific configuration structure
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Create variant-specific configuration structures to simplify the
implementation of new variants into this driver. It will also avoid
to have too many tests for a specific variant, or a list of variants
for new devices, inside the code itself.

Add configuration options for the support of the NVMEM, bit CD0 in
register WD_CTL as well as the maximum number of registers for each
variant, instead of hardcoding the variant (PCF2127) inside the
i2c_device_id and spi_device_id structures.

Also specify a different maximum number of registers (max_register)
for the PCF2129.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/rtc/rtc-pcf2127.c | 98 +++++++++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
index b10878a9224c..61918d7dc7a5 100644
--- a/drivers/rtc/rtc-pcf2127.c
+++ b/drivers/rtc/rtc-pcf2127.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
 
@@ -89,10 +90,24 @@
 		PCF2127_BIT_CTRL2_WDTF | \
 		PCF2127_BIT_CTRL2_TSF2)
 
+enum pcf21xx_type {
+	PCF2127,
+	PCF2129,
+	PCF21XX_LAST_ID
+};
+
+struct pcf21xx_config {
+	int type; /* IC variant */
+	int max_register;
+	unsigned int has_nvmem:1;
+	unsigned int has_bit_wd_ctl_cd0:1;
+};
+
 struct pcf2127 {
 	struct rtc_device *rtc;
 	struct watchdog_device wdd;
 	struct regmap *regmap;
+	const struct pcf21xx_config *cfg;
 	time64_t ts;
 	bool ts_valid;
 	bool irq_enabled;
@@ -606,8 +621,23 @@ static const struct attribute_group pcf2127_attr_group = {
 	.attrs	= pcf2127_attrs,
 };
 
+static struct pcf21xx_config pcf21xx_cfg[] = {
+	[PCF2127] = {
+		.type = PCF2127,
+		.max_register = 0x1d,
+		.has_nvmem = 1,
+		.has_bit_wd_ctl_cd0 = 1,
+	},
+	[PCF2129] = {
+		.type = PCF2129,
+		.max_register = 0x19,
+		.has_nvmem = 0,
+		.has_bit_wd_ctl_cd0 = 0,
+	},
+};
+
 static int pcf2127_probe(struct device *dev, struct regmap *regmap,
-			 int alarm_irq, const char *name, bool is_pcf2127)
+			 int alarm_irq, const char *name, const struct pcf21xx_config *config)
 {
 	struct pcf2127 *pcf2127;
 	int ret = 0;
@@ -620,6 +650,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		return -ENOMEM;
 
 	pcf2127->regmap = regmap;
+	pcf2127->cfg = config;
 
 	dev_set_drvdata(dev, pcf2127);
 
@@ -663,7 +694,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 		set_bit(RTC_FEATURE_ALARM, pcf2127->rtc->features);
 	}
 
-	if (is_pcf2127) {
+	if (pcf2127->cfg->has_nvmem) {
 		struct nvmem_config nvmem_cfg = {
 			.priv = pcf2127,
 			.reg_read = pcf2127_nvmem_read,
@@ -709,7 +740,7 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 				 PCF2127_BIT_WD_CTL_TF1 |
 				 PCF2127_BIT_WD_CTL_TF0,
 				 PCF2127_BIT_WD_CTL_CD1 |
-				 (is_pcf2127 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
+				 (pcf2127->cfg->has_bit_wd_ctl_cd0 ? PCF2127_BIT_WD_CTL_CD0 : 0) |
 				 PCF2127_BIT_WD_CTL_TF1);
 	if (ret) {
 		dev_err(dev, "%s: watchdog config (wd_ctl) failed\n", __func__);
@@ -774,9 +805,9 @@ static int pcf2127_probe(struct device *dev, struct regmap *regmap,
 
 #ifdef CONFIG_OF
 static const struct of_device_id pcf2127_of_match[] = {
-	{ .compatible = "nxp,pcf2127" },
-	{ .compatible = "nxp,pcf2129" },
-	{ .compatible = "nxp,pca2129" },
+	{ .compatible = "nxp,pcf2127", .data = &pcf21xx_cfg[PCF2127] },
+	{ .compatible = "nxp,pcf2129", .data = &pcf21xx_cfg[PCF2129] },
+	{ .compatible = "nxp,pca2129", .data = &pcf21xx_cfg[PCF2129] },
 	{}
 };
 MODULE_DEVICE_TABLE(of, pcf2127_of_match);
@@ -861,26 +892,40 @@ static const struct regmap_bus pcf2127_i2c_regmap = {
 static struct i2c_driver pcf2127_i2c_driver;
 
 static const struct i2c_device_id pcf2127_i2c_id[] = {
-	{ "pcf2127", 1 },
-	{ "pcf2129", 0 },
-	{ "pca2129", 0 },
+	{ "pcf2127", PCF2127 },
+	{ "pcf2129", PCF2129 },
+	{ "pca2129", PCF2129 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, pcf2127_i2c_id);
 
 static int pcf2127_i2c_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_match_id(pcf2127_i2c_id, client);
 	struct regmap *regmap;
-	static const struct regmap_config config = {
+	static struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
-		.max_register = 0x1d,
 	};
+	const struct pcf21xx_config *variant;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -ENODEV;
 
+	if (client->dev.of_node) {
+		variant = of_device_get_match_data(&client->dev);
+		if (!variant)
+			return -ENODEV;
+	} else {
+		enum pcf21xx_type type =
+			i2c_match_id(pcf2127_i2c_id, client)->driver_data;
+
+		if (type >= PCF21XX_LAST_ID)
+			return -ENODEV;
+		variant = &pcf21xx_cfg[type];
+	}
+
+	config.max_register = variant->max_register,
+
 	regmap = devm_regmap_init(&client->dev, &pcf2127_i2c_regmap,
 					&client->dev, &config);
 	if (IS_ERR(regmap)) {
@@ -890,7 +935,7 @@ static int pcf2127_i2c_probe(struct i2c_client *client)
 	}
 
 	return pcf2127_probe(&client->dev, regmap, client->irq,
-			     pcf2127_i2c_driver.driver.name, id->driver_data);
+			     pcf2127_i2c_driver.driver.name, variant);
 }
 
 static struct i2c_driver pcf2127_i2c_driver = {
@@ -928,17 +973,32 @@ static void pcf2127_i2c_unregister_driver(void)
 #if IS_ENABLED(CONFIG_SPI_MASTER)
 
 static struct spi_driver pcf2127_spi_driver;
+static const struct spi_device_id pcf2127_spi_id[];
 
 static int pcf2127_spi_probe(struct spi_device *spi)
 {
-	static const struct regmap_config config = {
+	static struct regmap_config config = {
 		.reg_bits = 8,
 		.val_bits = 8,
 		.read_flag_mask = 0xa0,
 		.write_flag_mask = 0x20,
-		.max_register = 0x1d,
 	};
 	struct regmap *regmap;
+	const struct pcf21xx_config *variant;
+
+	if (spi->dev.of_node) {
+		variant = of_device_get_match_data(&spi->dev);
+		if (!variant)
+			return -ENODEV;
+	} else {
+		enum pcf21xx_type type = spi_get_device_id(spi)->driver_data;
+
+		if (type >= PCF21XX_LAST_ID)
+			return -ENODEV;
+		variant = &pcf21xx_cfg[type];
+	}
+
+	config.max_register = variant->max_register,
 
 	regmap = devm_regmap_init_spi(spi, &config);
 	if (IS_ERR(regmap)) {
@@ -949,13 +1009,13 @@ static int pcf2127_spi_probe(struct spi_device *spi)
 
 	return pcf2127_probe(&spi->dev, regmap, spi->irq,
 			     pcf2127_spi_driver.driver.name,
-			     spi_get_device_id(spi)->driver_data);
+			     variant);
 }
 
 static const struct spi_device_id pcf2127_spi_id[] = {
-	{ "pcf2127", 1 },
-	{ "pcf2129", 0 },
-	{ "pca2129", 0 },
+	{ "pcf2127", PCF2127 },
+	{ "pcf2129", PCF2129 },
+	{ "pca2129", PCF2129 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, pcf2127_spi_id);
-- 
2.30.2

