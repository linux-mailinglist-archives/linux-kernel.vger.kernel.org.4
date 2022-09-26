Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AD55EAA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiIZPVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbiIZPTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:24 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08283072
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so4581963wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=Uyb0eyU1G7y4T0z0CnKTq+d4m6oHlieEpg+zi1Pz0zaS3HM67ZbeZa4l3MDly6njfi
         x731btnmUL7zNF7XrhVQ8L3hvbed0kawbHa08YKKdX1+T+3bojSnhNSzAWksFvoyaEcl
         oshiva9TCScpwL1I4RtFpmogSebfIHwVy5xKH2A25wQFpp1BcSDhP3owKviOVHtPAeUA
         uTGoSCmb2i1WuiKFYWGzQPUJ9CFYqJntgbHI5v+j1BD7qmshLyrqABJPKkufRAcsu1Qm
         cFl1HVALOnDp0/2wm5/+VBQU23ssR5KYyb8Mc2kQX9T+w5P5vorcJCSJO6xB4vEOMirX
         L/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p+Fs/P7gXsm/5qHeFX0rzCcy4XeIXDeOEwU0TTt39+U=;
        b=WMdiYJzma483LX/7eWvYesnO71G0Y5FGgtUP/p+E6woq12fwin4uzbO0r1o04g2l3l
         h1N9jU/kHwRWlxujsk1LgLkXmO4safDZHD2Z+pt0LpXuw4ouxxqKdLUoeIA7RIFrk1qv
         VPxrw8IB4GaO0ykLHEJlhI+ehWrPqrFqswvz630HXzDy01YhT5bxn5lUpY2E/bnqxBS+
         Ql6NPR9lHBF/lOKbEmYaXVjw2QTVpCeTPmwIY9a5vMo3BFs0PZQZFTEPgTXVrc9tkr62
         ekdcfw1aLVXUEj3KqlUDtZpmnHzBA02EbB44JetjMoxo1GkMcS3S9oFMnC1V2o+9BMyj
         Yb/A==
X-Gm-Message-State: ACrzQf3UpxrE4Tw+YQBY7IiRrUEEq3xPCIe8nz1/ycSW5plyQpF5ppRd
        Za6twsYZVGC9wbo6y+m4rAnIug==
X-Google-Smtp-Source: AMsMyM5L1gGBMlXU1EhsCLiLL1k/0Trfvb0Zs04EUaIadrrwVMgHghkmyPfYrIkJFSp13GpIU9cutw==
X-Received: by 2002:a05:600c:35c5:b0:3b4:bf50:f84a with SMTP id r5-20020a05600c35c500b003b4bf50f84amr14722636wmq.22.1664201206627;
        Mon, 26 Sep 2022 07:06:46 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:45 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 21/30] thermal/drivers/st: Use generic trip points
Date:   Mon, 26 Sep 2022 16:05:55 +0200
Message-Id: <20220926140604.4173723-22-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert to the generic trip points

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/st/st_thermal.c | 47 +++++----------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 1276b95604fe..c0d45cdd1c2f 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -134,48 +134,12 @@ static int st_thermal_get_temp(struct thermal_zone_device *th, int *temperature)
 	return 0;
 }
 
-static int st_thermal_get_trip_type(struct thermal_zone_device *th,
-				int trip, enum thermal_trip_type *type)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int st_thermal_get_trip_temp(struct thermal_zone_device *th,
-				    int trip, int *temp)
-{
-	struct st_thermal_sensor *sensor = th->devdata;
-	struct device *dev = sensor->dev;
-
-	switch (trip) {
-	case 0:
-		*temp = mcelsius(sensor->cdata->crit_temp);
-		break;
-	default:
-		dev_err(dev, "Invalid trip point\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static struct thermal_zone_device_ops st_tz_ops = {
 	.get_temp	= st_thermal_get_temp,
-	.get_trip_type	= st_thermal_get_trip_type,
-	.get_trip_temp	= st_thermal_get_trip_temp,
 };
 
+static struct thermal_trip trip;
+
 int st_thermal_register(struct platform_device *pdev,
 			const struct of_device_id *st_thermal_of_match)
 {
@@ -238,9 +202,12 @@ int st_thermal_register(struct platform_device *pdev,
 
 	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
 
+	trip.temperature = sensor->cdata->crit_temp;
+	trip.type = THERMAL_TRIP_CRITICAL;
+	
 	sensor->thermal_dev =
-		thermal_zone_device_register(dev_name(dev), 1, 0, sensor,
-					     &st_tz_ops, NULL, 0, polling_delay);
+		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, 0, sensor,
+							&st_tz_ops, NULL, 0, polling_delay);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
-- 
2.34.1

