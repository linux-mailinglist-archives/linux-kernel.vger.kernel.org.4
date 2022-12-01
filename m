Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F763E855
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLADak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLADaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:30:39 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC0F5BD69;
        Wed, 30 Nov 2022 19:30:38 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NN1mr3BP4z4xyCG;
        Thu,  1 Dec 2022 11:30:36 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B13UUSP049820;
        Thu, 1 Dec 2022 11:30:30 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 11:30:31 +0800 (CST)
Date:   Thu, 1 Dec 2022 11:30:31 +0800 (CST)
X-Zmail-TransId: 2af963881fd7ffffffffa9070c69
X-Mailer: Zmail v1.0
Message-ID: <202212011130317080061@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jdelvare@suse.com>
Cc:     <linux@roeck-us.net>, <guillaume.ligneul@gmail.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBod21vbjogdXNlIHN5c2ZzX2VtaXQoKSB0byBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B13UUSP049820
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63881FDC.001 by FangMail milter!
X-FangMail-Envelope: 1669865436/4NN1mr3BP4z4xyCG/63881FDC.001/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63881FDC.001/4NN1mr3BP4z4xyCG
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
 drivers/hwmon/ds1621.c |  2 +-
 drivers/hwmon/lm73.c   |  6 +++---
 drivers/hwmon/sht3x.c  | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 0886abf6ebab..e803d6393b9e 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -269,7 +269,7 @@ static ssize_t update_interval_show(struct device *dev,
 				    struct device_attribute *da, char *buf)
 {
 	struct ds1621_data *data = dev_get_drvdata(dev);
-	return scnprintf(buf, PAGE_SIZE, "%hu\n", data->update_interval);
+	return sysfs_emit(buf, "%hu\n", data->update_interval);
 }

 static ssize_t update_interval_store(struct device *dev,
diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
index 1346b3b3f463..b6433ae2d75c 100644
--- a/drivers/hwmon/lm73.c
+++ b/drivers/hwmon/lm73.c
@@ -92,7 +92,7 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *da,
 	/* use integer division instead of equivalent right shift to
 	   guarantee arithmetic shift and preserve the sign */
 	temp = (((s16) err) * 250) / 32;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
+	return sysfs_emit(buf, "%d\n", temp);
 }

 static ssize_t convrate_store(struct device *dev, struct device_attribute *da,
@@ -137,7 +137,7 @@ static ssize_t convrate_show(struct device *dev, struct device_attribute *da,
 	int res;

 	res = (data->ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
-	return scnprintf(buf, PAGE_SIZE, "%hu\n", lm73_convrates[res]);
+	return sysfs_emit(buf, "%hu\n", lm73_convrates[res]);
 }

 static ssize_t maxmin_alarm_show(struct device *dev,
@@ -154,7 +154,7 @@ static ssize_t maxmin_alarm_show(struct device *dev,
 	data->ctrl = ctrl;
 	mutex_unlock(&data->lock);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (ctrl >> attr->index) & 1);
+	return sysfs_emit(buf, "%d\n", (ctrl >> attr->index) & 1);

 abort:
 	mutex_unlock(&data->lock);
diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 3f279aa1cee5..8305e44d9ab2 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -320,7 +320,7 @@ static ssize_t temp1_limit_show(struct device *dev,
 	u8 index = to_sensor_dev_attr(attr)->index;
 	int temperature_limit = data->temperature_limits[index];

-	return scnprintf(buf, PAGE_SIZE, "%d\n", temperature_limit);
+	return sysfs_emit(buf, "%d\n", temperature_limit);
 }

 static ssize_t humidity1_limit_show(struct device *dev,
@@ -331,7 +331,7 @@ static ssize_t humidity1_limit_show(struct device *dev,
 	u8 index = to_sensor_dev_attr(attr)->index;
 	u32 humidity_limit = data->humidity_limits[index];

-	return scnprintf(buf, PAGE_SIZE, "%u\n", humidity_limit);
+	return sysfs_emit(buf, "%u\n", humidity_limit);
 }

 /*
@@ -483,7 +483,7 @@ static ssize_t temp1_alarm_show(struct device *dev,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x04));
+	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
 }

 static ssize_t humidity1_alarm_show(struct device *dev,
@@ -498,7 +498,7 @@ static ssize_t humidity1_alarm_show(struct device *dev,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x08));
+	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
 }

 static ssize_t heater_enable_show(struct device *dev,
@@ -513,7 +513,7 @@ static ssize_t heater_enable_show(struct device *dev,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x20));
+	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x20));
 }

 static ssize_t heater_enable_store(struct device *dev,
@@ -550,7 +550,7 @@ static ssize_t update_interval_show(struct device *dev,
 {
 	struct sht3x_data *data = dev_get_drvdata(dev);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 mode_to_update_interval[data->mode]);
 }

-- 
2.25.1
