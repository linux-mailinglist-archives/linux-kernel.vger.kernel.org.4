Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC008735EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFSUrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjFSUr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:47:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246CCE72;
        Mon, 19 Jun 2023 13:47:23 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31122c346f4so4353671f8f.3;
        Mon, 19 Jun 2023 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687207641; x=1689799641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMRt/p5AFtsO4siT1tV2NzpQd/2q9CfYdluDALvWqMM=;
        b=MImxId9FbF6JT3vzfROAnJb0iM3n8pb1LG4GlrNthaZreA/7PhQfVBGRDN0IXfIB1q
         EotHJtpDaWTb/uvIbATG+OtnEG3Xj0t7P9h12lyFcPkrSwGALgXKrP9D9jaeqs0UUDxK
         J68OEJKPS45lT21dED8dkk5bWwQJAtkof60atirR/dqsWqOvPX4km7s72Za+dcIIp3je
         oZ3qoJlZbY5/uKr9/pcf5MPLzKSwVFLtIlAjIkXZmsDxOzA2tuOdtYUTufcBXkwTukwN
         47gd6O9nbgmuqsKQmekDTIOfD1KgbDmXHs/HmBCIP6aOc8SyUpgRvV2uAs8VqUSrub7q
         cFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687207641; x=1689799641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMRt/p5AFtsO4siT1tV2NzpQd/2q9CfYdluDALvWqMM=;
        b=cyxG0W4BJc92bUjUvmH0Evb8xF8u9GHL5pfgZ3kV/0a30/YSP+eIZeDi5cpkveq/eU
         FtnGZMQ09B63zMgiQGuluCp45IE011OTLSxnxKOqHL18XbYDqacqJy7F1wKSrhIQJhPb
         hqr+dCV8t23HboI3bC6u9ukrxW98ToVd5afajUAJ3KsgCZ6/RVIYxV5zeoMI+wB8Fld4
         h7N0UaoFPslnzjHZBb5cp17xeb6QZVWBpdJZjKpmsD2S74FiFLVJNCl8HWKs4/sDcJAw
         MxoZuUDPV6asJKFOWq25yJlKUE5oD4vm84/cjk2VRqW5XtIwxXfsUieaFFF7hx67NkCz
         uzFQ==
X-Gm-Message-State: AC+VfDwKjXiLzjHnQyWIJavIqb46P9vKS/qwxKIFP4Usfa7m8kIxUjQW
        SGSUwg+B0HD/fJYt2gUY7bw=
X-Google-Smtp-Source: ACHHUZ6aEqqeAVR75LlHXFzKG59IG6cEJMOrgXTA1biqrUtHopIX2at5M6Pss1XLD1nRlSxINzKzLQ==
X-Received: by 2002:a5d:468d:0:b0:30f:be1f:8711 with SMTP id u13-20020a5d468d000000b0030fbe1f8711mr10415118wrq.63.1687207641431;
        Mon, 19 Jun 2023 13:47:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id k10-20020adff5ca000000b0030ae87bd3e3sm434043wrp.18.2023.06.19.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:47:20 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [net-next PATCH v5 2/3] leds: trigger: netdev: add additional specific link duplex mode
Date:   Mon, 19 Jun 2023 22:46:59 +0200
Message-Id: <20230619204700.6665-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619204700.6665-1-ansuelsmth@gmail.com>
References: <20230619204700.6665-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/leds/trigger/ledtrig-netdev.c | 27 +++++++++++++++++++++++++--
 include/linux/leds.h                  |  2 ++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index f625738392bf..2c1c9e95860e 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -55,6 +55,7 @@ struct led_netdev_data {
 
 	unsigned long mode;
 	int link_speed;
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
 	trigger_data->link_speed = SPEED_UNKNOWN;
+	trigger_data->duplex = DUPLEX_UNKNOWN;
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
 	trigger_data->link_speed = SPEED_UNKNOWN;
+	trigger_data->duplex = DUPLEX_UNKNOWN;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
 		get_device_state(trigger_data);
@@ -487,7 +508,9 @@ static void netdev_trig_work(struct work_struct *work)
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
index 126b79019429..3a65ff72bb04 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -558,6 +558,8 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_LINK_10,
 	TRIGGER_NETDEV_LINK_100,
 	TRIGGER_NETDEV_LINK_1000,
+	TRIGGER_NETDEV_HALF_DUPLEX,
+	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
 	TRIGGER_NETDEV_RX,
 
-- 
2.40.1

