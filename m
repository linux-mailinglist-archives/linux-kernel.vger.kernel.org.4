Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40606CC470
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbjC1PFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjC1PFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:05:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E47EB63
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:46 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so4330638wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1680015818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOMsSAwCIa8BFHDhgS4zqD3/u9bUaW/8QybvTpBaQmE=;
        b=d56Zz8LGPEnb5KUkvkHhKjzllTpdhYM/Zcnui/LE9lYSV6bJIQ6nuBVzER9AZwzoEL
         ynbWzJR8DWKgfOL9htGbgZP5pHqb9eSyCAXtQ4N8pdFHDC+fNjqMYQMQNYpqXozt2cio
         H0kz6u/3ERov2rU3FqMtLtSovIJkxHTIapn2BFc5azvogN/PRG1W9kRHyKVC90jXNbRK
         zcctjbs9eFHjY8atRFVLvo6eIVZWXzm4h/xhzxIzmH87MZ3+CMX8TnOc7htJ4J0JOmWr
         aA1ZwMhnMDfPSB1gu85yd7CQmgu6f4N0ZDAs3qU2Jve20tzZFevR4p9zbE8TAsuLWmvw
         GKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOMsSAwCIa8BFHDhgS4zqD3/u9bUaW/8QybvTpBaQmE=;
        b=K4YSoFvc6wXkPHl9EYqG82/nmjNEIuyMj96MwWH8IvXEzdoXoPk1w4HHQSWKBL/4TW
         zxdyg7z9eWz+dIarbHWfZEj3g3m4ITFCzF26/0gaHrLC/KbwpaGUfZbbI9YTGvgBUf3L
         xkkGAIjPL7F+UAvFiKhqXNiPRwfwdIo6VoqPJtEYWd7m6pV5E7GApf+QC3K8BCVkHZw5
         ARRZDbm9MjInsXArlo/3nfTrsDt20woi5Mp6qEaPnnSGdSPCYe9o8xmXSGyjDiObWPmQ
         NY75kNoZp0C46GqeOGkWMDsGnrwG44A/RfDOzSpGVFRXC+Kw1a4+3BD5ZljRfEA9yag6
         8GFw==
X-Gm-Message-State: AO0yUKX888JvGtohSyu+p/K+jFlF+WSRw43wwxBdwpWnCUnRMeJADyRR
        mkL6oymKLLml7QKQQ8U3oU+D0Q==
X-Google-Smtp-Source: AK7set/ceOSdFcqJgAuGnfupgeL/+F+cMO6E0rMvZT3NeIWsJKES9QAEzXJp+hwt0ZNcZY1+AVLTAQ==
X-Received: by 2002:a05:600c:ad0:b0:3ed:abb9:7515 with SMTP id c16-20020a05600c0ad000b003edabb97515mr13151196wmr.11.1680015818611;
        Tue, 28 Mar 2023 08:03:38 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c224200b003ee63fe5203sm17429293wmm.36.2023.03.28.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:03:38 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
Date:   Tue, 28 Mar 2023 17:03:34 +0200
Message-Id: <20230328150335.90238-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/hwmon/pmbus/pmbus_core.c | 74 +++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 25 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index d93405f1a495..509bc0ef1706 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2693,9 +2693,9 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	return 0;
 }
 
-/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* and REGULATOR_EVENTS_* flag */
 struct pmbus_status_assoc {
-	int pflag, rflag;
+	int pflag, rflag, eflag;
 };
 
 /* PMBus->regulator bit mappings for a PMBus status register */
@@ -2710,27 +2710,36 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
 		.func = PMBUS_HAVE_STATUS_VOUT,
 		.reg = PMBUS_STATUS_VOUT,
 		.bits = (const struct pmbus_status_assoc[]) {
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
 		.bits = (const struct pmbus_status_assoc[]) {
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
 		.bits = (const struct pmbus_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
+			{ PB_TEMP_OT_WARNING,    REGULATOR_ERROR_OVER_TEMP_WARN,
+			REGULATOR_EVENT_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP,
+			REGULATOR_EVENT_OVER_TEMP },
 			{ },
 		},
 	},
@@ -2790,7 +2799,7 @@ static void pmbus_notify(struct pmbus_data *data, int page, int reg, int flags)
 }
 
 static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
