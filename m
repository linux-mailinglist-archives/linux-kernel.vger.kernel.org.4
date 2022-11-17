Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53962D3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiKQHL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQHLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:11:55 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF967139
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:11:52 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCWLb29t0z5BNS0;
        Thu, 17 Nov 2022 15:11:51 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH7BV7m075328;
        Thu, 17 Nov 2022 15:11:31 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:11:33 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:11:33 +0800 (CST)
X-Zmail-TransId: 2af96375dea56961b9ff
X-Mailer: Zmail v1.0
Message-ID: <202211171511333735699@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <p.zabel@pengutronix.de>
Cc:     <airlied@gmail.com>, <daniel@ffwll.ch>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGRybS9pbXg6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH7BV7m075328
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 6375DEB7.000 by FangMail milter!
X-FangMail-Envelope: 1668669111/4NCWLb29t0z5BNS0/6375DEB7.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375DEB7.000/4NCWLb29t0z5BNS0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/imx/imx-drm-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/imx-drm-core.c b/drivers/gpu/drm/imx/imx-drm-core.c
index e060fa6cbcb9..2e4f5af894b0 100644
--- a/drivers/gpu/drm/imx/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/imx-drm-core.c
@@ -182,7 +182,7 @@ static int compare_of(struct device *dev, void *data)
 	if (strcmp(dev->driver->name, "imx-ipuv3-crtc") == 0) {
 		struct ipu_client_platformdata *pdata = dev->platform_data;

-		return pdata->of_node == np;
+		return device_match_of_node(pdata, np);
 	}

 	/* Special case for LDB, one device for two channels */
@@ -191,7 +191,7 @@ static int compare_of(struct device *dev, void *data)
 		of_node_put(np);
 	}

-	return dev->of_node == np;
+	return device_match_of_node(dev, np);
 }

 static int imx_drm_bind(struct device *dev)
-- 
2.25.1
