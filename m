Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13F66B4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 00:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjAOXBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 18:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjAOXBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 18:01:51 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E210428;
        Sun, 15 Jan 2023 15:01:50 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9so28564805pll.9;
        Sun, 15 Jan 2023 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWNlysJq0lnDtbSKvo7T7muCSIE9cK6qJbiITiHffwM=;
        b=ds0/Dsx056A9dQBoiIZArdP2boxGzDMZcKAYB5MQp1vG0Uc2I+YscriDmut/gQBUSM
         v6Kkvg9GmH/xejXlYOg7JCtKgq9J9Ay/C3MnHK7f06KjX4c5tntXfAwdv0KReDSdB8gc
         Sbt7k3TM5QH6BlSkQWkXiBFdp5gmzhPA2yEtWCRgQXNV56xYamfsjSSsAMfEnp8dyfxM
         IHemzc9BpULy8RAn3sgVePK+WBdLTmgsD7Zzbf52lS2fOSXdMO8tA6YCeY07z5Hdi/Oa
         crashmkPTsbwKLnFozkZUX6SZQkyb5lBGH8+zHZh1Xk8NdV9HLiBHFlEn1jhqE4oyucG
         tPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWNlysJq0lnDtbSKvo7T7muCSIE9cK6qJbiITiHffwM=;
        b=CGJw2GHiqRJAXVzmQXsgYZ67lO31O2tX8oxv4ZjwwsMmJnPSTVqluGYgEXzhu+teFS
         HP1ib44nsi064Wc91CaukxvW03nwuVudBNpTBKilr3yl135AqM3lOsYvGxT+vfR9xA8U
         lhNcq5VbfVwHPvN6iIkVlR00qWVopG/Te1GNk9WfBVQYQIuvbGH06e/7GfGiELJa3+K3
         Vjt/zqj+M4jmQwTGjN9/tDTDKPU1BSfxA5oprCZ+D1m/5YS63wszyhNQzQcFUEU4hSkT
         8fdC6n68TQCXNW4IA0n87+1RuU6n/UGKayN1zWrSnOR2qwGac24+ciSJYCnkQ3xO3idr
         VNHg==
X-Gm-Message-State: AFqh2kovoGYkhFKj0XF3z2IR+3foJa3Vd+duwJ8J6s/+gjeEN4F7U1cU
        Hr0uig1yk2WWduDquTh1aCGgqH2kzhP54B7P
X-Google-Smtp-Source: AMrXdXuO6o2CBDXDhZhy5lfSBGHQNlupsXAhE4S02tsSIHSZk/2mWziKsU8ST+nPZO1f7pPn0ACJoQ==
X-Received: by 2002:a17:902:c814:b0:193:a5b:ccf6 with SMTP id u20-20020a170902c81400b001930a5bccf6mr21683890plx.0.1673823709041;
        Sun, 15 Jan 2023 15:01:49 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm17907377plg.78.2023.01.15.15.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 15:01:48 -0800 (PST)
Date:   Mon, 16 Jan 2023 04:31:44 +0530
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Support omen backlight control
 wmi-acpi methods
Message-ID: <Y8SF2Os/NcWZkUMo@rishit-OMEN-Laptop-15-en0xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Omen Command Studio application includes a Light Studio feature
which can be used to control various features related to the keyboard
backlight via the 0x20009 command.

The command supports the following queries:

- 0x1: Checks if keyboard lighting is supported
- 0x2: Get the zone colors of each of the 4 zones on the keyboard
- 0x3: Set the zone colors of each of the 4 zones on the keyboard
- 0x4: Gets the state (on/off) of the backlight
- 0x5: Sets the state (on/off) of the backlight

This patch introduces a new sysfs led class called
"hp_omen::kbd_backlight" which can be used to control the state of the
backlight. It also includes a sysfs RW attribute called "backlight_color"
which can be used to get/set the current color of each zone.

The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 110 +++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..0dd6f1b6d9e1 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -27,6 +27,7 @@
 #include <linux/rfkill.h>
 #include <linux/string.h>
 #include <linux/dmi.h>
+#include <linux/leds.h>
 
 MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
 MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
@@ -136,6 +137,7 @@ enum hp_wmi_command {
 	HPWMI_WRITE	= 0x02,
 	HPWMI_ODM	= 0x03,
 	HPWMI_GM	= 0x20008,
+	HPWMI_KB    = 0x20009,
 };
 
 enum hp_wmi_hardware_mask {
@@ -734,12 +736,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t kbd_rgb_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	u8 val[128];
+
+	int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
+				       zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return ret;
+
+	strncat(buf, &val[25], 12);
+
+	return strlen(buf);
+}
+
+static ssize_t kbd_rgb_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	u8 val[128];
+	int ret;
+
+	ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
+				   zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return ret;
+
+	if (count != 12)
+		return -1;
+
+	strncpy(&val[25], buf, count);
+
+	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
+				   0);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
 static DEVICE_ATTR_RO(dock);
 static DEVICE_ATTR_RO(tablet);
 static DEVICE_ATTR_RW(postcode);
+static DEVICE_ATTR_RW(kbd_rgb);
 
 static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_display.attr,
@@ -748,6 +794,7 @@ static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_dock.attr,
 	&dev_attr_tablet.attr,
 	&dev_attr_postcode.attr,
+	&dev_attr_kbd_rgb.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(hp_wmi);
@@ -1294,6 +1341,63 @@ static int thermal_profile_setup(void)
 
 static int hp_wmi_hwmon_init(void);
 
+static struct led_classdev omen_kbd_led;
+
+static enum led_brightness get_omen_backlight_brightness(struct led_classdev *cdev)
+{
+	u8 val;
+
+	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return ret;
+
+	return (val & 0x80) ? LED_ON : LED_OFF;
+}
+
+static void set_omen_backlight_brightness(struct led_classdev *cdev, enum led_brightness value)
+{
+	char buffer[4] = { (value == LED_OFF) ? 0x64 : 0xe4, 0, 0, 0 };
+
+	hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_KB, &buffer,
+				       sizeof(buffer), 0);
+}
+
+
+static bool is_omen_lighting_supported(void)
+{
+	u8 val;
+
+	int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
+
+	if (ret)
+		return false;
+
+	return (val & 1) == 1;
+}
+
+static int omen_backlight_init(struct device *dev)
+{
+	int ret;
+
+	omen_kbd_led.name = "hp_omen::kbd_backlight";
+	omen_kbd_led.brightness_set = set_omen_backlight_brightness;
+	omen_kbd_led.brightness_get = get_omen_backlight_brightness;
+	omen_kbd_led.max_brightness = 1;
+
+	ret = devm_led_classdev_register(dev, &omen_kbd_led);
+
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static void omen_backlight_exit(struct device *dev)
+{
+	devm_led_classdev_unregister(dev, &omen_kbd_led);
+}
+
 static int __init hp_wmi_bios_setup(struct platform_device *device)
 {
 	int err;
@@ -1321,6 +1425,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	if (is_omen_lighting_supported())
+		omen_backlight_init(&device->dev);
+
 	return 0;
 }
 
@@ -1349,6 +1456,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 	if (platform_profile_support)
 		platform_profile_remove();
 
+	if (is_omen_lighting_supported())
+		omen_backlight_exit(&device->dev);
+
 	return 0;
 }
 
-- 
2.37.2

