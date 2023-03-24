Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7776C7578
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCXCRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjCXCRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:17:38 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019A6298CB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:17:36 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PjQpR5MFJz6FK2R;
        Fri, 24 Mar 2023 10:17:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 32O2HSAr099065;
        Fri, 24 Mar 2023 10:17:28 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 24 Mar 2023 10:17:29 +0800 (CST)
Date:   Fri, 24 Mar 2023 10:17:29 +0800 (CST)
X-Zmail-TransId: 2afa641d0839310-a3de9
X-Mailer: Zmail v1.0
Message-ID: <202303241017290414354@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <matthias.bgg@gmail.com>
Cc:     <angelogioacchino.delregno@collabora.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: =?UTF-8?B?W1BBVENIXSBzb2M6IG1lZGlhdGVrOiBtdXRleDogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32O2HSAr099065
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641D083F.001/4PjQpR5MFJz6FK2R
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
 drivers/soc/mediatek/mtk-mutex.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 7751527fc30d..05c8ad3c2664 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -1014,11 +1014,8 @@ static int mtk_mutex_probe(struct platform_device *pdev)

 	if (!mtx->data->no_clk) {
 		mtx->clk = devm_clk_get(dev, NULL);
-		if (IS_ERR(mtx->clk)) {
-			if (PTR_ERR(mtx->clk) != -EPROBE_DEFER)
-				dev_err(dev, "Failed to get clock\n");
-			return PTR_ERR(mtx->clk);
-		}
+		if (IS_ERR(mtx->clk))
+			return dev_err_probe(dev, PTR_ERR(mtx->clk), "Failed to get clock\n");
 	}

 	mtx->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
-- 
2.25.1
