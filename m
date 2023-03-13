Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AEE6B708D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjCMH46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMH40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE9554CAC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0x-0001jH-04; Mon, 13 Mar 2023 08:54:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-003nap-Bg; Mon, 13 Mar 2023 08:54:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-004TOn-Il; Mon, 13 Mar 2023 08:54:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] clocksource: timer-ti-dm: Convert to platform remove callback returning void
Date:   Mon, 13 Mar 2023 08:54:30 +0100
Message-Id: <20230313075430.2730803-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jWLwC9JWT1zAkN3MuVmGacjm0Ju2XN58CNDdUcULjW0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDtayowyjk/IGAmlFJ43CRKgvHOPq7G6WGJL55 GpXMyDV2KeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA7WsgAKCRDB/BR4rcrs CWXEB/9i8nksWGfGxjcU5//fTFQp0JrVL+aYr3XZNVBokMVlPNHovvmtXwb0ar6hVrucmdOaQHc HQbvBRj+FQSk1WtmBTgEF2wZWZGfY0FXFEvKHIguHvUYn5EHxB5b4VaOO/ZXbSOGBT7TEPcABA4 JZ31uuaja0mtksTBiwKJ1Z7VRc/m7FRUfWhVgUNIxfiAj8ulaYkciidGmEhhsbFp/mI4qpFmrRa 4SaPqeKVWPF5duWabzo5KDd1Fvm4VVd+6Oaeg21ORxpcuogQUXcbk3eKYRWCKLUtcrxcoVh4lea lQ4bqwekXbs5usuzy+hIv+AuE36wL46ttE4fjAIOSONntrze
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/clocksource/timer-ti-dm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 098562bda487..ab7a6caa36c5 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1177,7 +1177,7 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
  * In addition to freeing platform resources it also deletes the timer
  * entry from the local list.
  */
-static int omap_dm_timer_remove(struct platform_device *pdev)
+static void omap_dm_timer_remove(struct platform_device *pdev)
 {
 	struct dmtimer *timer;
 	unsigned long flags;
@@ -1199,8 +1199,6 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 
 	if (ret)
 		dev_err(&pdev->dev, "Unable to determine timer entry in list of drivers on remove\n");
-
-	return 0;
 }
 
 static const struct omap_dm_timer_ops dmtimer_ops = {
@@ -1275,7 +1273,7 @@ MODULE_DEVICE_TABLE(of, omap_timer_match);
 
 static struct platform_driver omap_dm_timer_driver = {
 	.probe  = omap_dm_timer_probe,
-	.remove = omap_dm_timer_remove,
+	.remove_new = omap_dm_timer_remove,
 	.driver = {
 		.name   = "omap_timer",
 		.of_match_table = omap_timer_match,
-- 
2.39.1

