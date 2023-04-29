Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041386F270A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjD2Wtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Wti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:49:38 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Apr 2023 15:49:35 PDT
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BA10C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:49:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id E06BE148F;
        Sun, 30 Apr 2023 00:44:01 +0200 (CEST)
Authentication-Results: ext-mx-out001.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:references
        :in-reply-to:message-id:date:date:subject:subject:from:from
        :received:received:received; s=dkim20160331; t=1682808241; x=
        1684622642; bh=gJiJI1CswEzwpG8AK3p8QEhEA6777HMct7zYoWUR8Ig=; b=P
        ECw5/RMOuXS4A339MEZeQ1oOHYdjmjSXuv6Ovo9MknYrgnBTLFL0U+O2IHbqv+pY
        clkWbDK+B0MEZ6+5eDqP6ixNudeDpADAQAcB99xIZyPAWz7QsxXDmM2LVmycrjfw
        k1Y0fXfXfXb6xT0tFZgbAC2W6ffONKN3EPFHvpHX++e0901+x4Q1hZMSS2k5IOjY
        wl/RN5rTSrfwRG8amFqFN6wjF28rUZR/++Kvmh7rp8KRUTkpi8zzlaBfUgP/1JbQ
        M+paXIjnF5ZrNBc+sBPZ6pQuqD8qW4v7uK6WENoe4/1befAg2cU7SOCD0XtjCvAE
        uTiyfIqfuND5eIGYfvBjUw8+rHXOZaQ8k/TKdh38hRTif6nPJZmU4ag35DNNzT1t
        NUP7/U25cOiNwN4gOh8HtTxkV0ru3bQzdK04p44olaW+f/t8IwXzLosGa3xqRStk
        +KmaVvnRimzspGgv+qSlIDYwDIBJaDC969L1D1MhYztfMuXS3UM/eEFqRvZEpdZf
        MaoiICKVCdGl0XqIXnfpfChtF+xu77HBQ9yquS6QMZ2hfE7Nts+1kihQUwqwIEiC
        129ja2slOpjIB+mhve9WGsCtm9nY6fLOtoxBwrWnTUKlaO2tfYocJqwTmqgnE+7L
        AFNBnwU/m7U4h7Z9GbxTtu2Ctd0UNwdeQ52TkuobJM=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y07i-MZnoUwg; Sun, 30 Apr 2023 00:44:01 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by mx.kolabnow.com (Postfix) with ESMTPS id 02317148D;
        Sun, 30 Apr 2023 00:44:00 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id 979D55EBF;
        Sun, 30 Apr 2023 00:44:00 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
Date:   Sat, 29 Apr 2023 15:43:48 -0700
Message-Id: <20230429224349.1935029-2-alison@she-devel.com>
In-Reply-To: <20230429224349.1935029-1-alison@she-devel.com>
References: <20230429224349.1935029-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add support for setting the baud rate of U-Blox Zed-F9P GNSS devices.
Provide functions that support writing of arbitrary configuration
messages to the device plus one that specifically configures the baud
rate.  Override the default gnss_serial_open() with a new method that
writes the configuration message to the GNSS if the devicetree declares
it to be a Zed F9P and requests a non-default baud.  Add a boolean flag
to the ubx_data private data of the GNSS driver in order to track
whether the configuration message has already been written.  Set the Zed
F9P to its default port speed if the devicetree does not specify a
value.

Signed-off-by: Alison Chaiken <achaiken@aurora.tech>
---
 drivers/gnss/ubx.c | 198 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 2 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c951be202ca2..cdaf910c52a7 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -9,18 +9,202 @@
 #include <linux/gnss.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 
 #include "serial.h"
 
