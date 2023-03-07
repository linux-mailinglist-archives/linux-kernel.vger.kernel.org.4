Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1FA6AD912
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCGIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCGISA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:18:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31AF509A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:17:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZSVk-0003g3-F5; Tue, 07 Mar 2023 09:17:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF5-002Q7K-GG; Tue, 07 Mar 2023 07:56:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF4-002uCh-KT; Tue, 07 Mar 2023 07:56:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/2] watchdog: s3c2410_wdt: Simplify using dev_err_probe()
Date:   Tue,  7 Mar 2023 07:56:03 +0100
Message-Id: <20230307065603.2253054-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
References: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SPTADogXAYTaKc+C78RKrrt7xUHnzCo6ao7xCudFxtA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBt/9TgrXqvneQq8BrEXsLFVQzyVJH8K0F3nGq Km8agAZpKqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAbf/QAKCRDB/BR4rcrs CT+rB/0akvpL8yOXpGcUlsq2sQ4ODnKHZohwUCZxgzMAFJaXYYx+LolOaUIeX6lIaLOb8UqkscH EL49wR/amDpifqzJt8EMkomj+MtPyK0G5lEoUqGQERtPAdnSUO+pZZ5+7d2jscyqHIjX0Sgt6s9 HRZtF9agfhV1MQC5ad4mliPQwVhNYSKQY0INXrdjFjfLYvJQZ11KGjc7V0CaUCofAR+lxcIJdmP DNUSWE5pC/zJa3jjythRIdvI1m5twkxV9xNv5pDa4BEJKzy62NP9aRVN5OpIIQNTjEohNHR3nIy I3bMg7o/Nu+dHB62pqIz1mkJrfgjht/aahKNB8ItncGBxvB+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of dev_err_probe() also for error paths that don't have to
handle -EPROBE_DEFER. While the code handing -EPROBE_DEFER isn't used
for these error paths, it still simpler as it cares for pretty printing
the error code and usually needs one code line less as it combines
message emitting and error returning. This also unifies the format of
the error messages.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/s3c2410_wdt.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index f3de8ef499c3..e14d6d9050ce 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -601,10 +601,8 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 
 		err = of_property_read_u32(dev->of_node,
 					   "samsung,cluster-index", &index);
-		if (err) {
-			dev_err(dev, "failed to get cluster index\n");
-			return -EINVAL;
-		}
+		if (err)
+			return dev_err_probe(dev, -EINVAL, "failed to get cluster index\n");
 
 		switch (index) {
 		case 0:
@@ -615,8 +613,7 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 				&drv_data_exynosautov9_cl1;
 			break;
 		default:
-			dev_err(dev, "wrong cluster index: %u\n", index);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL, "wrong cluster index: %u\n", index);
 		}
 	}
 #endif
@@ -653,10 +650,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						"samsung,syscon-phandle");
-		if (IS_ERR(wdt->pmureg)) {
-			dev_err(dev, "syscon regmap lookup failed.\n");
-			return PTR_ERR(wdt->pmureg);
-		}
+		if (IS_ERR(wdt->pmureg))
+			return dev_err_probe(dev, PTR_ERR(wdt->pmureg), "syscon regmap lookup failed.\n");
 	}
 
 	wdt_irq = platform_get_irq(pdev, 0);
@@ -694,21 +689,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (ret) {
 		ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
 					       S3C2410_WATCHDOG_DEFAULT_TIME);
-		if (ret == 0) {
+		if (ret == 0)
 			dev_warn(dev, "tmr_margin value out of range, default %d used\n",
 				 S3C2410_WATCHDOG_DEFAULT_TIME);
-		} else {
-			dev_err(dev, "failed to use default timeout\n");
-			return ret;
-		}
+		else
+			return dev_err_probe(dev, ret, "failed to use default timeout\n");
 	}
 
 	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
 			       pdev->name, pdev);
-	if (ret != 0) {
-		dev_err(dev, "failed to install irq (%d)\n", ret);
-		return ret;
-	}
+	if (ret != 0)
+		return dev_err_probe(dev, ret, "failed to install irq (%d)\n", ret);
 
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
 	watchdog_set_restart_priority(&wdt->wdt_device, 128);
-- 
2.39.1

