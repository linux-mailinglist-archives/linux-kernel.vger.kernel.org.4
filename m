Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AE562F33B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbiKRLFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241547AbiKRLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:05:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B697A80
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:04:46 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5so3395030wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyeoHLNYgE+7jRWrI7Gid0gjC7DyyjDTDuyVioxNv2s=;
        b=lnmpQeD29OtlmiLODfaUO4X03Cz3jnXA45M4S1331TbJxmDH6x8HQJ/zAySAh5xYdm
         a+4U2+ntc1abC9aVdCB4cRyd0Exx6+MHxKaWhH7l6YSRsX/hyJzaupSesQAwt69vVrA2
         FlG+KFrvSWulI/s0kzqZwiurXraKgGbvgYsHK/8mf7Cu2PYSuzt2VJwaErMeIRuop2KE
         6OnR3jy6i/ijsR+EGZlV7wjMfbrvic9WlCt3iPBtd8iGKEIQINaztz7QmYXydkRmxyVW
         rvbbLgJtz3FblUDr2iV0bjq31MEDLLUGzqW9f0iAtvhatcAjwPQpiYq6cq5Vm8chAlYx
         WxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyeoHLNYgE+7jRWrI7Gid0gjC7DyyjDTDuyVioxNv2s=;
        b=nRpwGkU/i1mabo2h0OkXsF3MgVVrudzlL7eme6NLa42vJuT016C8ZqfcnvBHL/tldW
         U9TpTxThlrOts77Ob4iKuSpMTDxphu1r2+3Z6dWDSOUcTGOlwfPDaU6SdEqYAuP6gG5U
         758tuCjQfTnk0/c6vns0oTC/Ve1OXmiMVFF6+pFEtIZnJoMaXL/95IWIzLWm0Vr/aE8P
         OP5p2kUHtWdo0bt7QJXJRi1TJMWuPUG/jWGiSvZ8ODz2nljV4HLMjBdVvKdTpHZORQeU
         KzGjSiJhnkNCArXK3AUW4Gduljy5KkdTd5O4eHCVz0ucc2hMG9+P8vcmikC+LW8/P9G5
         vLfg==
X-Gm-Message-State: ANoB5pnA41KBqUSvzv8baovPelNaTkztmFVZ1CI7hKCg/euhDtv6n0eU
        UMiZzliPJzgsMrd50Y8xUs7Kew==
X-Google-Smtp-Source: AA0mqf5Z2s7uT/ojkbi4kQH8ZukBjcYstw7H33D/YaQ6a6I60O8J6S4JZCXIyK7cgUZqBWAF7EE9/w==
X-Received: by 2002:a05:600c:3b84:b0:3cf:b73f:c062 with SMTP id n4-20020a05600c3b8400b003cfb73fc062mr8004968wms.204.1668769484910;
        Fri, 18 Nov 2022 03:04:44 -0800 (PST)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id i14-20020adff30e000000b002368a6deaf8sm3316948wro.57.2022.11.18.03.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:04:44 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 18 Nov 2022 12:04:28 +0100
Subject: [PATCH v7 2/4] thermal: mediatek: control buffer enablement tweaks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-up-i350-thermal-bringup-v7-2-ebf08ff2eddb@baylibre.com>
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
In-Reply-To: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668769481; l=2549;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=BUYgiWUyEmLmv5YqBlzSOjPnRULIXZAPNGFdkdhmkOQ=;
 b=Hv/1oPehOoXJm/XPVk7GdRrpDq0r896Pz2DLWRzc0Hg/KUFU6HAQy0YmZUyUyIRjhZhl4uRFoH0m
 e7doajURDSExpVZ7R7vTDgdxAvRfsQ+qgSKZRaBIbMZjJeA6LcBF
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
b4 0.10.1
