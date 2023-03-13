Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2080C6B708A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCMH4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCMH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:56:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3C52A16D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:54:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-0001jA-OO; Mon, 13 Mar 2023 08:54:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0w-003naj-2Z; Mon, 13 Mar 2023 08:54:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pbd0v-004TOg-8C; Mon, 13 Mar 2023 08:54:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] clocksource: timer-ti-dm: Improve error message in .remove
Date:   Mon, 13 Mar 2023 08:54:28 +0100
Message-Id: <20230313075430.2730803-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
References: <20230313075430.2730803-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JFLgDu9G0dZdZrBAfrFBT/sAvQRPGcgYsmNCWrrkkd0=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkDtascXVc4tZHw8XXjA2bAkq4kTxYDENhomOZK +lfPD6gXVyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZA7WrAAKCRDB/BR4rcrs Cf9aB/0a266jejUWRQymegTjmEjuZiTNzMbIA04dKu7N7B/DOuxscYf29RX4rb4hsDH2wF1JC3z MHImda86n2RmtQ86FtByfnd6z0472OrMwFKfbjj36Tr+a9CwKKdVV/uhIrMMZpBiNH4ri2BGeec 0Y+cXV/jkOP0BtqqzijXSP6jniz1eJejlCI+rmDm2LOnmjWc/rdX9i/mieTsdJpgBfEwnqKam1r IgiOevEHY6Et2eHeRWA++fnRzqOENRBYnnbdchp1nO+FcAyTxTRAxMcH0LoFdWLKt/K1TF2UX57 c7+dXBm8Q7gYXSZ5vDTGE+myKjGxJ0Nr+QEz4+fu6ZoOhaSL
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

If a platform driver's remove callback returns an error code, the driver
core emits a generic (and thus little helpful) error message.

Instead emit a more specifc error message about the actual error and
return zero to suppress the core's message.

Note that returning zero has no side effects apart from not emitting
said error message. This prepares converting platform driver's remove
message to return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-ti-dm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b24b903a8822..098562bda487 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1197,7 +1197,10 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	return ret;
+	if (ret)
+		dev_err(&pdev->dev, "Unable to determine timer entry in list of drivers on remove\n");
+
+	return 0;
 }
 
 static const struct omap_dm_timer_ops dmtimer_ops = {
-- 
2.39.1

