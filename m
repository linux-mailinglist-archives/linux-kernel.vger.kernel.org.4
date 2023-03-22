Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08116C44D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCVIXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCVIXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:23:04 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8AA8A5F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:23:02 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PhM110wYwz8R041;
        Wed, 22 Mar 2023 16:23:01 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32M8MmLe099387;
        Wed, 22 Mar 2023 16:22:49 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 16:22:51 +0800 (CST)
Date:   Wed, 22 Mar 2023 16:22:51 +0800 (CST)
X-Zmail-TransId: 2afa641abadbffffffffd7f-95a56
X-Mailer: Zmail v1.0
Message-ID: <202303221622511915615@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <laurent.pinchart@ideasonboard.com>
Cc:     <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm06IGJyaWRnZTogc2ltcGxlLWJyaWRnZTogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M8MmLe099387
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641ABAE5.000 by FangMail milter!
X-FangMail-Envelope: 1679473381/4PhM110wYwz8R041/641ABAE5.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641ABAE5.000/4PhM110wYwz8R041
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with dev_err_probe() to simplify the code.

Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 5ede3e111096..d85d9ee463b8 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -202,11 +202,9 @@ static int simple_bridge_probe(struct platform_device *pdev)

 	sbridge->enable = devm_gpiod_get_optional(&pdev->dev, "enable",
 						  GPIOD_OUT_LOW);
-	if (IS_ERR(sbridge->enable)) {
-		if (PTR_ERR(sbridge->enable) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Unable to retrieve enable GPIO\n");
-		return PTR_ERR(sbridge->enable);
-	}
+	if (IS_ERR(sbridge->enable))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sbridge->enable),
+				     "Unable to retrieve enable GPIO\n");

 	/* Register the bridge. */
 	sbridge->bridge.funcs = &simple_bridge_bridge_funcs;
-- 
2.25.1
