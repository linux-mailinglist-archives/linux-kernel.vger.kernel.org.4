Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D84638460
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKYHQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKYHQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:16:42 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC8B2C65A;
        Thu, 24 Nov 2022 23:16:34 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NJR4J5rMyz8QrkZ;
        Fri, 25 Nov 2022 15:16:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AP7GK8x056902;
        Fri, 25 Nov 2022 15:16:20 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 25 Nov 2022 15:16:22 +0800 (CST)
Date:   Fri, 25 Nov 2022 15:16:22 +0800 (CST)
X-Zmail-TransId: 2afa63806bc67d756baa
X-Mailer: Zmail v1.0
Message-ID: <202211251516222787845@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <cw00.choi@samsung.com>
Cc:     <myungjoo.ham@samsung.com>, <kyungmin.park@samsung.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBQTSAvIGRldmZyZXE6IFVzZSBkZXZpY2VfbWF0Y2hfb2Zfbm9kZSgp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AP7GK8x056902
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63806BD0.000 by FangMail milter!
X-FangMail-Envelope: 1669360592/4NJR4J5rMyz8QrkZ/63806BD0.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63806BD0.000/4NJR4J5rMyz8QrkZ
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
 drivers/devfreq/devfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 8c5f6f7fca11..817c71da391a 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -1057,7 +1057,7 @@ struct devfreq *devfreq_get_devfreq_by_node(struct device_node *node)
 	mutex_lock(&devfreq_list_lock);
 	list_for_each_entry(devfreq, &devfreq_list, node) {
 		if (devfreq->dev.parent
-			&& devfreq->dev.parent->of_node == node) {
+			&& device_match_of_node(devfreq->dev.parent, node)) {
 			mutex_unlock(&devfreq_list_lock);
 			return devfreq;
 		}
-- 
2.25.1
