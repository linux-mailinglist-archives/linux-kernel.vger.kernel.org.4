Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14616C6110
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCWHqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjCWHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:46:23 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6602A6D7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:46:01 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Phy7q58x9z501Sn;
        Thu, 23 Mar 2023 15:45:59 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 32N7joU5090489;
        Thu, 23 Mar 2023 15:45:50 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 23 Mar 2023 15:45:52 +0800 (CST)
Date:   Thu, 23 Mar 2023 15:45:52 +0800 (CST)
X-Zmail-TransId: 2afa641c03b012f-8631f
X-Mailer: Zmail v1.0
Message-ID: <202303231545522162256@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <vkoul@kernel.org>
Cc:     <kishon@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <linmq006@gmail.com>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwaHk6IG9tYXAtdXNiMi1waHk6IFVzZSBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32N7joU5090489
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641C03B7.001/4Phy7q58x9z501Sn
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
 drivers/phy/ti/phy-omap-usb2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index bbe5d25b0351..762d3de8b3c5 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -445,11 +445,9 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			 PTR_ERR(phy->wkupclk));
 		phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");

-		if (IS_ERR(phy->wkupclk)) {
-			if (PTR_ERR(phy->wkupclk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
-			return PTR_ERR(phy->wkupclk);
-		}
+		if (IS_ERR(phy->wkupclk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(phy->wkupclk),
+					     "unable to get usb_phy_cm_clk32k\n");

 		dev_warn(&pdev->dev,
 			 "found usb_phy_cm_clk32k, please fix DTS\n");
-- 
2.25.1
