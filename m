Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDCF72AE5A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbjFJTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFJTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 15:25:13 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBBA2712;
        Sat, 10 Jun 2023 12:25:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-39cc64e4a22so113885b6e.3;
        Sat, 10 Jun 2023 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686425110; x=1689017110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAHMT2j854kXCGo1A78pLYErqZjR1XtVMTE5AO+1mBY=;
        b=ieCtUlYKdVSjYBDTmrAYsQkMn+zF600Bsq8btpLBKk0Y5AbZaMKcGNPBBz9ds0efIk
         acp8hn3ctO/4Ye2L+XdBJZdR0RekGmf600ElMtR6am3/QDATkokxUjnRSTNdNX5XsH1e
         ywa3aSJvEakNdx9BPaefUdoi91Lbw9dEOIb2a8YSC2MKH6SABSVTG+DmGYCDXeaYqCpr
         Iyu0Oz0RyPQqHJ8P5zCVQ6ixeBXqFRXIly99+FetVtKjOu8hsMtsPHU94vWSXhx3Lo9C
         BnQ90Yj+g7RaRyA9GD8pveZC/79b/hE+VAq7CVQXCoI9J9wIm6c/NRi1ph3wGvsKI9mW
         1pjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686425110; x=1689017110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAHMT2j854kXCGo1A78pLYErqZjR1XtVMTE5AO+1mBY=;
        b=fdinBMYGPgVTzl8ByyIkbRR5lffWEBZ8HGWAyCyokuWXs8JdsWtmEwoGILMX6z20zo
         EXv5lYk7rdLGFJp2e4XMXGamTLCOAnM4KX4wrDNsamw9KmTFg9wHAqrElfoBDv6IG6jC
         yuhmgztnJRxmrMzRT10lqtaVR/dEKQmGGZlOz3Z42LZm6EBa7cKmB/xEc5/eudUWgZg/
         RwAM8SXDO95tOobnRLnb+m94pboox8fUZglQpDne1QJ/3scupx4c8FOyCCPAlZDkr9Qw
         scmShh7f7B+0OOyRL5QmwVoXjZ22iLLfudj/GMWE/h79KHY67dX1tyiM5Lvf06GdNivY
         a4og==
X-Gm-Message-State: AC+VfDyM5swsmOLzS7AErt4h6swuAWum6krZjMEf0hWlWeQEuJL8CJSL
        4pSrmqI62oLqkPp7kexPydg=
X-Google-Smtp-Source: ACHHUZ7C8AMxcqmF7iYIrDwXzObIbToMqYgQs9LoqW84ddsqOPMmqrwxqi3hE2njobvlRpruTBy2ng==
X-Received: by 2002:a05:6808:1308:b0:398:1807:84bc with SMTP id y8-20020a056808130800b00398180784bcmr1572225oiv.26.1686425110578;
        Sat, 10 Jun 2023 12:25:10 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id bu9-20020a0568201ac900b0054f6fb0ec57sm1895998oob.11.2023.06.10.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 12:25:10 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
Date:   Sat, 10 Jun 2023 16:23:49 -0300
Message-ID: <20230610192400.80611-2-samsagax@gmail.com>
X-Mailer: git-send-email 2.41.0
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
v2 changes:
- Attach the attribute to the platform device as per review
- Make the attribute return status 0|1 instead of read value
---
 Documentation/hwmon/oxp-sensors.rst |  16 ++++
 drivers/hwmon/oxp-sensors.c         | 142 +++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

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
index 0ec7588610ad..59e4e906ced5 100644
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
@@ -156,6 +170,112 @@ static int write_to_ec(u8 reg, u8 value)
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
+	int status;
+
+	switch (board) {
+	case oxp_mini_amd_a07:
+		reg = OXP_OLD_TURBO_SWITCH_REG;
+		break;
+	case oxp_mini_amd_pro:
+	case aok_zoe_a1:
+		reg = OXP_TURBO_SWITCH_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	retval = read_from_ec(reg, 1, &val);
+	if (retval)
+		return retval;
+
+	if (val)
+		status = 1;
+	else
+		status = 0;
+
+	return sysfs_emit(buf, "%d\n", status);
+}
+
+static DEVICE_ATTR_RW(tt_toggle);
+
+/* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
 	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
@@ -206,6 +326,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				*val = (*val * 255) / 100;
 				break;
 			case oxp_mini_amd_pro:
@@ -247,6 +368,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				val = (val * 100) / 255;
 				break;
 			case aok_zoe_a1:
@@ -274,6 +396,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
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
@@ -291,6 +420,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	const struct dmi_system_id *dmi_entry;
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
+	int ret;
 
 	/*
 	 * Have to check for AMD processor here because DMI strings are the
@@ -305,6 +435,16 @@ static int oxp_platform_probe(struct platform_device *pdev)
 
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
+	switch (board) {
+	case aok_zoe_a1:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+		ret = devm_device_add_groups(dev, oxp_ec_groups);
+		if (ret)
+			return ret;
+	default:
+	}
+
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
-- 
2.41.0

