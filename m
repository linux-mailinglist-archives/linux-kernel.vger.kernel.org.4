Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D956C30F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCULyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjCULyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:54:36 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E725E11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:54:14 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Pgql84qhtz6FK2W;
        Tue, 21 Mar 2023 19:54:12 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 32LBs0tj095231;
        Tue, 21 Mar 2023 19:54:00 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 21 Mar 2023 19:54:04 +0800 (CST)
Date:   Tue, 21 Mar 2023 19:54:04 +0800 (CST)
X-Zmail-TransId: 2afa64199adc41a-04a79
X-Mailer: Zmail v1.0
Message-ID: <202303211954042531445@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <miquel.raynal@bootlin.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtdGQ6IHJhd25hbmQ6IGZzbWM6IHVzZcKgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlX2J5bmFtZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32LBs0tj095231
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64199AE4.000/4Pgql84qhtz6FK2W
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource_byname(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource_byname(), as this is exactly what
this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 6b2bda815b88..cb2eb6a79043 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -1041,25 +1041,21 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_data");
-	host->data_va = devm_ioremap_resource(&pdev->dev, res);
+	host->data_va = devm_platform_ioremap_resource_byname(pdev, "nand_data");
 	if (IS_ERR(host->data_va))
 		return PTR_ERR(host->data_va);

 	host->data_pa = (dma_addr_t)res->start;

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_addr");
-	host->addr_va = devm_ioremap_resource(&pdev->dev, res);
+	host->addr_va = devm_platform_ioremap_resource_byname(pdev, "nand_addr");
 	if (IS_ERR(host->addr_va))
 		return PTR_ERR(host->addr_va);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "nand_cmd");
-	host->cmd_va = devm_ioremap_resource(&pdev->dev, res);
+	host->cmd_va = devm_platform_ioremap_resource_byname(pdev, "nand_cmd");
 	if (IS_ERR(host->cmd_va))
 		return PTR_ERR(host->cmd_va);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fsmc_regs");
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource_byname(pdev, "fsmc_regs");
 	if (IS_ERR(base))
 		return PTR_ERR(base);

-- 
2.25.1
