Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C986F1150
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 07:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbjD1F2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 01:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjD1F2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 01:28:06 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4501FD4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 22:28:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VhA7VcY_1682659679;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VhA7VcY_1682659679)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 13:28:00 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, vkoul@kernel.org, kishon@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] phy: freescale: imx8m-pcie: Use devm_platform_ioremap_resource()
Date:   Fri, 28 Apr 2023 13:27:58 +0800
Message-Id: <20230428052758.38636-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(),devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index afc63552ecaf..d4c92498ad1e 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -206,7 +206,6 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct imx8_pcie_phy *imx8_phy;
-	struct resource *res;
 
 	imx8_phy = devm_kzalloc(dev, sizeof(*imx8_phy), GFP_KERNEL);
 	if (!imx8_phy)
@@ -259,8 +258,7 @@ static int imx8_pcie_phy_probe(struct platform_device *pdev)
 				      "Failed to get PCIE PHY PERST control\n");
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	imx8_phy->base = devm_ioremap_resource(dev, res);
+	imx8_phy->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx8_phy->base))
 		return PTR_ERR(imx8_phy->base);
 
-- 
2.20.1.7.g153144c

