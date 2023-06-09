Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2027729BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjFINvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbjFINvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:51:16 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6F3580;
        Fri,  9 Jun 2023 06:51:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso14091215e9.0;
        Fri, 09 Jun 2023 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318673; x=1688910673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kprq6jjAZv3c6K51awIK2c2WIWDwE0VUEJPfJtDg3Ao=;
        b=kBmvvrTBMigUd6EVBWiTB4GST2mTmnUhG5VPYvwTZenw41yi1Voci0g5O2AUWby61c
         SbYuDBzqmVU9a8F/bqMHUomkV/a6zWeWJw0kQp5Zt7f3EEJa5Tif0ymrsRagnBxK0hqj
         mZtOlJnwjtQtEhgrBPtW+TjiY6/uGnVEotDkqm61f332N2uunUwcGZb1vxa4dZzwBqEH
         XsWPs15gkG8l31I4a3DJGECOIZo+k2cu+VaEzaZmy2D10p3W8VwobgKCn7FwIj45kdPj
         dTY0+Sm0+kNiQnlKnPf4skFmyLj2RPB/IUIf7laAWaUAEUsSQOfEae8CRKRY8iJng7xR
         dmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318673; x=1688910673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kprq6jjAZv3c6K51awIK2c2WIWDwE0VUEJPfJtDg3Ao=;
        b=VNjw1p18OoR53RRgHbq/c1m2+jWnMI/ViYCPs5zyP1z2tEyBndrbtz7z22W7g3bZaH
         GMa2m5mqBedWNqYuQc73ZEELzhEKASKhojTnYQ8sCIdSXEyVolvcbu5ds8locMs+JnGW
         9UrA16Nt5+r2o5cJ711zyuQV6NkgpZDus9gx3Kaoop6QHoxpDRuEHAkXNiYxoceTc92a
         N9EsLsHz2k7AXqFH5YEqvKpGS/YG+o+wQ9HFv847nqZ6SpqDymx3S/zT7q94ko2NoHx8
         FeHRjmDrGzz3vpgx1f3eJRHhxlX/rhrbFHCIdxvVonrUId8poMNAGsZkHXn4Lhol874m
         FDKw==
X-Gm-Message-State: AC+VfDw4QD9ImwSVIHN/HDsSLTq46Fi67bMr8kc0Bl9QQ3CMOMG58npE
        yaUwBytQQZK1hNy7qTCm580=
X-Google-Smtp-Source: ACHHUZ5RCbq7iBbZMnIoDkOahaI8xduAKEXD6FqhMzCoJyBG7j7LRB0BujP0ClvbIz6nBWQY5hnGsg==
X-Received: by 2002:a1c:4b14:0:b0:3f7:ec38:7b02 with SMTP id y20-20020a1c4b14000000b003f7ec387b02mr3898298wma.3.1686318673071;
        Fri, 09 Jun 2023 06:51:13 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm4533962wro.95.2023.06.09.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 06:51:12 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] leds: trigger: netdev: add additional mode for unified tx/rx traffic
Date:   Fri,  9 Jun 2023 15:51:03 +0200
Message-Id: <20230609135103.14221-4-ansuelsmth@gmail.com>
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

Add additional mode for unified tx/rx traffic. LED will blink on both tx
or rx traffic.

This is especially useful for PHY and Switch that supports LEDs hw
control that doesn't support split tx/rx traffic but supports blinking
on any kind of traffic in the link.

On mode set from sysfs we check if we have enabled split tx/rx mode and
reject enabling activity mode to prevent wrong and redundant
configuration.

Add additional modes:
- activity: Blink LED on both tx or rx traffic

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/leds/trigger/ledtrig-netdev.c | 21 +++++++++++++++++----
 include/linux/leds.h                  |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
index 3c1571b620e4..709371b2115f 100644
--- a/drivers/leds/trigger/ledtrig-netdev.c
+++ b/drivers/leds/trigger/ledtrig-netdev.c
@@ -117,7 +117,8 @@ static void set_baseline_state(struct led_netdev_data *trigger_data)
 		 * checking stats
 		 */
 		if (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ||
-		    test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode))
+		    test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ||
+		    test_bit(TRIGGER_NETDEV_ACTIVITY, &trigger_data->mode))
 			schedule_delayed_work(&trigger_data->work, 0);
 	}
 }
@@ -285,6 +286,7 @@ static ssize_t netdev_led_attr_show(struct device *dev, char *buf,
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
+	case TRIGGER_NETDEV_ACTIVITY:
 		bit = attr;
 		break;
 	default:
@@ -315,6 +317,7 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	case TRIGGER_NETDEV_FULL_DUPLEX:
 	case TRIGGER_NETDEV_TX:
 	case TRIGGER_NETDEV_RX:
+	case TRIGGER_NETDEV_ACTIVITY:
 		bit = attr;
 		break;
 	default:
@@ -332,6 +335,11 @@ static ssize_t netdev_led_attr_store(struct device *dev, const char *buf,
 	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode)))
 		return -EINVAL;
 
+	if (test_bit(TRIGGER_NETDEV_ACTIVITY, &mode) &&
+	    (test_bit(TRIGGER_NETDEV_TX, &mode) ||
+	     test_bit(TRIGGER_NETDEV_RX, &mode)))
+		return -EINVAL;
+
 	cancel_delayed_work_sync(&trigger_data->work);
 
 	trigger_data->mode = mode;
@@ -363,6 +371,7 @@ DEFINE_NETDEV_TRIGGER(half_duplex, TRIGGER_NETDEV_HALF_DUPLEX);
 DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
 DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
 DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
+DEFINE_NETDEV_TRIGGER(activity, TRIGGER_NETDEV_ACTIVITY);
 
 static ssize_t interval_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -411,6 +420,7 @@ static struct attribute *netdev_trig_attrs[] = {
 	&dev_attr_half_duplex.attr,
 	&dev_attr_rx.attr,
 	&dev_attr_tx.attr,
+	&dev_attr_activity.attr,
 	&dev_attr_interval.attr,
 	NULL
 };
@@ -502,14 +512,17 @@ static void netdev_trig_work(struct work_struct *work)
 
 	/* If we are not looking for RX/TX then return  */
 	if (!test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) &&
-	    !test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode))
+	    !test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) &&
+	    !test_bit(TRIGGER_NETDEV_ACTIVITY, &trigger_data->mode))
 		return;
 
 	dev_stats = dev_get_stats(trigger_data->net_dev, &temp);
 	new_activity =
-	    (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ?
+	    (test_bit(TRIGGER_NETDEV_TX, &trigger_data->mode) ||
+	     test_bit(TRIGGER_NETDEV_ACTIVITY, &trigger_data->mode) ?
 		dev_stats->tx_packets : 0) +
-	    (test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ?
+	    (test_bit(TRIGGER_NETDEV_RX, &trigger_data->mode) ||
+	     test_bit(TRIGGER_NETDEV_ACTIVITY, &trigger_data->mode) ?
 		dev_stats->rx_packets : 0);
 
 	if (trigger_data->last_activity != new_activity) {
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7d428100b42b..f11fa5e1e833 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -589,6 +589,7 @@ enum led_trigger_netdev_modes {
 	TRIGGER_NETDEV_FULL_DUPLEX,
 	TRIGGER_NETDEV_TX,
 	TRIGGER_NETDEV_RX,
+	TRIGGER_NETDEV_ACTIVITY,
 
 	/* Keep last */
 	__TRIGGER_NETDEV_MAX,
-- 
2.40.1

