Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A96B67FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCLQPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCLQP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F636689
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-0007oS-CL; Sun, 12 Mar 2023 17:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f22-Oq; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-004K8T-Qs; Sun, 12 Mar 2023 17:15:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/30] clk: fixed-factor: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:50 +0100
Message-Id: <20230312161512.2715500-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M5YJcNdD/5hndGzQS3LgoQpQyz7z0G0HAcs9i/Jf418=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfovHqWbj7JZFPDet7+eKJZmO9elyLEyrjbgw 0lSwq5jTPeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36LwAKCRDB/BR4rcrs CUVjB/9hy8p80nnMmzUBJm4S9UNrcO1YO/GMo86/vZIOXLWwJ9PHfIMZjbYmALSvm+QmHEdthO/ a7N5QDv24kdHsLlDlLkxd9AvLh6nBsDchutGMwZM2EwELSSnlpoOoLyCX3eurEU3OM+BCiRSs7R RR5LSwCsTU86lEgjILzz1yk9miUoUowOdCvgSiiQUGx/jWPc/uBNgkZR/5K0jJm8WxNZTxbD1cV XkwfNa/inoEcx2l2cZUyn5FRLL2TtjjLJeQwplx9cShx1RDEH9cDT5574mFA1xPVywSb757Uv0c Y7F67O1JhKfy7VNTkrs1sXxGQv6HIj0h5fxIc5sV+UneSelm
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
 drivers/clk/clk-fixed-factor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index f734e34735a9..b3e66202b942 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -297,14 +297,12 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
 CLK_OF_DECLARE(fixed_factor_clk, "fixed-factor-clock",
 		of_fixed_factor_clk_setup);
 
-static int of_fixed_factor_clk_remove(struct platform_device *pdev)
+static void of_fixed_factor_clk_remove(struct platform_device *pdev)
 {
 	struct clk_hw *clk = platform_get_drvdata(pdev);
 
 	of_clk_del_provider(pdev->dev.of_node);
 	clk_hw_unregister_fixed_factor(clk);
-
-	return 0;
 }
 
 static int of_fixed_factor_clk_probe(struct platform_device *pdev)
@@ -336,7 +334,7 @@ static struct platform_driver of_fixed_factor_clk_driver = {
 		.of_match_table = of_fixed_factor_clk_ids,
 	},
 	.probe = of_fixed_factor_clk_probe,
-	.remove = of_fixed_factor_clk_remove,
+	.remove_new = of_fixed_factor_clk_remove,
 };
 builtin_platform_driver(of_fixed_factor_clk_driver);
 #endif
-- 
2.39.1

