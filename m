Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2D6978A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjBOJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBOJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:06:39 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5A8298E9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:06:38 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4PGsdS0dKfz501R0;
        Wed, 15 Feb 2023 17:06:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 31F967gh070742;
        Wed, 15 Feb 2023 17:06:07 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 15 Feb 2023 17:06:09 +0800 (CST)
Date:   Wed, 15 Feb 2023 17:06:09 +0800 (CST)
X-Zmail-TransId: 2af963eca081374859ac
X-Mailer: Zmail v1.0
Message-ID: <202302151706099017993@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <eugeniy.paltsev@synopsys.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZXNldDogYXhzMTB4OiBVc2UgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 31F967gh070742
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63ECA09C.000/4PGsdS0dKfz501R0
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
 drivers/reset/reset-axs10x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/reset/reset-axs10x.c b/drivers/reset/reset-axs10x.c
index a854ef41364d..0fce5006778c 100644
--- a/drivers/reset/reset-axs10x.c
+++ b/drivers/reset/reset-axs10x.c
@@ -44,14 +44,12 @@ static const struct reset_control_ops axs10x_reset_ops = {
 static int axs10x_reset_probe(struct platform_device *pdev)
 {
 	struct axs10x_rst *rst;
-	struct resource *mem;

 	rst = devm_kzalloc(&pdev->dev, sizeof(*rst), GFP_KERNEL);
 	if (!rst)
 		return -ENOMEM;

-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rst->regs_rst = devm_ioremap_resource(&pdev->dev, mem);
+	rst->regs_rst = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(rst->regs_rst))
 		return PTR_ERR(rst->regs_rst);

-- 
2.25.1
