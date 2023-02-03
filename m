Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FC68A0AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjBCRpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjBCRoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:44:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E87FA77A7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:44:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j25so1798511wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5nHHSh5TfhObVB27BdAlj0+jr/HbFgiMaA9A4Ts7wk=;
        b=q4PvJDbS4h+Vm7gtjuSp5SfPDEZs2aQMuhxNgiB/QpLhxxaioTTfwl0SX91tfglgI9
         5Sj7bUM0UQV+cRRaX6RrFna0Q+1XQ1pGkTJ2j5Kg3MRAv4bznBi+0zlDbR29UpvPhroq
         b6A/NQ0gOPa5sY0yBiNZ6Nc9uGsmpWSUhMSuaLQkzWHHX+itsbknRohXFyv5dx4G+MGn
         E5xGkKQAdQ3fnByhmnvd3WQT+fJBoqUAb+umBwHFvFKgAySCKf4384E15JtZUW9Nw5KL
         E+ZWsxI5nf1u/RoPyjD996RNc5VjVxapUiHkHgbIUQFL6uI7AKv5PqbE+d4/+7+22RH6
         bwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5nHHSh5TfhObVB27BdAlj0+jr/HbFgiMaA9A4Ts7wk=;
        b=vmxva71cf8NHr5IM2jffouMBfw5lLdvVi73m1oimIl3n5hxc4wj+8048y8gf79HIv0
         i5zjxWzJzzZMfy2HDclh8uTQnUncAiEzhyfBtaPqEG2mgZljXiNTTR4yelOUHMVLN53A
         8lGhaeKNsfUDA96tHpNrfR8GksazjihVb/Qo2gExG/zS5zopSnIKASpzMZZfSB07QBib
         pbVQI6S4wurW1WgmiNVi0jM0qExLACZrIfLMdhr0jn3pygEl/szxqU2GUh97DNKGa8FZ
         ZPOi1ckaVomdRWfXeWRKUiQkoF5SWGe+9wnAWhks2fjUAdfzPyuWb9bNddL2z+4BWORa
         jszw==
X-Gm-Message-State: AO0yUKXpS6B/LfLFRROj1RubSDNfW/NDngsmi0LpeQeejRX2g1EG0imh
        iEak2ivlHKMtLSbw2CjGdjA3Gg==
X-Google-Smtp-Source: AK7set/xt1LGFtMdeWadocqdqxfEXyo3P7347SO7zjWlNakaSZxs2ZweMEL/aGiUYQxfjueuupHuPw==
X-Received: by 2002:a05:6000:1085:b0:2bf:d511:18a9 with SMTP id y5-20020a056000108500b002bfd51118a9mr9559555wrw.29.1675446281872;
        Fri, 03 Feb 2023 09:44:41 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 08/11] thermal/acpi: Remove active and enabled flags
Date:   Fri,  3 Feb 2023 18:44:26 +0100
Message-Id: <20230203174429.3375691-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
References: <20230203174429.3375691-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'active' field in the struct acpi_thermal_state is never used.

The 'enabled' field of the structure acpi_thermal_state_flags is
assigned but never used.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c7c2b3d63e90..316a16ac1a09 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -117,14 +117,12 @@ struct acpi_thermal_state {
 	u8 critical:1;
 	u8 hot:1;
 	u8 passive:1;
-	u8 active:1;
 	u8 reserved:4;
 	int active_index;
 };
 
 struct acpi_thermal_state_flags {
 	u8 valid:1;
-	u8 enabled:1;
 	u8 reserved:6;
 };
 
@@ -1138,17 +1136,14 @@ static int acpi_thermal_resume(struct device *dev)
 	for (i = ACPI_THERMAL_TRIP_ACTIVE; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (!tz->trips[i].flags.valid)
 			break;
-		tz->trips[i].flags.enabled = 1;
+
 		for (j = 0; j < tz->trips[i].devices.count; j++) {
 			result = acpi_bus_update_power(
 					tz->trips[i].devices.handles[j],
 					&power_state);
-			if (result || (power_state != ACPI_STATE_D0)) {
-				tz->trips[i].flags.enabled = 0;
+			if (result || (power_state != ACPI_STATE_D0))
 				break;
-			}
 		}
-		tz->state.active |= tz->trips[i].flags.enabled;
 	}
 
 	acpi_queue_thermal_check(tz);
-- 
2.34.1

