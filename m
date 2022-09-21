Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA845BFB8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiIUJqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIUJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2428692F44
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so849520wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=H7uUgV5bbaO8IhsA0NSgBx8cQTkdCMY13Map5H+yPhwkG1tjFGDj/3L9F5+Syn1WGD
         oxruQ1g3iQHEBtADdxkCsY9cxkvl0IICBlY569n3FO+p3No/uNn3rkQVEVRUZQurfKYt
         4h2XffbxvHrkH2XoJHdy2NstDcKoWuu+Yvn7YjhyZfP3qsIXOI2pxEB/0gK5GEO3VHtY
         UYBM4A/zXUody8cSgBJyjJd+25lL2gJZD00td5LuJHpsx0+ljyGvIz2hwQnIi9+TvdBy
         QZIevi7rRLS8zk4ssKYgz0djbsxR++NkuumLG76nUiEKDWhcOOO8OdJ2rGPHe4+ZWVUB
         bRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=SMzlKViLf6ylbs0N06Kns7jMXUxj60TgCIh/tuc8o9vY8CXjStMRepvB5CEwpkwKd2
         lK2LD04PO34Djh78isWF/JHLGfq/pjTRhUq2g2ffCMGGQNGo/nA25bz8HJjzmd3b8MCw
         Gy4FR8fiV37XD0kwQoy3Tk9dYbndT5R6tJzZatIMA2WEtGiN78GBNQhuhyi7r00lxsB2
         818j83cc558O3wYcP7mNmXjsjq6KC2hSIl+4zKRJM5LKYPTk66ws9K0RQC1OFwjsdP8Q
         lSIRMQdLdA7uVGxWR6j9Ck+7jHnt/+KaVgVHQG27z6bp0NwLr8NB4s06EqH90ulewC+T
         weyg==
X-Gm-Message-State: ACrzQf38VZyJbiD7y0zGO8uCB0aNEmvSXDCpmqo7wsQzPjjWPdU3Hvdb
        CjqWvQbq6Qm5lwXi6bxOwFLXpw==
X-Google-Smtp-Source: AMsMyM6Eo+bq69cC3CQibwo2iSeKRah3MVdlH4RMxCQH6V7JNTE0FdMNswpRvblkbci+zFv7/Un/bA==
X-Received: by 2002:a05:600c:2050:b0:3b4:a51a:a1f5 with SMTP id p16-20020a05600c205000b003b4a51aa1f5mr5044930wmg.177.1663753436656;
        Wed, 21 Sep 2022 02:43:56 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v4 24/30] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:37 +0200
Message-Id: <20220921094244.606948-25-daniel.lezcano@linaro.org>
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

