Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18D96B028B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCHJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCHJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:13:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B432514
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:13:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZpr4-0005oM-Cg; Wed, 08 Mar 2023 10:13:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZpr3-002gNp-8N; Wed, 08 Mar 2023 10:13:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZpr2-003FWt-A4; Wed, 08 Mar 2023 10:13:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RESEND] mfd: Remove .enable() and .disable() callbacks
Date:   Wed,  8 Mar 2023 10:12:57 +0100
Message-Id: <20230308091257.2404932-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3138; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GUzxnTWsIXWW7Ki2l9BW5VirY/a2SUtcfWPyToSsUOY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkCFGV95AaBgJK4+4UaRi0abquVBWD1AJMlE/yO IfuAsdqC4qJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAhRlQAKCRDB/BR4rcrs CRwXB/9RqaAnWZo58atUMOIvJjM/L3vGJyxS01W/W8Q48QEY5YJO3SegE9Ht9HMKuEvS26NPpWY LTnrUzrwiOc98JXQguObVhIC6LNNC0qRUJ9R/Rpn1JrgWBGi/eK6bHW7IUoEm5fBgnOmBpCxWBZ D2nJEkBGx50WOpXOilMaN17DFPPKv2LPJ97l7EMTCffXnGnYCWyYlcjrX6vEfD3vwak1+mysiXg ttikg1RSbV6K0XW0/4iBMMt91eTgD/KruNs9NdbZyqrK3nQpOg6ijiJ5xs3B2mzZSq/1pbTZv18 i4Qs+cidrMK+IT9yKg64gkEARtI2b4oAgS3GpZ4tEeLe3pmh
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
mfd driver that implements these callbacks is gone and since commit
652719b1003a ("w1: remove ds1wm driver") the last user is gone. The
corresponding functions mfd_cell_enable() and mfd_cell_disable() are
also unused (since commit 0ca222c81977 ("leds: Remove asic3 driver")).

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mfd/mfd-core.c   | 26 --------------------------
 include/linux/mfd/core.h | 12 ------------
 2 files changed, 38 deletions(-)

Hello,

this patch was already sent in January. Back then however there were
still a few drivers making use of the enable and disable calls. In
v6.3-rc1 these are gone now and so it should be safe to apply this
patch.

The comment "Refcounting happens automatically, with the cell's
enable/disable callbacks being called only when a device is first being
enabled or no other clients are making use of it." is wrong. Should we
consider this patch a fix then? :-)

Best regards
Uwe

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

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

