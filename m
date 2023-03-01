Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FAB6A7178
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCAQpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjCAQo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:44:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC8D41B40
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:44:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso11895496wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1677689094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azKX1lyv7tMs1R7K/ve0RJJDzM9elnW553diWuTLooQ=;
        b=dnjnCngKPOMhT2j4ysiutT5Xga5rCcF3eGxhgGH3hWplFQWcUI2lHbTMyAIvSCtGrt
         FHl166M+CbINjuE0/vtrsz8obGbpUrhYL2fxY6RukL7i2435MEUxnJaWwgSbs4bexPpS
         jxei/lZoBOnN9nwmr4fG7CEz07ZfMjBPx0MfWCDMMqcfZ3L0jPxIGCOJh7p9cRHZvPbe
         LP0Y8wut765vDx6zp/WP89Y1biJmVWe2OonuYA5aTAMIoSHEBUzGJFi+aEvcHP3piEiT
         mQeMwkhgVPXmL3E1Zc5+0A308p8YJrQR2uP2ugYeaKpoQ3phjCIvPYWFGgTUXlwqmM3d
         5fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azKX1lyv7tMs1R7K/ve0RJJDzM9elnW553diWuTLooQ=;
        b=MxnGNCz9pZwjgGYB6o+Z6gEYs0vIOHewlqae/mgLkhGsNYOzhMMSiIy036lXncshf/
         K3LTE2C/q5QHSxTIBwmTjJdR67H+pL9qkPpsUdU4Mqk9k4E6xJoAYdQCOtvXbL+6E0NH
         DfwNGqaAa9JfTSgJmJ5yrmaogZbqeNe6xwTBD1/Z0rWP0O3PnhKvcfvzHuqKrxbsCq/x
         18hq1RwSE1EDT8dcCaueApie28MYKnD8eOR0EVU5Ue2ENkIOqtazuJGViTQ9AK9GZcUf
         uy9h2x4j1iwtlIjt7NHd8wY5BwzjPnDiEoCcJ0SKAIo+ziURVezrslb3tCNnrqQyJJRx
         QcWw==
X-Gm-Message-State: AO0yUKWcUy60S7EFt7KKsup8MxFzoz0tYYDncV7OCbPmFmvsbLAz6ezp
        ySGC7G0Q6zE0a9dODjylT3p3Dg==
X-Google-Smtp-Source: AK7set+htUG7Xzgq5EG5XhiYoJmGuUSdC5B2bHFQO7tXvbcc3ZtzrNqdDQBz7UuNl0vRl9Kkm+vS3g==
X-Received: by 2002:a05:600c:3417:b0:3eb:38e6:f650 with SMTP id y23-20020a05600c341700b003eb38e6f650mr5024079wmp.41.1677689094308;
        Wed, 01 Mar 2023 08:44:54 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcde8000000b003dc521f336esm105542wmj.14.2023.03.01.08.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 08:44:54 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] hwmon: (pmbus/core) Generalise pmbus get status
Date:   Wed,  1 Mar 2023 17:44:32 +0100
Message-Id: <20230301164434.1928237-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
References: <20230301164434.1928237-1-Naresh.Solanki@9elements.com>
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

Add function pmbus get status that can be used to get both pmbus
specific status & regulator status

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
...
Change in V4
- None
Changes in V3:
- Add pmbus_is_enabled function
Changes in V2:
- Add __maybe attribute for pmbus_get_status function
- Remove unrelated changes
---
 drivers/hwmon/pmbus/pmbus_core.c | 98 ++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 36 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 1b70cf3be313..f8ac9016ea0e 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2735,18 +2735,12 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 	},
 };
 
-#if IS_ENABLED(CONFIG_REGULATOR)
-static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
+static int _pmbus_is_enabled(struct device *dev, u8 page)
 {
-	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	u8 page = rdev_get_id(rdev);
 	int ret;
 
-	mutex_lock(&data->update_lock);
 	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
-	mutex_unlock(&data->update_lock);
 
 	if (ret < 0)
 		return ret;
@@ -2754,58 +2748,38 @@ static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
 	return !!(ret & PB_OPERATION_CONTROL_ON);
 }
 
-static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
+static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
 {
-	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
-	u8 page = rdev_get_id(rdev);
 	int ret;
 
 	mutex_lock(&data->update_lock);
-	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
-				     PB_OPERATION_CONTROL_ON,
-				     enable ? PB_OPERATION_CONTROL_ON : 0);
+	ret = _pmbus_is_enabled(dev, page);
 	mutex_unlock(&data->update_lock);
 
-	return ret;
-}
-
-static int pmbus_regulator_enable(struct regulator_dev *rdev)
-{
-	return _pmbus_regulator_on_off(rdev, 1);
-}
-
-static int pmbus_regulator_disable(struct regulator_dev *rdev)
-{
-	return _pmbus_regulator_on_off(rdev, 0);
+	return !!(ret & PB_OPERATION_CONTROL_ON);
 }
 
-static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
 {
 	int i, status;
 	const struct pmbus_status_category *cat;
 	const struct pmbus_status_assoc *bit;
-	struct device *dev = rdev_get_dev(rdev);
-	struct i2c_client *client = to_i2c_client(dev->parent);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	u8 page = rdev_get_id(rdev);
+	struct device *dev = data->dev;
+	struct i2c_client *client = to_i2c_client(dev);
 	int func = data->info->func[page];
 
 	*flags = 0;
 
-	mutex_lock(&data->update_lock);
-
 	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
 		cat = &pmbus_status_flag_map[i];
 		if (!(func & cat->func))
 			continue;
 
 		status = _pmbus_read_byte_data(client, page, cat->reg);
-		if (status < 0) {
-			mutex_unlock(&data->update_lock);
+		if (status < 0)
 			return status;
-		}
 
 		for (bit = cat->bits; bit->pflag; bit++) {
 			if (status & bit->pflag)
@@ -2823,11 +2797,10 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	 * REGULATOR_ERROR_<foo>_WARN.
 	 */
 	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
-	mutex_unlock(&data->update_lock);
 	if (status < 0)
 		return status;
 
-	if (pmbus_regulator_is_enabled(rdev)) {
+	if (_pmbus_is_enabled(dev, page)) {
 		if (status & PB_STATUS_OFF)
 			*flags |= REGULATOR_ERROR_FAIL;
 
@@ -2855,6 +2828,59 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	return 0;
 }
 
+static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags)
+{
+	int ret;
+
+	mutex_lock(&data->update_lock);
+	ret = _pmbus_get_flags(data, page, flags);
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_REGULATOR)
+static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	return pmbus_is_enabled(rdev_get_dev(rdev), rdev_get_id(rdev));
+}
+
+static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	u8 page = rdev_get_id(rdev);
+	int ret;
+
+	mutex_lock(&data->update_lock);
+	ret = pmbus_update_byte_data(client, page, PMBUS_OPERATION,
+				     PB_OPERATION_CONTROL_ON,
+				     enable ? PB_OPERATION_CONTROL_ON : 0);
+	mutex_unlock(&data->update_lock);
+
+	return ret;
+}
+
+static int pmbus_regulator_enable(struct regulator_dev *rdev)
+{
+	return _pmbus_regulator_on_off(rdev, 1);
+}
+
+static int pmbus_regulator_disable(struct regulator_dev *rdev)
+{
+	return _pmbus_regulator_on_off(rdev, 0);
+}
+
+static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct device *dev = rdev_get_dev(rdev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags);
+}
+
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
 {
 	struct device *dev = rdev_get_dev(rdev);
-- 
2.39.1

