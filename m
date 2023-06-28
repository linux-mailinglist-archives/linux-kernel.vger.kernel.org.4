Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC02B741499
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjF1PKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:10:22 -0400
Received: from mx.kolabnow.com ([212.103.80.154]:62642 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbjF1PKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:10:16 -0400
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id DDFCFE9A;
        Wed, 28 Jun 2023 17:10:14 +0200 (CEST)
Authentication-Results: ext-mx-out002.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1687965012; x=1689779413;
         bh=QTYcZzZCgIf54YlqveiOoF7bNvPwDnkSf8s/GiQa96M=; b=Yd5KIjUsH5uF
        uzmoZAsQu/JhukSt2jiic5cdeLuhjR16b0b4HSrFxC2lc/F4xbu8PdgywiOelUyb
        ob5Qk5AsVfogcdRlxu4chG+laQc9ctp9Hm+6kg0VD5PzZFHHzAOSC28/gsu+hng/
        B6JtpWBdgbEkG1S6/qaunSzSv6H4za+q3W0dl4/pmtgPCwyPMn8s7yQsp5l+WU6f
        iNbf8ot/Yoj+/fWFshNVRR3ALIlY8/tzhncyC75nyIMAhX9itFlBmlpvA9fbGKQn
        O2QRO3zqlYWQbwmBcBka2q170jrLrbHRtZPmmxcxj8OztL5oD251nUuS6M9Orwyc
        05EDzllm5ygUUSgaxGNaiVZ9+H5oLBpqBSr6EwWTCf6K2+7Qabkfwgz8qjQl6Q0S
        VV8GIuIrzsylc30yVCxMcrPWh+kWizPKDoT/2RdYhC0WKtfD7/VaU2WfWh+aL9pe
        J9G8qTx/DGNyXHOwELNoRgfWqupjMJ0NYO9I3bKY/0Zv3EwmHhD6lctgn+mMbdaD
        XVw8v2KffqoU6GtTV1oB/5BiwywoNpaOe7nKX15mmDasDPmJxGPFnKIcvIjPkDMA
        d8MsA5hWO0W/zBhr5b3Ek06r/9HKsjbEd/wm4s7HSl50tob6jybBe5Z/sAKKZlua
        9lpjU4plGawNoWmiQ3drAKSlz2ruzOg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9] autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7__b5i1An047; Wed, 28 Jun 2023 17:10:12 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id BE9748B8;
        Wed, 28 Jun 2023 17:10:11 +0200 (CEST)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 29006CBB;
        Wed, 28 Jun 2023 17:10:11 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH v8 1/2] gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
Date:   Wed, 28 Jun 2023 08:09:47 -0700
Message-Id: <20230628150948.908273-2-alison@she-devel.com>
In-Reply-To: <20230628150948.908273-1-alison@she-devel.com>
References: <20230628150948.908273-1-alison@she-devel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
V7 -> V8 Rebased on v6.4.
V7 -> V6 Fixed version.
V6 -> V5 Change #ifdef to _maybe_unused and fix warnings.
V5 -> V4 Wrap all new code in a CONFIG_OF=y check
V4 -> V3 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:

 drivers/gnss/ubx.c | 243 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 232 insertions(+), 11 deletions(-)

diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index c951be202ca2..e857733aabe9 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -9,18 +9,212 @@
 #include <linux/gnss.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
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
+struct ubx_features {
+	u32 min_baud;
+	u32 default_baud;
+	u32 max_baud;
+	size_t baud_config_reg;
+	int (*open)(struct gnss_device *gdev);
+};
+
 struct ubx_data {
 	struct regulator *v_bckp;
 	struct regulator *vcc;
+	const struct ubx_features *features;
+	unsigned long is_configured;
 };
 
