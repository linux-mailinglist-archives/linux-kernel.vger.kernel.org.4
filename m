Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219595BFB94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiIUJq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiIUJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9592F6C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t7so8855143wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=Zsrvb3mh+DU+uq04wshQdZ/fl6vUAZ6Rn+tYDUa9JYYGCFrCHQ94KJXrfUMzknkMoo
         1smMNmbkcAm3Ynlzpj6C7E2InZ749X67xqnIMG66QCrPVgEKUGPWyN2koqGQkSM/nHVz
         /g5BsZdUV6yl9tQfoKTDpLMeTtkS+uoDJBVOK/c0285ZckytjP3ytTHrg+YzqA4tfQuB
         LaGjRGHS+/tBB+rIybB8J1kt4+ru3Z4f/cSAeAa3SpKLInIiW5JEMscKVKA+WLBk5uMO
         sR9oPOevvrF6E5dhJYkO+u0L30vYSPv7qkjcW6DGo/FQpeTk2xSvEknXD8qfv2PIl12j
         Xfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=aBwqEBiNMxl/d7dNYtmahf3j7hKgMkW41Vn+6ezX4EFdCFnkj/OzZD7MTGn1762JGb
         52b4qquIFkF5fn25+GjyaAf63xs3dMOudmo3HjWXc7DS3E+wDFHExwKbH88ADRubRODo
         KN6qqIHYSnwGlF0XN2K51nGCMpJVQMJ/VrjDi2FqWZNNcEvZIrVVnmS+yK4Dsdc0JVOd
         ejXsOPMZ56VC4gB8jbsYYUBBhjaVGVB1LpfB+JWNaNQHBvO1mDQR5h/uwRNtjECGnT6q
         tFKaZSSi1oZz+Eyjz3f5ST7SU02K5TpykcXIhoA4K87v4O5+KOXs0oi/rsZiB+JQJ/cL
         Hq/Q==
X-Gm-Message-State: ACrzQf22DhBZP9xyzBpiZHrXhQ4M+Cy4aabQ8/Zwk0mHMcc9NEdmVZzZ
        4TisRomzuiZaTyC5L6StDHZYBw==
X-Google-Smtp-Source: AMsMyM7oleeE3uJP8SvXFvgO75gAdkEdMSFbe03N6TMcjxB2OAojRmiDVm7qragD1ndSLXM67oreug==
X-Received: by 2002:a05:6000:38e:b0:22a:e302:28e6 with SMTP id u14-20020a056000038e00b0022ae30228e6mr15168907wrf.595.1663753407844;
        Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:27 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 06/30] thermal/of: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:19 +0200
Message-Id: <20220921094244.606948-7-daniel.lezcano@linaro.org>
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

The thermal OF code uses the thermal_zone_device_register_with_trips()
function. It builds the trips array and pass it to the register
function. That means the get_trip_* ops are duplicated with what does
already the core code.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..5cce83639085 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -71,39 +71,6 @@ of_thermal_get_trip_points(struct thermal_zone_device *tz)
 }
 EXPORT_SYMBOL_GPL(of_thermal_get_trip_points);
 
-static int of_thermal_get_trip_type(struct thermal_zone_device *tz, int trip,
-				    enum thermal_trip_type *type)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*type = tz->trips[trip].type;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_temp(struct thermal_zone_device *tz, int trip,
-				    int *temp)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*temp = tz->trips[trip].temperature;
-
-	return 0;
-}
-
-static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int *hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	*hyst = tz->trips[trip].hysteresis;
-
-	return 0;
-}
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
@@ -626,9 +593,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
-	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
-	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
 	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
-- 
2.34.1

