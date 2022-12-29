Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8D6588C2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiL2C4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2C4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:56:16 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BB27679;
        Wed, 28 Dec 2022 18:56:14 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h26so14145909qtu.2;
        Wed, 28 Dec 2022 18:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xrDNceExZ/L95VfQRjVAvngWOO0TiOGVDbqkT+0TwLQ=;
        b=aIsyYUsMH4UPiDKmXXjWLk8yUztfA1BuOET9SlI0Mf09rnEevLIvMOsCH7+ezgBsHa
         l9MCFhpU338Zi8ouruinB0I+J4c+Yl/JIynLc/JHUIHEavMLZdKnzN9Vxh49NQXTPoes
         8EGzd8JgVystFrQDjrIMxnGsbm+8PwTAnkIAh0V9NRpsa0eah6ArRnxyGIFjEYhU0+r9
         THV1CNzHod6C+kKhNiYRJ18TerZOfhY0LXZ+A6Az05e/bfugx6bM1vPlUgLiIYqTxKQn
         oBrFPHQVvXxHpK+ED29gqBN/uFbeeBva7SxbFNQZJ2RtQHskltcqShpqettLZZHlCW4Y
         ah6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrDNceExZ/L95VfQRjVAvngWOO0TiOGVDbqkT+0TwLQ=;
        b=KI8lpnhG4zGkE4WAOU2vgmo0sPr4BockPC+4cMUqlQcU9OOpWYFzOLoKIvEvK6uiRV
         SEVR5tIqOFBAFWteFaipv2/myyeco1TyIQXjWLIaHBEgITtVvduGArr+TUy0Sj7/t9FV
         mY77SehzX5Bh2LdgP3ghcPBlMBXqNPmKmrL7MqSQ5GX5GQPc0sPv+XtHObk624u4q1jK
         TXf72mh/Bwz2hgMaqr/A51y/FQkDv2f4EXk5MES1Fn0Beysd6JzqtbLAnz+/zdk56CZf
         JHxl0jiufZhu6bGNQWvv1WxHC7ZIcNhtSRJs254Ja4UlZ05uha0iBllCega7WQrhD21F
         ut5g==
X-Gm-Message-State: AFqh2krNc+c4Eeoq3b3xyQq5fb1IUxG6RFlMyinrGH/dCliaDPrlzEdT
        LPQby3Ybljh9/vvuA+aTutw=
X-Google-Smtp-Source: AMrXdXvBfmJf/ohEkCiAazyGrAoZv2w8MAjEDRyERpFFNhUpXIewZZhdo0ZVK2olPRCUTc+aF78Y4Q==
X-Received: by 2002:ac8:7518:0:b0:3a8:7c9f:7498 with SMTP id u24-20020ac87518000000b003a87c9f7498mr30607318qtq.43.1672282573409;
        Wed, 28 Dec 2022 18:56:13 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a19-20020ac81093000000b003a4f435e381sm10834372qtj.18.2022.12.28.18.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 18:56:13 -0800 (PST)
From:   "Derek J. Clark" <derekjohn.clark@gmail.com>
To:     linux@roeck-us.net
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Date:   Wed, 28 Dec 2022 18:56:09 -0800
Message-Id: <20221229025609.147482-1-derekjohn.clark@gmail.com>
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

Add support for the AYANEO AIR and AYANEO AIR Pro models of handheld devices.
These devices use the same EC registers and logic as the One X Player mini
AMD. Previous AYANEO models are not supported as they use a different EC and
do not have the necessary fan speed write enable and setting registers. The
driver is tested on AYANEO AIR while AIR Pro model EC functionality and DMI
data were verified using command line tools by another user.

Add:
- AYANEO AIR (AMD 5560U)
- AYANEO AIR Pro (AMD 5560U)
- AYANEO AIR Pro (AMD 5825U)

Fix spelling error (appart -> apart) 
---
v4:
Revert delete of ':' from Description: in Documentation
Add fix spelling error to commit description.
v3:
Bundled all cases that lead to break.
Spelling and grammar fixes.
More verbose description of supported devices.
v2:
Fix grammar in commit description
Delete ':' from Description: in Documentation
---
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 17 ++++++----
 MAINTAINERS                         |  1 +
 drivers/hwmon/oxp-sensors.c         | 52 ++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 39c588ec5c50..566a8d5bde08 100644
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
+			case oxp_mini_amd_pro:
+			case aok_zoe_a1:
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

