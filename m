Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854E46B681A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCLQQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCLQPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040138657
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-0007rd-Ux; Sun, 12 Mar 2023 17:15:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOM0-003f3E-8A; Sun, 12 Mar 2023 17:15:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLz-004K9T-8F; Sun, 12 Mar 2023 17:15:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/30] clk: renesas: Convert to platform remove callback returning void
Date:   Sun, 12 Mar 2023 17:15:05 +0100
Message-Id: <20230312161512.2715500-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tzqGylDHbl27wcUMOwx5LcyyO3qR6CT6GQOUrE4n8uI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfpzhc9DGdlNQXDJPhSJsCsYs2TOV5jF1d5hw yu2lPbJe4aJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36cwAKCRDB/BR4rcrs CQ9cB/9knQE1XSI+voDSdAHXVAQAjkGufgnbJqy5Tl+3jY8fUIfJXz8TfLnQIuVUcTJxmNvAwOp gAmsnUWgkCCQotILcUr9AlqNtMZ0YWcVzFNlbisomip0eYlVVWvBfritzehTm8KVSk+knsI9/oh SBdar3Tp/pdV/5lvtEMAgDW/ypB97a6EmynYkyZU9XfXfXyWi+nJxgXhXMOY/dMADyK8An1AePT sHP/xpNQfK81hJcbTkFfTOTGyCBdH7ZAovgFYFdw62KeLasb/HpAyfQ4RpzuvwIlsVXHWiZjfte IpyatPMvkyjLphcuuD/THA+q+Dp2B4HvjcMXKNTZn2jb4L1u
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
 drivers/clk/renesas/rcar-usb2-clock-sel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
index 684d8937965e..17c110978e33 100644
--- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
+++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
@@ -125,15 +125,13 @@ static int rcar_usb2_clock_sel_resume(struct device *dev)
 	return 0;
 }
 
-static int rcar_usb2_clock_sel_remove(struct platform_device *pdev)
+static void rcar_usb2_clock_sel_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
 	of_clk_del_provider(dev->of_node);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
-
-	return 0;
 }
 
 static int rcar_usb2_clock_sel_probe(struct platform_device *pdev)
@@ -215,7 +213,7 @@ static struct platform_driver rcar_usb2_clock_sel_driver = {
 		.pm	= &rcar_usb2_clock_sel_pm_ops,
 	},
 	.probe		= rcar_usb2_clock_sel_probe,
-	.remove		= rcar_usb2_clock_sel_remove,
+	.remove_new	= rcar_usb2_clock_sel_remove,
 };
 builtin_platform_driver(rcar_usb2_clock_sel_driver);
 
-- 
2.39.1

