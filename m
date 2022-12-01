Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920EF63EA96
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLAHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLAHzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:55:03 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106F251316;
        Wed, 30 Nov 2022 23:55:02 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN7dw5857z4xVng;
        Thu,  1 Dec 2022 15:55:00 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B17sjnm013390;
        Thu, 1 Dec 2022 15:54:45 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 15:54:47 +0800 (CST)
Date:   Thu, 1 Dec 2022 15:54:47 +0800 (CST)
X-Zmail-TransId: 2af963885dc71a3191d5
X-Mailer: Zmail v1.0
Message-ID: <202212011554474934696@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B17sjnm013390
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63885DD4.002 by FangMail milter!
X-FangMail-Envelope: 1669881300/4NN7dw5857z4xVng/63885DD4.002/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63885DD4.002/4NN7dw5857z4xVng
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/input/input.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ca2e3dd7188b..4e4643e74ac5 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1362,7 +1362,7 @@ static ssize_t input_dev_show_##name(struct device *dev,		\
 {									\
 	struct input_dev *input_dev = to_input_dev(dev);		\
 									\
-	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
+	return sysfs_emit(buf, "%s\n",			\
 			 input_dev->name ? input_dev->name : "");	\
 }									\
 static DEVICE_ATTR(name, S_IRUGO, input_dev_show_##name, NULL)
@@ -1455,7 +1455,7 @@ static ssize_t inhibited_show(struct device *dev,
 {
 	struct input_dev *input_dev = to_input_dev(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", input_dev->inhibited);
+	return sysfs_emit(buf, "%d\n", input_dev->inhibited);
 }

 static ssize_t inhibited_store(struct device *dev,
@@ -1502,7 +1502,7 @@ static ssize_t input_dev_show_id_##name(struct device *dev,		\
 					char *buf)			\
 {									\
 	struct input_dev *input_dev = to_input_dev(dev);		\
-	return scnprintf(buf, PAGE_SIZE, "%04x\n", input_dev->id.name);	\
+	return sysfs_emit(buf, "%04x\n", input_dev->id.name);	\
 }									\
 static DEVICE_ATTR(name, S_IRUGO, input_dev_show_id_##name, NULL)

-- 
2.25.1