-			    bool notify)
+			   unsigned int *event, bool notify)
 {
 	int i, status;
 	const struct pmbus_status_category *cat;
@@ -2800,6 +2809,7 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 	int func = data->info->func[page];
 
 	*flags = 0;
+	*event = 0;
 
 	for (i = 0; i < ARRAY_SIZE(pmbus_status_flag_map); i++) {
 		cat = &pmbus_status_flag_map[i];
@@ -2810,10 +2820,11 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 		if (status < 0)
 			return status;
 
-		for (bit = cat->bits; bit->pflag; bit++) {
-			if (status & bit->pflag)
+		for (bit = cat->bits; bit->pflag; bit++)
+			if (status & bit->pflag) {
 				*flags |= bit->rflag;
-		}
+				*event |= bit->eflag;
+			}
 
 		if (notify && status)
 			pmbus_notify(data, page, cat->reg, status);
@@ -2834,20 +2845,28 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 		return status;
 
 	if (_pmbus_is_enabled(dev, page)) {
-		if (status & PB_STATUS_OFF)
+		if (status & PB_STATUS_OFF) {
 			*flags |= REGULATOR_ERROR_FAIL;
+			*event |= REGULATOR_EVENT_FAIL;
+		}
 
-		if (status & PB_STATUS_POWER_GOOD_N)
+		if (status & PB_STATUS_POWER_GOOD_N) {
 			*flags |= REGULATOR_ERROR_REGULATION_OUT;
+			*event |= REGULATOR_EVENT_REGULATION_OUT;
+		}
 	}
 	/*
 	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
 	 * defined strictly as fault indicators (not warnings).
 	 */
-	if (status & PB_STATUS_IOUT_OC)
+	if (status & PB_STATUS_IOUT_OC) {
 		*flags |= REGULATOR_ERROR_OVER_CURRENT;
-	if (status & PB_STATUS_VOUT_OV)
+		*event |= REGULATOR_EVENT_OVER_CURRENT;
+	}
+	if (status & PB_STATUS_VOUT_OV) {
 		*flags |= REGULATOR_ERROR_REGULATION_OUT;
+		*event |= REGULATOR_EVENT_FAIL;
+	}
 
 	/*
 	 * If we haven't discovered any thermal faults or warnings via
@@ -2855,19 +2874,22 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
 	 * a (conservative) best-effort interpretation.
 	 */
 	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
-	    (status & PB_STATUS_TEMPERATURE))
+	    (status & PB_STATUS_TEMPERATURE)) {
 		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
+		*event |= REGULATOR_EVENT_OVER_TEMP_WARN;
+	}
+
 
 	return 0;
 }
 
 static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flags,
-					  bool notify)
+					  unsigned int *event, bool notify)
 {
 	int ret;
 
 	mutex_lock(&data->update_lock);
-	ret = _pmbus_get_flags(data, page, flags, notify);
+	ret = _pmbus_get_flags(data, page, flags, event, notify);
 	mutex_unlock(&data->update_lock);
 
 	return ret;
@@ -2911,8 +2933,9 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
 	struct device *dev = rdev_get_dev(rdev);
 	struct i2c_client *client = to_i2c_client(dev->parent);
 	struct pmbus_data *data = i2c_get_clientdata(client);
+	int event;
 
-	return pmbus_get_flags(data, rdev_get_id(rdev), flags, false);
+	return pmbus_get_flags(data, rdev_get_id(rdev), flags, &event, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3152,10 +3175,11 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, status;
+
+	int i, status, event;
 	mutex_lock(&data->update_lock);
 	for (i = 0; i < data->info->pages; i++)
-		_pmbus_get_flags(data, i, &status, true);
+		_pmbus_get_flags(data, i, &status, &event, true);
 
 	pmbus_clear_faults(client);
 	mutex_unlock(&data->update_lock);
-- 
2.39.1

