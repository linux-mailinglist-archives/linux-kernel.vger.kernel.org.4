Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875276974E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBODZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBODZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:25:26 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD02C3C0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 19:25:24 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PGk3k2kVdz4xyCY;
        Wed, 15 Feb 2023 11:25:22 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 31F3P6TP010713;
        Wed, 15 Feb 2023 11:25:06 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 11:25:07 +0800 (CST)
Date:   Wed, 15 Feb 2023 11:25:07 +0800 (CST)
X-Zmail-TransId: 2af963ec50933a968cfb
X-Mailer: Zmail v1.0
Message-ID: <202302151125076179524@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <vkoul@kernel.org>
Cc:     <nandhini.srikandan@intel.com>, <rashmi.a@intel.com>,
        <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwaHk6IGludGVsOiBVc2UgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F3P6TP010713
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EC50A2.000/4PGk3k2kVdz4xyCY
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
 drivers/phy/intel/phy-intel-thunderbay-emmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/intel/phy-intel-thunderbay-emmc.c b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
index 593f6970b81e..4fe63240779f 100644
--- a/drivers/phy/intel/phy-intel-thunderbay-emmc.c
+++ b/drivers/phy/intel/phy-intel-thunderbay-emmc.c
@@ -461,7 +461,6 @@ static int thunderbay_emmc_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	struct phy *generic_phy;
-	struct resource *res;

 	if (!dev->of_node)
 		return -ENODEV;
@@ -470,8 +469,7 @@ static int thunderbay_emmc_phy_probe(struct platform_device *pdev)
 	if (!tbh_phy)
 		return -ENOMEM;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	tbh_phy->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	tbh_phy->reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(tbh_phy->reg_base))
 		return PTR_ERR(tbh_phy->reg_base);

-- 
2.25.1
