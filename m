Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868546E9B50
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDTSK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 14:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjDTSKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:10:53 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686130F7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:10:51 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e13-20020a05600c4e4d00b003f18e479d9aso742555wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682014250; x=1684606250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EN4wCZ9lkq1KnrA6HkR+5KfkKCmTmfRZgBHM2t8UIZA=;
        b=GzWJ7JXjs+y1FrFizQuoL8MZmH2Ob5rX+5n6oL/MGV8BMx0bXrh0cFIk4QYhnclA8N
         zLRolQlz3gjpmHJkLRPBQThFPBqBeIhnZdU2O/8DolDn2NY8Ue8Gw7VX5f8fHQmfVcMS
         SHm7flAMFwoQ1HO5Z1vAHYfzB2bckLlC26w8YlpyXihzqQ3P8q8oD+72teYl0iPcXfKc
         HQQ9JGZXKoFeJI5qf8GH6IdL4NAILnG040HzvEeLwaXElp2+sAwKOVzFFAzqMRg3udZh
         A2eHMvvmUFkyJ0EjDs9LRAAiJNMfYoa7CfrcHlcGkFgrwYoezkVIrUyBnPQfdkeYpXEJ
         xFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682014250; x=1684606250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EN4wCZ9lkq1KnrA6HkR+5KfkKCmTmfRZgBHM2t8UIZA=;
        b=c6KalueVYNJ0Jjk/gooVBMlvhi/xThke7Ydz9XVFpXSbz1BPwPFE8OxWThzYAhbmnb
         lqeJhR+ful30KyRe/hKq1GYalAX3z5FN+x6f7TlGa7M2miZutBRRJTfm/35OQCfSiBNW
         Fwy5siMwE7q7FQqnVTQd4H8uVtRjNJOekcF1P3qgVmkUZJC02eCrwMLqrKHnD5B97IEq
         lZnZXjgPgmkr7vIevKJ0Im81GvWp5b3fiHYWkbVgzD9ckcXfSFg3jQkbaAc3gYHZTsMa
         8aZk4ycc3/NmwA82Z43+NghLTugtF7mwfPJ0esomVUk91wHz6SNs4lEAxSmx26mWvGbu
         3F3w==
X-Gm-Message-State: AAQBX9ehNS1k1ly1E+hLE6QgrcNNsmKJP0UQ4ZCMXNALHVhK5+iAyVzR
        WdqR1mYUBsiSzBJgYdXcuHUcPQ==
X-Google-Smtp-Source: AKy350YrQyP8uEtvQxSbmpXuI4pxTLko412mhNHqG9366balvbwHOc8YG9kk6QxOXLFbmIP2AZm3Gg==
X-Received: by 2002:a1c:e917:0:b0:3f1:727d:77a4 with SMTP id q23-20020a1ce917000000b003f1727d77a4mr1886970wmc.39.1682014250156;
        Thu, 20 Apr 2023 11:10:50 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003ee74c25f12sm6155490wmq.35.2023.04.20.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 11:10:49 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v6] leds: max597x: Add support for max597x
Date:   Thu, 20 Apr 2023 20:10:42 +0200
Message-Id: <20230420181042.3553335-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
        };

        leds {
            #address-cells = <1>;
            #size-cells = <0>;
            led@0 {
                reg = <0>;
                label = "ssd0:green";
                default-state = "on";
            };
            led@1 {
                reg = <1>;
                label = "ssd1:green";
                default-state = "on";
            };
        };
    };

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Change in V6:
- Improve error handling in case of failure in LED setup
Changes in V5:
- Update commit message
- Fix comments
- Add necessary new line
Changes in V4:
- Remove unwanted preinitialise
- Remove unneeded line breaks
- Fix variable name to avoid confusion
- Update module description to mention LED driver.
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
 drivers/leds/Kconfig        |  11 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max597x.c | 133 ++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
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
index 000000000000..8ba710d20bff
--- /dev/null
+++ b/drivers/leds/leds-max597x.c
@@ -0,0 +1,133 @@
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
+#define ldev_to_maxled(c)       container_of(c, struct max597x_led, cdev)
+
+struct max597x_led {
+	struct device *dev;
+	struct regmap *regmap;
+	struct led_classdev cdev;
+	unsigned int index;
+};
+
+static int max597x_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct max597x_led *ddata = ldev_to_maxled(cdev);
+	int ret, val;
+
+	if (!ddata->regmap)
+		return -ENODEV;
+
+	/* Set/clear corresponding bit for given led index */
+	val = !brightness ? BIT(ddata->index) : 0;
+
+	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d", ret);
+
+	return ret;
+}
+
+static int max597x_setup_led(struct max597x_led *ddata, struct regmap *regmap,
+			     struct device_node *nc, u32 reg)
+{
+	int ret;
+
+	if (of_property_read_string(nc, "label", &ddata->cdev.name))
+		ddata->cdev.name = nc->name;
+
+	ddata->cdev.max_brightness = 1;
+	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
+	ddata->cdev.default_trigger = "none";
+
+	ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);
+	if (ret)
+		dev_err(ddata->dev, "Error initializing LED %s", ddata->cdev.name);
+
+	return ret;
+}
+
+static int max597x_led_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev->parent);
+	struct regmap *regmap;
+	struct device_node *led_node;
+	struct device_node *child;
+	struct max597x_led *ddata[MAX597X_NUM_LEDS];
+	int ret = 0, i = 0;
+	bool leds_found = false;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
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
+			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX597X_NUM_LEDS);
+			continue;
+		}
+
+		ddata[i] = devm_kzalloc(dev, sizeof(struct max597x_led), GFP_KERNEL);
+		if (!ddata[i]) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		ddata[i]->index = reg;
+		ddata[i]->regmap = regmap;
+		ddata[i]->dev = dev;
+
+		ret = max597x_setup_led(ddata[i], regmap, child, reg);
+		if (ret < 0) {
+			dev_err(dev, "Failed to initialize LED %u\n", reg);
+			goto exit;
+		}
+		i++;
+		leds_found = true;
+	}
+
+	if (!leds_found)
+		return -ENODEV;
+
+exit:
+	if (ret < 0)
+		for (int j = 0; j < i; j++)
+			devm_led_classdev_unregister(dev, &ddata[j]->cdev);
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
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
+MODULE_LICENSE("GPL");

base-commit: 9d8d0d98885abba451d7ffc4885236d14ead3c9a
-- 
2.39.1

