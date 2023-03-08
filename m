Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1616B12C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCHUPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCHUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:15:25 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB66D38EB;
        Wed,  8 Mar 2023 12:14:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h14so16550863wru.4;
        Wed, 08 Mar 2023 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678306496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NTxFyuXuvL1E8ook5zvxKliYZOMPtSFayWm7A/U3Gc=;
        b=c0XJMkhNFSaE+GGuCk/cmM7LWYBQEeY4SqkeA8A5UXchCJrwxyFwdFUCt/RwdVveTd
         o7fhtnkIq3VsbkzC6uzhQQxFprsrhWRHw97DqFmfhNhDJ5SqBxt226gr66G8duEL7LF3
         aYibNBvQZA+AGQc42m9yMKe9PerlImooNCc3/KWoZhe/4ZYMGaFS+cSff6Lh5hB67oPu
         eOWNMddUwm+JyH0muQY2sSvAYG2LeQFD+0sOdTIcFwyu1nLA7Y+43WvpUjM8fChNpGDg
         8MRsczdBiuLdGqHEQlUWAsp641C+OA84B7z7L0ZxEmWO5hFH6275o/pviDDOTo9tpq1w
         P2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NTxFyuXuvL1E8ook5zvxKliYZOMPtSFayWm7A/U3Gc=;
        b=c5B+iP/GPm8YCRSi0y1ey+ND3iMm+2LFTcQnFYILDT0aLCxp2lsc55mY1fEgMdxooL
         txTIauGIMln9fdbhw0G4SVEyYRap49mvaI2WRkVqFGxggx0Fg6dJ4wQaaA9GUnblde3F
         bkovRARTZnVQupO4GbPdYXnd4DwmHZ8GgJj68Hs10KYPzV56s8opGxmhWlNkcG3KlTyd
         iAeVGmoaRJa17kCivsvspdBNMb2f4bMJpOqlCMOhsBOQFvM0M8NcKz5Tl9Qn6P8R4gCd
         R6rDQKsX3hF6c0Yuqyc/Ad/MDSiUTMW21FsFnLECiEtTTZOCh8Z9XdC2FIRgV0Agc1UO
         SCTw==
X-Gm-Message-State: AO0yUKXiBCJWos4v0cJYSPszbBhBfL9e1LpOzUtkoFDBrtj9nk9Z2cvV
        0js9x8siqxtC0XUAesfQ4/sNoKE9v7A3qw==
X-Google-Smtp-Source: AK7set+IzeN+P2cBofIYWlGP6N/rvKgcCi263L71Ac0YNJVXJdiuipWM5KzNvn8btYevk3lD02e3Ng==
X-Received: by 2002:a5d:4a4a:0:b0:2c7:434e:9a5a with SMTP id v10-20020a5d4a4a000000b002c7434e9a5amr12438161wrs.65.1678306496403;
        Wed, 08 Mar 2023 12:14:56 -0800 (PST)
Received: from Beasty.Home ([2a02:c7f:a63c:de00:a170:c7f8:586:6319])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b002c7b229b1basm16129796wrr.15.2023.03.08.12.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:14:56 -0800 (PST)
From:   Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Subject: [PATCH 2/2] leds: Add support for rohm,bd65b60 led driver
Date:   Wed,  8 Mar 2023 20:14:51 +0000
Message-Id: <20230308201451.11629-2-bogdan.ionescu.work@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for ROHM BD65B60 led driver.
The chip supports 2 outpus sharing the same current setting
and is controlled over I2C.

Signed-off-by: Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
---
 drivers/leds/Kconfig        |  11 ++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-bd65b60.c | 287 ++++++++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 drivers/leds/leds-bd65b60.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index aaa9140bc351..8c5090ac5cba 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -717,6 +717,17 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_BD65B60
+	tristate "LED Driver for BD65B60"
+	depends on LEDS_CLASS
+	depends on I2C
+	help
+	  If you have a LCD backlight connected to the ROHM BD65B60,
+	  say Y here to enable this driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-bd65b60.
+
 config LEDS_POWERNV
 	tristate "LED support for PowerNV Platform"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d30395d11fd8..9f85642a2c79 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
 obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
+obj-$(CONFIG_LEDS_BD65B60)		+= leds-bd65b60.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
 obj-$(CONFIG_LEDS_COBALT_QUBE)		+= leds-cobalt-qube.o
