Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC35BFB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIUJpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiIUJnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC192F4E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so8944561wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=w7YOAHF+Mo749ReVRayXWiXMtDEx78SmXA5hC2nF7+MA3C91wATBu0a02Qn7CU8j6P
         +lh5AndC3u/CB57mmREWvAFy6d5mlTnOhbKM7wKoxFeaKEvKZD467dEaSaOxhBP7p5rR
         cc+0vILWFLJsKydLAOwdm1OKu4f1sgz4eetA27kVPpU9xtMfXGQk+Nr9Dfl3jZ1RG11y
         YjkBy0F/LetLWVz5tLqn+x988dKSTYqJFHknu4fTuiJaRhz674ubnKykiDPxxZSqzz5z
         TrwLWUidkJQYayoc9XCCxTHbwfKe+QllGcvTjXRkAfmAQIr1wx0aQ6CO5Z6fqHCCqKH8
         quSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=n6pIy+0ufI+bWu0BepSglOmT1tEFCqQQx0XLJAHMEtiUTRshRjmHjuQHQN9NiWmRJX
         3EsKwKO8eezEBsahRXtvOWrCk4uXJ1gCGxqE/9zgHJbkZSfL/bKacIjV21p50IaFMBAm
         Jqy5FvxYE0b+3BaPV54Sp2D5MVG3wo29wlM/Aw6OFoKFziwnFWsJAKEbVY94WBVWno85
         sfymHQyFzwfzXUIbikZVwVdsgnhmI/Jr4Vx6M0juwj7Qwjh+wHbbluwyy5/xhrBaLoNj
         5uFMUOPCRVExFUJs8p3LsUNJTgdWEpS2JttcYrhV0i0Da+yW7C/YlpxRE3E5HAqLioTh
         GQdA==
X-Gm-Message-State: ACrzQf3Xmd1pD3NSTJP7ApWLAu7FKw+PlL7NPT8qJjr/pDHvclQedTAp
        xk4ZSFcy+PvaFazHUj9kUGQgnw==
X-Google-Smtp-Source: AMsMyM7b/bKDaPaFv9Rq2zLpIrEgKpeyNjVrzjIZx2uTbPvgvxj1FxRvBu2O98Q/8QSP9tMqrRFvYg==
X-Received: by 2002:a05:6000:38e:b0:22a:e302:28e6 with SMTP id u14-20020a056000038e00b0022ae30228e6mr15169501wrf.595.1663753424295;
        Wed, 21 Sep 2022 02:43:44 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 15/30] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:28 +0200
Message-Id: <20220921094244.606948-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/armada_thermal.c | 39 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 52d63b3997fe..9444e5a22ca0 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -785,33 +785,34 @@ static int armada_configure_overheat_int(struct armada_thermal_priv *priv,
 					 int sensor_id)
 {
 	/* Retrieve the critical trip point to enable the overheat interrupt */
-	const struct thermal_trip *trips = of_thermal_get_trip_points(tz);
+	struct thermal_trip trip;
 	int ret;
 	int i;
 
-	if (!trips)
-		return -EINVAL;
-
-	for (i = 0; i < of_thermal_get_ntrips(tz); i++)
-		if (trips[i].type == THERMAL_TRIP_CRITICAL)
-			break;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	if (i == of_thermal_get_ntrips(tz))
-		return -EINVAL;
+		ret = thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		if (trip.type != THERMAL_TRIP_CRITICAL) 
+			continue;
 
-	ret = armada_select_channel(priv, sensor_id);
-	if (ret)
-		return ret;
+		ret = armada_select_channel(priv, sensor_id);
+		if (ret)
+			return ret;
+		
+		armada_set_overheat_thresholds(priv, trip.temperature,
+					       trip.hysteresis);
+		priv->overheat_sensor = tz;
+		priv->interrupt_source = sensor_id;
 
-	armada_set_overheat_thresholds(priv,
-				       trips[i].temperature,
-				       trips[i].hysteresis);
-	priv->overheat_sensor = tz;
-	priv->interrupt_source = sensor_id;
+		armada_enable_overheat_interrupt(priv);
 
-	armada_enable_overheat_interrupt(priv);
+		return 0;
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static int armada_thermal_probe(struct platform_device *pdev)
-- 
2.34.1

