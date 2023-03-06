Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585976AB724
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCFHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:34:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0F1DBFA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:34:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N2-0008P1-MR; Mon, 06 Mar 2023 08:34:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N2-002C0w-2o; Mon, 06 Mar 2023 08:34:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N1-002bav-Bi; Mon, 06 Mar 2023 08:34:55 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] spmi: pmic-arb: Convert to platform remove callback returning void
Date:   Mon,  6 Mar 2023 08:34:46 +0100
Message-Id: <20230306073446.2194048-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=baC8Vc/YYIcpg5sQZ20fOmFcBz45wH3J4Jd35FckU7k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBZeRp+KOukWfnCDPaNKuarCheUCsR4j1f92CH 4fGT4kzvDeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWXkQAKCRDB/BR4rcrs CelrB/90x7/EalnevrxJZcp1D/0ZVT9Qwb22O7hv3KGfzxwXX+MNYARa1UkQRRESCFg/oMaykPC goVnkcez3yqNT8HCqOxInLxi5eI+yC1Rku0v4TevyrGeFGmpIiwb72WfL+A1vEiYJsXHbv1zX3g WwL8W7emEcTfMFnp3TJTtqz9I7r+kiEdCvvSV7lPvwODFyMsa1+kW4N9KnCvt358Y5hMOIbIgPM m65LMVO7D98Ws5pBzj7gACTCTuQvSrOIKhoDuMnEjNwGfa8BrmyQ1OAXXeJGbRTTtQj9ipQPaJ7 uN0IqJWcPIrH/8upCp3LZqB5daygZaQb/Fe03pblg6s9WeuZ
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
 drivers/spmi/spmi-pmic-arb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 8b6a42ab816f..42a593418aad 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1674,7 +1674,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int spmi_pmic_arb_remove(struct platform_device *pdev)
+static void spmi_pmic_arb_remove(struct platform_device *pdev)
 {
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -1682,7 +1682,6 @@ static int spmi_pmic_arb_remove(struct platform_device *pdev)
 	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
 	irq_domain_remove(pmic_arb->domain);
 	spmi_controller_put(ctrl);
-	return 0;
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
@@ -1693,7 +1692,7 @@ MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);
 
 static struct platform_driver spmi_pmic_arb_driver = {
 	.probe		= spmi_pmic_arb_probe,
-	.remove		= spmi_pmic_arb_remove,
+	.remove_new	= spmi_pmic_arb_remove,
 	.driver		= {
 		.name	= "spmi_pmic_arb",
 		.of_match_table = spmi_pmic_arb_match_table,
-- 
2.39.1

