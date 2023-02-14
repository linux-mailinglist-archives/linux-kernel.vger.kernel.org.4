Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90693696110
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjBNKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjBNKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:39:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12C244B3;
        Tue, 14 Feb 2023 02:39:46 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a2so15134376wrd.6;
        Tue, 14 Feb 2023 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG6+guVzRQjTbRLIGLzjFnyLsgkRwGsfNNLnjnu+i0s=;
        b=TNfbzoo0DPmK0ZpI0MZ0cwW6nGW+rhf0ZoQnJtepOR3qG1j0Qs6QCvVcEyBJ3Ysv4m
         Sw9VZdcBhLKa11W40/Q2ZCGOsVNSxZnyK709poQQX3DFD8ztEp9OTfPdKmBiXn7yibCD
         Y5LerYKNvhDSGFTDj677xHzBaJ0A0vGHYWgwBSjNBYtwllL3w/JHSCDrorgClwNE8XQQ
         G2U7eOxHEMY+C2P2reIkIYwktp5nyjO+QL2Tf7VCv7vx5l0AKHpGZ+Yqdie41pqhz7YF
         OCW6GaOlpDUCkJYY7Cndzd/e2IMf3s7YmptH9wxe3/vqx3sKNcrX2/q9uM/smaI6mBHJ
         9r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CG6+guVzRQjTbRLIGLzjFnyLsgkRwGsfNNLnjnu+i0s=;
        b=hO3ghkH+FmFc8TD8FfxwnHPMrsM+39u2md8pNOOj1FxGxJH88QeeuCnM0CCyn+msPO
         qUQQEVTuPxZJaK8hyZqgKs28UmuQY+PNFZkcTF7A9nvGFELOCnWreBhVkQblUPuwLBvu
         BpoHp+N0joq7dWD2kT2W2mxCjnnWWwjEzUfsQ+g/l0k614oUwOLQ/tFYdy/Bl/pZ5n9K
         ya5KgWNDBLy+kcopBjQ14XsHRNmAIbL+tUtnEQQEYpRSYDiXMqnbYSBtYx93GVW42Wr5
         cxN1r8avi6/SMyMOPJOS3hwEXUWG17FvNTA584F01UP07+PVw1dp4cdxRIOCD4GtZUuw
         Hqow==
X-Gm-Message-State: AO0yUKWQUuIibMgZG8LFg9GxGPLyho1LhouSY5v6cUePFq0gcnF+/lYV
        0YF3sXeWsw7zcAbMwDjHNfav2BxfJSA=
X-Google-Smtp-Source: AK7set+RJaZMNjJyW8sfMcSBInlOma1zNgii+lyMKRjaUcpAVyogYmZPSUDuX8PWn4cjmLQCBNXgoQ==
X-Received: by 2002:a5d:4e8a:0:b0:2c5:5847:3910 with SMTP id e10-20020a5d4e8a000000b002c558473910mr1472528wru.8.1676371184809;
        Tue, 14 Feb 2023 02:39:44 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b002be5bdbe40csm12693241wrt.27.2023.02.14.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:39:44 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v7 5/5] watchdog: mt7621-wdt: avoid ralink architecture dependent code
Date:   Tue, 14 Feb 2023 11:39:36 +0100
Message-Id: <20230214103936.1061078-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
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
 drivers/watchdog/Kconfig      |  4 +++-
 drivers/watchdog/mt7621_wdt.c | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b64bc49c7f30..cf752ad64392 100644
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
index 40fb2c9ba9d9..f37d8298a480 100644
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
@@ -143,6 +148,13 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "mediatek,sysctl");
+	if (IS_ERR(drvdata->sysc)) {
+		drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
+		if (IS_ERR(drvdata->sysc))
+			return PTR_ERR(drvdata->sysc);
+	}
+
 	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
@@ -158,7 +170,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	mt7621_wdt->max_timeout = 0xfffful / 1000;
 	mt7621_wdt->parent = dev;
 
-	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
+	mt7621_wdt->bootstatus = mt7621_wdt_bootcause(drvdata);
 
 	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
 	watchdog_set_nowayout(mt7621_wdt, nowayout);
-- 
2.25.1

