Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07B56C6138
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjCWIBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCWIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:01:02 -0400
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA65F974;
        Thu, 23 Mar 2023 01:00:57 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PhyT32mhZz8RTZK;
        Thu, 23 Mar 2023 16:00:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
        by mse-fl2.zte.com.cn with SMTP id 32N80lxC026494;
        Thu, 23 Mar 2023 16:00:47 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 23 Mar 2023 16:00:49 +0800 (CST)
Date:   Thu, 23 Mar 2023 16:00:49 +0800 (CST)
X-Zmail-TransId: 2afa641c07315a3-b4765
X-Mailer: Zmail v1.0
Message-ID: <202303231600496082749@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andersson@kernel.org>
Cc:     <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSByZW1vdGVwcm9jL2RhdmluY2k6IFVzZSBkZXZfZXJyX3Byb2JlKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 32N80lxC026494
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 641C0737.002 by FangMail milter!
X-FangMail-Envelope: 1679558455/4PhyT32mhZz8RTZK/641C0737.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 641C0737.002/4PhyT32mhZz8RTZK
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
 drivers/remoteproc/da8xx_remoteproc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 98e0be9476a4..b2b7d3347949 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -278,13 +278,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	}

 	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(dsp_reset)) {
-		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
-			dev_err(dev, "unable to get reset control: %ld\n",
-				PTR_ERR(dsp_reset));
-
-		return PTR_ERR(dsp_reset);
-	}
+	if (IS_ERR(dsp_reset))
+		return dev_err_probe(dev, PTR_ERR(dsp_reset),
+				     "unable to get reset control: %ld\n");

 	if (dev->of_node) {
 		ret = of_reserved_mem_device_init(dev);
-- 
2.25.1