+/* Total configuration message length = PREAMBLE_LEN + MESSAGE_CLASS_LEN +
+ *   MESSAGE_LENGTH_LEN + payload length + CHECKSUM_LEN
+ */
+const int32_t PREAMBLE_LEN = 2;
+const int32_t MESSAGE_CLASS_LEN = 2;
+const int32_t MESSAGE_LENGTH_LEN = 2;
+const int32_t CHECKSUM_LEN = 2;
+const size_t FIRST_CONFIG_REGISTER_BYTE = 10U;
+const size_t FIRST_VALUE_BYTE = 14U;
+const size_t FIRST_CHECKSUM_BYTE = 18U;
+const size_t CFG_MSG_TOTAL_LEN = 20U;
+
+uint8_t ZED_F9P_CFG_VALSET_MSG[] = {
+	0xB5, 0x62, /* 0-1 preamble */
+	0x06, 0x8A, /* 2-3 CFG_VALSET command */
+	0x0C, 0x00, /* 4-5 payload length = 12 for one key-value pair */
+	0x00, /* 6 U-Blox API version */
+	0x01, /* 7 Write to RAM */
+	0x00, 0x00, /* 8-9 Reserved */
+	0x00, 0x00, 0x00, 0x00, /* 10-13 Placeholder for configuration register */
+	0x00, 0x00, 0x00, 0x00, /* 14-17 Placeholder for baud value */
+	0x00, 0x00 /* 18-19 Placeholder for checksum */
+};
+
+const speed_t ZED_F9P_MIN_BAUD = 9600;
+const speed_t ZED_F9P_DEFAULT_BAUD = 38400;
+const speed_t ZED_F9P_MAX_BAUD = 921600;
+const uint32_t ZED_F9P_BAUD_CONFIG_REGISTER = 0x40520001;
+
 struct ubx_data {
 	struct regulator *v_bckp;
 	struct regulator *vcc;
+	unsigned long is_configured;
+};
+
+union message_length {
+	uint16_t ml;
+	uint8_t bytes[2];
+};
+
+union int_to_bytes {
+	uint32_t int_val;
+	uint8_t bytes[4];
 };
 
