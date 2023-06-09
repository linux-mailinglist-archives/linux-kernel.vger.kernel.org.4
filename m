Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14833729BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240462AbjFINvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFINvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:51:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF230FE;
        Fri,  9 Jun 2023 06:51:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so13841885e9.1;
        Fri, 09 Jun 2023 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318671; x=1688910671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m4tE0ixG9sqs6aNXbUxazOE/cyIRGnmIyM4kgiUq+vs=;
        b=V3V9NaCpgdRHYcBEP6XgaaySravagZXfbIGhIoRGAkBBpdLvUhqEOA10SzMCpiLJrN
         5QgI3PhkpfLXHrIaohHCegvLuwScRoiW6ubPjvBC7li9BYiE34/t2WpeidDkJ+JLMDws
         aAI8rkIFXPxZmHXsKhlyDD0G7DiBJP2dSLYZKx18VQSOJy00+icS9DKvy/DeCz0TpRMR
         AqUEDJdLT5rj6V9JQU+RoBBCxV0/RDj7YSjwAbvT5iASkoW59ZNnXg6jaP2InH8p82Mh
         sMNaU6DPe93TpEnWZK/exM8baS7tzRvVQ0mYU6cXujVqeRgxo0PZ1rpZ94dSrNkYlCaj
         rCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318671; x=1688910671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4tE0ixG9sqs6aNXbUxazOE/cyIRGnmIyM4kgiUq+vs=;
        b=EsRushqTB9849idsPUb1GDbv7hkGPFHsASNlXZx9Pj2eV514qh1ac6kp54qBCKyJiz
         hxSnCZf2JAp1WknDBc3AINCeUINblafM/S7Cd8Byj33pOzIcwyQgrTbnV1k7H3IHD4sT
         /8uI8ZkbcCk0qR/7ZhsZTffAP21RKGSE0f5Qtxo+LsqY4Ls4gXBdgU+UB/NON88DFyng
         io5VuPLGXbyZ9PgFZqIXbM3t0xRoHbXBopJ8OqqHU9a/XU/6QpkpSIfrJdt6+LhYRrQs
         DaOl5T8HohPZom14r7UXQ41IjqLzbmpyC27YGpqwx/97/IXxNgCTLltxOLbr80CvpLFL
         5Xsg==
X-Gm-Message-State: AC+VfDyqFwFWJnQkRIl9PD+vvn1sFEqkOMROk8FZiYaJowh2OInXjB9S
        kfhKRAVS9KcRj0Hs/LBPPrw=
X-Google-Smtp-Source: ACHHUZ5Prxwipg2bSnx3v+jjMbOAVYsYP6X25Ot1B0lU/9NOLLHBKpwMNMJZs50tHmsyU277HV7hRg==
X-Received: by 2002:a05:600c:ac6:b0:3f6:ffe:9ef1 with SMTP id c6-20020a05600c0ac600b003f60ffe9ef1mr938272wmr.36.1686318670935;
        Fri, 09 Jun 2023 06:51:10 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm4533962wro.95.2023.06.09.06.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:51:10 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] leds: trigger: netdev: add additional specific link speed mode
Date:   Fri,  9 Jun 2023 15:51:01 +0200
Message-Id: <20230609135103.14221-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609135103.14221-1-ansuelsmth@gmail.com>
References: <20230609135103.14221-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional modes for specific link speed. Use ethtool APIs to get the
current link speed and enable the LED accordingly. Under netdev event
handler the rtnl lock is already held and is not needed to be set to
access ethtool APIs.

This is especially useful for PHY and Switch that supports LEDs hw
control for specific link speed. (example scenario a PHY that have 2 LED
connected one green and one orange where the green is turned on with
1000mbps speed and orange is turned on with 10mpbs speed)

On mode set from sysfs we check if we have enabled split link speed mode
and reject enabling generic link mode to prevent wrong and redundant
configuration.

Rework logic on the set baseline state to support these new modes to
select if we need to turn on or off the LED.

Add additional modes:
- link_10: Turn on LED when link speed is 10mbps
- link_100: Turn on LED when link speed is 100mbps
- link_1000: Turn on LED when link speed is 1000mbps

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 84 ++++++++++++++++++++++++---
 include/linux/leds.h                  |  3 +
 2 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index c9b040bacbb0..f20d5168710a 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -13,6 +13,7 @@
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/device.h>
+#include <linux/ethtool.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
@@ -21,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/rtnetlink.h>
 #include <linux/timer.h>
 #include "../leds.h"
 
@@ -52,6 +54,8 @@ struct led_netdev_data {
 	unsigned int last_activity;
 
 	unsigned long mode;
+	u32 link_speed;
+
 	bool carrier_link_up;
 	bool hw_control;
 };
@@ -77,7 +81,24 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 	if (!trigger_data->carrier_link_up) {
 		led_set_brightness(led_cdev, LED_OFF);
 	} else {
+		bool blink_on = false;
+
 		if (test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode))
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_10)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_100)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode) &&
+		    trigger_data->link_speed == SPEED_1000)
+			blink_on = true;
+
+		if (blink_on)
 			led_set_brightness(led_cdev,
 					   led_cdev->blink_brightness);
 		else
