Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D05EC67B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiI0OfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiI0Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77EC1B9108
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so7009006wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9Ogs5/BdK1Y/lDDyEmjA88qgr/D6i26XcRmp1g6reCg=;
        b=shjk20gNeUlghK3xqf78iu/3LdpRVxyOjmfpGv8mN+gxLlR8p+bgKHpMJP0aaLw4mt
         RVZOrQLElZTl0N85JXu/BR5nV4a1UGXLsp96tTa3fTVf00NY8Wdo8KoRSFP/UwS5D8Wl
         xVM7xMSW2DxzmYmcIRTktYw9twcAlE690mDWneX+9Y5QXWL+DSEV+1G3F4/EeqJJyTpa
         qLVtsOOMg6jhdzUBIzCYe5Iaw98AAEoN8ftV6uK9vspqq/BSsIYft3ltePpK9/BtyFJZ
         kFHKYhZFHBqd208agMNZWCCa7nttTAlB6qiDII54sbjnKvLlwXa1Ir6LU3+3RDwQIggJ
         oh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9Ogs5/BdK1Y/lDDyEmjA88qgr/D6i26XcRmp1g6reCg=;
        b=o7gyN8+F5PjkJ+dLPPzLBrHZCxTFOzhj5eIY9YVi0xhU4z71UCMpQCDZLcxxx0OgH0
         KRa0es+JSY+p9wIha5vaK0rcRXZW0S0sKq2W5LJ8xcpnIszrO4SVmNynV4Bfz4DQRUcF
         IReOTABEZYmKogbGuRy4Prw8F4sEPAed+6cBDhBudD+MWmotjUCIX0VbLDorgSa2Fmx2
         tk2q3pxCxvpFtcwE3HKQtXb77B/WbHIZRWBdaE9t/5jR/r+2yVLvX5I4ll+M9FxjzOOl
         rUkeR5sUjBTAdCp2kWC45qo3OMnbhe6HGgk5hEG1++q/qKMULjKlJnYQsHZE6VBRqEP1
         63Ow==
X-Gm-Message-State: ACrzQf1TjTPPfX70qEQB2jcG4Z/NxAU1/m+phcqkN6gXKfyM/HxnCQHP
        TtkQcHZssay0L5b9XYwpsJD5HA==
X-Google-Smtp-Source: AMsMyM6NRM4xkRUkVGAebAoeA/YVo3QSEd/J1yd/wExQNi87pNYEsSLN8CuRs8daPjL/OtSQHelq+A==
X-Received: by 2002:a05:600c:35c5:b0:3b4:bf50:f84a with SMTP id r5-20020a05600c35c500b003b4bf50f84amr2895485wmq.22.1664289201728;
        Tue, 27 Sep 2022 07:33:21 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:21 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Amit Kucheria <amitk@kernel.org>,
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS)
Subject: [PATCH v6 22/29] thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:32 +0200
Message-Id: <20220927143239.376737-23-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 53 ++++------------------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 61c2b8855cb8..436f5f9cf729 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,12 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
 
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
-				      int trip, enum thermal_trip_type *type)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*type = THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int *temp)
-{
-	struct rcar_thermal_priv *priv = rcar_zone_to_priv(zone);
-	struct device *dev = rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <= temp */
-		*temp = MCELSIUS(90);
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static const struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
+static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
-static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
-	.get_temp	= rcar_thermal_get_temp,
-	.get_trip_type	= rcar_thermal_get_trip_type,
-	.get_trip_temp	= rcar_thermal_get_trip_temp,
+static struct thermal_trip trips[] = {
+	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
 };
 
 /*
@@ -529,11 +489,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (chip->use_of_thermal) {
 			priv->zone = devm_thermal_of_zone_register(
 						dev, i, priv,
-						&rcar_thermal_zone_of_ops);
+						&rcar_thermal_zone_ops);
 		} else {
-			priv->zone = thermal_zone_device_register(
-						"rcar_thermal",
-						1, 0, priv,
+			priv->zone = thermal_zone_device_register_with_trips(
+				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
-- 
2.34.1

