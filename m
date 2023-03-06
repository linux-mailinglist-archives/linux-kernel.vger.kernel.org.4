Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6326AB95E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCFJJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCFJJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:09:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0230D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:09:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qV-0006Z1-Aj; Mon, 06 Mar 2023 10:09:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qS-002D7b-5J; Mon, 06 Mar 2023 10:09:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qR-002coJ-DJ; Mon, 06 Mar 2023 10:09:23 +0100
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
Subject: [PATCH 1/3] watchdog: s3c2410_wdt: Fold s3c2410_get_wdt_drv_data() into only caller
Date:   Mon,  6 Mar 2023 10:09:17 +0100
Message-Id: <20230306090919.2206871-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
 <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3200; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lj5t3wNRO7XsqzB4cma/lRTjY8uSN/9hStGd2iSEk5E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBa2zmOGaDQVvRj/gbuA7yEV3QfmYNkBZ3uhry t2L2XShaWeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWtswAKCRDB/BR4rcrs CYmIB/4+5Zobt6Otp1mApAi4z3QQ48GLlCPbQZ+LH6otu4XjU37ivPUZFR//S+wUML8rgJDCirM bPjEZOr9hIvHAotaj7JfGrt90tfoYsQ1AhxdJ97aeqw8JdtWuC8vVtanxF9JwDHvP9hbp4BUV5j RHdA+RhwvxAjbIyM+3h9+L54b4gPV2QOAcniiQjQT3hNY9xNooC5Au9PIYx1gumJ9SfcEouo5Am pkdn8ceEOZMZmNuJCclRILy1Em5uj12UjgzurQ0sNve4+FyYvZgExYf716Vf8GVaOMiID/1RSub pAhPMmLP1Sd4XWjoKB4sRcVtVJHD3mj+YcAJUggY4pu1PWth
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s3c2410_get_wdt_drv_data() is only called by s3c2410wdt_probe(), so the
implementation of the former can move to the latter.

scripts/bloat-o-meter reports for this change (on an ARCH=arm
allmodconfig build):

	add/remove: 1/1 grow/shrink: 0/2 up/down: 4/-129 (-125)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/s3c2410_wdt.c | 70 +++++++++++++++-------------------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 58b262ca4e88..7382bf038161 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -579,11 +579,27 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 	return 0;
 }
 
-static inline const struct s3c2410_wdt_variant *
-s3c2410_get_wdt_drv_data(struct platform_device *pdev)
+static void s3c2410wdt_wdt_disable_action(void *data)
+{
+	s3c2410wdt_enable(data, false);
+}
+
+static int s3c2410wdt_probe(struct platform_device *pdev)
 {
-	const struct s3c2410_wdt_variant *variant;
 	struct device *dev = &pdev->dev;
+	const struct s3c2410_wdt_variant *variant;
+	struct s3c2410_wdt *wdt;
+	unsigned int wtcon;
+	int wdt_irq;
+	int ret;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	wdt->dev = dev;
+	spin_lock_init(&wdt->lock);
+	wdt->wdt_device = s3c2410_wdd;
 
 	variant = of_device_get_match_data(dev);
 	if (!variant) {
@@ -597,56 +613,30 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 	if (variant == &drv_data_exynos850_cl0 ||
 	    variant == &drv_data_exynosautov9_cl0) {
 		u32 index;
-		int err;
 
-		err = of_property_read_u32(dev->of_node,
+		ret = of_property_read_u32(dev->of_node,
 					   "samsung,cluster-index", &index);
-		if (err) {
+		if (ret) {
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
-				&drv_data_exynos850_cl1 :
-				&drv_data_exynosautov9_cl1;
+			if (variant == &drv_data_exynos850_cl0)
+				variant = &drv_data_exynos850_cl1;
+			else
+				variant = &drv_data_exynosautov9_cl1;
+			break;
 		default:
 			dev_err(dev, "wrong cluster index: %u\n", index);
-			return NULL;
+			return -EINVAL;
 		}
 	}
 #endif
-
-	return variant;
-}
-
-static void s3c2410wdt_wdt_disable_action(void *data)
-{
-	s3c2410wdt_enable(data, false);
-}
-
-static int s3c2410wdt_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct s3c2410_wdt *wdt;
-	unsigned int wtcon;
-	int wdt_irq;
-	int ret;
-
-	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
-	if (!wdt)
-		return -ENOMEM;
-
-	wdt->dev = dev;
-	spin_lock_init(&wdt->lock);
-	wdt->wdt_device = s3c2410_wdd;
-
-	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
-	if (!wdt->drv_data)
-		return -EINVAL;
+	wdt->drv_data = variant;
 
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
-- 
2.39.1

