Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950C86EEE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbjDZGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 02:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbjDZGxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 02:53:21 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F730EC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 23:53:12 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rZ1RpwxQZMX1TrZ1apoi7l; Wed, 26 Apr 2023 08:53:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682491991;
        bh=1oZNVU72onEvSJlf/nOroZTsWdZQ0dSMk+VCwOmUX5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bcamRcTYVPndFoKl1kVcGFPLlxC2EWR4gMfWdK2XWNXPos8dELczxHav2CKTgNg5f
         kuSImMQ7ExiyItxpHLpWUxvPdsb9Ei8OBmqA0MisQOcfyeLGtFHvH459Q2tOHdwgPM
         m9LteJ9Gb8lCVvjfC7CyhMwFc+7n6bFbH6q7Hc+PbRnXauohEOncx5smMN4fIsFkk8
         bAfXWs90p7aTLR5fOUK3kcltxU1KJW+Lhq57fsFJm8QeAP6b5jOTu0jmivpdq8Oy/w
         4tcsMzGU2yXx6HV4NawaUFkdzdKgj4HNDvCwhW2HnDcfvwYz/N95w2CKfFGtXcyI1/
         8qDNcPo2sexSg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 26 Apr 2023 08:53:11 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 2/2] watchdog: dw_wdt: Simplify clk management
Date:   Wed, 26 Apr 2023 08:52:49 +0200
Message-Id: <f6094c55cacf9637d835cd49290d9e888faeb0f7.1682491863.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
References: <fbb650650bbb33a8fa2fd028c23157bedeed50e1.1682491863.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() instead of hand-writing it.
This saves some LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This change the order the resources will be released, so review with care.
---
 drivers/watchdog/dw_wdt.c | 44 ++++++++++-----------------------------
 1 file changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index a1354a59eb37..84dca3695f86 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -566,22 +566,16 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	 * to the common timer/bus clocks configuration, in which the very
 	 * first found clock supply both timer and APB signals.
 	 */
-	dw_wdt->clk = devm_clk_get(dev, "tclk");
+	dw_wdt->clk = devm_clk_get_enabled(dev, "tclk");
 	if (IS_ERR(dw_wdt->clk)) {
-		dw_wdt->clk = devm_clk_get(dev, NULL);
+		dw_wdt->clk = devm_clk_get_enabled(dev, NULL);
 		if (IS_ERR(dw_wdt->clk))
 			return PTR_ERR(dw_wdt->clk);
 	}
 
-	ret = clk_prepare_enable(dw_wdt->clk);
-	if (ret)
-		return ret;
-
 	dw_wdt->rate = clk_get_rate(dw_wdt->clk);
-	if (dw_wdt->rate == 0) {
-		ret = -EINVAL;
-		goto out_disable_clk;
-	}
+	if (dw_wdt->rate == 0)
+		return -EINVAL;
 
 	/*
 	 * Request APB clock if device is configured with async clocks mode.
@@ -590,21 +584,13 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	 * so the pclk phandle reference is left optional. If it couldn't be
 	 * found we consider the device configured in synchronous clocks mode.
 	 */
-	dw_wdt->pclk = devm_clk_get_optional(dev, "pclk");
-	if (IS_ERR(dw_wdt->pclk)) {
-		ret = PTR_ERR(dw_wdt->pclk);
-		goto out_disable_clk;
-	}
-
-	ret = clk_prepare_enable(dw_wdt->pclk);
-	if (ret)
-		goto out_disable_clk;
+	dw_wdt->pclk = devm_clk_get_optional_enabled(dev, "pclk");
+	if (IS_ERR(dw_wdt->pclk))
+		return PTR_ERR(dw_wdt->pclk);
 
 	dw_wdt->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
-	if (IS_ERR(dw_wdt->rst)) {
-		ret = PTR_ERR(dw_wdt->rst);
-		goto out_disable_pclk;
-	}
+	if (IS_ERR(dw_wdt->rst))
+		return PTR_ERR(dw_wdt->rst);
 
 	/* Enable normal reset without pre-timeout by default. */
 	dw_wdt_update_mode(dw_wdt, DW_WDT_RMOD_RESET);
@@ -621,12 +607,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 				       IRQF_SHARED | IRQF_TRIGGER_RISING,
 				       pdev->name, dw_wdt);
 		if (ret)
-			goto out_disable_pclk;
+			return ret;
 
 		dw_wdt->wdd.info = &dw_wdt_pt_ident;
 	} else {
 		if (ret == -EPROBE_DEFER)
-			goto out_disable_pclk;
+			return ret;
 
 		dw_wdt->wdd.info = &dw_wdt_ident;
 	}
@@ -675,12 +661,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 out_assert_rst:
 	reset_control_assert(dw_wdt->rst);
-
-out_disable_pclk:
-	clk_disable_unprepare(dw_wdt->pclk);
-
-out_disable_clk:
-	clk_disable_unprepare(dw_wdt->clk);
 	return ret;
 }
 
@@ -692,8 +672,6 @@ static void dw_wdt_drv_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&dw_wdt->wdd);
 	reset_control_assert(dw_wdt->rst);
-	clk_disable_unprepare(dw_wdt->pclk);
-	clk_disable_unprepare(dw_wdt->clk);
 }
 
 #ifdef CONFIG_OF
-- 
2.34.1

