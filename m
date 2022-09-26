Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866C65EAA59
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiIZPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiIZPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6C382871
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:35 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z6so10444615wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=pRTzPS4VucxqbPjgMvXGtKhOH/eC6RPMSKxRskaJJ0oIdmzrfep+Anvh7x8gUg9DFq
         9vuDSLuCIq0s1oEJoup8xs4RWciI2/Qowlqk/CfsOtI/2G32yOl9aR3/siR8ijvV765L
         69G0De4pgYLY38skdsk+Q88isHA61exK7+L6FG6dLBFJGIWYyN+0pddH6a2Fa3BD5AQ/
         rIGkpDNf49imowH7Ijd+/cyKeR+K4NL5HSAGEnWhgQ8ov3d/K7ImBy6VMuk/hpiKSQqz
         8RVbUlArjmF7v/aJAiphhE2jq5DXAbVh5FQDte56lofbsXp5aKZp/EULOyorPJCLtkJY
         FaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=Xnlc+0ZotvKE/kWYgWeDCteMt/E2hVdu2M6V9eUIjkICoWCK09fkPi17CSxjl3WY6G
         K8m5URnpQWwtuTS6Xmh3I2Zn0Hk3rKNvyOS1EUovTyZqI110IzS5cjQQaz6XotdmCl8N
         byth4upq02e7pwc1iFkGOoPLkD7lQIK2h++M6uColS0u92DYq7HlyqR99qdlhG5Ww/+r
         5YzDCpYTe/s0kMxfRfOljbX2FJfDNmjWvQHlrIhsFK9iY/eZtbL87hKumJIJG1HA0gHK
         thjza9Hbtrf4a+K/LXnBQNFSu9YTUfZQNZp8njXDBvY0GS5/rguTe/ky0r/XLg0He5El
         KmZA==
X-Gm-Message-State: ACrzQf3M7ibMyH6U0dUlYOCm+1JkDTrWb+mMjadGTLIPD2hiFEbR1Jaw
        AQRgS3CyLGz01T9LthEdXaMdlQ==
X-Google-Smtp-Source: AMsMyM6TUZrs5KscYZv4KbmKV0JD99hbD9qUa3kk0L2ooG26LORx2BbUygrg9qDUyqqeIICw7Lcgzg==
X-Received: by 2002:a5d:62d2:0:b0:22a:3a88:e902 with SMTP id o18-20020a5d62d2000000b0022a3a88e902mr13602432wrv.637.1664201195088;
        Mon, 26 Sep 2022 07:06:35 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:34 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 13/30] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:47 +0200
Message-Id: <20220926140604.4173723-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
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

