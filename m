Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5963F7DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiLATEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiLATE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:04:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DFC23F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:04:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so4321318wrh.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPhmSuxm5X88P2ytZiq5oi3P9IuH3y0y7Ct9vba+7Q8=;
        b=c1bqYj2TPG5umwPMMfzf4h1SH4bLnNy141cOI4bYRDZjQSILJ6J5ZbePiZHOeG4p3d
         L0O/FB7m5qmMcfIWbjumi6N9zxxpJynM9JCc0CXU/RqtYOSqXuKpq1M1A7ELN9bQjkIL
         2FywXDNvAx60Ty8sbDpxygq1GskzWN710PXcJPGceFoEoQvWjcTjo2VpQ/QCvbkOGkZ6
         RVfq2Qe2lnU3JRqzS4BzYUmv00ej+ViEFKgHPdBzasOk5JPmZH55tAo+dpoztrv6IMSs
         sHrp7DQKbGZBuIl5CN9Rgz5HVCGyrwr6MDzAvvMI4RaVU0Dw51RkULXH4OU8ZelFOtn5
         7Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPhmSuxm5X88P2ytZiq5oi3P9IuH3y0y7Ct9vba+7Q8=;
        b=n7pIAXCsXNyQjavEZ3HhyMaFOjK/i4Du+2+C2o2iAiWtlalic0W4c8JF3+6BmqlhOB
         D6TrhwBuNGJ2CJYJ4GMi74PIU11+k/GR8wJzqTW+opv6GhFjhyPhahlb7ndyOunneBf9
         +MzSDqTe/iq/otazs2CFqGV/uStv8WECbNJAV0RtoPwEpghked+ktTIb4r2ol0BzaVL4
         x7ThmQ/m9on/lrSbxGB7sE/4nRNFgJXYWFuWp/G83FPhofG8HKU545hN2d2yjNYvhrMr
         tO5NM8VFpyf/tC7PSR/7IIvxK/HNxHvGLq1fMa+8imN6H+ghIUJ1ZPAPj2q21dac5AbS
         heVw==
X-Gm-Message-State: ANoB5pk2Oq1GZ9diEef3KNXh83aOtk1kR39Bv4C47lIL0v7brAOeerbV
        Kr95PQRUHT1zS27KLaF7RkQ7bQ==
X-Google-Smtp-Source: AA0mqf6M/lP7jgUDaAjIVF60WBrACA1nSK1WxDmwn5xR48C9VTAJiYNpMj9M0Wf3BDWk9EKOgTBUyA==
X-Received: by 2002:adf:e7cd:0:b0:236:960f:161d with SMTP id e13-20020adfe7cd000000b00236960f161dmr35407082wrn.376.1669921466090;
        Thu, 01 Dec 2022 11:04:26 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm11848474wmq.43.2022.12.01.11.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:04:25 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v4 4/5] hwmon: (pmbus/core): Add regulator event support
Date:   Thu,  1 Dec 2022 20:03:53 +0100
Message-Id: <20221201190354.1512790-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221201190354.1512790-1-Naresh.Solanki@9elements.com>
References: <20221201190354.1512790-1-Naresh.Solanki@9elements.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 85 ++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 78c401412c4d..daf700210c68 100644
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
 
 static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *error,
-				    bool notify)
+				    unsigned int *event, bool notify)
 {
 	int i, status;
 	const struct pmbus_regulator_status_category *cat;
@@ -2821,7 +2830,8 @@ static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *e
 	u8 page = rdev_get_id(rdev);
 	int func = data->info->func[page];
 
-	*flags = 0;
+	*error = 0;
+	*event = 0;
 
 	mutex_lock(&data->update_lock);
 
@@ -2836,10 +2846,11 @@ static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *e
 			return status;
 		}
 
-		for (bit = cat->bits; bit->pflag; bit++) {
-			if (status & bit->pflag)
-				*flags |= bit->rflag;
-		}
+		for (bit = cat->bits; bit->pflag; bit++)
+			if (status & bit->pflag) {
+				*error |= bit->rflag;
+				*event |= bit->eflag;
+			}
 
 		if (notify && status)
 			pmbus_notify(data, page, cat->reg, status);
@@ -2860,36 +2871,48 @@ static int pmbus_regulator_get_flags(struct regulator_dev *rdev, unsigned int *e
 		return status;
 
 	if (pmbus_regulator_is_enabled(rdev)) {
-		if (status & PB_STATUS_OFF)
-			*flags |= REGULATOR_ERROR_FAIL;
+		if (status & PB_STATUS_OFF) {
+			*error |= REGULATOR_ERROR_FAIL;
+			*event |= REGULATOR_EVENT_FAIL;
+		}
 
-		if (status & PB_STATUS_POWER_GOOD_N)
-			*flags |= REGULATOR_ERROR_REGULATION_OUT;
+		if (status & PB_STATUS_POWER_GOOD_N) {
+			*error |= REGULATOR_ERROR_REGULATION_OUT;
+			*event |= REGULATOR_EVENT_REGULATION_OUT;
+		}
 	}
 	/*
 	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
 	 * defined strictly as fault indicators (not warnings).
 	 */
-	if (status & PB_STATUS_IOUT_OC)
-		*flags |= REGULATOR_ERROR_OVER_CURRENT;
-	if (status & PB_STATUS_VOUT_OV)
-		*flags |= REGULATOR_ERROR_REGULATION_OUT;
+	if (status & PB_STATUS_IOUT_OC) {
+		*error |= REGULATOR_ERROR_OVER_CURRENT;
+		*event |= REGULATOR_EVENT_OVER_CURRENT;
+	}
+	if (status & PB_STATUS_VOUT_OV) {
+		*error |= REGULATOR_ERROR_REGULATION_OUT;
+		*event |= REGULATOR_EVENT_FAIL;
+	}
 
 	/*
 	 * If we haven't discovered any thermal faults or warnings via
 	 * PMBUS_STATUS_TEMPERATURE, map PB_STATUS_TEMPERATURE to a warning as
 	 * a (conservative) best-effort interpretation.
 	 */
-	if (!(*flags & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
-	    (status & PB_STATUS_TEMPERATURE))
-		*flags |= REGULATOR_ERROR_OVER_TEMP_WARN;
+	if (!(*error & (REGULATOR_ERROR_OVER_TEMP | REGULATOR_ERROR_OVER_TEMP_WARN)) &&
+	    (status & PB_STATUS_TEMPERATURE)) {
+		*error |= REGULATOR_ERROR_OVER_TEMP_WARN;
+		*event |= REGULATOR_EVENT_OVER_TEMP_WARN;
+	}
 
 	return 0;
 }
 
 static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
 {
-	return pmbus_regulator_get_flags(rdev, flags, false);
+	int event;
+
+	return pmbus_regulator_get_flags(rdev, flags, &event, false);
 }
 
 static int pmbus_regulator_get_status(struct regulator_dev *rdev)
@@ -3124,7 +3147,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 {
 	struct pmbus_data *data = pdata;
 	struct i2c_client *client = to_i2c_client(data->dev);
-	int i, ret = IRQ_NONE, status;
+	int i, ret = IRQ_NONE, status, event;
 	u8 page;
 
 	for (i = 0; i < data->info->num_regulators; i++) {
@@ -3132,7 +3155,7 @@ static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
 		if (!data->rdevs[i])
 			continue;
 
-		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, true);
+		ret = pmbus_regulator_get_flags(data->rdevs[i], &status, &event, true);
 		if (ret)
 			return ret;
 
-- 
2.37.3

