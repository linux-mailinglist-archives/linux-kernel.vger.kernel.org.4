Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEC69705F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjBNWCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B271716A;
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id k3so9604447wrv.5;
        Tue, 14 Feb 2023 14:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhUd31tbYc8/GAz1s1GxERvfWBKhM44LCwYftwbthSU=;
        b=VZUZk0Py67Lk9352uvTnZl5bLCzZmEQzsZPsEDa584Ci1dwNOeFhYj4CQLOGTHXlNb
         v7Ya6kxHvttpMM3EHxn5bTsfVEM2EH3sP5khKoOetjB2HWubOg1hP5VgIeEIOx3Jpuyg
         N/ycHCWg1+CZpsY6eQWwPY7ihLn2e5hf0we7blMsC/xZqR+uGrujphlkFbvidHjLAhcz
         nJ0vf1/qd8Rum3G8ONoBUx/4tO6pQuvfbUsnXLKk+Ud6VbDfK+GB9JJdwMehmsUi1/mR
         PhKzsSCr7X0U1XHrwAl36mazFd1AHLOEVCxhOWeJJ8UuY5mIE0QA1jGm819v1FAQIji+
         qBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhUd31tbYc8/GAz1s1GxERvfWBKhM44LCwYftwbthSU=;
        b=I2ZkByvTyrANVxgDucpPPZ1mz2EeSc1MLnfZs9v1ZAVVO/jrU02C74rGsWnYYyMu4x
         ANZMsFOsxtvGnIc/TSUplqy1GgKL5e3AFK3CWZpwyWWcK/3SJxPrAQllDcqzTq+ssmow
         ouD1wAcSToy4AF2JalHgKJ8Jeyw3JIeEvBLCLwfdLm/cp64npRyu5IhGTgzlQTLzNVPx
         dq+NQ2NiS4iAOO8RvAHFJROFLb/MbhIZnwfJI76jYM1BRuhuJYO9HgfFyYQqyjT/VQiB
         tUCkXR1V3wjbkeaqGvb1Zjt25x1BOlQMvTJmU8BBnaOYkfQB3CtPPRf7lQWzKmhHCxvk
         E1cA==
X-Gm-Message-State: AO0yUKU0QKk/k6AoZEm7yn8sjWPynVH0O2BgmOuPEq8vIAv9LziEbg5h
        46zE3JzmH56u98k7KPvf43503f5Nl9ooHQ==
X-Google-Smtp-Source: AK7set/KmaTI3DeaRfBvkZuIuhTtDhnSI4giJXvtnuT9yOQlX/Uz/NIVlWMsyML3jjYcLd9ECIl2tw==
X-Received: by 2002:adf:f746:0:b0:2c5:5a65:799f with SMTP id z6-20020adff746000000b002c55a65799fmr3356810wrp.34.1676412111368;
        Tue, 14 Feb 2023 14:01:51 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:50 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 1/6] hwmon: (aquacomputer_d5next) Support one byte control values
Date:   Tue, 14 Feb 2023 23:02:16 +0100
Message-Id: <20230214220221.15003-2-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214220221.15003-1-leonard.anderweit@gmail.com>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
MIME-Version: 1.0
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

Add support for one byte control values. This extends aqc_set_ctrl_val() and
aqc_get_ctrl_val() with a type. Currently supported types are AQC_8 (one byte)
and AQC_BE16 (two bytes big endian). More types will be added in the future.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 48 +++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 12682a610ce7..babfd998e70c 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -70,6 +70,10 @@ static u8 secondary_ctrl_report[] = {
 /* Report IDs for legacy devices */
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
+/* Data types for reading and writing control reports */
+#define AQC_8		0
+#define AQC_BE16	1
+
 /* Info, sensor sizes and offsets for most Aquacomputer devices */
 #define AQC_SERIAL_START		0x3
 #define AQC_FIRMWARE_VERSION		0xD
@@ -544,7 +548,7 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 }
 
 /* Refreshes the control buffer and stores value at offset in val */
-static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
+static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val, int type)
 {
 	int ret;
 
@@ -554,14 +558,23 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	*val = (s16)get_unaligned_be16(priv->buffer + offset);
+	switch (type) {
+	case AQC_BE16:
+		*val = (s16)get_unaligned_be16(priv->buffer + offset);
+		break;
+	case AQC_8:
+		*val = priv->buffer[offset];
+		break;
+	default:
+		ret = -EINVAL;
+	}
 
 unlock_and_return:
 	mutex_unlock(&priv->mutex);
 	return ret;
 }
 
-static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
+static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val, int type)
 {
 	int ret;
 
@@ -571,7 +584,19 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	put_unaligned_be16((s16)val, priv->buffer + offset);
+	switch (type) {
+	case AQC_BE16:
+		put_unaligned_be16((s16)val, priv->buffer + offset);
+		break;
+	case AQC_8:
+		priv->buffer[offset] = (u8)val;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret < 0)
+		goto unlock_and_return;
 
 	ret = aqc_send_ctrl_data(priv);
 
@@ -775,7 +800,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		case hwmon_temp_offset:
 			ret =
 			    aqc_get_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
@@ -791,7 +816,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			*val = priv->speed_input[channel];
 			break;
 		case hwmon_fan_pulses:
-			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -804,7 +830,8 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets) {
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
@@ -877,7 +904,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			val = clamp_val(val, -15000, 15000) / 10;
 			ret =
 			    aqc_set_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -889,7 +916,8 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		switch (attr) {
 		case hwmon_fan_pulses:
 			val = clamp_val(val, 10, 1000);
-			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset,
+					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 			break;
@@ -906,7 +934,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 					return pwm_value;
 
 				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
-						       pwm_value);
+						       pwm_value, AQC_BE16);
 				if (ret < 0)
 					return ret;
 			}
-- 
2.39.1

