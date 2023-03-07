Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BCD6AE0C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCGNiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjCGNiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:38:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0281025B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:37:59 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az36so7790736wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678196278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjVs2mfF+5OS1VMRPgk5J2R/XS+QKw7GSrWzqh0h9oE=;
        b=nwuS1n1dGQucPh2XKQbKMbOfHQRb0TXCyHjqV8hQgGiVYUnv0Z3JoxSW+QcolIIoIx
         KeP+LoD37PZSFj1miZWKNKd6cf47xdV05BRMhAyd0n+h7HXQ5MD0UA1CZUPtdge59bPX
         X3yl2i2+ZXMnPdjps2s4t/n8BjImhsnOmUzRdHGT4V8hSkxpcwZgpxakbO56kEjzLtNs
         e+aEFbPjVqMBaygI1zsl/2MZsMjItMSs3LTCaJyWJhb0sLDRFZXFOabMbcyVeapHf1k3
         Ats2QvQeA8o4+B45RMyqkJNqoxVUdxPQKUgWlZ6VIYugABEn3NSbi5gHPXfxR2+mt6w5
         PBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678196278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjVs2mfF+5OS1VMRPgk5J2R/XS+QKw7GSrWzqh0h9oE=;
        b=sc6x5ncAGzz+Prz9w97Ix9dPqfEnxja+hh+FTSuxtMJ4tTnxiRK9zSkIJn7yLXCJhP
         qCH27xPe0FAJ9lL9KJM28fdbbw7g64mYKv7N+hWL+WB0evsOHZVV740PQLoM+PTAzLF5
         Qj8WjohCC4ZveAAR3w8advIPYdV/AKJ2fasMJtm/5blJ0BLS3gFhqld++LzhWmmfnBGs
         qsWihpMHwMh3UZe+eml/S5NnbFMGgOly1dJmQe3mBojKbrRQG9hBm8Y8Er9F9CkYnETB
         gIA7v0oX26r1IAKmQM9ObE/xDaBEkOCj+gpS4BzNJftA6wnEUVABHOevmdpz3vY8mpa+
         Dcgg==
X-Gm-Message-State: AO0yUKUJ7bC5g4IgbQdz+KzNXp281DGT498Iz6gvu72OCDidLCyvQ4NW
        rWIaEnVM/rRtxT2hzNoUD36Id755ps6a9m37s/E=
X-Google-Smtp-Source: AK7set+QqlE9Bn/nNAwKCGRX2rPLbgBL7L/YeIJ1qEiaPgZwrdF+xKnMDrwXF7my9fvBOXimUa8Jrw==
X-Received: by 2002:a05:600c:ad3:b0:3ea:e667:b1ee with SMTP id c19-20020a05600c0ad300b003eae667b1eemr12281365wmr.38.1678196277915;
        Tue, 07 Mar 2023 05:37:57 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5ab9:1ac6:870d:35c])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b002c55de1c72bsm12311477wrr.62.2023.03.07.05.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:37:57 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, amitk@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 04/11] thermal/drivers/db8500: Use driver dev instead of tz->device
Date:   Tue,  7 Mar 2023 14:37:28 +0100
Message-Id: <20230307133735.90772-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307133735.90772-1-daniel.lezcano@linaro.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The db8500 driver uses the thermal zone device instead of the device
attached to it. In order to prevent the drivers to access the thermal
zone device structure, replace the thermal zone device by the driver
to show the debug message.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/db8500_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index c0418497520c..de790e526ca5 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -53,6 +53,7 @@ static const unsigned long db8500_thermal_points[] = {
 
 struct db8500_thermal_zone {
 	struct thermal_zone_device *tz;
+	struct device *dev;
 	unsigned long interpolated_temp;
 	unsigned int cur_index;
 };
@@ -114,7 +115,7 @@ static irqreturn_t prcmu_low_irq_handler(int irq, void *irq_data)
 	idx -= 1;
 
 	db8500_thermal_update_config(th, idx, next_low, next_high);
-	dev_dbg(&th->tz->device,
+	dev_dbg(th->dev,
 		"PRCMU set max %ld, min %ld\n", next_high, next_low);
 
 	thermal_zone_device_update(th->tz, THERMAL_EVENT_UNSPECIFIED);
@@ -136,7 +137,7 @@ static irqreturn_t prcmu_high_irq_handler(int irq, void *irq_data)
 
 		db8500_thermal_update_config(th, idx, next_low, next_high);
 
-		dev_dbg(&th->tz->device,
+		dev_dbg(th->dev,
 			"PRCMU set max %ld, min %ld\n", next_high, next_low);
 	} else if (idx == num_points - 1)
 		/* So we roof out 1 degree over the max point */
@@ -157,6 +158,8 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (!th)
 		return -ENOMEM;
 
+	th->dev = dev;
+	
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0)
 		return low_irq;
-- 
2.34.1

