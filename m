Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4746A848A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCBOs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCBOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1881E4AFF5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-0003wi-RA; Thu, 02 Mar 2023 15:47:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDd-001Ls8-6f; Thu, 02 Mar 2023 15:47:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDc-001ZqQ-CS; Thu, 02 Mar 2023 15:47:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alex Hung <alexhung@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/29] platform/x86: intel: hid: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:21 +0100
Message-Id: <20230302144732.1903781-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=p4w/9jtnouAyp1eJo+WIbJu5c+ULhR1tWYCbbhAgbEQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALbQOhcPWcexTWxY+NygINDuhyhOrXEYL7UuX i8rHZtG85aJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC20AAKCRDB/BR4rcrs CVcZB/9ye3KjcLu2a/DViU2kheftVNv5tc/U1GNDD6KzGERttB0ZaDXLvKKV6Rao1sIUIv92EPD ZhPDsMxLQbTx41TXu++iOuClbFkdLrqcSdQ1KEAfwNN1OAjkC4ISoFXwiwfhS60bzKEaeeV3EXz n59/YK4GC0CcwaWiKStFFMMmd2wHPmLS+OUwYn0eqvOPzD4yGgDGOq0U4hdNCEsbcNcbKGstptg 5urT4R8O5moRmjUn3LQ0e5A7LjS8gNU833MpvaOxiuinScybD4MV9Gn5IwkSjWIBJReTWyMcEee CpIdXq7Dz1u76ekXzZhKLCF9oEzIbnjCxS4vXl/nhYXHj+y7
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
 drivers/platform/x86/intel/hid.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index b6c06b37862e..5632bd3c534a 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -720,7 +720,7 @@ static int intel_hid_probe(struct platform_device *device)
 	return err;
 }
 
-static int intel_hid_remove(struct platform_device *device)
+static void intel_hid_remove(struct platform_device *device)
 {
 	acpi_handle handle = ACPI_HANDLE(&device->dev);
 
@@ -728,12 +728,6 @@ static int intel_hid_remove(struct platform_device *device)
 	acpi_remove_notify_handler(handle, ACPI_DEVICE_NOTIFY, notify_handler);
 	intel_hid_set_enable(&device->dev, false);
 	intel_button_array_enable(&device->dev, false);
-
-	/*
-	 * Even if we failed to shut off the event stream, we can still
-	 * safely detach from the device.
-	 */
-	return 0;
 }
 
 static struct platform_driver intel_hid_pl_driver = {
@@ -743,7 +737,7 @@ static struct platform_driver intel_hid_pl_driver = {
 		.pm = &intel_hid_pl_pm_ops,
 	},
 	.probe = intel_hid_probe,
-	.remove = intel_hid_remove,
+	.remove_new = intel_hid_remove,
 };
 
 /*
-- 
2.39.1

