Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1E739862
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFVHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjFVHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:48:00 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3B1BD5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:47:49 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id ECBDA240103
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687420068; bh=6Sq4WKTFaQaVW7Kdpp0Pbjr4A7LkSjfOGjU/5hdQ8QU=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=cu9mNfadI4WPE/ReKGSbA9hnZZeGd6MR+mC0Y7/77WZHvXNif4qXAHkGsPuh/xE1k
         xJq2uZooagrwqUtolTwc2i8S+eET9psN3JXy6BRo9Tnbb6IfWXBBAltw4bWcOT8PPW
         b8IGysUQUcUwmk7jDubQ1p5MAZYKrU1lKjjyyCaONBNtXCK7nRrB7EbNGhl1zxQJPg
         Jm+w+cvCsmYZ9M69bVzQHMDDo+g4Sz1+Z+b5NR8mzF1iJNm4TAQJ4lKHBiexJlx7NU
         KqAVuBwVeSk5eMTorXJLp6aVeU/hp5Uta3VQUugaycHC+eIhhOg90fdzqPnDfmANzb
         xt5v3V0X9w6CA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qmsst6pPHz6txt;
        Thu, 22 Jun 2023 09:47:46 +0200 (CEST)
Date:   Thu, 22 Jun 2023 07:47:45 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] hwmon: corsair-psu: add support for reading PWM values and
 mode
Message-ID: <ZJP8oSMHCorq9Nql@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also updates the documentation and comments accordingly. Fixes several
typos and updates the coding style to be more uniform.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 Documentation/hwmon/corsair-psu.rst |  6 +-
 drivers/hwmon/corsair-psu.c         | 85 ++++++++++++++++++++++++-----
 2 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index c389bd21f4f2..953850213889 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -15,11 +15,11 @@ Supported devices:
 
   Corsair HX850i
 
-  Corsair HX1000i (revision 1 and 2)
+  Corsair HX1000i (Series 2022 and Series 2023)
 
   Corsair HX1200i
 
-  Corsair HX1500i
+  Corsair HX1500i (Series 2022)
 
   Corsair RM550i
 
@@ -69,6 +69,8 @@ power1_input		Total power usage
 power2_input		Power usage of the 12v psu rail
 power3_input		Power usage of the 5v psu rail
 power4_input		Power usage of the 3.3v psu rail
+pwm			PWM value, read only
+pwm_enable		PWM mode, read only
 temp1_input		Temperature of the psu vrm component
 temp1_crit		Temperature max cirtical value of the psu vrm component
 temp2_input		Temperature of the psu case
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index dc24c566d08b..9e3e3c0a3bdd 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -32,18 +32,17 @@
  *	  but it is better to not rely on this (it is also hard to parse)
  *	- the driver uses raw events to be accessible from userspace (though this is not really
  *	  supported, it is just there for convenience, may be removed in the future)
- *	- a reply always start with the length and command in the same order the request used it
+ *	- a reply always starts with the length and command in the same order the request used it
  *	- length of the reply data is specific to the command used
  *	- some of the commands work on a rail and can be switched to a specific rail (0 = 12v,
  *	  1 = 5v, 2 = 3.3v)
  *	- the format of the init command 0xFE is swapped length/command bytes
  *	- parameter bytes amount and values are specific to the command (rail setting is the only
- *	  for now that uses non-zero values)
- *	- there are much more commands, especially for configuring the device, but they are not
- *	  supported because a wrong command/length can lockup the micro-controller
+ *	  one for now that uses non-zero values)
  *	- the driver supports debugfs for values not fitting into the hwmon class
- *	- not every device class (HXi, RMi or AXi) supports all commands
- *	- it is a pure sensors reading driver (will not support configuring)
+ *	- not every device class (HXi or RMi) supports all commands
+ *	- if configured wrong the PSU resets or shuts down, often before actually hitting the
+ *	- reported critical temperature
  */
 
 #define DRIVER_NAME		"corsair-psu"
@@ -58,7 +57,8 @@
 #define OCP_MULTI_RAIL		0x02
 
 #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
-#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
+#define PSU_CMD_FAN_PWM		0x3B /* the rest of the commands expect length 3 */
+#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40
 #define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
 #define PSU_CMD_RAIL_AMPS_HCRIT	0x46
 #define PSU_CMD_TEMP_HCRIT	0x4F
@@ -76,6 +76,7 @@
 #define PSU_CMD_UPTIME		0xD2
 #define PSU_CMD_OCPMODE		0xD8
 #define PSU_CMD_TOTAL_WATTS	0xEE
+#define PSU_CMD_FAN_PWM_ENABLE	0xF0
 #define PSU_CMD_INIT		0xFE
 
 #define L_IN_VOLTS		"v_in"
