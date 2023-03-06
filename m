Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7296AB95F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCFJJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:09:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67E1985
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:09:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qV-0006Z4-Aj; Mon, 06 Mar 2023 10:09:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qS-002D7h-JA; Mon, 06 Mar 2023 10:09:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qR-002coM-Jt; Mon, 06 Mar 2023 10:09:23 +0100
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
Subject: [PATCH 2/3] watchdog: s3c2410_wdt: Unify error logging format in probe function
Date:   Mon,  6 Mar 2023 10:09:18 +0100
Message-Id: <20230306090919.2206871-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2391; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0wy6Dy0bHuq9AT7DkIaobmqRGVHmG+KhTNYskb2dtn8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBa22JhVhmITJILO59i+so650I69rUMjT4609C q72jCkU8EWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWttgAKCRDB/BR4rcrs CT6CB/oCAJExWw3gqAoAPs4ZmIvkNXaaagqyh+IRMVZZ4hEGJY/VpRTigM6WcMQOLOPlnFMTG83 hPuUzTeccJl04LrUVaUuhtlLeicjaaRyPGsUCdft3UKkofojSpG5sEYU/c89kqcBH8h2Ln0yps2 ZZWLuS9YgoOuME/4z9h7XS5wXqpRITBiI+C93y7lL0KK4LDCjtvA1acBW2yD6l7aK8HdFi556bs HJ7ahmZlgA/SwTyNzibVG1KgsanPUcq5GyYtXZTSHk2Xw6x3xZNeC6tPPb0pwcujuAVcPmpSh5T JlyqZyjPl2sxq9ztB3VRRBYVafF31SVP4XXSNP503EeUC7ig
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

In the probe function a mixture of dev_err() and dev_err_probe() is used.
Align the format of the error messages when dev_err() is used to that of
dev_err_probe() for consistency. Apart from consistency this also
mentions the human readable error code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/s3c2410_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 7382bf038161..93df6ee331a0 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -617,7 +617,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		ret = of_property_read_u32(dev->of_node,
 					   "samsung,cluster-index", &index);
 		if (ret) {
-			dev_err(dev, "failed to get cluster index\n");
+			dev_err(dev, "error %pe: failed to get cluster index\n", ERR_PTR(-EINVAL));
 			return -EINVAL;
 		}
 
@@ -631,7 +631,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 				variant = &drv_data_exynosautov9_cl1;
 			break;
 		default:
-			dev_err(dev, "wrong cluster index: %u\n", index);
+			dev_err(dev, "error %pe: wrong cluster index: %u\n", ERR_PTR(-EINVAL), index);
 			return -EINVAL;
 		}
 	}
@@ -642,7 +642,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						"samsung,syscon-phandle");
 		if (IS_ERR(wdt->pmureg)) {
-			dev_err(dev, "syscon regmap lookup failed.\n");
+			dev_err(dev, "error %pe: syscon regmap lookup failed.\n", wdt->pmureg);
 			return PTR_ERR(wdt->pmureg);
 		}
 	}
@@ -686,7 +686,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 			dev_warn(dev, "tmr_margin value out of range, default %d used\n",
 				 S3C2410_WATCHDOG_DEFAULT_TIME);
 		} else {
-			dev_err(dev, "failed to use default timeout\n");
+			dev_err(dev, "error: %pe: failed to use default timeout\n", ERR_PTR(ret));
 			return ret;
 		}
 	}
@@ -694,7 +694,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, wdt_irq, s3c2410wdt_irq, 0,
 			       pdev->name, pdev);
 	if (ret != 0) {
-		dev_err(dev, "failed to install irq (%d)\n", ret);
+		dev_err(dev, "error: %pe: failed to install irq\n", ERR_PTR(ret));
 		return ret;
 	}
 
-- 
2.39.1

