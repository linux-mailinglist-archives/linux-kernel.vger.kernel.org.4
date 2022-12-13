Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0FD64BFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 23:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiLMWzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 17:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLMWzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 17:55:18 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D632627;
        Tue, 13 Dec 2022 14:55:17 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id fu10so1245699qtb.0;
        Tue, 13 Dec 2022 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40ZWp9bpood9P6+Umngp+1GnvNnCZK/uWDcL1ufyhCs=;
        b=FXhiaFSJre6O84NcBUi3Zn14ThrOmqM0UKgXyqCJKgBRd64kqBJqBY1bZGmVkn0nZm
         hCfUGr+8SnfEq1BZa2oDwALy8liwYzIFz2YxHzUNUEpSLJ30Ynj6pxcEeq7GMIETmYi1
         9bD5W4K81ky4KBMPgza9Iz4+lC2Kf6TpttGzBvx+QW95w03uV2/pcid9LC7tHW9fdFXy
         lWFmkm+XSDNsZEQ+C/+fFypp8nH2nCIr2RAdAmJ2V0vOK1FgQlyMbK66j4U6XgKrYCPa
         pE/TInxT8LI8vkflEvrnkvZtlv5ujyAV2U1Lps19YEGbgDNODV72Eh2LwxjN8bujEe6T
         M3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40ZWp9bpood9P6+Umngp+1GnvNnCZK/uWDcL1ufyhCs=;
        b=DTo5AiMQx8YpA3GxOG7GnCx2rKkwcYktLGfi2h8VvMZzhddOXWEJw/W06s2x+FrzVw
         uXAwggBkUiAykmKTUO9d9jUcofFgW1DjJdddEaMkoI6tnwXQwL0+D3jL8RirvFR3of9z
         iCfy5uc5jfz927Ef0og8l0mrh26NJ0hiYGboHHvheUcafVy/w8/7YIuAmS3iZSJqugG8
         pe/mUUz758BdsRciwvAF2keUKqrrMLCHV8tKnykjzL+fFK53mPIhCX3A/UqjyT6jPoUe
         OoKirSepZyz+XCWw1mAMV9bU2Nu7mSIcDirylTJzi6Sqrad0t8s7qezwR2RO+Puwu5i6
         qviw==
X-Gm-Message-State: ANoB5plz7uAkFbLBrprODX6/a8jcC3QfR3ONbaxKF/9pWLlrUCldPF27
        POeJnHwJI8qZ2v0jFJeTYBQ=
X-Google-Smtp-Source: AA0mqf5zrEeOGXo9dPMhrzMZKX05tezxX5/eXTIammlB9HXG85+4GmGI8AdSqlPotFmh6wql09ua4g==
X-Received: by 2002:ac8:5545:0:b0:3a5:2704:d4c0 with SMTP id o5-20020ac85545000000b003a52704d4c0mr7432643qtr.31.1670972115998;
        Tue, 13 Dec 2022 14:55:15 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id f1-20020a05620a280100b006ff8ac9acfdsm6769191qkp.49.2022.12.13.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 14:55:15 -0800 (PST)
From:   "Derek J. Clark" <derekjohn.clark@gmail.com>
To:     linux@roeck-us.net
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Date:   Tue, 13 Dec 2022 14:55:11 -0800
Message-Id: <20221213225511.77442-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the AYANEO AIR and AYANEO AIR Pro models of handheld
devices. These devices use the same EC registers and logic as the One X
Player mini AMD. Previous AYANEO models are not supported as they use a
different EC and do not have the necessary fan speed write enable and
setting registers. Tested on Aya Neo AIR. AIR Pro model EC functionality
and DMI data were verified using command line tools by another user.

The added devices are:
- AYANEO AIR (AMD 5560U)
- AYANEO AIR Pro (AMD 5560U)
- AYANEO AIR Pro (AMD 5825U)

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 17 +++++----
 MAINTAINERS                         |  6 ++++
 drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
 3 files changed, 63 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 39c588ec5c50..b93892c892c5 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -3,18 +3,21 @@
 Kernel driver oxp-sensors
 =========================
 
