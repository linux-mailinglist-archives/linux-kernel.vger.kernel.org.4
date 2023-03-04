Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A22D6AAB4E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjCDQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCDQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:57:00 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466521167A;
        Sat,  4 Mar 2023 08:56:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id t129so2290005iof.12;
        Sat, 04 Mar 2023 08:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677949016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tpSFi8oQ8gJhvBK+1ukBO6QMtwZSSdSaUChPuPzBR3c=;
        b=Rb4ZNyGKUE3v/LdbeL9momfA58G5zQHoFZ3eElXIlCFDv59pTz9zk/d9GAyQGkyd+N
         PhlywmLX/4G64ibYGXNPjZlQROv50yG7R3b80N2+nEO6gvMc1e4+z3sBH6G1CErZOorn
         zwyoKlzOfjfXyTB//5jzMpJuJFWwABEqWhHHW34VxfMVWf1lnYsfSMKjm/Ahr7aXmEaE
         YOjPpujV00eHUCslDs6BPSBzNHYB1a+lqnf/P8R3eSbmlEN+BND1P69wCfCon0IlZX+x
         DN/eljo8Q46TqPZkI/9aw8M8/ABKX71fvwr4hdOt7fqFbpxffTWo2Ye1hr8GZz3aTa/L
         R7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677949016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpSFi8oQ8gJhvBK+1ukBO6QMtwZSSdSaUChPuPzBR3c=;
        b=cDO+ceJTcV5qtYWyjTgq6v4GQUjGimy+gJ9nwO+xF6woue5uwQs1PeHoykfxl/IJSx
         dvSSyPV07Xi+Y3Znd8FkD+YNVjhXe0ayvq8G/D9O+igQk4EeykJOOcAW3oq49bVnwZdq
         hr/CFKlPGuEYuSzhr+XobOgVB6t71Md0gMpQ7vVfLIw0pLsZlAst8sWLAIG/coqUtc9X
         AqGVSR8U/7SGo254Ip0JcVSS/Rk9vfHEKHOgsXIVJMjAvkm39gRsV1ScQfdZoDR0twk5
         qy1VicWOTf9EHGZ6zChQU2rx0Qz/1CpigKx9sST/l78QAHS/jNhc0eC7cxd54zA1tlSN
         D6pQ==
X-Gm-Message-State: AO0yUKXQktNenWJ0hrS2NizTk4IcPZh9QYw99nv9rgOhcxNqdXdqY+0W
        4NptWXFM5C2LVbZ2MiLZa3g=
X-Google-Smtp-Source: AK7set83oJcNExK3Eb+T8l1q48j5qW46pOyFnowBwt1rO9/RepcMWvXnXt7Dv94AjLnFOwFjhngDLw==
X-Received: by 2002:a6b:c993:0:b0:74c:8f72:291c with SMTP id z141-20020a6bc993000000b0074c8f72291cmr7584839iof.2.1677949016532;
        Sat, 04 Mar 2023 08:56:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d858d000000b0073f8a470bacsm1672220ioj.16.2023.03.04.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:56:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use devm_clk_get[_optional]_enabled() helpers
Date:   Sat,  4 Mar 2023 08:56:52 -0800
Message-Id: <20230304165653.2179835-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_clk_get[_optional]_enabled() helpers:
    - call devm_clk_get[_optional]()
    - call clk_prepare_enable() and register what is needed in order to
      call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

While at it, use dev_err_probe consistently, and use its return value
to return the error code.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/s3c2410_wdt.c | 45 +++++++---------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 200ba236a72e..a1fcb79b0b7c 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->reg_base))
 		return PTR_ERR(wdt->reg_base);
 
-	wdt->bus_clk = devm_clk_get(dev, "watchdog");
-	if (IS_ERR(wdt->bus_clk)) {
-		dev_err(dev, "failed to find bus clock\n");
-		return PTR_ERR(wdt->bus_clk);
-	}
-
-	ret = clk_prepare_enable(wdt->bus_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable bus clock\n");
-		return ret;
-	}
+	wdt->bus_clk = devm_clk_get_enabled(dev, "watchdog");
+	if (IS_ERR(wdt->bus_clk))
+		return dev_err_probe(dev, PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
 
 	/*
 	 * "watchdog_src" clock is optional; if it's not present -- just skip it
 	 * and use "watchdog" clock as both bus and source clock.
 	 */
-	wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
-	if (IS_ERR(wdt->src_clk)) {
-		dev_err_probe(dev, PTR_ERR(wdt->src_clk),
-			      "failed to get source clock\n");
-		ret = PTR_ERR(wdt->src_clk);
-		goto err_bus_clk;
-	}
-
-	ret = clk_prepare_enable(wdt->src_clk);
-	if (ret) {
-		dev_err(dev, "failed to enable source clock\n");
-		goto err_bus_clk;
-	}
+	wdt->src_clk = devm_clk_get_optional_enabled(dev, "watchdog_src");
+	if (IS_ERR(wdt->src_clk))
+		return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed to get source clock\n");
 
 	wdt->wdt_device.min_timeout = 1;
 	wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
@@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 				 S3C2410_WATCHDOG_DEFAULT_TIME);
 		} else {
 			dev_err(dev, "failed to use default timeout\n");
-			goto err_src_clk;
+			return ret;
 		}
 	}
 
@@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 			       pdev->name, pdev);
 	if (ret != 0) {
 		dev_err(dev, "failed to install irq (%d)\n", ret);
-		goto err_src_clk;
+		return ret;
 	}
 
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
@@ -744,7 +726,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret)
-		goto err_src_clk;
+		return ret;
 
 	ret = s3c2410wdt_enable(wdt, true);
 	if (ret < 0)
@@ -766,12 +748,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
  err_unregister:
 	watchdog_unregister_device(&wdt->wdt_device);
 
- err_src_clk:
-	clk_disable_unprepare(wdt->src_clk);
-
- err_bus_clk:
-	clk_disable_unprepare(wdt->bus_clk);
-
 	return ret;
 }
 
@@ -786,9 +762,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 
 	watchdog_unregister_device(&wdt->wdt_device);
 
-	clk_disable_unprepare(wdt->src_clk);
-	clk_disable_unprepare(wdt->bus_clk);
-
 	return 0;
 }
 
-- 
2.39.1

