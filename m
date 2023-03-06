Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1096AB95B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCFJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCFJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:09:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79012D4A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:09:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qV-0006Z3-Ai; Mon, 06 Mar 2023 10:09:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qS-002D7e-Gd; Mon, 06 Mar 2023 10:09:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qR-002coP-R6; Mon, 06 Mar 2023 10:09:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 3/3] watchdog: s3c2410_wdt: Simplify using dev_err_probe()
Date:   Mon,  6 Mar 2023 10:09:19 +0100
Message-Id: <20230306090919.2206871-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=X99umvAVl7VrA7sYL0/YZrxlrH/9RZb/gUEAyYgz4uU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBa2651XONejSdHIex1gpZ2WT2RCV+XEY+Xe+J T1AhkqiZr+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWtugAKCRDB/BR4rcrs CZwTCACEC/Xx8sMzeOS/919McZTmtZCMZTSQZJF8VXu/vJkfazCTqqaJ0cRrzUpgs6oemPxQVTH 3hPG3At3UPxAOGThxdkGKE0uBit4WDpMcYJ1KyGOY6pZBTrdotzHTMj/RBjVIIVM+evpCgdj6/A t5Y7awPlj1F90mJSUUGO8Tk1LfSX+QSV8gSjFDWE0i79jGJRxohsJw214MJroqnATLvgCgsddY1 R17AsqrKGE4oq6B1aXWOiUeaVoztxtoeoEfBrMsF1vW2LXcaJD44Q30ynT0EjbO6pP+CmQQSM8C IJc0ms4m1EndJ+sn5KxC4fc9TSjb7rL22lW9H5k0KtuDvYmu
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
the error code and usually needs on line less to use as it combines
message emitting and error returning.

Apart from the reduction of line count, scripts/bloat-o-meter reports
for this change (on an ARCH=arm allmodconfig build):

	add/remove: 1/1 grow/shrink: 1/2 up/down: 32/-144 (-112)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/s3c2410_wdt.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 93df6ee331a0..c3b50266deab 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -616,10 +616,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
 		ret = of_property_read_u32(dev->of_node,
 					   "samsung,cluster-index", &index);
-		if (ret) {
-			dev_err(dev, "error %pe: failed to get cluster index\n", ERR_PTR(-EINVAL));
-			return -EINVAL;
-		}
+		if (ret)
+			return dev_err_probe(dev, -EINVAL, "failed to get cluster index\n");
 
 		switch (index) {
 		case 0:
@@ -631,8 +629,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 				variant = &drv_data_exynosautov9_cl1;
 			break;
 		default:
-			dev_err(dev, "error %pe: wrong cluster index: %u\n", ERR_PTR(-EINVAL), index);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL, "wrong cluster index: %u\n", index);
 		}
 	}
 #endif
@@ -641,10 +638,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						"samsung,syscon-phandle");
-		if (IS_ERR(wdt->pmureg)) {
-			dev_err(dev, "error %pe: syscon regmap lookup failed.\n", wdt->pmureg);
-			return PTR_ERR(wdt->pmureg);
-		}
+		if (IS_ERR(wdt->pmureg))
+			return dev_err_probe(dev, PTR_ERR(wdt->pmureg), "syscon regmap lookup failed.\n");
 	}
 
 	wdt_irq = platform_get_irq(pdev, 0);
@@ -682,21 +677,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	if (ret) {
 		ret = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
 					       S3C2410_WATCHDOG_DEFAULT_TIME);
-		if (ret == 0) {
+		if (ret == 0)
 			dev_warn(dev, "tmr_margin value out of range, default %d used\n",
 				 S3C2410_WATCHDOG_DEFAULT_TIME);
-		} else {
-			dev_err(dev, "error: %pe: failed to use default timeout\n", ERR_PTR(ret));
-			return ret;
-		}
+		else
+			return dev_err_probe(dev, ret, "failed to use default timeout\n");
 	}
 
 	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
 			       pdev->name, pdev);
-	if (ret != 0) {
-		dev_err(dev, "error: %pe: failed to install irq\n", ERR_PTR(ret));
-		return ret;
-	}
+	if (ret != 0)
+		return dev_err_probe(dev, ret, "failed to install irq\n");
 
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
 	watchdog_set_restart_priority(&wdt->wdt_device, 128);
-- 
2.39.1

