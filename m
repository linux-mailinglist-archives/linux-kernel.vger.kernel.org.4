Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEA69C0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjBSOj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjBSOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DF21115A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b10so388088wrx.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVzYorydu8I+vmR0UzViLt9Y2MhZrZxLWqtLEYveqhw=;
        b=aofmVeNA4acxVVgFs38ZTZRtGVg1wncseVSzDl5/8tQx4eux9fWRapy4cjcddqKUyj
         fSKV/ecXnrtBICF4qVNBzsCvINfrypeVjF9aCENYJbGpDzOYhGnyobwA9kXWxxOQACLG
         eIFdMAEjauS4L+ffvALgbZjl5wzOGCsySkz6XE8orKOTkdb/ciDEkS0E/wS5P/DyFruu
         VXmxTK+03qoIyIOpLLXfSsSgtZf/J+hrQ0KIr/9JiT7rVEZoTxdoyZNQR2kt1WXrTvhn
         HrAr4oKSfdr5CB4ulHVQFXWf/KX5kOQKdEIWklXPQgoQVSq2KH+AaTSr048RjW8Fdw3P
         yeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVzYorydu8I+vmR0UzViLt9Y2MhZrZxLWqtLEYveqhw=;
        b=pLIYvJ0E7mn44IuwyQHvQ0EOGQz5QzmhLAXbYN/7NuHws6/vg0Bsuo3ZOTLGARAJZC
         yFPWlgL7x2dqkV7WQXqy6ngissNetW0sGUFLdnJtXtf9D3Adtq3bSNm0EMCTRHzOPz9I
         ENfz6UbNNv1HRTNFvYtbpUcOV8j/zrMbh4DqVTGww4vTy31GrvZow7H6XMfGLpVhmGu4
         462wcyJ8BL4L7dwAJZprRbjIrU/CdPLZCNgrhvBvv7QsWv/tp+gO5UhrGogS2DjwtWbr
         LfuubCS82wFU/GmnzUZl7lgM7kb5ZQDiwC8Z0aQaz9GJGfEXt0TSQaYjcArp4C86do4Z
         wPFg==
X-Gm-Message-State: AO0yUKXL/x7G8BPAdlwuIjA2K+V9IV+dm6b5un4V6VNSEjTI+36Dpgy8
        QiUh2bIuVLqnDUAgA4dd9WXkFQ==
X-Google-Smtp-Source: AK7set9+IMytDQLX5f4z3vq8PuxTWU9aQeQD3QlYl1Tn6AoFc4WJCWv4N4Be9Np6y+/oDZjmFWXR3w==
X-Received: by 2002:a05:6000:181:b0:2c5:49e1:b2cb with SMTP id p1-20020a056000018100b002c549e1b2cbmr1767154wrx.37.1676817493623;
        Sun, 19 Feb 2023 06:38:13 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v1 13/17] thermal/drivers/tegra: Remove unneeded lock when setting a trip point
Date:   Sun, 19 Feb 2023 15:36:53 +0100
Message-Id: <20230219143657.241542-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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

The function tegra_tsensor_enable_hw_channel() takes the thermal zone
lock to prevent "a potential" race with a call to set_trips()
callback.

The driver must not play with the thermal framework core code
internals.

The tegra_tsensor_enable_hw_channel() is called by:

 - the suspend / resume callbacks
 - the probe function after the thermal zones are registered

The thermal zone lock taken in this function is supposed to protect
from a call to the set_trips() callback which writes in the same
register.

The potential race is when suspend / resume are called at the same
time as set_trips. This one is called only in
thermal_zone_device_update().

 - At suspend time, the 'in_suspend' is set, thus the
   thermal_zone_device_update() bails out immediately and set_trips is
   not called during this moment.

 - At resume time, the thermal zone is updated at PM_POST_SUSPEND,
   thus the driver has already set the TH2 temperature.

 - At probe time, we register the thermal zone and then we set the
   TH2. The only scenario I can see so far is the interrupt fires, the
   thermal_zone_update() is called exactly at the moment
   tegra_tsensor_enable_hw_channel() a few lines after registering it.

Disable the interrupt before setting up the hw channels and then
enable it. We close the potential race window without using the
thermal zone's lock.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index ceb5b1b338a9..9cf74208673f 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -359,9 +359,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 
 	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
 
-	/* prevent potential racing with tegra_tsensor_set_trips() */
-	mutex_lock(&tzd->lock);
-
 	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %dC\n",
 		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
 
@@ -404,8 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
 
-	mutex_unlock(&tzd->lock);
-
 	err = thermal_zone_device_enable(tzd);
 	if (err) {
 		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
@@ -592,12 +587,24 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to request interrupt\n");
 
+	/*
+	 * Disable the interrupt so set_trips() can not be called
+	 * while we are setting up the register
+	 * TSENSOR_SENSOR0_CONFIG1. With this we close a potential
+	 * race window where we are setting up the TH2 and the
+	 * temperature hits TH1 resulting to an update of the
+	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
+	 */
+	disable_irq(irq);
+
 	for (i = 0; i < ARRAY_SIZE(ts->ch); i++) {
 		err = tegra_tsensor_enable_hw_channel(ts, i);
 		if (err)
 			return err;
 	}
 
+	enable_irq(irq);
+
 	return 0;
 }
 
-- 
2.34.1

