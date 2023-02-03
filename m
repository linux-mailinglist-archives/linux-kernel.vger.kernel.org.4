Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7F68A09F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjBCRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjBCRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:44:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F457D98A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:44:36 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bt17so2294762wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 09:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLokg2NHvRs8lyMVKIrJy/BKSUdWDoE+8uppdEp+JpA=;
        b=sZRjljkr6bJYeB4OrmFyNTCBRtYs6quMNFi9nqhdgWamo9qgpOnOE6zldkfIpgGpBu
         esIFInDsT+nubJI71sW8L7ivDzru9kf4QiIUNp5GESU5dzH+MF2lQCLt8bwyo11ErNl6
         YtcC4Td0cSmuM0ywDVpeXW7tvy7qIEN4cJsIulhqDbZv0zx450Z3KNmCp3FPUV2aA2yU
         P8XidWqFHv1qqwd2/qj9AQ8TUsmaTaZUIkHis4dllxUPIy5o2p/kN++kLLkEEcb7RGde
         PyQyFuCZiawkZORNU21wavgD905PQQCQBVJlep13d3PFjzgt0jENJldfYD3ZHULkkhCO
         gstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLokg2NHvRs8lyMVKIrJy/BKSUdWDoE+8uppdEp+JpA=;
        b=jdlJQ3DBUtXohtwFQjQGYoqZ0r5e7OPc4FcVQyoF3kTvI4AWgMNrBozj4JoImBnPVt
         fNUVKpPmW30VojNm+83DTXhtxm8LWeQ0g8+K+DAPvYlZOlN3TxwXV/NdpMAZdzY0vraw
         uGj8UPMssAmvHF7XjOmtjHzPt4PAgNd/3/OeFYj8YhUKAMFh3P5TuoA2qtTG3htPpddH
         Wv44eNn5srYeBnuI9wecHxzI8gbWymtOkGPWffMbEUcqlCqOfgS2uVuz1cJ/nBPk98hS
         xrG4kRf9PjyMdNR5dosCib9hmd5b84Tm1e1ss8fotef/gkzXctiZOoVkSoE9nRJVXZtl
         6Tew==
X-Gm-Message-State: AO0yUKWdoSDypNtYBxa5SNP0ktQUqxXcnfSPdat8Z9BAcwjJNlE778lM
        EFnyw6EN0Xy9cibtk2xr77/kAw==
X-Google-Smtp-Source: AK7set/fA0uLNA2/eAJKJytN7nhGGOwiShSlSNEPkHruKpmZdInvtgkz+iLe45fLJc1HPbq/NtzF8A==
X-Received: by 2002:a05:6000:1005:b0:2c3:be89:7c29 with SMTP id a5-20020a056000100500b002c3be897c29mr4288351wrx.12.1675446274468;
        Fri, 03 Feb 2023 09:44:34 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id z1-20020a5d4c81000000b002bdd8f12effsm2443528wrs.30.2023.02.03.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:44:34 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rjw@rjwysocki.net
Cc:     daniel.lezcano@linaro.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 02/11] thermal/acpi: Change to a common acpi_thermal_trip structure
Date:   Fri,  3 Feb 2023 18:44:20 +0100
Message-Id: <20230203174429.3375691-3-daniel.lezcano@linaro.org>
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

The acpi trip point definition are very similar whatever their
types. Instead of creating a different structure for each trip type,
let's define and use a common one.

With this change we move a step forward to the generic trip point.

No functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/thermal.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0dbce190cacc..e27b0b71fcf8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -119,36 +119,13 @@ struct acpi_thermal_state_flags {
 	u8 reserved:6;
 };
 
-struct acpi_thermal_critical {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_hot {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-};
-
-struct acpi_thermal_passive {
+struct acpi_thermal_trip {
 	struct acpi_thermal_state_flags flags;
+	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_active {
-	struct acpi_thermal_state_flags flags;
-	unsigned long temperature;
-	struct acpi_handle_list devices;
-};
-
-struct acpi_thermal_trips {
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 };
 
 struct acpi_thermal_flags {
@@ -166,10 +143,10 @@ struct acpi_thermal {
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
-	struct acpi_thermal_passive passive;
-	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
+	struct acpi_thermal_trip critical;
+	struct acpi_thermal_trip hot;
+	struct acpi_thermal_trip passive;
+	struct acpi_thermal_trip active[ACPI_THERMAL_MAX_ACTIVE];
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
-- 
2.34.1

