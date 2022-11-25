Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6563846C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKYHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiKYHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:22:15 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D2DFB4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:22:14 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NJRBr3xzQz4xVnK;
        Fri, 25 Nov 2022 15:22:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AP7M67E062975;
        Fri, 25 Nov 2022 15:22:06 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 25 Nov 2022 15:22:08 +0800 (CST)
Date:   Fri, 25 Nov 2022 15:22:08 +0800 (CST)
X-Zmail-TransId: 2afa63806d201c063586
X-Mailer: Zmail v1.0
Message-ID: <202211251522083717991@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <cw00.choi@samsung.com>
Cc:     <myungjoo.ham@samsung.com>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBleHRjb246IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AP7M67E062975
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63806D24.001 by FangMail milter!
X-FangMail-Envelope: 1669360932/4NJRBr3xzQz4xVnK/63806D24.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63806D24.001/4NJRBr3xzQz4xVnK
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
 drivers/extcon/extcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e1c71359b605..cdf1c8c9973e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1349,7 +1349,7 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)

 	mutex_lock(&extcon_dev_list_lock);
 	list_for_each_entry(edev, &extcon_dev_list, entry)
-		if (edev->dev.parent && edev->dev.parent->of_node == node)
+		if (edev->dev.parent && device_match_of_node(edev->dev.parent, node))
 			goto out;
 	edev = ERR_PTR(-EPROBE_DEFER);
 out:
-- 
2.25.1
