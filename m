Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5F63EADE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLAILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLAILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:11:42 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE9321E03;
        Thu,  1 Dec 2022 00:11:35 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NN81047nmz4xyCN;
        Thu,  1 Dec 2022 16:11:32 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B18BMHB046498;
        Thu, 1 Dec 2022 16:11:22 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 16:11:24 +0800 (CST)
Date:   Thu, 1 Dec 2022 16:11:24 +0800 (CST)
X-Zmail-TransId: 2af9638861acffffffff9b0399c2
X-Mailer: Zmail v1.0
Message-ID: <202212011611248725166@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <jansimon.moeller@gmx.de>
Cc:     <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBsZWRzOiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B18BMHB046498
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638861B4.002 by FangMail milter!
X-FangMail-Envelope: 1669882292/4NN81047nmz4xyCN/638861B4.002/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638861B4.002/4NN81047nmz4xyCN
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
 drivers/leds/leds-blinkm.c             |  8 ++++----
 drivers/leds/leds-lm3533.c             | 12 ++++++------
 drivers/leds/leds-lp5521.c             |  2 +-
 drivers/leds/leds-lp55xx-common.c      |  4 ++--
 drivers/leds/trigger/ledtrig-pattern.c |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index 3fb6a2fdaefa..e19cc8a7b7ca 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -139,11 +139,11 @@ static ssize_t show_color_common(struct device *dev, char *buf, int color)
 		return ret;
 	switch (color) {
 	case RED:
-		return scnprintf(buf, PAGE_SIZE, "%02X\n", data->red);
+		return sysfs_emit(buf, "%02X\n", data->red);
 	case GREEN:
-		return scnprintf(buf, PAGE_SIZE, "%02X\n", data->green);
+		return sysfs_emit(buf, "%02X\n", data->green);
 	case BLUE:
-		return scnprintf(buf, PAGE_SIZE, "%02X\n", data->blue);
+		return sysfs_emit(buf, "%02X\n", data->blue);
 	default:
 		return -EINVAL;
 	}
@@ -253,7 +253,7 @@ static DEVICE_ATTR_RW(blue);
 static ssize_t test_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 			 "#Write into test to start test sequence!#\n");
 }

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 43d5970d96aa..bcd414eb4724 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -314,7 +314,7 @@ static ssize_t show_id(struct device *dev,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct lm3533_led *led = to_lm3533_led(led_cdev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", led->id);
+	return sysfs_emit(buf, "%d\n", led->id);
 }

 /*
@@ -344,7 +344,7 @@ static ssize_t show_risefalltime(struct device *dev,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%x\n", val);
+	return sysfs_emit(buf, "%x\n", val);
 }

 static ssize_t show_risetime(struct device *dev,
@@ -415,7 +415,7 @@ static ssize_t show_als_channel(struct device *dev,

 	channel = (val & LM3533_REG_CTRLBANK_BCONF_ALS_CHANNEL_MASK) + 1;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
+	return sysfs_emit(buf, "%u\n", channel);
 }

 static ssize_t store_als_channel(struct device *dev,
@@ -465,7 +465,7 @@ static ssize_t show_als_en(struct device *dev,

 	enable = val & LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return sysfs_emit(buf, "%d\n", enable);
 }

 static ssize_t store_als_en(struct device *dev,
@@ -518,7 +518,7 @@ static ssize_t show_linear(struct device *dev,
 	else
 		linear = 0;

-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return sysfs_emit(buf, "%x\n", linear);
 }

 static ssize_t store_linear(struct device *dev,
@@ -564,7 +564,7 @@ static ssize_t show_pwm(struct device *dev,
 	if (ret)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t store_pwm(struct device *dev,
diff --git a/drivers/leds/leds-lp5521.c b/drivers/leds/leds-lp5521.c
index 7ff20c260504..19478d9c19a7 100644
--- a/drivers/leds/leds-lp5521.c
+++ b/drivers/leds/leds-lp5521.c
@@ -469,7 +469,7 @@ static ssize_t lp5521_selftest(struct device *dev,
 	ret = lp5521_run_selftest(chip, buf);
 	mutex_unlock(&chip->lock);

-	return scnprintf(buf, PAGE_SIZE, "%s\n", ret ? "FAIL" : "OK");
+	return sysfs_emit(buf, "%s\n", ret ? "FAIL" : "OK");
 }

 /* device attributes */
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index ca2e28fb843f..c1940964067a 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -88,7 +88,7 @@ static ssize_t led_current_show(struct device *dev,
 {
 	struct lp55xx_led *led = dev_to_lp55xx_led(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", led->led_current);
+	return sysfs_emit(buf, "%d\n", led->led_current);
 }

 static ssize_t led_current_store(struct device *dev,
@@ -121,7 +121,7 @@ static ssize_t max_current_show(struct device *dev,
 {
 	struct lp55xx_led *led = dev_to_lp55xx_led(dev);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", led->max_current);
+	return sysfs_emit(buf, "%d\n", led->max_current);
 }

 static DEVICE_ATTR_RW(led_current);
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 43a265dc4696..885ca63f383f 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -155,7 +155,7 @@ static ssize_t repeat_show(struct device *dev, struct device_attribute *attr,

 	mutex_unlock(&data->lock);

-	return scnprintf(buf, PAGE_SIZE, "%d\n", repeat);
+	return sysfs_emit(buf, "%d\n", repeat);
 }

 static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
-- 
2.25.1
