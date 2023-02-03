Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9553768A63C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 23:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjBCWdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 17:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBCWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 17:33:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB6D10E0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 14:32:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso9075546pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 14:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KIdZ7FQp9WFTcmd+jowSgslxPLIVkG0vSbFmJ235qqw=;
        b=m9jAEaldtO4AZBtXqDt7qkeAjcFqfa90qunaOGMNKpdP1lNdIfj568JAzwdyLXmdXe
         pX5SmCIXCFoTl0YygVvfrwRiecqiswSSBFkWrwEfW2nK05GgC0FNIc4ISNpZaxBDNqxM
         jIbNuiNYUgEnHyb+jE9RCgkNVwHX/pPSYri7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIdZ7FQp9WFTcmd+jowSgslxPLIVkG0vSbFmJ235qqw=;
        b=YsqwJpY1PfqWW6dHOA0KsSjWuqrPUHsoK0X6gywtm0aQJdnIrEtQVmVJRIdIQXynGB
         ajqmX7zsWlmApFzEZ2T+L303U6zrVjNEsLcUA1whsuurLQp1ejKSPPqeNqSkhvWRelZ9
         wNvyP/ByMj9uQDKM342+sgM+BLKRjAXR4QRRP93LSG6xFw+eTFyIEr6pMQQxpxe67vOD
         Po4Be4Ksy4kEm4+25mtKuvAblm3SxxnqjzbYi2xc3dipV5A/GY1zg7jRNssGCfxQFr+H
         Auyh7mm54D6fyumQZLOkheQLIQHHUXlV76h4Nw54tFKXc440CYRPPqtuIU5fw9+JtMfY
         Wc9g==
X-Gm-Message-State: AO0yUKXX761HQMwl3LF/HOGj6OkOtFzdyldRaE0ADZQFlajN0PMyDCZ2
        ztKJKAI86CcXG6ZHEnPaHG0/bA==
X-Google-Smtp-Source: AK7set/HdcI/AGIBijxjYM48MuXrER5cMM6a8hF2DZ6Pad+mku9va1s8mR5BWBrNkcrfkRqzBGnkLQ==
X-Received: by 2002:a17:903:1210:b0:192:90e7:41d5 with SMTP id l16-20020a170903121000b0019290e741d5mr14335993plh.52.1675463575865;
        Fri, 03 Feb 2023 14:32:55 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x2-20020a1709027c0200b0019472226769sm2088379pll.251.2023.02.03.14.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 14:32:55 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] lm85: Bounds check to_sensor_dev_attr()->index usage
Date:   Fri,  3 Feb 2023 22:32:53 +0000
Message-Id: <20230203223250.gonna.713-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15718; h=from:subject:message-id; bh=ZouD4Z3Ww372Dpxgk/0f1RnmY3+v5/1iNPuY8rOBBR0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj3YuVotP5/5IGPMz5ZgGZU/d1fLrxdNIBezFeTOB+ luULk0yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY92LlQAKCRCJcvTf3G3AJshcEA CPIy2c428GTh2P9Vz8jfq8dyIALk5aDiFb+wtNTJ6/qpEzcMWHUQ/HCJp6w88pylvgdcNQgN/ijx5y 0kJMwEQ7lhUnV469ZeVIpM/xOPlRKqRCGKOD31jARiX3/b2Jcu0XUkac6RsRSpUgH3muSt6mFsz8L7 VBG18b0i+eZznEIjUo6GVv3jp8EH/mxG43pZZPLz2DO/vY77/X1WY0IGAvTP2MYRacp6EnmT+4RvXb /KufqyPEUd7eebvLBPRjnbQRdsnUSTDEsj9ZxxzmxjfHdXefodXxo32T13/sO0eoqEKm19bGHGWR/W /DNepx1/F3+TQ3ggDB4OtZEEt12SGXRpYxgSumI1U0pEY/lA8dc9s2TyJ4Xd9kitWoAxjQ6r23tvrI pdUv1qVggA2Hz3IYnzTf5sQSLEUeuBffBaAur3km+Du+2lbuvDXYtFa5FcP1zm7qQNzIVDm7f5vfyO 5gGS8P5+0g6fbJoMzCmQt4a3gxlXCs3GHmNDXVdh3TrV4ApR+4mo1qWnS2CXjZONKIQLet0Yv+lrCO WvgRUEu90KNy/n9SWSyEsLF6gCh10buMUjHNa2XHFHwv4Lzg20Err3Z3H6/cDWzJloFEF46I8NWI31 OMrdjNLGbJjSGA1tx+xWizTxwGkeoK/vKjqVelthIq9a/W9I0oOENC9P13WQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index into various register arrays was not bounds checked. Provide a
simple wrapper to bounds check the index, adding robustness in the face
of memory corruption, unexpected index manipulation, etc. Noticed under
GCC 13 with -Warray-bounds:

drivers/hwmon/lm85.c: In function 'pwm_auto_pwm_minctl_store':
drivers/hwmon/lm85.c:1110:26: warning: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Warray-bounds=]
 1110 |         if (data->autofan[nr].min_off)
      |             ~~~~~~~~~~~~~^~~~
drivers/hwmon/lm85.c:317:29: note: while referencing 'autofan'
  317 |         struct lm85_autofan autofan[3];
      |                             ^~~~~~~

