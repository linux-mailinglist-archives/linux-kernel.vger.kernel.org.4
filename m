Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3564CD30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiLNPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiLNPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:40:41 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0160DC;
        Wed, 14 Dec 2022 07:40:40 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id q18-20020a056830441200b006704633f258so1985746otv.0;
        Wed, 14 Dec 2022 07:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MB+cjJ0APVSPLYKSXokJmYfJJzb5hyUnGFn3uvrOCQs=;
        b=YzK6BC77zHknUwqd/KFXfr2QqsoewRVPzPQNToJD2oWI12PC2oGU+FIEn1Esh1cWru
         t/12wDjSd8xJL93Dg34+waP3jflFCF8pZYFgl2j2kpJzIAK+beIW2DarCOAPNqZ23jXe
         XdtXnG0cw2GSnTg0lYk8zfgAmPba2GBmUSARVsF+0n14/upTmIjtwgShbbFOSwCcy8kJ
         kt0s9p60N4Jzn+GN1Mn9jZG9/5a10Tj0dl8tPiXAiHg9P+nARR+OrPPFwkO9VuCehrVv
         cZdbGaXP38BrLMtpdZGFgQ95eDPsAbrWc0PM4PGc+txf1cJjSLoPlgwS8C8RzkAsFOhR
         H9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB+cjJ0APVSPLYKSXokJmYfJJzb5hyUnGFn3uvrOCQs=;
        b=2eBWyi75o3uv+6CNjGtT4PInlYXcvjk4OBbVDPsIydlNqd0aS6Ptb/cMBoOsoAd5yg
         VjNsDCee1sVnbhRIxPBt4gw7HVzruYaX5zvVpK6FoEu7oVd+hRt5F1ridKK7WRhxR7Zi
         IEkULIESXxuoy9iEK2uLNQsO2+4voe2F4U0861uWFVQ/VDHraByeBlWfqaaqYmB/gcDr
         o9qmt6KHrm7GKLrkmMyMMP9/mTpjlbAVz9Htzf6DKzo5l9wq9kmVNNeCyn2Ki+EOrwMr
         M8+xArua4H4oJQPGMziyMQBtlzafzetvhuSVfuRtmmYlpQF27QybnBHswmymTMz8kzBW
         l/+Q==
X-Gm-Message-State: ANoB5pkaL8q5fr8A+U8csKIO7VHClSeeRRFolf+xbiBe8sE1bL37IpHo
        UaihvD0o2rFi+g5h3CZ6E8s=
X-Google-Smtp-Source: AA0mqf7zsaBsYwvuGben3iQe/1eXAlkowHMFEXh5oHiN/FQHD3DDN9RTrC9mYp+67NsWGu41mk8R3A==
X-Received: by 2002:a9d:51c3:0:b0:670:6cfe:385 with SMTP id d3-20020a9d51c3000000b006706cfe0385mr13244001oth.23.1671032439413;
        Wed, 14 Dec 2022 07:40:39 -0800 (PST)
Received: from localhost.localdomain (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 88-20020a9d0161000000b0066c49ce8b77sm2455146otu.77.2022.12.14.07.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:40:39 -0800 (PST)
From:   "Derek J. Clark" <derekjohn.clark@gmail.com>
To:     linux@roeck-us.net
Cc:     "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Date:   Wed, 14 Dec 2022 07:39:08 -0800
Message-Id: <20221214153908.99926-1-derekjohn.clark@gmail.com>
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

Add support for the AYANEO AIR and AYANEO AIR Pro models of handheld
devices. These devices use the same EC registers and logic as the One X
Player mini AMD. Previous AYANEO models are not supported as they use a
different EC and do not have the necessary fan speed write enable and
setting registers. Tihe driver is tested on Aya Neo AIR while AIR Pro
model EC functionality and DMI data were verified using command line
tools by another user.

The added devices are:
- AYANEO AIR (AMD 5560U)
- AYANEO AIR Pro (AMD 5560U)
- AYANEO AIR Pro (AMD 5825U)

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 Documentation/hwmon/oxp-sensors.rst | 19 ++++++----
 MAINTAINERS                         |  1 +
 drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
 3 files changed, 59 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
index 39c588ec5c50..a53c961065b2 100644
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

