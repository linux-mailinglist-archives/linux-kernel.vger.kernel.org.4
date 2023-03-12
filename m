Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC9E6B67FA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCLQPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C743669A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-0007ov-Tz; Sun, 12 Mar 2023 17:15:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLx-003f2C-8s; Sun, 12 Mar 2023 17:15:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-004K8k-LY; Sun, 12 Mar 2023 17:15:20 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] clk: palmas: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:14:54 +0100
Message-Id: <20230312161512.2715500-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zEZr6iE44gTKWVY3i3VQqSeHRxgblN9cAWTQGCH3j7U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpCxY8G+6AOtqpcGsR8pWvAP2L4zD2Z/iA2z O1CHq8ezi+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36QgAKCRDB/BR4rcrs CfIXB/sFFu8yMgEcJcHDsWKJXt/uzgNB5264hhGM3+xfDr7ZDaQYJwxRRhvZzYn2LFH3SNL3+Oh tvbUkxroxVrfr7mUwj4r6E9rAISFqDnmxj1lfKoA6e1ODz905EcF39bWP9nfsiRZa6aIZ/3c/GI 9Al6AIDuBcGmGX8lPmACB1RVwTwjRjfuoa1VoJAFWmHL3+JFBaoHVt1oGekQ3kAyq0gS/xSwrAV xPk8mDtHmUaDpRP/PDEyOYwvTWPkMm6x64KsdiXHeW/FMeaARSSd4HKE34tZwRsmlwLDdMONyIO uEwPxcj10UimYxGWYg9rwwLB//2zYIpFsq9bgEJj49HBsPqt
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
 drivers/clk/clk-palmas.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
index b8c3d0da1918..74a241b1e1f4 100644
--- a/drivers/clk/clk-palmas.c
+++ b/drivers/clk/clk-palmas.c
@@ -271,10 +271,9 @@ static int palmas_clks_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int palmas_clks_remove(struct platform_device *pdev)
+static void palmas_clks_remove(struct platform_device *pdev)
 {
 	of_clk_del_provider(pdev->dev.of_node);
-	return 0;
 }
 
 static struct platform_driver palmas_clks_driver = {
@@ -283,7 +282,7 @@ static struct platform_driver palmas_clks_driver = {
 		.of_match_table = palmas_clks_of_match,
 	},
 	.probe = palmas_clks_probe,
-	.remove = palmas_clks_remove,
+	.remove_new = palmas_clks_remove,
 };
 
 module_platform_driver(palmas_clks_driver);
-- 
2.39.1

