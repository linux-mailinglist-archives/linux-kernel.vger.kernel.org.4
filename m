Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFA568E159
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBGTgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBGTgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:36:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F213B655
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:36:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTlh-0002Ed-5t; Tue, 07 Feb 2023 20:36:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTlf-003Lyz-3z; Tue, 07 Feb 2023 20:36:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTlf-001f1F-5t; Tue, 07 Feb 2023 20:36:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] clocksource: sh_tmu: Mark driver as non-removable
Date:   Tue,  7 Feb 2023 20:36:14 +0100
Message-Id: <20230207193614.472060-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=afhwFKHRjhQ+oOEhse1rmYXhTcETjLrPHQTUdsZj0bc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj4qgrFqzYI6Osku9IVoAZG+RGoTT/q6ylKX/lqW5T 9aDGHiOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY+KoKwAKCRDB/BR4rcrsCafcB/ sEVBACqsLCa429wTvBKpOmPWXp8LfXJ4x8aBdrRodxeOahqecDjWAaXqpcgGS7yCty4xmyuBE7/UkL 6qir37XunUl9hf+mRlTS38fQh2aOF0rB0JqTzpCuk2F5VhI4sgLgZjvjYt4caS9mcgLg9xy5xXi0t7 pINVvGNjoaYTKwR9JDT8VvTjpBnvkbzCzWX4cDHEm/vV4QC3TGPaKOE9zNNwBbHNzcc4lVekIuGloO ZjWSQbWdQpDiIKuwa1uFv+zt+U5QMBj1df0rX3EH/AqVgGLLYdfAkIiH8OXIJTxz1Ar13ivqMrE2I+ ABqcAwAEFOBnHzLMxH+3M7ONYbS2lV
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
The only remaining way to unbind a sh_tmu device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/sh_tmu.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b00dec0655cb..932f31a7c5be 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -632,11 +632,6 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sh_tmu_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct platform_device_id sh_tmu_id_table[] = {
 	{ "sh-tmu", SH_TMU },
 	{ "sh-tmu-sh3", SH_TMU_SH3 },
@@ -652,10 +647,10 @@ MODULE_DEVICE_TABLE(of, sh_tmu_of_table);
 
 static struct platform_driver sh_tmu_device_driver = {
 	.probe		= sh_tmu_probe,
-	.remove		= sh_tmu_remove,
 	.driver		= {
 		.name	= "sh_tmu",
 		.of_match_table = of_match_ptr(sh_tmu_of_table),
+		.suppress_bind_attrs = true,
 	},
 	.id_table	= sh_tmu_id_table,
 };

base-commit: 05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
-- 
2.39.0

