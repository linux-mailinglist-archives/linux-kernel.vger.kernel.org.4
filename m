Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A11B67AED3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjAYJvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAYJvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:51:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1FE4C2A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:51:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q5so11778639wrv.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8rG7Mbgb1oWT4fX2vZyNeYThYNVXL6oBqBlNEJwaWo=;
        b=xPWzL4S43VKse9dWE8bt5cpWWfxCYYdjSEnvvA18Lvlhc/05RPdQbUtIXakb3vBwOr
         yvTO5WToHjWPcxv2LW1ueJxhU0PfaDPRmCtYjxQsZ3sU1yQmGMS3+a9TqsoIteKsbReD
         E6udwR9XHgscFD4p3EXKzHbpMD+F6R1VBsvHQ8tJoRRyV4M0XEzwFOp3eQVwWN5CF1gS
         /wszNzazSfHLc52rPtQ1ybUM/SwoxBBoW8g2fNCzZouSJ1SJ2BIglkEJXL7vmff1zvPJ
         PY4u69Zcwb/CGFAYHJ5szMqb1+PkSMyrvhSnRyjsC2FX/XUN4MtNGpJiZbfy3+9Oc7ch
         PTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8rG7Mbgb1oWT4fX2vZyNeYThYNVXL6oBqBlNEJwaWo=;
        b=70KSABZ9JZaVS5FSy2vPh+VGvzZ96/smmV+QaW1Y930ryfM05+3aC2T+1oWg+ds/n+
         8xv0+JdjwBGuOys87rPL2QQifz3MkchHvgZoG9MNwG7l0/GXlw7E6Zsg0ZtUXR01MfYj
         7j5O+31MMhOhP6reU2p4IE6MmiHoDD4QrcEHKwjLObK94tCzQAKoe6pJx33khjdU6dW1
         z8mei5RmbkwgunqHXSEXMQevHXiSC7C8p6D2gECTI0eNNXnVt+oXO5S53gJV8wtNigWC
         2MBXuCw+OgSo8KnZ+AIY0oMBWQNbhIj9yA4+MGdpoJc8bzLdOEpY7udARlYZPtIRh/fn
         KtIA==
X-Gm-Message-State: AO0yUKUCwyBZwkcOw3TKbEhwV10I2KOgM/ZK4VMKimaYpesDczTntib9
        OG1yIFlNAYQBcAZk8b6FHDDKTA==
X-Google-Smtp-Source: AK7set9P75tmgvXzlQ7uRit1xFYJrLg1XymQi858p0cz6PXUglNd52fGr5orgcHOWHr8J38C041+KA==
X-Received: by 2002:a5d:66ce:0:b0:2bf:b765:74cf with SMTP id k14-20020a5d66ce000000b002bfb76574cfmr2102506wrw.30.1674640263230;
        Wed, 25 Jan 2023 01:51:03 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id j26-20020a5d453a000000b002bdf3809f59sm3955072wra.38.2023.01.25.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:51:02 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 25 Jan 2023 10:50:30 +0100
Subject: [PATCH v8 2/5] thermal: mediatek: control buffer enablement tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v8-2-23e8fbb08837@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v8-0-23e8fbb08837@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Michael Kao <michael.kao@mediatek.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674640259; l=2546;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=o4V8Nb038m3SOSHzM/Z25bSLgf/ue1pK+n3hiU0se4A=;
 b=z+eBUVG5tTpkdOflpaYTVv0RLdNKf8a4pIUewm6Ch4PuTfzhjtAJJ58QazUubZZjO6YaNfGgl8VM
 yS/u5hKRAwrw+zWBjbi6O4hrypwnQNNl63tdF+8pse8qmBDQEers
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mtk_thermal.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

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
2.39.1
