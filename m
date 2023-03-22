Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453A96C4106
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCVDax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCVDat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:30:49 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116F1ABF5;
        Tue, 21 Mar 2023 20:30:48 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PhDWq0SNGz501Sg;
        Wed, 22 Mar 2023 11:30:47 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 32M3UUgZ015264;
        Wed, 22 Mar 2023 11:30:30 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 11:30:31 +0800 (CST)
Date:   Wed, 22 Mar 2023 11:30:31 +0800 (CST)
X-Zmail-TransId: 2afa641a76574ea-e0473
X-Mailer: Zmail v1.0
Message-ID: <202303221130316049449@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <alexandre.belloni@bootlin.com>
Cc:     <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <a.zummo@towertech.it>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBydGM6IGFybWFkYTM4eDogdXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZV9ieW5hbWUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 32M3UUgZ015264
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641A7667.000/4PhDWq0SNGz501Sg
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
 drivers/rtc/rtc-armada38x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index cc542e6b1d5b..b4139c200676 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -491,7 +491,6 @@ MODULE_DEVICE_TABLE(of, armada38x_rtc_of_match_table);

 static __init int armada38x_rtc_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct armada38x_rtc *rtc;

 	rtc = devm_kzalloc(&pdev->dev, sizeof(struct armada38x_rtc),
@@ -508,12 +507,10 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)

 	spin_lock_init(&rtc->lock);

-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc");
-	rtc->regs = devm_ioremap_resource(&pdev->dev, res);
+	rtc->regs = devm_platform_ioremap_resource_byname(pdev, "rtc");
 	if (IS_ERR(rtc->regs))
 		return PTR_ERR(rtc->regs);
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc-soc");
-	rtc->regs_soc = devm_ioremap_resource(&pdev->dev, res);
+	rtc->regs_soc = devm_platform_ioremap_resource_byname(pdev, "rtc-soc");
 	if (IS_ERR(rtc->regs_soc))
 		return PTR_ERR(rtc->regs_soc);

-- 
2.25.1