-Author:
+Authors:
+    - Derek John Clark <derekjohn.clark@gmail.com>
     - Joaquín Ignacio Aramendía <samsagax@gmail.com>
 
 Description:
 ------------
 
-One X Player devices from One Netbook provide fan readings and fan control
-through its Embedded Controller.
+Handheld devices from One Netbook and Aya Neo provide fan readings and fan
+control through their Embedded Controllers.
 
-Currently only supports AMD boards from the One X Player and AOK ZOE lineup.
-Intel boards could be supported if we could figure out the EC registers and
-values to write to since the EC layout and model is different.
+Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
+Neo devices. One X PLayer Intel boards could be supported if we could figure
+out the EC registers and values to write to since the EC layout and model is
+different. Aya Neo devices preceding the AIR may not be usable as the EC model
+is different and do not appear to have manual control capabiltities.
 
 Supported devices
 -----------------
@@ -22,6 +25,8 @@ Supported devices
 Currently the driver supports the following handhelds:
 
  - AOK ZOE A1
+ - Aya Neo AIR
+ - Aya Neo AIR Pro
  - OneXPlayer AMD
  - OneXPlayer mini AMD
  - OneXPlayer mini AMD PRO
diff --git a/MAINTAINERS b/MAINTAINERS
index 90220659206c..ba03a2983045 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15345,6 +15345,12 @@ S:	Maintained
 F:	drivers/mtd/nand/onenand/
 F:	include/linux/mtd/onenand*.h
 
+ONEXPLAYER FAN DRIVER
+M:	Derek John Clark <derekjohn.clark@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/oxp-sensors.c
+
 ONEXPLAYER FAN DRIVER
 M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index f84ec8f8eda9..7adc0199ea66 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform driver for OXP Handhelds that expose fan reading and control
- * via hwmon sysfs.
+ * Platform driver for Handhelds that expose fan reading and control via
+ * hwmon sysfs.
  *
- * Old boards have the same DMI strings and they are told appart by the
- * boot cpu vendor (Intel/AMD). Currently only AMD boards are supported
- * but the code is made to be simple to add other handheld boards in the
- * future.
+ * Old OXP boards have the same DMI strings and they are told appart by
+ * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
+ * supported but the code is made to be simple to add other handheld
+ * boards in the future.
  * Fan control is provided via pwm interface in the range [0-255].
  * Old AMD boards use [0-100] as range in the EC, the written value is
  * scaled to accommodate for that. Newer boards like the mini PRO and
@@ -42,6 +42,8 @@ static bool unlock_global_acpi_lock(void)
 
 enum oxp_board {
 	aok_zoe_a1 = 1,
+	aya_neo_air,
+	aya_neo_air_pro,
 	oxp_mini_amd,
 	oxp_mini_amd_pro,
 };
@@ -60,6 +62,20 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
+		},
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_air},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
+		},
+		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
@@ -161,8 +177,19 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
 			if (ret)
 				return ret;
-			if (board == oxp_mini_amd)
+			switch (board) {
+			case aok_zoe_a1:
+				break;
+			case aya_neo_air:
+			case aya_neo_air_pro:
+			case oxp_mini_amd:
 				*val = (*val * 255) / 100;
+				break;
+			case oxp_mini_amd_pro:
+				break;
+			default:
+				break;
+			}
 			return 0;
 		case hwmon_pwm_enable:
 			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
@@ -191,8 +218,19 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
 				return -EINVAL;
-			if (board == oxp_mini_amd)
+			switch (board) {
+			case aok_zoe_a1:
+				break;
+			case aya_neo_air:
+			case aya_neo_air_pro:
+			case oxp_mini_amd:
 				val = (val * 100) / 255;
+				break;
+			case oxp_mini_amd_pro:
+				break;
+			default:
+				break;
+			}
 			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
 		default:
 			break;
-- 
2.38.1

