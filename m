Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3D6B680B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCLQP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCLQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D1236084
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-0007qY-Qw; Sun, 12 Mar 2023 17:15:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-003f2x-7T; Sun, 12 Mar 2023 17:15:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-004K9F-G6; Sun, 12 Mar 2023 17:15:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/30] clk: mmp: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:02 +0100
Message-Id: <20230312161512.2715500-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6pAH+UlQsJo/x5+z/AfP2hBEHoK8zvT2mO6fM4gHPEg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpnn7BYRo2cl59zcHVpqNtPyPhNPPM0EICc3 jglvKFMQeqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36ZwAKCRDB/BR4rcrs CRT5B/9qBPDaix3jhVQTCAHH9a171DMXZmMx6Dmv1SYz3TpPt5iTVGA8iv7pBoL+6AfYjHaPIk6 EgnAwmQa+JvQOe37IxI2Av5oGTh3jtxzUQNdR6bocstqa34D443hb7BpGYy2w2MZX7vH6t5i9dw PcWC1AH16o00BAjfhD0J3CzXoptP9a29Y9UJve/bGd+KG0hlvzTCh9Z9ZN/QPm9LMX7A3JU1M/L eFCkCmZI8TF5vqA7B84+KabYxX7E+1zPm8YW96Q6yMOboUEikw31MbpG2/SDqycdDMw4wj1rLEl 9bYE5iSkGvO1f6OkjJKv2bSakUJhldvIlmVlyvbbxjfKLZQ0
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
 drivers/clk/mmp/clk-audio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
index 7aa7f4a9564f..6fb1aa9487b5 100644
--- a/drivers/clk/mmp/clk-audio.c
+++ b/drivers/clk/mmp/clk-audio.c
@@ -384,12 +384,10 @@ static int mmp2_audio_clk_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mmp2_audio_clk_remove(struct platform_device *pdev)
+static void mmp2_audio_clk_remove(struct platform_device *pdev)
 {
 	pm_clk_destroy(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -436,7 +434,7 @@ static struct platform_driver mmp2_audio_clk_driver = {
 		.pm = &mmp2_audio_clk_pm_ops,
 	},
 	.probe = mmp2_audio_clk_probe,
-	.remove = mmp2_audio_clk_remove,
+	.remove_new = mmp2_audio_clk_remove,
 };
 module_platform_driver(mmp2_audio_clk_driver);
 
-- 
2.39.1

