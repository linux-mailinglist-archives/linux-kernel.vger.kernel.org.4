Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E9468E928
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjBHHk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjBHHkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:40:25 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EDE19F;
        Tue,  7 Feb 2023 23:40:23 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PBX3B2mTQz6FK2g;
        Wed,  8 Feb 2023 15:40:22 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 3187eB3v039174;
        Wed, 8 Feb 2023 15:40:11 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 15:40:13 +0800 (CST)
Date:   Wed, 8 Feb 2023 15:40:13 +0800 (CST)
X-Zmail-TransId: 2af963e351ddfffffffff5a5518b
X-Mailer: Zmail v1.0
Message-ID: <202302081540136870117@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <mani@kernel.org>
Cc:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBjbGs6IGJtMTg4MDogdXNlIGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3187eB3v039174
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63E351E6.000 by FangMail milter!
X-FangMail-Envelope: 1675842022/4PBX3B2mTQz6FK2g/63E351E6.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E351E6.000/4PBX3B2mTQz6FK2g
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
 drivers/clk/clk-bm1880.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-bm1880.c b/drivers/clk/clk-bm1880.c
index fad78a22218e..1013be67254b 100644
--- a/drivers/clk/clk-bm1880.c
+++ b/drivers/clk/clk-bm1880.c
@@ -876,16 +876,13 @@ static int bm1880_clk_probe(struct platform_device *pdev)
 	struct bm1880_clock_data *clk_data;
 	void __iomem *pll_base, *sys_base;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int num_clks, i;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pll_base = devm_ioremap_resource(&pdev->dev, res);
+	pll_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(pll_base))
 		return PTR_ERR(pll_base);

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	sys_base = devm_ioremap_resource(&pdev->dev, res);
+	sys_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
 	if (IS_ERR(sys_base))
 		return PTR_ERR(sys_base);

-- 
2.25.1
