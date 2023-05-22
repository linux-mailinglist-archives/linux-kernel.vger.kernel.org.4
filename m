Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F089B70C5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjEVTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:05:13 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1C8B0;
        Mon, 22 May 2023 12:05:07 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C15B05FD17;
        Mon, 22 May 2023 22:05:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684782305;
        bh=2DJAr9e4w3zOYIvLRuW4/ZmCgHR06bxLckQdsRvsB98=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=id8ObulbGeZIu8jyHRrpbIHf4neDO+ZFp6uuY7WEyzfCQA3xFaGDE5YyBwzeP6Zu6
         PPGoIJWNMoMzapXyj19EpriyuJVqAOa/Gh/hZ9Ir6dxt0xZTAkPZj+RrNAtJzlFYOS
         egNd0hQQryMnOFJcI8SldL7MCetZjjPc3rbaBEh9PfMF9MEpnZymV1XBn/gTfo4Fy5
         Xth5PU2rkrqlHDNfKw4guZjWyOf5nDd/1bhjSWjT2JC19V73cj7ELR5zQjW30zvhxT
         +FrQ+nc4JNlZeSMTS8/5nxh6096uxB8On3/Ag6qpWjBKtoidImNevtJMpR7E0W/6aO
         j1VnQTKj3zTQQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 22 May 2023 22:05:02 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Kalle Valo <kvalo@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v1] leds: trigger: pattern: add support for hrtimer
Date:   Mon, 22 May 2023 22:04:12 +0300
Message-ID: <20230522190412.374474-1-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/22 16:25:00 #21366469
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, led pattern trigger uses timer_list to schedule brightness
changing. As we know from timer_list API [1], it's not accurate to
milliseconds and depends on HZ granularity.

Example:
"0 10 0 0 50 10 50 0 100 10 100 0 150 10 150 0 200 10 200 0 250 10 250 0",
we expect it to be 60ms long, but it can actually be up to ~120ms
(add ~10ms for each pattern when HZ == 100).

But sometimes, userspace needs time accurate led patterns to make sure
that pattern will be executed during expected time slot.
To achieve this goal the patch introduces optional hrtimer usage for
led trigger pattern, because hrtimer is microseconds accurate timer.

[1]: kernel/time/timer.c#L104

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 .../testing/sysfs-class-led-trigger-pattern   |  10 ++
 drivers/leds/trigger/ledtrig-pattern.c        | 123 ++++++++++++++----
 2 files changed, 111 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
index 8c57d2780554..07d0ab35ba9a 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
@@ -12,6 +12,16 @@ Description:
 		The exact format is described in:
 		Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt
 
+What:		/sys/class/leds/<led>/hr_pattern
+Date:		May 2023
+Description:
+		Specify a software pattern for the LED, that supports altering
+		the brightness for the specified duration with one software
+		timer. It can do gradual dimming and step change of brightness.
+
+		Unlike the /sys/class/leds/<led>/pattern, this attribute runs
+		a pattern on high-resolution timer (hrtimer).
+
 What:		/sys/class/leds/<led>/hw_pattern
 Date:		September 2018
 KernelVersion:	4.20
diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
index fadd87dbe993..93d79b912290 100644
--- a/drivers/leds/trigger/ledtrig-pattern.c
+++ b/drivers/leds/trigger/ledtrig-pattern.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <linux/hrtimer.h>
 
 #define MAX_PATTERNS		1024
 /*
@@ -21,6 +22,12 @@
  */
 #define UPDATE_INTERVAL		50
 
+enum pattern_type {
+	PATTERN_TYPE_SW, /* Use standard timer for software pattern */
+	PATTERN_TYPE_HR, /* Use hrtimer for software pattern */
+	PATTERN_TYPE_HW, /* Hardware pattern */
+};
+
 struct pattern_trig_data {
 	struct led_classdev *led_cdev;
 	struct led_pattern patterns[MAX_PATTERNS];
@@ -32,8 +39,9 @@ struct pattern_trig_data {
 	int last_repeat;
 	int delta_t;
 	bool is_indefinite;
-	bool is_hw_pattern;
+	enum pattern_type type;
 	struct timer_list timer;
+	struct hrtimer hrtimer;
 };
 
 static void pattern_trig_update_patterns(struct pattern_trig_data *data)
@@ -71,10 +79,35 @@ static int pattern_trig_compute_brightness(struct pattern_trig_data *data)
 		return data->curr->brightness - step_brightness;
 }
 
