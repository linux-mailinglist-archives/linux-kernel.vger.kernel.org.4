Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62466C626F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCWIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCWIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:54:51 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B4412F25;
        Thu, 23 Mar 2023 01:53:50 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Phzf52sgpz6FK2Z;
        Thu, 23 Mar 2023 16:53:49 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 32N8rgwq099302;
        Thu, 23 Mar 2023 16:53:42 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 23 Mar 2023 16:53:44 +0800 (CST)
Date:   Thu, 23 Mar 2023 16:53:44 +0800 (CST)
X-Zmail-TransId: 2afa641c1398358-47488
X-Mailer: Zmail v1.0
Message-ID: <202303231653447704556@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZXNldDogbWVzb24tYXVkaW8tYXJiOiBVc2UgZGV2X2Vycl9wcm9iZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32N8rgwq099302
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641C139D.000/4Phzf52sgpz6FK2Z
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/reset/reset-meson-audio-arb.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 1dc06e08a8da..6a3f6a6a3bbf 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -151,11 +151,8 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, arb);

 	arb->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(arb->clk)) {
-		if (PTR_ERR(arb->clk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get clock\n");
-		return PTR_ERR(arb->clk);
-	}
+	if (IS_ERR(arb->clk))
+		return dev_err_probe(dev, PTR_ERR(arb->clk), "failed to get clock\n");

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	arb->regs = devm_ioremap_resource(dev, res);
-- 
2.25.1
