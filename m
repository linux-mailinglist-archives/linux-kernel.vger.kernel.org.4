Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77328694542
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjBMMHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjBMMHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:07:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AC1A668;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so8838377wms.1;
        Mon, 13 Feb 2023 04:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=YWEYH2b4HN6eXkFJ4ZK0M9uKlH+diuyglQ3ucbPo0c5udpBqN8KzCUjKu0vtByRLzm
         U9rOv4twjtKU+nrbatLFkPcTjvhhCrjGuB5gmkg56R0gsPA34m9B9kQHAnBydqL46K+c
         Cv/66HidLtwjUuF92jE/y27EOI6euOsnoq281+DugGlllySwwUx4E/m2d02DX6EDj6bZ
         WQFkn9WeMVza+CbtHuf/Qz/0zkhYrw87AD0e9wzbEuwKROWdPQTPwTozYEx4JOQWagai
         +QYsilt3vsQHJWi3TGCgtjZHOgkmmVJ3poA6AGQTwLun+B0X1C4+RdhVyO5E9MsJUhMO
         q9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTGPGFaQb/DlfYZrXhPbzKJDWxh4+D5n3UiQCEuPX0I=;
        b=jCJVOod8vDxqzilsTP12v0c9xWMOCJdsgl5oiGBKAq3QKgeBvblCs7xIRuXjcjGrUG
         MmNEv7C5Zdyac9RfdDomWM5jUylSGMR4NMjcChKz+xIcu4Hq4daG1mh8o8uVZkTyS3RF
         uJ4MrGx4zLCSAPejdDBVn6DY60ZMv7cl6XVTTXCeWfqzqSRZLYlrmF1ExEFozItcIMCj
         AY0yQTBY2XwCxTbkcIc0s//4+GPsFrtF1MDnegPAJMk14Zi8hdAlDB0c9FJljJYXVyuk
         S1Ujo779P6wd1r4I9NVjQMp6ARx+yPXhbgk+iBfyC4boZSlM2HJg7KDrwYATCGlYgcwP
         0dQg==
X-Gm-Message-State: AO0yUKXfx2OIEEtbLA+WB9RDS59qS6XZ+IWPQ+MW9Y2jfLel3Nr+xOWt
        SWOt4nJtB7NOxhkpKmaeRmceIvIGsEg=
X-Google-Smtp-Source: AK7set+qiS7u+ciqsP2eXoLSrpYMakN/XMoBiyNBZdnB2U3QH9SjOan1nLFzuIGgXJUtTBJhBuPILA==
X-Received: by 2002:a05:600c:993:b0:3dc:4fd7:31e9 with SMTP id w19-20020a05600c099300b003dc4fd731e9mr20318806wmp.7.1676290003233;
        Mon, 13 Feb 2023 04:06:43 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b003dc434900e1sm14798046wms.34.2023.02.13.04.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:06:42 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v5 2/2] watchdog: mt7621-wdt: avoid static global declarations
Date:   Mon, 13 Feb 2023 13:06:38 +0100
Message-Id: <20230213120638.850612-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
References: <20230213120638.850612-1-sergio.paracuellos@gmail.com>
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

