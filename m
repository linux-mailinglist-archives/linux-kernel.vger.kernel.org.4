Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5926A713177
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjE0BYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjE0BYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:24:30 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57893A7;
        Fri, 26 May 2023 18:24:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af7a84b2bdso1136544a34.2;
        Fri, 26 May 2023 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685150668; x=1687742668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tKKQUdhvmst45itFXxTG/3YLpUX8lObiN8yQaG6Ix/k=;
        b=kZ75hBo+9r3Zj16dkx2//i5QIFfHyKciEjn50EnOVARf0uuFGxnxI8shFC2FFQQRJQ
         x4SBHOPJKl34aJHlYXX5AS4BOZrQK6s9T2AVCuOWy6PsGNYjGW4FcfSOnkS6Vk10/thd
         KwevDKlQcuAay+IFk6UC7K/AXb2Lg6Wj1D4dvdOj8Xbecac2XUzY3WDK00h3+MNJzycU
         3se8SDciUz8/SgP1YSg4qhEJKBQ48jkkq//wLugqlRh8s5ajaLhc1UNWaLwwz2z3gKOn
         Dl75+gCQv+nwRFVbyxA4k35u10EhqCR2YP7IiNnFiWo/AEezuQ+fIcEXGQDiK0T4UBMb
         vuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685150668; x=1687742668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tKKQUdhvmst45itFXxTG/3YLpUX8lObiN8yQaG6Ix/k=;
        b=VI/1EdjKhYf4eR87mTK8Wa6VqWuEKHyoCEJHKEtOZx+D8liC2UKvYbAmPewjgnxrbZ
         MqUHeiMSdGm7qAPoN31awHrosxSONbdneqar54l9L0WQio6DfvgiVEvRUOLGiMRF6LlJ
         hPGG79A6kw0+Yd/taRx06etpvk58IrMUoq/wODtTyDbmLQJhd+8XdfjYSArWjQubbu+h
         oSQafIKhOcUWRQH3C+wgjB5M0QXc8R8n5N23DbQZSxevvuhd48PpB+Oc50Oi80dTCAYj
         GNvOP73MQVxSVd5iQ3/Rq0iblX3vS4ztFJUMI2LqzNC/QICusVqVdjeM9YkoZwM85u3U
         zT4Q==
X-Gm-Message-State: AC+VfDzh26LT5aP9/4CUmhA4071K27iuM4itxVqpDv0dm6nJK/1x7P5P
        pURkRyHBunXjXH4PVQq/W7CWeaANCQU=
X-Google-Smtp-Source: ACHHUZ6kS//nLc2/9XTcy6It+EacIZsdCc8dkZewyHI7hi7bXtfFqTS2RzJBwraX2YK2kgVs4vHSCg==
X-Received: by 2002:a9d:7d18:0:b0:6a4:4252:47aa with SMTP id v24-20020a9d7d18000000b006a4425247aamr1829222otn.21.1685150668442;
        Fri, 26 May 2023 18:24:28 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id d3-20020a0568301b6300b006af99ac5832sm2345700ote.47.2023.05.26.18.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 18:24:27 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
Date:   Fri, 26 May 2023 22:22:06 -0300
Message-Id: <20230527012206.133464-1-samsagax@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

OneXPlayer boards from the last generation (both for OneXPlayer and AOK
ZOE brands) have a toggle in the EC to switch the "Turbo/Silent" button
into a different keyboard event.

Add a means to use that "Turbo button takeover" function and expose it
to userspace in a custom sysfs `tt_toggle` attribute. It can be read to
take the current state. Write 1|0 to activate the function. The specific
keycode is dependent on the board but can be checked by running
`evtest` utility.

Newer BIOS on the OneXPlayer added this function aside from string changes.
Add a board enum to differentiate it from the old OneXplayer Mini AMD BIOS.

Currently known supported boards:
- AOK ZOE A1
- OneXPlayer Mini AMD (only newer BIOS version supported)
- OneXPlayer Mini Pro

Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
---
This patch includes the one in https://lore.kernel.org/linux-hwmon/20230526215621.16075-1-samsagax@gmail.com/
so it should be discarded.
---
 Documentation/hwmon/oxp-sensors.rst |  16 ++++
 drivers/hwmon/oxp-sensors.c         | 140 +++++++++++++++++++++++++++-
 2 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 4ab442301415..131c89fad03a 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -19,6 +19,11 @@ out the EC registers and values to write to since the EC layout and model is
 different. Aya Neo devices preceding the AIR may not be supportable as the EC
 model is different and do not appear to have manual control capabilities.
 
+Some models have a toggle for changing the behaviour of the "Turbo/Silent"
+button of the device. It will change the key event that it triggers with
+a flip of the `tt_toggle` attribute. See below for boards that support this
+function.
+
 Supported devices
 -----------------
 
@@ -33,6 +38,11 @@ Currently the driver supports the following handhelds:
  - OneXPlayer mini AMD
  - OneXPlayer mini AMD PRO
 
+"Turbo/Silent" button behaviour toggle is only supported on:
+ - AOK ZOE A1
+ - OneXPlayer mini AMD (only with updated alpha BIOS)
+ - OneXPlayer mini AMD PRO
+
 Sysfs entries
 -------------
 
