Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021C761921B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKDHhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKDHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:37:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70E65D2;
        Fri,  4 Nov 2022 00:37:19 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g24so4160347plq.3;
        Fri, 04 Nov 2022 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MemN4TDe1mA5TiRCcsQbYoP1am+ZBwYtE5zTkLVCqlw=;
        b=SnJKpJHb0zssD/RUj8u8GKrEhsZsasba6o/2H1blzK7qe1v3T7pJMWtirmVrdJs+Uz
         /5Wk5MEhMpR1itLUnsWnvuXdHYDGHG3PW8PqMQBfTJuDChK09VzbWey6rGvJGeKpujn7
         lUgyoF0kw2Mbr9TU6DJ9huatEASEP8JFX4Kl1+TpW6YLCrZEqMhsYO2ypLN9vZPfk3pv
         ShHbsBsWRfusEl+/dPIFkwTVcfCCsCj+MooPwo3AcocrPw0BRPtxtisyQ5sY0WxWGKps
         FOPhcpvugEdGaV+uDHAfVy/AZi5o8M4TCGhw2ldzxOJZk/gVUVpuc86+3ExxrmJuwzbs
         xXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MemN4TDe1mA5TiRCcsQbYoP1am+ZBwYtE5zTkLVCqlw=;
        b=XC95lsh+cE+RCqP0N3HlaZkyqDfNhDqL3y/AiSUmYv8GH7F9h0yzLGyKp46F7x7w0C
         Dj6ymXS4+um9p8Xri1QxAnefjdHVAt7CDRPHjnDoLjddoZdDEyYJC2aqY9FuFt5lsv5c
         LhoEgWE67B9UgTqAhQxb70I736e/pjZTGj9zlKTZ+vSRcRVD0F0birGBQnFmW+LtsSzs
         QNOTrFXH5DacpzOyLXaa9kTwSh3+iHyCPlHoXo1EUxRTqvezVp4UZ5a4WFsW+YV6Fi4q
         23RUVk6eyODeMzURdbhBMu29nOxRUblYjMVZtBqEPmNbTPSy7WNdP70OhVKAf6XQAEka
         Sgog==
X-Gm-Message-State: ACrzQf1Jm8zgqEgIFz5ctIlnI1zaGKhblju/UIpTOrKEmUTD+0RRkVwb
        HgOVWLqoksv2rWa+6ZwR5WL80mg3+YM=
X-Google-Smtp-Source: AMsMyM4Rh/nNyjPYCOt0Y/5UT0zxfbTNz1Aj/u7887L6PRRTEJro+f6F53bcsjsS/w5JHhXbSJ0G4A==
X-Received: by 2002:a17:90b:3e88:b0:213:6442:5614 with SMTP id rj8-20020a17090b3e8800b0021364425614mr46641751pjb.58.1667547438435;
        Fri, 04 Nov 2022 00:37:18 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902714100b00183c67844aesm1947663plm.22.2022.11.04.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 00:37:18 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] can: etas_es58x: report the firmware version through ethtool
Date:   Fri,  4 Nov 2022 16:36:59 +0900
Message-Id: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ES58x devices report below information in their usb product info
string:

  * the firmware version
  * the bootloader version
  * the hardware revision

Report the firmware version through ethtool_drvinfo::fw_version.
Because struct ethtool_drvinfo has no fields to report the boatloader
version nor the hardware revision, continue to print these in the
kernel log (c.f. es58x_print_product_info()).

While doing so, bump up copyright year of each modified files.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es581_4.c    |   5 +-
 drivers/net/can/usb/etas_es58x/es58x_core.c | 140 +++++++++++++-------
 drivers/net/can/usb/etas_es58x/es58x_core.h |  11 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c   |   5 +-
 4 files changed, 108 insertions(+), 53 deletions(-)

diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 1bcdcece5ec7..1d6ae7b279cf 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/kernel.h>
@@ -492,7 +492,8 @@ const struct es58x_parameters es581_4_param = {
 	.tx_bulk_max = ES581_4_TX_BULK_MAX,
 	.urb_cmd_header_len = ES581_4_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-	.tx_urb_max = ES58X_TX_URBS_MAX
+	.tx_urb_max = ES58X_TX_URBS_MAX,
+	.prod_info_delim = ','
 };
 
 const struct es58x_operators es581_4_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 51294b717040..7c20a73169f3 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/ethtool.h>
@@ -1978,10 +1978,6 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
 };
 
-static const struct ethtool_ops es58x_ethtool_ops = {
-	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
-};
-
 /**
  * es58x_set_mode() - Change network device mode.
  * @netdev: CAN network device.
@@ -2062,6 +2058,96 @@ static void es58x_init_priv(struct es58x_device *es58x_dev,
 	can->do_set_mode = es58x_set_mode;
 }
 
+/**
+ * es58x_get_product_info() - Get the product information.
+ * @es58x_dev: ES58X device.
+ * @prod_info: Buffer where to store the product information.
+ * @prod_info_len: Length of @prod_info.
+ *
+ * Do a synchronous call to get the product information.
+ *
+ * Return: zero on success, errno when any error occurs.
+ */
+static int es58x_get_product_info(struct es58x_device *es58x_dev,
+				  char *prod_info, size_t prod_info_len)
+{
+	struct usb_device *udev = es58x_dev->udev;
+	const int es58x_prod_info_idx = 6;
+	int ret;
+
+	ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
+	if (ret < 0) {
+		dev_err(es58x_dev->dev,
+			"%s: Could not read the product info: %pe\n",
+			__func__, ERR_PTR(ret));
+		return ret;
+	}
+	if (ret >= prod_info_len - 1) {
+		dev_warn(es58x_dev->dev,
+			 "%s: Buffer is too small, result might be truncated\n",
+			 __func__);
+	}
+
+	return 0;
+}
+
+/**
+ * es58x_print_product_info() - Print the product information.
+ * @es58x_dev: ES58X device.
+ *
+ * Return: zero on success, errno when any error occurs.
+ */
+static int es58x_print_product_info(struct es58x_device *es58x_dev)
+{
+	char prod_info[ES58X_USB_STRING_SIZE];
+	int ret;
+
+	ret = es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info));
+	if (ret == 0)
+		dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
+
+	return ret;
+}
+
+/**
+ * es58x_get_drvinfo() - Get the driver name and firmware version.
+ * @netdev: CAN network device.
+ * @drvinfo: Driver information.
+ *
+ * Populate @drvinfo with the driver name and the firwmware version.
+ */
+static void es58x_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	struct es58x_device *es58x_dev = es58x_priv(netdev)->es58x_dev;
+	char prod_info[ES58X_USB_STRING_SIZE];
+	char *start, *end;
+
+	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+
+	if (es58x_get_product_info(es58x_dev, prod_info, sizeof(prod_info)) < 0)
+		return;
+
+	/* The firmware prefix is either "FW_V" or "FW:" */
+	start = strstr(prod_info, "FW");
+	if (!start)
+		return;
+	/* Go to first digit */
+	while (!isdigit(*start))
+		start++;
+
+	end = strchr(start, es58x_dev->param->prod_info_delim);
+	if (!end || end - start >= sizeof(drvinfo->fw_version))
+		return;
+
+	strscpy(drvinfo->fw_version, start, end - start + 1);
+}
+
+static const struct ethtool_ops es58x_ethtool_ops = {
+	.get_drvinfo = es58x_get_drvinfo,
+	.get_ts_info = can_ethtool_op_get_ts_info_hwts,
+};
+
 /**
  * es58x_init_netdev() - Initialize the network device.
  * @es58x_dev: ES58X device.
@@ -2119,48 +2205,6 @@ static void es58x_free_netdevs(struct es58x_device *es58x_dev)
 	}
 }
 
-/**
- * es58x_get_product_info() - Get the product information and print them.
- * @es58x_dev: ES58X device.
- *
- * Do a synchronous call to get the product information.
- *
- * Return: zero on success, errno when any error occurs.
- */
-static int es58x_get_product_info(struct es58x_device *es58x_dev)
-{
-	struct usb_device *udev = es58x_dev->udev;
-	const int es58x_prod_info_idx = 6;
-	/* Empirical tests show a prod_info length of maximum 83,
-	 * below should be more than enough.
-	 */
-	const size_t prod_info_len = 127;
-	char *prod_info;
-	int ret;
-
-	prod_info = kmalloc(prod_info_len, GFP_KERNEL);
-	if (!prod_info)
-		return -ENOMEM;
-
-	ret = usb_string(udev, es58x_prod_info_idx, prod_info, prod_info_len);
-	if (ret < 0) {
-		dev_err(es58x_dev->dev,
-			"%s: Could not read the product info: %pe\n",
-			__func__, ERR_PTR(ret));
-		goto out_free;
-	}
-	if (ret >= prod_info_len - 1) {
-		dev_warn(es58x_dev->dev,
-			 "%s: Buffer is too small, result might be truncated\n",
-			 __func__);
-	}
-	dev_info(es58x_dev->dev, "Product info: %s\n", prod_info);
-
- out_free:
-	kfree(prod_info);
-	return ret < 0 ? ret : 0;
-}
-
 /**
  * es58x_init_es58x_dev() - Initialize the ES58X device.
  * @intf: USB interface.
@@ -2243,7 +2287,7 @@ static int es58x_probe(struct usb_interface *intf,
 	if (IS_ERR(es58x_dev))
 		return PTR_ERR(es58x_dev);
 
-	ret = es58x_get_product_info(es58x_dev);
+	ret = es58x_print_product_info(es58x_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.h b/drivers/net/can/usb/etas_es58x/es58x_core.h
index 640fe0a1df63..3a9f6582c06d 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.h
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.h
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #ifndef __ES58X_COMMON_H__
@@ -49,6 +49,12 @@
 /* A magic number sent by the ES581.4 to inform it is alive. */
 #define ES58X_HEARTBEAT 0x11
 
