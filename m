Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFBD6B5744
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCKBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCKBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:10:15 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54786EFB8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:10:14 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 32-20020a9d0323000000b0069426a71d79so3897169otv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pg/Y8NVSABbLKTXUhLPi9eY9pyjP+zU6j4r9Umj6pZE=;
        b=wNlqk2crlfmDE/+WKjF3sPjUDnrZnsI4AXVpg3LoQi7GQbBHgTgQOrgWBAQbaFNnb5
         5EuGdrkZFN2UnTvIwHy7i3AGLoxBIiW05MFxULOfVXldsGhqNtY0s6ZGEM8iembyIkD0
         noD96zWNkKk25QZ1FlAMz6B+31qBIUeyxlKxtpNSTbPHWpNtpWpuFoT5iAWe+aYAou+F
         v6nvEGvgZdLsfNZVaIiq3qiGAsP8AS6ztr1IJ1liVR9bDk5fSmAyzhGpTAPbvujABLy5
         meWDOC++e7cCztgwRVoOjh/wiUJIwR3cBa4pX+yuMVEKF2KWhg8imbIUQyjSyw5YsuxB
         SWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pg/Y8NVSABbLKTXUhLPi9eY9pyjP+zU6j4r9Umj6pZE=;
        b=wtpvd5fK0VClM8JhGvp7lXXUtEGA3VPQvZl87z9L++T0mRMcrNynpaNx2qdrjJqtBP
         TefY+xOBFmLbQJzNwxnkUR2GBboO+kRapZuqmsmaoYWMFhOmYU0z84JSEJy14EO/vzXz
         GApdK4bd7pbbOughWkVnJleS4slxeXbAXFs+UZabTSm8MlA6qCt+CUxd5CNdlkPUaf3J
         LUVxQKkzDazJoxDdHFjQ3OXuHU2EaBL5WX5O+4JlM12hsit+SNuv3BR5CTn6b6k13ebC
         nH+jA3HdqDIWFvB13+Cu3HyHFXqQKTFfobtJ0NLgZjKq81i06XrfSrEipzLx7tvWKEol
         14Jw==
X-Gm-Message-State: AO0yUKXGinMNdUtzbcHoQBTAzX6biSUp0u3SVmZk2mpcismG7oMRYZxS
        K5jUseZT/NYQ0bnrounJsR1grQ==
X-Google-Smtp-Source: AK7set8vmev8yFYppuYdUn+w5YeFXngvf6oc27bWwdibbGy7yWXM8CE3wPtNVo5/20PO6r7OQTx4JA==
X-Received: by 2002:a05:6830:26e0:b0:690:c284:f16c with SMTP id m32-20020a05683026e000b00690c284f16cmr1881407otu.11.1678497013637;
        Fri, 10 Mar 2023 17:10:13 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y30-20020a9d461e000000b00688449397d3sm694743ote.15.2023.03.10.17.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:10:13 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] watchdog: ebc-c384_wdt: Migrate to the regmap API
Date:   Fri, 10 Mar 2023 19:44:04 -0500
Message-Id: <20230311004404.62980-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/watchdog/Kconfig        |  1 +
 drivers/watchdog/ebc-c384_wdt.c | 64 +++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f0872970daf9..301cfe79263c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1089,6 +1089,7 @@ config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
 	depends on X86
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer on the
diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
index 8ef4b0df3855..3776d32cb863 100644
--- a/drivers/watchdog/ebc-c384_wdt.c
+++ b/drivers/watchdog/ebc-c384_wdt.c
@@ -3,15 +3,15 @@
  * Watchdog timer driver for the WinSystems EBC-C384
  * Copyright (C) 2016 William Breathitt Gray
  */
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
-#include <linux/errno.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
+#include <linux/err.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -24,8 +24,11 @@
 #define WATCHDOG_MAX_TIMEOUT	15300
 #define BASE_ADDR		0x564
 #define ADDR_EXTENT		5
-#define CFG_ADDR		(BASE_ADDR + 1)
-#define PET_ADDR		(BASE_ADDR + 2)
+#define CFG_REG			0x1
+#define PET_REG			0x2
+#define CFG_MINUTES		0x00
+#define CFG_SECONDS		BIT(7)
+#define PET_DISABLED		0x00
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -37,43 +40,54 @@ module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
 	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
+static const struct regmap_range ebc_c384_wdt_wr_ranges[] = {
+	regmap_reg_range(0x1, 0x2),
+};
+static const struct regmap_access_table ebc_c384_wdt_wr_table = {
+	.yes_ranges = ebc_c384_wdt_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ebc_c384_wdt_wr_ranges),
+};
+static const struct regmap_config ebc_c384_wdt_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x2,
+	.wr_table = &ebc_c384_wdt_wr_table,
+};
+
 static int ebc_c384_wdt_start(struct watchdog_device *wdev)
 {
+	struct regmap *const map = wdev->driver_data;
 	unsigned t = wdev->timeout;
 
 	/* resolution is in minutes for timeouts greater than 255 seconds */
 	if (t > 255)
 		t = DIV_ROUND_UP(t, 60);
 
-	outb(t, PET_ADDR);
-
-	return 0;
+	return regmap_write(map, PET_REG, t);
 }
 
 static int ebc_c384_wdt_stop(struct watchdog_device *wdev)
 {
-	outb(0x00, PET_ADDR);
+	struct regmap *const map = wdev->driver_data;
 
-	return 0;
+	return regmap_write(map, PET_REG, PET_DISABLED);
 }
 
 static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
 {
+	struct regmap *const map = wdev->driver_data;
+
 	/* resolution is in minutes for timeouts greater than 255 seconds */
 	if (t > 255) {
 		/* round second resolution up to minute granularity */
 		wdev->timeout = roundup(t, 60);
-
-		/* set watchdog timer for minutes */
-		outb(0x00, CFG_ADDR);
-	} else {
-		wdev->timeout = t;
-
-		/* set watchdog timer for seconds */
-		outb(0x80, CFG_ADDR);
+		return regmap_write(map, CFG_REG, CFG_MINUTES);
 	}
 
-	return 0;
+	wdev->timeout = t;
+	return regmap_write(map, CFG_REG, CFG_SECONDS);
 }
 
 static const struct watchdog_ops ebc_c384_wdt_ops = {
@@ -89,6 +103,8 @@ static const struct watchdog_info ebc_c384_wdt_info = {
 
 static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 {
+	void __iomem *regs;
+	struct regmap *map;
 	struct watchdog_device *wdd;
 
 	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
@@ -97,6 +113,15 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	regs = devm_ioport_map(dev, BASE_ADDR, ADDR_EXTENT);
+	if (!regs)
+		return -ENOMEM;
+
+	map = devm_regmap_init_mmio(dev, regs, &ebc_c384_wdt_regmap_config);
+	if (IS_ERR(map))
+		return dev_err_probe(dev, PTR_ERR(map),
+				     "Unable to initialize register map\n");
+
 	wdd = devm_kzalloc(dev, sizeof(*wdd), GFP_KERNEL);
 	if (!wdd)
 		return -ENOMEM;
@@ -106,6 +131,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 	wdd->timeout = WATCHDOG_TIMEOUT;
 	wdd->min_timeout = 1;
 	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
+	wdd->driver_data = map;
 
 	watchdog_set_nowayout(wdd, nowayout);
 	watchdog_init_timeout(wdd, timeout, dev);

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

