Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CEC6AAB4D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCDQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCDQ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:56:59 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF5812F29;
        Sat,  4 Mar 2023 08:56:58 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l2so3811343ilg.7;
        Sat, 04 Mar 2023 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677949018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHhEJVEVzLbDVPR+ROK20RK4K6MlBOfgj289iHs9gU8=;
        b=Y1aqvHe5PU4IB69r3bRAP6PbuXYJyil0hzZH2e1oumTsiO0cpIgcSwKJARNBVv+sZ+
         wlMkTK3Hfph0qZSPdFkghXdW2uNM+y75lQilOOdUcwXRF2kRKFqrrBldQCRIx2uip2Uq
         vGfb83a1tDsYGAfdhp18v3UE27yk6YrsceuUqKXAbbyfTvIvcR8FniaBd0vCsJPRq6kz
         RrTEo4Pavqf6fVgWVELGg1LaskPAxolDuuLehIQY5oEHwhpX45MDHjEOmmYgBckge/Qd
         iSpJcVVZcDrlwQfv9cJz82JlGVcHRQb7Gl14Eol89njt/HVBaQraUFPVJal3vNn1u6G/
         1y9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677949018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHhEJVEVzLbDVPR+ROK20RK4K6MlBOfgj289iHs9gU8=;
        b=DVtOGd61FX93FewmqKGrAZD2XDRz0IPFHjQOoCeXFjLA7wkNDeWtU6+axDCAYXqpas
         4aUd5+lEM9ivOUn0S0LrtqXnjYzksP80YYxwMOazWVCI4VL31ILVB3ugu1QZakSxE7yR
         HE/Xb3f8ShlecKqQboBtm27E3nzOyvlBk1hYDWqoPqWd29JmcNW+TrWAFyKypSiSF9MN
         cdJVoHrS94XtzXPyanZGjtOYtfQUib39wUf76TqAXZH73/fyxLOyqipYXHAgCBlEfOS0
         /NYx3CuDxl3txF9x3uKdJzxkdpn8G43DakRCLnVYVcm4xQB2Wwk9oFuf99rjS4taqAcA
         ldlQ==
X-Gm-Message-State: AO0yUKUx/3O2haBiB7CvaAPrhI9R4L6Q/e1NH0CUY+UObY8TJxJqnccP
        5X8/EPYuAxC4hNSUtaPQVpg=
X-Google-Smtp-Source: AK7set8HNAYpV75qv/aHc3DCVpUZt9UazbUxX9z1XkSHC4ogijZZcyZzS+4Zk0HVYuTj3IRbSOWzXA==
X-Received: by 2002:a92:c54f:0:b0:316:dcfd:1b6e with SMTP id a15-20020a92c54f000000b00316dcfd1b6emr5001055ilj.30.1677949018184;
        Sat, 04 Mar 2023 08:56:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2-20020a056638224200b003c4f55da7easm1712349jas.45.2023.03.04.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:56:57 -0800 (PST)
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
Subject: [PATCH 2/2] watchdog: s3c2410_wdt: Use devm_add_action_or_reset() to disable watchdog
Date:   Sat,  4 Mar 2023 08:56:53 -0800
Message-Id: <20230304165653.2179835-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230304165653.2179835-1-linux@roeck-us.net>
References: <20230304165653.2179835-1-linux@roeck-us.net>
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

Use devm_add_action_or_reset() to disable the watchdog when the driver
is removed to simplify the code. With this in place, we can use
devm_watchdog_register_device() to register the watchdog, and the removal
function is no longer necessary.

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/s3c2410_wdt.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index a1fcb79b0b7c..58b262ca4e88 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -623,6 +623,11 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 	return variant;
 }
 
+static void s3c2410wdt_wdt_disable_action(void *data)
+{
+	s3c2410wdt_enable(data, false);
+}
+
 static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -724,13 +729,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		s3c2410wdt_stop(&wdt->wdt_device);
 	}
 
-	ret = watchdog_register_device(&wdt->wdt_device);
+	ret = devm_watchdog_register_device(dev, &wdt->wdt_device);
 	if (ret)
 		return ret;
 
 	ret = s3c2410wdt_enable(wdt, true);
 	if (ret < 0)
-		goto err_unregister;
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, s3c2410wdt_wdt_disable_action, wdt);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, wdt);
 
@@ -744,25 +753,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		 (wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
 
 	return 0;
-
- err_unregister:
-	watchdog_unregister_device(&wdt->wdt_device);
-
-	return ret;
-}
-
-static int s3c2410wdt_remove(struct platform_device *dev)
-{
-	int ret;
-	struct s3c2410_wdt *wdt = platform_get_drvdata(dev);
-
-	ret = s3c2410wdt_enable(wdt, false);
-	if (ret < 0)
-		return ret;
-
-	watchdog_unregister_device(&wdt->wdt_device);
-
-	return 0;
 }
 
 static void s3c2410wdt_shutdown(struct platform_device *dev)
@@ -817,7 +807,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(s3c2410wdt_pm_ops,
 
 static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
-	.remove		= s3c2410wdt_remove,
 	.shutdown	= s3c2410wdt_shutdown,
 	.id_table	= s3c2410_wdt_ids,
 	.driver		= {
-- 
2.39.1

