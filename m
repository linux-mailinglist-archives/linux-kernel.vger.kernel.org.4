Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9775EAA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbiIZPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236040AbiIZPT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:26 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECD4832C3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z6so10445805wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=tnnDjaBUtnc7oQrQbRebViXzmDjDdl9T/DEuZNUa9/JCDkDEp4iP53y1QtaSPi98g7
         +vBxLVToAlC9nmdKHBjptrLQORY/qiSyHCq9wlVFLXOUH7A/iK8R9RyquHplpBVNBD8g
         ZrnGKD3wDUl4TdphCW7hwjPVqClPb4iH12hN/2srvVDBes1jZL/Ts/yUoapAQ+Du2hGk
         0AWbJxxqH5Z9pBf7KLV9nVueV2+OYe19maKGCS30q5XXT9+KZaBu6Hx+35s4qyIR2mYf
         F+sGY0Slo13wCBkKp7Q7o6RFh2kwDAr1xMaMP4bLPChHOB39YLUJ6BTtuBvRUcINqmUg
         5apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1g7iD3leIss4w6BJ5qO+L1jz4YwsNBVACOWMBVjZgpk=;
        b=OFjjlmF7YL8Yd1hiwp0uhylMcGU9s7fSZOfwetOZPm51L0UL911aQyDjqXvGsabfhb
         ShhNKY3GS+9QIMtyvAxjQW2z1ccqWW/es+tw4eWGdP7fpVTCV+ISDrg/6cmIRegV/0FM
         fhldhjCqCtsUvptc6IiCS3WqYCYV27RWx7ZEltPsvQuCm+nkpBXV+wNJD3jqqWdb7y98
         fzWuKJP0F9QuJFu4Pp8R6nA4OIX0jr9tsm6ECt43bT1guu/+vqC/DTaEWApQjdGEfiiB
         zNH6KW4hXgGLCBHFgl6s7maTolPS/xeqOL9Jdtbftp2t8DzRmXqmOePmMSrYquLuxqOp
         jlhA==
X-Gm-Message-State: ACrzQf21stpBiDQ4vf80k4QQRQwe3g05WztxGUVvw26HhZ3FNxejL1zx
        Ndomt2RuHY4Nv0HrHTTtueUrHw==
X-Google-Smtp-Source: AMsMyM4IjuisRUSZFfhh5aV/d+IDBRRQK/plI/EtN4XB30ApYlP4YdMBrxfzv20ceoHjV3K0TdPGqA==
X-Received: by 2002:a5d:6147:0:b0:22a:6035:a878 with SMTP id y7-20020a5d6147000000b0022a6035a878mr13189438wrt.528.1664201211500;
        Mon, 26 Sep 2022 07:06:51 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:50 -0700 (PDT)
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
Subject: [PATCH v5 23/30] thermal/drivers/rcar: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:57 +0200
Message-Id: <20220926140604.4173723-24-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/thermal/rcar_thermal.c | 49 +++++-----------------------------
 1 file changed, 6 insertions(+), 43 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4df42d70d867..003457810072 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,16 @@ static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
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
 static struct thermal_zone_device_ops rcar_thermal_zone_of_ops = {
 	.get_temp	= rcar_thermal_get_temp,
 };
 
 static struct thermal_zone_device_ops rcar_thermal_zone_ops = {
 	.get_temp	= rcar_thermal_get_temp,
-	.get_trip_type	= rcar_thermal_get_trip_type,
-	.get_trip_temp	= rcar_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .type = THERMAL_TRIP_CRITICAL, .temperature = 90000 }
 };
 
 /*
@@ -531,9 +495,8 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
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

