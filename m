Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D055EC64A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiI0Oep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiI0OdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255CC9353F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l18so3316262wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=T3SlIKEv0zADO1dZOhwif0afMh/nJixEenM7GZG339pBszZvqi76IjZCG/IKHvGUQ8
         jgQ//fkxNJIKmm97NZRaHWbfDl9E4sdvLTmdwuNhzk1c0sMdFyCZ0AyYZ+OYDjcpEf5u
         PY63R5T9nz1eeCN24VQ4x66zC+k9wH63IeT5pWU44G7C+53v8ObwSM+D3184J/DEtsHh
         1Jh5kA+MR02bj9MI7p9/rPxGKq/85YGmBgt9c8l15OPksXMuIOdshdbXTV3gJgPG9uky
         i+oL8Q+MSs3+kXoBkUHox5vT6bSv/1zbuHDE2/V+oti9O8Hys/iOGMVp3cKuhqFGrP6o
         dVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=LtAEiS2trb+rxUQYDkhK0htkuWMFBtgTbdcljl0WWKwQYns6aEgwK+rqIoIIgJ1XZ3
         13vs6gmPJqQ6f3R1cQOT9oRLtvpwOp4QoyfAZgnaS1a15ogY2UTNqw2KH85TbM7dmWJs
         TfWxCHIvPLsq6s2Mn4Q1pBj+94G4LqV1445YT+GFhG7nJAnw7yJGVFwehFACF538nNLu
         szRGoYJJIZTYB2O3lqP5UQHEC179NTOC9M6Di/485WUCbS1LYLyrpzuvE2sLbla2lmwv
         bmzQW4Nv7Yu+FY+CRveiH2jLfWJxCrXZhREG5EoqK9aFdTLlaK6Wmlf49+ztdQirFUw+
         TFXw==
X-Gm-Message-State: ACrzQf23zOST+xZ5wl5VSZhh+IVd/bd0HRY1Hqve4gUDTUqhGklE7Qhu
        ZShGWuF1FYFox9qbSrN+1yyGDw==
X-Google-Smtp-Source: AMsMyM5FquSYSr9UGupgBGmDiyruXPisb4uzaE/67pnNAbuh9NFyH/Ujj3u0nXa6cjIYO2cSRsLoHA==
X-Received: by 2002:adf:e9ce:0:b0:22c:ae77:b75c with SMTP id l14-20020adfe9ce000000b0022cae77b75cmr5312569wrn.380.1664289196141;
        Tue, 27 Sep 2022 07:33:16 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 18/29] thermal/of: Remove of_thermal_set_trip_hyst()
Date:   Tue, 27 Sep 2022 16:32:28 +0200
Message-Id: <20220927143239.376737-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

The thermal core is providing the generic thermal_zone_set_trip()
function which does exactly what the OF ops function is doing.

It is pointless to define our own version, just remove the ops and the
thermal_zone_set_trip() will take care of it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_of.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4e54d62720dc..494e9c319541 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,18 +19,6 @@
 
 #include "thermal_core.h"
 
-static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
-				    int hyst)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return -EDOM;
-
-	/* thermal framework should take care of data->mask & (1 << trip) */
-	tz->trips[trip].hysteresis = hyst;
-
-	return 0;
-}
-
 static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
 				    int *temp)
 {
@@ -541,7 +529,6 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
 		goto out_kfree_trips;
 	}
 
-	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
 	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
 	of_ops->bind = thermal_of_bind;
 	of_ops->unbind = thermal_of_unbind;
-- 
2.34.1

