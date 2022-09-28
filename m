Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602575EE6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiI1VBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiI1VBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:01:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F24D803
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:01:17 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso1520969wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=abNjzxC9KSYgYlQOmWQSgo4rKZqyrGSmTM4tjbmhmc8=;
        b=ebXZQzqLFM7RjEoQM6zsVXA6jDMD2WgjwN4nDLGZW8mHkCrbK4eH36HuGUvha7R+QY
         DfEisBb7GpqVukgcqjj2/XF6op9qUciWVIPdLSVv+zlAvbpGUaVCAvDem3AR548FA2Ro
         vCTH4UAIB1px1Sdw+yPZ2GHw4k79F6Qham0iaoih9HhM5wjfogpaw5aRx/qco0+C8rYY
         ikU7zGP/0YNCaxTcpYV3N0ddABmPOXzUXmyl4ZoEVYqwf1ccMbXBj9jyksltxH0M90QH
         h/ulB0oOJdmRLK7hZn4fcDvkkyKF9S+omn2RWC7DCTryAQptRYS78wuCwsQtChsXFJoX
         MGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=abNjzxC9KSYgYlQOmWQSgo4rKZqyrGSmTM4tjbmhmc8=;
        b=kTRYS+yah9atwiuR0A7UnFlIB+PaXOSjUWHqpFNya1yd3KQky0iNeMl3IsZRaYl8LV
         Dt2TESn4XMGGgcZJQWBFHyZrdOyOyD5EHVms4bI7QcMPqF7xCLC229cP6JfpW+TJtwKg
         ZJuMBiovBmodkeDpRvBqZKME8uWjO4e8IkmDV49mBEC9lG3rU+Il9u7LvfeKnHQ4U/IE
         hhy/4aRrQVNa3SPEwoByrLaAWTcRF75UDZiF64YHsdQmUg2k+Vj7g04vMOitMeugQ1b8
         2+R3hOd+A2y1JQkvwKqGOruUjrp0xOq51/hA1518a+NTvEOUm42XSS1VszJl4nEv47g1
         lrwQ==
X-Gm-Message-State: ACrzQf2AzAz4a3Qgt20KCh+LrLxCTc2f3G8QhS0x5U3SMzfZxRFg4Yx6
        FBb8rb9O9FQ1kn7ZZleSVZapbw==
X-Google-Smtp-Source: AMsMyM44FrfuMgclUbeBL+zv+v8tEfa13hMyWrP2ZUn1Nnam2wRAnNABfXvDzhNBoZcFcyOd37P02w==
X-Received: by 2002:a05:600c:34c2:b0:3b4:76f2:9c3b with SMTP id d2-20020a05600c34c200b003b476f29c3bmr8102729wmq.179.1664398876092;
        Wed, 28 Sep 2022 14:01:16 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:48a2:39eb:9d1b:8b8d])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2874300wmq.26.2022.09.28.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:01:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v7 02/29] thermal/sysfs: Always expose hysteresis attributes
Date:   Wed, 28 Sep 2022 23:00:32 +0200
Message-Id: <20220928210059.891387-3-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928210059.891387-1-daniel.lezcano@linaro.org>
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
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

Instead of avoiding to expose the hysteresis attributes of a thermal
zone when its get_trip_hyst() operation is not defined, which is
confusing, expose them always and use the default
thermal_zone_get_trip() function returning 0 hysteresis when that
operation is not present.

The hysteresis of 0 is perfectly valid, so this change should not
introduce any backwards compatibility issues.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index d093d7aa64c6..6c45194aaabb 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -426,23 +426,20 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	if (tz->ops->get_trip_hyst) {
-		tz->trip_hyst_attrs = kcalloc(tz->num_trips,
-					      sizeof(*tz->trip_hyst_attrs),
-					      GFP_KERNEL);
-		if (!tz->trip_hyst_attrs) {
-			kfree(tz->trip_type_attrs);
-			kfree(tz->trip_temp_attrs);
-			return -ENOMEM;
-		}
+	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+				      sizeof(*tz->trip_hyst_attrs),
+				      GFP_KERNEL);
+	if (!tz->trip_hyst_attrs) {
+		kfree(tz->trip_type_attrs);
+		kfree(tz->trip_temp_attrs);
+		return -ENOMEM;
 	}
 
 	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
-		if (tz->ops->get_trip_hyst)
-			kfree(tz->trip_hyst_attrs);
+		kfree(tz->trip_hyst_attrs);
 		return -ENOMEM;
 	}
 
@@ -475,9 +472,6 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		}
 		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
-		/* create Optional trip hyst attribute */
-		if (!tz->ops->get_trip_hyst)
-			continue;
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
 
@@ -514,8 +508,7 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 
 	kfree(tz->trip_type_attrs);
 	kfree(tz->trip_temp_attrs);
-	if (tz->ops->get_trip_hyst)
-		kfree(tz->trip_hyst_attrs);
+	kfree(tz->trip_hyst_attrs);
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-- 
2.34.1

