Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BF6E0B61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDMK0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDMK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:26:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC19319A3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:26:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so7733134wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1681381587; x=1683973587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KDoTnfAPlRpqj9SVoAm5XkfAd7cBOc+KN2V9nzTfi7U=;
        b=WpmoMmP6omfYtz0mpP8foZEOC0LazqvAJaHLmfCtRSAHUKDtUa//oK5DsjN2JIT/W5
         95Ig7TlPcDsgiblYuSI2T1pGivEduJKz3qZ4P5XfyJzxndekrcIH1CkMHO0Mfr1oxlLX
         lX0isxo9TSiHPFwcWDDTskf77pkBYV2U7OifEEkX0BPINNMv+CPOGIeraVH74NSPNbPz
         7LZWqcJ7jUhsHdrGPgkqXQVMRhGZLet25k0OQACfknlFzkg2gZqnPcXZj4LI3t3aoL6J
         kyUvpXFa2I8fvnyA5rMj6dQy5skEPGkvTiNF0VFn42OnfnVrzNt2BXYSz4a6FRt4Rj1A
         q0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681381587; x=1683973587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDoTnfAPlRpqj9SVoAm5XkfAd7cBOc+KN2V9nzTfi7U=;
        b=kFdYnGWA+qBfdjPCOmfbNmy8qh6hZXhzQ0CQCcInlAypoMZuSLlMA7gCw4CDh/C7EW
         BC1/VLiWwDrfAD+EezXA38NeDDGhK/65CFg4lc088xsIAR5IjqQSDm062m7XrbrYQ6ro
         BrOqICW5kelOQHlACw2X3jq5KB3LIZmkYXdjbf7hVPr9tDi5WNiSh/vtrF0UWEAAEGUe
         BuFR6CODYTiY6ezkSydNoiIuhXr79IObBB3THx6n81oWVEZ6dm/orkdRhynta1e7JDC5
         UOMIu8359laPfE5wm6O3CdgaPUC1uTovDmMmlgyrlnlL8Vl+JHOpd7ev23zn2cmR6LQF
         F6Mw==
X-Gm-Message-State: AAQBX9dp2KAYBy8pwXoe1HIQ8bdrudfuaz7hia2PxzjCUhBHvq1gQzRK
        DtlJKdoMtKC+u7b/rO3Y0sbH9w==
X-Google-Smtp-Source: AKy350ZRW2tsRDshWcYK17C407S/zMegRhx3B/kgDnrMme1klwI16DO4YDeCUxZkt3ratZA/9Enh9g==
X-Received: by 2002:a7b:c309:0:b0:3f0:967e:2cfb with SMTP id k9-20020a7bc309000000b003f0967e2cfbmr1516961wmj.36.1681381587182;
        Thu, 13 Apr 2023 03:26:27 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b003f0a1c18128sm2352260wmg.29.2023.04.13.03.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:26:26 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH v4] leds: max597x: Add support for max597x
Date:   Thu, 13 Apr 2023 12:26:23 +0200
Message-Id: <20230413102624.3561299-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 000000000000..8f34bbca7f21
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
+#define ldev_to_maxled(c)       container_of(c, struct max597x_led, cdev)
+
+struct max597x_led {
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
+	/* Set/Clear corresponding bit for given led index */
+	val = !brightness ? BIT(ddata->index) : 0;
+	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d", ret);
+	return ret;
+}
+
+static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
+			     u32 reg)
+{
+	struct max597x_led *ddata;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(struct max597x_led), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	if (of_property_read_string(nc, "label", &ddata->cdev.name))
+		ddata->cdev.name = nc->name;
+
+	ddata->cdev.max_brightness = 1;
+	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
+	ddata->cdev.default_trigger = "none";
+	ddata->index = reg;
+	ddata->regmap = regmap;
+	ret = devm_led_classdev_register(dev, &ddata->cdev);
+	if (ret)
+		dev_err(dev, "Error initializing LED %s", ddata->cdev.name);
+
+	return ret;
+}
+
+static int max597x_led_probe(struct platform_device *pdev)
+{
+	struct device_node *np = dev_of_node(pdev->dev.parent);
+	struct regmap *regmap;
+	struct device_node *led_node;
+	struct device_node *child;
+	int ret = 0;
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
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
+MODULE_LICENSE("GPL");

base-commit: 11e572d06c23d61683e20a98bd16f550ef17ac65
prerequisite-patch-id: 456044abe991b2ff3b521d337825432789d71b29
-- 
2.39.1

