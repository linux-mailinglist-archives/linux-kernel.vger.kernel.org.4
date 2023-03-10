Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D36B54AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjCJWm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjCJWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:42:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3A214DA10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:41:42 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQg-0002dB-Cc; Fri, 10 Mar 2023 23:41:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003GqN-Ss; Fri, 10 Mar 2023 23:41:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1palQe-003uEY-3g; Fri, 10 Mar 2023 23:41:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] bus: fsl-mc: dprc: Push down error message from fsl_mc_driver_remove()
Date:   Fri, 10 Mar 2023 23:41:24 +0100
Message-Id: <20230310224128.2638078-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
References: <20230310224128.2638078-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zyomHc/a8RjH8rB16Pl7Aa7f3JBTHoJGdtnzhJxLWMk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkC7IFde5cyfUUkluP5sb7EamLPCdvIGyRB0CDc 6qzXQhBDUqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAuyBQAKCRDB/BR4rcrs CbADB/9d/5bLFRXln06G6ARKHRV+gcjOlv4P0ca124EZ6TwrRFHYRbbXlkHt9INfzPIPHT7CS9f MkH+Dh01R5ZH+tmMcArElHWhm3c0nJGcySFZgTsZCH/+SJX5wCk+gHXRGWHWX8G6ATfvQ5eiQr5 53Q1y0De1BXCmJBdW29mm4GN5PLcdteL7oVKRJIYY+y41vtGXXxdwQAKv5nTZi9S4bcRe8GZmGe IM2JeI1mzP++cK2M6UCdd7KPCU7GTuhhQ6IoF35iA+JPHe8kV9dqtV83702BPxxVVPAgGmrKOTu eoNge9LwTl84FvjOIFkLuaHIg6EBzbeczfHkA1TO7Sx153Ra
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

The error message emitted in fsl_mc_driver_remove() is very generic.
Replace it by a message that mentions the reason for the failure.

Returning zero instead of a negative value has no side effect apart from
suppressing the generic error message.

The first if condition in dprc_remove() can never be true, as this would
prevent successful probing of the device and then .remove wasn't called.
So this can just be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/bus/fsl-mc/dprc-driver.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 4c84be378bf2..ef4f43f67b80 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -839,11 +839,10 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 {
 	struct fsl_mc_bus *mc_bus = to_fsl_mc_bus(mc_dev);
 
-	if (!is_fsl_mc_bus_dprc(mc_dev))
-		return -EINVAL;
-
-	if (!mc_bus->irq_resources)
-		return -EINVAL;
+	if (!mc_bus->irq_resources) {
+		dev_err(&mc_dev->dev, "No irq resources, so unbinding the device failed\n");
+		return 0;
+	}
 
 	if (dev_get_msi_domain(&mc_dev->dev))
 		dprc_teardown_irq(mc_dev);
-- 
2.39.1

