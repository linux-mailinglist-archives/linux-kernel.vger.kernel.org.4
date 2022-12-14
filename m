Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741464C4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbiLNIHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbiLNIH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:07:28 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13BC1EADF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w15so18399830wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 00:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4I7a1GqXJo8TnUT7+EadFpwe8WXb+46MsnUGIDBeH8=;
        b=d2f4tYg1ydCRNbpi9K6fJxUJaAagYBs6CBH5ii7Q0/v2HdNvZpwDB855rUnYjzK10U
         YwmsQlUPlu1Olq1oOtaVCcDvbTb8nZ885T6wBxYNNkEVa+mmbJbVjNSrgU7v6ozMJ4V6
         bAVvbrX4v3UfVodsuFmwQQSqpk4kxRIPPrrsDXEjdxTpDAdlbpyCQACzkAzxh3EVK+Lk
         OLEpHKKtf7gVH4x1wJefIITrI4nRd3cqu0dxHFw8GnNPQkwAkGVfACcn8DeKAUQ9zWaw
         XN7wMv0SNnCm+yBKLcSulbHMPq94eIduM6GZTp+SquA8ymOyU3VK/aD/T+iq7v/+MJQn
         6N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4I7a1GqXJo8TnUT7+EadFpwe8WXb+46MsnUGIDBeH8=;
        b=TjoIg4Gi2wNlHBkFGY885dgyl4jiZwXwPSduU8DLmhT1HtqRGbNbKfM1CkKdmo4P6s
         NNfrJxDPS2xy5waj3yQddP2tr1WVH0Ub9VtsnmPUT/67aW+LgKCVZL128JuSTlaRLqwS
         YPzjA1GB0YXNWYnBn/oXFgwRsG1VozIqzzjOajmV26Hc/E4EQNBGKjSE38P65ww07fPc
         rTqC+ZMuNVygkkvzWPfm8qewZlt1Crbtwsry8o9tXCbT6N+jPU2ItbFKutQRv3C3Qcpd
         kS7hKr0rxy4cIEZYhE/2GnXbYl7O7YqR/qM0PjMcEeHdZ/kfF/upPq9nmobwjv2wnRqa
         mmUg==
X-Gm-Message-State: ANoB5pmPBvnIUl0ocnL0b1QnDs54Xnd2UQrVbtYSNxL1VckXjvP6BUh5
        PSuxgfU0D38gSbkBUhPzf0pyvg==
X-Google-Smtp-Source: AA0mqf4i2Wp0c4O1BDXbnj48O3MA/p8zT40OJQ4M1iD62kmrP0BhY3mQp8xAKtc2Nh7HVmES/ORD1w==
X-Received: by 2002:adf:fd0e:0:b0:242:1926:783d with SMTP id e14-20020adffd0e000000b002421926783dmr18661142wrr.7.1671005245266;
        Wed, 14 Dec 2022 00:07:25 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d5183000000b002422bc69111sm2500781wrv.9.2022.12.14.00.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:07:25 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH RESEND v6 4/5] hwmon: (pmbus/core): Add regulator event support
Date:   Wed, 14 Dec 2022 09:07:14 +0100
Message-Id: <20221214080715.2700442-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
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

