Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7C62D442
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiKQHlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:41:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQHlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:41:14 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91F8333;
        Wed, 16 Nov 2022 23:41:12 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NCX0R2wwHz8R039;
        Thu, 17 Nov 2022 15:41:11 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AH7f4ZX014225;
        Thu, 17 Nov 2022 15:41:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 17 Nov 2022 15:41:06 +0800 (CST)
Date:   Thu, 17 Nov 2022 15:41:06 +0800 (CST)
X-Zmail-TransId: 2af96375e5922f0755ff
X-Mailer: Zmail v1.0
Message-ID: <202211171541061366938@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <andersson@kernel.org>
Cc:     <mathieu.poirier@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHJlbW90ZXByb2M6IGNvcmU6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AH7f4ZX014225
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 6375E597.000 by FangMail milter!
X-FangMail-Envelope: 1668670871/4NCX0R2wwHz8R039/6375E597.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6375E597.000/4NCX0R2wwHz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with device_match_of_node().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index cb1d414a2389..11c165ddf1fc 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2112,7 +2112,7 @@ struct rproc *rproc_get_by_phandle(phandle phandle)

 	rcu_read_lock();
 	list_for_each_entry_rcu(r, &rproc_list, node) {
-		if (r->dev.parent && r->dev.parent->of_node == np) {
+		if (r->dev.parent && device_match_of_node(r->dev.parent, np)) {
 			/* prevent underlying implementation from being removed */
 			if (!try_module_get(r->dev.parent->driver->owner)) {
 				dev_err(&r->dev, "can't get owner\n");
-- 
2.25.1