+union message_length {
+	uint16_t ml;
+	uint8_t bytes[2];
+};
+
+union int_to_bytes {
+	uint32_t int_val;
+	uint8_t bytes[4];
+};
+
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
+static uint32_t  check_baud(speed_t speed, const struct device *dev,
+					const struct ubx_features *features)
+{
+	if ((speed < features->min_baud) || (speed > features->max_baud)) {
+		dev_warn(dev, "Baud rate specification %d out of range\n", speed);
+		speed = features->default_baud;
+	}
+	return speed;
+}
+
+static int prepare_zedf9p_config_msg(const speed_t speed,
+					const struct device *dev,
+					    const struct ubx_features *features)
+{
+	union int_to_bytes cfg_val, cfg_register;
+	int i = 0;
+	uint8_t checksum[2];
+	const size_t total_len = get_msg_total_len(ZED_F9P_CFG_VALSET_MSG);
+
+	if (total_len != CFG_MSG_TOTAL_LEN)
+		goto bad_msg;
+
+	cfg_val.int_val = check_baud(speed, dev, features);
+	cfg_register.int_val = features->baud_config_reg;
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
+					struct serdev_device *serdev, struct gnss_serial *gserial)
+{
+	const struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	const struct ubx_features *features = data->features;
+	size_t count = 0U;
+	int ret;
+
+	if (!data->features)
+		return -EINVAL;
+	if (gserial->speed == features->default_baud)
+		return 0;
+
+	ret = prepare_zedf9p_config_msg(gserial->speed, &gdev->dev, features);
+	if (ret)
+		return ret;
+	/* Initially set the UART to the default speed to match the GNSS' power-on value. */
+	serdev_device_set_baudrate(serdev, features->default_baud);
+	/* Now set the new baud rate. */
+	count = gdev->ops->write_raw(gdev, ZED_F9P_CFG_VALSET_MSG, CFG_MSG_TOTAL_LEN);
+	if (count != CFG_MSG_TOTAL_LEN)
+		return count;
+
+	return 0;
+}
+
+static int zed_f9p_serial_open(struct gnss_device *gdev)
+{
+	struct gnss_serial *gserial = gnss_get_drvdata(gdev);
+	struct serdev_device *serdev = gserial->serdev;
+	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
+	int ret;
+
+	ret = serdev_device_open(serdev);
+	if (ret)
+		return ret;
+	if (!data->features)
+		return -EINVAL;
+
+	serdev_device_set_flow_control(serdev, false);
+
+	if (!data->is_configured) {
+		/* 4800 is the default value set by gnss_serial_parse_dt() */
+		if (gserial->speed == 4800) {
+			/* Fall back instead to Zed F9P default */
+			gserial->speed = data->features->default_baud;
+		} else {
+			ret = set_zedf9p_baud(gdev, serdev, gserial);
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
@@ -63,10 +257,31 @@ static const struct gnss_serial_ops ubx_gserial_ops = {
 	.set_power = ubx_set_power,
 };
 
+
+static const struct ubx_features __maybe_unused zedf9p_feats = {
+	.min_baud		=	9600,
+	.default_baud		=	38400,
+	.max_baud		=	921600,
+	.baud_config_reg	=	0x40520001,
+	.open			=	zed_f9p_serial_open,
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id ubx_of_match[] = {
+	{ .compatible = "u-blox,neo-6m" },
+	{ .compatible = "u-blox,neo-8" },
+	{ .compatible = "u-blox,neo-m8" },
+	{ .compatible = "u-blox,zed-f9p", .data = &zedf9p_feats },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ubx_of_match);
+#endif
+
 static int ubx_probe(struct serdev_device *serdev)
 {
 	struct gnss_serial *gserial;
 	struct ubx_data *data;
+	struct gnss_operations *ubx_gnss_ops;
 	int ret;
 
 	gserial = gnss_serial_allocate(serdev, sizeof(*data));
@@ -74,13 +289,29 @@ static int ubx_probe(struct serdev_device *serdev)
 		ret = PTR_ERR(gserial);
 		return ret;
 	}
+	ubx_gnss_ops = kzalloc(sizeof(struct gnss_operations), GFP_KERNEL);
+	if (IS_ERR(ubx_gnss_ops)) {
+		ret = PTR_ERR(ubx_gnss_ops);
+		return ret;
+	}
 
 	gserial->ops = &ubx_gserial_ops;
 
 	gserial->gdev->type = GNSS_TYPE_UBX;
 
 	data = gnss_serial_get_drvdata(gserial);
-
+#if IS_ENABLED(CONFIG_OF)
+	{
+		data->is_configured = 0;
+		data->features = of_match_device(ubx_of_match, &serdev->dev)->data;
+		if (data->features && data->features->open) {
+			ubx_gnss_ops->open  = data->features->open;
+			ubx_gnss_ops->close = gserial->gdev->ops->close;
+			ubx_gnss_ops->write_raw = gserial->gdev->ops->write_raw;
+			gserial->gdev->ops = ubx_gnss_ops;
+		}
+	}
+#endif
 	data->vcc = devm_regulator_get(&serdev->dev, "vcc");
 	if (IS_ERR(data->vcc)) {
 		ret = PTR_ERR(data->vcc);
@@ -128,16 +359,6 @@ static void ubx_remove(struct serdev_device *serdev)
 	gnss_serial_free(gserial);
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id ubx_of_match[] = {
-	{ .compatible = "u-blox,neo-6m" },
-	{ .compatible = "u-blox,neo-8" },
-	{ .compatible = "u-blox,neo-m8" },
-	{},
-};
-MODULE_DEVICE_TABLE(of, ubx_of_match);
-#endif
-
 static struct serdev_device_driver ubx_driver = {
 	.driver	= {
 		.name		= "gnss-ubx",
-- 
2.40.1

