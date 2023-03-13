Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DFE6B708E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCMH5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCMH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EC359F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-0001jC-Ui; Mon, 13 Mar 2023 08:54:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-003nam-6T; Mon, 13 Mar 2023 08:54:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-004TOj-DO; Mon, 13 Mar 2023 08:54:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 4/5] clocksource: timer-tegra186: Convert to platform remove callback returning void
Date:   Mon, 13 Mar 2023 08:54:29 +0100
Message-Id: <20230313075430.2730803-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1785; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fWROh41pLFAOOuaiIIcU6R9zdNm1DYH76BDFy3r52HE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDtavHL7WtDQHc1rbvZJIqcgl0K9PqzTyycMnC 6Nf5KH11GuJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA7WrwAKCRDB/BR4rcrs CWQLB/41/1OCgtQxaLErB4WJV6Ma17tE20bSAkkJok3pVc7CSdHeSW8eNf9kjC3KRUrj2ligs4l LIVuFA/HaxYHMAL4Yl6HqF7MIn/4xMfvbIN0H1EP/hgfBA+2dfwJcd4DsLQnIPTqGTcRSI7qmbB gjXgAvzizCICokkN1p7zKo97Nki8sgv5AGB0w89dZKRXh3IAWVCYJv4xP3rLlsYjg6fwD37jW1z 86yfBkfSrGKOuJLbsLmiHr40+xsMfDItTmlVvcS2cFckywqhSVydAjn5/tryyJqkSk102PhkH0c /6GUqM5+8JqrVQuQIZ3+iWbv7vuN16/sc7nsxUipYgkOw9bB
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

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-tegra186.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index ea742889ee06..ccc762d32422 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -447,15 +447,13 @@ static int tegra186_timer_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int tegra186_timer_remove(struct platform_device *pdev)
+static void tegra186_timer_remove(struct platform_device *pdev)
 {
 	struct tegra186_timer *tegra = platform_get_drvdata(pdev);
 
 	clocksource_unregister(&tegra->usec);
 	clocksource_unregister(&tegra->osc);
 	clocksource_unregister(&tegra->tsc);
-
-	return 0;
 }
 
 static int __maybe_unused tegra186_timer_suspend(struct device *dev)
@@ -505,7 +503,7 @@ static struct platform_driver tegra186_wdt_driver = {
 		.of_match_table = tegra186_timer_of_match,
 	},
 	.probe = tegra186_timer_probe,
-	.remove = tegra186_timer_remove,
+	.remove_new = tegra186_timer_remove,
 };
 module_platform_driver(tegra186_wdt_driver);
 
-- 
2.39.1

