Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41161691EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBJMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjBJMRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:17:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CD7289B;
        Fri, 10 Feb 2023 04:17:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso3916277wms.4;
        Fri, 10 Feb 2023 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Jcqp/n5GNk4Jt2RN2nNjpswbRqJZ3Mt7tqEL5Vzsk=;
        b=KU4zhpdKF64gnPrZSYtRctPRLhs18rAmuzm73jQWx1HnMfCJmhcCsD+puNvmFx+wTM
         5hXWGs2wYVB6tzARbIFZfdIZJs2E5L1ikjnoRMy/8mlq52h69ra1WH7cB/ScK+hyUtns
         UmIHo3Qx996o1d4Y4+ExP0Kemq34n0F8Z9U9krPtWLpi6+z04spnIPlebMOe5m//ZtZB
         OUJSgL44cDCq8MsKd+lYeFqcBXrVCtuT1K4BIGziyzMr57rcHLMsaMe98/WF+XvDjYCY
         KksOnWAtCKu8o1xCcdAVGHl/BgRAbAbGGII6aFreadXRE9xpjdGPVyggPsFjDeYV/oeo
         sJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85Jcqp/n5GNk4Jt2RN2nNjpswbRqJZ3Mt7tqEL5Vzsk=;
        b=5VQuAvjQOE/9Fvx6qKrDiTDSzzKEmoVw/9lXxpkG5oA0YVFpubtl0IoUpJg7U83Yym
         3ouwE1cXR+EFWPgg9eawFNeyKOZj0ZBsisVxQWCXh6W0WusKPcjctlwW+43N6aj7AD89
         gcOsG43DJDXFQ1oZqnq8o+6rQxJ3zR3SUa+il9qzOVUcNm3+Z1wGYHCifV9WW1felrjA
         AeGS9tkQ3WEkhL7YQFDEb3/tIxtK8kc5FUD+8gI8PkTt/4q77fWjiIPhMBOd41z6cTJI
         y/3dchTFPxpZdZUNhdt4w+M0AcLAaYOKDHeJR+AWJ6juIu8P6uZsaQNshR/i97gBjXWk
         mzRQ==
X-Gm-Message-State: AO0yUKV4zDZwVX9D/keOjchd7eGw5R7SQmSjDsw1+9F8j8fhs/x7UjX1
        EtcTtZKCy64VTE9cVTlgBUqyLhkHULw=
X-Google-Smtp-Source: AK7set+qS6x4BJ+LtKe95F/2SO4xZ8r/N6WDScelOSSAg3g2uSEJKjzn5Lnq9yVuJJ9xzfPxkUroEw==
X-Received: by 2002:a05:600c:1887:b0:3dc:4318:d00d with SMTP id x7-20020a05600c188700b003dc4318d00dmr12224825wmp.11.1676031462935;
        Fri, 10 Feb 2023 04:17:42 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm5359820wmo.2.2023.02.10.04.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:17:42 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 4/4] watchdog: mt7621-wdt: avoid ralink architecture dependent code
Date:   Fri, 10 Feb 2023 13:17:35 +0100
Message-Id: <20230210121735.639089-5-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
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
index f1c702971..a7480fd2b 100644
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
 
+	drvdata->sysc = syscon_regmap_lookup_by_phandle(np, "ralink,sysctl");
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

