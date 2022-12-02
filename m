Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E36400D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiLBHEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiLBHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:04:11 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC4EBEE36;
        Thu,  1 Dec 2022 23:04:09 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NNkSm1BnXz501Qh;
        Fri,  2 Dec 2022 15:04:08 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B2743YH020599;
        Fri, 2 Dec 2022 15:04:04 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Fri, 2 Dec 2022 15:04:06 +0800 (CST)
Date:   Fri, 2 Dec 2022 15:04:06 +0800 (CST)
X-Zmail-TransId: 2af96389a36634a2bc70
X-Mailer: Zmail v1.0
Message-ID: <202212021504062431427@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeff@labundy.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBJbnB1dDogcm1pNDogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B2743YH020599
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 6389A368.000 by FangMail milter!
X-FangMail-Envelope: 1669964648/4NNkSm1BnXz501Qh/6389A368.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6389A368.000/4NNkSm1BnXz501Qh
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
 drivers/input/rmi4/rmi_f01.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index d7603c50f864..29f3ba1599e8 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -267,8 +267,7 @@ static ssize_t rmi_driver_manufacturer_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-			 f01->properties.manufacturer_id);
+	return sysfs_emit(buf, "%d\n", f01->properties.manufacturer_id);
 }

 static DEVICE_ATTR(manufacturer_id, 0444,
@@ -280,7 +279,7 @@ static ssize_t rmi_driver_dom_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", f01->properties.dom);
+	return sysfs_emit(buf, "%s\n", f01->properties.dom);
 }

 static DEVICE_ATTR(date_of_manufacture, 0444, rmi_driver_dom_show, NULL);
@@ -292,7 +291,7 @@ static ssize_t rmi_driver_product_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", f01->properties.product_id);
+	return sysfs_emit(buf, "%s\n", f01->properties.product_id);
 }

 static DEVICE_ATTR(product_id, 0444, rmi_driver_product_id_show, NULL);
@@ -304,7 +303,7 @@ static ssize_t rmi_driver_firmware_id_show(struct device *dev,
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
 	struct f01_data *f01 = dev_get_drvdata(&data->f01_container->dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", f01->properties.firmware_id);
+	return sysfs_emit(buf, "%d\n", f01->properties.firmware_id);
 }

 static DEVICE_ATTR(firmware_id, 0444, rmi_driver_firmware_id_show, NULL);
@@ -318,8 +317,8 @@ static ssize_t rmi_driver_package_id_show(struct device *dev,

 	u32 package_id = f01->properties.package_id;

-	return scnprintf(buf, PAGE_SIZE, "%04x.%04x\n",
-			 package_id & 0xffff, (package_id >> 16) & 0xffff);
+	return sysfs_emit(buf, "%04x.%04x\n",
+			package_id & 0xffff, (package_id >> 16) & 0xffff);
 }

 static DEVICE_ATTR(package_id, 0444, rmi_driver_package_id_show, NULL);
-- 
2.25.1
