Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9736A8492
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCBOtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCBOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2753C32
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDg-00045Y-9l; Thu, 02 Mar 2023 15:47:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-001Lsj-1f; Thu, 02 Mar 2023 15:47:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDe-001Zqz-A7; Thu, 02 Mar 2023 15:47:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 27/29] platform/x86: serial-multi-instantiate: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:30 +0100
Message-Id: <20230302144732.1903781-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zZdMBuHYK98FB0/gRnuDVS6LFfhuk4IBzInMCTmznJA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALb1rvceOGPBsIzcSYQ/ZFLJcwFZMlPe0/ZcU 7fMoesuAWWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC29QAKCRDB/BR4rcrs CS7/B/0bdPvjYrFNATZEQCmNbthFqiFhuxnRTvZN+E0wDqVtaT2CbcJSjHSy3aohyBK95vdj9/R 7WuH6QrYjEgh2JhkBIABMfcFNX9WW0Bu2vB7CO9Lix4idGxV2eb7BgMrVZoB5Cc21FtRULd9OnZ KmttsreCmRbBoyH5VOyaM89tAtbVBvrhTrXBA/tXOjQRqEHOtnX+WoeJfMXvfGEunRllDOM45H+ 7QpuQlnuwk1B46v2MB0z4MyFg0orhkS5YFbsUIrJ5talKoynhSlIENRpc0n/ondSjv4bmBUL7Nf MQhlA9LWraaOMM7XWp194iNSAvfVQWGF3JpjriASL0NVMcF/
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
 drivers/platform/x86/serial-multi-instantiate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 5362f1a7b77c..cd25125b7923 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -265,13 +265,11 @@ static int smi_probe(struct platform_device *pdev)
 	}
 }
 
-static int smi_remove(struct platform_device *pdev)
+static void smi_remove(struct platform_device *pdev)
 {
 	struct smi *smi = platform_get_drvdata(pdev);
 
 	smi_devs_unregister(smi);
-
-	return 0;
 }
 
 static const struct smi_node bsg1160_data = {
@@ -339,7 +337,7 @@ static struct platform_driver smi_driver = {
 		.acpi_match_table = smi_acpi_ids,
 	},
 	.probe = smi_probe,
-	.remove = smi_remove,
+	.remove_new = smi_remove,
 };
 module_platform_driver(smi_driver);
 
-- 
2.39.1

