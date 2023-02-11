Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577BF692F12
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBKHeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBKHeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1432A6D6;
        Fri, 10 Feb 2023 23:34:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so5612640wmb.2;
        Fri, 10 Feb 2023 23:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLAmTwGROSc7NPK5pPUXsH009XpQBIleEsTQztuacG0=;
        b=K31o9ot37al44f+dNK/AWrD7FpEn5jU8g/Wq8H1nazUjutTvjldG4dCjn+F5XPr+Ew
         XTZmGQRTAq4zpRNTQtaO5n8P0G6gsXOXppCFyFkGlZjdzikjQ97DysAaqqOEuq9qO3SR
         h2nyL1ugBmsBzIsFRyxNKhlwDCj/DYnNFjSGnK+bqzltonkvfxyveQhQ7npCPSYDvhvL
         iFVVmFE56Epk06eOXi85fmvBIO00RdBcQEUkMGEUnGgdkhkv2jKwCmGNBSC6Bs62iinF
         zBoI5QUwQMAmzhFG1e6YztK3lk5AGPpkLXJ6anDntTWgQvqnkb7yuG8hY8ZJXLV4f7fM
         Vrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLAmTwGROSc7NPK5pPUXsH009XpQBIleEsTQztuacG0=;
        b=EooilULHwf3cNm7NgBSWdRvevJ+p+nmeuNdISW/CSzkzyFLTbB5Bk4KwpGqyCkAShc
         QN1NMYG3RUw1goUILqEIJ8YUcT2G8mON3QAuIDPmcDib7ranjC6j7dUi4vI2EWb7E7iq
         dOmRbJnWiRM0ww24TIHCGJ3IMB8OycJGIBR36pO5vH52Wb03SjLLeRoq9uDAGAwrAB87
         woc2p9p8Kw6cKaaQVO8yHzDbfRlyTcySavijahveH5MAEk/wgQ7EJGwJbU2+kmDh7z75
         kG9+Jy7ZtbhU4HdsQlxvOeivaW09YzD7IQ9wfUbgEUrFjPYRdOt23wpoRkF5dmpwedvx
         iaAg==
X-Gm-Message-State: AO0yUKUUbKxMJAysu1659mosuzV1stGAYbvkHGTUJcN3/p2VrEWKLZ3U
        LFJPEelV776bnXKEyv19dQRfAxSZ6NQ=
X-Google-Smtp-Source: AK7set/iq7UVY+SA3X2XBZTFdGF8890AM3Pvqf+1eK5jQ6/W5TzH5XDefv26kfKvCqhuBwJTTJOTFg==
X-Received: by 2002:a05:600c:43c7:b0:3dc:5d34:dbe5 with SMTP id f7-20020a05600c43c700b003dc5d34dbe5mr14491745wmn.28.1676100846266;
        Fri, 10 Feb 2023 23:34:06 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:34:05 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 5/5] watchdog: mt7621-wdt: avoid ralink architecture dependent code
Date:   Sat, 11 Feb 2023 08:33:57 +0100
Message-Id: <20230211073357.755893-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/Kconfig      |  4 +++-
 drivers/watchdog/mt7621_wdt.c | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

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

