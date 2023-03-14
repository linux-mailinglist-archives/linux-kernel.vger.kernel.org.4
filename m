Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BD66B994D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjCNPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjCNPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:30:29 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ACE62864
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:29:32 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cu4so7794482qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678807770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYq3TK0piMvSdh8u6sbDbIfAAHTlrs55q/Bi+N/T6Tg=;
        b=RgHdUsz/OuJnP7rs4HBCE76HsrbfCtwP02LkIhQFNyZVAV6FJMn/Aw1XU0EmwpcH+E
         e/up7EbKCrZX8T+BDLhrdm7rY+KzWT5F6DBDCkneU/sJDT5TJWqf8EtPMPngHbOHsZPX
         fz4TkrCiz95UBzxA0r0ZTfX16pKvwgNHMrCztb9nMH0bY/t+aqWDeK+komMC7agDgLFp
         wa/4laXM+fSvJx44RNEuyeTeIyMoWaRHGGJkWP+0tvmcH5iXHKpgUcsQU8eAK58us/AB
         O4QJvvWPDDp09KVyKVaZtz3YvHOax0KZ672Ji8fT+e/ZGKZSpBOtH1YDf9NM0XlEqwLd
         PLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678807770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYq3TK0piMvSdh8u6sbDbIfAAHTlrs55q/Bi+N/T6Tg=;
        b=NhRJkAwfeu385RNbgAyuLTeL10mmdZKLmoipBcfVoq1dMTj83X/z5CrWuwf9a0h+D5
         UUjYK8HiAnx3U8eujQJmIoVKaHUQmz314MSHxCwHwzSQcsCuP1uK3Kd9iX4zKwle/HBy
         bXTpjOaXpUmbynV04KlQ1zT4dr/Ui4yAxWnRbKBWuVjgsfqNXgV9795/xvFANNNVJtbm
         CPe7P4jbW+wYYB7x5bMYXsYOV9fZ8nksY+9VYi4y0S+AI1Hl0gSyH2jPbl2qQ5e39kFa
         lO0Ek4CH7YCNnfPyci4zbjgAzvjR5M+eUBSw3N8GJ7/bYVzwXXuPDKQXfm/fy0G2K8fr
         G+7w==
X-Gm-Message-State: AO0yUKW4Nbfmda6WFRfZMaPCQV3slw5cz8KmJcZ80ejyYSeGupUqgY4/
        OKGjctb6szi2EI+ZTog08S8C4w==
X-Google-Smtp-Source: AK7set81ScLnrbEkyRYwaXDPBwCS3RapglOjf27ds8NmKZXYB0lmC1J+FD2pL0r1mYR8Kyan7kpuAg==
X-Received: by 2002:a05:6214:2421:b0:5a3:2814:59c with SMTP id gy1-20020a056214242100b005a32814059cmr19185470qvb.51.1678807770481;
        Tue, 14 Mar 2023 08:29:30 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 207-20020a3704d8000000b0074575572030sm1985474qke.1.2023.03.14.08.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:29:30 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Date:   Tue, 14 Mar 2023 11:29:16 -0400
Message-Id: <20230314152916.185939-1-william.gray@linaro.org>
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
Changes in v2:
 - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()
 - Map watchdog control registers based on offset 0x1 and adjust regmap
   configurations accordingly; offset 0x0 is unused in this driver so we
   should avoid unnecessary exposure of it

 drivers/watchdog/Kconfig        |  1 +
 drivers/watchdog/ebc-c384_wdt.c | 67 +++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 19 deletions(-)

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
index 8ef4b0df3855..2f9fec5073b3 100644
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
 
@@ -24,8 +24,14 @@
 #define WATCHDOG_MAX_TIMEOUT	15300
 #define BASE_ADDR		0x564
 #define ADDR_EXTENT		5
-#define CFG_ADDR		(BASE_ADDR + 1)
-#define PET_ADDR		(BASE_ADDR + 2)
+#define CTRL_BASE_ADDR		(BASE_ADDR + 0x1)
+#define CTRL_ADDR_EXTENT	2
+#define CTRL_MAX_REGISTER	(CTRL_ADDR_EXTENT - 1)
+#define CFG_REG			0x0
+#define PET_REG			0x1
+#define CFG_MINUTES		0x00
+#define CFG_SECONDS		BIT(7)
+#define PET_DISABLED		0x00
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -37,43 +43,54 @@ module_param(timeout, uint, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds (default="
 	__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
 
+static const struct regmap_range ebc_c384_wdt_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x1),
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
+	.max_register = CTRL_MAX_REGISTER,
+	.wr_table = &ebc_c384_wdt_wr_table,
+};
+
 static int ebc_c384_wdt_start(struct watchdog_device *wdev)
 {
+	struct regmap *const map = watchdog_get_drvdata(wdev);
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
+	struct regmap *const map = watchdog_get_drvdata(wdev);
 
-	return 0;
+	return regmap_write(map, PET_REG, PET_DISABLED);
 }
 
 static int ebc_c384_wdt_set_timeout(struct watchdog_device *wdev, unsigned t)
 {
+	struct regmap *const map = watchdog_get_drvdata(wdev);
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
@@ -89,6 +106,8 @@ static const struct watchdog_info ebc_c384_wdt_info = {
 
 static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 {
+	void __iomem *regs;
+	struct regmap *map;
 	struct watchdog_device *wdd;
 
 	if (!devm_request_region(dev, BASE_ADDR, ADDR_EXTENT, dev_name(dev))) {
@@ -97,6 +116,15 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
+	regs = devm_ioport_map(dev, CTRL_BASE_ADDR, CTRL_ADDR_EXTENT);
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
@@ -107,6 +135,7 @@ static int ebc_c384_wdt_probe(struct device *dev, unsigned int id)
 	wdd->min_timeout = 1;
 	wdd->max_timeout = WATCHDOG_MAX_TIMEOUT;
 
+	watchdog_set_drvdata(wdd, map);
 	watchdog_set_nowayout(wdd, nowayout);
 	watchdog_init_timeout(wdd, timeout, dev);
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

