Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F12679AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjAXNxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjAXNx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:53:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824E34957A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:51:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so12859233wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KeFsLzGCqHOmLoq3WaiVqhzSWU0bcZhMSI7GPr+4hM=;
        b=kiPlOFixsP6261tglxcomRwMECun5vCh3UCI9DA5wkN0ooI8SqUUURqeyQJs2RtI/t
         r3JwBy678qo4rOFmyog+Os1f8DbELQYZBlBkbCUikbnaAGwxhVs0DodpIxj6ku3mv2lZ
         d3f+QR/d/AGRfNkjo8ivadBLxcXHn2kiUrsskJfCbCjLmmAsrDLiWYrOl/OyVf+3bP0Y
         Av833Q9KawSnvsgdSHJk1Fs5iJg05ciW7jeAqAC/rgQKNQVVPY/MHx6SMoHk3UfWAaTm
         mmA/aRHv31o8VbAR7phtlYCLQ46YEboe+PcDt3SgaNGJEkttwLWgvKTZ+jDzP7zQOCMC
         4avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KeFsLzGCqHOmLoq3WaiVqhzSWU0bcZhMSI7GPr+4hM=;
        b=Kzv5+HsLMRZeiH0Ko7cyQHxHBHoo4pKYqXEKqDY+ilz7OnSJ9/enX4sDYzNtYrHZjG
         tssxZvGFGFIlwAf183HEv6PzGj8ud41QdlivFJDnsRdTxG3ME1brfm5WXAptinkL1y/e
         FjQXzd4zo6viwo4Z+EusQOiL/kGp5/6kpShmAxkiOKREaL7waqOy9MEVy1Viy9Tmh1ND
         JDi5m1sVRTnh8w5PNnmL6rnMbV5yhmXv4wIgMC5Y/cLfsfuH7MpaaLoyg7xhcNWoF1Mh
         iv9ZRxFS0Xs61rRydahzlE8tgUMUpEFBNo5bVdQ6vuoOEAkcjB7xUlpktgfSVC1CaN9q
         karw==
X-Gm-Message-State: AFqh2kqMWMJD9XR8rm7kKqMARiXSe1cZZmXFIJUCIpgNQi4z7bbgvXEG
        CIk8980GDJwyW2tz0+0vCwMhQg==
X-Google-Smtp-Source: AMrXdXsDT+iit7s0CkWteKjN4rmdKAwLV0C7kklLnqQ22Hh8uuQwD9YXbjPaSt5L9HD9kP5hLfjByw==
X-Received: by 2002:a05:600c:1c8b:b0:3d9:f492:f25f with SMTP id k11-20020a05600c1c8b00b003d9f492f25fmr27372163wms.16.1674568237200;
        Tue, 24 Jan 2023 05:50:37 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id j4-20020a05600c42c400b003db1ca20170sm1972507wme.37.2023.01.24.05.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:50:36 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 2/3] thermal/drivers/imx: Use the thermal framework for the trip point
Date:   Tue, 24 Jan 2023 14:50:22 +0100
Message-Id: <20230124135024.366486-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124135024.366486-1-daniel.lezcano@linaro.org>
References: <20230124135024.366486-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework provides an API to get the trip related to a
trip point id. We want to consolidate the generic trip points code,
thus preventing the different drivers to deal with the trip points
after they registered them.

The set_trip_temp ops will be changed regarding the above changes but
first we need to rework a bit the different implementation in the
drivers.

The goal is to prevent using the trip id but use a trip point passed
as parameter which will contain all the needed information.

As we don't have the trip point passed as parameter yet, we get the
trip point using the generic trip thermal framewrok APIs and use it to
take exactly the same decisions.

The difference with this change and the previous code is from where we
get the thermal trip point (which is the same).

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/imx_thermal.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 0d94d4baea33..c115a696e83f 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -332,26 +332,29 @@ static int imx_change_mode(struct thermal_zone_device *tz,
 	return 0;
 }
 
-static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
+static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip_id,
 			     int temp)
 {
 	struct imx_thermal_data *data = tz->devdata;
+	struct thermal_trip trip;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(data->dev);
 	if (ret < 0)
 		return ret;
 
+	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
+
 	/* do not allow changing critical threshold */
-	if (trip == IMX_TRIP_CRITICAL)
+	if (trip.type == THERMAL_TRIP_CRITICAL)
 		return -EPERM;
-
+	
 	/* do not allow passive to be set higher than critical */
 	if (temp < 0 || temp > trips[IMX_TRIP_CRITICAL].temperature)
 		return -EINVAL;
 
-	trips[IMX_TRIP_PASSIVE].temperature = temp;
-
 	imx_set_alarm_temp(data, temp);
 
 	pm_runtime_put(data->dev);
-- 
2.34.1

