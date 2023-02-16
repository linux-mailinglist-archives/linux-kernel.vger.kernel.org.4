Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3728F698A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 03:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBPCtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 21:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPCtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 21:49:17 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25D3772F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:49:15 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PHKCX6TmPz8R040;
        Thu, 16 Feb 2023 10:49:12 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 31G2n8vo017340;
        Thu, 16 Feb 2023 10:49:08 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 16 Feb 2023 10:49:10 +0800 (CST)
Date:   Thu, 16 Feb 2023 10:49:10 +0800 (CST)
X-Zmail-TransId: 2af963ed99a6ffffffff94fd3840
X-Mailer: Zmail v1.0
Message-ID: <202302161049100728015@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSByZXNldDogYXRoNzk6IFVzZSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 31G2n8vo017340
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63ED99A8.000 by FangMail milter!
X-FangMail-Envelope: 1676515752/4PHKCX6TmPz8R040/63ED99A8.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ED99A8.000/4PHKCX6TmPz8R040
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to Use devm_platform_ioremap_resource(), as this is exactly
what this function does.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
change devm_platform_get_and_ioremap_resource() to
devm_platform_ioremap_resource().
 drivers/reset/reset-ath79.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
index e48d8fcb3133..a8b8f5ea77ec 100644
--- a/drivers/reset/reset-ath79.c
+++ b/drivers/reset/reset-ath79.c
@@ -86,7 +86,6 @@ static int ath79_reset_restart_handler(struct notifier_block *nb,
 static int ath79_reset_probe(struct platform_device *pdev)
 {
 	struct ath79_reset *ath79_reset;
-	struct resource *res;
 	int err;

 	ath79_reset = devm_kzalloc(&pdev->dev,
@@ -96,8 +95,7 @@ static int ath79_reset_probe(struct platform_device *pdev)

 	platform_set_drvdata(pdev, ath79_reset);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ath79_reset->base = devm_ioremap_resource(&pdev->dev, res);
+	ath79_reset->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ath79_reset->base))
 		return PTR_ERR(ath79_reset->base);

-- 
2.25.1
