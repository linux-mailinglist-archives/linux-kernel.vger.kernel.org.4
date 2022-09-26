Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5F5EAA69
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiIZPVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbiIZPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D38983060
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o5so4603881wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=EpvKvHSwStgMICfq57+AHEBgNTsZCGHu4zDwSNFuBuPQ2UEKfocQK/30SpAMYBT1F9
         GCSYXU5+D4iBDFg7NUeec7imLqJ82HssPSs/tIv0TLYebUEQT0kqYQAauZ3iGIAkL6LS
         QsFBYx71/vqTlKvlVQIHddyArmUbT5QHln/Ld/kmDubpbo+lYkpkXvPKiWcZ4pmoY5ss
         ILtGblkDQxADV8Wb6oYOrVeDR3cmBDH565RIp/7DOcoKVk33Tjw0LEzfeemw1uiiStvj
         21Bsg/z72x6H7GcotuoMIYjMu6IIQ7H5/l+30+rVBCh3RKg4Wu9cvQDlCDoB+wgMM3MB
         CQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KY22MjtoUlIwWIKxWwfuHh0wn9QBG3Vjtz/Dduvf6bU=;
        b=UKY5VCk/gDf6W6ryp/f/5rLoKfkQR8Thm/xInSOsP7vIvghesFL4L544wehQNzTPZm
         D2xN4DF7srbtqI9GKAMsroRS8zurWKZGJxQ2Dxe2vi46vD2BJOYdX4RIvfFRIohDgzjf
         j5GfI1w2k5JbicxcJuvHsja6fHlpeMvqpyYAyf/RRvv4jU+gLtU0e3wF178eBpTQ2rcO
         n5rhZe79T2eS2Q4xtBaTxjecx67N39BA/vNPkkQiHCKyjeB+DSr1xBBAfz95D3n8ChhY
         MalwMaD9JOYzwj87bI5lN8o2YuzYyauUyBUmjgVfDUZFas4q0bGn0F4y1kRdPZ2Zcrbe
         ayww==
X-Gm-Message-State: ACrzQf29IfEYoLduLJZTEGNTnLzBy79CH2RJXY5aPTvFpr+bNvdIO0i7
        zJFk0ByXjqMFy1uJGcMBwRmNuZTkROKyWw==
X-Google-Smtp-Source: AMsMyM7ph8+YGuzkaWydlGbxcmLfQj31Wy1YMb/EFgCFTEjKDhVspNRf4G1OwUurnCUM4ZZJ07FLpA==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr21728823wmb.20.1664201203569;
        Mon, 26 Sep 2022 07:06:43 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 19/30] thermal/of: Remove of_thermal_set_trip_hyst()
Date:   Mon, 26 Sep 2022 16:05:53 +0200
Message-Id: <20220926140604.4173723-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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

