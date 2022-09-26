Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92CB5EAA70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiIZPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiIZPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:19:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D04832DB
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:55 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso7560723wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=T+qYO3llwUwso32BkYS1kv3SBonRyZ9HsFQWCOev8fDPELdQc56lwcRjbNa63bPjsJ
         AaK79jaNovAimi7tlaHVhvniTBHRV7hW+FOu/EH8GGJxIzm065Bpps4tFmlkiglF1UyJ
         RnQ3bbwNQ63gu6tEXBSnBfG8Py9YJIG3Dcl/YjXeLnBvraZGS5nXDqDrpQEho5uBlrjt
         xqWiHi+aqbEOkvMk15ibG+u4pIZ2zH2B863kKw+d1p9a9uC+MMkm8zfiw4qY3EkLRqXv
         nwrLU3IZNbo00BYmLVBQaCM+zUNbvGoV/Av6zNt0VbpME2DMw6Lg9Pd4jJWulb6djHL+
         tKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=cPart4wYrPBCgeqpnBXDr+8ZEci/iGmntGigmS5WFJHwF8Qit34RlptFoB4wjV9cBq
         5fHfeCYzNilf6CXMmg7ZQLbVwyJVzI6uxIZeNBRq82nJHetNUj+rL9o+zOAJaVr/EK2V
         7Dw4V1xX8cNqiHtG89ASO6CoK5PR7vWb4Hfn2h29QVoMs2CWvRND+gihALOgptT1CWDE
         1DNv7/SjpDFsOEC2y+vQ+8TwUKxQNlx2DzprNaJop4cjUN68jEtVgmm16pbCexHPsDB5
         fTb9zkPiwq6eG0b97MgkFzLMvLvzcF8YPLSrgxoh5IxR2aSct6Io/qh1Vyi1DXjf7paA
         d2ZQ==
X-Gm-Message-State: ACrzQf1c0wkVJfOt1Y1UnLrLPvUG+d6WmcT6ecxCxWF179F8derYI7rd
        sOM3bDaVVa4O1+ezgK7VV71iBA==
X-Google-Smtp-Source: AMsMyM7KmIDtVH4wXUQBQWMer4IDmi6aj2W1A3NPf9b5sqTNvsh7yYTzc41bHp9m8L4yiccyBTvqTA==
X-Received: by 2002:a7b:cb41:0:b0:3b3:34d6:189f with SMTP id v1-20020a7bcb41000000b003b334d6189fmr22308524wmj.6.1664201213772;
        Mon, 26 Sep 2022 07:06:53 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:52 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v5 24/30] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Mon, 26 Sep 2022 16:05:58 +0200
Message-Id: <20220926140604.4173723-25-daniel.lezcano@linaro.org>
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

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 2c67841a1115..5485e59d03a9 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/thermal.h>
 
+#include "../thermal_core.h"
 #include "../thermal_hwmon.h"
 
 #define BCM2835_TS_TSENSCTL			0x00
@@ -224,7 +225,8 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	val = readl(data->regs + BCM2835_TS_TSENSCTL);
 	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
-		int trip_temp, offset, slope;
+		struct thermal_trip trip;
+		int offset, slope;
 
 		slope = thermal_zone_get_slope(tz);
 		offset = thermal_zone_get_offset(tz);
@@ -232,7 +234,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		 * For now we deal only with critical, otherwise
 		 * would need to iterate
 		 */
-		err = tz->ops->get_trip_temp(tz, 0, &trip_temp);
+		err = thermal_zone_get_trip(tz, 0, &trip);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
@@ -249,7 +251,7 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		val |= (0xFE << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
 
 		/*  trip_adc value from info */
-		val |= bcm2835_thermal_temp2adc(trip_temp,
+		val |= bcm2835_thermal_temp2adc(trip.temperature,
 						offset,
 						slope)
 			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;
-- 
2.34.1

