Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C509C5EC65C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiI0Oe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiI0OdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD761D5C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:09 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bq9so15328930wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=LFuOvlKG90LD6P79v8aSbVSzwMi/qE+qT5I6LDFo0rHPIdPbtk/sxvHOgANi7AFokH
         rh3T9Qddxc3z785OAeMRn1QcnS8K5rJAWqOnw9OHzSG7QHxWHh8A8gfRI/4DI93e8JRS
         47K5wuV7e0P5+FdrYF3ZfZA1v4PrV36ien3Y0dYrYkH+v9U2Se1N3L69qmId4xn4tcoo
         Fgi5H3+p1LLHV2PEDdVQ6C9WnfXjjRzFSTcGdj/eE8dsrzoXLyKaoKD7Hn6w1M0nP5eZ
         TfFx5YIW4SDs8AmQF2tnMIC2oIEpl971Cg90OUI+c/JDxpluqx0Mjg6gXGa7lVtt6noR
         X8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F16FcP49uIGOwU3Sf8ns9eXu8wz72Lx9ob6lOEA95bs=;
        b=KzgXm57tgsiTc8DAKnnaxnnHZMJ87i8/fvao25rrVVW4jpyxxHOG1rNXiXx2ZAEYpv
         9Shi+IGn2XfeuQlbFx7pA7YN8tbwMe3ZQkFh1jbF5n01Ct6popFKfleYt/r54u8ClFX/
         JM4io8oN9WeBzOnrqVZuFcZx7VNQIz7yX8qt+1QIrI52EbrwskVUeRQINXAVL4kYaNdX
         r9oR63yBtUnQNanhmLi57esG8wSCTo9CIECjcdZmEdOh9Jmc/hOrF3uZ2UI/VmhbXdS3
         wNfUtVllEvAU7cU0YhAl4t1wvV+9OeV0L/dx9MeWG0IN5Exqu+jtDEaCI5WtjdpaLszR
         Mazg==
X-Gm-Message-State: ACrzQf0yQOkgNS+j3xs7tu9/I8HrsJws44PQ+TMSMp4DrL9i2bBcdjYA
        fogDkr9xWIUhTwNPaE7ljMMXSl0TsZt9AA==
X-Google-Smtp-Source: AMsMyM4js2Oa/GfoXq436lDee0C+68Qy6ZnBixlUVLNv71+CxYJwbxbVUyNdnJynCw5FyS+wTwckGg==
X-Received: by 2002:a05:6000:118f:b0:22c:bebb:1a42 with SMTP id g15-20020a056000118f00b0022cbebb1a42mr2026375wrx.540.1664289188651;
        Tue, 27 Sep 2022 07:33:08 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 12/29] thermal/drivers/hisi: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:22 +0200
Message-Id: <20220927143239.376737-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

