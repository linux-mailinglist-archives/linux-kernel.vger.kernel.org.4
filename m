Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1FA67D01E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjAZPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjAZPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:25:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F55135
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:24:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL47Q-0003PY-0r; Thu, 26 Jan 2023 16:24:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL47P-000aX9-H2; Thu, 26 Jan 2023 16:24:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pL47N-00G480-82; Thu, 26 Jan 2023 16:24:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: Remove .enable() and .disable() callbacks
Date:   Thu, 26 Jan 2023 16:24:29 +0100
Message-Id: <20230126152429.580539-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pV2BidT0feAIyeBEspjcy30xYnKaHoEsk8l5/awmPCM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj0psnMYkX/HfjLaG5pxCLOuu8G1E8Ll92J14zgJam DZdrXxSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY9KbJwAKCRDB/BR4rcrsCZ74B/ 43ldylWmazDaiYNUhyBTYsARF/DTQePuukj/rpl/ghdMa5chE8SoB07gUrWqdnbpFdP0geMmtfV2/f 1cgHSviiZHYCVOsUOh0J50QmJlVV1Mn9In+e1xn/sSKizimogZMAPpmYWoQ1J2vfyK0UYAZqUgYq16 UE/+FhAvd++6EBULmNw9R0u403OJg0U8jcuBQLZFlaDxVVQd/T011tudaEW+KBBRzRnLc6hWJ0YXmf 5pMF5Cuah+NqXKeopivPBru6zaDp6R796MQKV8Xx8/WWf1+b5twI0JZfU2siL76BivdDVct/KQBVnA pqmu0L6XPUQWnZsD+uQ7lvYTiYqcaG
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

With commit dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers") the last
mfd driver that makes use of these callbacks is gone. The corresponding
functions mfd_cell_enable() and mfd_cell_disable() are also unused
(apart from the leds-asic3 driver that cannot be enabled any more after
the above mentioned remove and will/should be deleted, too).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mfd-core.c   | 26 --------------------------
 include/linux/mfd/core.h | 12 ------------
 2 files changed, 38 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 16d1861e9682..695d50b3bac6 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -33,32 +33,6 @@ static struct device_type mfd_dev_type = {
 	.name	= "mfd_device",
 };
 
-int mfd_cell_enable(struct platform_device *pdev)
-{
-	const struct mfd_cell *cell = mfd_get_cell(pdev);
-
-	if (!cell->enable) {
-		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
-		return 0;
-	}
-
-	return cell->enable(pdev);
-}
-EXPORT_SYMBOL(mfd_cell_enable);
-
-int mfd_cell_disable(struct platform_device *pdev)
-{
-	const struct mfd_cell *cell = mfd_get_cell(pdev);
-
-	if (!cell->disable) {
-		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
-		return 0;
-	}
-
-	return cell->disable(pdev);
-}
-EXPORT_SYMBOL(mfd_cell_disable);
-
 #if IS_ENABLED(CONFIG_ACPI)
 struct match_ids_walk_data {
 	struct acpi_device_id *ids;
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 14ca7b471576..dac04793e194 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -68,9 +68,6 @@ struct mfd_cell {
 	int			id;
 	int			level;
 
-	int			(*enable)(struct platform_device *dev);
-	int			(*disable)(struct platform_device *dev);
-
 	int			(*suspend)(struct platform_device *dev);
 	int			(*resume)(struct platform_device *dev);
 
@@ -123,15 +120,6 @@ struct mfd_cell {
 	int			num_parent_supplies;
 };
 
-/*
- * Convenience functions for clients using shared cells.  Refcounting
- * happens automatically, with the cell's enable/disable callbacks
- * being called only when a device is first being enabled or no other
- * clients are making use of it.
- */
-extern int mfd_cell_enable(struct platform_device *pdev);
-extern int mfd_cell_disable(struct platform_device *pdev);
-
 /*
  * Given a platform device that's been created by mfd_add_devices(), fetch
  * the mfd_cell that created it.

base-commit: dd77f5fa97d3b2b066743647aad080314c476d74
-- 
2.39.0

