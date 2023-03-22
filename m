Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA7D6C44E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCVIZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCVIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:25:34 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E9D51F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:25:33 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PhM3v6kjFz8R046;
        Wed, 22 Mar 2023 16:25:31 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl2.zte.com.cn with SMTP id 32M8PNVV003324;
        Wed, 22 Mar 2023 16:25:23 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 22 Mar 2023 16:25:25 +0800 (CST)
Date:   Wed, 22 Mar 2023 16:25:25 +0800 (CST)
X-Zmail-TransId: 2afa641abb75ffffffffa5a-9d729
X-Mailer: Zmail v1.0
Message-ID: <202303221625255005719@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <laurent.pinchart@ideasonboard.com>
Cc:     <hyun.kwon@xilinx.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <michal.simek@xilinx.com>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm06IHhsbng6IHp5bnFtcDogVXNlIGRldl9lcnJfcHJvYmUoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32M8PNVV003324
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641ABB7B.002 by FangMail milter!
X-FangMail-Envelope: 1679473531/4PhM3v6kjFz8R046/641ABB7B.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641ABB7B.002/4PhM3v6kjFz8R046
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
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 0a7b466446fb..c6c2cb4626b9 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -1700,10 +1700,8 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)

 	dp->reset = devm_reset_control_get(dp->dev, NULL);
 	if (IS_ERR(dp->reset)) {
-		if (PTR_ERR(dp->reset) != -EPROBE_DEFER)
-			dev_err(dp->dev, "failed to get reset: %ld\n",
-				PTR_ERR(dp->reset));
-		ret = PTR_ERR(dp->reset);
+		ret = dev_err_probe(dp->dev, PTR_ERR(dp->reset),
+				    "failed to get reset: %ld\n");
 		goto err_free;
 	}

-- 
2.25.1
