Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AD16C44CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCVIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCVIVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:21:50 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA05D447
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:21:45 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PhLzX24dBz6FK2Y;
        Wed, 22 Mar 2023 16:21:44 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl2.zte.com.cn with SMTP id 32M8LVA3098098;
        Wed, 22 Mar 2023 16:21:31 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 16:21:33 +0800 (CST)
Date:   Wed, 22 Mar 2023 16:21:33 +0800 (CST)
X-Zmail-TransId: 2afa641aba8d2ae-91f88
X-Mailer: Zmail v1.0
Message-ID: <202303221621336645576@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <laurent.pinchart@ideasonboard.com>
Cc:     <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
        <rfoss@kernel.org>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYnJpZGdlOiBkaXNwbGF5LWNvbm5lY3RvcjogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M8LVA3098098
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641ABA98.000/4PhLzX24dBz6FK2Y
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
 drivers/gpu/drm/bridge/display-connector.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index fbb3e102c02f..56ae511367b1 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -271,12 +271,9 @@ static int display_connector_probe(struct platform_device *pdev)
 	    type == DRM_MODE_CONNECTOR_DisplayPort) {
 		conn->hpd_gpio = devm_gpiod_get_optional(&pdev->dev, "hpd",
 							 GPIOD_IN);
-		if (IS_ERR(conn->hpd_gpio)) {
-			if (PTR_ERR(conn->hpd_gpio) != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Unable to retrieve HPD GPIO\n");
-			return PTR_ERR(conn->hpd_gpio);
-		}
+		if (IS_ERR(conn->hpd_gpio))
+			return dev_err_probe(&pdev->dev, PTR_ERR(conn->hpd_gpio),
+					     "Unable to retrieve HPD GPIO\n");

 		conn->hpd_irq = gpiod_to_irq(conn->hpd_gpio);
 	} else {
-- 
2.25.1