@@ -196,9 +217,21 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 		    dev_get_by_name(&init_net, trigger_data->device_name);
 
 	trigger_data->carrier_link_up = false;
-	if (trigger_data->net_dev != NULL)
+	trigger_data->link_speed = 0;
+	if (trigger_data->net_dev != NULL) {
+		struct ethtool_link_ksettings cmd;
+
 		trigger_data->carrier_link_up = netif_carrier_ok(trigger_data->net_dev);
 
+		if (trigger_data->carrier_link_up) {
+			rtnl_lock();
+			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
+			rtnl_unlock();
+
+			trigger_data->link_speed = cmd.base.speed;
+		}
+	}
+
 	trigger_data->last_activity = 0;
 
 	set_baseline_state(trigger_data);
@@ -234,6 +267,9 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 
 	switch (attr) {
 	case TRIGGER_NETDEV_LINK:
+	case TRIGGER_NETDEV_LINK_10:
+	case TRIGGER_NETDEV_LINK_100:
+	case TRIGGER_NETDEV_LINK_1000:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -249,7 +285,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 				     size_t size, enum led_trigger_netdev_modes attr)
 {
 	struct led_netdev_data *trigger_data = led_trigger_get_drvdata(dev);
-	unsigned long state;
+	unsigned long state, mode = trigger_data->mode;
 	int ret;
 	int bit;
 
@@ -259,6 +295,9 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 
 	switch (attr) {
 	case TRIGGER_NETDEV_LINK:
+	case TRIGGER_NETDEV_LINK_10:
+	case TRIGGER_NETDEV_LINK_100:
+	case TRIGGER_NETDEV_LINK_1000:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -267,13 +306,20 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 		return -EINVAL;
 	}
 
-	cancel_delayed_work_sync(&trigger_data->work);
-
 	if (state)
-		set_bit(bit, &trigger_data->mode);
+		set_bit(bit, &mode);
 	else
-		clear_bit(bit, &trigger_data->mode);
+		clear_bit(bit, &mode);
+
+	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
+	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_100, &mode) ||
+	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode)))
+		return -EINVAL;
 
+	cancel_delayed_work_sync(&trigger_data->work);
+
+	trigger_data->mode = mode;
 	trigger_data->hw_control = can_hw_control(trigger_data);
 
 	set_baseline_state(trigger_data);
@@ -295,6 +341,9 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	static DEVICE_ATTR_RW(trigger_name)
 
 DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
+DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
+DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
+DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
 
@@ -338,6 +387,9 @@ static DEVICE_ATTR_RW(interval);
 static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_device_name.attr,
 	&dev_attr_link.attr,
+	&dev_attr_link_10.attr,
+	&dev_attr_link_100.attr,
+	&dev_attr_link_1000.attr,
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
 	&dev_attr_interval.attr,
@@ -352,6 +404,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 		netdev_notifier_info_to_dev((struct netdev_notifier_info *)dv);
 	struct led_netdev_data *trigger_data =
 		container_of(nb, struct led_netdev_data, notifier);
+	struct ethtool_link_ksettings cmd;
 
 	if (evt != NETDEV_UP && evt != NETDEV_DOWN && evt != NETDEV_CHANGE
 	    && evt != NETDEV_REGISTER && evt != NETDEV_UNREGISTER
@@ -368,9 +421,17 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	mutex_lock(&trigger_data->lock);
 
 	trigger_data->carrier_link_up = false;
+	trigger_data->link_speed = 0;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
 		trigger_data->carrier_link_up = netif_carrier_ok(dev);
+
+		if (trigger_data->carrier_link_up) {
+			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
+
+			trigger_data->link_speed = cmd.base.speed;
+		}
+
 		fallthrough;
 	case NETDEV_REGISTER:
 		dev_put(trigger_data->net_dev);
@@ -384,6 +445,12 @@ static int netdev_trig_notify(struct notifier_block *nb,
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
 		trigger_data->carrier_link_up = netif_carrier_ok(dev);
+
+		if (trigger_data->carrier_link_up) {
+			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
+
+			trigger_data->link_speed = cmd.base.speed;
+		}
 		break;
 	}
 
@@ -426,7 +493,10 @@ static void netdev_trig_work(struct work_struct *work)
 	if (trigger_data->last_activity != new_activity) {
 		led_stop_software_blink(trigger_data->led_cdev);
 
-		invert = test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode);
+		invert = test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode);
 		interval = jiffies_to_msecs(
 				atomic_read(&trigger_data->interval));
 		/* base state is ON (link present) */
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 4b3d8bda1fff..39f15b1e772c 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -582,6 +582,9 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 /* Trigger specific enum */
 enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK = 0,
+	TRIGGER_NETDEV_LINK_10,
+	TRIGGER_NETDEV_LINK_100,
+	TRIGGER_NETDEV_LINK_1000,
 	TRIGGER_NETDEV_TX,
 	TRIGGER_NETDEV_RX,
 
-- 
2.40.1

