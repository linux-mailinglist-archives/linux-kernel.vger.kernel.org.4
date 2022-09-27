Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADE5EC677
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiI0OfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiI0Oda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5A9018B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cc5so15314279wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=k8h9lvDET/68SfhS9eSROv/pLI+kzVzlDtP1wnyeA0Og+Q9nmzMmAfzLTwVM0QyiRN
         bYdCuTSQGqoZuKD/P7klIMZxMzkD2UhPJOJV4A+bOHkCJfxQM2YmXpg34OyI7iSmBxcn
         23WV0d/LO/38lNgwKwZc7CqNfjBTxm7Kcwq0NduReGCF7udLJEO+cewAux52hmaHN7RV
         IL0DsyCxPTvCA/+ptYFFGVMs2JVsU1X9RUwsjPLygk8n2b9tS4y0HjJjMe8m+j0e11hM
         JGivnKjaI79qX+asnRuPa8QmT4AAKZsGYiI0Qjxs+7cc6jiudc7hdt9DEGHLv3xkhxnF
         6dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RuOkdBUevpNwOF5uxKYPUxVuiSYnY/XeiYrwbyLTKVs=;
        b=LjsfSnMpCS2XXlCzAdWI3gkyxXIX3ulnb7r0ZlkjWpuE4/Bp4k/7aDbtumiXDDbiGJ
         zlpUtCn17DnzVHleWFUmIWtB4yj2Co5vT0E6IVf4GDyj5nJkBiS8vpo0bFtvB/lRrRfl
         PWAl8+ddReQvspJGf3CPyTicEQzGaoSkh0jpScW9ZATANUB4hClIAbe1IJxyZN9Pezmx
         oF243tpdAVb1j7V6WIZ3E5Z8FaUl39XhT55uBlZh5DoFBW8sgft2DL+SEUXbKEHAREg8
         eifmTNpgN5gjGreQIzSUbx4Tewnu9pBH/qWXISIYTCjd0ldoiRH+5nKkdBF2CpGa1s9t
         Ljvw==
X-Gm-Message-State: ACrzQf3zDlv0vv/1m8kQyCFJkxhJQCmlvlPWa0/74lObgeEbUY318VlN
        wg/Y1+rPaV2gDdPndgkY9Ugtzg==
X-Google-Smtp-Source: AMsMyM6lFx3bEN+boegewxS3Me7Ygx9201Z5Zs+qWIIPdE3RKNXQ9iptgbbnB1UXfy/E5uHTTJJwzQ==
X-Received: by 2002:a5d:5a15:0:b0:228:cd90:ccd with SMTP id bq21-20020a5d5a15000000b00228cd900ccdmr18304306wrb.658.1664289203517;
        Tue, 27 Sep 2022 07:33:23 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:23 -0700 (PDT)
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
Subject: [PATCH v6 23/29] thermal/drivers/broadcom: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:33 +0200
Message-Id: <20220927143239.376737-24-daniel.lezcano@linaro.org>
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

