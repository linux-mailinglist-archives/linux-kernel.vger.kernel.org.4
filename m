Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16265BFB74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIUJov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiIUJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2518F92F42
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so8874897wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=HiA3EfjWkOce7HwilnMsNfPhOfemF/8YL8t+8lZHmM5THJGFye6sXuc2WOQuNkuYGc
         IJNRokWV+QLpeV7kcY7pkPnQrjNKVQW/WHEDtcjgUL7e6SXZf7HRAH8XBtRKWUJtSYTq
         K6Zu0noiOKiIdlA3di/oIW7dCCBKLtZONbToCEKVIZTEJz8WBBDQ1yznH05XcRIqUxge
         HZv2MarsMNF+4vTDqZ/BvZiYeKv4Pq6kTKUNLAv6oRTYEc3IhVjQD4D5trYKuHjEg0a7
         g1Dss0cy8Si4/T4uQwqgGNIWj8+htpRKLnUNrGQDk4Ty/Qqa1pTFekXHythD+zjsaA1v
         zbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=En2ZWyOgoFiLRbyNsPpg10OE/UgZ+0WlkNIqUBXaPKGU5UyIUi/YGRrwNgOUt2KCcE
         B9qOUB7rbu/oA/B60dR5Z6N9jNl7o53nN3VcXZNRPEE9GiUI7WvqySdYtGToWD+LjHH1
         J+G9emLuBG2/gwazmW8aHkH90nbdmdha/h6Tlry0pN+cDg7J/nGXdVwohZLsM/MQUS+r
         0Q9EsBrwAw+LEi464XuFm1+RiqiOWL/XOPemKXJsX0+mmvG2KkhWsACy6Db9SsIY3MKg
         r7pxvIXNZ5THNISVztBbm61lingWgqOYprMz1N+0cf/Aobx52gGWWdJ0lkGzWkXC9BhC
         J2RQ==
X-Gm-Message-State: ACrzQf1sVVHiu0O9uFRl2C/8vmFNeooU3EWOnJ1cxlymxi8UGsfZ8j+5
        9MHQwrx77aY2FusvZepDmwxuIA==
X-Google-Smtp-Source: AMsMyM6NfenDQBTBp7WJSQFB8n58E4eQqGgdYyhShAn/pvOtGqYuaxoJdDoba+Fjvj4KZxef1xoG1Q==
X-Received: by 2002:a5d:5c0a:0:b0:228:db53:22cc with SMTP id cc10-20020a5d5c0a000000b00228db5322ccmr15551040wrb.126.1663753421667;
        Wed, 21 Sep 2022 02:43:41 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:40 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 13/30] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:26 +0200
Message-Id: <20220921094244.606948-14-daniel.lezcano@linaro.org>
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
 drivers/thermal/hisi_thermal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index d6974db7aaf7..45226cab466e 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -482,7 +482,7 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 					struct hisi_thermal_sensor *sensor)
 {
 	int ret, i;
-	const struct thermal_trip *trip;
+	struct thermal_trip trip;
 
 	sensor->tzd = devm_thermal_of_zone_register(&pdev->dev,
 						    sensor->id, sensor,
@@ -495,11 +495,12 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
 		return ret;
 	}
 
-	trip = of_thermal_get_trip_points(sensor->tzd);
+	for (i = 0; i < thermal_zone_get_num_trips(sensor->tzd); i++) {
 
-	for (i = 0; i < of_thermal_get_ntrips(sensor->tzd); i++) {
-		if (trip[i].type == THERMAL_TRIP_PASSIVE) {
-			sensor->thres_temp = trip[i].temperature;
+		thermal_zone_get_trip(sensor->tzd, i, &trip);
+
+		if (trip.type == THERMAL_TRIP_PASSIVE) {
+			sensor->thres_temp = trip.temperature;
 			break;
 		}
 	}
-- 
2.34.1

