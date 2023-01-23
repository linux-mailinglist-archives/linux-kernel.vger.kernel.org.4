Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0C678A20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjAWWCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjAWWC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:02:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A991B75B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:02:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pK4tV-0006OK-Qq; Mon, 23 Jan 2023 23:02:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pK4tU-008A4k-Ed; Mon, 23 Jan 2023 23:02:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pK4tT-00FKzQ-Fc; Mon, 23 Jan 2023 23:02:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] clocksource/drivers/sh_cmt: Mark driver as non-removable
Date:   Mon, 23 Jan 2023 23:02:21 +0100
Message-Id: <20230123220221.48164-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+LZ+8HX+K947Qy1BXMUgF+Llkliggacmtec8irlFfsk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjzwPpbWZ0nGHe6nGBI7qAUnO3folNpNsXNatgw+GU Ut2MnPqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY88D6QAKCRDB/BR4rcrsCU6BB/ 0VROzzPWpDcv/g/MwIGwQOsNhuh0W75RbVWFiX51coKCs3n+cKQ9Z4CmFX2pdg0FHvwVyCBm2axm/Z 4YuKpyDPVAA9lCKISrayZxgDjKylU0swhPioWcK2n2FER5N1Tr+U0MXLM9u9W8MNB3UBxdmc2Yt4KJ vfOSm5anHRgOx/VHJzXcbkr/pCimHf3AMiOUcSCV1ScX/odmBrQwHjMDDULSarNp21nTlI0HBivJrm fm81XmHBiqAiYbb4Y3GhJQHrLmwKZhr2apTKvbJBNZmTKPXK9MY6N1+xNQ+U2RrfYAj2LQLceIxyYv ehNIMO0OyFKbc/kj3+RlbpE0RyxkfF
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

The comment in the remove callback suggests that the driver is not
supposed to be unbound. However returning an error code in the remove
callback doesn't accomplish that. Instead set the suppress_bind_attrs
property (which makes it impossible to unbind the driver via sysfs).
The only remaining way to unbind a sh_cmt device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/sh_cmt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 7b952aa52c0b..8b2e079d9df2 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -1145,17 +1145,12 @@ static int sh_cmt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sh_cmt_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static struct platform_driver sh_cmt_device_driver = {
 	.probe		= sh_cmt_probe,
-	.remove		= sh_cmt_remove,
 	.driver		= {
 		.name	= "sh_cmt",
 		.of_match_table = of_match_ptr(sh_cmt_of_table),
+		.suppress_bind_attrs = true,
 	},
 	.id_table	= sh_cmt_id_table,
 };

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.0

