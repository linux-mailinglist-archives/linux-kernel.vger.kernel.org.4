Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590B16B6803
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCLQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4F366A0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLy-0007p5-1f; Sun, 12 Mar 2023 17:15:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-003f2I-Cf; Sun, 12 Mar 2023 17:15:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-004K8d-88; Sun, 12 Mar 2023 17:15:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/30] clk: fixed-rate: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:52 +0100
Message-Id: <20230312161512.2715500-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1718; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=po8EXvs+7kHg+zX81YA98XCvTJMed7ODKE0yUfz1NMA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfo7HhZVAZ7xgnVadaKVWiVIjah3rnTnbXaAg kP/auTHxkWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36OwAKCRDB/BR4rcrs CQBoB/970blcFnob82f3+cSBAU22kQDO9u+2fsoXotCRpnYOj8hZiZlU4Wu6W9SbSmJCwzSVbnQ p2Dp7GP3jfWchSOHVqCuLlUw16EEO2rMEHPxNWsP28CSow3Z4bGVM2rX5M4on/0VH+NQWg7rBu2 aKN3w1WCFLc6lwB9MfY63O7uOBov17HVfth8EqORFgvtHucvDczHepS6hT/ZZkrluu74Kk1GAIC Ye7ujDgMZt/eQx7R5iuzFoKrWKxzRm7OoSJ2yIbPw0pfSdrKTRgrKZpKojH+Z23GOfOYWGUR8pa 0rX+eMLhDZmVKxCbWeCtLxJ4F9HMELZJ6yNPKPIyfMuEk+fr
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
 drivers/clk/clk-fixed-rate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index 7d775954e26d..3481eb8cdeb3 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -196,14 +196,12 @@ void __init of_fixed_clk_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(fixed_clk, "fixed-clock", of_fixed_clk_setup);
 
-static int of_fixed_clk_remove(struct platform_device *pdev)
+static void of_fixed_clk_remove(struct platform_device *pdev)
 {
 	struct clk_hw *hw = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(pdev->dev.of_node);
 	clk_hw_unregister_fixed_rate(hw);
-
-	return 0;
 }
 
 static int of_fixed_clk_probe(struct platform_device *pdev)
@@ -234,7 +232,7 @@ static struct platform_driver of_fixed_clk_driver = {
 		.of_match_table = of_fixed_clk_ids,
 	},
 	.probe = of_fixed_clk_probe,
-	.remove = of_fixed_clk_remove,
+	.remove_new = of_fixed_clk_remove,
 };
 builtin_platform_driver(of_fixed_clk_driver);
 #endif
-- 
2.39.1

