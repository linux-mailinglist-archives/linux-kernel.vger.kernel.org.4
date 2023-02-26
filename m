Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BF76A3522
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBZW4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBZWzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7531A4B9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so2796975wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyXE7dTHWFCFp1MXqwgdHIOsHgvb6Bb+CE7d2W8RwzE=;
        b=j6cWgriM44yIlkbnJMBl/LIF4DBN7K6sDq72ct5XO1gZhaT3JIxDgnr+g9hYq6D7T0
         Vyz+spEgxahy83vuWL1RVBGN8w5RXhwOL9XlOts6Fm+PBKePIzzye1/OOUaDEKrKEydi
         hrpNFPGUHHEiuFh60nTc1FMwGsTsdjyq7Bnx9I0QQg5fA83wsAUmerRnXgbRVUaIS8Sl
         mHYKa8RNX8+Rayot/nUhsgSj3uJlORnBlF3RODAi5Ab8d75eg92iuz+BjKfF5oGKJ5aD
         iRCj349olk+3brNKo+p9Od/3XA45oZkFM/gwC9cTj5RnYQHayoOMHCIg+YPziH8rKN3T
         u8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyXE7dTHWFCFp1MXqwgdHIOsHgvb6Bb+CE7d2W8RwzE=;
        b=aIFXeNofHa4cbjqWAIMIRfYR+s6UalDE0uevxBeb+zxCikmAfc7bKmQPR3FM3NDs2W
         TC8MDRjywKUxxdvLmkmQk83vWyj5jBZbV093bKfQQzWnX6HrDFMUwXJ1YVrBURs31m7t
         lCbVUK0h54g0Vcnj7a708CR5Sf0StQgkntDVvbx1KJjUT89Ho1mNPKCNCQrubgIh33tp
         SiXlY9aVCFSIH6lHizTjWwSO3CQqfsC1Z5aqQhOWNapbrUPitzdzYf9B5DisWZCbN6e8
         NCZamXptKShfxTgE6grf7iVWmMXTezIS40dqJ73niG2jyxWCBAXh6agg+PhFG66doLOM
         FRHA==
X-Gm-Message-State: AO0yUKULbJjFHH7ezKUR3mkQNLxJPZLM67o3fGbdrrP4Q84R2O12ZaJF
        thA0tG1h+QiyB/3MUi9d/XaQTQ==
X-Google-Smtp-Source: AK7set8ROkTT5C5SAw1A6UPRYb/QJsRqGkDj+cNJXtdB3OYVnq/pN0bK5Nc3GU0CXlIZQ7aXtiPHew==
X-Received: by 2002:a05:600c:70a:b0:3df:eecc:de2b with SMTP id i10-20020a05600c070a00b003dfeeccde2bmr13952434wmn.11.1677452119106;
        Sun, 26 Feb 2023 14:55:19 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v3 16/20] thermal/drivers/tegra: Remove unneeded lock when setting a trip point
Date:   Sun, 26 Feb 2023 23:54:02 +0100
Message-Id: <20230226225406.979703-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

Disable the interrupt before setting up the hw channels and then
enable it. We close the potential race window without using the
thermal zone's lock.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 4b2ea17910cd..3506c3f3c474 100644
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