diff --git a/drivers/leds/leds-bd65b60.c b/drivers/leds/leds-bd65b60.c
new file mode 100644
index 000000000000..9843e20369d3
--- /dev/null
+++ b/drivers/leds/leds-bd65b60.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Simple driver for ROHM Semiconductor BD65B60GWL Backlight driver chip
+ *
+ * Copyright (C) 2014 ROHM Semiconductor.com
+ * Copyright (C) 2014 MMI
+ * Copyright (C) 2023 Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define BD65B60_MAX_BRIGHTNESS 255
+#define BD65B60_DEFAULT_BRIGHTNESS 255
+#define BD65B60_DEFAULT_TRIGGER "bkl-trigger"
+#define BD65B60_DEFAULT_NAME "white"
+#define BD65B60_DEFAULT_OVP_VAL BD65B60_35V_OVP
+
+#define INT_DEBOUNCE_MSEC 10
+
+#define PWMEN_MASK 0x20
+#define OVP_MASK 0x18
+#define LEDSEL_MASK 0x05
+
+enum bd65b60_regs {
+	REG_SFTRST = 0x00,
+	REG_COMSET1 = 0x01,
+	REG_COMSET2 = 0x02,
+	REG_LEDSEL = 0x03,
+	REG_ILED = 0x05,
+	REG_CTRLSET = 0x07,
+	REG_SLEWSET = 0x08,
+	REG_PON = 0x0E,
+	REG_MAX = REG_PON,
+};
+
+enum bd65b60_ovp {
+	BD65B60_25V_OVP = 0x00,
+	BD65B60_30V_OVP = 0x08,
+	BD65B60_35V_OVP = 0x10,
+};
+
+enum bd65b60_ledsel {
+	BD65B60_DISABLE = 0x00,
+	BD65B60_LED1SEL = 0x01,
+	BD65B60_LED2SEL = 0x04,
+	BD65B60_LED12SEL = 0x05,
+};
+
+enum bd65b60_pwm_ctrl {
+	BD65B60_PWM_DISABLE = 0x00,
+	BD65B60_PWM_ENABLE = 0x20,
+};
+
+enum bd65b60_state {
+	BD65B60_OFF = 0,
+	BD65B60_ON = 1,
+	BD65B60_KEEP = 2,
+};
+
+struct bd65b60_led {
+	struct led_classdev cdev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct mutex lock; /* Held when writing to registers */
+	enum bd65b60_ledsel enable;
+	enum bd65b60_state state;
+	enum bd65b60_ovp ovp;
+};
+
+static const struct regmap_config bd65b60_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+};
+
+static void bd65b60_brightness_set(struct led_classdev *cdev,
+				   enum led_brightness brightness)
+{
+	int ret;
+	enum bd65b60_state new_state;
+	struct bd65b60_led *led = container_of(cdev, struct bd65b60_led, cdev);
+
+	mutex_lock(&led->lock);
+
+	ret = regmap_write(led->regmap, REG_ILED, brightness);
+
+	new_state = (brightness) ? BD65B60_ON : BD65B60_OFF;
+
+	if (new_state != led->state) {
+		ret |= regmap_write(led->regmap, REG_PON, new_state);
+		led->state = new_state;
+	}
+
+	mutex_unlock(&led->lock);
+
+	if (ret)
+		dev_err(&led->client->dev, "Failed to set brightness: %d", ret);
+}
+
+static int bd65b60_init(struct bd65b60_led *led)
+{
+	int ret;
+
+	mutex_lock(&led->lock);
+
+	if (led->state != BD65B60_KEEP) {
+		/* Reset the chip */
+		ret = regmap_write(led->regmap, REG_SFTRST, 0x01);
+	}
+
+	ret |= regmap_update_bits(led->regmap, REG_COMSET1, OVP_MASK, led->ovp);
+	ret |= regmap_update_bits(led->regmap, REG_LEDSEL, LEDSEL_MASK,
+				  led->enable);
+	ret |= regmap_update_bits(led->regmap, REG_CTRLSET, PWMEN_MASK,
+				  BD65B60_PWM_ENABLE);
+	ret |= regmap_write(led->regmap, REG_PON,
+			    led->state ? BD65B60_ON : BD65B60_OFF);
+
+	mutex_unlock(&led->lock);
+
+	return ret;
+}
+
+static int bd65b60_parse_dt(struct bd65b60_led *led,
+			    struct fwnode_handle **fwnode)
+{
+	struct device *dev = &led->client->dev;
+	struct fwnode_handle *child = NULL;
+	char default_state[] = "keep";
+	int ret;
+
+	child = device_get_next_child_node(dev, child);
+	if (!child) {
+		dev_err(dev, "No led child node found");
+		return -ENODEV;
+	}
+
+	/* Check required properties */
+	if (!fwnode_property_present(child, "rohm,enable-outputs")) {
+		dev_err(dev, "No rohm,enable-outputs property found");
+		return -ENOENT;
+	}
+
+	ret = fwnode_property_read_u32(child, "rohm,enable-outputs", &led->enable);
+	if (ret || (led->enable & LEDSEL_MASK) != led->enable) {
+		dev_err(dev, "Failed to read rohm,enable-outputs property");
+		return ret;
+	}
+
+	/* Check optional properties */
+	led->state = BD65B60_OFF;
+	if (!fwnode_property_present(child, "default-state")) {
+		ret = fwnode_property_read_string(child, "default-state",
+						(const char **)&default_state);
+		if (ret) {
+			dev_err(dev, "Failed to read default-state property");
+			return ret;
+		}
+
+		if (strcmp(default_state, "keep") == 0) {
+			led->state = BD65B60_KEEP;
+		} else if (strcmp(default_state, "on") == 0) {
+			led->state = BD65B60_ON;
+		} else if (strcmp(default_state, "off") == 0) {
+			led->state = BD65B60_OFF;
+		} else {
+			dev_err(dev, "Invalid default-state property");
+			return -EINVAL;
+		}
+	}
+
+	led->ovp = BD65B60_DEFAULT_OVP_VAL;
+	if (fwnode_property_present(child, "rohm,ovp")) {
+		ret = fwnode_property_read_u32(child, "rohm,ovp", &led->ovp);
+
+		if (ret || (led->ovp & OVP_MASK) != led->ovp) {
+			dev_err(dev, "Failed to read rohm,ovp property");
+			return ret;
+		}
+	}
+
+	*fwnode = child;
+
+	return 0;
+}
+
+static int bd65b60_probe(struct i2c_client *client)
+{
+	struct bd65b60_led *led;
+	struct led_init_data init_data = {};
+	struct fwnode_handle *fwnode = NULL;
+	int ret;
+
+	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	led->client = client;
+	i2c_set_clientdata(client, led);
+
+	ret = bd65b60_parse_dt(led, &fwnode);
+	if (ret)
+		return ret;
+
+	led->cdev.name = BD65B60_DEFAULT_NAME;
+	led->cdev.brightness_set = bd65b60_brightness_set;
+	led->cdev.brightness = BD65B60_DEFAULT_BRIGHTNESS;
+	led->cdev.max_brightness = BD65B60_MAX_BRIGHTNESS;
+	led->cdev.default_trigger = BD65B60_DEFAULT_TRIGGER;
+	led->client = client;
+
+	led->regmap = devm_regmap_init_i2c(client, &bd65b60_regmap_config);
+	if (IS_ERR(led->regmap)) {
+		ret = PTR_ERR(led->regmap);
+		dev_err(&client->dev, "Failed to allocate register map: %d",
+			ret);
+		return ret;
+	}
+
+	mutex_init(&led->lock);
+
+	ret = bd65b60_init(led);
+	if (ret) {
+		dev_err(&client->dev, "Failed to initialize led: %d", ret);
+		mutex_destroy(&led->lock);
+		return ret;
+	}
+
+	init_data.fwnode = fwnode;
+	init_data.devicename = led->client->name;
+	init_data.default_label = ":";
+	ret = devm_led_classdev_register_ext(&client->dev, &led->cdev,
+					     &init_data);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register led: %d", ret);
+		mutex_destroy(&led->lock);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void bd65b60_remove(struct i2c_client *client)
+{
+	int ret;
+	struct bd65b60_led *led = i2c_get_clientdata(client);
+
+	ret = regmap_write(led->regmap, REG_PON, BD65B60_OFF);
+	if (ret)
+		dev_err(&client->dev, "Failed to turn off led: %d", ret);
+
+	mutex_destroy(&led->lock);
+}
+
+static const struct i2c_device_id bd65b60_id[] = {
+	{ "bd65b60", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, bd65b60_id);
+
+static const struct of_device_id of_bd65b60_leds_match[] = {
+	{ .compatible = "rohm,bd65b60" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_bd65b60_leds_match);
+
+static struct i2c_driver bd65b60_i2c_driver = {
+	.driver = {
+		.name = "bd65b60",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(of_bd65b60_leds_match),
+		  },
+	.probe_new = bd65b60_probe,
+	.remove = bd65b60_remove,
+	.id_table = bd65b60_id,
+};
+
+module_i2c_driver(bd65b60_i2c_driver);
+
+MODULE_AUTHOR("Bogdan Ionescu <bogdan.ionescu.work+kernel@gmail.com>");
+MODULE_DESCRIPTION("ROHM Semiconductor led driver for bd65b60");
+MODULE_LICENSE("GPL");
-- 
2.39.2

