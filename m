Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304B463FF1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiLBDgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiLBDgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:36:22 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841C6DFB6E;
        Thu,  1 Dec 2022 19:33:45 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NNdnz5vVGz501Qq;
        Fri,  2 Dec 2022 11:33:43 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B23XcpA051832;
        Fri, 2 Dec 2022 11:33:38 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 11:33:39 +0800 (CST)
Date:   Fri, 2 Dec 2022 11:33:39 +0800 (CST)
X-Zmail-TransId: 2af9638972134f291fb0
X-Mailer: Zmail v1.0
Message-ID: <202212021133398847947@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeff@labundy.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBJbnB1dDogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B23XcpA051832
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63897217.002 by FangMail milter!
X-FangMail-Envelope: 1669952023/4NNdnz5vVGz501Qq/63897217.002/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63897217.002/4NNdnz5vVGz501Qq
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
v1 -> v2
Fix the code style.
 drivers/input/input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index ca2e3dd7188b..c061bbe96086 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1362,8 +1362,8 @@ static ssize_t input_dev_show_##name(struct device *dev,		\
 {									\
 	struct input_dev *input_dev = to_input_dev(dev);		\
 									\
-	return scnprintf(buf, PAGE_SIZE, "%s\n",			\
-			 input_dev->name ? input_dev->name : "");	\
+	return sysfs_emit(buf, "%s\n",			\
+			input_dev->name ? input_dev->name : "");	\
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
