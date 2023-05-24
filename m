Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54670F579
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjEXLk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEXLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:40:55 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC87135;
        Wed, 24 May 2023 04:40:51 -0700 (PDT)
Received: from mta-01.yadro.com (localhost.localdomain [127.0.0.1])
        by mta-01.yadro.com (Proxmox) with ESMTP id 11F2A3425F3;
        Wed, 24 May 2023 14:40:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=mta-01; bh=ozepF3nEKKN3yWRME3
        KKtyGQGa1TAe0/aW2uROZnlKc=; b=Aw3JuZRMi7tGmxfNIJ1vbrKmpFhFo4IW1D
        KyiE7q1BFkJWF6upU/Zv1fc5j6HPi1jAghb96AWZVkOeGuGmePgGy7/d8hzawis/
        d4c8XRMmZRdNm9mz/jx1l5Ebp+JW6R0SQzZwpjlZbRkrXhksmirNyar5+/E6n3us
        u+Etyj5OI=
Received: from T-EXCH-08.corp.yadro.com (unknown [172.17.10.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Proxmox) with ESMTPS id 0718D3425DD;
        Wed, 24 May 2023 14:40:50 +0300 (MSK)
Received: from xpad.Home (10.199.28.63) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 24 May
 2023 14:40:49 +0300
From:   Vladimir Barinov <v.barinov@yadro.com>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vladimir Barinov <v.barinov@yadro.com>, <linux@yadro.com>
Subject: [PATCH 1/2] leds: add Awinic AW2016 LED driver
Date:   Wed, 24 May 2023 14:40:42 +0300
Message-ID: <20230524114042.196490-1-v.barinov@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524113910.196321-1-v.barinov@yadro.com>
References: <20230524113910.196321-1-v.barinov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.28.63]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for Awinic AW2026 3-channel LED driver with
I2C insterface. It supports hardware blinking and hardware
pattern generator.

Signed-off-by: Vladimir Barinov <v.barinov@yadro.com>
---
 drivers/leds/Kconfig       |  10 +
 drivers/leds/Makefile      |   1 +
 drivers/leds/leds-aw2026.c | 578 +++++++++++++++++++++++++++++++++++++
 3 files changed, 589 insertions(+)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index aaa9140bc351..574f3cc47d3e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -104,6 +104,16 @@ config LEDS_AW2013
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-aw2013.
 
+config LEDS_AW2026
+	tristate "LED support for Awinic AW2026"
+	depends on LEDS_CLASS && I2C && OF
+	help
+	  This option enables support for the AW2026 3-channel
+	  LED driver.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-aw2026.
+
 config LEDS_BCM6328
 	tristate "LED Support for Broadcom BCM6328"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d30395d11fd8..7fb7b48329ff 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
+obj-$(CONFIG_LEDS_AW2026)		+= leds-aw2026.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
 obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
