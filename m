Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC7633B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiKVLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKVLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:38:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9585B5A2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:33:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e11so11346636wru.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2zr/3LnDgZvKq+c4XGc3H/8wNdt4pUTOlQ5WTUoXqY=;
        b=RW5GjrPQStt/3N3wqzjmvb75Xed84o1+oHhxvHAmUMk4kdKH5Js+45eAVEzTJa/MoJ
         WHbR9YMfwyL11SK1dBBD2CfJHg/SRWRDxz26P9/uAlEeev3jRSzgTSQkc0ntjAN59QG5
         fUXwt6dlFo7zPX6HPRslBtwqTbfThHvhfOcRsEZ2qn4FFlrq1dwIjgMZuxSvtb50hEYu
         tX9kXMlw3pdCdzeHGB0sOlPSxAbXcGDIx7e4C9a+SsI5Vwvk0bGWXqMbEGfg1SREz5r2
         Wej3n9C5A1I73QrpK0mUiTi5UI5T6Hygct/QndPtuIiu/5Z6lGegQ6exQ89mt3QJaFb+
         NByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2zr/3LnDgZvKq+c4XGc3H/8wNdt4pUTOlQ5WTUoXqY=;
        b=UccZxlaLMWsbt/bhe37X/xwxoUTHdeWJ9WMLS7LTn1zRp1xK1fOy2gzj7ld7uD9LHD
         dzbxiKaQsobbgYCa15jHP0kaRGLDZMeoVrD7Rz1lCoe8ut7aRqoUneM8mM+W/H94FSWe
         fbViu9hF7607jQW4Ui631qae5GIz08JXuZuGuW6D8LyU7PJKZqjjO1Toh6k8H88xLwwq
         8uppfGNBoHD0g2Aabkh88I8lZbuCaNMYx0/0nciu/ZrPjAe8xX+Kvyg/Feu7lpmxzk6g
         8AJjg0hxwt4Wm5WEPSUt2FPd62zecXgvp43XFytkijTGiH+E4+jN8OEg9e1ecLwWpmxF
         kurA==
X-Gm-Message-State: ANoB5pn3nlBcL/gPQt5ucW3Fcs1dgtJioUJw/UoM6nBOLwAk8NBumcVw
        tGus6CEKSKW/eSXOpX791nZh0Q==
X-Google-Smtp-Source: AA0mqf4CrIPLr/j50ifVlKk7DcR6q7icqtILjB+Y0z5gNVZ2mixNP6S+Ru8dACI0XSNFDe7yBf6ypQ==
X-Received: by 2002:adf:dd8c:0:b0:236:63d4:fbbe with SMTP id x12-20020adfdd8c000000b0023663d4fbbemr14008361wrl.574.1669116792346;
        Tue, 22 Nov 2022 03:33:12 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b00241bc4880fesm12914086wrt.111.2022.11.22.03.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 03:33:12 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (pmbus/core): Add events to regulator flag map
Date:   Tue, 22 Nov 2022 12:32:56 +0100
Message-Id: <20221122113257.3213700-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122113257.3213700-1-Naresh.Solanki@9elements.com>
References: <20221122113257.3213700-1-Naresh.Solanki@9elements.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 68 ++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 08f96e2b4837..7d7d10039987 100644
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
@@ -2755,48 +2755,76 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
 		.func = PMBUS_HAVE_STATUS_VOUT,
 		.reg = PMBUS_STATUS_VOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_REGULATION_OUT },
+			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
+			REGULATOR_EVENT_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_REGULATION_OUT,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_IOUT,
 		.reg = PMBUS_STATUS_IOUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IOUT_OC_WARNING,	 REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_IOUT_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IOUT_OC_LV_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_POUT_OP_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_WARNING,	 REGULATOR_ERROR_OVER_CURRENT_WARN,
+			REGULATOR_EVENT_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,	 REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_POUT_OP_FAULT,	 REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_TEMP,
 		.reg = PMBUS_STATUS_TEMPERATURE,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_TEMP_OT_WARNING,	 REGULATOR_ERROR_OVER_TEMP_WARN },
-			{ PB_TEMP_OT_FAULT,	 REGULATOR_ERROR_OVER_TEMP },
+			{ PB_TEMP_OT_WARNING,	 REGULATOR_ERROR_OVER_TEMP_WARN,
+			REGULATOR_EVENT_OVER_TEMP_WARN },
+			{ PB_TEMP_OT_FAULT,	 REGULATOR_ERROR_OVER_TEMP,
+			REGULATOR_EVENT_OVER_TEMP },
 			{ },
 		},
 	}, {
 		.func = -1,
 		.reg = PMBUS_STATUS_BYTE,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_STATUS_IOUT_OC,	 REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_STATUS_VOUT_OV,	 REGULATOR_ERROR_REGULATION_OUT },
-			{ PB_STATUS_VIN_UV,	 REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_STATUS_NONE_ABOVE,  REGULATOR_ERROR_FAIL },
+			{ PB_STATUS_IOUT_OC,	 REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_STATUS_VOUT_OV,	 REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_STATUS_VIN_UV,	 REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
+			{ PB_STATUS_OFF,	 0,
+			REGULATOR_EVENT_DISABLE },
+			{ PB_STATUS_NONE_ABOVE,  REGULATOR_ERROR_FAIL,
+			REGULATOR_EVENT_FAIL },
+			{ },
+		},
+	}, {
+		.func = -1,
+		.reg = PMBUS_STATUS_WORD,
+		.bits = (const struct pmbus_regulator_status_assoc[]) {
+			{ PB_STATUS_POWER_GOOD_N, 0,
+			REGULATOR_EVENT_REGULATION_OUT },
 			{ },
 		},
 	}, {
 		.func = PMBUS_HAVE_STATUS_INPUT,
 		.reg = PMBUS_STATUS_INPUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IIN_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE },
+			{ PB_IIN_OC_FAULT,	 REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_VOLTAGE_OV_FAULT,	 REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_UV_FAULT,	 REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
 			{ },
 		},
 	},
-- 
2.37.3

