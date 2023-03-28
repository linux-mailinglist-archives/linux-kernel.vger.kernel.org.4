Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867D6CBB68
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjC1Joj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjC1JoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:44:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604C5FF9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:44:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso6972680wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679996660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAnQ4iWFnpxhElk3CKI/cTE9tr6I3d66/Wl67iHg3Ys=;
        b=Ug/VoW5sKOVru0xLzejQSX1BHNbzs/AnqDTzUFKDlkzoljVi4gP10JGlUzqYdbVIl8
         +z/iZjzQUTUVSQKAY6A0+plIHcgpBqqUXbIa6IOBSfiH+fpZPXNQZ52dAaRXBq/imigK
         Wx3W0gQV576ZGckmvZbrVEHyuYk7/Ts2fqepkS73UXFrXgBFB3fevq7DZQ0hdZ8GO9hf
         CTl6yXc/jsubYKsjtamLolNQ9ObkqZXrDhf9Hn29ySwr/4QKONukEcxBM32zKjlQI6AC
         Ugwz05l3fC2ggDymVEFVqEz71z1ZTui6ug7GOulwwpYAoXgrb5erNUYxalpK07Z95xpo
         UeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAnQ4iWFnpxhElk3CKI/cTE9tr6I3d66/Wl67iHg3Ys=;
        b=yjhWOTz8RWWUd7UuR4cDuCjRLfqOdEvWai4ZiFlOkPZhs+gsgzxtKzod+mSgmfweh4
         H18At1M9IulvgVKUVWWMsBitLeIrxjpr55O8nhfqnIvze9nhPhGJdIPwN+DQUhiGHODj
         J8WwBhSQ8wE4xWcuVyEzjWc2b98JE5m9ZSLK2+pcCOaj75jJgl8SZCspEOcXRKQtIr5M
         QfKYjtvCPzhpB1G4tPJWaixSU0lRxVZYdTR6kYgnTAhDCFaM27ZOV1GvsMwc5aswmIHG
         PbCL8/8P8FNkv/hAL6MqY7G7NU7BixbHrzd4N5P/W/fMUmXdX5wIKavdwyumS5B2faVe
         gn1Q==
X-Gm-Message-State: AAQBX9d5uVRm9513tdg90Lx5+y0dK7GyHXLJkg+Tn3CT520bM1uNbmjM
        +gQqXDdy0Ev00GKOp2ZlJ2QfYZFG+tHQ0FBIm/PPdA==
X-Google-Smtp-Source: AKy350Y8/UJMO3U7Xk4DHzn6rGEiZMZ+t2q0HBClC7JERZ9gAgCi1sX3sBD2/OZ4SqBMwh/8BTik2A==
X-Received: by 2002:a7b:ce85:0:b0:3ef:6eeb:c25a with SMTP id q5-20020a7bce85000000b003ef6eebc25amr4719512wmj.6.1679996660210;
        Tue, 28 Mar 2023 02:44:20 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b003ef7058ea02sm5387953wmg.29.2023.03.28.02.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:44:20 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v3 2/2] leds: max597x: Add support for max597x
Date:   Tue, 28 Mar 2023 11:44:15 +0200
Message-Id: <20230328094416.3851801-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x is hot swap controller with indicator LED support.
This driver uses DT property to configure led during boot time &
also provide the LED control in sysfs.

DTS example:
    i2c {
        #address-cells = <1>;
        #size-cells = <0>;
        regulator@3a {
            compatible = "maxim,max5978";
            reg = <0x3a>;
            vss1-supply = <&p3v3>;

            regulators {
                sw0_ref_0: sw0 {
                    shunt-resistor-micro-ohms = <12000>;
                };
            };

            leds {
                #address-cells = <1>;
                #size-cells = <0>;
                led@0 {
                    reg = <0>;
                    label = "led0";
                    default-state = "on";
                };
                led@1 {
                    reg = <1>;
                    label = "led1";
                    default-state = "on";
                };
            };
        };
    };

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V3:
- Remove of_node_put as its handled by for loop
- Print error if an LED fails to register.
- Update driver name in Kconfig description
- Remove unneeded variable assignment
- Use devm_led_classdev_register to reget led
Changes in V2:
- Fix regmap update
- Remove devm_kfree
- Remove default-state
- Add example dts in commit message
- Fix whitespace in Kconfig
- Fix comment
---
 drivers/leds/Kconfig        |  11 ++++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max597x.c | 112 ++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/leds/leds-max597x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9dbce09eabac..60004cb8c257 100644
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
+	  This option enables support for the Maxim MAX5970 & MAX5978 smart
+	  switch indication LEDs via the I2C bus.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-max597x.
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
index 000000000000..83e4dfb617fb
--- /dev/null
+++ b/drivers/leds/leds-max597x.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for leds in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/leds.h>
+#include <linux/mfd/max597x.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
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
+	int ret, val = 0;
+
+	if (!led || !led->regmap)
+		return -ENODEV;
+
+	val = !brightness ? BIT(led->index) : 0;
+	ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH, BIT(led->index), val);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d\n", ret);
+	return ret;
+}
+
+static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
+			     u32 reg)
+{
+	struct max597x_led *led;
+	int ret;
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
+	ret = devm_led_classdev_register(dev, &led->led);
+	if (ret)
+		dev_err(dev, "Error in initializing led %s", led->led.name);
+
+	return ret;
+}
+
+static int max597x_led_probe(struct platform_device *pdev)
+{
+	struct device_node *np = dev_of_node(pdev->dev.parent);
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
+			dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
+				MAX597X_NUM_LEDS);
+			continue;
+		}
+
+		ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
+		if (ret < 0)
+			dev_err(&pdev->dev, "Failed to initialize LED %u\n", reg);
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

