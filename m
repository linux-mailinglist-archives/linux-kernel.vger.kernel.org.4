Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626D67E9E5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjA0Ppu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjA0Ppe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:45:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A387159
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so3801844wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 07:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8rG7Mbgb1oWT4fX2vZyNeYThYNVXL6oBqBlNEJwaWo=;
        b=Ak0M4S3PP2YfIwMvpC1g+jI3DK7R1uaawLMfTZ0B+Xmk4DxyWTByJZK3Dmitz/w8Vr
         NU5W6K27YWXTm6TU2/5v3fcvIW6/wSHEQOjujgrdPGF/vPlAZUWto2qjHb+xtAZZ0RHb
         qLYGFOx94tqTuNhEXB3dt9u7qlScW/U8SLYNNsMxIyQ41/GZEPxgM41PBw16Wdmtqk23
         UtHO1XWKLi6QbL236FphQaWX7e39VoxyHgXwSXUb35QcSfDdt78VTHSS3CP6C+6mB8zJ
         HeV+XJ2M+fwE5J6e0rPj+3zKqU9z73pgCVfbUgXfkfpv3T4icegBZufAkLZr7LSrJ2ve
         WUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8rG7Mbgb1oWT4fX2vZyNeYThYNVXL6oBqBlNEJwaWo=;
        b=X2kOEzi4RkvGJOsI7jqFm4+spREXgRjtaktMzVOCkLYmHi3qdqMOL3WPREhht/rxKM
         7Dgz63nSFYdUxxBfEOJJxC5mM+EZ9iOk2pyzjQAVMWXh+fKWg1Q5BD18AmxSOpdxBeFD
         X8VilnwYalSBSb12u9KXBIn0LFqPGc/czbgpMECl4eEy7+FzvwRFzEmDaum+vQQcud9Y
         bwVir4gN3XVyhIyQOrtIj9hoc614fxDkdpf32CvW/KIqNljGe56a8j7PZz/XRvIZWhcB
         nAnhzMjnVQfjevY8aLABWIUzFux/UHb/0KKK+s0zP/F7Nsoombk5uvkOQhpit7Fufun4
         /YRg==
X-Gm-Message-State: AO0yUKU3sRelGea8flNzch0XDgdsU1vFmLUCOPShUOF+iKvwIGdzdzRn
        HLjVLc7c7OiR/cdhicQQkd70iQ==
X-Google-Smtp-Source: AK7set+4H3DcOl0YSNla7P3MTJIr/xfF8CB0kZbmKaJ8hFq/uX5FUr77sAZOWY5ilP7Ik6/grrDfYg==
X-Received: by 2002:a05:600c:1551:b0:3dc:18de:b221 with SMTP id f17-20020a05600c155100b003dc18deb221mr12151943wmg.21.1674834316515;
        Fri, 27 Jan 2023 07:45:16 -0800 (PST)
Received: from [127.0.1.1] (62.213.132.195.rev.sfr.net. [195.132.213.62])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm4381153wrp.53.2023.01.27.07.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:45:16 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 27 Jan 2023 16:44:43 +0100
Subject: [PATCH v9 2/5] thermal: mediatek: control buffer enablement tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221018-up-i350-thermal-bringup-v9-2-55a1ae14af74@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v9-0-55a1ae14af74@baylibre.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674834313; l=2546;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=o4V8Nb038m3SOSHzM/Z25bSLgf/ue1pK+n3hiU0se4A=;
 b=F/MJjX8JLy8QavZIEwP1xSnnGVqcwpuAksMQF4r8pFpwR5bs7BQ9ybmGwstHL43WvEIYyvHZN05C
 lkzKS4DUD0yH20B1pwekw5XCea4gDE3mVOIjb32AynRNE1hEa6HL
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
