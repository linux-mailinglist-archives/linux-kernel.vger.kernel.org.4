Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B763B0A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbiK1SAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiK1SAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:00:23 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE24219F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:47:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5so9078521wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zldnW5rJOk7M0l3yWgxmGNQjXevQdi/Iqfoi9nBlAx0=;
        b=HrTD3WXu/Al7qExPlPzwtZirW4zpkJcJqhbIDJd1ZNyw6J2NVU0Y+zfJ4LHng4uWpd
         i3Yjprv9ZPGrwTdUjDtnyP+xFndZM6JkhOj8SzbXXJexsBfXIkYGanFx6zF+6+/UUoqo
         kgOFwoNyPuSa5ZxlDEdKxT8Ovhs08umFtalEPwOXODvimNaigNTsmCUrL8bvNY48ZPC5
         UtF1DjNGcbrbH7A8EuB8/jnl62d+ovGPTAFcM1ulffOscuX7/Xih97aiPNECCEuyPyHC
         q5hPPz6LoJH0LGU8aUXg/ueEKglcyszhpITyAe2HwR7aAyU0ciidHI9pweWLizQa+Vej
         Pjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zldnW5rJOk7M0l3yWgxmGNQjXevQdi/Iqfoi9nBlAx0=;
        b=kp5qmE/f3Scty8RzJOkSfgsb+JXrfXIlvcQ/nosyLbdPOhKjQ0Di7RCI2fwms8ccNq
         jdujfR5rLRdOFEADu/5uK+HNtT+AavOMTLnhFBpTwVVwbC4kpxikd4asgl5YvelDWmof
         VliHsVkT5quDsFWmzqtZ8MXyF6yvHhNNZshTW1F87SRtxpopG63ZrxibIsZk99yoQh0l
         owiQQr+JcMfmR5IJdM0YAgMgqXBLdN+nWInEeMoXFRGIS5rX0+6aJjJyB+vOvbuacqcb
         lbGNp9vyS0l84mmf02Zw29iXOw22fFjY4Flf4DbJxNWxlpIwvTSruJKcfHB3bGvOmfVj
         fXfA==
X-Gm-Message-State: ANoB5pnvTbT3zEaPM6h6DsI8AckH7racOXhFhi8tUxMgdgYyf+Yu9uBa
        TdC8dvb+QczuytJeWYHwGhj7RQ==
X-Google-Smtp-Source: AA0mqf45JYunsYGGZgjSURmXcNikMn57TuKiyaxNXEofVAoeo+m9nGr0sRXuEjibQnMmTfBMK3Km+A==
X-Received: by 2002:a05:600c:35cf:b0:3cf:aa11:93a8 with SMTP id r15-20020a05600c35cf00b003cfaa1193a8mr42423628wmq.31.1669657643354;
        Mon, 28 Nov 2022 09:47:23 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b003c6b9749505sm21090045wmq.30.2022.11.28.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:47:23 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: (pmbus/core): Add events to regulator flag map
Date:   Mon, 28 Nov 2022 18:47:13 +0100
Message-Id: <20221128174715.1969957-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
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
 drivers/hwmon/pmbus/pmbus_core.c | 62 +++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index f5caceaaef2a..060e9d0a55bd 100644
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
@@ -2755,51 +2755,71 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
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
-			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
+			{ PB_IOUT_OC_WARNING,   REGULATOR_ERROR_OVER_CURRENT_WARN,
+			REGULATOR_EVENT_OVER_CURRENT_WARN },
+			{ PB_IOUT_OC_FAULT,     REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_IOUT_OC_LV_FAULT,  REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_POUT_OP_FAULT,     REGULATOR_ERROR_OVER_CURRENT,
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
 	}, {
 		.func = PMBUS_HAVE_STATUS_INPUT,
 		.reg = PMBUS_STATUS_INPUT,
 		.bits = (const struct pmbus_regulator_status_assoc[]) {
-			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
-			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN },
-			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
-			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
-			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT,
+			REGULATOR_EVENT_OVER_CURRENT },
+			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN,
+			REGULATOR_EVENT_OVER_CURRENT_WARN },
+			{ PB_VOLTAGE_UV_FAULT,       REGULATOR_ERROR_UNDER_VOLTAGE,
+			REGULATOR_EVENT_UNDER_VOLTAGE },
+			{ PB_VOLTAGE_UV_WARNING,     REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
+			REGULATOR_EVENT_UNDER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_WARNING,     REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_ERROR_OVER_VOLTAGE_WARN },
+			{ PB_VOLTAGE_OV_FAULT,       REGULATOR_ERROR_OVER_VOLTAGE_WARN,
+			REGULATOR_ERROR_OVER_VOLTAGE_WARN },
 			{ },
 		},
+
 	},
 };
 
-- 
2.37.3

