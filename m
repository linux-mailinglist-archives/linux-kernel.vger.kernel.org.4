Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA526B67ED
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjCLQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjCLQP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE3B34C14
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-0007nt-Nu; Sun, 12 Mar 2023 17:15:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f1m-33; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLv-004K8L-D6; Sun, 12 Mar 2023 17:15:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] clk: axi-clkgen: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:48 +0100
Message-Id: <20230312161512.2715500-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mKWm1tXjLyBA2SWXj77lTJC97AAz8dVbbZwONWNxxz0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfoprVMb78SIBnkb6CzMjA734MOUZDDgvGbwZ iDAVC4m6AKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36KQAKCRDB/BR4rcrs CfaJB/wO+xJeQ+MI+rcZY8q1XbpVZNCqDaAxpY5G5GuX8GyvvTXAAE6TetfA3Zaafkvko1OZnLq rzDp8Wc9HBs0KmRsMszYvFd47Dl6vodmfWpP8glXmUBBL9oVG84wN4AZ5tbshg8td/c0UDVJrJZ 4WBx538jrqzK16N1yfy0BYjRe5lbo9MYRabT6N2Ig72yDB3q3gRIUgfvbtPs5JDj6vxvPJtWlkF COXbgaT5jILLhUfdS7CZsvKVjWejoCPAs0LNRagV0euUI5vJr+GYpWLieMU35HE8H9e/6YbxvPN mBsIeWtymULMR7xthHfoayeB4MarC7t/j5EbYS0CvsonZaHS
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
 drivers/clk/clk-axi-clkgen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index ac6ff736ac8f..671bee55ceb3 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -557,11 +557,9 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 				      &axi_clkgen->clk_hw);
 }
 
-static int axi_clkgen_remove(struct platform_device *pdev)
+static void axi_clkgen_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-
-	return 0;
 }
 
 static const struct of_device_id axi_clkgen_ids[] = {
@@ -583,7 +581,7 @@ static struct platform_driver axi_clkgen_driver = {
 		.of_match_table = axi_clkgen_ids,
 	},
 	.probe = axi_clkgen_probe,
-	.remove = axi_clkgen_remove,
+	.remove_new = axi_clkgen_remove,
 };
 module_platform_driver(axi_clkgen_driver);
 
-- 
2.39.1

