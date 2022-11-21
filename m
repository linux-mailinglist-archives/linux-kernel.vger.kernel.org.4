Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E98632274
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKUMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiKUMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:39:41 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FC1C412;
        Mon, 21 Nov 2022 04:39:33 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 721865FD0B;
        Mon, 21 Nov 2022 15:39:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669034371;
        bh=DUvu+YKp1hu6pdL6wHkphNXlL3BTh1Kqk0H1tPtLv58=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=nq2oAr7XLtOOyJIHjGIg273R7HJyGriAS+nJKSg87sTFIFt10dptkhBo7lA4w7QB7
         M8kL5F+VUAWVsk0IsKS50G53c+6wjjRPZtuvwmlfKEOxqjFnMrk+2i9jOJaHlM1MXE
         s0iQdr8yt+B9UZ2X1AoymTGVkpg1mKE6SKqJAiwNzupijmBJ0Wj9vzBh30OrVa2ZCN
         skT39m4hziy1wg8dsZF+A3wKnXNBCJMy6xBHH+TEnvg37TCvL/h027cmxy7V2n19d7
         yDKRz3eV6yS7GPgJ9n+xVp2shgcKbs8QQRrCROmNFwNEX7PnUae1GoY8cbOpYU+qMt
         pRE7PC4d5PIWg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 21 Nov 2022 15:39:31 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 2/2] leds: trigger: pattern: notify usespace if pattern finished
Date:   Mon, 21 Nov 2022 15:38:33 +0300
Message-ID: <20221121123833.164614-3-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
References: <20221121123833.164614-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/11/21 03:43:00 #20593185
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current moment, userspace caller can schedule LED pattern with
appropriate parameters, but it doesn't have ability to listen to any
events indicated pattern finished. This patch implements such an event
using sysfs node and sysfs_notify_dirent() call.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../testing/sysfs-class-led-trigger-pattern   | 11 ++++
 drivers/leds/trigger/ledtrig-pattern.c        | 63 ++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index 8c57d2780554..b2564123b54b 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -38,3 +38,14 @@ Description:
 
 		It should be noticed that some leds, like EL15203000 may
 		only support indefinitely patterns, so they always store -1.
+
+What:		/sys/class/leds/<led>/is_running
+Date:		October 2022
+KernelVersion:	6.1
+Description:
+		Indicates running of a software pattern for the LED.
+
+		This file is read only and supports poll() to detect when the
+		software pattern ended.
+
+		1 means pattern is running and number 0 are finish or not run.
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index 354304b404aa..19a6b5dcd7af 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -33,7 +33,9 @@ struct pattern_trig_data {
 	int delta_t;
 	bool is_indefinite;
 	bool is_hw_pattern;
+	bool is_running;
 	struct timer_list timer;
+	struct kernfs_node *is_running_kn;
 };
 
 static void pattern_trig_update_patterns(struct pattern_trig_data *data)
@@ -76,8 +78,14 @@ static void pattern_trig_timer_function(struct timer_list *t)
 	struct pattern_trig_data *data = from_timer(data, t, timer);
 
 	for (;;) {
-		if (!data->is_indefinite && !data->repeat)
+		if (!data->is_indefinite && !data->repeat) {
+			data->is_running = false;
+
+			if (data->is_running_kn)
+				sysfs_notify_dirent(data->is_running_kn);
+
 			break;
+		}
 
 		if (data->curr->brightness == data->next->brightness) {
 			/* Step change of brightness */
@@ -137,6 +145,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	data->curr = data->patterns;
 	data->next = data->patterns + 1;
 	data->timer.expires = jiffies;
+	data->is_running = true;
 	add_timer(&data->timer);
 
 	return 0;
@@ -176,6 +185,7 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->lock);
 
 	del_timer_sync(&data->timer);
+	data->is_running = false;
 
 	if (data->is_hw_pattern)
 		led_cdev->pattern_clear(led_cdev);
@@ -267,6 +277,7 @@ static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
 	mutex_lock(&data->lock);
 
 	del_timer_sync(&data->timer);
+	data->is_running = false;
 
 	if (data->is_hw_pattern)
 		led_cdev->pattern_clear(led_cdev);
@@ -327,6 +338,16 @@ static ssize_t hw_pattern_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(hw_pattern);
 
+static ssize_t is_running_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+
+	return sysfs_emit(buf, "%d\n", data->is_running);
+}
+static DEVICE_ATTR_RO(is_running);
+
 static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
@@ -382,9 +403,41 @@ static void pattern_init(struct led_classdev *led_cdev)
 	kfree(pattern);
 }
 
+static int pattern_trig_add_is_running(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+	struct device *dev = led_cdev->dev;
+	int ret;
+
+	ret = device_create_file(dev, &dev_attr_is_running);
+	if (ret) {
+		dev_err(dev,
+			"Error creating is_running (%pe)\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	data->is_running_kn = sysfs_get_dirent(dev->kobj.sd, "is_running");
+	if (!data->is_running_kn) {
+		dev_err(dev, "Error getting is_running kernelfs\n");
+		device_remove_file(dev, &dev_attr_is_running);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void pattern_trig_remove_is_running(struct led_classdev *led_cdev)
+{
+	struct pattern_trig_data *data = led_get_trigger_data(led_cdev);
+
+	sysfs_put(data->is_running_kn);
+	device_remove_file(led_cdev->dev, &dev_attr_is_running);
+}
+
 static int pattern_trig_activate(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data;
+	int err;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -403,6 +456,13 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 	data->led_cdev = led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+
+	err = pattern_trig_add_is_running(led_cdev);
+	if (err)
+		dev_warn(led_cdev->dev,
+			 "pattern ended notifications disabled (%pe)\n",
+			 ERR_PTR(err));
+
 	led_cdev->activated = true;
 
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
@@ -428,6 +488,7 @@ static void pattern_trig_deactivate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear(led_cdev);
 
 	del_timer_sync(&data->timer);
+	pattern_trig_remove_is_running(led_cdev);
 
 	led_set_brightness(led_cdev, LED_OFF);
 	kfree(data);
-- 
2.38.1