Additionally fix a comment indentation and a coding style issue of
a missing space before the { in the struct sensor_device_attribute
definition.

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: create a common helper for bounds checking
v1: https://lore.kernel.org/linux-hardening/20230127223744.never.113-kees@kernel.org/
---
 drivers/hwmon/lm85.c        | 77 +++++++++++++++++++++----------------
 include/linux/hwmon-sysfs.h |  2 +-
 2 files changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8d33c2484755..3cb04e4138b8 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -318,6 +318,15 @@ struct lm85_data {
 	struct lm85_zone zone[3];
 };
 
+#define get_sensor_index(attr, array)				\
+({								\
+	unsigned int _nr = to_sensor_dev_attr(attr)->index;	\
+								\
+	if (WARN_ON_ONCE(_nr >= ARRAY_SIZE(array)))		\
+		_nr = 0;					\
+	_nr;							\
+})
+
 static int lm85_read_value(struct i2c_client *client, u8 reg)
 {
 	int res;
@@ -552,16 +561,16 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->fan);
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr]));
 }
 
 static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->fan_min);
 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr]));
 }
 
@@ -569,8 +578,8 @@ static ssize_t fan_min_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->fan_min);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
@@ -683,16 +692,16 @@ static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 13);
 static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->pwm);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
 }
 
 static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->pwm);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
@@ -711,8 +720,8 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
 static ssize_t pwm_enable_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	int pwm_zone, enable;
 
 	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
@@ -734,8 +743,8 @@ static ssize_t pwm_enable_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	struct i2c_client *client = data->client;
 	u8 config;
 	unsigned long val;
@@ -777,8 +786,8 @@ static ssize_t pwm_enable_store(struct device *dev,
 static ssize_t pwm_freq_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->pwm_freq);
 	int freq;
 
 	if (IS_ADT7468_HFPWM(data))
@@ -794,8 +803,8 @@ static ssize_t pwm_freq_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->pwm_freq);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
@@ -843,8 +852,8 @@ static SENSOR_DEVICE_ATTR_RW(pwm3_freq, pwm_freq, 2);
 static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->in);
 	return sprintf(buf, "%d\n", INSEXT_FROM_REG(nr, data->in[nr],
 						    data->in_ext[nr]));
 }
@@ -852,16 +861,16 @@ static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->in);
 	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_min[nr]));
 }
 
 static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->in_min);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -880,16 +889,16 @@ static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
 static ssize_t in_max_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->in_max);
 	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_max[nr]));
 }
 
 static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->in_max);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -935,8 +944,8 @@ static SENSOR_DEVICE_ATTR_RW(in7_max, in_max, 7);
 static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->temp);
 	return sprintf(buf, "%d\n", TEMPEXT_FROM_REG(data->temp[nr],
 						     data->temp_ext[nr]));
 }
@@ -944,8 +953,8 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 static ssize_t temp_min_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->temp_min);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
 }
 
@@ -953,8 +962,8 @@ static ssize_t temp_min_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->temp_min);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -976,8 +985,8 @@ static ssize_t temp_min_store(struct device *dev,
 static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->temp_max);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
 }
 
@@ -985,8 +994,8 @@ static ssize_t temp_max_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->temp_max);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -1021,8 +1030,8 @@ static ssize_t pwm_auto_channels_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	return sprintf(buf, "%d\n", ZONE_FROM_REG(data->autofan[nr].config));
 }
 
@@ -1030,8 +1039,8 @@ static ssize_t pwm_auto_channels_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -1052,8 +1061,8 @@ static ssize_t pwm_auto_channels_store(struct device *dev,
 static ssize_t pwm_auto_pwm_min_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	return sprintf(buf, "%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
 }
 
@@ -1061,8 +1070,8 @@ static ssize_t pwm_auto_pwm_min_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
@@ -1083,8 +1092,8 @@ static ssize_t pwm_auto_pwm_minctl_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	return sprintf(buf, "%d\n", data->autofan[nr].min_off);
 }
 
@@ -1092,8 +1101,8 @@ static ssize_t pwm_auto_pwm_minctl_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->autofan);
 	struct i2c_client *client = data->client;
 	u8 tmp;
 	long val;
@@ -1130,8 +1139,8 @@ static ssize_t temp_auto_temp_off_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
 		HYST_FROM_REG(data->zone[nr].hyst));
 }
@@ -1140,8 +1149,8 @@ static ssize_t temp_auto_temp_off_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	struct i2c_client *client = data->client;
 	int min;
 	long val;
@@ -1170,8 +1179,8 @@ static ssize_t temp_auto_temp_min_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit));
 }
 
@@ -1179,8 +1188,8 @@ static ssize_t temp_auto_temp_min_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
@@ -1194,7 +1203,7 @@ static ssize_t temp_auto_temp_min_store(struct device *dev,
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
 
-/* Update temp_auto_max and temp_auto_range */
+	/* Update temp_auto_max and temp_auto_range */
 	data->zone[nr].range = RANGE_TO_REG(
 		TEMP_FROM_REG(data->zone[nr].max_desired) -
 		TEMP_FROM_REG(data->zone[nr].limit));
@@ -1210,8 +1219,8 @@ static ssize_t temp_auto_temp_max_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
 		RANGE_FROM_REG(data->zone[nr].range));
 }
@@ -1220,8 +1229,8 @@ static ssize_t temp_auto_temp_max_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	struct i2c_client *client = data->client;
 	int min;
 	long val;
@@ -1247,8 +1256,8 @@ static ssize_t temp_auto_temp_crit_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].critical));
 }
 
@@ -1256,8 +1265,8 @@ static ssize_t temp_auto_temp_crit_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
+	unsigned int nr = get_sensor_index(attr, data->zone);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
index d896713359cd..f0505d10bfad 100644
--- a/include/linux/hwmon-sysfs.h
+++ b/include/linux/hwmon-sysfs.h
@@ -10,7 +10,7 @@
 #include <linux/device.h>
 #include <linux/kstrtox.h>
 
-struct sensor_device_attribute{
+struct sensor_device_attribute {
 	struct device_attribute dev_attr;
 	int index;
 };
-- 
2.34.1

