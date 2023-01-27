Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77067F139
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjA0Whz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjA0Whw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:37:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A2E7D95
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:37:49 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id b6so4121425pgi.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afSBN2WLU8TH2R54aYsGkONjyBb20pQKuLeFdFxzOFY=;
        b=Fc5aM2yUOdMAMQRze6jmZoF1bIZmtPJ4egT7MQrEdhUQYq58CwoSbofdFl0s2ayCDf
         a2p+yakd3YRwmrGJlHNdZ/HxeCyFqvPRPjCg0QMNP3paTkJxmljxdZEps04D7S6NLEsp
         VrsyK56nAvipQGOVlplnbnFwuaM63Ak0F4vHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afSBN2WLU8TH2R54aYsGkONjyBb20pQKuLeFdFxzOFY=;
        b=T20Vlk61VWOZ4bknI537MF4yArhpUurB8rG9WzXM2I/qeSSudTz7UzbviAyAS7E/4Y
         KfXKh1gFMYTo5cThzqguz+zfxtc59/YwpNJR0KeJO2kvdwS6m8izyUCmXSr77ZofeegC
         Eh82vxK3zDM0fel1ChOAkbCszmMywlSPk6Xz0sDadvQKRpdRkLqB7j+rxmyLbhui6Zeb
         0HIjGYwktV38RsbjpfKQm2i6PoOJN0GtVN97n6OQ05l+uOAlY23zOs6aZoQdXcEInGMZ
         wgtPNlfEyazIaC3hOIwvOOIq4DvK1mCIuxw7KXIuiR41uBBOUnPk6fYhntmAZ5+scTH2
         y6Jw==
X-Gm-Message-State: AFqh2krJHd+zh1NAudEUOCnt2Z4ea2Fv0iAPqpYxUcrqZp0pFo63IiVz
        ijqvh9TrHZSNJeYYer8P4vz4lA==
X-Google-Smtp-Source: AMrXdXvuhemQB9gwEbYvXltByMtin59/fSK1RCH3LKQXPTfHi3l9voPm7FLZpAPI+UmaB43EOFfB8A==
X-Received: by 2002:aa7:8b45:0:b0:58e:151c:f7fe with SMTP id i5-20020aa78b45000000b0058e151cf7femr25140674pfd.4.1674859069279;
        Fri, 27 Jan 2023 14:37:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b005813f365afcsm3064548pfv.189.2023.01.27.14.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:37:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] lm85: Bounds check to_sensor_dev_attr()->index usage
Date:   Fri, 27 Jan 2023 14:37:45 -0800
Message-Id: <20230127223744.never.113-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18993; h=from:subject:message-id; bh=sCkPS7decDESQ/63W0rVQ8sew45pQbK0xHuo51JLPwo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBj1FI5Cf41Ey614xmUDePeKIK7XuEcV8onOPYmRnBB RpzUqg+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY9RSOQAKCRCJcvTf3G3AJmAND/ 42bnIHRAhwuAdzK8aBRcCSudgkyTBktQeVYxWds4mkWDMfcAAFT5oQoj0CfqybPIp70IikN7N6Kz9a +p9gjf7Z8/Q5E76SNeo63P2xBWCLeq2CtskiGHFHZjOMU36Goce2N9kW6fYxyzjYRMhWih2zML/jb/ iAyjnhE5Yyn5W3ixATltXlT9+CguGDRNIdvcNoFK5UuqKHMWQ4tIarXlon5zsutkEk8cghitYXE+Yp jysv79L6G4AX01YSlWCDTXNKZUHUIl1mrdU4QL1/nt6yvliYTdk8K9Q8MRh8B6dMYuxq1a4euAZxpl DzTqSYCT0Ow3ZfnIMX0GNZOoJSfymwStTDEzkKP1rXChLE5p7gucrVRVfN93ue1S3GPstJJ14sLhRz EniuO+CMSj8BUZxywDBYdA+blFlVJaFQygANHmWQR41ErRLn3dJ4tsqC+oKnTGDTeI0sk9bjEja6yD 3sFNDhDodFlg8IvuNk7L8Fe+LbmQbX9mfMANoDBFDINNBIO6ZurE0G6vx/dCBma+RO+lGRSCNSMe+a 3tpqQf6LRkFJN6v/bkhdEB5tzocCphde0kA4GYfMzbf7Ie6/r9acKvQO7KVtS6C9TlRL1rebFFd233 2RWRAI8pnH/zYHUMaCYqw6JtQKy6R6i3UOcgs7H9FDIIFUXnzDUhm7hhzxkw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The index into various register arrays was not bounds checked. Add
checking. Seen under GCC 13:

drivers/hwmon/lm85.c: In function 'pwm_auto_pwm_minctl_store':
drivers/hwmon/lm85.c:1110:26: warning: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Warray-bounds=]
 1110 |         if (data->autofan[nr].min_off)
      |             ~~~~~~~~~~~~~^~~~
drivers/hwmon/lm85.c:317:29: note: while referencing 'autofan'
  317 |         struct lm85_autofan autofan[3];
      |                             ^~~~~~~

Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hwmon/lm85.c        | 221 +++++++++++++++++++++++++++---------
 include/linux/hwmon-sysfs.h |   2 +-
 2 files changed, 167 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 8d33c2484755..367a77660dda 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -552,29 +552,40 @@ static struct lm85_data *lm85_update_device(struct device *dev)
 static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->fan))
+		val = FAN_FROM_REG(data->fan[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->fan_min))
+		val = FAN_FROM_REG(data->fan_min[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t fan_min_store(struct device *dev,
 			     struct device_attribute *attr, const char *buf,
 			     size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->fan_min))
+		return -EINVAL;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
@@ -683,20 +694,27 @@ static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 13);
 static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->pwm))
