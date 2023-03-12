Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138256B67F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCLQPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCLQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B63647E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-0007oG-9q; Sun, 12 Mar 2023 17:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f1x-LO; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-004K8W-0w; Sun, 12 Mar 2023 17:15:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/30] clk: fixed-mmio: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:51 +0100
Message-Id: <20230312161512.2715500-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=O3BSffUzhF87lbhZq01hmKO4dRQjYInCIMfdlJqnSog=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfoz3U7OH8B0N7C8Lm3dEzQKgOrJB5nNt0941 k45EdSkZqOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36MwAKCRDB/BR4rcrs CSh5B/92q6ddRUWfNxn8SXA3DJ5j/Um3zLfN4gOSGuKYxy2J13NUPww3p4QLMWNTWM2dP2muWee vkfO+duUem0jkgWH0poKrPyG06LSp4dWIIfLRvYI9DYAbZ/HsrfCnHny8OmDPKoPFlxFrSRuwWd 1If6FoEY7tvFudzmUekmY1Y9xdumwJzNR1m5diIVNDF7uK+9Sz7b47prh6cKR6LB4YRPfF3u9M7 0E5111dnP7z5pfkU25w31xuBlD6jnVoOveJ4NqgCChcD36spFvdxrMAthF10pGpgYnylhVHTvtC YU+ymau7Yg7s5NXLYS9SLssKd8qBAumQ4Hr5OPbYef+vbP9O
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
 drivers/clk/clk-fixed-mmio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
index 5225d17d6b3f..7435055670d2 100644
--- a/drivers/clk/clk-fixed-mmio.c
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -71,14 +71,12 @@ static int of_fixed_mmio_clk_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int of_fixed_mmio_clk_remove(struct platform_device *pdev)
+static void of_fixed_mmio_clk_remove(struct platform_device *pdev)
 {
 	struct clk_hw *clk = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(pdev->dev.of_node);
 	clk_hw_unregister_fixed_rate(clk);
-
-	return 0;
 }
 
 static const struct of_device_id of_fixed_mmio_clk_ids[] = {
@@ -93,7 +91,7 @@ static struct platform_driver of_fixed_mmio_clk_driver = {
 		.of_match_table = of_fixed_mmio_clk_ids,
 	},
 	.probe = of_fixed_mmio_clk_probe,
-	.remove = of_fixed_mmio_clk_remove,
+	.remove_new = of_fixed_mmio_clk_remove,
 };
 module_platform_driver(of_fixed_mmio_clk_driver);
 
-- 
2.39.1