-static void pattern_trig_timer_function(struct timer_list *t)
+static void pattern_trig_timer_start(struct pattern_trig_data *data)
 {
-	struct pattern_trig_data *data = from_timer(data, t, timer);
+	if (data->type == PATTERN_TYPE_HR) {
+		hrtimer_start(&data->hrtimer, ns_to_ktime(0), HRTIMER_MODE_REL);
+	} else {
+		data->timer.expires = jiffies;
+		add_timer(&data->timer);
+	}
+}
 
+static void pattern_trig_timer_cancel(struct pattern_trig_data *data)
+{
+	if (data->type == PATTERN_TYPE_HR)
+		hrtimer_cancel(&data->hrtimer);
+	else
+		del_timer_sync(&data->timer);
+}
+
+static void pattern_trig_timer_restart(struct pattern_trig_data *data,
+				       unsigned long interval)
+{
+	if (data->type == PATTERN_TYPE_HR)
+		hrtimer_forward_now(&data->hrtimer, ms_to_ktime(interval));
+	else
+		mod_timer(&data->timer, jiffies + msecs_to_jiffies(interval));
+}
+
+static void pattern_trig_timer_common_function(struct pattern_trig_data *data)
+{
 	for (;;) {
 		if (!data->is_indefinite && !data->repeat)
 			break;
@@ -83,8 +116,7 @@ static void pattern_trig_timer_function(struct timer_list *t)
 			/* Step change of brightness */
 			led_set_brightness(data->led_cdev,
 					   data->curr->brightness);
-			mod_timer(&data->timer,
-				  jiffies + msecs_to_jiffies(data->curr->delta_t));
+			pattern_trig_timer_restart(data, data->curr->delta_t);
 			if (!data->next->delta_t) {
 				/* Skip the tuple with zero duration */
 				pattern_trig_update_patterns(data);
@@ -106,8 +138,7 @@ static void pattern_trig_timer_function(struct timer_list *t)
 
 			led_set_brightness(data->led_cdev,
 					   pattern_trig_compute_brightness(data));
-			mod_timer(&data->timer,
-				  jiffies + msecs_to_jiffies(UPDATE_INTERVAL));
+			pattern_trig_timer_restart(data, UPDATE_INTERVAL);
 
 			/* Accumulate the gradual dimming time */
 			data->delta_t += UPDATE_INTERVAL;
@@ -117,6 +148,25 @@ static void pattern_trig_timer_function(struct timer_list *t)
 	}
 }
 
+static void pattern_trig_timer_function(struct timer_list *t)
+{
+	struct pattern_trig_data *data = from_timer(data, t, timer);
+
+	return pattern_trig_timer_common_function(data);
+}
+
+static enum hrtimer_restart pattern_trig_hrtimer_function(struct hrtimer *t)
+{
+	struct pattern_trig_data *data =
+		container_of(t, struct pattern_trig_data, hrtimer);
+
+	pattern_trig_timer_common_function(data);
+	if (!data->is_indefinite && !data->repeat)
+		return HRTIMER_NORESTART;
+
+	return HRTIMER_RESTART;
+}
+
 static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 {
 	struct pattern_trig_data *data = led_cdev->trigger_data;
@@ -124,7 +174,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	if (!data->npatterns)
 		return 0;
 
-	if (data->is_hw_pattern) {
+	if (data->type == PATTERN_TYPE_HW) {
 		return led_cdev->pattern_set(led_cdev, data->patterns,
 					     data->npatterns, data->repeat);
 	}
@@ -136,8 +186,7 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
 	data->delta_t = 0;
 	data->curr = data->patterns;
 	data->next = data->patterns + 1;
-	data->timer.expires = jiffies;
-	add_timer(&data->timer);
+	pattern_trig_timer_start(data);
 
 	return 0;
 }
@@ -175,9 +224,9 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->lock);
 
-	del_timer_sync(&data->timer);
+	pattern_trig_timer_cancel(data);
 
-	if (data->is_hw_pattern)
+	if (data->type == PATTERN_TYPE_HW)
 		led_cdev->pattern_clear(led_cdev);
 
 	data->last_repeat = data->repeat = res;
@@ -196,14 +245,14 @@ static ssize_t repeat_store(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RW(repeat);
 
 static ssize_t pattern_trig_show_patterns(struct pattern_trig_data *data,
-					  char *buf, bool hw_pattern)
+					  char *buf, enum pattern_type type)
 {
 	ssize_t count = 0;
 	int i;
 
 	mutex_lock(&data->lock);
 
-	if (!data->npatterns || (data->is_hw_pattern ^ hw_pattern))
+	if (!data->npatterns || data->type != type)
 		goto out;
 
 	for (i = 0; i < data->npatterns; i++) {
@@ -260,19 +309,19 @@ static int pattern_trig_store_patterns_int(struct pattern_trig_data *data,
 
 static ssize_t pattern_trig_store_patterns(struct led_classdev *led_cdev,
 					   const char *buf, const u32 *buf_int,
-					   size_t count, bool hw_pattern)
+					   size_t count, enum pattern_type type)
 {
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 	int err = 0;
 
 	mutex_lock(&data->lock);
 
-	del_timer_sync(&data->timer);
+	pattern_trig_timer_cancel(data);
 
-	if (data->is_hw_pattern)
+	if (data->type == PATTERN_TYPE_HW)
 		led_cdev->pattern_clear(led_cdev);
 
-	data->is_hw_pattern = hw_pattern;
+	data->type = type;
 	data->npatterns = 0;
 
 	if (buf)
@@ -297,7 +346,7 @@ static ssize_t pattern_show(struct device *dev, struct device_attribute *attr,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 
-	return pattern_trig_show_patterns(data, buf, false);
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_SW);
 }
 
 static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
@@ -305,7 +354,8 @@ static ssize_t pattern_store(struct device *dev, struct device_attribute *attr,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, false);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_SW);
 }
 
 static DEVICE_ATTR_RW(pattern);
@@ -316,7 +366,7 @@ static ssize_t hw_pattern_show(struct device *dev,
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 	struct pattern_trig_data *data = led_cdev->trigger_data;
 
-	return pattern_trig_show_patterns(data, buf, true);
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_HW);
 }
 
 static ssize_t hw_pattern_store(struct device *dev,
@@ -325,11 +375,33 @@ static ssize_t hw_pattern_store(struct device *dev,
 {
 	struct led_classdev *led_cdev = dev_get_drvdata(dev);
 
-	return pattern_trig_store_patterns(led_cdev, buf, NULL, count, true);
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_HW);
 }
 
 static DEVICE_ATTR_RW(hw_pattern);
 
+static ssize_t hr_pattern_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+	struct pattern_trig_data *data = led_cdev->trigger_data;
+
+	return pattern_trig_show_patterns(data, buf, PATTERN_TYPE_HR);
+}
+
+static ssize_t hr_pattern_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct led_classdev *led_cdev = dev_get_drvdata(dev);
+
+	return pattern_trig_store_patterns(led_cdev, buf, NULL, count,
+					   PATTERN_TYPE_HR);
+}
+
+static DEVICE_ATTR_RW(hr_pattern);
+
 static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 				       struct attribute *attr, int index)
 {
@@ -338,6 +410,8 @@ static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 
 	if (attr == &dev_attr_repeat.attr || attr == &dev_attr_pattern.attr)
 		return attr->mode;
+	else if (attr == &dev_attr_hr_pattern.attr)
+		return attr->mode;
 	else if (attr == &dev_attr_hw_pattern.attr && led_cdev->pattern_set)
 		return attr->mode;
 
@@ -347,6 +421,7 @@ static umode_t pattern_trig_attrs_mode(struct kobject *kobj,
 static struct attribute *pattern_trig_attrs[] = {
 	&dev_attr_pattern.attr,
 	&dev_attr_hw_pattern.attr,
+	&dev_attr_hr_pattern.attr,
 	&dev_attr_repeat.attr,
 	NULL
 };
@@ -400,12 +475,15 @@ static int pattern_trig_activate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear = NULL;
 	}
 
+	data->type = PATTERN_TYPE_SW;
 	data->is_indefinite = true;
 	data->last_repeat = -1;
 	mutex_init(&data->lock);
 	data->led_cdev = led_cdev;
 	led_set_trigger_data(led_cdev, data);
 	timer_setup(&data->timer, pattern_trig_timer_function, 0);
+	hrtimer_init(&data->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	data->hrtimer.function = pattern_trig_hrtimer_function;
 	led_cdev->activated = true;
 
 	if (led_cdev->flags & LED_INIT_DEFAULT_TRIGGER) {
@@ -431,6 +509,7 @@ static void pattern_trig_deactivate(struct led_classdev *led_cdev)
 		led_cdev->pattern_clear(led_cdev);
 
 	timer_shutdown_sync(&data->timer);
+	hrtimer_cancel(&data->hrtimer);
 
 	led_set_brightness(led_cdev, LED_OFF);
 	kfree(data);
-- 
2.40.0

