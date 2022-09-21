Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42515BFB86
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiIUJpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIUJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C887192F63
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so4010316wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NFzfcStR9W+Nwf1uLdi1lXL2TUYpkWfd9XSuLVSwMnk=;
        b=OFhfxi08zetOvSfj0CGLPTauK+j/KNX61LmDyV4cNzbFtaIFiUB9OxpwZ3Sz7IgrR1
         ziuPAICaIKCarjrv6O6BHG6gvDpI2EqCz19QYay8UNrXxW7Fdi3SYmSzRBdDR1Gkx5Zm
         Ql3+y9//rZhWw7obN8XGkn6zSL++iO7X6/NMmhVkiQkVaPVdbiOaCJhuXoaIxoXbtocg
         1Y9W+jmYVAKxwk/FLJGrJyAsTkxe7G0j6MsNEEJBd23fbtPug1b1+fdug7YU2rOy8E82
         3t+i+clVnhEE13vD2Q9sW/muqy5yGAjp7wHNar9DfmJAXOKruTeNwGy6Q2QS6VynHkbx
         sBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NFzfcStR9W+Nwf1uLdi1lXL2TUYpkWfd9XSuLVSwMnk=;
        b=ZpzA4pQyG7u8bEbwxQWONk4e+37/TlH1XkoYkrczKeOSMy7/ioUr7GoDDqsi9JQ+gh
         OLbNlZn/7fBavde8rpEMAAfm2467hidRIamDgmk2cjDccnPur2KrJ3ODNdyPD2yrORG7
         +l5sJffBNijea/RmYzXLwh9onDfSdIsmFRSlNFQGuFh63zFLuufTaVv5osixUzJpPNpN
         DpIcx6E8QEEqSjtissDARRveDHKGJpGGKLOjr6KwJVRu8ioL+ADiK6I4Fx2MApXehY+l
         UDd4QVDFfDN3PU2q96N9g4bzhyo79c1QpTZLrMDjLXpeDs//GGhdH9oDWoW6+z0wzC8u
         hTGA==
X-Gm-Message-State: ACrzQf30Tafb3yfNdBqKSYDzPoE/XFLfz+XnO8pK+FUbhSEr/eSXZD3F
        QX+QUzUJcaT8wDFkQowvi0A/1w==
X-Google-Smtp-Source: AMsMyM54SSbst017kUHJ/kRvSaUTvDDuiwBy6e6yjxo/iFlnpkJnIf2iqh/R/keVni6O9LysJ63CMg==
X-Received: by 2002:a1c:6a0b:0:b0:3b3:3ed4:9bef with SMTP id f11-20020a1c6a0b000000b003b33ed49befmr5512802wmc.84.1663753428323;
        Wed, 21 Sep 2022 02:43:48 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 18/30] thermal/of: Remove of_thermal_is_trip_valid()
Date:   Wed, 21 Sep 2022 11:42:31 +0200
Message-Id: <20220921094244.606948-19-daniel.lezcano@linaro.org>
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
index 0139bc1e4f87..4d1af11a6eb4 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -136,16 +136,6 @@ thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
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

