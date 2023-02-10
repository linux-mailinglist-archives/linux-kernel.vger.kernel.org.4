Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD06924A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBJRjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjBJRiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:38:55 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB56CC7C;
        Fri, 10 Feb 2023 09:38:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id by3so4478898wrb.10;
        Fri, 10 Feb 2023 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWd5PzeWNJMCpvyMunjpALsUnq2zPXRaUZZq05baKwY=;
        b=OCt10IItTlBPL52YaXJVQyFuuSqvf8GSvtpHogwe/mjnVed2ZuRy3ozf7u+jeylpHK
         qjTTEDwC/pLbHSYh+VlfRLE9qhutrlxb/4nisQHiru/blo1l9vnY7Y0Iw4AcOLtUeObg
         C+AZBZ5iyV8swUU+qNWy43OiRj2ofjwubjkCyOxm4usIkDCYA7Q34fjeX0AWtVr+kyEs
         RWwu5+C1Z2sKMkeemeb6uu+KxINddMhzPgdb5JcTq5m0rhc9QtyUXJTu/w6+g21F1Sbe
         IdWYsDHrKh6BU7vWOryCInhbd+bUokoUHlPZKY0AY59A9mYNYC5q6GRA4bdizRU8+Qkw
         E2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWd5PzeWNJMCpvyMunjpALsUnq2zPXRaUZZq05baKwY=;
        b=qYlIoMHMQLJR/rci9K4QKmWacOFdEloZV2Hq5Sezx+7JCG6+UuwpVAqc9U1hdJBu04
         qlnFUBv/L9YYH2fLLwKgGWgmb7zuabtm1zTJSKX4jHCIxRg5M7eAglnnAz5NQwMEvUDH
         VWEcaHi2lhG1gOWwnZN+lwATKS++TQleQ6EBF2oKN6DRlR6ZW9cmkJOuLGjQSkMvyyou
         bfN8xh7quuGFI+CSp7+46xVzsDw0up+HmUB4PsXS0dUdN14LvreyElsWz4ql+k3eJSXC
         gZDHAu6R5/0kt9oEQXouGskQpEZvS5OxPlQ4v20WwOJ3eBG0657CpwHFdzuUaDezU/i3
         DHyA==
X-Gm-Message-State: AO0yUKVibAtgxg9DyhdOy1Qmj83dx6vcvVYlau0Hbss2dZtiNnLawJT0
        BeXjsImV1MqV/MTZHlJDwZk7t26KudE=
X-Google-Smtp-Source: AK7set9aXFRknJm+ksQPwDww2f3SImtswgswX3GGKnt0A8acqYqBjOrOlPBcjcIrlyzz85WF2IYLlg==
X-Received: by 2002:a5d:5487:0:b0:2bf:be35:2303 with SMTP id h7-20020a5d5487000000b002bfbe352303mr13868526wrv.34.1676050730162;
        Fri, 10 Feb 2023 09:38:50 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id t2-20020a0560001a4200b002c3ef7e74bdsm4024184wry.73.2023.02.10.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:38:49 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 4/4] watchdog: mt7621-wdt: avoid ralink architecture dependent code
Date:   Fri, 10 Feb 2023 18:38:41 +0100
Message-Id: <20230210173841.705783-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 SoC has a system controller node. Watchdog need to access to reset
status register. Ralink architecture and related driver are old and from
the beggining they are using some architecture dependent operations for
accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
header file. However this is not ideal from a driver perspective which can
just access to the system controller registers in an arch independent way
using regmap syscon APIs. Update Kconfig accordingly to select new added
dependencies and allow driver to be compile tested.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/Kconfig      |  2 ++
 drivers/watchdog/mt7621_wdt.c | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b64bc49c7..0759de670 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1865,6 +1865,8 @@ config GXP_WATCHDOG
 config MT7621_WDT
 	tristate "Mediatek SoC watchdog"
 	select WATCHDOG_CORE
+	select REGMAP_MMIO
+	select MFD_SYSCON
 	depends on SOC_MT7620 || SOC_MT7621
 	help
 	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 40fb2c9ba..9ed07c187 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -15,8 +15,8 @@
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
-
-#include <asm/mach-ralink/ralink_regs.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #define SYSC_RSTSTAT			0x38
 #define WDT_RST_CAUSE			BIT(1)
@@ -34,6 +34,7 @@
 struct mt7621_wdt_data {
 	void __iomem *base;
 	struct reset_control *rst;
+	struct regmap *sysc;
 	struct watchdog_device wdt;
 };
 
@@ -104,9 +105,12 @@ static int mt7621_wdt_stop(struct watchdog_device *w)
 	return 0;
 }
 
-static int mt7621_wdt_bootcause(void)
+static int mt7621_wdt_bootcause(struct mt7621_wdt_data *d)
 {
-	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
+	u32 val;
+
+	regmap_read(d->sysc, SYSC_RSTSTAT, &val);
+	if (val & WDT_RST_CAUSE)
 		return WDIOF_CARDRESET;
 
 	return 0;
@@ -134,6 +138,7 @@ static const struct watchdog_ops mt7621_wdt_ops = {
 
 static int mt7621_wdt_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *mt7621_wdt;
 	struct mt7621_wdt_data *drvdata;
@@ -143,6 +148,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
+	if (IS_ERR(drvdata->sysc))
+		return PTR_ERR(drvdata->sysc);
+
 	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
@@ -158,7 +167,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	mt7621_wdt->max_timeout = 0xfffful / 1000;
 	mt7621_wdt->parent = dev;
 
-	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
+	mt7621_wdt->bootstatus = mt7621_wdt_bootcause(drvdata);
 
 	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
 	watchdog_set_nowayout(mt7621_wdt, nowayout);
-- 
2.25.1

