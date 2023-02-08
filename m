Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526068E640
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBHCsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjBHCsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:48:17 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ACC26868;
        Tue,  7 Feb 2023 18:48:15 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBPZ56mMhz6FK2X;
        Wed,  8 Feb 2023 10:48:13 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3182m21w077937;
        Wed, 8 Feb 2023 10:48:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 10:48:03 +0800 (CST)
Date:   Wed, 8 Feb 2023 10:48:03 +0800 (CST)
X-Zmail-TransId: 2af963e30d634e00a959
X-Mailer: Zmail v1.0
Message-ID: <202302081048037733713@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <tsbogend@alpha.franken.de>
Cc:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIXSBNSVBTOiBwY2ktbXQ3NjIwOiBVc2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3182m21w077937
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E30D6D.002 by FangMail milter!
X-FangMail-Envelope: 1675824493/4PBPZ56mMhz6FK2X/63E30D6D.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E30D6D.002/4PBPZ56mMhz6FK2X
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 arch/mips/pci/pci-mt7620.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index e032932348d6..2700d75d41c5 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -282,21 +282,17 @@ static int mt7628_pci_hw_init(struct platform_device *pdev)

 static int mt7620_pci_probe(struct platform_device *pdev)
 {
-	struct resource *bridge_res = platform_get_resource(pdev,
-							    IORESOURCE_MEM, 0);
-	struct resource *pcie_res = platform_get_resource(pdev,
-							  IORESOURCE_MEM, 1);
 	u32 val = 0;

 	rstpcie0 = devm_reset_control_get_exclusive(&pdev->dev, "pcie0");
 	if (IS_ERR(rstpcie0))
 		return PTR_ERR(rstpcie0);

-	bridge_base = devm_ioremap_resource(&pdev->dev, bridge_res);
+	bridge_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(bridge_base))
 		return PTR_ERR(bridge_base);

-	pcie_base = devm_ioremap_resource(&pdev->dev, pcie_res);
+	pcie_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(pcie_base))
 		return PTR_ERR(pcie_base);

-- 
2.25.1
