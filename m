Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF28E69E721
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjBUSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjBUSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7CC2F7A3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:08:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r7so5252249wrz.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2s/AS9OMV5i6t0w60QjnkUP8k7sKtqb93EMncEZug0=;
        b=STKCle/D+aRO5/PsxpIOmpasqDliI5Jen3mltOo11WOsbh2h4xrWh78KFbbXDff28b
         ahz28JiXcfV3cyJGyVY5fNshkdmCxd/Rb1TaN1sheYQZTHrA5cCuT1ivlfxBKZbuJRAn
         DCVKLOPv6Oef78F9rzfY4OONy7zfF4LTblDBwHVVYc+dYAsMQ6j2RO+E8aRgaWJiXLKC
         9Ud5WblKVT0Pen16kN1x8/mxVBkWmzZsHQRId6RGUnD+GaFXVt4B9wjyrUSqxDhGYv6M
         hWu0FJDD80qscl3m57xN7hNxBYNOqxrR68TlCc4CHoyEHdDuRbSMsw9LKs9ZVC8+vdau
         6QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2s/AS9OMV5i6t0w60QjnkUP8k7sKtqb93EMncEZug0=;
        b=Hqxgsv08KlMWq1+Z3vfAGvNwwzelPJ2Wp1eYDbbG8xRvh/fI0f1CsPaxLOOeieR7BX
         t1tLefYwXJouJe+CBckGAIBcD6kCTtB8O+9FN/lw8jF6WVU0U2/JJQrdrKn4RbhM8dJ0
         V1178UO2iLCKFz279fe1dyKkt4FgQ0LMYo/gaCBUSCs/xzmbNKeWZSekAz/I7fy+jJaw
         sLA2KNMOtxlC+cotzj6aTgVQf2yzLSSebg4H6UTUFu0XGM1hMbEAVEVGVCxztJjw1UYO
         WrzOsEPYRYBESvNRkW27/TUM7llhm0k5HrABRAzFG5U+9HQDzBrRq8ee4+f3dBKGrReJ
         WawQ==
X-Gm-Message-State: AO0yUKWSrccH6NjN1K+UZd9pDSii4pyi6RwpBmROKAg2yK/dFa2iqNZh
        +7+zOvvJySAnFupuhRTKWNAiAw==
X-Google-Smtp-Source: AK7set/F8EKn/LuLvBh1KiI2BdVHGVDB8spna+JRaSBMJuDqED29VTWrpOZ0VeWH8eoT4nzk1zsk7A==
X-Received: by 2002:a05:6000:14e:b0:2bf:dcdc:afb8 with SMTP id r14-20020a056000014e00b002bfdcdcafb8mr5182978wrx.64.1677002889369;
        Tue, 21 Feb 2023 10:08:09 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:08:09 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v2 13/16] thermal/tegra: Do not enable the thermal zone, it is already enabled
Date:   Tue, 21 Feb 2023 19:07:07 +0100
Message-Id: <20230221180710.2781027-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

The code enables the thermal zone after setting it up. But the thermal
zone is already enabled by thermal_of_zone_register() function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/tegra30-tsensor.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index 3506c3f3c474..e38902abf207 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -346,7 +346,7 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 {
 	const struct tegra_tsensor_channel *tsc = &ts->ch[id];
 	struct thermal_zone_device *tzd = tsc->tzd;
-	int err, hot_trip = 0, crit_trip = 0;
+	int hot_trip = 0, crit_trip = 0;
 	u32 val;
 
 	if (!tzd) {
@@ -401,12 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const struct tegra_tsensor *ts,
 	val |= FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1);
 	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
 
-	err = thermal_zone_device_enable(tzd);
-	if (err) {
-		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
-		return err;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

