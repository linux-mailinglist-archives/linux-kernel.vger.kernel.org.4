Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5768E137
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjBGTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjBGTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:30:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3256F34032
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:30:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTfg-0001Jg-4v; Tue, 07 Feb 2023 20:30:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTfe-003Lw7-5I; Tue, 07 Feb 2023 20:30:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pPTfe-001f0B-Ky; Tue, 07 Feb 2023 20:30:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] clocksource: em_sti: Mark driver as non-removable
Date:   Tue,  7 Feb 2023 20:30:10 +0100
Message-Id: <20230207193010.469495-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1533; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xWky83UVbDs3U7xsklzu4J26bU89FAvP72/120mKghk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj4qa/XOLrE4HohTQuYtMSEZKT5EVA766EqYoT1gZU xeA2gMqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY+KmvwAKCRDB/BR4rcrsCYNqB/ 96Oetl/NgUCLlz5RCD0Sr/+ErBlDWWWBPi1eGRTJuGIHJy62dyq/PkLFo6FEZMVPtUyXBUzIYoKaAV QhBc2L6h1wQalwRl5y6WQ0I5G2q72l56hrMDl6hl/9gkstBGyqF6qh2BNkMMq9gaQpbgq8aAL7bGYr dYCVSdsWm2xokewmtfKLjbcwC8FGkEzZZMWgDnRbIMy22FQKkVukLt99UM1UwVa5kD78jvbDzNPI3w xK6nQ75D92fdG3bzAUqLwFVAxG+83XH1qYtMs/9BMsdkTT6moH99SsJ1v2L4MxbOlXiVBqwm/xVmhu Ev0/prh4vKcFPlk5i5VNZVobyypbLF
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
The only remaining way to unbind a em_sti device would be module
unloading, but that doesn't apply here, as the driver cannot be built as
a module.

Also drop the useless remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/em_sti.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index ab190dffb1ed..c04b47bd4868 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -333,11 +333,6 @@ static int em_sti_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int em_sti_remove(struct platform_device *pdev)
-{
-	return -EBUSY; /* cannot unregister clockevent and clocksource */
-}
-
 static const struct of_device_id em_sti_dt_ids[] = {
 	{ .compatible = "renesas,em-sti", },
 	{},
@@ -346,10 +341,10 @@ MODULE_DEVICE_TABLE(of, em_sti_dt_ids);
 
 static struct platform_driver em_sti_device_driver = {
 	.probe		= em_sti_probe,
-	.remove		= em_sti_remove,
 	.driver		= {
 		.name	= "em_sti",
 		.of_match_table = em_sti_dt_ids,
+		.suppress_bind_attrs = true,
 	}
 };
 

base-commit: 05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
-- 
2.39.0

