Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68572B250
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjFKOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjFKOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:36:46 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9883;
        Sun, 11 Jun 2023 07:36:44 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-55b77d50465so573523eaf.0;
        Sun, 11 Jun 2023 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686494204; x=1689086204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvdshtR/+hGfnmqrqTGGF2xCkrUO24uwCSGtFWk45gM=;
        b=Wi5I+GzwbYrmHVOK+PXtdkU7H9V+d/Mm/xKC/UlFPCsn9MpT6YRy76DD546ZeC/HhT
         Ah1qm7p50zHtJ2unRHTAjR5TeXaOxqARNMfd/rNxa2xip0da1Fy8XbquhiLB/1zPyLBy
         Ixaj5TCJ+XcrIpumr93OseAzRyaDgVgwNxXSRbmW3mZdp88BrmRe7BtSyT0MSf4HowUn
         CbadhpDhnXP0gdjpSSCPhUASv6oxaKHlknTqFksDPd2wnCOj6xHAUKKEZUsI3pr/6geO
         WppeO0+1ekJVWncPQpRW4QiAaYWwP99+jrOQozjIpVO9RNEGi/hZhYQPQxfTrJF+5uZw
         1cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686494204; x=1689086204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvdshtR/+hGfnmqrqTGGF2xCkrUO24uwCSGtFWk45gM=;
        b=Nmw19vlBR2R2RMDL0LzENU3NB9isufOwemOz8Jf4SOqWX69w2K+ADNSfaCoWgvevfH
         xiEPrk3y8GmXMMrR1HpbjY4KVd63YK3FSIBft9/Lse2BnVLhJpAQLEgk+Aa42T9LdgWb
         RE3PNriKMhobeUSMGskxGJ3PpagSJ+MzY5XZLeUMkXGYdb2Y93+kW/TIwN7e5LrRGtIJ
         LwIWahPhxRYZ5eiTbjYzBfc84NRcmDtpYF9xEvKwSu6GqnLPkUK/E3GT/INQzwsF5d5J
         e2I5OFXFu3WrIqXHQBN66tQKg9DIsGU6YvoEZ9JZhbh6ZDOIiBeRy3StvkG/rQOQUJZg
         QWyw==
X-Gm-Message-State: AC+VfDyLPvyaQa7LBkKYfkgOXtzqj7/WDlsCOWMOEl5weYITQFx/xl41
        KCyf+fwR1n85q/Pep/06x9yWAioux9Y=
X-Google-Smtp-Source: ACHHUZ6qSR0ZGW4zVdMRzuqyVvMJhTE3KkApcvfoyshecHRXcLgVClwIdswINMfg3aC71zZCUWfE/w==
X-Received: by 2002:a05:6808:181f:b0:39a:acfd:e5a3 with SMTP id bh31-20020a056808181f00b0039aacfde5a3mr2156164oib.23.1686494203891;
        Sun, 11 Jun 2023 07:36:43 -0700 (PDT)
Received: from smeagol.fibertel.com.ar ([201.235.4.68])
        by smtp.gmail.com with ESMTPSA id j9-20020aca1709000000b00397bc1af159sm3092444oii.18.2023.06.11.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:36:43 -0700 (PDT)
From:   =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>
To:     linux@roeck-us.net
Cc:     =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
Date:   Sun, 11 Jun 2023 11:33:20 -0300
Message-ID: <20230611143332.40590-2-samsagax@gmail.com>
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

v3 changes:
- Mention the attribute attached to the platform device on Documentation
- Use boolean instead of base 10 int in tt_toggle_store()
- Remove unnecesary status logic in tt_toggle_show() (use !!val instead)
- Add missing breaks in probe()
---
 Documentation/hwmon/oxp-sensors.rst |  17 ++++
 drivers/hwmon/oxp-sensors.c         | 134 +++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 4ab442301415..0ca1f7728c34 100644
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
 
@@ -49,3 +59,10 @@ pwm1
   Read Write. Read this attribute to see current duty cycle in the range [0-255].
   When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
   to set fan speed.
+
+tt_toggle
+  Read Write. Read this attribute to check the status of the turbo/silent
+  button behaviour function. Write "1" to activate the switch and "0" to
+  deactivate it. The specific keycodes and behaviour is specific to the device
+  both with this function on and off. This attribute is attached to the platform
+  driver and not to the hwmon driver (/sys/devices/platform/oxp-platform/tt_toggle)
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index 0ec7588610ad..be36d38f13d9 100644
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
@@ -156,6 +170,102 @@ static int write_to_ec(u8 reg, u8 value)
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
+	bool value;
+
+	rval = kstrtobool(buf, &value);
+	if (rval)
+		return rval;
+
+	if (value) {
+		rval = tt_toggle_enable();
+		if (rval)
+			return rval;
+	} else {
+		rval = tt_toggle_disable();
+		if (rval)
+			return rval;
+	}
+	return count;
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
+	return sysfs_emit(buf, "%d\n", !!val);
+}
+
+static DEVICE_ATTR_RW(tt_toggle);
+
+/* PWM enable/disable functions */
 static int oxp_pwm_enable(void)
 {
 	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
@@ -206,6 +316,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				*val = (*val * 255) / 100;
 				break;
 			case oxp_mini_amd_pro:
@@ -247,6 +358,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 			case aya_neo_air_pro:
 			case aya_neo_geek:
 			case oxp_mini_amd:
+			case oxp_mini_amd_a07:
 				val = (val * 100) / 255;
 				break;
 			case aok_zoe_a1:
@@ -274,6 +386,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
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
@@ -291,6 +410,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 	const struct dmi_system_id *dmi_entry;
 	struct device *dev = &pdev->dev;
 	struct device *hwdev;
+	int ret;
 
 	/*
 	 * Have to check for AMD processor here because DMI strings are the
@@ -305,6 +425,18 @@ static int oxp_platform_probe(struct platform_device *pdev)
 
 	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
 
+	switch (board) {
+	case aok_zoe_a1:
+	case oxp_mini_amd_a07:
+	case oxp_mini_amd_pro:
+		ret = devm_device_add_groups(dev, oxp_ec_groups);
+		if (ret)
+			return ret;
+		break;
+	default:
+		break;
+	}
+
 	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
 						     &oxp_ec_chip_info, NULL);
 
-- 
2.41.0

