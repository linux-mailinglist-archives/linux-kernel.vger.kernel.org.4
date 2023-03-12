Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5323E6B6822
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjCLQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCLQPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217A9367C4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-0007sf-Uk; Sun, 12 Mar 2023 17:15:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM1-003f3d-Bl; Sun, 12 Mar 2023 17:15:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-004K9h-4q; Sun, 12 Mar 2023 17:15:24 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Tero Kristo <kristo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/30] clk: ti: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:09 +0100
Message-Id: <20230312161512.2715500-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+eDcQI6Zb4aIs7d9bJFFkkDfJcRJeMKqXpNyUgVrxUw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfqAWH+TKlTmHEM6RxOYZ9/tjSDti0OgQsMd8 3lfr5mcv2GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36gAAKCRDB/BR4rcrs CUW0B/4jNY4NiHQmjbgaA87O5C1kRpCQk+LmocZoMsFOsC0tZJxOkF/iopdO1LZvnd6RO/TFNtL 4sHa7kuYCq4fzdCigy8ArkO4qcv3qjWbHjtF9IaIkRnfFQ5Q1xwqfuonhrhGANm/Lc9l823UMGV VMqyTVphe/dudZ8iH2wbqbyXsxosUjCbDg54p1tVjIRr9NwPsx8gc5ecRq4oP61hOcXBVXY2Z3g waRxdIPA0Pgllstt5/4O3iQl/Yd8o3L5a0lGs4x2Ov/sA8RjdSmqqOXwrxTfTE0MEjVhIACueWD AOC1aazeB2ueFvzfFAzgZPKfA4u1IKoDpyUS6Y2BNREilAg6
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
 drivers/clk/ti/adpll.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index f5e7e2049241..6ecbba4342c5 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -931,13 +931,11 @@ static int ti_adpll_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ti_adpll_remove(struct platform_device *pdev)
+static void ti_adpll_remove(struct platform_device *pdev)
 {
 	struct ti_adpll_data *d = dev_get_drvdata(&pdev->dev);
 
 	ti_adpll_free_resources(d);
-
-	return 0;
 }
 
 static struct platform_driver ti_adpll_driver = {
@@ -946,7 +944,7 @@ static struct platform_driver ti_adpll_driver = {
 		.of_match_table = ti_adpll_match,
 	},
 	.probe = ti_adpll_probe,
-	.remove = ti_adpll_remove,
+	.remove_new = ti_adpll_remove,
 };
 
 static int __init ti_adpll_init(void)
-- 
2.39.1

