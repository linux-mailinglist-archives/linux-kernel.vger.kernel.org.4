Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C2468E932
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjBHHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjBHHmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:42:12 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6905B97;
        Tue,  7 Feb 2023 23:42:09 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PBX594wBnz4xq27;
        Wed,  8 Feb 2023 15:42:05 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl1.zte.com.cn with SMTP id 3187fsPq028878;
        Wed, 8 Feb 2023 15:41:54 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 8 Feb 2023 15:41:56 +0800 (CST)
Date:   Wed, 8 Feb 2023 15:41:56 +0800 (CST)
X-Zmail-TransId: 2af963e35244ffffffffc8658eb3
X-Mailer: Zmail v1.0
Message-ID: <202302081541565850181@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <thierry.reding@gmail.com>
Cc:     <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBncHU6IGhvc3QxeDogbWlwaTogdXNlwqBkZXZtX3BsYXRmb3JtX2dldF9hbmRfaW9yZW1hcF9yZXNvdXJjZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3187fsPq028878
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63E3524D.000/4PBX594wBnz4xq27
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
 drivers/gpu/host1x/mipi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/mipi.c b/drivers/gpu/host1x/mipi.c
index 2efe12dde8bc..4dcec535ec21 100644
--- a/drivers/gpu/host1x/mipi.c
+++ b/drivers/gpu/host1x/mipi.c
@@ -501,7 +501,6 @@ static int tegra_mipi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct tegra_mipi *mipi;
-	struct resource *res;
 	int err;

 	match = of_match_node(tegra_mipi_of_match, pdev->dev.of_node);
@@ -515,8 +514,7 @@ static int tegra_mipi_probe(struct platform_device *pdev)
 	mipi->soc = match->data;
 	mipi->dev = &pdev->dev;

-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mipi->regs = devm_ioremap_resource(&pdev->dev, res);
+	mipi->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(mipi->regs))
 		return PTR_ERR(mipi->regs);

-- 
2.25.1
