Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073E668E9F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBHIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjBHIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:35:56 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB90A17CCF;
        Wed,  8 Feb 2023 00:35:55 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PBYHF40Rpz4y0ty;
        Wed,  8 Feb 2023 16:35:53 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 3188ZfKq002286;
        Wed, 8 Feb 2023 16:35:42 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 16:35:44 +0800 (CST)
Date:   Wed, 8 Feb 2023 16:35:44 +0800 (CST)
X-Zmail-TransId: 2af963e35ee0553d6702
X-Mailer: Zmail v1.0
Message-ID: <202302081635445002151@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <xavier.roumegue@oss.nxp.com>
Cc:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZWRpYTogZHcxMDA6IHVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3188ZfKq002286
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E35EE9.000/4PBYHF40Rpz4y0ty
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
 drivers/media/platform/nxp/dw100/dw100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/dw100/dw100.c b/drivers/media/platform/nxp/dw100/dw100.c
index 189d60cd5ed1..0771a88122c0 100644
--- a/drivers/media/platform/nxp/dw100/dw100.c
+++ b/drivers/media/platform/nxp/dw100/dw100.c
@@ -1532,7 +1532,6 @@ static int dw100_probe(struct platform_device *pdev)
 {
 	struct dw100_device *dw_dev;
 	struct video_device *vfd;
-	struct resource *res;
 	int ret, irq;

 	dw_dev = devm_kzalloc(&pdev->dev, sizeof(*dw_dev), GFP_KERNEL);
@@ -1547,8 +1546,7 @@ static int dw100_probe(struct platform_device *pdev)
 	}
 	dw_dev->num_clks = ret;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dw_dev->mmio = devm_ioremap_resource(&pdev->dev, res);
+	dw_dev->mmio = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(dw_dev->mmio))
 		return PTR_ERR(dw_dev->mmio);

-- 
2.25.1
