Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530556976A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjBOGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:52:13 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D2034C10;
        Tue, 14 Feb 2023 22:52:12 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PGpfM1bTrz6FK2b;
        Wed, 15 Feb 2023 14:52:11 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 31F6q2Ad092025;
        Wed, 15 Feb 2023 14:52:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 14:52:04 +0800 (CST)
Date:   Wed, 15 Feb 2023 14:52:04 +0800 (CST)
X-Zmail-TransId: 2af963ec8114ffffffffd39024f4
X-Mailer: Zmail v1.0
Message-ID: <202302151452046003226@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sre@kernel.org>
Cc:     <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwb3dlcjogcmVzZXQ6IGJyY20ta29uYS1yZXNldDogVXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F6q2Ad092025
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63EC811B.000 by FangMail milter!
X-FangMail-Envelope: 1676443931/4PGpfM1bTrz6FK2b/63EC811B.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63EC811B.000/4PGpfM1bTrz6FK2b
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
 drivers/power/reset/brcm-kona-reset.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/brcm-kona-reset.c b/drivers/power/reset/brcm-kona-reset.c
index 3de024e3ceb7..02a056983291 100644
--- a/drivers/power/reset/brcm-kona-reset.c
+++ b/drivers/power/reset/brcm-kona-reset.c
@@ -38,9 +38,7 @@ static struct notifier_block kona_reset_nb = {

 static int kona_reset_probe(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-
-	kona_reset_base = devm_ioremap_resource(&pdev->dev, res);
+	kona_reset_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(kona_reset_base))
 		return PTR_ERR(kona_reset_base);

-- 
2.25.1
