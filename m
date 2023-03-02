Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF66A8486
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCBOsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCBOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818463C7B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-0003uM-L8; Thu, 02 Mar 2023 15:47:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001Lrl-WB; Thu, 02 Mar 2023 15:47:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-001Zq7-9v; Thu, 02 Mar 2023 15:47:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/29] platform/x86: huawei-wmi: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:16 +0100
Message-Id: <20230302144732.1903781-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JW33fHxe/kBQW6ZFF7MD4WNhh5dcbkzNNcJmCnfisT4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALa62P3XEguYN3LFWtRFAPXnn3mTTVM9Ih3OS W2S3s+MZOyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2ugAKCRDB/BR4rcrs CUG0B/4+91kpU48HWypHlPmj2zLHU604Su/U8sc8tUAY3raE7VC/7zqriN00C9aqji+N3U4ds3d tdMsDO66a4eH+FJv4CKAVTaCCj2zHxoRNWuvw7pvzvsv+T3mg8Xiynjjr/sCvi/599yrdnNvxHA uwNBRlDShBVe7elB5ZP6F0zawQ8b3b6P1tcNoDtRDVMOxqdJwUMpjCHrIqsv8u8zUWB+cgm7Stc lT2Uzb0MQ/gkiPyBEmsf6Q8aGgH1lJ0hmrGQFk3dJ6UoIAESrJRC5rPPEOj4LXRAKau73f2HY3b ByESQh3fWqY1niisUV8udhiTQ6sC64wYvei5t28EjzLC701+
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
 drivers/platform/x86/huawei-wmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 2df1b2d5e3ea..70e5c4c0574d 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -830,7 +830,7 @@ static int huawei_wmi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int huawei_wmi_remove(struct platform_device *pdev)
+static void huawei_wmi_remove(struct platform_device *pdev)
 {
 	const struct wmi_device_id *guid = huawei_wmi_events_id_table;
 
@@ -846,8 +846,6 @@ static int huawei_wmi_remove(struct platform_device *pdev)
 		huawei_wmi_battery_exit(&pdev->dev);
 		huawei_wmi_fn_lock_exit(&pdev->dev);
 	}
-
-	return 0;
 }
 
 static struct platform_driver huawei_wmi_driver = {
@@ -855,7 +853,7 @@ static struct platform_driver huawei_wmi_driver = {
 		.name = "huawei-wmi",
 	},
 	.probe = huawei_wmi_probe,
-	.remove = huawei_wmi_remove,
+	.remove_new = huawei_wmi_remove,
 };
 
 static __init int huawei_wmi_init(void)
-- 
2.39.1

