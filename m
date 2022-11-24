Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418CE637FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 20:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKXTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 14:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKXTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 14:36:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA13C82235
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:36:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so1906022wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJBW1A5y1fTLRdd0u5x23CN10W0jIpZwTzIzusrDHRM=;
        b=U2inWMfGvvDyBsg7W8oSpgwEOh0FopbXURb0S0tmoqjmZTBS02Gu4brPu2P+jzNeMG
         7RIUQId8Gr2/38NzWJEEW1o+HUJ+mUPFY8mi8bRwl6OK2fAsr3lAZX64IteDJlkKIyTv
         DiBEwATvcfTfWQVQ8C5t6EMKTX3jjkDq9eHV1uMzESfVvYxEXFeLCjJ/zrF+mlOoo8vf
         U3KSbYKz4dl2sloSKwV4AVEIDuvDCHmO673QEnVetZ6jjQ9KxgSBKFqycZqZlDWXtmuK
         WVnAPPn41JtIVTH0//4kLqi/N8BhA+LglBD115gboy5a8NqY9wQ3PqAVSFBtqIeAKYq0
         OBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJBW1A5y1fTLRdd0u5x23CN10W0jIpZwTzIzusrDHRM=;
        b=pw6h2gIlxcADhjZZYzlkcb+jQy/3oV82yZ+VQxBwgReAt0kbv8MPyNe+PoB0B81lhY
         hsfrgpNkY9zi0fmz0Uk+4DEWnsKkR7ZIPQwMN3+M2Ka5IQOVrK+dTqVg9K+0UF2+Iu1p
         go+vrR1s1P3dusZ0Db360aqe5RM7ZPy27s/yWEWl56OFSsblqeMJmJiUuvJg1KVVz93v
         XvSSx+zc4VWChzV4wrKtkqxig4DDdiYFnnKE7xJf3eyNVGQ6mIlPpZtc67sHxx+11iZ0
         Sps+8bX9OgsT378UlWwLqgfh03g7w5+tMX/UfQWTNxmdYzhkaRafTymvnSeWVUfw7U/t
         rgrg==
X-Gm-Message-State: ANoB5plNWYRivUVca8RyaRLRw6Oq9G95oFuaKhHUHkAMCAos15i7Mz9u
        xzC4nbbuTMlWWy92SG3xDZGQ+Q==
X-Google-Smtp-Source: AA0mqf5FZX8PiHZbyPRD3b6sK1e6yHLeg4NbBlmiSzgnYz1ZCgXew3tch9mkCyCJXDccpq7LnvjVAw==
X-Received: by 2002:a7b:c4cc:0:b0:3cf:89c5:c241 with SMTP id g12-20020a7bc4cc000000b003cf89c5c241mr23913810wmk.204.1669318611408;
        Thu, 24 Nov 2022 11:36:51 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id u26-20020a7bcb1a000000b003cfd42821dasm2744127wmj.3.2022.11.24.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 11:36:50 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] hwmon: (pmbus/core): Implement regulator get_status
Date:   Thu, 24 Nov 2022 20:36:42 +0100
Message-Id: <20221124193642.4081054-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
- Use function pmbus_regulator_get_error_flags directly

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 20ca26e19db7..95e95783972a 100644
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
+	ret = pmbus_regulator_get_error_flags(rdev, &status);
+	if (ret)
+		goto unlock;
+
+	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
+	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP)) {
+		ret = REGULATOR_STATUS_ERROR;
+		goto unlock;
+	}
+
+	ret = REGULATOR_STATUS_UNDEFINED;
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