+/* USB strings are at most 127 characters and es58x devices only use
+ * ASCII (i.e. one byte). Also, the maximum observed length is 83
+ * bytes.
+ */
+#define ES58X_USB_STRING_SIZE (127 + 1)
+
 /**
  * enum es58x_driver_info - Quirks of the device.
  * @ES58X_DUAL_CHANNEL: Device has two CAN channels. If this flag is
@@ -306,6 +312,8 @@ struct es58x_priv {
  * @urb_cmd_header_len: Length of the URB command header.
  * @rx_urb_max: Number of RX URB to be allocated during device probe.
  * @tx_urb_max: Number of TX URB to be allocated during device probe.
+ * @prod_info_delim: delimiter of the different fields in the USB
+ *	product information string.
  */
 struct es58x_parameters {
 	const struct can_bittiming_const *bittiming_const;
@@ -324,6 +332,7 @@ struct es58x_parameters {
 	u8 urb_cmd_header_len;
 	u8 rx_urb_max;
 	u8 tx_urb_max;
+	char prod_info_delim;
 };
 
 /**
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index c97ffa71fd75..3d781b89df4a 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -8,7 +8,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
  */
 
 #include <linux/kernel.h>
@@ -550,7 +550,8 @@ const struct es58x_parameters es58x_fd_param = {
 	.tx_bulk_max = ES58X_FD_TX_BULK_MAX,
 	.urb_cmd_header_len = ES58X_FD_URB_CMD_HEADER_LEN,
 	.rx_urb_max = ES58X_RX_URBS_MAX,
-	.tx_urb_max = ES58X_TX_URBS_MAX
+	.tx_urb_max = ES58X_TX_URBS_MAX,
+	.prod_info_delim = '-'
 };
 
 const struct es58x_operators es58x_fd_ops = {
-- 
2.37.4

