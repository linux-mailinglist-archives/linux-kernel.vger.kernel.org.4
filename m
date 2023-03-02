Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED6E6A8498
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjCBOtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjCBOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978AD4215
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDg-00046X-MP; Thu, 02 Mar 2023 15:47:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDf-001Lsv-Ep; Thu, 02 Mar 2023 15:47:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDe-001Zr7-Gn; Thu, 02 Mar 2023 15:47:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] platform/x86: wmi: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:31 +0100
Message-Id: <20230302144732.1903781-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vINht6ojUFDqgv3t7NnT5jRF+UmY6wpfnULDkHfIdto=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALb6O68NAGyM825FA1GeI2kBnh4ZSeuQ+fR2u yAw6iq7r0eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2+gAKCRDB/BR4rcrs Cc+XB/4lFYU8LTWGolMf3K0oUcggqVhrI+67SZELHpQlMDMfyWJX+LlcPKRSZmvYs3Q6T2nehtt JIJUBYSnoVPqTE/SpLPCR3cwK3rajXld6eDxKP1jX7ObtBVTaUK9nEuttiC+gsxjIiYp/Xzh9H9 2SncwaWdNIS0TWl5EwEm2mmtNH2mHdSxziFo70KxABJof7BJSBnsh/M9AIQgodLKhZeJ9/9IxOU F1z3xN45EF+Q7ukBSHC8Z5XKpfDJKoWYp/9DPg9WQEePE5MLfXUBKPw7MjooXPou9KX/1KMcf3j zZ1oPMkLQtH8l7H8MyZiUUl+DKDl72tGf8e1+m3sPI3EU3BQ
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
 drivers/platform/x86/wmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4fe7650dd014..d81319a502ef 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1369,7 +1369,7 @@ static void acpi_wmi_notify_handler(acpi_handle handle, u32 event,
 		event, 0);
 }
 
-static int acpi_wmi_remove(struct platform_device *device)
+static void acpi_wmi_remove(struct platform_device *device)
 {
 	struct acpi_device *acpi_device = ACPI_COMPANION(&device->dev);
 
@@ -1379,8 +1379,6 @@ static int acpi_wmi_remove(struct platform_device *device)
 				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
 	wmi_free_devices(acpi_device);
 	device_unregister(dev_get_drvdata(&device->dev));
-
-	return 0;
 }
 
 static int acpi_wmi_probe(struct platform_device *device)
@@ -1468,7 +1466,7 @@ static struct platform_driver acpi_wmi_driver = {
 		.acpi_match_table = wmi_device_ids,
 	},
 	.probe = acpi_wmi_probe,
-	.remove = acpi_wmi_remove,
+	.remove_new = acpi_wmi_remove,
 };
 
 static int __init acpi_wmi_init(void)
-- 
2.39.1

