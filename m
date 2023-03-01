Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC67A6A67D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 07:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCAGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 01:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 01:55:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AB02E0C9;
        Tue, 28 Feb 2023 22:55:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p16so7846263wmq.5;
        Tue, 28 Feb 2023 22:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677653712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BznZY3DwzY1Ny939pkp41laSlmuq7UqVrDzh8/niGI=;
        b=XAH9M2EAUyKsNg85Mhs4md8BH5lu6CplILqnEnQjkFWftoe3PISpd5yG3ric9RcFwe
         P0fncKWHddPootloz20EiRNial6hPeIJ8sCrBkwk8FOCFlI6LJbL3xctWpoCgGR8o+D/
         1WZmsujxwT8i8HGr2UGD+78U1ak3+R+BoOpQ2PZYo2asIojXqycobopE8wpJyuiLFSAB
         j/8JKqL1ngjd/xOgJmiZGSikn3Iv8cSc9b9/OYky0XgmLcReclq7F0ZX+Ci+gUYzR+X4
         Bu0lX7UImVzDVfSjtvASpev+xSpWzyJ109rm5CgPrrfHxt/6/5Azbd2RM/7p5Fu/b2vx
         6iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677653712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BznZY3DwzY1Ny939pkp41laSlmuq7UqVrDzh8/niGI=;
        b=ju9x5iVATTMgkSrpuUWDZ1Q5zIKxu82znwJKz1JC6jWnOcFYAqBWt8K9MqDH81O6XB
         LjZuen4W/6akGvb94fP3r3aPX3HyOarKHBWml2ZY3UKIINM9KT+o4UUpey62e+wUSFG/
         f7IIMpQc5xS/ALXOIJ5mEOx/RYrgN+Ya0SPvZbv9GW+vml/v3Iv8SmLkAe6BfqPLrvKI
         QzmPPb8wgLa2jDh2m8k8c1A/NycE/C/nNL3JX2XsC45D4OpaEZcF/mhaWcIEWm5kdLKU
         Cot71lOXDk9JVmRK0fpUwMMuHBQVd4WlLjJSZzEOeH7sLC5RyPmARfRDsDH+a64O3+iU
         D/OQ==
X-Gm-Message-State: AO0yUKVa+IMpkJDBXLzHz+DfI1TxKr0p72GxiZJyDx79ja/BKjg+4p51
        0TXMIUXzPTGGCCTvRZluNB1r3cpnmJI=
X-Google-Smtp-Source: AK7set/YKllQZvY0MBC4AnXlCk0f+g+1j2ZNr45jI9htpv7pWPLSc8ib1/K0MFJMDr5dsTHFkAdlEA==
X-Received: by 2002:a05:600c:19c7:b0:3dc:40a0:3853 with SMTP id u7-20020a05600c19c700b003dc40a03853mr4019407wmq.11.1677653712258;
        Tue, 28 Feb 2023 22:55:12 -0800 (PST)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003e7f1086660sm18279998wme.15.2023.02.28.22.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 22:55:11 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog: rt2880-wdt: avoid static global declarations
