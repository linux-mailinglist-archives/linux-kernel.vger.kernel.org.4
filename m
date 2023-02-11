Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06061692F17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 08:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBKHeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 02:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBKHeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 02:34:10 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5E2A170;
        Fri, 10 Feb 2023 23:34:06 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u10so5373106wmj.3;
        Fri, 10 Feb 2023 23:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=WBZBv5+/3LplUniui6ce9L03+sig+cCpsE45lmaFPXquqBtPf6vjgs4/0cV88zJUtG
         aNbJ316TG+LjPmaZ7Bi38CElHvzIr/RK+iq+OTFrtW1MKl+OL3wFFxsK6T5goIeZ5sbF
         8s6IVu05+dyCeETEtP3luSaI0xTR2g60S8l+vbzoH232jePOGCb1mKRyU4h60lROfTnb
         4NolYJgXsxQSQZaKqRxkqKoQPAdErYBTWn0Cd199PP9Juot3rOrdSpvj4aGBhYao1Kh5
         pDAmHMha4FIx1j1/+NEqiPAG8fShODh6ffxF7JEDM/uHVJe5m3AZNueDeNMXlDTWQiam
         znxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=kkyKZqMS9ZsrfuyT15VwCNC2KamD7aGSesY9BqtRjdtfcPL5Om3BAUP0O6hUt2W5Pa
         HwZ2Cwfumpx8ax6KnUzcFYSnnUzcqpe1a+vbJf85JFzs16urfBXo6oRDgnv/DPlkZC+M
         YchNYxtf7rZhcXxgxDJs3ofOINhxRMzfKYHSojmylUvuRWuksCoXhCYAFrYxKX0pNgAG
         lPrlciWe3MK26mAJb/O4fl41amUGVRYaVNO+3MDNedAIRzzTglpqxvwltIqm7oFXPD/Q
         BhMmJ+CYeqKs34mXIWx1SD/FZns5npXFoVS2kTgTLKe0ipw8adJ48sHrjK3bPNyMy8tt
         sjYg==
X-Gm-Message-State: AO0yUKWog0kYlAsl3NJBiT9VUVoABAijJhxK3qaTBmR0+AoLgEd3YS4o
        4rq4tdAkYpA5HVLBcdziR9730tsqXmk=
X-Google-Smtp-Source: AK7set+kGAX7SGuIrUm9Q0aGQ7UyfjpMTPfaQTrLDwPG1KEIr2bqNZ4uc9YEM1YYFN9/sKDP9b8D1g==
X-Received: by 2002:a05:600c:2b46:b0:3df:e472:fe03 with SMTP id e6-20020a05600c2b4600b003dfe472fe03mr16333119wmf.30.1676100845036;
        Fri, 10 Feb 2023 23:34:05 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003daf681d05dsm7917829wms.26.2023.02.10.23.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 23:34:04 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 4/5] watchdog: mt7621-wdt: avoid static global declarations
Date:   Sat, 11 Feb 2023 08:33:56 +0100
Message-Id: <20230211073357.755893-5-sergio.paracuellos@gmail.com>
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

Instead of using static global definitions in driver code, refactor code
introducing a new watchdog driver data structure and use it along the
code.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/watchdog/mt7621_wdt.c | 102 ++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 37 deletions(-)

diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index a8aa3522c..40fb2c9ba 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -31,8 +31,11 @@
 #define TMR1CTL_RESTART			BIT(9)
 #define TMR1CTL_PRESCALE_SHIFT		16
 
-static void __iomem *mt7621_wdt_base;
-static struct reset_control *mt7621_wdt_reset;
+struct mt7621_wdt_data {
+	void __iomem *base;
+	struct reset_control *rst;
+	struct watchdog_device wdt;
+};
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -40,27 +43,31 @@ MODULE_PARM_DESC(nowayout,
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
@@ -68,29 +75,31 @@ static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
 
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
@@ -105,7 +114,9 @@ static int mt7621_wdt_bootcause(void)
 
 static int mt7621_wdt_is_running(struct watchdog_device *w)
 {
-	return !!(rt_wdt_r32(TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
+	struct mt7621_wdt_data *drvdata = watchdog_get_drvdata(w);
+
+	return !!(rt_wdt_r32(drvdata->base, TIMER_REG_TMR1CTL) & TMR1CTL_ENABLE);
 }
 
 static const struct watchdog_info mt7621_wdt_info = {
@@ -121,30 +132,39 @@ static const struct watchdog_ops mt7621_wdt_ops = {
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
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
 
-	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
+	drvdata->rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (!IS_ERR(drvdata->rst))
+		reset_control_deassert(drvdata->rst);
 
-	watchdog_init_timeout(&mt7621_wdt_dev, mt7621_wdt_dev.max_timeout,
-			      dev);
-	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
-	if (mt7621_wdt_is_running(&mt7621_wdt_dev)) {
+	mt7621_wdt = &drvdata->wdt;
+	mt7621_wdt->info = &mt7621_wdt_info;
+	mt7621_wdt->ops = &mt7621_wdt_ops;
+	mt7621_wdt->min_timeout = 1;
+	mt7621_wdt->max_timeout = 0xfffful / 1000;
+	mt7621_wdt->parent = dev;
+
+	mt7621_wdt->bootstatus = mt7621_wdt_bootcause();
+
+	watchdog_init_timeout(mt7621_wdt, mt7621_wdt->max_timeout, dev);
+	watchdog_set_nowayout(mt7621_wdt, nowayout);
+	watchdog_set_drvdata(mt7621_wdt, drvdata);
+
+	if (mt7621_wdt_is_running(mt7621_wdt)) {
 		/*
 		 * Make sure to apply timeout from watchdog core, taking
 		 * the prescaler of this driver here into account (the
@@ -154,17 +174,25 @@ static int mt7621_wdt_probe(struct platform_device *pdev)
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
+	if (err)
+		return err;
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

