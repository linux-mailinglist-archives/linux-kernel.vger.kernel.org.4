Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB223695157
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjBMUFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjBMUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:05:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470C1D934;
        Mon, 13 Feb 2023 12:05:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso9912809wms.4;
        Mon, 13 Feb 2023 12:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhlCnihZNb20BPjIHQMYuoRdi3oZ62JfzhHTqCzRQ24=;
        b=dNDDKMpMHgloJyHwNh90yoMIp0iBvWg/A6xWij6O3F0yy3+V7nnKlJPbE7E4LXsUsd
         Wykacpe0ojR+DR2/W0SejFA5M4rG9mM8zrz3D3/o+PeM85pIsLV/lg1vr5YawwnYwTzJ
         MElxtQa2IkbKKVlxnPx3N5YMBa+DOK2c8SDe90tVivpwq2nd0s6xFjDFDhxM6Y4mJ1ZZ
         fw0krbuevPiUTPbwVcHoBH3WIEmelQnlY3Mvj+8voCMgBhAz2nGeOJ4GX9cj+tqZWykP
         DsCFE873vogsY0ojvhLKgWkQXY+cUkVl/nYcjgKgN41Alc9CkZ4TXB44qlq9FRAau9Uy
         UZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhlCnihZNb20BPjIHQMYuoRdi3oZ62JfzhHTqCzRQ24=;
        b=lRWnk4X8LT7wLEmn2yhWE4gL02HylIRUzjkqVCmdCqxkZ5xx8LSGv5ZJmKTIaqPc0U
         pnRuxVfyYPXJeVnTwPtVmlWQSRCJ7mqzK+i8Bsiw1kU77TA0fs0JnV9qts5uszYM2wNQ
         HAJUgwQrtoNp7c6pfNtA5TcC/f9H8NHd3JFO70KZ1kB52O4u9NgvBXU10D4oaOJZQrvK
         0ELhKvtyRhyy8VvJKdMEY3KPQOUlsGKNbzLkYOKrwdbtFLfFA0p50fxEjcOh0q2VzU0t
         PkOYLJ6io22C3z0jFZE8WpC05Qizo5I65GQR4wxeuit8OGUV++9Dsi6eGQNFDUZ1BceE
         ETug==
X-Gm-Message-State: AO0yUKXWpBCMdQt3L3ftDg5UaDw6Imvjx+douWGSS8XO1p1nP9bQoDpa
        nUbDzqFE6NabbmXdBqceW0JHVEDCZbQ=
X-Google-Smtp-Source: AK7set8N4Fktu7d+K0Pr53TyVYQ66TrRRkSI6n5yAFkQioauKyspkp2DXN1WwVGJOvshbtLeQlnrHQ==
X-Received: by 2002:a05:600c:81b:b0:3c6:e63e:23e9 with SMTP id k27-20020a05600c081b00b003c6e63e23e9mr23363211wmp.24.1676318724833;
        Mon, 13 Feb 2023 12:05:24 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm15591242wma.25.2023.02.13.12.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:05:24 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v6 3/3] watchdog: mt7621-wdt: avoid ralink architecture dependent code
Date:   Mon, 13 Feb 2023 21:05:19 +0100
Message-Id: <20230213200519.889503-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
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
 drivers/watchdog/mt7621_wdt.c | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index 40fb2c9ba..22e979bdd 100644
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
@@ -143,6 +147,10 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->sysc = syscon_regmap_lookup_by_compatible("mediatek,mt7621-sysc");
+	if (IS_ERR(drvdata->sysc))
+		return PTR_ERR(drvdata->sysc);
+
 	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drvdata->base))
 		return PTR_ERR(drvdata->base);
@@ -158,7 +166,7 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
 	mt7621_wdt->max_timeout = 0xfffful / 1000;
 	mt7621_wdt->parent = dev;
 
-	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
+	mt7621_wdt->bootstatus = mt7621_wdt_bootcause(drvdata);
 
 	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
 	watchdog_set_nowayout(mt7621_wdt, nowayout);
-- 
2.25.1

