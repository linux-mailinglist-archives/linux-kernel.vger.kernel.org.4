Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434475F73F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJGF2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJGF23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:28:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E26112ABE;
        Thu,  6 Oct 2022 22:28:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so4005379pfh.6;
        Thu, 06 Oct 2022 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=thpcfEjkT6M3Cbh0jMprMM++zM74T/WSw+KO6E7QZfI=;
        b=LTLotsrqQ2qF/sXGSK6TJc78Hy1yiwmf6pRPUuSSkYY5WFOsBaUFlxEgEq+SYEiuab
         egwmVz8eZJj05RP1tv6+nYgfdag0PtQ/z5PX8bFZ7U3wipPaQajcwg3nDILFud5bl38E
         1GyhI9TfrTeo9/hdPx4hIGI2J6+04CPBlg5PYML2gqEA4SytIxgjAk0waedyiXwXZbSW
         AXvE2P5R4pbGMv0YotmMRPqqP1CzMOVYf3PrO1YWJqlNQ6HCJZXQbUTJCy/RZk7uuoaB
         DeTywHb7Zp3B69IYFS57fcQLtkUbihxZICal7sQ1k/DxQPoJzw04qwySlwBPl1xm8alV
         h4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thpcfEjkT6M3Cbh0jMprMM++zM74T/WSw+KO6E7QZfI=;
        b=BSj1LG0CqywLxDqmbmOzc+/+lva9HcP11SpGbv7xmX6CPk80Cd1pIqJNsjEDyDu7Df
         LvRQSJx3Bjfo6IsAOgKcGng3pYXY1KsAR+4Rj4SlHvZ74Y/WwFlUbz+lINFAKj1fahZ2
         GnEe/6+TZN5BsELP+j/Kpff6KxOyZ+Lvbwsb1fKygOhXgCBg1mELbfCKguzKI3hoGAna
         WeyZZDxd5H7b/6nuwJbn2dEB9OGyXWNDKJfWUycFzkIXh64BnJV5qi5YWPNCdw+9DJ7u
         cZuiBY1mfklXpzpjHTZ/iWN5A0eQ0q0zlMexjwf+Ml3wAti3pJt2C4H17yR53IKWJTZK
         dQJg==
X-Gm-Message-State: ACrzQf2WUkQlSRmgyIbE+MxZvK2/jqc4xkDjEVU7HC9A8upNTfLo5yH6
        8h7bbqMEvf0fOjoqIvUFbQ==
X-Google-Smtp-Source: AMsMyM75g+l0cB8G8yFdl9SOfT+lBxZly/DZD7cuEs6EYFKpkOCkVZ2eDaqWBPjti3iul/NjQBsoHQ==
X-Received: by 2002:a63:90c8:0:b0:458:b70b:b16d with SMTP id a191-20020a6390c8000000b00458b70bb16dmr3058112pge.366.1665120507073;
        Thu, 06 Oct 2022 22:28:27 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902860c00b00176c0e055f8sm579480plo.64.2022.10.06.22.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 22:28:26 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH v2 2/2] leds: Add support for UP board CPLD onboard LEDS
Date:   Fri,  7 Oct 2022 13:25:30 +0800
Message-Id: <20221007052530.31621-3-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221007052530.31621-1-larry.lai@yunjingtech.com>
References: <20221007052530.31621-1-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP boards come with a few FPGA-controlled onboard LEDs:
* UP Board: yellow, green, red
* UP Squared: blue, yellow, green, red

this patch depends on patch "mfd: Add support for UP board CPLD/FPGA"

Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 drivers/leds/Kconfig        | 10 +++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..80b9c394c5b6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,16 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD_FPGA
+	help
+	  This option enables support for the UP board LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..e72956645646 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_LEDS_TI_LMU_COMMON)	+= leds-ti-lmu-common.o
 obj-$(CONFIG_LEDS_TLC591XX)		+= leds-tlc591xx.o
 obj-$(CONFIG_LEDS_TPS6105X)		+= leds-tps6105x.o
 obj-$(CONFIG_LEDS_TURRIS_OMNIA)		+= leds-turris-omnia.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 obj-$(CONFIG_LEDS_WM831X_STATUS)	+= leds-wm831x-status.o
 obj-$(CONFIG_LEDS_WM8350)		+= leds-wm8350.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 000000000000..214325442f3b
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UP Board FPGA-based LED driver
+ *
+ * Copyright (c) 2017, Emutex Ltd. All rights reserved.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/upboard-fpga.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_led {
+	struct led_classdev cdev;
+	struct regmap_field *field;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+};
+
+static void upboard_led_brightness_set(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+
+	regmap_field_write(led->field, brightness != LED_OFF);
+};
+
+static int __init upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_fpga * const up_fpga = dev_get_drvdata(pdev->dev.parent);
+	struct reg_field fldconf = {
+		.reg = UPFPGA_REG_FUNC_EN0,
+	};
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard_led *led;
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	fldconf.lsb = pdata->bit;
+	fldconf.msb = pdata->bit;
+	led->field = devm_regmap_field_alloc(&pdev->dev, up_fpga->regmap, fldconf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:",
+					pdata->colour);
+	if (!led->cdev.name)
+		return -ENOMEM;
+
+	return devm_led_classdev_register(&pdev->dev, &led->cdev);
+};
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:upboard-led");
-- 
2.17.1

