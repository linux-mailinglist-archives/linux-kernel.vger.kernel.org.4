Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583A26C4AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjCVMnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCVMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:43:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DC1C7F0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:43:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l12so16912894wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679489014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQSenOUiD7nYUwUp9rD2KgxkJq4J/MWYT3r0jjHaGE0=;
        b=HIQa7TN6fSVEE63djYOFjAfUtrRgAtzbbkC6bq9M08YRoF3efiV9QBBqrFjtBZBrE2
         H3ApLDFK+ei/QQcnc8kQkzPtGwoAnGpDxBM97pnpNI2dj1ObgaAqI8j26R0Xt92ICYlT
         qTJfT41W2xdrkgNgF4K1Tr3N8sZ/sz1wVUrS/xqiJROXIGx5+sKX1+IpQkyLiim1YDfF
         vY2hJx1IiW5ajiY+/+QAzg6ilGYY1ORmOLSMNLZLXsAjK6Pn+hC+gpL0we16yZVPqavP
         n/YwnScPz9FBVP6ZmSTTvqJJMBmd04iuszah6RXpmsYN9tvRzzwI8m7ldq4DyKUYS5FZ
         cKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679489014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQSenOUiD7nYUwUp9rD2KgxkJq4J/MWYT3r0jjHaGE0=;
        b=G5Hy5wunukRz7t+cokhrdECONePLCEBRalXWPb5SxLHg5zB++biDP8Z6IO/CgUGoSb
         5C0lGidD8k8R4riul2MN6OyIInW8pg3qT4m9eNB8CVnIH6tMAOclI4VcXQ7BgKxbdh2O
         5ePLNyteF3fdUxjgdrMoazQmwdiuMK+u+mGOHC0w/bCG2P+NOsMVV8frmJa2/jwc5PKR
         bTX4VUAPnwpKflGtCsiwqPXvTiJxP4aCJ7YljBIjhnahKLGaV4JwPFVpvLjY+5useEoO
         hCxzgwWCLUyNdpT5zDnpPaxolQcR+zUHyUQz8pW5aDJ/kiFNIy/0WXhnMvKaARU0nTCk
         Crwg==
X-Gm-Message-State: AO0yUKV1l9pF/sfiAAXTXMvharParhvPlOc/OaZs5U8MbHUWdkydHDLF
        d4iq0odCCAQpYFM5tlCmylQYXw==
X-Google-Smtp-Source: AK7set8rIwqsQyRKXcEj0zV2tf29uJWv5uJwBB4TgPlHs8ucdzxkVlfFIYIOvCqQ8LHWU4Fy8E77Kg==
X-Received: by 2002:a5d:690f:0:b0:2cf:e3d5:34db with SMTP id t15-20020a5d690f000000b002cfe3d534dbmr5666917wru.36.1679489014286;
        Wed, 22 Mar 2023 05:43:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id c15-20020adfef4f000000b002c7066a6f77sm13748526wrp.31.2023.03.22.05.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:43:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH 2/2] leds: max597x: Add support for max597x
Date:   Wed, 22 Mar 2023 13:43:16 +0100
Message-Id: <20230322124316.2147143-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
References: <20230322124316.2147143-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x is hot swap controller with indication led support.
This driver uses DT property to configure led during boot time &
also provide the led control in sysfs.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/leds/Kconfig        |  11 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max597x.c | 132 ++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/leds/leds-max597x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9dbce09eabac..ba184a3f736e 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -590,6 +590,17 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MAX597X
+	tristate "LED Support for Maxim 597x"
+	depends on LEDS_CLASS
+	depends on MFD_MAX597X
+	help
+	  This option enables support for the Maxim 597x smart switch indication LEDs
+	   via the I2C bus.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called max597x-led.
+
 config LEDS_MC13783
 	tristate "LED Support for MC13XXX PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d30395d11fd8..da1192e40268 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
 obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
 obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
+obj-$(CONFIG_LEDS_MAX597X)		+= leds-max597x.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
new file mode 100644
index 000000000000..e2844202a35b
--- /dev/null
+++ b/drivers/leds/leds-max597x.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max597x.h>
+#include <linux/regmap.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+#define ldev_to_maxled(c)       container_of(c, struct max597x_led, led)
+
+struct max597x_led {
+	struct regmap *regmap;
+	struct led_classdev led;
+	unsigned int index;
+};
+
+static int max597x_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct max597x_led *led = ldev_to_maxled(cdev);
+	int ret;
+
+	if (!led || !led->regmap)
+		return -ENODEV;
+
+	ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH,
+				 1 << led->index, ~brightness << led->index);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d\n", ret);
+	return ret;
+}
+
+static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
+			     u32 reg)
+{
+	struct max597x_led *led;
+	const char *state;
+	int ret = 0;
+
+	led = devm_kzalloc(dev, sizeof(struct max597x_led),
+			   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	if (of_property_read_string(nc, "label", &led->led.name))
+		led->led.name = nc->name;
+
+	led->led.max_brightness = 1;
+	led->led.brightness_set_blocking = max597x_led_set_brightness;
+	led->led.default_trigger = "none";
+	led->index = reg;
+	led->regmap = regmap;
+	ret = led_classdev_register(dev, &led->led);
+	if (ret) {
+		dev_err(dev, "Error in initializing led %s", led->led.name);
+		devm_kfree(dev, led);
+		return ret;
+	}
+
+	if (!of_property_read_string(nc, "default-state", &state)) {
+		if (!strcmp(state, "on")) {
+			led->led.brightness = 1;
+			led_set_brightness(&led->led, led->led.brightness);
+		}
+	}
+	return 0;
+}
+
+static int max597x_led_probe(struct platform_device *pdev)
+{
+	struct device_node *np = dev_of_node(pdev->dev.parent);
+	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct device_node *led_node;
+	struct device_node *child;
+	int ret = 0;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	led_node = of_get_child_by_name(np, "leds");
+	if (!led_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(led_node, child) {
+		u32 reg;
+
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg >= MAX597X_NUM_LEDS) {
+			dev_err(&i2c->dev, "invalid LED (%u >= %d)\n", reg,
+				MAX597X_NUM_LEDS);
+			continue;
+		}
+
+		ret = max597x_setup_led(&i2c->dev, regmap, child, reg);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static struct platform_driver max597x_led_driver = {
+	.driver = {
+		.name = "max597x-led",
+	},
+	.probe = max597x_led_probe,
+};
+
+module_platform_driver(max597x_led_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

