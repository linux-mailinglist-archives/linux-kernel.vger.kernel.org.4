Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E75EAA65
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiIZPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiIZPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E021B8304E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so3782665wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=z5G8IkXBIKXhd7qT+UB7xxqOj6f3Eq8ax/RzqIl0XorZS+Xr/fqHotZJoYnnDaLgYx
         RU+AboprBDINIgSrCT17V2VQkFIcIl1hD9e+vSnbHnoV4QqqR++JiOL6d9NPipzK5/TI
         dX+38uP4uEZLIq+g1Xuomd5NqZ7tgSU8w0Lod1GFR/FbDnwRARfTg2BZ8DzmoiYLndqt
         SFrjMRemT9KbH8hl8wieeTrr/D1/TQ05iMXt9YvSIhkzgcIjA2wkzutajp8ld2X+E/Mu
         mLyMagte7bGjcjht40IFMoY9KDdNRe1SR2II8S3lY7R5RHdIWdU0MGNpEITtZTihHq8m
         ILMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vcQTbtSOs9FbsFbv8V2t/E69I1IFg9ZKCW8F5npsSmY=;
        b=zUcapnW4NmQwLwyiIUwaSPdlzi0DZBYqmDGEp+9NNKj+7quxJEraziul1YDzTYDvk+
         iMEM39fxO6ucL9XgeOi4OvJvFWTvHxCeG03RrubD2NtH40XcCxeuRUMAZAbnz1A/0aI8
         lu4XwalDGE/tPF1nEHCBWNJC/ntFMf5NNQbxw4S732ySswC8u3DNjuinNUVEtsx3AGt9
         6ou14Rv9ALORO5dPcpAGrVRex+itjZBKRN51G/ZAnVCTP0R9KD6PzMMC68pEh8CNE82P
         U7CMjbjouBLWyNm64AiRleDCUV5ydoPpYIW9uO2KoFSkjvSDOt+WTtAaPkRBx3nNrULm
         l8mQ==
X-Gm-Message-State: ACrzQf1IvIcdLqploTV2HToXqheKAWMlSsJqUoAMWSecG0F6YLAr926U
        +reGub7YUENsiAKAG5iPOf6b8Q==
X-Google-Smtp-Source: AMsMyM513Uavgx2NJuLiJ2uLHUthzvwVsVfjgpzOEqdTKG+7IuRHAT8POOi+Ek0OBjiSxJDR9lp2cg==
X-Received: by 2002:a05:600c:3b1f:b0:3b4:b1fc:4797 with SMTP id m31-20020a05600c3b1f00b003b4b1fc4797mr22404966wms.129.1664201202274;
        Mon, 26 Sep 2022 07:06:42 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:41 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 18/30] thermal/of: Remove of_thermal_is_trip_valid()
Date:   Mon, 26 Sep 2022 16:05:52 +0200
Message-Id: <20220926140604.4173723-19-daniel.lezcano@linaro.org>
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

There is no benefit with the of_thermal_is_trip_valid() function as it
does the check the thermal_zone_get_trip() is already doing for the
sake of getting the trip point.

As all the calls have been replaced by thermal_zone_get_trip(), there
is no more users of of_thermal_is_trip_valid().

Remove the function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 10 ----------
 drivers/thermal/thermal_of.c   | 19 -------------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index b00fc1913734..e9b3af6c2084 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -138,16 +138,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 #endif /* CONFIG_THERMAL_STATISTICS */
 
 /* device tree support */
-#ifdef CONFIG_THERMAL_OF
-bool of_thermal_is_trip_valid(struct thermal_zone_device *, int);
-#else
-static inline bool of_thermal_is_trip_valid(struct thermal_zone_device *tz,
-					    int trip)
-{
-	return false;
-}
-#endif
-
 int thermal_zone_device_is_enabled(struct thermal_zone_device *tz);
 
 #endif /* __THERMAL_CORE_H__ */
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 89afa59c4915..4e54d62720dc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -19,25 +19,6 @@
 
 #include "thermal_core.h"
 
-/**
- * of_thermal_is_trip_valid - function to check if trip point is valid
- *
- * @tz:	pointer to a thermal zone
- * @trip:	trip point to evaluate
- *
- * This function is responsible for checking if passed trip point is valid
- *
- * Return: true if trip point is valid, false otherwise
- */
-bool of_thermal_is_trip_valid(struct thermal_zone_device *tz, int trip)
-{
-	if (trip >= tz->num_trips || trip < 0)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(of_thermal_is_trip_valid);
-
 static int of_thermal_set_trip_hyst(struct thermal_zone_device *tz, int trip,
 				    int hyst)
 {
-- 
2.34.1

