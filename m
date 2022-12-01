Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40E863EA91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLAHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLAHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:52:01 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCB946675;
        Wed, 30 Nov 2022 23:52:00 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN7ZQ6R5hz8RV6M;
        Thu,  1 Dec 2022 15:51:58 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B17pefB008289;
        Thu, 1 Dec 2022 15:51:40 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 15:51:42 +0800 (CST)
Date:   Thu, 1 Dec 2022 15:51:42 +0800 (CST)
X-Zmail-TransId: 2af963885d0e1b8131f0
X-Mailer: Zmail v1.0
Message-ID: <202212011551429834598@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogcm1pNDogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B17pefB008289
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63885D1E.001 by FangMail milter!
X-FangMail-Envelope: 1669881118/4NN7ZQ6R5hz8RV6M/63885D1E.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63885D1E.001/4NN7ZQ6R5hz8RV6M
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/input/rmi4/rmi_f01.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index d7603c50f864..7b56bb70b393 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -267,7 +267,7 @@ static ssize_t rmi_driver_manufacturer_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			 f01->properties.manufacturer_id);
 }

@@ -280,7 +280,7 @@ static ssize_t rmi_driver_dom_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", f01->properties.dom);
+	return sysfs_emit(buf, "%s\n", f01->properties.dom);
 }

 static DEVICE_ATTR(date_of_manufacture, 0444, rmi_driver_dom_show, NULL);
@@ -292,7 +292,7 @@ static ssize_t rmi_driver_product_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", f01->properties.product_id);
+	return sysfs_emit(buf, "%s\n", f01->properties.product_id);
 }

 static DEVICE_ATTR(product_id, 0444, rmi_driver_product_id_show, NULL);
@@ -304,7 +304,7 @@ static ssize_t rmi_driver_firmware_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", f01->properties.firmware_id);
+	return sysfs_emit(buf, "%d\n", f01->properties.firmware_id);
 }

 static DEVICE_ATTR(firmware_id, 0444, rmi_driver_firmware_id_show, NULL);
@@ -318,7 +318,7 @@ static ssize_t rmi_driver_package_id_show(struct device *dev,

 	u32 package_id = f01->properties.package_id;

-	return scnprintf(buf, PAGE_SIZE, "%04x.%04x\n",
+	return sysfs_emit(buf, "%04x.%04x\n",
 			 package_id & 0xffff, (package_id >> 16) & 0xffff);
 }

-- 
2.25.1
