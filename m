Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45A6587C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbiL1XGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiL1XGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:06:43 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E14E95;
        Wed, 28 Dec 2022 15:06:41 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id g7so13853416qts.1;
        Wed, 28 Dec 2022 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XcIPcUbtved4OSvuCwO20Kdo7utIV/9HcXrfdp5KB4o=;
        b=cHPGzQLQupk9Ma1ODRwW/5bJRdKnNlHYWHLfN9RfUKu7h1kBhf4SJAhPgx2tYdrAo6
         i9i6SuSUJ/9BnY5JmmwjFVUqSf9KnjBJRvcWMvDT+TfJYLY4lhHio8PHA0OOzSBiLx1I
         xOzCXmI4TWi0jPdTgy92B13aBACNOvVY/znvmDsNC087tknUeMZjYWdrU2umM4dmRRl9
         GxkuGpA3IkGGSclw5QLi5YymCDpyh34SzeTTUTPb7e339wyie2b97wYDHJh0vOVu1dy7
         6nlKhw9iqCLyhuX27xkW74toCABxrgDgRQol5Xv4cq2G53SKmZV0VHmLE/msxM0nhaAD
         r/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XcIPcUbtved4OSvuCwO20Kdo7utIV/9HcXrfdp5KB4o=;
        b=xKvho7F3S4ymJKfewMhUPWs6XoiodMYFtcMY1s2MU+jUy+/Oq2Jx7XZHxjl0a+ACHd
         npUzyImnmk+L7PC4yOxouwNvp80xYHPPXqGwz/9eoYY43TfCXi/3I9W0oYdGmbQgMirG
         AQ7XEbCr5KGP6PRl2SDFRnUvQ5KBY85fFK+yD2tRwqgOqhkY0M+4eJaT+Q00pHAM7pSG
         nl6juc7ubZsVCsF3nDpO4yjRiWaTJX8SokuGH6N8WRfzQyaqIm0tM5B9160BYAfeLXNB
         nZ5CNimBovX+ZezlV7hvnsaFkLXPuFZ54rtNV6tiFE9OVUputiKDBQ2FIGRCfF+vrISe
         MmMw==
X-Gm-Message-State: AFqh2kqSDpgPy/lxHi5ZRRnM2kd8QPW6ggLyLkwJ47QA0DwZuypYKAfJ
        v8esReIG4UPLZmBGAUV6TZk=
X-Google-Smtp-Source: AMrXdXvqaipsUQ6alQgXFvsB3D9hkgBi9bBwyF+8B+CLNnS4wvkjF/aOBIDBO1jdUAuYvFOw4UfpPw==
X-Received: by 2002:ac8:43cb:0:b0:3a8:112d:27de with SMTP id w11-20020ac843cb000000b003a8112d27demr36949146qtn.26.1672268800956;
        Wed, 28 Dec 2022 15:06:40 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006fec1c0754csm11932649qkm.87.2022.12.28.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 15:06:40 -0800 (PST)
From:   "Derek J. Clark" <derekjohn.clark@gmail.com>
To:     linux@roeck-us.net
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Add support for the AYANEO AIR and AYANEO AIR Pro models of handheld devices. These devices use the same EC registers and logic as the One X Player mini AMD. Previous AYANEO models are not supported as they use a different EC and do not have the necessary fan speed write enable and setting registers. The driver is tested on AYANEO AIR while AIR Pro model EC functionality and DMI data were verified using command line tools by another user.
Date:   Wed, 28 Dec 2022 15:06:32 -0800
Message-Id: <20221228230632.141917-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.39.0
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

The added devices are:
- AYANEO AIR (AMD 5560U)
- AYANEO AIR Pro (AMD 5560U)
- AYANEO AIR Pro (AMD 5825U)
---
Bundled all cases that lead to break.
Spelling and grammar fixes.
More verbose description of supported devices.
---
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 19 +++++++----
 MAINTAINERS                         |  1 +
 drivers/hwmon/oxp-sensors.c         | 52 ++++++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 39c588ec5c50..7f6e8def5aef 100644
--- a/Documentation/hwmon/oxp-sensors.rst
+++ b/Documentation/hwmon/oxp-sensors.rst
@@ -3,18 +3,21 @@
 Kernel driver oxp-sensors
 =========================
 
-Author:
+Authors:
+    - Derek John Clark <derekjohn.clark@gmail.com>
     - Joaquín Ignacio Aramendía <samsagax@gmail.com>
 
-Description:
+Description
 ------------
 
-One X Player devices from One Netbook provide fan readings and fan control
-through its Embedded Controller.
+Handheld devices from One Netbook and Aya Neo provide fan readings and fan
+control through their embedded controllers.
 
-Currently only supports AMD boards from the One X Player and AOK ZOE lineup.
-Intel boards could be supported if we could figure out the EC registers and
-values to write to since the EC layout and model is different.
+Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
+Neo devices. One X Player Intel boards could be supported if we could figure
+out the EC registers and values to write to since the EC layout and model is
+different. Aya Neo devices preceding the AIR may not be supportable as the EC
+model is different and do not appear to have manual control capabilities.
 
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
index 90220659206c..8bce95170f12 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15346,6 +15346,7 @@ F:	drivers/mtd/nand/onenand/
 F:	include/linux/mtd/onenand*.h
 
 ONEXPLAYER FAN DRIVER
+M:	Derek John Clark <derekjohn.clark@gmail.com>
 M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
index f84ec8f8eda9..36872b57912a 100644
--- a/drivers/hwmon/oxp-sensors.c
+++ b/drivers/hwmon/oxp-sensors.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Platform driver for OXP Handhelds that expose fan reading and control
- * via hwmon sysfs.
+ * Platform driver for OneXPlayer, AOK ZOE, and Aya Neo Handhelds that expose
+ * fan reading and control via hwmon sysfs.
  *
- * Old boards have the same DMI strings and they are told appart by the
- * boot cpu vendor (Intel/AMD). Currently only AMD boards are supported
- * but the code is made to be simple to add other handheld boards in the
- * future.
+ * Old OXP boards have the same DMI strings and they are told apart by
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
@@ -161,8 +177,17 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
 			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
 			if (ret)
 				return ret;
-			if (board == oxp_mini_amd)
+			switch (board) {
+			case aya_neo_air:
+			case aya_neo_air_pro:
+			case oxp_mini_amd:
 				*val = (*val * 255) / 100;
+				break;
+			case aok_zoe_a1:
+			case oxp_mini_amd_pro:
+			default:
+				break;
+			}
 			return 0;
 		case hwmon_pwm_enable:
 			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
@@ -191,8 +216,17 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_pwm_input:
 			if (val < 0 || val > 255)
 				return -EINVAL;
-			if (board == oxp_mini_amd)
+			switch (board) {
+			case aya_neo_air:
+			case aya_neo_air_pro:
+			case oxp_mini_amd:
 				val = (val * 100) / 255;
+				break;
+			case aok_zoe_a1:
+			case oxp_mini_amd_pro:
+			default:
+				break;
+			}
 			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
 		default:
 			break;
@@ -233,7 +267,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
 
 	/*
 	 * Have to check for AMD processor here because DMI strings are the
-	 * same between Intel and AMD boards, the only way to tell them appart
+	 * same between Intel and AMD boards, the only way to tell them apart
 	 * is the CPU.
 	 * Intel boards seem to have different EC registers and values to
 	 * read/write.
-- 
2.39.0

