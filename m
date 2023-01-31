Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1007683ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjAaXvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjAaXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:50:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9BC38EAB;
        Tue, 31 Jan 2023 15:50:54 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z1so9223388plg.6;
        Tue, 31 Jan 2023 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WslHUg1g5Qm3+Vz0tJmbhJFBRAyc1/qD3WAiokhW5E=;
        b=qY+Y0yisS6B/KaNtEyAfcn7r3jmmpH3uqCv+Rp+jH93BmWnK2U2VoJ8N14vjHE5oHH
         pxzfap90i4sa/0p/zS4pFdZUG6ZnNbArqItKpEGH1ZF52s4ObXL79Wej5GhwQ6a5vRhD
         CGCOpr8yf+hDzQBaYiYRk3G0deM0ZBcFh9/oXDjxaUKnmMZsA7Fva3/+WhWd2tt0x5hw
         VJali4fquIrffo1BUK387AInL/JIa/8mSB0LP3A2VPESWcP+wz1FpLfiyZgocjFMNR+a
         u9xaaaXdS4pq5Z3fBHERZuHxqPCBr3hp7se6Nnq/rZPqympqcmsApznMovO64fLNguaO
         HpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WslHUg1g5Qm3+Vz0tJmbhJFBRAyc1/qD3WAiokhW5E=;
        b=EPZVD1XSLl5oDySXWOo06+fPTRa/6wW4mL5YOWG+Furss8RgubCMiYRhRULNbRvH6X
         W1bxDhLVorJtRDT7K9BbXsx2tgWGzidQSiaMZM9MvPnxi0kOuZKholf0paJWx74XCxnY
         RuLcIHyxPfahMlcCjPTvXksyTTd/s0p2cBshoituko/W1z2bYANIDsto6PDK6/9fUrGO
         R/YNY2cLLtvs+/kqk98vj9q1CC2UN002WGNH/To//ieqKIZDKE7TTYEGHNONZIJ44XI6
         YNKfq+pGQAvfHU7a8agIJmy1oG2MXmjycRDglb8bFrk4YUge920E9iXEWa8TuzkhvSxo
         0gtg==
X-Gm-Message-State: AO0yUKX4Ksl0qZW/ln+71jewq5h+nyJMmm6CXWiWO5buJrkg3hZqjI6G
        ll0YaqoSWXDoFeSlpjQAf5s=
X-Google-Smtp-Source: AK7set/nqxHTfU6pfSeQ2U/FdcASIlljHs6oGNFKD9eWRabWLN4X/A+/MWy+vmS4T7RHwBdoy30Icw==
X-Received: by 2002:a05:6a20:2d2a:b0:b9:5fda:cd71 with SMTP id g42-20020a056a202d2a00b000b95fdacd71mr419867pzl.6.1675209048768;
        Tue, 31 Jan 2023 15:50:48 -0800 (PST)
