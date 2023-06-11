Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC272B49C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 00:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFKWa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFKWaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 18:30:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED02E4E;
        Sun, 11 Jun 2023 15:30:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6e1393f13so26709645e9.0;
        Sun, 11 Jun 2023 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686522615; x=1689114615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEXma0Sl180nUlDy6+RTrJLABcn2sDvoD62d8qplRAU=;
        b=VCCc/A2cfpGNAa3ZCYJfYjZG9Ogc9ISQJ9820DHNQPBlM3feGZqTajn4qcaPWBGShC
         ifcQCYgLQY20LhxjB5yE2QnBeThS0AKvCv60cC2PGr08xZOlLdkX6tK9F93KhvnHri8E
         ZPH1aNYzv8uc73SN+Cll23lHm2OpGd/R0bFJ34bgqMnsaolm+KVwh0JOyXW2WcKN8C8X
         wKyWi29I4VKIjU+ZPt1Tqpcj9AdZWS9Dip/RjycddMaPSKsrVQ59KPSm7/c1fq4nCrEn
         LZ6DXhqe7YazUBMLn+MDhZhoK0K3yNttCwgshY/zNyF35J8EoUcy3d6IWnxeJHwOu2+/
         tu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686522615; x=1689114615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEXma0Sl180nUlDy6+RTrJLABcn2sDvoD62d8qplRAU=;
        b=RlFIsv+vTMvhjYC4CDTMKrqmQVS99FAaGCSGSE6hArsC5YV0vtk6udtrnZQ/SzAkuh
         Pe/bIJMCNeavgKyangknkak7EO3eH1OTxttNNiTwWi7qhNg8h7zqlwtuIzPtFcys7dJS
         e0lxQXpHUM8eMPlyNxvBe4NT0buMPhERXa50bO7Nm7kWJjRv+aSWXOZFLohaI5Z0B90I
         U4sa10YWINzB8PZvBTOvvuO7l7u7UBZiHQYak9YTMF2NwX9IzUEJz/pYlg7/suknYomM
         8M+AICQr/nkhuNfPAmu+DFJIVLnot63Wt032AmA0iEtZlsfc4v0dSqHxWP6hAV+PHB9G
         aB3w==
X-Gm-Message-State: AC+VfDx0laPQ0eNkuuWInm0U+fYs8z09c5CdcsmuZheffE37RFCLtvM4
        oqXJe+cYwvnfgEyJWj0CHQo=
X-Google-Smtp-Source: ACHHUZ4lcl90P4fKNIUb69EmUEMLI+Rhrj4RTVKZDzmWnzHynvoU9e9Ff5p0ws0qDxjDfjuQdPZ5MQ==
X-Received: by 2002:a7b:c84c:0:b0:3f7:33cf:707b with SMTP id c12-20020a7bc84c000000b003f733cf707bmr5563528wml.1.1686522615332;
        Sun, 11 Jun 2023 15:30:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id a7-20020a05600c224700b003f60a9ccd34sm9509479wmm.37.2023.06.11.15.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 15:30:14 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] leds: trigger: netdev: add additional specific link duplex mode
Date:   Sun, 11 Jun 2023 16:47:59 +0200
Message-Id: <20230611144759.6096-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611144759.6096-1-ansuelsmth@gmail.com>
References: <20230611144759.6096-1-ansuelsmth@gmail.com>
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
index 8e6132f069af..90b682d49998 100644
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

