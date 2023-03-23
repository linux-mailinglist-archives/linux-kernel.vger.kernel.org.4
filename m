Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4124C6C60FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjCWHok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCWHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:44:38 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0350519685
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 00:44:36 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Phy6C1SMkz501Sn;
        Thu, 23 Mar 2023 15:44:35 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32N7iLMm083884;
        Thu, 23 Mar 2023 15:44:21 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 23 Mar 2023 15:44:23 +0800 (CST)
Date:   Thu, 23 Mar 2023 15:44:23 +0800 (CST)
X-Zmail-TransId: 2afa641c0357ffffffff89e-81a93
X-Mailer: Zmail v1.0
Message-ID: <202303231544233162199@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <vkoul@kernel.org>
Cc:     <kishon@kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBwaHk6IGxhbnRpcTogcmN1LXVzYjI6IFVzZSBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32N7iLMm083884
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641C0363.000/4Phy6C1SMkz501Sn
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
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
index 29d246ea24b4..9a5d797db1f4 100644
--- a/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
+++ b/drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
@@ -193,11 +193,9 @@ static int ltq_rcu_usb2_of_parse(struct ltq_rcu_usb2_priv *priv,
 	}

 	priv->ctrl_reset = devm_reset_control_get_shared(dev, "ctrl");
-	if (IS_ERR(priv->ctrl_reset)) {
-		if (PTR_ERR(priv->ctrl_reset) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get 'ctrl' reset\n");
-		return PTR_ERR(priv->ctrl_reset);
-	}
+	if (IS_ERR(priv->ctrl_reset))
+		return dev_err_probe(dev, PTR_ERR(priv->ctrl_reset),
+				     "failed to get 'ctrl' reset\n");

 	priv->phy_reset = devm_reset_control_get_optional(dev, "phy");

-- 
2.25.1