Received: from rishit-OMEN-Laptop-15-en0xxx ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id k24-20020a637b58000000b00476dc914262sm9247109pgn.1.2023.01.31.15.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:50:48 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Rishit Bansal <rishitbansal0@gmail.com>
Subject: [PATCH V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods
Date:   Wed,  1 Feb 2023 05:20:27 +0530
Message-Id: <20230131235027.36304-1-rishitbansal0@gmail.com>
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
backlight. It also includes a sysfs RW attribute at the following
location:

/sys/class/leds/hp_omen::kbd_backlight/zone_colors

This file contains the color codes for each of the 4 zones of the
keyboard. Each zone's color is represented by R,G and B components, each
of which take a byte. Therefore, the total size of this file is always:

4 (zones) * 3 (components R,G,B) = 12 bytes

An example output from this file is:

$ xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
00000000: 01ff 00ff 01ff ffff 01ff 0101            ............

The above output means that each zone has the following hex
color codes:
Zone 1: #01ff00
Zone 2: #ff01ff
Zone 3: #ffff01
Zone 4: #ff0101

Colors can be set on the backlight by writing back to this file by
passing 12 bytes in the exact same format as above.

Additionally this patch also maps the backlight event to the KEY_KBDILLUMTOGGLE
key so it shows the correct notification on userspace.

The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.

Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
---
Changes since v1:
 - Map backlight key to KEY_KBDILLUMTOGGLE

Changes since v2:
 - Changes all str operations to memcpy() to handle null bytes edge
   cases
 - Renamed kbd_rgb to zone_colors, and moved it to inside the
   kbd_backlight directory
 - Added documentation for the zone_colors file
 - Removed KEY_KBDILLUMTOGGLE from the parse-map, and instead emitted
   directly
 - Remove logic to unregister from devm
 - Moved a few constants to #define
 - Updated path description with more details on zone_colors file format
---
 .../ABI/testing/sysfs-platform-hp-wmi         |  33 +++++
 drivers/platform/x86/hp/hp-wmi.c              | 116 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hp-wmi

diff --git a/Documentation/ABI/testing/sysfs-platform-hp-wmi b/Documentation/ABI/testing/sysfs-platform-hp-wmi
new file mode 100644
index 000000000000..ccf2d29185ee
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-hp-wmi
@@ -0,0 +1,33 @@
+What:		/sys/class/leds/hp_omen::kbd_backlight/zone_colors
+Date:		Feb 2023
+KernelVersion:	6.2
+Contact:	Rishit Bansal <rishitbansal0@gmail.com>
+Description:
+		This file stores the RGB color codes for each of
+		the 4 zones of the backlight on HP omen keyboards.
+
+		Each zone takes R,G,B values. The R,G,B values each can
+		range from 0-255. This means the whole state of the colors
+		can be represented in 12 bytes:
+
+		(4 zones * 3 color components (R,G,B) * 1 byte = 12 bytes)
+
+		Here is an example where we read the file:
+
+			xxd /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
+			00000000: 01ff 00ff 01ff ffff 01ff 0101            ............
+
+		The above output means that each zone has the following hex
+		color codes:
+		Zone 1: #01ff00
+		Zone 2: #ff01ff
+		Zone 3: #ffff01
+		Zone 4: #ff0101
+
+		The colors of the each of the zones can be set by writing
+		the same format to this file. For example to set all zones
+		to white, we would do:
+
+			echo -n -e '\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff' | sudo tee /sys/class/leds/hp_omen\:\:kbd_backlight/zone_colors
+
+
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 0a99058be813..f86cb7feaad4 100644
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
+	HPWMI_KB	= 0x20009,
 };
 
 enum hp_wmi_hardware_mask {
@@ -254,6 +256,9 @@ static const char * const tablet_chassis_types[] = {
 
 #define DEVICE_MODE_TABLET	0x06
 
+#define OMEN_ZONE_COLOR_OFFSET 0x19
+#define OMEN_ZONE_COLOR_LEN 0x0c
+
 /* map output size to the corresponding WMI method id */
 static inline int encode_outsize_for_pvsz(int outsize)
 {
@@ -734,12 +739,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
+static ssize_t zone_colors_show(struct device *dev,
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
+	memcpy(buf, &val[OMEN_ZONE_COLOR_OFFSET], OMEN_ZONE_COLOR_LEN);
+
+	return OMEN_ZONE_COLOR_LEN;
+}
+
+static ssize_t zone_colors_store(struct device *dev,
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
+	if (count != OMEN_ZONE_COLOR_LEN)
+		return -1;
+
+	memcpy(&val[OMEN_ZONE_COLOR_OFFSET], buf, count);
+
+	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
+				   0);
+
+	if (ret)
+		return ret;
+
+	return OMEN_ZONE_COLOR_LEN;
+}
+
 static DEVICE_ATTR_RO(display);
 static DEVICE_ATTR_RO(hddtemp);
 static DEVICE_ATTR_RW(als);
 static DEVICE_ATTR_RO(dock);
 static DEVICE_ATTR_RO(tablet);
 static DEVICE_ATTR_RW(postcode);
+static DEVICE_ATTR_RW(zone_colors);
 
 static struct attribute *hp_wmi_attrs[] = {
 	&dev_attr_display.attr,
@@ -752,6 +801,12 @@ static struct attribute *hp_wmi_attrs[] = {
 };
 ATTRIBUTE_GROUPS(hp_wmi);
 
+static struct attribute *omen_kbd_led_attrs[] = {
+	&dev_attr_zone_colors.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(omen_kbd_led);
+
 static void hp_wmi_notify(u32 value, void *context)
 {
 	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -853,6 +908,10 @@ static void hp_wmi_notify(u32 value, void *context)
 	case HPWMI_PROXIMITY_SENSOR:
 		break;
 	case HPWMI_BACKLIT_KB_BRIGHTNESS:
+		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
+		input_sync(hp_wmi_input_dev);
+		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
+		input_sync(hp_wmi_input_dev);
 		break;
 	case HPWMI_PEAKSHIFT_PERIOD:
 		break;
@@ -1294,6 +1353,60 @@ static int thermal_profile_setup(void)
 
 static int hp_wmi_hwmon_init(void);
 
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
+static struct led_classdev omen_kbd_led = {
+	.name = "hp_omen::kbd_backlight",
+	.brightness_set = set_omen_backlight_brightness,
+	.brightness_get = get_omen_backlight_brightness,
+	.max_brightness = 1,
+	.groups = omen_kbd_led_groups,
+};
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
+	input_set_capability(hp_wmi_input_dev, KE_KEY, KEY_KBDILLUMTOGGLE);
+
+	ret = devm_led_classdev_register(dev, &omen_kbd_led);
+
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __init hp_wmi_bios_setup(struct platform_device *device)
 {
 	int err;
@@ -1321,6 +1434,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
 
 	thermal_profile_setup();
 
+	if (is_omen_lighting_supported())
+		omen_backlight_init(&device->dev);
+
 	return 0;
 }
 
-- 
2.37.2

