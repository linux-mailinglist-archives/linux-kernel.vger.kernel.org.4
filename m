Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C1676040
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjATWkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATWkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:40:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BEB22A25;
        Fri, 20 Jan 2023 14:40:17 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z20so4584999plc.2;
        Fri, 20 Jan 2023 14:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TD4+D55doYrSZRUONO0jFQcQqjgGxOTX6KlK/7naN+0=;
        b=TonjkksGdo9veTWYHSw4ATzqQHkxY88mSsON8Mcq+OQ5+2LcTsLwBZD2vGYZnrLBTQ
         iXZNF4+JbYxA7Jru20WvvYkF38dyIHKspLAEnxOCDMpNG357Xq3XndAZ+d+G8rb47g47
         zwYSDK8RA2lE3CIYJmVMvduSmVL+HNorPwRieu38N8S7I58SpXHRs87cRYZ4SCvfi/Bn
         mrWuUrwJqcFEcZCP+oF1GWrUdf6YQKdNLoDfJfj1sByW9h1jQVmcT5Gsl+gZmOMkNZ28
         j7f3d4OBPlIvu6hXgLRGgqmDXqyX/FMrEq8lShj8Bs9iL40czDPksnkY7WX8aYHTKe+b
         0ANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD4+D55doYrSZRUONO0jFQcQqjgGxOTX6KlK/7naN+0=;
        b=MRz4PGqawLC1F/TLcKh8YnyO6uQauNAESUCnnU/Xc9gXKVybQ0Qg5OmakidzVfAI1i
         yOgtKzLI+BNLtrlYtkyHQ4DgwdLOMkpPGF7mpuh+xBrWrZrMYNDSLuQL4awboqyQ3wOh
         96oYF2D5eLBYLjEcrVAU9t6e2o/PnVVjdcBWAyv13zSGjU2JHa54ohC2L5q7EBMR0JXo
         YrPiuF7l42EzQjKVzxIA18+hy4cR42ynm7zm0OzhP2tL2DRVPXDtR262Eu3CPEzrtBoA
         i447XaOR9NKCrTdyyl/oIjA8XXH6eLW3PI6OSTe5Q0FawHjPT/5ETSOcPqlAhqzqHDk9
         10zQ==
X-Gm-Message-State: AFqh2kqUFDJYn8/9Tp93diFr76Y56JRlScfi+/hM5TCf10d7Ir9JSPt/
        u9B3oNnqGL2AcOke6GuxlA4LACWl5xHaeKqO
X-Google-Smtp-Source: AMrXdXtX36sJYvZ0zSHGwR0IgUSUJ05qd5MRgH3L1AlMKqBofQuAcQRDHRrDa2AKdsCS53/Owtk8uw==
X-Received: by 2002:a17:90a:1a0a:b0:22b:b346:4d86 with SMTP id 10-20020a17090a1a0a00b0022bb3464d86mr3414527pjk.43.1674254416834;
        Fri, 20 Jan 2023 14:40:16 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090abc8d00b00219eefe47c7sm1483271pjr.47.2023.01.20.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 14:40:15 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rishit Bansal <rishitbansal0@gmail.com>
Subject: [PATCH v2] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods
Date:   Sat, 21 Jan 2023 04:09:08 +0530
Message-Id: <20230120223908.28678-1-rishitbansal0@gmail.com>
X-Mailer: git-send-email 2.37.2
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
backlight. It also includes a sysfs RW attribute called "kbd_rgb"
which can be used to get/set the current color of each zone.

Additionally, it also maps the backlight event to the KEY_KBDILLUMTOGGLE
key so it shows the correct notification on userspace.

The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
Changes since v1:
 - Map backlight key to KEY_KBDILLUMTOGGLE
---
 drivers/platform/x86/hp/hp-wmi.c | 113 +++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..a9e2634a9d46 100644
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
@@ -219,6 +221,7 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
+	{ KE_KEY, KEY_KBDILLUMTOGGLE, { KEY_KBDILLUMTOGGLE }},
 	{ KE_END, 0 }
 };
 
@@ -734,12 +737,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
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
@@ -748,6 +795,7 @@ static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_dock.attr,
 	&dev_attr_tablet.attr,
 	&dev_attr_postcode.attr,
+	&dev_attr_kbd_rgb.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(hp_wmi);
@@ -853,6 +901,8 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_PROXIMITY_SENSOR:
 		break;
 	case HPWMI_BACKLIT_KB_BRIGHTNESS:
+		sparse_keymap_report_event(hp_wmi_input_dev,
+						KEY_KBDILLUMTOGGLE, 1, true);
 		break;
 	case HPWMI_PEAKSHIFT_PERIOD:
 		break;
@@ -1294,6 +1344,63 @@ static int thermal_profile_setup(void)
 
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
@@ -1321,6 +1428,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	if (is_omen_lighting_supported())
+		omen_backlight_init(&device->dev);
+
 	return 0;
 }
 
@@ -1349,6 +1459,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
 	if (platform_profile_support)
 		platform_profile_remove();
 
+	if (is_omen_lighting_supported())
+		omen_backlight_exit(&device->dev);
+
 	return 0;
 }
 
-- 
2.37.2

