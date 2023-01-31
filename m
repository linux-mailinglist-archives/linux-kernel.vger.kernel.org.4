Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40246682A0F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjAaKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:13:18 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A714E13D55;
        Tue, 31 Jan 2023 02:13:14 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qw12so24180653ejc.2;
        Tue, 31 Jan 2023 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc9Z5j9MkGMkB7mJzT9wGvl3LY8/Qix/mZ9EpxY13UU=;
        b=pTV4aNcJs3yHVeIu0uZ+oEGW0BTDG33Bh8K+yllcVBsxr+7IYKQrsWGxtsCXdmRRGE
         108S2mvuyKLZAnF5zT0u1IY+Nfri3aGDYwgr87VWrT5aGv7c8lizJgEjO0G8nt1DDgPG
         WcwiGtJnWKW7dLrPon82l0yZP67BmT46ZiHhzIETbNCFs4bauU1IgHnIeIPQEbbyOyB3
         N/X6TctSnf4ci/DSQtgFpMBZUBjtbXZPAFVuPADht0+gCYr/BuWjvRjYSNzZSALXhqPv
         w+KRY6lm85x+oZb7TmeX9rcj1RrQe3fnH6zTStMdqyGoRmRjWdcAc6+ie1leztVAqj1/
         kFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc9Z5j9MkGMkB7mJzT9wGvl3LY8/Qix/mZ9EpxY13UU=;
        b=hW2qAr2LcOgGfD3CI7iBJzKAXT7tb3W2rceKzuQ4Y+VM3LKhgHmFQejF0eCxRruEmJ
         wEq9SZf4E7fUAih8g0mdf10aOQgFxlhepssNNU2LBWeSvclLZiQ0O/Xj290eonQsoCzJ
         tzM+LoKu/DMRRkc1tNIF6F+i7cyUd+Uvd+uXIKzJm5f5R5SsrfXYJC7oTssif7ug7nEY
         y7mVseCGL8GnBdovB+fS3Jpsxa9i4nfWGShVF+iS6YkHgr2eYmOEOKg1l57h8O5L0hDE
         LduLPiCDghoMmO2t4DT6KoxEziAZaOsYSq3ek4li1k+ZPM+1vmlgMNgBfYfQSH2MEqgo
         7wow==
X-Gm-Message-State: AO0yUKWTtU0tFogZRt1q5levk2CDA/8+dmra8/viEv6AOVBXXbNnP8xa
        aa1hSwMFV9Gxpk093nbMHiZuFJnI5BFLIg==
X-Google-Smtp-Source: AK7set9l9y2O0Zw2wmoy1z1pL6IehAj88HMjNCapftlhZTtdc5HqDCHJ7LYSUarXyNkXqmvl5CxjCg==
X-Received: by 2002:a17:906:cf89:b0:878:790b:b7db with SMTP id um9-20020a170906cf8900b00878790bb7dbmr17879915ejb.70.1675159992813;
        Tue, 31 Jan 2023 02:13:12 -0800 (PST)
Received: from fedora.. ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id c12-20020a170906340c00b0088aadc18b69sm1844695ejb.101.2023.01.31.02.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 02:13:10 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Poweradjust 3
Date:   Tue, 31 Jan 2023 11:12:09 +0100
Message-Id: <20230131101210.8095-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose the temp sensor of the
Aquacomputer Poweradjust 3 fan controller, which communicates
through a proprietary USB HID protocol.

The Poweradjust 3 is not currently known to expose firmware version
and serial number, so don't create debugfs entries if their values
can't be retrieved.

Tested by a user on Github [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/57

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +
 drivers/hwmon/aquacomputer_d5next.c         | 88 +++++++++++++++++++--
 2 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 3f7880fb8116..527bcd3edda9 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -12,6 +12,7 @@ Supported devices:
 * Aquacomputer Octo fan controller
 * Aquacomputer Quadro fan controller
 * Aquacomputer High Flow Next sensor
+* Aquacomputer Poweradjust 3 fan controller
 
 Author: Aleksa Savic
 
@@ -53,6 +54,8 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
 A temperature sensor can be connected to it, in which case it provides its reading
 and an estimation of the dissipated/absorbed power in the liquid cooling loop.
 
+The Poweradjust 3 controller exposes a single external temperature sensor.
+
 Depending on the device, not all sysfs and debugfs entries will be available.
 Writing to virtual temperature sensors is not currently supported.
 
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index c1b885240ddf..2945b630b4a0 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -4,7 +4,8 @@
  * Quadro, High Flow Next, Aquaero)
  *
  * Aquacomputer devices send HID reports (with ID 0x01) every second to report
- * sensor values.
+ * sensor values, except for devices that communicate through the
+ * legacy way (currently, Poweradjust 3).
  *
  * Copyright 2021 Aleksa Savic <savicaleksa83@gmail.com>
  * Copyright 2022 Jack Doan <me@jackdoan.com>
@@ -28,8 +29,9 @@
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
+#define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
 
-enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext, aquaero };
+enum kinds { d5next, farbwerk, farbwerk360, octo, quadro, highflownext, aquaero, poweradjust3 };
 
 static const char *const aqc_device_names[] = {
 	[d5next] = "d5next",
@@ -38,7 +40,8 @@ static const char *const aqc_device_names[] = {
 	[octo] = "octo",
 	[quadro] = "quadro",
 	[highflownext] = "highflownext",
-	[aquaero] = "aquaero"
+	[aquaero] = "aquaero",
+	[poweradjust3] = "poweradjust3"
 };
 
 #define DRIVER_NAME			"aquacomputer_d5next"
@@ -59,6 +62,9 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
+/* Report IDs for legacy devices */
+#define POWERADJUST3_STATUS_REPORT_ID	0x03
+
 /* Info, sensor sizes and offsets for most Aquacomputer devices */
 #define AQC_SERIAL_START		0x3
 #define AQC_FIRMWARE_VERSION		0xD
@@ -176,6 +182,13 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
 
+/* Specs of the Poweradjust 3 */
+#define POWERADJUST3_NUM_SENSORS	1
+#define POWERADJUST3_SENSOR_REPORT_SIZE	0x32
+
+/* Sensor report offsets for the Poweradjust 3 */
+#define POWERADJUST3_SENSOR_START	0x03
+
 /* Labels for D5 Next */
 static const char *const label_d5next_temp[] = {
 	"Coolant temp"
@@ -326,6 +339,11 @@ static const char *const label_highflownext_voltage[] = {
 	"+5V USB voltage"
 };
 
+/* Labels for Poweradjust 3 */
+static const char *const label_poweradjust3_temp_sensors[] = {
+	"External sensor"
+};
+
 struct aqc_fan_structure_offsets {
 	u8 voltage;
 	u8 curr;
@@ -357,6 +375,8 @@ struct aqc_data {
 	enum kinds kind;
 	const char *name;
 
+	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
+
 	int buffer_size;
 	u8 *buffer;
 	int checksum_start;
@@ -615,14 +635,49 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 	return 0;
 }
 
+/* Read device sensors by manually requesting the sensor report (legacy way) */
+static int aqc_legacy_read(struct aqc_data *priv)
+{
+	int ret, i, sensor_value;
+
+	mutex_lock(&priv->mutex);
+
+	memset(priv->buffer, 0x00, priv->buffer_size);
+	ret = hid_hw_raw_request(priv->hdev, priv->status_report_id, priv->buffer,
+				 priv->buffer_size, HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret < 0)
+		goto unlock_and_return;
+
+	/* Temperature sensor readings */
+	for (i = 0; i < priv->num_temp_sensors; i++) {
+		sensor_value = get_unaligned_le16(priv->buffer + priv->temp_sensor_start_offset +
+						  i * AQC_SENSOR_SIZE);
+		priv->temp_input[i] = sensor_value * 10;
+	}
+
+	priv->updated = jiffies;
+
+unlock_and_return:
+	mutex_unlock(&priv->mutex);
+	return ret;
+}
+
 static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
 	int ret;
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
-	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL))
-		return -ENODATA;
+	if (time_after(jiffies, priv->updated + STATUS_UPDATE_INTERVAL)) {
+		if (priv->status_report_id != 0) {
+			/* Legacy devices require manual reads */
+			ret = aqc_legacy_read(priv);
+			if (ret < 0)
+				return -ENODATA;
+		} else {
+			return -ENODATA;
+		}
+	}
 
 	switch (type) {
 	case hwmon_temp:
@@ -1014,9 +1069,13 @@ static void aqc_debugfs_init(struct aqc_data *priv)
 		  dev_name(&priv->hdev->dev));
 
 	priv->debugfs = debugfs_create_dir(name, NULL);
-	debugfs_create_file("serial_number", 0444, priv->debugfs, priv, &serial_number_fops);
-	debugfs_create_file("firmware_version", 0444, priv->debugfs, priv, &firmware_version_fops);
 
+	if (priv->serial_number_start_offset != 0)
+		debugfs_create_file("serial_number", 0444, priv->debugfs, priv,
+				    &serial_number_fops);
+	if (priv->firmware_version_offset != 0)
+		debugfs_create_file("firmware_version", 0444, priv->debugfs, priv,
+				    &firmware_version_fops);
 	if (priv->power_cycle_count_offset != 0)
 		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
 }
@@ -1214,6 +1273,17 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
 		break;
+	case USB_PRODUCT_ID_POWERADJUST3:
+		priv->kind = poweradjust3;
+
+		priv->num_fans = 0;
+
+		priv->num_temp_sensors = POWERADJUST3_NUM_SENSORS;
+		priv->temp_sensor_start_offset = POWERADJUST3_SENSOR_START;
+		priv->buffer_size = POWERADJUST3_SENSOR_REPORT_SIZE;
+
+		priv->temp_label = label_poweradjust3_temp_sensors;
+		break;
 	default:
 		break;
 	}
@@ -1225,6 +1295,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->fan_structure = &aqc_aquaero_fan_structure;
 		break;
+	case poweradjust3:
+		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
+		break;
 	default:
 		priv->serial_number_start_offset = AQC_SERIAL_START;
 		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
@@ -1287,6 +1360,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
 	{ }
 };
 
-- 
2.39.1

