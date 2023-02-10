Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531596918DB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjBJG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBJG4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:56:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE249036;
        Thu,  9 Feb 2023 22:56:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r18so3086787wmq.5;
        Thu, 09 Feb 2023 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qf+2ZhY+893e36Ug2b5UjMaC8ljMGgprsHyghDRy1Sg=;
        b=QFQGPb20w3YPAM0If9VYHLNWZx8fQU/Jcj32TVqWfuWNx2CwViDw+2kE7IvKAd51e6
         FuUq8XLdWDwou1nrsbPiV1BzklAZ9210mnwQZrc8NKxmZ+WUn3Wk2XOaxW6ArHMAoGim
         Izi8pHqvGHh4qIghrClzJx9E4yPDCAD+z7Xed3DQlaBT7mCNjgSe3yyXE1pw3qNhnbWf
         pA0f4sGujjHSaxqpw4FV32bqAf2kuC0P3iphlxsRVzeEuW7KeGvk5W59/Dn1KmQyuAGZ
         hlxmyNA9g8epGTJ2pLbCq5rs9RWTPOY1derkGQj8LSnqMDVSFKiqeRFYO+LovX6TFgtb
         hQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qf+2ZhY+893e36Ug2b5UjMaC8ljMGgprsHyghDRy1Sg=;
        b=39VGLHlxtxsRJc1+PqBTv7c+pREVu/ZEdTNHqris9PO1Ty8WH/s/g2VxLC3XMUF8kj
         q5PidDWz6edwPkrkHPpf/TmBy0AE+fDc2WmrNEXgTEkB4On/w9eXTqqh2AD/QYBm8bKL
         QnXhswwqN6uYSjf9oPn2+CpPZNVcQElpfbMZsw7sA7OnZgs9cflhZPpBf+BMA0a92E79
         VmewaR9ge9ksiBtZUPEKRuWXTNblnkMEcYOYiRSsXE/0zLInUqUFOf7bmdT37CJ+juAT
         jq2/7NlCGxY/dG82ii2LgG4E5Dz7lBCIBNRw1Cv182pgfXsvHuSSQiKRqCEasXdus1mN
         VMjA==
X-Gm-Message-State: AO0yUKVbYlBHOCp6OTYHi9Rm+iUWkyrIyfblJtjN3ZKPdocyR/OpjLgO
        0nXmFDFErqoo94rDBOEOzFylVDLNBWI=
X-Google-Smtp-Source: AK7set8XQm8OBKzW5suIAmgWC7BkirjKJPBm2w1XqSWnY5B6w+svwYlQ1C6Ceu/dcH0hvxjvQSd/DQ==
X-Received: by 2002:a05:600c:490a:b0:3d3:4007:9c88 with SMTP id f10-20020a05600c490a00b003d340079c88mr15192637wmp.18.1676012186722;
        Thu, 09 Feb 2023 22:56:26 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm4385612wmo.2.2023.02.09.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 22:56:26 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH 3/3] watchdog: mt7621-wdt: avoid globals and arch dependencies
Date:   Fri, 10 Feb 2023 07:56:21 +0100
Message-Id: <20230210065621.598120-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
References: <20230210065621.598120-1-sergio.paracuellos@gmail.com>
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
the beggining they ar providing some architecture dependent operations
for accessing this shared registers through 'asm/mach-ralink/ralink_regs.h'
header file. However this is not ideal from a driver perspective which can
just access to the system controller registers in am arch independent way
using regmap syscon APIs. Hence, add a new structure for driver data and
use it along the code. This way architecture dependencies and global vars
are not needed anymore. Update Kconfig accordingly to select new added
dependencies and allow driver to be compile tested.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/Kconfig      |   4 +-
 drivers/watchdog/mt7621_wdt.c | 121 ++++++++++++++++++++++------------
 2 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b64bc49c7..cf752ad64 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1865,7 +1865,9 @@ config GXP_WATCHDOG
 config MT7621_WDT
 	tristate "Mediatek SoC watchdog"
 	select WATCHDOG_CORE
-	depends on SOC_MT7620 || SOC_MT7621
+	select REGMAP_MMIO
+	select MFD_SYSCON
+	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
 	help
 	  Hardware driver for the Mediatek/Ralink MT7621/8 SoC Watchdog Timer.
 
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index a8aa3522c..a7480fd2b 100644
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
@@ -31,8 +31,12 @@
 #define TMR1CTL_RESTART			BIT(9)
 #define TMR1CTL_PRESCALE_SHIFT		16
 
-static void __iomem *mt7621_wdt_base;
-static struct reset_control *mt7621_wdt_reset;
+struct mt7621_wdt_data {
+	void __iomem *base;
+	struct reset_control *rst;
+	struct regmap *sysc;
+	struct watchdog_device wdt;
+};
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -40,27 +44,31 @@ MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static inline void rt_wdt_w32(unsigned reg, u32 val)
+static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
 {
-	iowrite32(val, mt7621_wdt_base + reg);
+	iowrite32(val, base + reg);
 }
 
