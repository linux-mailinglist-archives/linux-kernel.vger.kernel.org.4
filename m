Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C87063EA83
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiLAHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 02:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAHs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 02:48:59 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544043858;
        Wed, 30 Nov 2022 23:48:48 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN7Vk6t5yz4xVnZ;
        Thu,  1 Dec 2022 15:48:46 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B17maTK013822;
        Thu, 1 Dec 2022 15:48:36 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 15:48:38 +0800 (CST)
Date:   Thu, 1 Dec 2022 15:48:38 +0800 (CST)
X-Zmail-TransId: 2af963885c56ffffffff81a0d858
X-Mailer: Zmail v1.0
Message-ID: <202212011548387254492@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <colin.i.king@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBJbnB1dDogbWlzYzogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B17maTK013822
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63885C5E.000 by FangMail milter!
X-FangMail-Envelope: 1669880926/4NN7Vk6t5yz4xVnZ/63885C5E.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63885C5E.000/4NN7Vk6t5yz4xVnZ
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
 drivers/input/misc/ims-pcu.c | 10 +++++-----
 drivers/input/misc/iqs269a.c | 18 +++++++++---------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index b2f1292e27ef..6e8cc28debd9 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1050,7 +1050,7 @@ static ssize_t ims_pcu_attribute_show(struct device *dev,
 			container_of(dattr, struct ims_pcu_attribute, dattr);
 	char *field = (char *)pcu + attr->field_offset;

-	return scnprintf(buf, PAGE_SIZE, "%.*s\n", attr->field_length, field);
+	return sysfs_emit(buf, "%.*s\n", attr->field_length, field);
 }

 static ssize_t ims_pcu_attribute_store(struct device *dev,
@@ -1206,7 +1206,7 @@ ims_pcu_update_firmware_status_show(struct device *dev,
 	struct usb_interface *intf = to_usb_interface(dev);
 	struct ims_pcu *pcu = usb_get_intfdata(intf);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", pcu->update_firmware_status);
+	return sysfs_emit(buf, "%d\n", pcu->update_firmware_status);
 }

 static DEVICE_ATTR(update_firmware_status, S_IRUGO,
@@ -1309,7 +1309,7 @@ static ssize_t ims_pcu_ofn_reg_data_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%x\n", data);
+	return sysfs_emit(buf, "%x\n", data);
 }

 static ssize_t ims_pcu_ofn_reg_data_store(struct device *dev,
@@ -1344,7 +1344,7 @@ static ssize_t ims_pcu_ofn_reg_addr_show(struct device *dev,
 	int error;

 	mutex_lock(&pcu->cmd_mutex);
-	error = scnprintf(buf, PAGE_SIZE, "%x\n", pcu->ofn_reg_addr);
+	error = sysfs_emit(buf, "%x\n", pcu->ofn_reg_addr);
 	mutex_unlock(&pcu->cmd_mutex);

 	return error;
@@ -1397,7 +1397,7 @@ static ssize_t ims_pcu_ofn_bit_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(data & (1 << attr->nr)));
+	return sysfs_emit(buf, "%d\n", !!(data & (1 << attr->nr)));
 }

 static ssize_t ims_pcu_ofn_bit_store(struct device *dev,
diff --git a/drivers/input/misc/iqs269a.c b/drivers/input/misc/iqs269a.c
index a348247d3d38..e4d5cea51f39 100644
--- a/drivers/input/misc/iqs269a.c
+++ b/drivers/input/misc/iqs269a.c
@@ -1332,7 +1332,7 @@ static ssize_t counts_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", le16_to_cpu(counts));
+	return sysfs_emit(buf, "%u\n", le16_to_cpu(counts));
 }

 static ssize_t hall_bin_show(struct device *dev,
@@ -1369,7 +1369,7 @@ static ssize_t hall_bin_show(struct device *dev,
 		return -EINVAL;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t hall_enable_show(struct device *dev,
@@ -1377,7 +1377,7 @@ static ssize_t hall_enable_show(struct device *dev,
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->hall_enable);
+	return sysfs_emit(buf, "%u\n", iqs269->hall_enable);
 }

 static ssize_t hall_enable_store(struct device *dev,
@@ -1407,7 +1407,7 @@ static ssize_t ch_number_show(struct device *dev,
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->ch_num);
+	return sysfs_emit(buf, "%u\n", iqs269->ch_num);
 }

 static ssize_t ch_number_store(struct device *dev,
@@ -1435,7 +1435,7 @@ static ssize_t rx_enable_show(struct device *dev,
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 iqs269->ch_reg[iqs269->ch_num].rx_enable);
 }

@@ -1475,7 +1475,7 @@ static ssize_t ati_mode_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t ati_mode_store(struct device *dev,
@@ -1508,7 +1508,7 @@ static ssize_t ati_base_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t ati_base_store(struct device *dev,
@@ -1541,7 +1541,7 @@ static ssize_t ati_target_show(struct device *dev,
 	if (error)
 		return error;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t ati_target_store(struct device *dev,
@@ -1568,7 +1568,7 @@ static ssize_t ati_trigger_show(struct device *dev,
 {
 	struct iqs269_private *iqs269 = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n", iqs269->ati_current);
+	return sysfs_emit(buf, "%u\n", iqs269->ati_current);
 }

 static ssize_t ati_trigger_store(struct device *dev,
-- 
2.25.1
