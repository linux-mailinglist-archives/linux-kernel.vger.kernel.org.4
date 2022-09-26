Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C065EAA58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiIZPUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbiIZPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9143482D16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:38 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so2652055wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=yg0w3HEfNXGtnBBhO8Cz9xNPnCqn8b9SdcuxEqWkp0YubNFanaltpZ00oRcemcsH3D
         k64GiXeXxW47t8afssig/+CNlxxvrbMBDg/R9eUS0Eq4zb8kcht8bEA/uyXUXcm4dTqo
         ISO3f+0KUPHO5wpalccaBQLy8I9wRuL3ESHXrp4LjnIU1V34M9vPxq9D39v8kW0PDAxe
         0T7EoTI/PEyXd0DayS6FWCRtP7/Iyy1dhKs+JS1IApCv9/bjHi0k8HcmDBlD20jdsA28
         OAHoQLfpP/7bMBIA/cmoxCut/rb4LQsT5YsXcha6pdgycnuNPxVQvT4kS9v/C04SA2+V
         e2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cMvv+kIwS7Npnyybgo7TEwbxPHKi63Y9shqXlNy7AcU=;
        b=u7KdyXavEBN21B7ysdjamK2HeKRKsQ3VVGl16Zk5EhlQEqT4HZ1cb3Bt4RwQYBODzL
         PdScNTMgcA8ztcBAaB/JN04k/R6r+KTdrCrGGfsYysIUZmMG6VM9LXSRzuucfxr/xAB2
         XFDQaNpOi5C8DsIs20xbfTyl+H222UYo0txYTk4hrtEg3050Y+QBJ1Ek3YxKt2+4+wq6
         70qYn+cLZdDK0vW3QqbhX3iUSVplpB00Wuk4gu6DOzkulwmSIXWwD5zlNpzF1sb8d8Ga
         wS9Cja4wmZxJB7QPucYZsrWhZXyNlXKnfoSEAT3+UssG6xs2kmVmEKz2nG1AaZgOEtZf
         EiVQ==
X-Gm-Message-State: ACrzQf2E1SkYSozz7GCoY2NKS4Cac7II8R1qAvpcrsXXnA+G8qXTJhkn
        swky+KKos3n03QdQJ1skrZvgyA==
X-Google-Smtp-Source: AMsMyM4zW+nU32TzlZYB7xZBNRPL1pZLN8fPKdGijDdPGplygM302nIxXzt0O6PYvnsGBLrTPdtgTQ==
X-Received: by 2002:adf:d0d2:0:b0:22a:daf4:87e8 with SMTP id z18-20020adfd0d2000000b0022adaf487e8mr13523497wrh.167.1664201197751;
        Mon, 26 Sep 2022 07:06:37 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 15/30] thermal/drivers/armada: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:49 +0200
Message-Id: <20220926140604.4173723-16-daniel.lezcano@linaro.org>
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