-static inline u32 rt_wdt_r32(unsigned reg)
+static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
 {
-	return ioread32(mt7621_wdt_base + reg);
+	return ioread32(base + reg);
 }
 
 static int mt7621_wdt_ping(struct watchdog_device *w)
 {
-	rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
+
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
 
 	return 0;
 }
 
 static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
 {
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
+
 	w->timeout = t;
-	rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1LOAD, t * 1000);
 	mt7621_wdt_ping(w);
 
 	return 0;
@@ -68,36 +76,41 @@ static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
 
 static int mt7621_wdt_start(struct watchdog_device *w)
 {
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
 	u32 t;
 
 	/* set the prescaler to 1ms == 1000us */
-	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, 1000 << TMR1CTL_PRESCALE_SHIFT);
 
 	mt7621_wdt_set_timeout(w, w->timeout);
 
-	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
 	t |= TMR1CTL_ENABLE;
-	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
 
 	return 0;
 }
 
 static int mt7621_wdt_stop(struct watchdog_device *w)
 {
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
 	u32 t;
 
 	mt7621_wdt_ping(w);
 
-	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
 	t &= ~TMR1CTL_ENABLE;
-	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
 
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
@@ -105,7 +118,9 @@ static int mt7621_wdt_bootcause(void)
 
 static int mt7621_wdt_is_running(struct watchdog_device *w)
 {
-	return !!(rt_wdt_r32(TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
+
+	return !!(rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
 }
 
 static const struct watchdog_info mt7621_wdt_info = {
@@ -121,30 +136,44 @@ static const struct watchdog_ops mt7621_wdt_ops = {
 	.set_timeout = mt7621_wdt_set_timeout,
 };
 
-static struct watchdog_device mt7621_wdt_dev = {
-	.info = &mt7621_wdt_info,
-	.ops = &mt7621_wdt_ops,
-	.min_timeout = 1,
-	.max_timeout = 0xfffful / 1000,
-};
-
 static int mt7621_wdt_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	mt7621_wdt_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(mt7621_wdt_base))
-		return PTR_ERR(mt7621_wdt_base);
+	struct watchdog_device *mt7621_wdt;
+	struct mt7621_wdt_data *drvdata;
+	int err;
+
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
 
-	mt7621_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(mt7621_wdt_reset))
-		reset_control_deassert(mt7621_wdt_reset);
+	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "ralink,sysctl");
+	if (IS_ERR(drvdata->sysc))
+		return PTR_ERR(drvdata->sysc);
 
-	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
-			      dev);
-	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
-	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
+	drvdata->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (!IS_ERR(drvdata->rst))
+		reset_control_deassert(drvdata->rst);
+
+	mt7621_wdt = &drvdata->wdt;
+	mt7621_wdt->info = &mt7621_wdt_info;
+	mt7621_wdt->ops = &mt7621_wdt_ops;
+	mt7621_wdt->min_timeout = 1;
+	mt7621_wdt->max_timeout = 0xfffful / 1000;
+	mt7621_wdt->parent = dev;
+
+	mt7621_wdt->bootstatus = mt7621_wdt_bootcause(drvdata);
+
+	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
+	watchdog_set_nowayout(mt7621_wdt, nowayout);
+	watchdog_set_drvdata(mt7621_wdt, drvdata);
+
+	if (mt7621_wdt_is_running(mt7621_wdt)) {
 		/*
 		 * Make sure to apply timeout from watchdog core, taking
 		 * the prescaler of this driver here into account (the
@@ -154,17 +183,27 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 		 * we first disable the watchdog, set the new prescaler
 		 * and timeout, and then re-enable the watchdog.
 		 */
-		mt7621_wdt_stop(&mt7621_wdt_dev);
-		mt7621_wdt_start(&mt7621_wdt_dev);
-		set_bit(WDOG_HW_RUNNING, &mt7621_wdt_dev.status);
+		mt7621_wdt_stop(mt7621_wdt);
+		mt7621_wdt_start(mt7621_wdt);
+		set_bit(WDOG_HW_RUNNING, &mt7621_wdt->status);
 	}
 
-	return devm_watchdog_register_device(dev, &mt7621_wdt_dev);
+	err = devm_watchdog_register_device(dev, &drvdata->wdt);
+	if (err) {
+		dev_err(dev, "Error registering watchdog device\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
 }
 
 static void mt7621_wdt_shutdown(struct platform_device *pdev)
 {
-	mt7621_wdt_stop(&mt7621_wdt_dev);
+	struct mt7621_wdt_data *drvdata = platform_get_drvdata(pdev);
+
+	mt7621_wdt_stop(&drvdata->wdt);
 }
 
 static const struct of_device_id mt7621_wdt_match[] = {
-- 
2.25.1

