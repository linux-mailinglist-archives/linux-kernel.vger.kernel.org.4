Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF966AD910
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCGISS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCGIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:17:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC84FF2F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:17:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZSVk-0003g3-Lx; Tue, 07 Mar 2023 09:17:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF5-002Q7C-2R; Tue, 07 Mar 2023 07:56:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF4-002uCe-Fg; Tue, 07 Mar 2023 07:56:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/2] watchdog: s3c2410: Make s3c2410_get_wdt_drv_data() return an int
Date:   Tue,  7 Mar 2023 07:56:02 +0100
Message-Id: <20230307065603.2253054-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
References: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=QceFBbZEoT2r3QXkJtJmxaZbpUExXmHFUHw+BMJmhf0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBt/6TEKme0kmgt7JVegTZDxiYYug5SE4NxQih VPgYL2kE1OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAbf+gAKCRDB/BR4rcrs CXwpCAChkMnOmUimP9KpfnLPRyxLYVU2V1Brn39p4n9zCVkmYCCSPFmht0SwyRNaS9WAUJpfs7e uKZBJHf2fd07AcMrVn/Y5C286m6ohE9LXqc6bBCIx3+XVVztm/R/IFeRlhDSIDQkEUU3PV3qXyb boDmopsutluKy9t8sDh7QZL8Fh4cpxEzZ72ND7A0lLK7kLcsDWyt1Q7loRjdHq2Wuxn8e9HE6py HtHtSXb7Aq2lsnw9dnufMMwiNVlwSyMrnB9eBuhRLBp6a6sI/8Jlch1mPMY4AScl8BaKs01yawL TRSdgU+kGi4wCQGaYxTJa8sU0DbcGjTkhDmQ0CXl0cOLjmgw
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

This is a preparation for making more use of dev_err_probe(). The idea
is that s3c2410_get_wdt_drv_data() (as it's called only by .probe()) can
make effective use of dev_err_probe() only if it returns an int. For
that the assignment to wdt->drv_data has to happen in the function. The
caller can then just pass on the return value in the error case.

This seems to be nicer for the compiler: bloatometer reports for an
ARCH=arm s3c6400_defconfig build:

	add/remove: 1/1 grow/shrink: 0/1 up/down: 4/-64 (-60)
	Function                                     old     new   delta
	__initcall__kmod_s3c2410_wdt__209_821_s3c2410wdt_driver_init6       -       4      +4
	__initcall__kmod_s3c2410_wdt__209_819_s3c2410wdt_driver_init6       4       -      -4
	s3c2410wdt_probe                            1332    1272     -60

There is no semantical change. (Just one minor difference: Before this
patch wdt->drv_data was always assigned, now that only happens in the
non-error case. That doesn't matter however as *wdt is freed in the
error case.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 58b262ca4e88..f3de8ef499c3 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -579,8 +579,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 	return 0;
 }
 
-static inline const struct s3c2410_wdt_variant *
-s3c2410_get_wdt_drv_data(struct platform_device *pdev)
+static inline int
+s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
 {
 	const struct s3c2410_wdt_variant *variant;
 	struct device *dev = &pdev->dev;
@@ -603,24 +603,26 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 					   "samsung,cluster-index", &index);
 		if (err) {
 			dev_err(dev, "failed to get cluster index\n");
-			return NULL;
+			return -EINVAL;
 		}
 
 		switch (index) {
 		case 0:
-			return variant;
+			break;
 		case 1:
-			return (variant == &drv_data_exynos850_cl0) ?
+			variant = (variant == &drv_data_exynos850_cl0) ?
 				&drv_data_exynos850_cl1 :
 				&drv_data_exynosautov9_cl1;
+			break;
 		default:
 			dev_err(dev, "wrong cluster index: %u\n", index);
-			return NULL;
+			return -EINVAL;
 		}
 	}
 #endif
 
-	return variant;
+	wdt->drv_data = variant;
+	return 0;
 }
 
 static void s3c2410wdt_wdt_disable_action(void *data)
@@ -644,9 +646,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device = s3c2410_wdd;
 
-	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
-	if (!wdt->drv_data)
-		return -EINVAL;
+	ret = s3c2410_get_wdt_drv_data(pdev, wdt);
+	if (ret)
+		return ret;
 
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
-- 
2.39.1

