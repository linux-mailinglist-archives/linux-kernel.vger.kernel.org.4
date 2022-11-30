Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEE263DB84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiK3RFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiK3RFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:05:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA593A57
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d1so28122823wrs.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsjaiNcbOnAPHJfNdou87+1m3ymlwlqqUN1bnFhs+to=;
        b=VXKfm9GT2RJzMcTd5Yh71vxzbz1fYLOCc5qdLGU/SCeTHAiHg5CzxhCRCxz0399dlt
         d3JBLqRT7mMJnCi/YBGBD+kpG6e5RbkBmbIwgBcerkD4k/EYvS8dDLOOUxWsc40Shup4
         cWoUfZsx/kCnGrxvwlMe5Va4xahmmvb+jFI6kDHi8dIUJROqaNGEPoDSOVb8lz/O3hC4
         PE6kzym7tFV72p0mrSUnUOINR6+dBO67gi4JSwpRl73a2ZbdXnaoVrvxQqvJXVU/Ux7x
         7BJfXerl4jeuIniDS2pDCaUmZippD0w/H8Lh+5ZKTAyA/HN49ic6eX4wQ0nsWaKJO+LK
         kAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsjaiNcbOnAPHJfNdou87+1m3ymlwlqqUN1bnFhs+to=;
        b=dmWZoREU2faO+t2mZYDNVtknXGPq/2PGU2wkmZXnBOjXyrcNVs5PnMFFp7lLe6BlEH
         hwCBwxYXoRH+FGpjGEVlYsDyWatxxi99csb/O+DuzgHKxUkRfvICrpjQGX7B3IghmiIA
         pBzKXiaNVZdJ3ySYSHVs7Z/FNXpyEHbscyzLVjfwPaxNUQbeDFtjEwlNeE3/f8vkJvQ7
         Xqv0Y1HhNMFOc5vL5sBEosmdxpB7mRe28t6qACJlDYkFDv2+j80yQnxKtsTzU02BPETV
         lq4XS6I494icsxe0KsUvvwOugeCbS24zV7ZGfKJUEDaNROFldmPsKNT2/6iYte8R+oJ8
         3XOA==
X-Gm-Message-State: ANoB5plImAbR44BB9/C/JJuSRAwOJBqVz3nRiCpDuljr2azEW1GoRMHE
        bVeLtj3xwHNmaRc98nW4xrmk4XIX1O4a4vb4
X-Google-Smtp-Source: AA0mqf7hsbed8fdlaMvutAG6fj2UMzC3RSLVjvhGTrpz0IR6PizokXEPfp6sm+wqMEEvQu+J75wIJw==
X-Received: by 2002:a05:6000:70f:b0:22e:41c5:7ef7 with SMTP id bs15-20020a056000070f00b0022e41c57ef7mr1079565wrb.332.1669827609089;
        Wed, 30 Nov 2022 09:00:09 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id fn7-20020a05600c688700b003c6b70a4d69sm2457159wmb.42.2022.11.30.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 09:00:08 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v3 2/4] hwmon: (pmbus/core): Add events to regulator flag map
Date:   Wed, 30 Nov 2022 17:59:52 +0100
Message-Id: <20221130165955.3479143-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221130165955.3479143-1-Naresh.Solanki@9elements.com>
References: <20221130165955.3479143-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add regulator events corresponding to regulator error in regulator flag
map.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 43 +++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index a7b4ae0f1f3b..9a9e380acc23 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2738,9 +2738,9 @@ static int pmbus_regulator_disable(struct regulator_dev *rdev)
 	return _pmbus_regulator_on_off(rdev, 0);
 }
 
-/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
+/* A PMBus status flag and the corresponding REGULATOR_ERROR_* and REGULATOR_EVENTS_* flag */
 struct pmbus_regulator_status_assoc {
-	int pflag, rflag;
+	int pflag, rflag, eflag;
 };
 
 /* PMBus->regulator bit mappings for a PMBus status register */
@@ -2755,37 +2755,50 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 		.func = -1,
 		.reg = PMBUS_STATUS_BYTE,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
-			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
 			{ },
 		},
 	}, {
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
-			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_FAIL },
+			{ PB_IOUT_OC_WARNING,   REGULATOR_ERROR_OVER_CURRENT_WARN,
+			REGULATOR_EVENT_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,     REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,  REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_POUT_OP_FAULT,     REGULATOR_ERROR_FAIL,
+			REGULATOR_EVENT_FAIL },
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
-- 
2.37.3

