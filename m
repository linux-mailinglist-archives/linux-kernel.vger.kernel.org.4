Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76686BF998
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 12:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCRL3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 07:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 07:29:23 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910232B9C3;
        Sat, 18 Mar 2023 04:29:19 -0700 (PDT)
Received: from laboratory-MS-7D42.. ([10.12.190.56])
        (user=jingfelix@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 32IBSldC031417-32IBSldD031417
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Mar 2023 19:28:53 +0800
From:   Tianyi Jing <jingfelix@hust.edu.cn>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Tianyi Jing <jingfelix@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hwmon: fix ioremap and memremap leak
Date:   Sat, 18 Mar 2023 19:27:11 +0800
Message-Id: <20230318112711.1803167-1-jingfelix@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: jingfelix@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports:

drivers/hwmon/xgene-hwmon.c:757 xgene_hwmon_probe() warn:
'ctx->pcc_comm_addr' from ioremap() not released on line: 757.

This is because in drivers/hwmon/xgene-hwmon.c:701 xgene_hwmon_probe(),
ioremap and memremap is not released, which may cause a leak.

To fix this, iounmap and memunmap is added to line: 754. And the
declaration of 'version' is moved to xgene-hwmon.c:620 to help simplify
getting 'version' below.

Signed-off-by: Tianyi Jing <jingfelix@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/hwmon/xgene-hwmon.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 5cde837bfd09..44d1004ddacb 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -617,6 +617,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 	struct xgene_hwmon_dev *ctx;
 	struct mbox_client *cl;
 	int rc;
+	int version;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -655,7 +656,6 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 	} else {
 		struct pcc_mbox_chan *pcc_chan;
 		const struct acpi_device_id *acpi_id;
-		int version;
 
 		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
@@ -749,8 +749,15 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 out:
 	if (acpi_disabled)
 		mbox_free_channel(ctx->mbox_chan);
-	else
+	else {
+		if (ctx->comm_base_addr && ctx->pcc_comm_addr) {
+			if (version == XGENE_HWMON_V2)
+				iounmap(ctx->pcc_comm_addr);
+			else
+				memunmap(ctx->pcc_comm_addr);
+		}
 		pcc_mbox_free_channel(ctx->pcc_chan);
+	}
 out_mbox_free:
 	kfifo_free(&ctx->async_msg_fifo);
 
@@ -765,9 +772,22 @@ static int xgene_hwmon_remove(struct platform_device *pdev)
 	kfifo_free(&ctx->async_msg_fifo);
 	if (acpi_disabled)
 		mbox_free_channel(ctx->mbox_chan);
-	else
-		pcc_mbox_free_channel(ctx->pcc_chan);
+	else {
+		int version;
+		const struct acpi_device_id *acpi_id;
 
+		acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
+					    &pdev->dev);
+
+		version = (int)acpi_id->driver_data;
+
+		if (version == XGENE_HWMON_V2)
+			iounmap(ctx->pcc_comm_addr);
+		else
+			memunmap(ctx->pcc_comm_addr);
+
+		pcc_mbox_free_channel(ctx->pcc_chan);
+	}
 	return 0;
 }
 
-- 
2.34.1

