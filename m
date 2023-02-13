Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F2695156
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBMUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBMUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:05:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFF1E2B0;
        Mon, 13 Feb 2023 12:05:25 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so13455701wrv.7;
        Mon, 13 Feb 2023 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=ez7EynmaFLZ9mWHcUnVekEqRj1HYCfFo+U0FC+0pSmPUf4/sbRsEUG694SXGRe4jSw
         Ccfm8VWUlfxIBQG2R1tYV/N5PMNlpWoXCw9dNJgQrkxKx0m5VOBCefLY/bzfTFUpzNHG
         GdL9O4zT7N8nrXNPh9Rj07QiQc1Fh4W0+qu111TS8a+NICy4X/TE4XVqA85hseRUF/4s
         Zf72v6ImMCuq9+9T1arT5HtMvCRAwABQdV3rnFg67G5W/275qldiyrwFv2cegB2BHMD0
         kq6NyOJEiS3ELpSqrfaxB1LQ+SrETTRZj4NjBt3/+1AwrQrIsYqGQhmNIyFO6rac3a7S
         mB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=b5EKkva8NvWy5rw2oy70RqvmCZfAsPqeKvNcYa+b4f0srKRaraqRElMXOEruhj32uS
         4t/0cdJHwALu9yWQcq4mSWOnHwdBIkVhS0qwnAyahcgrcsH75qvajO1FjfGBWefWxwlg
         spAVPackPJv0ioKYehA8atwZyJOysEmBu8jwsrdweswE+D/WkBw+xguwBEWfxrSE4+Sz
         0zpnflXa8WbxjIKHXmxVg13rMKnjT8dQttMeWVu+6jnuuToGRI0WJ+r/wz7XRbM7TL42
         E4sYy3cpm4q9MvnEs6bk+sggNZzGzvr2koLki9TIHDgxiiiTp5eUEHNQRLPvsTbFkPSZ
         HcoQ==
X-Gm-Message-State: AO0yUKXh+I752PCVDMQjNk5Mebytslq7pTXlw7H6r7fnTLt+Vp9wIX40
        xNZafgyn2Atuc/iwdJ+dduvfFKxNbn0=
X-Google-Smtp-Source: AK7set8e9Vu5lWf3u0ZRRGbRhp9okecHZ/8ihwvSVJupThvgR1U1my48mnnyIhIdXejN+1lLKO45xg==
X-Received: by 2002:adf:ed03:0:b0:2bf:c0d3:430c with SMTP id a3-20020adfed03000000b002bfc0d3430cmr22843241wro.11.1676318723700;
        Mon, 13 Feb 2023 12:05:23 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id c129-20020a1c3587000000b003dc1a525f22sm15591242wma.25.2023.02.13.12.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 12:05:23 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v6 2/3] watchdog: mt7621-wdt: avoid static global declarations
Date:   Mon, 13 Feb 2023 21:05:18 +0100
Message-Id: <20230213200519.889503-3-sergio.paracuellos@gmail.com>
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

