Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7285710DED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241581AbjEYOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241523AbjEYOCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2B6E6F
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3078d1c8828so2099709f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023330; x=1687615330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ItegjrGGv11f7pKzf7OY/tEt56zaRuB7g6O2qnWaWE=;
        b=u602UsgORyj8+WQfir0DgKNegXC6dcDBBELHq8gxS5Ipba6T6z16yPBMdx4vPoBo4h
         uWOwJtDjijNAJ9aUxqnEd5aFg5s0qeM71KrD6G5bzvBux8r/qAUXVKPIGrYRVEXkJ7GD
         n0gItdYiBPi06mIzuh+DDyi5fH/73jIFpVR2zzCrA0u4NogeKM5sEzb8YNbN8kdeOQiu
         08V2P6PVoPwZgWfvNOG3Doduihqpp+LGW1+sFQsiqmUd9VnpnnZDf1ERjOu75nivbcaZ
         ax1AFJa+Iy0UoHewlnsCQeMN3xufkW2xSvyI8KhvRqRCHK1Yyko8CfMHdlTGaTvwFpC/
         ornQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023330; x=1687615330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ItegjrGGv11f7pKzf7OY/tEt56zaRuB7g6O2qnWaWE=;
        b=abTjiqSAFw6lAKbHUll8ol97NoddfDnwU9qFnLcQFYpI98++p5qrYMqvtyEued3/zK
         tr0wdRYIefrMCObiNbfQ0rgXJJk07HmAd9J8eVbljPewkYRN9sJ9BsiCHslrdlrehq1d
         Jw1kevNJyXvoWa5IDp+O57DwgCnpyrrS14Beu2Ht5bHsKKN8lQb64MsPPswAips0Z++V
         di0Zsd03mp+cKDys8V6o4SZzx8AE2Ua4ZEbyDqo5MvYfbhl9J01eMtXkApsYtR3GSTQn
         oOTZgFPMNBTPzAv/0HyOasjow8nPChJIXdjBvMjtDLW/TesAvTJvvJrvrKRJ6kYkSFzN
         re7Q==
X-Gm-Message-State: AC+VfDw5/J/p9oeSw7r+kjRPJdCqDI//fbKpNPPPnYXVNJN1BVQKpK9A
        UxwLfOMU6M4MdybIftHopcxxLw==
X-Google-Smtp-Source: ACHHUZ5FJcIDH0IGIR9EZH+aqkLlq+kUdkJo9afvSvi2Qak2Ss7gX3cbcULnrr1M6Z0y+2mj+TFGog==
X-Received: by 2002:a5d:694c:0:b0:30a:bae7:9848 with SMTP id r12-20020a5d694c000000b0030abae79848mr1766026wrw.13.1685023330426;
        Thu, 25 May 2023 07:02:10 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:09 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 7/8] thermal/drivers/int340x: Use thermal zone device trip update
Date:   Thu, 25 May 2023 16:01:34 +0200
Message-Id: <20230525140135.3589917-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code takes the thermal zone device lock to update the
thermal trips.

Now we have an API allowing to update the thermal trip directly, so
use it and get ride of the thermal zone lock access.

Take also the opportunity to use the zone>-type accessor.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../int340x_thermal/int340x_thermal_zone.c      | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 89cf007146ea..94697063f41e 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -58,7 +58,8 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
 
 static void int340x_thermal_critical(struct thermal_zone_device *zone)
 {
-	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
+	dev_dbg(thermal_zone_device(zone), "%s: critical temperature reached\n",
+		thermal_zone_device_type(zone));
 }
 
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
@@ -215,13 +216,15 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
 void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
 {
 	struct acpi_device *zone_adev = int34x_zone->adev;
-	struct thermal_trip *zone_trips = int34x_zone->trips;
-	int trip_cnt = int34x_zone->zone->num_trips;
+	struct thermal_trip *zone_trips;
+	int trip_cnt = thermal_zone_get_num_trips(int34x_zone->zone);
 	int act_trip_nr = 0;
 	int i;
 
-	mutex_lock(&int34x_zone->zone->lock);
-
+	zone_trips = kmemdup(int34x_zone->trips, sizeof(*zone_trips) * trip_cnt, GFP_KERNEL);
+	if (!zone_trips)
+		return;
+	
 	for (i = int34x_zone->aux_trip_nr; i < trip_cnt; i++) {
 		int temp, err;
 
@@ -250,7 +253,9 @@ void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
 		zone_trips[i].temperature = temp;
 	}
 
-	mutex_unlock(&int34x_zone->zone->lock);
+	if (!thermal_zone_trips_update(int34x_zone->zone, zone_trips, trip_cnt,
+				       GENMASK_ULL((trip_cnt) - 1, 0)))
+		int34x_zone->trips = zone_trips;
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
 
-- 
2.34.1

