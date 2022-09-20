Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629ED5BE994
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiITPEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiITPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:03:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF73AE59
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n8so2142915wmr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=TmGNn02GgjwItsyH3XavnEsHEt3aT4LQ32MW9ssWl/I=;
        b=2F0yiM/OgzF4Ed7A5+WPvE7Mk1nzN1Iilg59ccLi7J73+lybZivFjlO3Ll5UIxSnxr
         n7RS1IA6Hr050B4gC1QLs6XV3Mz3BA3f8z8nfqiJFw72iDOujNjc20MTUUvyxD++HHJt
         VXKqtKlf/7XaMor2XknMhXTi6u0gMulhVdrofvY6mBCdvs+naTmea49V8tGFDkhQ6apP
         mN2Yrm8kSCTRgCxCM9WRqqLl2PDj2ZfxpP5jJJ+ks4kllQhhpA5p3KDAo1FX6YMmJTqE
         mOnGI5EbKnowqU0NCoM70yjtJKEc/G07WP4YvkhkZaOK7f693MBX/sSYohYU/pPNq3tb
         F8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TmGNn02GgjwItsyH3XavnEsHEt3aT4LQ32MW9ssWl/I=;
        b=VQxCT1El4Vh8Q18kuIV4+CcJkkbb2+OlXp0s7KdHZ5VdpelYXtEuXndEjokCgPJF9D
         CwqC1eTBmPi/wNiuSA4je12+82dx0WOZkwv//Ec94bv21dE2X6/ECRb+S5soT6fw8mOz
         +0PeJG60qoJEkMjFJTomLGZzEMlwXP3Be1WJWa2WGLBAvDvqF6yUE5xu3OL6C4u1BvH1
         quqd1PiZJddRaJOackb3WQqNne0HHV5ma9RoaJG64aVUHT9O7NR6PxzYkqTsYwgp1wcZ
         JF3xzEeVlm4P8GKyTO0a3194s2vDk3eUkAY4Ce2kuohoIduFjf9SBdp2kAGzp/yftFB2
         c68g==
X-Gm-Message-State: ACrzQf2KmlKUdMNljtUagHbVv7W069fAd6wa4+AUpHtMATJwIWoZUOKX
        pJ3qXjpe20Dljx98VysC74JLLQ==
X-Google-Smtp-Source: AMsMyM4xTO6waY4g42gGq+iBbRpilZuIgppAQBmwNVrkXXSLy+/oePmPpSG/eXaojWrHeXW7Hhknqg==
X-Received: by 2002:a05:600c:a09:b0:3a6:8900:c651 with SMTP id z9-20020a05600c0a0900b003a68900c651mr2786317wmp.145.1663686232198;
        Tue, 20 Sep 2022 08:03:52 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id u3-20020a5d4683000000b00225239d9265sm242056wrq.74.2022.09.20.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:03:51 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 20 Sep 2022 17:03:49 +0200
Subject: [PATCH v5 2/4] thermal: mediatek: control buffer enablement tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-i350-thermal-up-v5-2-123bc852d199@baylibre.com>
References: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
In-Reply-To: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
To:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663686228; l=2347;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=5q/fW4mpAQQZom7YMno2r4M6vJl67k0unrSVbaUfEJ8=;
 b=XlVTEXZVb137T29c44XMQm5WKed4jWjkqD0vT/9S8XW0ASP1lOEMbQT3VbT6aqgiabILmrb4jfbe
 PuxqMiI2Dm2YL6lh8uL1289P7KUrvFJ/Gw6bDdoCvJikuGYoVNVy
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Schneider-Pargmann <msp@baylibre.com>

Add logic in order to be able to turn on the control buffer on MT8365.
This change now allows to have control buffer support for MTK_THERMAL_V1,
and it allows to define the register offset, and mask used to enable it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 8440692e3890..d8ddceb75372 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -271,6 +271,9 @@ struct mtk_thermal_data {
 	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 	enum mtk_thermal_version version;
+	u32 apmixed_buffer_ctl_reg;
+	u32 apmixed_buffer_ctl_mask;
+	u32 apmixed_buffer_ctl_set;
 };
 
 struct mtk_thermal {
@@ -514,6 +517,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
 	.adcpnp = mt7622_adcpnp,
 	.sensor_mux_values = mt7622_mux_values,
 	.version = MTK_THERMAL_V2,
+	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
+	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
+	.apmixed_buffer_ctl_set = BIT(0),
 };
 
 /*
@@ -963,14 +969,18 @@ static const struct of_device_id mtk_thermal_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
 
-static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
+static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
+				       void __iomem *apmixed_base)
 {
-	int tmp;
+	u32 tmp;
+
+	if (!mt->conf->apmixed_buffer_ctl_reg)
+		return;
 
-	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
-	tmp &= ~(0x37);
-	tmp |= 0x1;
-	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
+	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
+	tmp &= mt->conf->apmixed_buffer_ctl_mask;
+	tmp |= mt->conf->apmixed_buffer_ctl_set;
+	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
 	udelay(200);
 }
 
@@ -1070,8 +1080,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_auxadc;
 	}
 
+	mtk_thermal_turn_on_buffer(mt, apmixed_base);
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
-		mtk_thermal_turn_on_buffer(apmixed_base);
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
 

-- 
b4 0.10.0
