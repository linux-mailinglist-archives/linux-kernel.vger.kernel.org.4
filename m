Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341CC5EC67F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiI0Off (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiI0Odo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842461B7B2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so5561944wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Bvo7EJO01qiFSqaGbT4JiAGDEh8uk0vvz3ltgjeJ4xY=;
        b=T9Yv44yYrTtCNaiU5wiZN0UL6Z3v3bqtDzkRBRov+GPkWFws7RcKceIXcRZjM/YOqm
         3ppFsVB4L+XckbKJO+b9FSuuTwMMURVtLGXBoZ+PpsY7IQ2+aXB9jhUCCTYp5tXmV4xl
         ww9Kv9GJ0ziNvLy0CzmNssBjDQvagCHVAm7AqWeMDmnD8Tvv8+yEnX+webFrjEQN+vut
         LNj06unOKNTwD51nQFnljo2Y5lIRDAI/0MBnADAiWqMssX7GwlK5+iHgHMmgLIqw/Xa7
         MMB0Dap0OCl7Z6fVlOPotbRN/uz+9JqDA9D02kMVP8EWsmqnWX1MBeMoQHamOroBXejA
         AMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Bvo7EJO01qiFSqaGbT4JiAGDEh8uk0vvz3ltgjeJ4xY=;
        b=zP0SSgL+9bHPj9YAvMnyrmcsscu6ufy/Oh/4P9MrM1aYgJY5QuRd7n/GdFaH/rgqRI
         Hx2segk8SoPdBrQ/wIXXmJMWLJFOk/PD0CSBBSJv58NrBeEcHyV+9FXaU1QMSC/hFf1g
         liVshSl0mY6O/bDYTujrSRTl56SA6gdjwHT0SeO1SsiTFP8BhmYo5K6sTt2cEzGopEG2
         Y6o+JRMAfOOC/+cstci6vgv5U61GPoyQ3E8CzdkDSNSOvksYQr4k+k3NuHOLILLEFHIx
         bUnqkAq6P+eBCQwkx47cdFzped9NUsgG0e2szlKDSz/CAPe7Vw/958QPPXVsnJOL24q2
         DoRg==
X-Gm-Message-State: ACrzQf2Tbyec9gr9yMbVZS4+2ju12IDSaG9ZAfAJ2CxKohWe3eSg5h6p
        8vQTtqUEr8D8CeGptLVglYj5yw==
X-Google-Smtp-Source: AMsMyM4bkZzBpjUbqF+RHS8ZCprGjVOxdmWnqMSgcxklwDf8rYXb/cmGJT75lPf0Aml4T3XhYhOWEw==
X-Received: by 2002:a05:600c:4211:b0:3b4:6334:9940 with SMTP id x17-20020a05600c421100b003b463349940mr3022429wmh.166.1664289207795;
        Tue, 27 Sep 2022 07:33:27 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Peter=20K=C3=A4stle?= <peter@piie.net>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org (open list:ACER ASPIRE ONE
        TEMPERATURE AND FAN DRIVER)
Subject: [PATCH v6 26/29] thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:36 +0200
Message-Id: <20220927143239.376737-27-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter Kästle <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c | 73 ++++++++++++----------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 3463629f8764..a7407aa032ba 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -46,6 +46,8 @@
  * measured by the on-die thermal monitor are within 0 <= Tj <= 90. So,
  * assume 89°C is critical temperature.
  */
+#define ACERHDF_DEFAULT_TEMP_FANON 60000
+#define ACERHDF_DEFAULT_TEMP_FANOFF 53000
 #define ACERHDF_TEMP_CRIT 89000
 #define ACERHDF_FAN_OFF 0
 #define ACERHDF_FAN_AUTO 1
@@ -70,8 +72,8 @@ static int kernelmode;
 #endif
 
 static unsigned int interval = 10;
-static unsigned int fanon = 60000;
-static unsigned int fanoff = 53000;
+static unsigned int fanon = ACERHDF_DEFAULT_TEMP_FANON;
+static unsigned int fanoff = ACERHDF_DEFAULT_TEMP_FANOFF;
 static unsigned int verbose;
 static unsigned int list_supported;
 static unsigned int fanstate = ACERHDF_FAN_AUTO;
@@ -137,6 +139,15 @@ struct ctrl_settings {
 	int mcmd_enable;
 };
 
+static struct thermal_trip trips[] = {
+	[0] = { .temperature = ACERHDF_DEFAULT_TEMP_FANON,
+		.hysteresis = ACERHDF_DEFAULT_TEMP_FANON - ACERHDF_DEFAULT_TEMP_FANOFF,
+		.type = THERMAL_TRIP_ACTIVE },
+
+	[1] = { .temperature = ACERHDF_TEMP_CRIT,
+		.type = THERMAL_TRIP_CRITICAL }
+};
+
 static struct ctrl_settings ctrl_cfg __read_mostly;
 
 /* Register addresses and values for different BIOS versions */
@@ -326,6 +337,15 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 		fanon = ACERHDF_MAX_FANON;
 	}
 
+	if (fanon < fanoff) {
+		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
+		       fanoff, fanon, fanon);
+		fanoff = fanon;
+	};
+
+	trips[0].temperature = fanon;
+	trips[0].hysteresis  = fanon - fanoff;
+
 	if (kernelmode && prev_interval != interval) {
 		if (interval > ACERHDF_MAX_INTERVAL) {
 			pr_err("interval too high, set to %d\n",
@@ -424,43 +444,6 @@ static int acerhdf_change_mode(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int trip,
-				 enum thermal_trip_type *type)
-{
-	if (trip == 0)
-		*type = THERMAL_TRIP_ACTIVE;
-	else if (trip == 1)
-		*type = THERMAL_TRIP_CRITICAL;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int trip,
-				 int *temp)
-{
-	if (trip != 0)
-		return -EINVAL;
-
-	*temp = fanon - fanoff;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int trip,
-				 int *temp)
-{
-	if (trip == 0)
-		*temp = fanon;
-	else if (trip == 1)
-		*temp = ACERHDF_TEMP_CRIT;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 				 int *temperature)
 {
@@ -474,13 +457,9 @@ static struct thermal_zone_device_ops acerhdf_dev_ops = {
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
 	.change_mode = acerhdf_change_mode,
-	.get_trip_type = acerhdf_get_trip_type,
-	.get_trip_hyst = acerhdf_get_trip_hyst,
-	.get_trip_temp = acerhdf_get_trip_temp,
 	.get_crit_temp = acerhdf_get_crit_temp,
 };
 
-
 /*
  * cooling device callback functions
  * get maximal fan cooling state
@@ -710,10 +689,10 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
 
-	thz_dev = thermal_zone_device_register("acerhdf", 2, 0, NULL,
-					      &acerhdf_dev_ops,
-					      &acerhdf_zone_params, 0,
-					      (kernelmode) ? interval*1000 : 0);
+	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
+							  0, NULL, &acerhdf_dev_ops,
+							  &acerhdf_zone_params, 0,
+							  (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
 
-- 
2.34.1

