Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD546B680F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCLQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:15:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38134C05
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:15:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-0007ns-M1; Sun, 12 Mar 2023 17:15:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLw-003f1i-13; Sun, 12 Mar 2023 17:15:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbOLu-004K8B-Nd; Sun, 12 Mar 2023 17:15:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/30] clk: xilinx: Drop if block with always false condition
Date:   Sun, 12 Mar 2023 17:14:45 +0100
Message-Id: <20230312161512.2715500-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2l2y8Hwodd04VIsYFpyJCISjEEwoZDOvzxOqN6nZXvo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDfod91tRBqw4DTMu5AWaEo9bEyJsVu3RB1JsZ RWLXfZAPzqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA36HQAKCRDB/BR4rcrs CYLQB/kBUyFOTio3WkuzOw5MVnPnA08KyRaoE2EbydF8Q8XsArHNbkcU3FJ5xcKZrp6Zzp5GEWX mQfdDhOSXU0ZZTqxHdyVTxnuGbylhwOzJ/AEdxk61lIv24FRljrXwxuagRKBDYflJ4bcWMrJQ7+ tNjWDsO/yeGt5ocCPxd0ooStsRxYsp5vkEH7u8kYHivIcjoB62r7xnBb0QhgblXy8Z0jErrNM6D RayhTythzWRkOXOT3Df75a/qJOSp8Wwrds9XHFeaxeFnxx42MUoISeaMO3jD5yMxMPPLfp9L1+0 iTLKlXFHqZx1/iUjGMhh+bapytf0MENIF530tsPU0uFPZr1Q
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

xvcu_remove() is only called for a device after after xvcu_probe()
completed successfully. In that case dev_set_drvdata() was called for
that device with a non-NULL parameter, so platform_get_drvdata() won't
return NULL and the if condition is never true.

Drop the if, preparing a conversion to make platform driver's remove
callback return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clk/xilinx/xlnx_vcu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index d66b1315114e..54b44debfd3e 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -707,8 +707,6 @@ static int xvcu_remove(struct platform_device *pdev)
 	struct xvcu_device *xvcu;
 
 	xvcu = platform_get_drvdata(pdev);
-	if (!xvcu)
-		return -ENODEV;
 
 	xvcu_unregister_clock_provider(xvcu);
 
-- 
2.39.1

