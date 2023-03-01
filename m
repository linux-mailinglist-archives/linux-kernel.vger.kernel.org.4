Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690D66A7514
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCAUQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCAUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67251F88
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so264065wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koJPR2fTStLYORfVp08sS7+PQVK0D33ZKiTZpjngJoo=;
        b=SBVcWfNmCmLQAwaNijwS/wnXrU1y3WvMrSoMghzjYjl0kvFkNMInBeeJZdFABFHmo0
         WsBH9PAEK1WyhcG0S2o5GhPdcPflLJvSe3ee72kSNxlc+Avrw3TyI8t6Xc5sBr6WukqD
         oGttmqKYRrutn8kIbY3fyKh4Sta8TvN38JDZqitiEp00lpU1D0Bwo4DVGnLILMdjSAkz
         FD0dnmxKFZHG7NPaKfT6Bw104u7ia/tuXSWp+hAWb9QBlDn2HrPr/qsYq+Yb5woR/4pi
         c6OQ14RqG8CRMqNfe+uZGTKWjurbEHKLw1wigkauculhTEEALJx8tiyOTXCY1geTrL+X
         1ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koJPR2fTStLYORfVp08sS7+PQVK0D33ZKiTZpjngJoo=;
        b=PhtRSmTENWbGXHbjXN0zOO5qmb9XyxfpebUDTS2Yy3o2+m+PBZFF7JEYq+GoSxB61T
         k/M+LMrE3ac4K85s8YX+UmzrzHT567IxIDepAq1uTdub026vkbzqZoaNzhTNFCCIY7Ab
         80XDXEJFo/UVoNDhX3Y+FQ8wAu2fvoQfqB4vTUeObH68LlGuEhn74Wp4Cwi4dpinhBT7
         cZh5+dJNPR8a4fOVEi754Dc8/+uo19vy2HTQQsx7Y+jEZ/43O1Gmz9fA40XFPgDHhlOp
         nKm+iE7r3dNMwsx1NSeB7WjABsE6svsG9Bg8ASR56eqxguSpKPncD0LjcHQhyDz4R2W4
         i8Sw==
X-Gm-Message-State: AO0yUKXo/xQk332S95Zj0z/I4bTwVJYJx7Me7XpC5tbmpp11kLujroAv
        vS4G0rxtosoA2THG1zl/n0n5Xg==
X-Google-Smtp-Source: AK7set/3sxifAPk6zZfdQQkJo9RNfG+PbYT/A9+2SLhfqM4/LduE3SU0oUGzRKLmJXJkkXU3oNDbhQ==
X-Received: by 2002:a05:600c:92a:b0:3ea:c100:e974 with SMTP id m42-20020a05600c092a00b003eac100e974mr6557309wmp.26.1677701750119;
        Wed, 01 Mar 2023 12:15:50 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v5 16/18] thermal/drivers/tegra: Remove unneeded lock when setting a trip point
Date:   Wed,  1 Mar 2023 21:14:44 +0100
Message-Id: <20230301201446.3713334-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
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

Enable the channels before setting up the interrupt. We close the
potential race window without using the thermal zone's lock.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Suggested-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 4b2ea17910cd..cb584a5735ed 100644
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
@@ -585,6 +580,20 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	/*
+	 * Enable the channels before setting the interrupt so
+	 * set_trips() can not be called while we are setting up the
+	 * register TSENSOR_SENSOR0_CONFIG1. With this we close a
+	 * potential race window where we are setting up the TH2 and
+	 * the temperature hits TH1 resulting to an update of the
+	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ts->ch); i++) {
+		err = tegra_tsensor_enable_hw_channel(ts, i);
+		if (err)
+			return err;
+	}
+
 	err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					tegra_tsensor_isr, IRQF_ONESHOT,
 					"tegra_tsensor", ts);
@@ -592,12 +601,6 @@ static int tegra_tsensor_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to request interrupt\n");
 
-	for (i = 0; i < ARRAY_SIZE(ts->ch); i++) {
-		err = tegra_tsensor_enable_hw_channel(ts, i);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

