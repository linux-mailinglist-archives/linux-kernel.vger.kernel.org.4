Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5873A6FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFVRJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjFVRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:09:33 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1723DB7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:09:32 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id B5B46240027
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 19:09:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687453770; bh=gK01his0toQC/praF8orw9fUGx6SIOWBWWw4rlGAy/w=;
        h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Disposition:From;
        b=q42Ay8JTS/STxFaykZ/L/P7FN4wqFpUB/FJYVAr8Rd5KnBfDuF23zlqUakRwbIxst
         +3VkbEaI1z6whylmepQa+mWCx9cCZBqwkeJyX9dO8jQQ3e0mzUcR58smI8xac9RB16
         2Pd+r2H52X0LRYwmf9eQsfo6B+eIo5yzUyeNniSahsK3H2GwOSpdDHAqpQxFfWP6cO
         FuTFpXvKBmDo0j11XNVoVI+V3jYtFl5WxUthoUdU+QSpKptu2jfuydatIVtNDeWeey
         zWa9OpC5j0OTq0xXigsl4leiu/2YNxHuqcCnu9BtdEyua8QAvQ/GcmJWaO3VtHY00L
         gUbjb1BXkntAQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Qn6L218TKz6tvk;
        Thu, 22 Jun 2023 19:09:30 +0200 (CEST)
Date:   Thu, 22 Jun 2023 17:09:28 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH v2] hwmon: corsair-psu: add support for reading PWM values
 and mode
Message-ID: <ZJSASByXpzoZ0XyH@monster.localdomain>
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

Also updates the documentation accordingly.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v2:
  - removed cleanup and typo fixes, sticking to feature adding only
---
 Documentation/hwmon/corsair-psu.rst |  2 +
 drivers/hwmon/corsair-psu.c         | 62 ++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
index c389bd21f4f2..fc798c3df1d0 100644
--- a/Documentation/hwmon/corsair-psu.rst
+++ b/Documentation/hwmon/corsair-psu.rst
@@ -69,6 +69,8 @@ power1_input		Total power usage
 power2_input		Power usage of the 12v psu rail
 power3_input		Power usage of the 5v psu rail
 power4_input		Power usage of the 3.3v psu rail
+pwm1			PWM value, read only
+pwm1_enable		PWM mode, read only
 temp1_input		Temperature of the psu vrm component
 temp1_crit		Temperature max cirtical value of the psu vrm component
 temp2_input		Temperature of the psu case
diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
index dc24c566d08b..2389f605ca16 100644
--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -58,7 +58,8 @@
 #define OCP_MULTI_RAIL		0x02
 
 #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
-#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
+#define PSU_CMD_FAN_PWM		0x3B /* the rest of the commands expect length 3 */
+#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40
 #define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
 #define PSU_CMD_RAIL_AMPS_HCRIT	0x46
 #define PSU_CMD_TEMP_HCRIT	0x4F
@@ -76,6 +77,7 @@
 #define PSU_CMD_UPTIME		0xD2
 #define PSU_CMD_OCPMODE		0xD8
 #define PSU_CMD_TOTAL_WATTS	0xEE
+#define PSU_CMD_FAN_PWM_ENABLE	0xF0
 #define PSU_CMD_INIT		0xFE
 
 #define L_IN_VOLTS		"v_in"
@@ -145,6 +147,14 @@ static int corsairpsu_linear11_to_int(const u16 val, const int scale)
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
@@ -264,6 +274,24 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
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
@@ -349,6 +377,18 @@ static umode_t corsairpsu_hwmon_fan_is_visible(const struct corsairpsu_data *pri
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
@@ -416,6 +456,8 @@ static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sens
 		return corsairpsu_hwmon_temp_is_visible(priv, attr, channel);
 	case hwmon_fan:
 		return corsairpsu_hwmon_fan_is_visible(priv, attr, channel);
+	case hwmon_pwm:
+		return corsairpsu_hwmon_pwm_is_visible(priv, attr, channel);
 	case hwmon_power:
 		return corsairpsu_hwmon_power_is_visible(priv, attr, channel);
 	case hwmon_in:
@@ -447,6 +489,20 @@ static int corsairpsu_hwmon_temp_read(struct corsairpsu_data *priv, u32 attr, in
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
@@ -531,6 +587,8 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
 		if (attr == hwmon_fan_input)
 			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
 		return -EOPNOTSUPP;
+	case hwmon_pwm:
+		return corsairpsu_hwmon_pwm_read(priv, attr, channel, val);
 	case hwmon_power:
 		return corsairpsu_hwmon_power_read(priv, attr, channel, val);
 	case hwmon_in:
@@ -579,6 +637,8 @@ static const struct hwmon_channel_info * const corsairpsu_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
 	HWMON_CHANNEL_INFO(fan,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
 	HWMON_CHANNEL_INFO(power,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL,
-- 
2.41.0

