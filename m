Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6EE69789C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBOJF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjBOJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:05:24 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7019829E12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:05:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PGsbt6DrMz8R03x;
        Wed, 15 Feb 2023 17:05:14 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 31F954HP069480;
        Wed, 15 Feb 2023 17:05:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 17:05:06 +0800 (CST)
Date:   Wed, 15 Feb 2023 17:05:06 +0800 (CST)
X-Zmail-TransId: 2af963eca0425f780c34
X-Mailer: Zmail v1.0
Message-ID: <202302151705068837948@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZXNldDogYXRoNzk6IFVzZSBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F954HP069480
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63ECA04A.001 by FangMail milter!
X-FangMail-Envelope: 1676451914/4PGsbt6DrMz8R03x/63ECA04A.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ECA04A.001/4PGsbt6DrMz8R03x
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
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/reset/reset-ath79.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
index e48d8fcb3133..801a65db2e15 100644
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
+	ath79_reset->base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(ath79_reset->base))
 		return PTR_ERR(ath79_reset->base);

-- 
2.25.1