diff --git a/drivers/leds/leds-aw2026.c b/drivers/leds/leds-aw2026.c
index e69de29bb2d1..7c2d5f62797c 100644
--- a/drivers/leds/leds-aw2026.c
+++ b/drivers/leds/leds-aw2026.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Awinic AW2026 3-channel LED driver
+ *
+ * Author: Vladimir Barinov <v.barinov@yadro.com>
+ * Copyright (C) 2023 KNS Group LLC (YADRO)
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define AW2026_MAX_LEDS		3
+
+/* Chip ID and Software Reset Register */
+#define AW2026_RSTIDR		0x00
+#define AW2026_RSTIDR_RESET	0x55
+#define AW2026_RSTIDR_CHIP_ID	0x31
+
+/* Global Control Register */
+#define AW2026_GCR		0x01
+#define AW2026_GCR_CHIPEN	BIT(0)
+
+/* LED Maximum Current Register */
+#define AW2026_IMAX		0x03
+#define AW2026_IMAX_MASK	(BIT(0) | BIT(1))
+
+/* LED Configure Register */
+#define AW2026_LCFG(x)		(0x04 + (x))
+#define AW2026_LCFG_LEDMD	BIT(0)
+#define AW2026_LCFG_FADE_IN	BIT(1)
+#define AW2026_LCFG_FADE_OUT	BIT(2)
+
+/* LED Channel Enable Register */
+#define AW2026_LEDEN		0x07
+
+/* Pattern Run/Stop Register */
+#define AW2026_PATRUN		0x09
+
+/* LED Current Register */
+#define AW2026_ILED(x)		(0x10 + (x))
+#define AW2026_ILED_MAX		0xFF
+
+/* PWM duty level Register */
+#define AW2026_PWM(x)		(0x1C + (x))
+#define AW2026_PWM_DUTY_MAX	0xFF
+
+/* T1 Time Parameter of Pattern */
+#define AW2026_PAT_T1(x)	(0x30 + 5*(x))
+
+/* T2 Time Parameter of Pattern */
+#define AW2026_PAT_T2(x)	(0x31 + 5*(x))
+
+struct aw2026;
+
+enum aw2026_state {
+	AW2026_STATE_OFF,
+	AW2026_STATE_ON,
+	AW2026_STATE_KEEP,
+};
+
+struct aw2026_led {
+	struct aw2026 *chip;
+	struct fwnode_handle *fwnode;
+	struct led_classdev cdev;
+	enum aw2026_state default_state;
+	u32 idx;
+};
+
+struct aw2026 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct regulator *vcc_regulator;
+	struct aw2026_led leds[AW2026_MAX_LEDS];
+	int num_leds;
+	unsigned int imax;
+	bool enabled;
+};
+
+static const struct regmap_config aw2026_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3e,
+};
+
+struct msec_reg {
+	u32 msec;
+	u8 reg;
+};
+
+static const struct msec_reg aw2026_msec_reg[] = {
+	{ .msec =    4, .reg = 0x0 },
+	{ .msec =  130, .reg = 0x1 },
+	{ .msec =  260, .reg = 0x2 },
+	{ .msec =  380, .reg = 0x3 },
+	{ .msec =  510, .reg = 0x4 },
+	{ .msec =  770, .reg = 0x5 },
+	{ .msec = 1040, .reg = 0x6 },
+	{ .msec = 1600, .reg = 0x7 },
+	{ .msec = 2100, .reg = 0x8 },
+	{ .msec = 2600, .reg = 0x9 },
+	{ .msec = 3100, .reg = 0xa },
+	{ .msec = 4200, .reg = 0xb },
+	{ .msec = 5200, .reg = 0xc },
+	{ .msec = 6200, .reg = 0xd },
+	{ .msec = 7300, .reg = 0xe },
+	{ .msec = 8300, .reg = 0xf },
+	{ /* sentinel */ },
+};
+
+static int aw2026_chip_init(struct aw2026 *chip)
+{
+	int idx, ret;
+
+	ret = regmap_update_bits(chip->regmap, AW2026_GCR, AW2026_GCR_CHIPEN,
+				 AW2026_GCR_CHIPEN);
+	if (ret)
+		return ret;
+
+	/* Max current */
+	ret = regmap_update_bits(chip->regmap, AW2026_IMAX,
+				 AW2026_IMAX_MASK, chip->imax);
+	if (ret)
+		return ret;
+
+	for (idx = 0; idx < chip->num_leds; idx++) {
+		/* PWM level */
+		ret = regmap_write(chip->regmap, AW2026_PWM(idx), AW2026_PWM_DUTY_MAX);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static void aw2026_chip_disable(struct aw2026 *chip)
+{
+	int ret;
+
+	if (!chip->enabled)
+		return;
+
+	regmap_update_bits(chip->regmap, AW2026_GCR, AW2026_GCR_CHIPEN, 0);
+
+	ret = regulator_disable(chip->vcc_regulator);
+	if (ret) {
+		dev_err(&chip->client->dev,
+			"Failed to disable regulator: %d\n", ret);
+		return;
+	}
+
+	chip->enabled = false;
+}
+
+static int aw2026_chip_enable(struct aw2026 *chip)
+{
+	int ret;
+
+	if (chip->enabled)
+		return 0;
+
+	ret = regulator_enable(chip->vcc_regulator);
+	if (ret) {
+		dev_err(&chip->client->dev,
+			"Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+	chip->enabled = true;
+
+	ret = aw2026_chip_init(chip);
+	if (ret)
+		aw2026_chip_disable(chip);
+
+	return ret;
+}
+
+static bool aw2026_chip_in_use(struct aw2026 *chip)
+{
+	int i;
+
+	for (i = 0; i < chip->num_leds; i++)
+		if (chip->leds[i].cdev.brightness)
+			return true;
+
+	return false;
+}
+
+static int aw2026_brightness_set(struct led_classdev *cdev,
+				 enum led_brightness brightness)
+{
+	struct aw2026_led *led = container_of(cdev, struct aw2026_led, cdev);
+	int ret, idx = led->idx;
+
+	mutex_lock(&led->chip->lock);
+
+	if (aw2026_chip_in_use(led->chip)) {
+		ret = aw2026_chip_enable(led->chip);
+		if (ret)
+			goto error;
+	}
+
+	if (brightness) {
+		/* Manual mode */
+		ret = regmap_update_bits(led->chip->regmap, AW2026_LCFG(idx),
+					 AW2026_LCFG_LEDMD, 0);
+		if (ret)
+			goto error;
+		/* Current configure */
+		ret = regmap_write(led->chip->regmap, AW2026_ILED(idx), brightness);
+		if (ret)
+			goto error;
+		/* Enable LED */
+		ret = regmap_update_bits(led->chip->regmap, AW2026_LEDEN, BIT(idx), 0xFF);
+	} else {
+		/* Disable LED */
+		ret = regmap_update_bits(led->chip->regmap, AW2026_LEDEN, BIT(idx), 0);
+	}
+	if (ret)
+		goto error;
+
+	if (!aw2026_chip_in_use(led->chip))
+		aw2026_chip_disable(led->chip);
+
+error:
+	mutex_unlock(&led->chip->lock);
+
+	return ret;
+}
+
+static int aw2026_convert_msec_to_reg(struct aw2026 *chip, u32 *msec, u8 *reg)
+{
+	const struct msec_reg *value;
+	const struct msec_reg *prev_value = NULL;
+
+	for (value = aw2026_msec_reg; value->msec; value++) {
+		if (value->msec >= *msec)
+			break;
+		prev_value = value;
+	}
+
+	if (!value->msec) {
+		dev_err(&chip->client->dev, "Unsupported msec (%u)", *msec);
+		return -ERANGE;
+	}
+
+	if (prev_value && ((*msec - prev_value->msec) <= (value->msec - *msec)))
+		value = prev_value;
+
+	*reg = value->reg;
+	*msec = value->msec;
+
+	return 0;
+}
+
+static int aw2026_pattern_setup(struct aw2026_led *led, u8 trise, u8 ton, u8 tfall, u8 toff)
+{
+	int ret, idx = led->idx;
+
+	mutex_lock(&led->chip->lock);
+
+	if (aw2026_chip_in_use(led->chip)) {
+		ret = aw2026_chip_enable(led->chip);
+		if (ret)
+			goto error;
+	}
+
+	/* Pattern mode */
+	ret = regmap_update_bits(led->chip->regmap, AW2026_LCFG(idx),
+				 AW2026_LCFG_LEDMD, 0xFF);
+	if (ret)
+		goto error;
+	/* Current configure */
+	ret = regmap_write(led->chip->regmap, AW2026_ILED(idx), led->cdev.brightness);
+	if (ret)
+		goto error;
+	/* Rise and On time of Pattern */
+	ret = regmap_write(led->chip->regmap, AW2026_PAT_T1(idx), (trise << 4) | ton);
+	if (ret)
+		goto error;
+	/* Fall and Off time of Pattern */
+	ret = regmap_write(led->chip->regmap, AW2026_PAT_T2(idx), (tfall << 4) | toff);
+	if (ret)
+		goto error;
+	/* Pattern run for individual LED */
+	ret = regmap_update_bits(led->chip->regmap, AW2026_PATRUN, BIT(idx), 0xFF);
+	if (ret)
+		goto error;
+	/* Enable LED */
+	ret = regmap_update_bits(led->chip->regmap, AW2026_LEDEN, BIT(idx), 0xFF);
+
+error:
+	mutex_unlock(&led->chip->lock);
+
+	return ret;
+}
+
+static int aw2026_pattern_set(struct led_classdev *cdev,
+			      struct led_pattern *pattern,
+			      u32 len, int repeat)
+{
+	struct aw2026_led *led = container_of(cdev, struct aw2026_led, cdev);
+	struct aw2026 *chip = led->chip;
+	int ret;
+	u8 trise, ton, tfall, toff;
+
+	if (len == 1) {
+		led->cdev.brightness = pattern[0].brightness;
+		return aw2026_brightness_set(cdev, led->cdev.brightness);
+	}
+
+	if (repeat > 0 || len != 4)
+		return -EINVAL;
+
+	ret = aw2026_convert_msec_to_reg(chip, &pattern[0].delta_t, &trise);
+	if (ret)
+		return ret;
+	ret = aw2026_convert_msec_to_reg(chip, &pattern[1].delta_t, &ton);
+	if (ret)
+		return ret;
+	ret = aw2026_convert_msec_to_reg(chip, &pattern[2].delta_t, &tfall);
+	if (ret)
+		return ret;
+	ret = aw2026_convert_msec_to_reg(chip, &pattern[3].delta_t, &toff);
+	if (ret)
+		return ret;
+
+	dev_dbg(&chip->client->dev, "pattern timings: %d %d %d %d\n",
+		trise, ton, tfall, toff);
+
+	led->cdev.brightness = max(max(pattern[0].brightness, pattern[1].brightness),
+				   max(pattern[2].brightness, pattern[3].brightness));
+
+	return aw2026_pattern_setup(led, trise, ton, tfall, toff);
+}
+
+static int aw2026_pattern_clear(struct led_classdev *cdev)
+{
+	return aw2026_brightness_set(cdev, LED_OFF);
+}
+
+static int aw2026_blink_set(struct led_classdev *cdev,
+			    unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct aw2026_led *led = container_of(cdev, struct aw2026_led, cdev);
+	struct aw2026 *chip = led->chip;
+	u8 ton, toff;
+	int ret;
+
+	if (!*delay_on) {
+		led->cdev.brightness = LED_OFF;
+		return aw2026_brightness_set(&led->cdev, LED_OFF);
+	}
+
+	led->cdev.brightness = LED_FULL;
+
+	if (!*delay_off)
+		return aw2026_brightness_set(&led->cdev, LED_FULL);
+
+	ret = aw2026_convert_msec_to_reg(chip, (u32 *)delay_on, &ton);
+	if (ret)
+		return ret;
+	ret = aw2026_convert_msec_to_reg(chip, (u32 *)delay_off, &toff);
+	if (ret)
+		return ret;
+
+	dev_dbg(&chip->client->dev, "blink timings: %d %d\n", ton, toff);
+
+	return aw2026_pattern_setup(led, 0, ton, 0, toff);
+}
+
+static int aw2026_parse_dt(struct i2c_client *client, struct aw2026 *chip)
+{
+	struct device_node *np = dev_of_node(&client->dev), *child;
+	int count, ret = 0, i = 0;
+	struct aw2026_led *led;
+	const char *str;
+	u32 imax;
+
+	count = of_get_available_child_count(np);
+	if (!count || count > AW2026_MAX_LEDS)
+		return -EINVAL;
+
+	if (!of_property_read_u32(np, "awinic,led-max-microamp", &imax)) {
+		chip->imax = min_t(u32, hweight32(imax / 3187 - 1), 3);
+	} else {
+		chip->imax = 1; /* 6.375mA */
+		dev_info(&client->dev,
+			 "DT property led-max-microamp is missing\n");
+	}
+
+	for_each_available_child_of_node(np, child) {
+		u32 source;
+
+		ret = of_property_read_u32(child, "reg", &source);
+		if (ret != 0 || source >= AW2026_MAX_LEDS) {
+			dev_err(&chip->client->dev,
+				"Couldn't read LED address: %d\n", ret);
+			count--;
+			continue;
+		}
+
+		led = &chip->leds[i];
+		led->idx = source;
+		led->chip = chip;
+		led->fwnode = of_fwnode_handle(child);
+
+		if (!of_property_read_string(child, "default-state", &str)) {
+			if (!strcmp(str, "on"))
+				led->default_state = AW2026_STATE_ON;
+			else if (!strcmp(str, "keep"))
+				led->default_state = AW2026_STATE_KEEP;
+			else
+				led->default_state = AW2026_STATE_OFF;
+		}
+
+		i++;
+	}
+
+	if (!count)
+		return -EINVAL;
+
+	chip->num_leds = i;
+
+	return 0;
+}
+
+static void aw2026_init_default_state(struct aw2026_led *led)
+{
+	struct aw2026 *chip = led->chip;
+	int led_on;
+	int ret, idx = led->idx;
+
+	switch (led->default_state) {
+	case AW2026_STATE_ON:
+		led->cdev.brightness = LED_FULL;
+		break;
+	case AW2026_STATE_KEEP:
+		/* keep setup made in loader */
+		ret = regmap_read(chip->regmap, AW2026_LEDEN, &led_on);
+		if (ret)
+			return;
+
+		if (!(led_on & BIT(idx))) {
+			led->cdev.brightness = LED_OFF;
+			break;
+		}
+		regmap_read(chip->regmap, AW2026_ILED(idx),
+			    &led->cdev.brightness);
+		return;
+	default:
+		led->cdev.brightness = LED_OFF;
+	}
+
+	aw2026_brightness_set(&led->cdev, led->cdev.brightness);
+}
+
+static int aw2026_probe(struct i2c_client *client)
+{
+	struct aw2026 *chip;
+	int i, ret;
+	unsigned int chipid;
+
+	chip = devm_kzalloc(&client->dev, sizeof(struct aw2026), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	ret = aw2026_parse_dt(client, chip);
+	if (ret < 0)
+		return ret;
+
+	mutex_init(&chip->lock);
+	chip->client = client;
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap = devm_regmap_init_i2c(client, &aw2026_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto error;
+	}
+
+	chip->vcc_regulator = devm_regulator_get(&client->dev, "vcc");
+	ret = PTR_ERR_OR_ZERO(chip->vcc_regulator);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev,
+				"Failed to request regulator: %d\n", ret);
+		goto error;
+	}
+
+	ret = regulator_enable(chip->vcc_regulator);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to enable regulator: %d\n", ret);
+		goto error;
+	}
+
+	ret = regmap_read(chip->regmap, AW2026_RSTIDR, &chipid);
+	if (ret) {
+		dev_err(&client->dev, "Failed to read chip ID: %d\n", ret);
+		goto error_reg;
+	}
+
+	if (chipid != AW2026_RSTIDR_CHIP_ID) {
+		ret = -ENODEV;
+		goto error_reg;
+	}
+
+	for (i = 0; i < chip->num_leds; i++) {
+		struct led_init_data init_data = {};
+		struct aw2026_led *led = &chip->leds[i];
+
+		aw2026_init_default_state(&chip->leds[i]);
+		led->cdev.brightness_set_blocking = aw2026_brightness_set;
+		led->cdev.blink_set = aw2026_blink_set;
+		led->cdev.pattern_set = aw2026_pattern_set;
+		led->cdev.pattern_clear = aw2026_pattern_clear;
+
+		init_data.fwnode = chip->leds[i].fwnode;
+
+		ret = devm_led_classdev_register_ext(&client->dev,
+						     &led->cdev, &init_data);
+		if (ret < 0)
+			goto error_reg;
+	}
+
+	ret = regulator_disable(chip->vcc_regulator);
+	if (ret) {
+		dev_err(&client->dev,
+			"Failed to disable regulator: %d\n", ret);
+		goto error;
+	}
+
+	return 0;
+
+error_reg:
+	regulator_disable(chip->vcc_regulator);
+error:
+	mutex_destroy(&chip->lock);
+	return ret;
+}
+
+static void aw2026_remove(struct i2c_client *client)
+{
+	struct aw2026 *chip = i2c_get_clientdata(client);
+
+	aw2026_chip_disable(chip);
+
+	mutex_destroy(&chip->lock);
+}
+
+static const struct of_device_id aw2026_match_table[] = {
+	{ .compatible = "awinic,aw2026", },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, aw2026_match_table);
+
+static struct i2c_driver aw2026_driver = {
+	.driver = {
+		.name = "leds-aw2026",
+		.of_match_table = of_match_ptr(aw2026_match_table),
+	},
+	.probe_new = aw2026_probe,
+	.remove = aw2026_remove,
+};
+
+module_i2c_driver(aw2026_driver);
+
+MODULE_DESCRIPTION("AW2026 LED driver");
+MODULE_AUTHOR("Vladimir Barinov");
+MODULE_LICENSE("GPL");
-- 
2.34.1


