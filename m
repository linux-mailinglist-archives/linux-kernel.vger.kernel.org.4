Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E064323C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiLETZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiLETYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:24:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238B52C11A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:19:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so892279ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4I7a1GqXJo8TnUT7+EadFpwe8WXb+46MsnUGIDBeH8=;
        b=TUHSjLLuGa7GOd7typuCY1RhKrIUaQfEqj18f9tSZ7+XQbIz8InRJHdukCEF/cM/Xl
         YXLyJQPhLeUO2flF9tkHV5ckCe9wM8Cn7x48KV7LxoDoIybO28Px09NJ4oVNZwHVk4Tq
         JI+ztfBKvYowCqm8KyLfHpqRBkQAn/3AfY8UkA3pVp49O1rxESbVjmo9rxTwv7ZrTNoZ
         a8m04+TrRPkABXlb3Rrow5jc1miDkgzcN/mowT4zqGFnGynWnsptW3IeR4t69Q/F56lH
         yOCpwvfdUA9dGOOzAreK6IPqIuVJyrf9cJhU3ucxXbdJRT9Mq2qwP0VAFsVAPsL0czoE
         XC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4I7a1GqXJo8TnUT7+EadFpwe8WXb+46MsnUGIDBeH8=;
        b=MR9FjzxCiYEmf8owTU5PCZS95aj4etla1Zjm2YHvnvMI2MDheCCfVoKNhpp8ST8tVU
         zTqDIvmHkQ23NnK0zTpsVIUUGXGWB+QOSpTCdk6atoLSwFyMSU8LMbL3uOyUX+y3Bjt+
         D34dVAFns1a5RH+MefrRyPoOSWARkKbr+RYrcSy30xkfAuN4Khck6NKf59z1KLITCjUi
         s3buz8Yg8PMVdtUYUkDbyMO/JNikKLeHRizuDpC8R0hamwFL8oc8IahR+q8kpZ6053UN
         mcTQ1setEuMoC6mu9WrMRW2Tg0zs4LKLR2XnwjZKWh33+YQgq75LAl+Vudw7WBHK7YBO
         eZ/w==
X-Gm-Message-State: ANoB5pmDKEnu4Yh0PLkHIhNQOWU9D7ptmYQppEXCVk1Zjf8de5ep2FdV
        6anuQbtFPCLpGs9T/WBmZNmEZg==
X-Google-Smtp-Source: AA0mqf4YuOPV4uAnSrfJjttM6ekc9EDG8jik0lDo5HNJq+Nu9RD3A1iMchlIad6bOo+jYRvG9oAVSA==
X-Received: by 2002:a17:906:5a94:b0:7bc:34d3:31fe with SMTP id l20-20020a1709065a9400b007bc34d331femr43514132ejq.427.1670267987737;
        Mon, 05 Dec 2022 11:19:47 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t16-20020aa7db10000000b0045cf4f72b04sm112739eds.94.2022.12.05.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:19:47 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v6 4/5] hwmon: (pmbus/core): Add regulator event support
Date:   Mon,  5 Dec 2022 20:19:15 +0100
Message-Id: <20221205191917.2614603-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221205191917.2614603-1-Naresh.Solanki@9elements.com>
References: <20221205191917.2614603-1-Naresh.Solanki@9elements.com>
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

Add regulator events corresponding to regulator error in regulator flag
map.
Also capture the same in pmbus_regulator_get_flags.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 69 +++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index afd98e639b4f..22176f266891 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2739,9 +2739,9 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
-/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* and REGULATOR_EVENTS_* flag */
 struct pmbus_regulator_status_assoc {
-	int pflag, rflag;
+	int pflag, rflag, eflag;
 };
 
 /* PMBus->regulator bit mappings for a PMBus status register */
@@ -2756,27 +2756,36 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 		.func = PMBUS_HAVE_STATUS_VOUT,
 		.reg = PMBUS_STATUS_VOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
+			REGULATOR_EVENT_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_IOUT,
 		.reg = PMBUS_STATUS_IOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_WARNING,   REGULATOR_ERROR_OVER_CURRENT_WARN,
+			REGULATOR_EVENT_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,     REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,  REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_TEMP,
 		.reg = PMBUS_STATUS_TEMPERATURE,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN,
+			REGULATOR_EVENT_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP,
+			REGULATOR_EVENT_OVER_TEMP },
 			{ },
 		},
 	},
@@ -2810,7 +2819,7 @@ static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
 }
 
 static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error,
-				    bool notify)
+				    unsigned int *event, bool notify)
 {
 	const struct pmbus_regulator_status_category *cat;
 	const struct pmbus_regulator_status_assoc *bit;
@@ -2819,6 +2828,7 @@ static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error
 	int i, status, ret;
 
 	*error = 0;
+	*event = 0;
 
 	mutex_lock(&data->update_lock);
 
@@ -2833,10 +2843,11 @@ static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error
 			goto unlock;
 		}
 
-		for (bit = cat->bits; bit->pflag; bit++) {
-			if (status & bit->pflag)
+		for (bit = cat->bits; bit->pflag; bit++)
+			if (status & bit->pflag) {
 				*error |= bit->rflag;
-		}
+				*event |= bit->eflag;
+			}
 
 		if (notify && status)
 			pmbus_notify(data, page, cat->reg, status);
@@ -2863,20 +2874,28 @@ static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error
 		goto unlock;
 
 	if (ret & PB_OPERATION_CONTROL_ON) {
-		if (status & PB_STATUS_OFF)
+		if (status & PB_STATUS_OFF) {
 			*error |= REGULATOR_ERROR_FAIL;
+			*event |= REGULATOR_EVENT_FAIL;
+		}
 
-		if (status & PB_STATUS_POWER_GOOD_N)
+		if (status & PB_STATUS_POWER_GOOD_N) {
 			*error |= REGULATOR_ERROR_REGULATION_OUT;
+			*event |= REGULATOR_EVENT_REGULATION_OUT;
+		}
 	}
 	/*
 	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
 	 * defined strictly as fault indicators (not warnings).
 	 */
-	if (status & PB_STATUS_IOUT_OC)
+	if (status & PB_STATUS_IOUT_OC) {
 		*error |= REGULATOR_ERROR_OVER_CURRENT;
-	if (status & PB_STATUS_VOUT_OV)
+		*event |= REGULATOR_EVENT_OVER_CURRENT;
+	}
+	if (status & PB_STATUS_VOUT_OV) {
 		*error |= REGULATOR_ERROR_REGULATION_OUT;
+		*event |= REGULATOR_EVENT_FAIL;
+	}
 
 	/*
 	 * If we haven't discovered any thermal faults or warnings via
@@ -2884,8 +2903,10 @@ static int pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *error
 	 * a (conservative) best-effort interpretation.
 	 */
 	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
-	    (status & PB_STATUS_TEMPERATURE))
+	    (status & PB_STATUS_TEMPERATURE)) {
 		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
+		*event |= REGULATOR_EVENT_OVER_TEMP_WARN;
+	}
 
 unlock:
 	mutex_unlock(&data->update_lock);
@@ -2897,8 +2918,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
+	int event;
 
-	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, &event, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3132,11 +3154,12 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status, ret;
+	int i, status, ret, event;
 
 	for (i = 0; i < data->info->pages; i++) {
 
-		ret = pmbus_get_flags(data, i, &status, true);
+		ret = pmbus_get_flags(data, i, &status, &event, true);
+
 		if (ret)
 			return ret;
 
-- 
2.37.3

