Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90F637407
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiKXIfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiKXIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:34:55 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FA7DA4D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:34:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso698394wmp.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JW7FLp8EfvNtL1XZPl1vzh58Pu217kjL61ohaey6idw=;
        b=GcCGKg/AY5KiyMo9lr9z+0Of6TgjF2FQsaHsWLYrGL0n8YzhroF3H//kQJXFP9ZZ8M
         q3V/nUxNwc9ZOdrGlpotzenR8KygjjSydZalMmL7pqGRLxXhBJKIXRlzEIr9L9Q8EafA
         +c7LK5LTB72YcsG2smQuF4g8Er2Y1Cka6wT6+9Z+chx62I+s3225b3rImPNtpPEIQC9U
         AwsrwGBgKcgjJUNSTb3KdfsXHJVs5gYT36r0dOvbK4BLs1eDCfatLQP61GZdnNt6enu9
         gOWTFt3iER8MxKSzGzdDgHHlM0vLUt0BCDdqHK/Pc6F0VVUhwYFcKqaRI9bdH9wodf0D
         N8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JW7FLp8EfvNtL1XZPl1vzh58Pu217kjL61ohaey6idw=;
        b=7D5Vv5xT+YLRAcKBk0JFBY6hzFP1oAhYj6wvhCukjMnEyPEk/5HuldHyiVKJ0NkoNT
         KpEjdwCxfk/gBiRQAaPGfkGIeznGj3Pcl0Tbv5RkU2xZilSEpvbuzv25dRkjXHsRi9ZU
         qBQ8sHOUbKs9iBwyuRgUjuwCI+K4+RJq0bWeESlQzaT7K4ubfYr1Gl5V4kyijHTvRUGW
         HSDOXhhNull9UP7R02fe+mP5q6CHd8fKwmSWTfI+2jXlC2nZN5kSSHxrtYX0I6FZvZlA
         wAMRBRnf1cIU4tB3edRymDdMcTv07NpxTGEWH54Aq7VuIKufZvyXf9OaXuU4rlRkk5kd
         Flug==
X-Gm-Message-State: ANoB5pk22Tlf254P7dPMoM8UAijoeLtlnRppHFqgasjKUNgld7KM/QDF
        hF/tgsqiZKpeG2/yrNnmKjGBqtKC4fU50leu
X-Google-Smtp-Source: AA0mqf4vXt6BzOXC8fITrnXJEdxWynPL6TEABGgcuTn/077Jp8MjHSROYmA9JQk/TYDU6Dh/SvKulw==
X-Received: by 2002:a05:600c:3586:b0:3cf:a3b0:df6a with SMTP id p6-20020a05600c358600b003cfa3b0df6amr25923934wmq.126.1669278892794;
        Thu, 24 Nov 2022 00:34:52 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id o5-20020a05600c510500b003b4ff30e566sm10028095wms.3.2022.11.24.00.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 00:34:52 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] hwmon: (pmbus/core): Implement regulator get_status
Date:   Thu, 24 Nov 2022 09:34:39 +0100
Message-Id: <20221124083439.3840025-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add get_status for pmbus_regulator_ops.

---
Changes:
- use lock throughout the function
- Avoid line continuation upto 100 column
- Optimize use of & and | operator
- Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
  respective status register for fault.
- Report regulator current status.
- Utilize get_error_flag to check for regulator errors.
- Check for return value of function get_error_flag

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 20ca26e19db7..0b13214c662f 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2855,6 +2855,49 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int pmbus_regulator_get_status(struct regulator_dev *rdev)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(rdev);
+	int status, ret;
+
+	mutex_lock(&data->update_lock);
+	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
+	if (status < 0) {
+		ret = status;
+		goto unlock;
+	}
+
+	if (status & PB_STATUS_OFF) {
+		ret = REGULATOR_STATUS_OFF;
+		goto unlock;
+	}
+
+	/* If regulator is ON & reports power good then return ON */
+	if (!(status & PB_STATUS_POWER_GOOD_N)) {
+		ret = REGULATOR_STATUS_ON;
+		goto unlock;
+	}
+
+	if (rdev->desc->ops->get_error_flags) {
+		ret = rdev->desc->ops->get_error_flags(rdev, &status);
+		if (ret)
+			goto unlock;
+
+		if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
+		   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL |
+		   REGULATOR_ERROR_OVER_TEMP))
+			ret = REGULATOR_STATUS_ERROR;
+	} else
+		ret = REGULATOR_STATUS_UNDEFINED;
+
+unlock:
+	mutex_unlock(&data->update_lock);
+	return ret;
+}
+
 static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
@@ -2995,6 +3038,7 @@ const struct regulator_ops pmbus_regulator_ops = {
 	.disable = pmbus_regulator_disable,
 	.is_enabled = pmbus_regulator_is_enabled,
 	.get_error_flags = pmbus_regulator_get_error_flags,
+	.get_status = pmbus_regulator_get_status,
 	.get_voltage = pmbus_regulator_get_voltage,
 	.set_voltage = pmbus_regulator_set_voltage,
 	.list_voltage = pmbus_regulator_list_voltage,

base-commit: 2c71b3246ec3246522e8cb7c8191dc7a5d62cc70
-- 
2.37.3

