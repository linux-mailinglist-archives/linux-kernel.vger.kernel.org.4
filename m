Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85735EC641
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiI0Odi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiI0Oc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:32:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0C950721
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:32:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l8so6669459wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=rfouTixis30rRYkQFrk+ln930d6uzUs4TAsgPAC9POztjI8fDu4i6dkxv4fKye3XJp
         1In6G6k8VYxRw01yZ4fIInflEGmvMEOzKwjR4hSlhfgds7381dE2NwPcMkJc0eIZBY10
         rjLm0gj3supa43X9HUXvlAIcjKSEFksE317TCdr5lDhvMLYoZgzgXg/p6vAz1MxAo3XQ
         Agv2zxAH/OZvY6uKoHaj3ZWBFvqGFZtfMREXbKHW3XX0z1u117C5NdX+zUNSYhbZ0jfm
         j4J247hNCwXhxwoIBc0t/1oEcrYb1RpN46w7QmkOEluQkTvoNjbspilZMADJrYGaNP97
         L/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NVPF6vnmjrMx5FQU0j+pKHlND8VmvL5OT3fQ9b1KMis=;
        b=fjoCHXZPwNVWF95GBiScbdubZu5DI8pvENxpA57hFEZJARHQ+ToUZuiic55f9Sebqf
         3XU5eKn4DV6CsUhXCgwaiqLuTxCQmgt2Ld86nM6Fo/OjxyvwoXQ1HMOwl4jyx3QSzPhy
         /WRRdgoNY/QGnIDgwpbNybuSTU7nfUxxgtT/gpd7WzMASsy//T5F7MgMh9FqJXwRcqtu
         QlJMv2ylqTsdozxhqJ4QCgBVeBdg2+S+jWhK0i38xhAlBIS8B4CP1yExPoEiMDiSJOdA
         PwM//xMAKkG3Sj5dumZiNzGhCRHk3taMff4jr1MbxjgBGDXSqXiyrCmSmSk3tcpE9trs
         wlmQ==
X-Gm-Message-State: ACrzQf1oEds/uEOWMX8LZ74QUOZOfz1B/kOPbOxiDZbGTCK8UUi+74I0
        zaVqAK4dmM3e4xsrRrpYklEddg==
X-Google-Smtp-Source: AMsMyM60IWXw4nzGjnK2BFNDz8nbH8qalr1HEM2XyAQHtAygKWucxxtwnWOQMV18NKyeYC7Z/b2Nkw==
X-Received: by 2002:a05:600c:4211:b0:3b4:6334:9940 with SMTP id x17-20020a05600c421100b003b463349940mr3020567wmh.166.1664289177231;
        Tue, 27 Sep 2022 07:32:57 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:32:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 05/29] thermal/of: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:15 +0200
Message-Id: <20220927143239.376737-6-daniel.lezcano@linaro.org>
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