@@ -145,6 +146,14 @@ static int corsairpsu_linear11_to_int(const u16 val, const int scale)
 	return (exp >= 0) ? (result << exp) : (result >> -exp);
 }
 
+/* the micro-controller uses percentage values to control pwm */
+static int corsairpsu_dutycycle_to_pwm(const long dutycycle)
+{
+	const int result = (256 << 16) / 100;
+
+	return (result * dutycycle) >> 16;
+}
+
 static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
 {
 	unsigned long time;
@@ -244,8 +253,8 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	/*
 	 * the biggest value here comes from the uptime command and to exceed MAXINT total uptime
 	 * needs to be about 68 years, the rest are u16 values and the biggest value coming out of
-	 * the LINEAR11 conversion are the watts values which are about 1200 for the strongest psu
-	 * supported (HX1200i)
+	 * the LINEAR11 conversion are the watts values which are about 1500 for the strongest psu
+	 * supported (HX1500i)
 	 */
 	tmp = ((long)data[3] << 24) + (data[2] << 16) + (data[1] << 8) + data[0];
 	switch (cmd) {
@@ -264,6 +273,24 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
 	case PSU_CMD_FAN:
 		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
 		break;
+	case PSU_CMD_FAN_PWM_ENABLE:
+		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
+		/*
+		 * 0 = automatic mode, means the micro-controller controls the fan using a plan
+		 *     which can be modified, but changing this plan is not supported by this
+		 *     driver, the matching PWM mode is automatic fan speed control = PWM 2
+		 * 1 = fixed mode, fan runs at a fixed speed represented by a percentage
+		 *     value 0-100, this matches the PWM manual fan speed control = PWM 1
+		 * technically there is no PWM no fan speed control mode, it would be a combination
+		 * of 1 at 100%
+		 */
+		if (*val == 0)
+			*val = 2;
+		break;
+	case PSU_CMD_FAN_PWM:
+		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
+		*val = corsairpsu_dutycycle_to_pwm(*val);
+		break;
 	case PSU_CMD_RAIL_WATTS:
 	case PSU_CMD_TOTAL_WATTS:
 		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000000);
@@ -349,6 +376,18 @@ static umode_t corsairpsu_hwmon_fan_is_visible(const struct corsairpsu_data *pri
 	}
 }
 
+static umode_t corsairpsu_hwmon_pwm_is_visible(const struct corsairpsu_data *priv, u32 attr,
+					       int channel)
+{
+	switch (attr) {
+	case hwmon_pwm_input:
+	case hwmon_pwm_enable:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
 static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairpsu_data *priv, u32 attr,
 						 int channel)
 {
@@ -416,6 +455,8 @@ static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sens
 		return corsairpsu_hwmon_temp_is_visible(priv, attr, channel);
 	case hwmon_fan:
 		return corsairpsu_hwmon_fan_is_visible(priv, attr, channel);
+	case hwmon_pwm:
+		return corsairpsu_hwmon_pwm_is_visible(priv, attr, channel);
 	case hwmon_power:
 		return corsairpsu_hwmon_power_is_visible(priv, attr, channel);
 	case hwmon_in:
@@ -447,6 +488,20 @@ static int corsairpsu_hwmon_temp_read(struct corsairpsu_data *priv, u32 attr, in
 	return err;
 }
 
+static int corsairpsu_hwmon_pwm_read(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
+{
+	switch (attr) {
+	case hwmon_pwm_input:
+		return corsairpsu_get_value(priv, PSU_CMD_FAN_PWM, 0, val);
+	case hwmon_pwm_enable:
+		return corsairpsu_get_value(priv, PSU_CMD_FAN_PWM_ENABLE, 0, val);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int corsairpsu_hwmon_power_read(struct corsairpsu_data *priv, u32 attr, int channel,
 				       long *val)
 {
@@ -531,6 +586,8 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
 		if (attr == hwmon_fan_input)
 			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
 		return -EOPNOTSUPP;
+	case hwmon_pwm:
+		return corsairpsu_hwmon_pwm_read(priv, attr, channel, val);
 	case hwmon_power:
 		return corsairpsu_hwmon_power_read(priv, attr, channel, val);
 	case hwmon_in:
@@ -571,7 +628,7 @@ static const struct hwmon_ops corsairpsu_hwmon_ops = {
 	.read_string	= corsairpsu_hwmon_ops_read_string,
 };
 
-static const struct hwmon_channel_info * const corsairpsu_info[] = {
+static const struct hwmon_channel_info *const corsairpsu_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
@@ -579,6 +636,8 @@ static const struct hwmon_channel_info * const corsairpsu_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(power,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
@@ -813,15 +872,15 @@ static const struct hid_device_id corsairpsu_idtable[] = {
 	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i revision 1 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i Series 2022 */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
 	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i revision 2 */
-	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i Series 2023 */
+	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i Series 2022 */
 	{ },
 };
 MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
-- 
2.41.0

