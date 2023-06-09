Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD6B729BFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239804AbjFINvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbjFINvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:51:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76318D;
        Fri,  9 Jun 2023 06:51:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so2201486e87.2;
        Fri, 09 Jun 2023 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318672; x=1688910672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYq8sLZvkKIRyh10Exy08xI3yetDl/UeLuaCQ7b94Wk=;
        b=aunkLK03le309fkrjQAgSe2FayEUzMUvrrsFxVMP6JWPs8On1DjlSZnQ9k+519WJbG
         +49T3yrIY4OrSKwH24BXaKanNwlyBFpbVJwS/pZNB5o9m4C9BZkWNkYqtT6kZTkKDhD5
         CcPOVmoJ3cv1twb83/VSCkuIYZpoe67lb5yO7p5XzfoiEzZS3MvHzL9Sk2MOwmFVVcLc
         WnW7wFheWjl9Wx6cNeeEgrfWrLUBTuf8iw66idIQbLIBL4cOnDF8qVLbpu2SOtuNhvjx
         0x01NoyubaDhiR86H+Nw4fHMAwrCkpDIf0xaj2++M1q5lmCYBBT3RvYug5Cw58T2tP+V
         liIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318672; x=1688910672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYq8sLZvkKIRyh10Exy08xI3yetDl/UeLuaCQ7b94Wk=;
        b=MEFYHHnpcBFL63bhksD/35xt/2HEBN5YUlt8eanluWPkuxvZx/eeF506MYDUgPPdeO
         o2TTvYbFgnEc6VcFjQ4Hi6CaJoAszlXB9Gqf037k7lZhPTHbI/C13ixejY/TH8LbuulK
         VMQkRkMSzOAeI3mWaywpGPnXNWBSwgWk/JskAp0FSJOA7nDbB5+7yFxAZ6MPT2QP1yES
         m+wK0xV2ankbLM05jdWSvCLgaK0JwGhOEx4BgDbsRTLm9GKZ8/WV41gjOeG5faGnTVpb
         3RuLYaSj0dnQNTd7+oUdS44lQ7y/TUCkooyZWEkLOhLXruTbA5sMAv4L2oUk0lPYqX0M
         9NNA==
X-Gm-Message-State: AC+VfDxtUXRWl3kTkd/fEdbhRB6qj6I0UNc5KXPNgAdUCNv+Bk7blbss
        0+iH1X79dkrQ+2waznU1hQY=
X-Google-Smtp-Source: ACHHUZ6lf1FuckB7RHwYWbLXPQX/YZWBtPcQpxD+c0qXi5U7hD+gwtJhQ7Mc0oFtVMRiLLGU8fGEhw==
X-Received: by 2002:ac2:5bd1:0:b0:4f4:b47d:5c07 with SMTP id u17-20020ac25bd1000000b004f4b47d5c07mr902477lfn.46.1686318671881;
        Fri, 09 Jun 2023 06:51:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm4533962wro.95.2023.06.09.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:51:11 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] leds: trigger: netdev: add additional specific link duplex mode
Date:   Fri,  9 Jun 2023 15:51:02 +0200
Message-Id: <20230609135103.14221-3-ansuelsmth@gmail.com>
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
 drivers/leds/trigger/ledtrig-netdev.c | 26 +++++++++++++++++++++++++-
 include/linux/leds.h                  |  2 ++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index f20d5168710a..3c1571b620e4 100644
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
@@ -218,6 +227,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = 0;
+	trigger_data->duplex = 0;
 	if (trigger_data->net_dev != NULL) {
 		struct ethtool_link_ksettings cmd;
 
@@ -229,6 +239,7 @@ static int set_device_name(struct led_netdev_data *trigger_data,
 			rtnl_unlock();
 
 			trigger_data->link_speed = cmd.base.speed;
+			trigger_data->duplex = cmd.base.duplex;
 		}
 	}
 
@@ -270,6 +281,8 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_HALF_DUPLEX:
+	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -298,6 +311,8 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_LINK_10:
 	case TRIGGER_NETDEV_LINK_100:
 	case TRIGGER_NETDEV_LINK_1000:
+	case TRIGGER_NETDEV_HALF_DUPLEX:
+	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
 		bit = attr;
@@ -344,6 +359,8 @@ DEFINE_NETDEV_TRIGGER(link, TRIGGER_NETDEV_LINK);
 DEFINE_NETDEV_TRIGGER(link_10, TRIGGER_NETDEV_LINK_10);
 DEFINE_NETDEV_TRIGGER(link_100, TRIGGER_NETDEV_LINK_100);
 DEFINE_NETDEV_TRIGGER(link_1000, TRIGGER_NETDEV_LINK_1000);
+DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
+DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
 
@@ -390,6 +407,8 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_link_10.attr,
 	&dev_attr_link_100.attr,
 	&dev_attr_link_1000.attr,
+	&dev_attr_full_duplex.attr,
+	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
 	&dev_attr_interval.attr,
@@ -422,6 +441,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 
 	trigger_data->carrier_link_up = false;
 	trigger_data->link_speed = 0;
+	trigger_data->duplex = 0;
 	switch (evt) {
 	case NETDEV_CHANGENAME:
 		trigger_data->carrier_link_up = netif_carrier_ok(dev);
@@ -430,6 +450,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
 
 			trigger_data->link_speed = cmd.base.speed;
+			trigger_data->duplex = cmd.base.duplex;
 		}
 
 		fallthrough;
@@ -450,6 +471,7 @@ static int netdev_trig_notify(struct notifier_block *nb,
 			__ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
 
 			trigger_data->link_speed = cmd.base.speed;
+			trigger_data->duplex = cmd.base.duplex;
 		}
 		break;
 	}
@@ -496,7 +518,9 @@ static void netdev_trig_work(struct work_struct *work)
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

