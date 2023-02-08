Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBFB68EB9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBHJhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjBHJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:37:11 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D84C23C42
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:36:58 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBZdh6Drnz4xVnD;
        Wed,  8 Feb 2023 17:36:56 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3189alMZ098566;
        Wed, 8 Feb 2023 17:36:47 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 17:36:50 +0800 (CST)
Date:   Wed, 8 Feb 2023 17:36:50 +0800 (CST)
X-Zmail-TransId: 2af963e36d32ffffffff83573948
X-Mailer: Zmail v1.0
Message-ID: <202302081736500534579@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lee@kernel.org>
Cc:     <wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtZmQ6IHN1bjRpLWdwYWRjOiB1c2XCoGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3189alMZ098566
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E36D38.003 by FangMail milter!
X-FangMail-Envelope: 1675849016/4PBZdh6Drnz4xVnD/63E36D38.003/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E36D38.003/4PBZdh6Drnz4xVnD
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
 drivers/mfd/sun4i-gpadc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index edc180d83a4b..d1cbea27b136 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -93,7 +93,6 @@ MODULE_DEVICE_TABLE(of, sun4i_gpadc_of_match);
 static int sun4i_gpadc_probe(struct platform_device *pdev)
 {
 	struct sun4i_gpadc_dev *dev;
-	struct resource *mem;
 	const struct of_device_id *of_id;
 	const struct mfd_cell *cells;
 	unsigned int irq, size;
@@ -124,8 +123,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dev->base = devm_ioremap_resource(&pdev->dev, mem);
+	dev->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(dev->base))
 		return PTR_ERR(dev->base);

-- 
2.25.1
