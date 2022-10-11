Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78C5FB6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJKPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 11:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiJKPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 11:12:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB81837C;
        Tue, 11 Oct 2022 08:04:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f23so13448128plr.6;
        Tue, 11 Oct 2022 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C10Q4XJneMGMJhEDiSg76fw0Q/8SVw0hSNkjyfh8gjo=;
        b=FDv6Sw3QbdaR48PUvn5ClpNnOsnr5JzTdCyRcqrWQWRZvFio7oJJL9BLmZPGTkT+ZZ
         vBuRDVfMqkr64IeGa++mXyWZLV+qzSOjzoMgiMbsO55dLceB2MJBg8YYCsC2Z+p50xW8
         OcfnQOihOoT5lqhBf2ZJhxtbfbAK45nuIH0syzzKspdlG23b7aDnqdXV+pEMFd6A68pZ
         BmFtbIr2b/CZp1atvdih85yI90FwYLqtMfh2Toojd9gkFSu/C1RCqTQmOMvv9McHwU8Z
         aEA64oenBtMJ9PmQVCIXlm9ZplnOPy/iye4/ynqZuXH1i62Lfa5gVrQbfsx39Al9pLOU
         sk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C10Q4XJneMGMJhEDiSg76fw0Q/8SVw0hSNkjyfh8gjo=;
        b=U3JbilSW2xhA2dTHNnBeT3bDiOS6Fz/Y8Rr4bKHuz6BaE53h3zuyCiNUZSw2hT/RBE
         issHXXrHmpOUJjxRMhSw9vrzmWYaS77JIOy/ip3j3KogiNtcSGhbP4a5hxD1fs+73Xcb
         ai4ZB24e0D8ogY4SjG4dUReeZrj/kVugzEoqHrZPo0GMn0L26mqEtUduLmkXDXvCX2bl
         YRath0mwh9NTkMzMkFGQA0+dMo8S4o7uwEOYYR5VdVW7LisHgyLQYQ1SCfq5iKGboUbl
         XFo2Ab7nHkqCEQr7TTdOKnavfZVQ/0gQ6R+xvCbx8JYvV6VkXWHNTW4USmp5uO5U69pg
         ZrBA==
X-Gm-Message-State: ACrzQf2gg+uEaMEe+nM3q49g4BsJnaZ25YezD8YuSsTBGKvZFFVAZh3D
        +534U8JvHl/P0p4UsIRFVw==
X-Google-Smtp-Source: AMsMyM6tSYy8+lK7jPryvatWeeUC+1QTtXbegtQtSZVaFdwGDpyDNqGt3xzPA7lkfvJSmEXk7a8QgQ==
X-Received: by 2002:a17:90b:4a4b:b0:20c:705a:9899 with SMTP id lb11-20020a17090b4a4b00b0020c705a9899mr21809607pjb.133.1665500505006;
        Tue, 11 Oct 2022 08:01:45 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id b5-20020a1709027e0500b001754064ac31sm8746695plm.280.2022.10.11.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:01:44 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH v3 2/2] leds: Add support for UP board CPLD onboard LEDS
Date:   Tue, 11 Oct 2022 23:01:00 +0800
Message-Id: <20221011150100.10195-3-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011150100.10195-1-larry.lai@yunjingtech.com>
References: <20221011150100.10195-1-larry.lai@yunjingtech.com>
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
 drivers/leds/Kconfig        | 11 ++++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 78 +++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 499d0f215a8b..ae35a4c7e1e6 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -872,6 +872,17 @@ source "drivers/leds/flash/Kconfig"
 comment "RGB LED drivers"
 source "drivers/leds/rgb/Kconfig"
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP board"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD_FPGA
+	depends on X86
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