+/* Payload  length is contained in bytes 0-2 after message class and ID.
+ *  While the checksum includes the Message class and ID plus message length, the
+ *  payload does not.
+ */
+static uint16_t get_payload_length(const uint8_t msg[])
+{
+	union message_length hs_msg_len;
+
+	hs_msg_len.bytes[0] = msg[PREAMBLE_LEN + MESSAGE_CLASS_LEN];
+	hs_msg_len.bytes[1] = msg[PREAMBLE_LEN + MESSAGE_CLASS_LEN + 1U];
+	return hs_msg_len.ml;
+}
+
+static int32_t get_msg_total_len(const uint8_t msg[])
+{
+	const size_t payload_len = get_payload_length(msg);
+
+	return PREAMBLE_LEN + MESSAGE_CLASS_LEN + MESSAGE_LENGTH_LEN + payload_len
+		+ CHECKSUM_LEN;
+}
+
+/* The checksum is calculated on message class, message ID, message length and
+ * payload.
+ */
+static void calc_ubx_checksum(const uint8_t msg[], uint8_t checksum[],
+			   const uint16_t total_len)
+{
+	uint8_t CK_A = 0;
+	uint8_t CK_B = 0;
+	int i;
+
+	for (i = PREAMBLE_LEN; i < (total_len - CHECKSUM_LEN); i++) {
+		CK_A += msg[i];
+		CK_B += CK_A;
+	}
+	checksum[0] = CK_A;
+	checksum[1] = CK_B;
+}
+
+static uint32_t  check_baud(speed_t speed, const struct device *dev)
+{
+	if ((speed < ZED_F9P_MIN_BAUD) || (speed > ZED_F9P_MAX_BAUD)) {
+		dev_warn(dev, "Baud rate specification %d out of range\n", speed);
+		speed = ZED_F9P_DEFAULT_BAUD;
+	}
+	return speed;
+}
+
+static int prepare_zedf9p_config_msg(const speed_t speed,
+					const struct device *dev, const size_t msg_register)
+{
+	union int_to_bytes cfg_val, cfg_register;
+	int i = 0;
+	uint8_t checksum[2];
+	const size_t total_len = get_msg_total_len(ZED_F9P_CFG_VALSET_MSG);
+
+	if (total_len != CFG_MSG_TOTAL_LEN)
+		goto bad_msg;
+
+	cfg_val.int_val = check_baud(speed, dev);
+	cfg_register.int_val = msg_register;
+	for (i = 0; i < 4; i++) {
+		ZED_F9P_CFG_VALSET_MSG[FIRST_VALUE_BYTE + i] = cfg_val.bytes[i];
+		ZED_F9P_CFG_VALSET_MSG[FIRST_CONFIG_REGISTER_BYTE + i] = cfg_register.bytes[i];
+	}
+	calc_ubx_checksum(ZED_F9P_CFG_VALSET_MSG, checksum, total_len);
+	ZED_F9P_CFG_VALSET_MSG[FIRST_CHECKSUM_BYTE] = checksum[0];
+	ZED_F9P_CFG_VALSET_MSG[FIRST_CHECKSUM_BYTE + 1U] = checksum[1];
+	return 0;
+
+ bad_msg:
+	dev_err(dev, "Malformed UBX-CFG-VALSET message\n");
+	return -EINVAL;
+}
+
+/* Configure the Zed F9P baud rate via the UBX-CFG-VALSET message. */
+static int set_zedf9p_baud(struct gnss_device *gdev,
+					struct serdev_device *serdev, const speed_t speed)
+{
+	size_t count = 0U;
+	int ret;
+
+	if (speed == ZED_F9P_DEFAULT_BAUD)
+		return 0;
+
+	ret = prepare_zedf9p_config_msg(speed, &gdev->dev, ZED_F9P_BAUD_CONFIG_REGISTER);
+	if (ret)
+		return ret;
+	/* Initially set the UART to the default speed to match the GNSS' power-on value. */
+	serdev_device_set_baudrate(serdev, ZED_F9P_DEFAULT_BAUD);
+	/* Now set the new baud rate. */
+	count = gdev->ops->write_raw(gdev, ZED_F9P_CFG_VALSET_MSG, CFG_MSG_TOTAL_LEN);
+	if (count != CFG_MSG_TOTAL_LEN)
+		return count;
+
+	pr_info("Setting Zed F9P GNSS speed to %u\n", speed);
+	return 0;
+}
+
+static int ubx_serial_open(struct gnss_device *gdev)
+{
+	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = gserial->serdev;
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	struct device_node *np;
+	int ret;
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_flow_control(serdev, false);
+
+	np = serdev->dev.of_node;
+	if ((of_device_is_compatible(np, "u-blox,zed-f9p")) && (!data->is_configured)) {
+		/* 4800 is the default value set by gnss_serial_parse_dt() */
+		if (gserial->speed == 4800) {
+			/* Fall back instead to Zed F9P default */
+			gserial->speed = ZED_F9P_DEFAULT_BAUD;
+		} else {
+			ret = set_zedf9p_baud(gdev, serdev, gserial->speed);
+			if (ret)
+				return ret;
+		}
+		data->is_configured = 1;
+	}
+	serdev_device_set_baudrate(serdev, gserial->speed);
+
+	ret = pm_runtime_get_sync(&serdev->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&serdev->dev);
+		goto err_close;
+	}
+	return 0;
+
+err_close:
+	serdev_device_close(serdev);
+
+	return ret;
+}
+
 static int ubx_set_active(struct gnss_serial *gserial)
 {
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
@@ -67,6 +251,7 @@ static int ubx_probe(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
+	struct gnss_operations *ubx_gnss_ops;
 	int ret;
 
 	gserial = gnss_serial_allocate(serdev, sizeof(*data));
@@ -74,12 +259,20 @@ static int ubx_probe(struct serdev_device *serdev)
 		ret = PTR_ERR(gserial);
 		return ret;
 	}
-
-	gserial->ops = &ubx_gserial_ops;
+	ubx_gnss_ops = kzalloc(sizeof(struct gnss_operations), GFP_KERNEL);
+	if (IS_ERR(ubx_gnss_ops)) {
+		ret = PTR_ERR(ubx_gnss_ops);
+		return ret;
+	}
 
 	gserial->gdev->type = GNSS_TYPE_UBX;
+	ubx_gnss_ops->open  = &ubx_serial_open;
+	ubx_gnss_ops->close = gserial->gdev->ops->close;
+	ubx_gnss_ops->write_raw = gserial->gdev->ops->write_raw;
+	gserial->gdev->ops = ubx_gnss_ops;
 
 	data = gnss_serial_get_drvdata(gserial);
+	data->is_configured = 0;
 
 	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
 	if (IS_ERR(data->vcc)) {
@@ -133,6 +326,7 @@ static const struct of_device_id ubx_of_match[] = {
 	{ .compatible = "u-blox,neo-6m" },
 	{ .compatible = "u-blox,neo-8" },
 	{ .compatible = "u-blox,neo-m8" },
+	{ .compatible = "u-blox,zed-f9p" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ubx_of_match);
-- 
2.39.2

