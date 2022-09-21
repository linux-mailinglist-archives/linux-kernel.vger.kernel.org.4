Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9E75BFB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIUJqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiIUJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:44:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA392F6C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z6so8963832wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=spC8itzQ8Zu07i902LsnviwBg3i7BeeP9FVIKUq6RuScZOrs7MWKBO1vka1Cq6kToQ
         tWwDlIHH61SlicyCjd+RY60+H8lN6jUsw5uopblNw0o2zrUH825oHPRZtIvp0nh2lmWP
         QdTTSg5M9MuwV+L1rcdvZQbdaNodY7rCfy2BmpwDYajWfGRvZh3fQzlV9GGQCVYkkZkQ
         Ta5g+DGqSYxnbI/DdgLLz+Pgu6y7QT/YwCTtZj5Arr9k5DUGsStM2+x5xs9trjChOD79
         CDTn0Z8Z1Op+tfkEoJfkyRiPTRjg+hBpbkHCea7ChHh2FXWM2bd3XsTULmcOI3mpFl/M
         frAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kNTESOeVOVH9BHNMsa7BlHA2jeppHM3L2UNE800z/X4=;
        b=Yct90kCyVsCgeOUtJZV9L6SkaJYjamb7vYGlBa4oggQCZ2aO7Js3NfAF3/MU8tIF1D
         mLAEg1dJrTY7zmpuRrQZNKMk5drhWqF1qJkwBYbttj4hITNvjxkteYqzGPAvIVavJ+lD
         tyFciSnReFa5ORx3pWdnez19MPMwhWA4SSC2OHXFAcpNKy3kUs3nSArEpBJQSfWJhPHp
         AJ5cyJZajKCr5KKyyxO8cVXQurXUihRVwqptWlFBJM6c3PEoUoBjEy1Qw0/cxV9Tkl7y
         C5LzCb9SqXKGwV7hq+5KmMNdPCoGmnBK5VdR70pvKKNpgTLk3jI4PgqMCAZstCQ8Jfsy
         HF+Q==
X-Gm-Message-State: ACrzQf3TIYWbV8aK8uVJDzNAiQ+chlzeJZxd5MXcPGr8bAQ/RNyv8dyc
        kJ1RLWiNn2EN9o9uP4e/t1RTEw==
X-Google-Smtp-Source: AMsMyM5CMzCtQp7qke8QoVEmBj72+j+rjWl2TQ32E2YQvISKP5i9p6jbY0juB+pB4xs/o1b1bVVuZQ==
X-Received: by 2002:adf:fbc7:0:b0:220:6004:18ca with SMTP id d7-20020adffbc7000000b00220600418camr16220603wrs.632.1663753437819;
        Wed, 21 Sep 2022 02:43:57 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:57 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 25/30] thermal/drivers/da9062: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:38 +0200
Message-Id: <20220921094244.606948-26-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
 drivers/thermal/da9062-thermal.c | 52 +++++---------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 180edec34e07..1e163e90d6b6 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -120,44 +120,6 @@ static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int da9062_thermal_get_trip_type(struct thermal_zone_device *z,
-					int trip,
-					enum thermal_trip_type *type)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*type = THERMAL_TRIP_HOT;
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int da9062_thermal_get_trip_temp(struct thermal_zone_device *z,
-					int trip,
-					int *temp)
-{
-	struct da9062_thermal *thermal = z->devdata;
-
-	switch (trip) {
-	case 0:
-		*temp = DA9062_MILLI_CELSIUS(125);
-		break;
-	default:
-		dev_err(thermal->dev,
-			"Driver does not support more than 1 trip-wire\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 				   int *temp)
 {
@@ -172,8 +134,10 @@ static int da9062_thermal_get_temp(struct thermal_zone_device *z,
 
 static struct thermal_zone_device_ops da9062_thermal_ops = {
 	.get_temp	= da9062_thermal_get_temp,
-	.get_trip_type	= da9062_thermal_get_trip_type,
-	.get_trip_temp	= da9062_thermal_get_trip_temp,
+};
+
+static struct thermal_trip trips[] = {
+	{ .temperature = DA9062_MILLI_CELSIUS(125), .type = THERMAL_TRIP_HOT },
 };
 
 static const struct da9062_thermal_config da9062_config = {
@@ -228,10 +192,10 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register(thermal->config->name,
-					1, 0, thermal,
-					&da9062_thermal_ops, NULL, pp_tmp,
-					0);
+	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
+								trips, ARRAY_SIZE(trips), 0, thermal,
+								&da9062_thermal_ops, NULL, pp_tmp,
+								0);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
-- 
2.34.1