@@ -49,3 +59,9 @@ pwm1
   Read Write. Read this attribute to see current duty cycle in the range [0-255].
   When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
   to set fan speed.
+
+tt_toggle
+  Read Write. Read this attribute to check the status of the turbo/silent
+  button behaviour function. Write "1" to activate the switch and "0" to
+  deactivate it. The specific keycodes and behaviour is specific to the device
+  both with this function on and off.
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 0ec7588610ad..80fd153253fc 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -47,15 +47,29 @@ enum oxp_board {
 	aya_neo_air_pro,
 	aya_neo_geek,
 	oxp_mini_amd,
+	oxp_mini_amd_a07,
 	oxp_mini_amd_pro,
 };
 
 static enum oxp_board board;
 
+/* Fan reading and PWM */
 #define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
 #define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
 #define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
 
+/* Turbo button takeover function
+ * Older boards have different values and EC registers
+ * for the same function
+ */
+#define OXP_OLD_TURBO_SWITCH_REG	0x1E
+#define OXP_OLD_TURBO_TAKE_VAL		0x01
+#define OXP_OLD_TURBO_RETURN_VAL	0x00
+
+#define OXP_TURBO_SWITCH_REG		0xF1
+#define OXP_TURBO_TAKE_VAL		0x40
+#define OXP_TURBO_RETURN_VAL		0x00
+
 static const struct dmi_system_id dmi_table[] = {
 	{
 		.matches = {
@@ -104,7 +118,7 @@ static const struct dmi_system_id dmi_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
 		},
-		.driver_data = (void *)oxp_mini_amd,
+		.driver_data = (void *)oxp_mini_amd_a07,
 	},
 	{
 		.matches = {
@@ -156,6 +170,108 @@ static int write_to_ec(u8 reg, u8 value)
 	return ret;
 }
 
+/* Turbo button toggle functions */
+static int tt_toggle_enable(void)
+{
+	u8 reg;
+	u8 val;
+
+	switch (board) {
+	case oxp_mini_amd_a07:
+		reg = OXP_OLD_TURBO_SWITCH_REG;
+		val = OXP_OLD_TURBO_TAKE_VAL;
+		break;
+	case oxp_mini_amd_pro:
+	case aok_zoe_a1:
+		reg = OXP_TURBO_SWITCH_REG;
+		val = OXP_TURBO_TAKE_VAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return write_to_ec(reg, val);
+}
+
+static int tt_toggle_disable(void)
+{
+	u8 reg;
+	u8 val;
+
+	switch (board) {
+	case oxp_mini_amd_a07:
+		reg = OXP_OLD_TURBO_SWITCH_REG;
+		val = OXP_OLD_TURBO_RETURN_VAL;
+		break;
+	case oxp_mini_amd_pro:
+	case aok_zoe_a1:
+		reg = OXP_TURBO_SWITCH_REG;
+		val = OXP_TURBO_RETURN_VAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return write_to_ec(reg, val);
+}
+
+/* Callbacks for turbo toggle attribute */
+static ssize_t tt_toggle_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t count)
+{
+	int rval;
+	unsigned int value;
+
+	rval = kstrtouint(buf, 10, &value);
+	if (rval)
+		return rval;
+
+	switch (value) {
+	case 0:
+		rval = tt_toggle_disable();
+		if (rval)
+			return rval;
+		return count;
+	case 1:
+		rval = tt_toggle_enable();
+		if (rval)
+			return rval;
+		return count;
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t tt_toggle_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int retval;
+	u8 reg;
+	long val;
+
+	switch (board) {
+	case oxp_mini_amd_a07:
+		reg = OXP_OLD_TURBO_SWITCH_REG;
+		val = OXP_OLD_TURBO_RETURN_VAL;
+		break;
+	case oxp_mini_amd_pro:
+	case aok_zoe_a1:
+		reg = OXP_TURBO_SWITCH_REG;
+		val = OXP_TURBO_RETURN_VAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	retval = read_from_ec(reg, 1, &val);
+	if (retval)
+		return retval;
+
+	return sysfs_emit(buf, "%ld\n", val);
+}
+
+static DEVICE_ATTR_RW(tt_toggle);
+
+/* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
 	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
@@ -206,6 +322,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				*val = (*val * 255) / 100;
 				break;
 			case oxp_mini_amd_pro:
@@ -247,6 +364,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				val = (val * 100) / 255;
 				break;
 			case aok_zoe_a1:
@@ -274,6 +392,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
 	NULL,
 };
 
+static struct attribute *oxp_ec_attrs[] = {
+	&dev_attr_tt_toggle.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(oxp_ec);
+
 static const struct hwmon_ops oxp_ec_hwmon_ops = {
 	.is_visible = oxp_ec_hwmon_is_visible,
 	.read = oxp_platform_read,
@@ -305,8 +430,17 @@ static int oxp_platform_probe(struct platform_device *pdev)
 
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
-	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
-						     &oxp_ec_chip_info, NULL);
+	switch (board) {
+	case aok_zoe_a1:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+		hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
+							     &oxp_ec_chip_info, oxp_ec_groups);
+		break;
+	default:
+		hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
+							     &oxp_ec_chip_info, NULL);
+	}
 
 	return PTR_ERR_OR_ZERO(hwdev);
 }
-- 
2.40.1