Date:   Wed,  1 Mar 2023 07:55:09 +0100
Message-Id: <20230301065510.2818425-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Instead of using static global definitions in driver code, refactor code
introducing a new watchdog driver data structure and use it along the code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/rt2880_wdt.c | 89 ++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 39 deletions(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 49aff800824d..e54737bcf939 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -40,10 +40,13 @@
 #define TMR1CTL_PRESCALE_MASK		0xf
 #define TMR1CTL_PRESCALE_65536		0xf
 
-static struct clk *rt288x_wdt_clk;
-static unsigned long rt288x_wdt_freq;
-static void __iomem *rt288x_wdt_base;
-static struct reset_control *rt288x_wdt_reset;
+struct rt2880_wdt_data {
+	void __iomem *base;
+	unsigned long freq;
+	struct clk *clk;
+	struct reset_control *rst;
+	struct watchdog_device wdt;
+};
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -51,52 +54,56 @@ MODULE_PARM_DESC(nowayout,
 		"Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static inline void rt_wdt_w32(unsigned reg, u32 val)
+static inline void rt_wdt_w32(void __iomem *base, unsigned reg, u32 val)
 {
-	iowrite32(val, rt288x_wdt_base + reg);
+	iowrite32(val, base + reg);
 }
 
-static inline u32 rt_wdt_r32(unsigned reg)
+static inline u32 rt_wdt_r32(void __iomem *base, unsigned reg)
 {
-	return ioread32(rt288x_wdt_base + reg);
+	return ioread32(base + reg);
 }
 
 static int rt288x_wdt_ping(struct watchdog_device *w)
 {
-	rt_wdt_w32(TIMER_REG_TMR1LOAD, w->timeout * rt288x_wdt_freq);
+	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
+
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1LOAD, w->timeout * drvdata->freq);
 
 	return 0;
 }
 
 static int rt288x_wdt_start(struct watchdog_device *w)
 {
+	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
 	u32 t;
 
-	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
 	t &= ~(TMR1CTL_MODE_MASK << TMR1CTL_MODE_SHIFT |
 		TMR1CTL_PRESCALE_MASK);
 	t |= (TMR1CTL_MODE_WDT << TMR1CTL_MODE_SHIFT |
 		TMR1CTL_PRESCALE_65536);
-	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
 
 	rt288x_wdt_ping(w);
 
-	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
 	t |= TMR1CTL_ENABLE;
-	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
 
 	return 0;
 }
 
 static int rt288x_wdt_stop(struct watchdog_device *w)
 {
+	struct rt2880_wdt_data *drvdata = watchdog_get_drvdata(w);
 	u32 t;
 
 	rt288x_wdt_ping(w);
 
-	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
+	t = rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL);
 	t &= ~TMR1CTL_ENABLE;
-	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
+	rt_wdt_w32(drvdata->base, TIMER_REG_TMR1CTL, t);
 
 	return 0;
 }
@@ -130,41 +137,45 @@ static const struct watchdog_ops rt288x_wdt_ops = {
 	.set_timeout = rt288x_wdt_set_timeout,
 };
 
-static struct watchdog_device rt288x_wdt_dev = {
-	.info = &rt288x_wdt_info,
-	.ops = &rt288x_wdt_ops,
-	.min_timeout = 1,
-};
-
 static int rt288x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdt;
+	struct rt2880_wdt_data *drvdata;
 	int ret;
 
-	rt288x_wdt_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(rt288x_wdt_base))
-		return PTR_ERR(rt288x_wdt_base);
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	rt288x_wdt_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(rt288x_wdt_clk))
-		return PTR_ERR(rt288x_wdt_clk);
+	drvdata->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(drvdata->clk))
+		return PTR_ERR(drvdata->clk);
 
-	rt288x_wdt_reset = devm_reset_control_get_exclusive(dev, NULL);
-	if (!IS_ERR(rt288x_wdt_reset))
-		reset_control_deassert(rt288x_wdt_reset);
+	drvdata->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (!IS_ERR(drvdata->rst))
+		reset_control_deassert(drvdata->rst);
 
-	rt288x_wdt_freq = clk_get_rate(rt288x_wdt_clk) / RALINK_WDT_PRESCALE;
+	drvdata->freq = clk_get_rate(drvdata->clk) / RALINK_WDT_PRESCALE;
 
-	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
-	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
-	rt288x_wdt_dev.parent = dev;
+	wdt = &drvdata->wdt;
+	wdt->info = &rt288x_wdt_info;
+	wdt->ops = &rt288x_wdt_ops;
+	wdt->min_timeout = 1;
+	wdt->max_timeout = (0xfffful / drvdata->freq);
+	wdt->parent = dev;
+	wdt->bootstatus = rt288x_wdt_bootcause();
 
-	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
-			      dev);
-	watchdog_set_nowayout(&rt288x_wdt_dev, nowayout);
+	watchdog_init_timeout(wdt, wdt->max_timeout, dev);
+	watchdog_set_nowayout(wdt, nowayout);
+	watchdog_set_drvdata(wdt, drvdata);
 
-	watchdog_stop_on_reboot(&rt288x_wdt_dev);
-	ret = devm_watchdog_register_device(dev, &rt288x_wdt_dev);
+	watchdog_stop_on_reboot(wdt);
+	ret = devm_watchdog_register_device(dev, &drvdata->wdt);
 	if (!ret)
 		dev_info(dev, "Initialized\n");
 
-- 
2.25.1