+		val = PWM_FROM_REG(data->pwm[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->pwm))
+		return -EINVAL;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
@@ -711,11 +729,12 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
 static ssize_t pwm_enable_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	int pwm_zone, enable;
+	int pwm_zone = -1, enable;
 
-	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
+	if (nr < ARRAY_SIZE(data->autofan))
+		pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
 	switch (pwm_zone) {
 	case -1:	/* PWM is always at 100% */
 		enable = 0;
@@ -734,13 +753,16 @@ static ssize_t pwm_enable_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	u8 config;
 	unsigned long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->autofan))
+		return -EINVAL;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
@@ -777,10 +799,13 @@ static ssize_t pwm_enable_store(struct device *dev,
 static ssize_t pwm_freq_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
 	int freq;
 
+	if (nr >= ARRAY_SIZE(data->pwm_freq))
+		return -EINVAL;
+
 	if (IS_ADT7468_HFPWM(data))
 		freq = 22500;
 	else
@@ -794,12 +819,15 @@ static ssize_t pwm_freq_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->pwm_freq))
+		return -EINVAL;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
@@ -843,10 +871,13 @@ static SENSOR_DEVICE_ATTR_RW(pwm3_freq, pwm_freq, 2);
 static ssize_t in_show(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", INSEXT_FROM_REG(nr, data->in[nr],
-						    data->in_ext[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->in))
+		val = INSEXT_FROM_REG(nr, data->in[nr], data->in_ext[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
@@ -854,18 +885,25 @@ static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_min[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->in_min))
+		val = INS_FROM_REG(nr, data->in_min[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->in_min))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -880,20 +918,27 @@ static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
 static ssize_t in_max_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_max[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->in_max))
+		val = INS_FROM_REG(nr, data->in_max[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->in_max))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -935,30 +980,40 @@ static SENSOR_DEVICE_ATTR_RW(in7_max, in_max, 7);
 static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMPEXT_FROM_REG(data->temp[nr],
-						     data->temp_ext[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->temp))
+		val = TEMPEXT_FROM_REG(data->temp[nr], data->temp_ext[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_min_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->temp_min))
+		val = TEMP_FROM_REG(data->temp_min[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_min_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->temp_min))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -976,21 +1031,28 @@ static ssize_t temp_min_store(struct device *dev,
 static ssize_t temp_max_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->temp_max))
+		val = TEMP_FROM_REG(data->temp_max[nr]);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_max_store(struct device *dev,
 			      struct device_attribute *attr, const char *buf,
 			      size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->temp_max))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1021,21 +1083,28 @@ static ssize_t pwm_auto_channels_show(struct device *dev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", ZONE_FROM_REG(data->autofan[nr].config));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->autofan))
+		val = ZONE_FROM_REG(data->autofan[nr].config);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t pwm_auto_channels_store(struct device *dev,
 				       struct device_attribute *attr,
 				       const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->autofan))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1052,21 +1121,28 @@ static ssize_t pwm_auto_channels_store(struct device *dev,
 static ssize_t pwm_auto_pwm_min_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->autofan))
+		val = PWM_FROM_REG(data->autofan[nr].min_pwm);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t pwm_auto_pwm_min_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	unsigned long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->autofan))
+		return -EINVAL;
+
 	err = kstrtoul(buf, 10, &val);
 	if (err)
 		return err;
@@ -1083,22 +1159,29 @@ static ssize_t pwm_auto_pwm_minctl_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", data->autofan[nr].min_off);
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->autofan))
+		val = data->autofan[nr].min_off;
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t pwm_auto_pwm_minctl_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	u8 tmp;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->autofan))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1130,23 +1213,30 @@ static ssize_t temp_auto_temp_off_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
-		HYST_FROM_REG(data->zone[nr].hyst));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->zone))
+		val = TEMP_FROM_REG(data->zone[nr].limit) -
+			HYST_FROM_REG(data->zone[nr].hyst);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_auto_temp_off_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int min;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->zone))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1170,21 +1260,28 @@ static ssize_t temp_auto_temp_min_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->zone))
+		val = TEMP_FROM_REG(data->zone[nr].limit);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_auto_temp_min_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->zone))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1194,7 +1291,7 @@ static ssize_t temp_auto_temp_min_store(struct device *dev,
 	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
 		data->zone[nr].limit);
 
-/* Update temp_auto_max and temp_auto_range */
+	/* Update temp_auto_max and temp_auto_range */
 	data->zone[nr].range = RANGE_TO_REG(
 		TEMP_FROM_REG(data->zone[nr].max_desired) -
 		TEMP_FROM_REG(data->zone[nr].limit));
@@ -1210,23 +1307,30 @@ static ssize_t temp_auto_temp_max_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
-		RANGE_FROM_REG(data->zone[nr].range));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->zone))
+		val = TEMP_FROM_REG(data->zone[nr].limit) +
+			RANGE_FROM_REG(data->zone[nr].range);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_auto_temp_max_store(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	int min;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->zone))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
@@ -1247,21 +1351,28 @@ static ssize_t temp_auto_temp_crit_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].critical));
+	int val = 0;
+
+	if (nr < ARRAY_SIZE(data->zone))
+		val = TEMP_FROM_REG(data->zone[nr].critical);
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_auto_temp_crit_store(struct device *dev,
 					 struct device_attribute *attr,
 					 const char *buf, size_t count)
 {
-	int nr = to_sensor_dev_attr(attr)->index;
+	unsigned int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
 	long val;
 	int err;
 
+	if (nr >= ARRAY_SIZE(data->zone))
+		return -EINVAL;
+
 	err = kstrtol(buf, 10, &val);
 	if (err)
 		return err;
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

