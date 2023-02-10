Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC4A692932
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjBJVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233662AbjBJVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:25:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB877717B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:25:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pQatm-00051h-EQ; Fri, 10 Feb 2023 22:25:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pQatk-0044kf-9R; Fri, 10 Feb 2023 22:25:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pQatk-002Wu8-NF; Fri, 10 Feb 2023 22:25:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] power: supply: max77650: Make max77650_charger_disable() return void
Date:   Fri, 10 Feb 2023 22:25:28 +0100
Message-Id: <20230210212528.179627-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9HU0mBVgWFq+rDTBjOFEA+YWiBjHNDyR6odYSBx4LSg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj5rZE9Ao5hJmCZpIKQalsouTWFAF1UY8SPQLoigyk pg3Hp7SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY+a2RAAKCRDB/BR4rcrsCbQnB/ 9QH4egcBSji0n5A9yEYjpHSQlKKTFbMmmMsRTHKAvKLqTvanprOUoM+SxnSNnUvlrOcGQbDhzmkY92 vDG+/HGX1WRyqYwhh5UngKMHvkNlUchngg9S8CaMcuHNmfn99fpQUHIHfCnJX2/Dr0+RseTqkh+K8Z pO87vRACeQNc2rrBHyXrIEwnUWMTTX63BwmY+a9FXzwM8Qn+fgMDrVRxrappZY3H6J2soASxz/Rmk3 aOC+/rmw2DYsqUBgDdOj7A1qtdhSljwuKrpqHhMrfdSYziw203pizLWW10ddYSezf4RUPYPLlclGnm 6iaXed1veYv4O2HDalN/mqYHh6KHX8
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

The return value of max77650_charger_disable() is ignored by all but one
caller. That one caller propagates the error code in the platform driver's
remove function. The only effect of that is that the driver core emits
a generic error message (but still removes the device). As
max77650_charger_disable() already emits an error message, this can better
be changed to return zero.

This is a preparation for making struct platform_driver::remove return
void, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/power/supply/max77650-charger.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/max77650-charger.c b/drivers/power/supply/max77650-charger.c
index d913428bedc0..e8c25da40ab2 100644
--- a/drivers/power/supply/max77650-charger.c
+++ b/drivers/power/supply/max77650-charger.c
@@ -141,7 +141,7 @@ static int max77650_charger_enable(struct max77650_charger_data *chg)
 	return rv;
 }
 
-static int max77650_charger_disable(struct max77650_charger_data *chg)
+static void max77650_charger_disable(struct max77650_charger_data *chg)
 {
 	int rv;
 
@@ -151,8 +151,6 @@ static int max77650_charger_disable(struct max77650_charger_data *chg)
 				MAX77650_CHARGER_DISABLED);
 	if (rv)
 		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
-
-	return rv;
 }
 
 static irqreturn_t max77650_charger_check_status(int irq, void *data)
@@ -351,7 +349,9 @@ static int max77650_charger_remove(struct platform_device *pdev)
 {
 	struct max77650_charger_data *chg = platform_get_drvdata(pdev);
 
-	return max77650_charger_disable(chg);
+	max77650_charger_disable(chg);
+
+	return 0;
 }
 
 static const struct of_device_id max77650_charger_of_match[] = {

base-commit: 4f72a263e162938de26866b862ed6015f5725946
-- 
2.39.0

