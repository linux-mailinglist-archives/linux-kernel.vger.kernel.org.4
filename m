Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22F963EED2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiLALFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiLALEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:04:30 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F81303D6;
        Thu,  1 Dec 2022 03:04:27 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NNCrT2Nqvz5BNRf;
        Thu,  1 Dec 2022 19:04:25 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B1B4GFx055613;
        Thu, 1 Dec 2022 19:04:16 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 19:04:19 +0800 (CST)
Date:   Thu, 1 Dec 2022 19:04:19 +0800 (CST)
X-Zmail-TransId: 2af963888a331aa5b09b
X-Mailer: Zmail v1.0
Message-ID: <202212011904193038898@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <dmitry.torokhov@gmail.com>
Cc:     <nick@shmanahar.org>, <giulio.benetti@benettiengineering.com>,
        <dario.binacchi@amarulasolutions.com>,
        <michael@amarulasolutions.com>, <oliver.graute@kococonnector.com>,
        <wsa+renesas@sang-engineering.com>,
        <u.kleine-koenig@pengutronix.de>, <jeff@labundy.com>,
        <johan@kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyXSBJbnB1dDogdG91Y2hzY3JlZW46IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZsKgc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B1B4GFx055613
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63888A39.000 by FangMail milter!
X-FangMail-Envelope: 1669892665/4NNCrT2Nqvz5BNRf/63888A39.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63888A39.000/4NNCrT2Nqvz5BNRf
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
fix the Subject.
 drivers/input/touchscreen/atmel_mxt_ts.c   | 4 ++--
 drivers/input/touchscreen/edt-ft5x06.c     | 2 +-
 drivers/input/touchscreen/hideep.c         | 4 ++--
 drivers/input/touchscreen/hycon-hy46xx.c   | 2 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c  | 4 ++--
 drivers/input/touchscreen/iqs5xx.c         | 2 +-
 drivers/input/touchscreen/usbtouchscreen.c | 2 +-
 drivers/input/touchscreen/wdt87xx_i2c.c    | 6 +++---
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ccecd1441f0b..daad47c7823f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2761,7 +2761,7 @@ static ssize_t mxt_fw_version_show(struct device *dev,
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
 	struct mxt_info *info = data->info;
-	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
+	return sysfs_emit(buf, "%u.%u.%02X\n",
 			 info->version >> 4, info->version & 0xf, info->build);
 }

@@ -2771,7 +2771,7 @@ static ssize_t mxt_hw_version_show(struct device *dev,
 {
 	struct mxt_data *data = dev_get_drvdata(dev);
 	struct mxt_info *info = data->info;
-	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
+	return sysfs_emit(buf, "%u.%u\n",
 			 info->family_id, info->variant_id);
 }

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 9ac1378610bc..b2ec2e04f943 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -445,7 +445,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 		*field = val;
 	}

-	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	count = sysfs_emit(buf, "%d\n", val);
 out:
 	mutex_unlock(&tsdata->mutex);
 	return error ?: count;
diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index e9547ee29756..c0d72ba3c44a 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -922,7 +922,7 @@ static ssize_t hideep_fw_version_show(struct device *dev,
 	ssize_t len;

 	mutex_lock(&ts->dev_mutex);
-	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
+	len = sysfs_emit(buf, "%04x\n",
 			be16_to_cpu(ts->dwz_info.release_ver));
 	mutex_unlock(&ts->dev_mutex);

@@ -937,7 +937,7 @@ static ssize_t hideep_product_id_show(struct device *dev,
 	ssize_t len;

 	mutex_lock(&ts->dev_mutex);
-	len = scnprintf(buf, PAGE_SIZE, "%04x\n",
+	len = sysfs_emit(buf, "%04x\n",
 			be16_to_cpu(ts->dwz_info.product_id));
 	mutex_unlock(&ts->dev_mutex);

diff --git a/drivers/input/touchscreen/hycon-hy46xx.c b/drivers/input/touchscreen/hycon-hy46xx.c
index 891d0430083e..2d34959cb510 100644
--- a/drivers/input/touchscreen/hycon-hy46xx.c
+++ b/drivers/input/touchscreen/hycon-hy46xx.c
@@ -202,7 +202,7 @@ static ssize_t hycon_hy46xx_setting_show(struct device *dev,
 		*field = val;
 	}

-	count = scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	count = sysfs_emit(buf, "%d\n", val);

 out:
 	mutex_unlock(&tsdata->mutex);
diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index c5d259c76adc..114dceb13b77 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -512,7 +512,7 @@ static ssize_t firmware_version_show(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ilitek_ts_data *ts = i2c_get_clientdata(client);

-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			 "fw version: [%02X%02X.%02X%02X.%02X%02X.%02X%02X]\n",
 			 ts->firmware_ver[0], ts->firmware_ver[1],
 			 ts->firmware_ver[2], ts->firmware_ver[3],
@@ -527,7 +527,7 @@ static ssize_t product_id_show(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct ilitek_ts_data *ts = i2c_get_clientdata(client);

-	return scnprintf(buf, PAGE_SIZE, "product id: [%04X], module: [%s]\n",
+	return sysfs_emit(buf, "product id: [%04X], module: [%s]\n",
 			 ts->mcu_ver, ts->product_id);
 }
 static DEVICE_ATTR_RO(product_id);
diff --git a/drivers/input/touchscreen/iqs5xx.c b/drivers/input/touchscreen/iqs5xx.c
index 34c4cca57d13..9119e6b5c44f 100644
--- a/drivers/input/touchscreen/iqs5xx.c
+++ b/drivers/input/touchscreen/iqs5xx.c
@@ -943,7 +943,7 @@ static ssize_t fw_info_show(struct device *dev,
 	if (!iqs5xx->dev_id_info.bl_status)
 		return -ENODATA;

-	return scnprintf(buf, PAGE_SIZE, "%u.%u.%u.%u:%u.%u\n",
+	return sysfs_emit(buf, "%u.%u.%u.%u:%u.%u\n",
 			 be16_to_cpu(iqs5xx->dev_id_info.prod_num),
 			 be16_to_cpu(iqs5xx->dev_id_info.proj_num),
 			 iqs5xx->dev_id_info.major_ver,
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index d6d04b9f04fc..4b2606805240 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -456,7 +456,7 @@ static ssize_t mtouch_firmware_rev_show(struct device *dev,
 	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
 	struct mtouch_priv *priv = usbtouch->priv;

-	return scnprintf(output, PAGE_SIZE, "%1x.%1x\n",
+	return sysfs_emit(output, "%1x.%1x\n",
 			 priv->fw_rev_major, priv->fw_rev_minor);
 }
 static DEVICE_ATTR(firmware_rev, 0444, mtouch_firmware_rev_show, NULL);
diff --git a/drivers/input/touchscreen/wdt87xx_i2c.c b/drivers/input/touchscreen/wdt87xx_i2c.c
index 166edeb77776..8f1b45ec2618 100644
--- a/drivers/input/touchscreen/wdt87xx_i2c.c
+++ b/drivers/input/touchscreen/wdt87xx_i2c.c
@@ -887,7 +887,7 @@ static ssize_t config_csum_show(struct device *dev,
 	cfg_csum = wdt->param.xmls_id1;
 	cfg_csum = (cfg_csum << 16) | wdt->param.xmls_id2;

-	return scnprintf(buf, PAGE_SIZE, "%x\n", cfg_csum);
+	return sysfs_emit(buf, "%x\n", cfg_csum);
 }

 static ssize_t fw_version_show(struct device *dev,
@@ -896,7 +896,7 @@ static ssize_t fw_version_show(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct wdt87xx_data *wdt = i2c_get_clientdata(client);

-	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt->param.fw_id);
+	return sysfs_emit(buf, "%x\n", wdt->param.fw_id);
 }

 static ssize_t plat_id_show(struct device *dev,
@@ -905,7 +905,7 @@ static ssize_t plat_id_show(struct device *dev,
 	struct i2c_client *client = to_i2c_client(dev);
 	struct wdt87xx_data *wdt = i2c_get_clientdata(client);

-	return scnprintf(buf, PAGE_SIZE, "%x\n", wdt->param.plat_id);
+	return sysfs_emit(buf, "%x\n", wdt->param.plat_id);
 }

 static ssize_t update_config_store(struct device *dev,
-- 
2.25.1
