Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F57672ABA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 15:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjFJNJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjFJNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 09:09:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EC01FF3;
        Sat, 10 Jun 2023 06:09:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso28077955e9.2;
        Sat, 10 Jun 2023 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686402574; x=1688994574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx7+bM8+AiQU9Trbr3LuFZlhpmDP+KyzgvYOIF3mewk=;
        b=VUq8JjMyzeYxv9BmTXrl+YFfyG4722n05JuIGcYtc7q9YDS9MKmRGLs8D2ku0ehOxe
         7qFFaX3J+NYjX/dEyFqITqXoa5WNa2Y7CtdKsT40RFG71kR9/UWsXZvnuyqqNfV3YVht
         tq4Ly23lAHGae5eSlBKxOyGNVCPO5erhfybT9ghBxUOI+JR93lK1rYWRjfiWCthylugZ
         9m46IVfIlxQug+MOFNvsA33X8lgUi+gpmYuEtmuRELTe8c589uvAJctIzmRJ5psB4Ao7
         zPcYa9j7j4uFFnMqFTSLTOCg1cTIooAwfICJKRqWAh7NkG0V7twmFgvtOtrPemAFh3GW
         jm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686402574; x=1688994574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yx7+bM8+AiQU9Trbr3LuFZlhpmDP+KyzgvYOIF3mewk=;
        b=GX5G7oP5hIqBBfHyLNyu8hG4EohDy4s/3M96+EwlA3eG94K12cqQNSkhLqfC6AwQRC
         T33C5qxzK6JgCJbBIWOI24kT9c6u3Jq4pjqw3VRZlNaxaack3zRO2MAmfqM8zjQiZPBU
         BctpLsb8+xZRs4sBfGEzKCNC+vHevcTEpz9aVeczBk7pRUNND8sQ7/64rP9BpKoTeK06
         fe3HqjG9JZswAEg0aOGbEd+B5YtMvzApzF5COypKFZR8nJGI+3PFJEZZgMAf62f+Uy0S
         ElS2XZDBFBnN8SOoDfJ2GhbOz/aP8kH2q3Num4x+e5wN3/rEDDe3BTAaRlEJh0bxzZVG
         VXbA==
X-Gm-Message-State: AC+VfDwgWn13GRBuROt9n/2EokkaxAw67dvWADHSUiD7cwedpTwrdg6p
        cpslyfxK5aeKMkUxDpEXb21HqRIugZY=
X-Google-Smtp-Source: ACHHUZ6dV4yXU8U0r2sCAbXdGqFbk/rzs4d403S6mheQqXdqltkaLKL9GbPKYZ2eSmGme9hpapCb6w==
X-Received: by 2002:a05:6000:147:b0:30a:bf2b:e03b with SMTP id r7-20020a056000014700b0030abf2be03bmr1222145wrx.1.1686402573965;
        Sat, 10 Jun 2023 06:09:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id x15-20020a5d650f000000b0030adfa48e1esm7075632wru.29.2023.06.10.06.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 06:09:33 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] leds: trigger: netdev: add additional specific link duplex mode
Date:   Sat, 10 Jun 2023 06:16:16 +0200
Message-Id: <20230610041616.21141-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610041616.21141-1-ansuelsmth@gmail.com>
References: <20230610041616.21141-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional modes for specific link duplex. Use ethtool APIs to get the
current link duplex and enable the LED accordingly. Under netdev event
handler the rtnl lock is already held and is not needed to be set to
access ethtool APIs.

This is especially useful for PHY and Switch that supports LEDs hw
control for specific link duplex.

Add additional modes:
- half_duplex: Turn on LED when link is half duplex
- full_duplex: Turn on LED when link is full duplex

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 27 +++++++++++++++++++++++++--
 include/linux/leds.h                  |  2 ++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 7e73fb56266b..88c4aef065e5 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -55,6 +55,7 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	u32 link_speed;
+	u8 duplex;
 
 	bool carrier_link_up;
 	bool hw_control;
@@ -98,6 +99,14 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		    trigger_data->link_speed == SPEED_1000)
 			blink_on = true;
 
+		if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) &&
+		    trigger_data->duplex == DUPLEX_HALF)
+			blink_on = true;
+
+		if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode) &&
+		    trigger_data->duplex == DUPLEX_FULL)
+			blink_on = true;
+
 		if (blink_on)
 			led_set_brightness(led_cdev,
 					   led_cdev->blink_brightness);
@@ -190,8 +199,10 @@ static void get_device_state(struct led_netdev_data *trigger_data)
 	if (!trigger_data->carrier_link_up)
 		return;
 
-	if (!__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd))
+	if (!__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd)) {
 		trigger_data->link_speed = cmd.base.speed;
+		trigger_data->duplex = cmd.base.duplex;
+	}
 }
 
 static ssize_t device_name_show(struct device *dev,
@@ -230,6 +241,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = 0;
+	trigger_data->duplex = 0;
 	if (trigger_data->net_dev != NULL) {
 		rtnl_lock();
 		get_device_state(trigger_data);
@@ -274,6 +286,8 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_HALF_DUPLEX:
+	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -302,6 +316,8 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_HALF_DUPLEX:
+	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -348,6 +364,8 @@ DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
 DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
 DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
 DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
+DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
+DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
 
@@ -394,6 +412,8 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_link_10.attr,
 	&dev_attr_link_100.attr,
 	&dev_attr_link_1000.attr,
+	&dev_attr_full_duplex.attr,
+	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
 	&dev_attr_interval.attr,
@@ -425,6 +445,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = 0;
+	trigger_data->duplex = 0;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
 		get_device_state(trigger_data);
@@ -486,7 +507,9 @@ static void netdev_trig_work(struct work_struct *work)
 		invert = test_bit(TRIGGER_NETDEV_LINK, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_10, &trigger_data->mode) ||
 			 test_bit(TRIGGER_NETDEV_LINK_100, &trigger_data->mode) ||
-			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode);
+			 test_bit(TRIGGER_NETDEV_LINK_1000, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &trigger_data->mode) ||
+			 test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &trigger_data->mode);
 		interval = jiffies_to_msecs(
 				atomic_read(&trigger_data->interval));
 		/* base state is ON (link present) */
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 39f15b1e772c..7d428100b42b 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -585,6 +585,8 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK_10,
 	TRIGGER_NETDEV_LINK_100,
 	TRIGGER_NETDEV_LINK_1000,
+	TRIGGER_NETDEV_HALF_DUPLEX,
+	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
 	TRIGGER_NETDEV_RX,
 
-- 
2.40.1

