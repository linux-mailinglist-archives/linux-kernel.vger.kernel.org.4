Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9706C4020
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCVCHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:07:14 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026D43936
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:07:13 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PhBgM4xLSz501bt;
        Wed, 22 Mar 2023 10:07:11 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32M273JH031716;
        Wed, 22 Mar 2023 10:07:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 10:07:04 +0800 (CST)
Date:   Wed, 22 Mar 2023 10:07:04 +0800 (CST)
X-Zmail-TransId: 2afa641a62c80ef-bb19c
X-Mailer: Zmail v1.0
Message-ID: <202303221007049346627@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <miquel.raynal@bootlin.com>
Cc:     <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwaHk6IG1hcnZlbGw6IHBoeS1tdmVidS1hMzcwMC1jb21waHk6IHVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2VfYnluYW1lKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M273JH031716
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641A62CF.005/4PhBgM4xLSz501bt
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
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
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index d641b345afa3..9aeeedf59f44 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -1241,7 +1241,6 @@ static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
 	struct mvebu_a3700_comphy_priv *priv;
 	struct phy_provider *provider;
 	struct device_node *child;
-	struct resource *res;
 	struct clk *clk;
 	int ret;

@@ -1251,26 +1250,19 @@ static int mvebu_a3700_comphy_probe(struct platform_device *pdev)

 	spin_lock_init(&priv->lock);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "comphy");
-	priv->comphy_regs = devm_ioremap_resource(&pdev->dev, res);
+	priv->comphy_regs = devm_platform_ioremap_resource_byname(pdev, "comphy");
 	if (IS_ERR(priv->comphy_regs))
 		return PTR_ERR(priv->comphy_regs);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "lane1_pcie_gbe");
-	priv->lane1_phy_regs = devm_ioremap_resource(&pdev->dev, res);
+	priv->lane1_phy_regs = devm_platform_ioremap_resource_byname(pdev, "lane1_pcie_gbe");
 	if (IS_ERR(priv->lane1_phy_regs))
 		return PTR_ERR(priv->lane1_phy_regs);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "lane0_usb3_gbe");
-	priv->lane0_phy_regs = devm_ioremap_resource(&pdev->dev, res);
+	priv->lane0_phy_regs = devm_platform_ioremap_resource_byname(pdev, "lane0_usb3_gbe");
 	if (IS_ERR(priv->lane0_phy_regs))
 		return PTR_ERR(priv->lane0_phy_regs);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "lane2_sata_usb3");
-	priv->lane2_phy_indirect = devm_ioremap_resource(&pdev->dev, res);
+	priv->lane2_phy_indirect = devm_platform_ioremap_resource_byname(pdev, "lane2_sata_usb3");
 	if (IS_ERR(priv->lane2_phy_indirect))
 		return PTR_ERR(priv->lane2_phy_indirect);

-- 
2.25.1
