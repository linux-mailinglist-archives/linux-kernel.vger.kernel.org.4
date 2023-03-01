Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0F6A74FA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCAUQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCAUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:15:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC74D4FAB9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r18so14520832wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/7e8N8b7gEax6Mp/tnE3jBK1MXlLnukXxRJZ25cEfk=;
        b=MDUIOAJCbxOoRoUdpykbKUJ/DLqedw98V6ULDsqSCrVv2DyQoKsOfFo1yWSFUMyGAH
         61NLVJ3VtYPMta1yqM/+iLb07kdsrakUTAyOLkEEU/a5vc5/jnXoTNRP6EHQks2G1cYK
         O7H4ybns27pUTUFLhFFuX98xGnbRConr+RkP0qe2eKL5lKoqM6X29VmtxVtQ0JH8IcLG
         eHvacZ50yVh2fLHdZZBuivopsteFdk48clomNw6d1E8G6lW5O5HK+zqhoPZOzgRgjlxq
         SqVEnpRGIULjdyG+opdX3sBaoqH/nj9vxXHhbWgoHSUUEHEUxp5aw0lD2j2HfRFxWdGJ
         lupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/7e8N8b7gEax6Mp/tnE3jBK1MXlLnukXxRJZ25cEfk=;
        b=AYzxeYs9wUKZ4qLUspMVwwgPTFPllyeIv0uG5RgAJSHxxxCRd0EuiK1GQxe6koLIwa
         N3+jzza6styfGe5jg8BeIdauCLLub/6DEPYAcCtm1DDOjjypcLDMKCH1ulcE/bMX9/tT
         wEex0aITG7cKiRFt8B9C6a2PsHtpj8TCglurDXDIdDYMVySQIS/y8p9ggmIKWKE/yqBq
         eQtZ5tFTyWz3iR0baqhgeSiFxyiVoRPIpP6aTCGK9eFagi514mLu/+HIjvNMthgN4hSc
         m8NFBAHD4mCkOEsNVt0pKCHZPiBFZiZ68ulxMCixbOU3cTZw0TEuabLpdSoblFexb5Y1
         EYHA==
X-Gm-Message-State: AO0yUKX1fTrXc4lyyufaArf/eS0W7rBHfXCJft93TFYbPGHp97xLzi2d
        L7o1RiWJrziYziif11x4ibWSIQ==
X-Google-Smtp-Source: AK7set9TfCp/BeD5OZI1vQMbiQ8UL9u+JNMs3gnfhvFgF02HRwETSmUApdZ7SbXWMRKNCbHrm/8nBg==
X-Received: by 2002:a05:6000:1362:b0:2c7:a9ec:3 with SMTP id q2-20020a056000136200b002c7a9ec0003mr5544569wrz.65.1677701727394;
        Wed, 01 Mar 2023 12:15:27 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:27 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dhruva Gole <d-gole@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-renesas-soc@vger.kernel.org (open list:RENESAS R-CAR THERMAL
        DRIVERS),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v5 07/18] thermal/hwmon: Do not set no_hwmon before calling thermal_add_hwmon_sysfs()
Date:   Wed,  1 Mar 2023 21:14:35 +0100
Message-Id: <20230301201446.3713334-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal->tzp->no_hwmon parameter is only used when calling
thermal_zone_device_register().

Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
effect.

Remove the call and again prevent the drivers to access the thermal
internals.

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom
---
 drivers/thermal/broadcom/bcm2711_thermal.c | 1 -
 drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
 drivers/thermal/rcar_gen3_thermal.c        | 1 -
 drivers/thermal/rcar_thermal.c             | 5 -----
 drivers/thermal/rockchip_thermal.c         | 1 -
 drivers/thermal/rzg2l_thermal.c            | 1 -
 6 files changed, 10 deletions(-)

diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/broadcom/bcm2711_thermal.c
index fcfcbbf044a4..c243a76a3471 100644
--- a/drivers/thermal/broadcom/bcm2711_thermal.c
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -98,7 +98,6 @@ static int bcm2711_thermal_probe(struct platform_device *pdev)
 
 	priv->thermal = thermal;
 
-	thermal->tzp->no_hwmon = false;
 	return thermal_add_hwmon_sysfs(thermal);
 }
 
diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 86aaf459de37..a217d832f24e 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -267,7 +267,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 * Thermal_zone doesn't enable hwmon as default,
 	 * enable it here
 	 */
-	tz->tzp->no_hwmon = false;
 	err = thermal_add_hwmon_sysfs(tz);
 	if (err)
 		goto err_tz;
diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 2b7537ef141d..3df00c9d55ab 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -527,7 +527,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		}
 		tsc->zone = zone;
 
-		tsc->zone->tzp->no_hwmon = false;
 		ret = thermal_add_hwmon_sysfs(tsc->zone);
 		if (ret)
 			goto error_unregister;
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index e0440f63ae77..b8571f7090aa 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -509,11 +509,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		}
 
 		if (chip->use_of_thermal) {
-			/*
-			 * thermal_zone doesn't enable hwmon as default,
-			 * but, enable it here to keep compatible
-			 */
-			priv->zone->tzp->no_hwmon = false;
 			ret = thermal_add_hwmon_sysfs(priv->zone);
 			if (ret)
 				goto error_unregister;
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 71e533df563a..bb254bdff043 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1451,7 +1451,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	for (i = 0; i < thermal->chip->chn_num; i++) {
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
-		thermal->sensors[i].tzd->tzp->no_hwmon = false;
 		error = thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
 		if (error)
 			dev_warn(&pdev->dev,
diff --git a/drivers/thermal/rzg2l_thermal.c b/drivers/thermal/rzg2l_thermal.c
index 7631430ce8a9..b56981f85306 100644
--- a/drivers/thermal/rzg2l_thermal.c
+++ b/drivers/thermal/rzg2l_thermal.c
@@ -216,7 +216,6 @@ static int rzg2l_thermal_probe(struct platform_device *pdev)
 	}
 
 	priv->zone = zone;
-	priv->zone->tzp->no_hwmon = false;
 	ret = thermal_add_hwmon_sysfs(priv->zone);
 	if (ret)
 		goto err;
-- 
2.34.1

