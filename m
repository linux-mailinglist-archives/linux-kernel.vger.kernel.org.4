Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035D66AB6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCFG6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCFG6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:58:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7E05BA3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:58:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4n1-0003SU-N9; Mon, 06 Mar 2023 07:57:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4n0-002BSL-Dm; Mon, 06 Mar 2023 07:57:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4mz-002a96-FG; Mon, 06 Mar 2023 07:57:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: imx: Don't skip cleanup in remove's error path
Date:   Mon,  6 Mar 2023 07:57:32 +0100
Message-Id: <20230306065733.2170662-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
References: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Xm+yZrkh4S8C1VCzyMDCcqXn5ZR5uzRWQ2sqBLvmDxs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBY7VSY7j7q9ToQTI6dhRV3Q92jHaEoF5ANkzG /u0NU++ptSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWO1QAKCRDB/BR4rcrs CVkTCACKsKJAjTeu+OvOwzDFygO7Nad/jsqDGT+MDVh+iP9eh1QTP3sAFj9H+fcn5tSR9UxbAPS qgQ7yaIW1L+gq8pfodhVU8q+6sgVwYBAYBsjyL4ittlKTTCeqoXn2lFMyeC5LB92RI0qK6tOY1Z PbmNzLspFVzLTfE00F4q+BWTBZT/qmLC+2jt/rD3/FP5AZXVFzrskj6U1XoNKwYeiHRhkZIUSVs N/GKG1avm7AhZIX6dIZXm33p/hgt3eR2h4997fZqGkFM7dPr4EamdYTK9QpoRCmHwkXW393dzO3 2YIrK9IjRpokaHmpx2KLjg8DwnGwJn2bKnGTA1cZfJEtC3MC
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

Returning early in a platform driver's remove callback is wrong. In this
case the dma resources are not released in the error path. this is never
retried later and so this is a permanent leak. To fix this, only skip
hardware disabling if waking the device fails.

Fixes: d593574aff0a ("spi: imx: do not access registers while clocks disabled")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-imx.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e4ccd0c329d0..6c9c87cd14ca 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1856,13 +1856,11 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	spi_unregister_controller(controller);
 
-	ret = pm_runtime_resume_and_get(spi_imx->dev);
-	if (ret < 0) {
-		dev_err(spi_imx->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	writel(0, spi_imx->base + MXC_CSPICTRL);
+	ret = pm_runtime_get_sync(spi_imx->dev);
+	if (ret >= 0)
+		writel(0, spi_imx->base + MXC_CSPICTRL);
+	else
+		dev_warn(spi_imx->dev, "failed to enable clock, skip hw disable\n");
 
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_put_sync(spi_imx->dev);
-- 
2.39.1

