Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000B161991B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiKDOPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiKDOOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:14:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E6B2F3B4
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:14:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v1so7212529wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVeGkGwr3GPdeR7i1EiSinttHW7VHiK035a7xfUpheg=;
        b=RCyBPJvwhOLCj3/RNokf2JgooAwJHyvwVSCM4BwunHJzPhtOJ+SzN1fHjOfDHEEXHQ
         Nl2GB0ZYTF37W75Vuk5Y6W+JulQXsQVyHvbSGUdcdgc5GDVr1g7q3HtKQy6d4FayZ9v9
         qRRlKVKKmJOQ1Gq2ZVn/nkN+0QrQzLAMp61xAfPFGhiAOpwC3EafcseuFNslK+2WC7OU
         eElhNkMrjNfLwYBnas75Xnya45p6jl07sGY1JFq6+LjWccvUqXgJeAI2K9SmpvmxzHDp
         xZadrFGOJPXBhFaBl36XHSwx3z1gC4jlaef/IKvmFuo28U76lUPMkgA7CmuT8mqJ2tCJ
         YM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVeGkGwr3GPdeR7i1EiSinttHW7VHiK035a7xfUpheg=;
        b=EwezasG1kUXmLiNNp51/y37Y5k0FF2uitm53t9r5KMZIRpCC+XYQl+nHGLiOGcrPDe
         3iuMxmcbCihkBjFYjRqsV19zzTMHGP0iQ9Lo/3KUqwekUifVWAL3k1B/M2mS5RYuqgpR
         Q07QC8kt69VVQya4zg5I2Y9Ky1amymQt3xCvo3ci+LIvu/WTP5aTKEhQfiy44UZXRbMZ
         aLCDQONiJqlBTjkqbbYmXaTzYIuxoUcZp/5uFzhXtkGEki+hEN3A8944RkGQwteq5hDD
         s+Iyn5iinH02xg55kc6nFfwhmiZaT86S3V5RPEZuzpSOVC6phaJfNyG/M2+qatiwJtg2
         8xCQ==
X-Gm-Message-State: ACrzQf0RH1WuuQVDvV7dXO2zTKARnOFQImIBCccunUsFt4nEoj6IB42C
        cy/N05ncG/FHX7YHnnYzhftjSQ==
X-Google-Smtp-Source: AMsMyM6m1Uze6fLYU9H4EiVlYzz8WUlNIc/+yVXsZi2Cve2/1/ya3ilrFdP+gj+QlVosCe/JR5x1/g==
X-Received: by 2002:a05:6000:381:b0:236:f075:d2a9 with SMTP id u1-20020a056000038100b00236f075d2a9mr9823911wrf.65.1667571269624;
        Fri, 04 Nov 2022 07:14:29 -0700 (PDT)
Received: from [127.0.0.1] (2a02-8440-6440-7fff-3074-96af-9642-0003.rev.sfr.net. [2a02:8440:6440:7fff:3074:96af:9642:3])
        by smtp.gmail.com with ESMTPSA id bj9-20020a0560001e0900b002365cd93d05sm3594512wrb.102.2022.11.04.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:14:29 -0700 (PDT)
From:   Guillaume Ranquet <granquet@baylibre.com>
Date:   Fri, 04 Nov 2022 15:09:58 +0100
Subject: [PATCH v3 12/12] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220919-v3-12-a803f2660127@baylibre.com>
References: <20220919-v3-0-a803f2660127@baylibre.com>
In-Reply-To: <20220919-v3-0-a803f2660127@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Guillaume Ranquet <granquet@baylibre.com>,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DPI1 hdmi path support in mtk dpi driver

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 143 ++++++++++++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |   5 ++
 2 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 508a6d994e83..8052b47042b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -14,7 +14,10 @@
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/types.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <video/videomode.h>
 
@@ -65,10 +68,14 @@ struct mtk_dpi {
 	struct drm_bridge *next_bridge;
 	struct drm_connector *connector;
 	void __iomem *regs;
+	struct reset_control *reset_ctl;
 	struct device *dev;
 	struct clk *engine_clk;
+	struct clk *dpi_ck_cg;
 	struct clk *pixel_clk;
+	struct clk *dpi_sel_clk;
 	struct clk *tvd_clk;
+	struct clk *hdmi_cg;
 	int irq;
 	struct drm_display_mode mode;
 	const struct mtk_dpi_conf *conf;
@@ -134,6 +141,7 @@ struct mtk_dpi_yc_limit {
  * @yuv422_en_bit: Enable bit of yuv422.
  * @csc_enable_bit: Enable bit of CSC.
  * @pixels_per_iter: Quantity of transferred pixels per iteration.
+ * @is_internal_hdmi: True if this DPI block is directly connected to SoC internal HDMI block
  */
 struct mtk_dpi_conf {
 	unsigned int (*cal_factor)(int clock);
@@ -152,6 +160,7 @@ struct mtk_dpi_conf {
 	u32 yuv422_en_bit;
 	u32 csc_enable_bit;
 	u32 pixels_per_iter;
+	bool is_internal_hdmi;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -465,8 +474,15 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 		pinctrl_select_state(dpi->pinctrl, dpi->pins_gpio);
 
 	mtk_dpi_disable(dpi);
+
+	reset_control_rearm(dpi->reset_ctl);
+
 	clk_disable_unprepare(dpi->pixel_clk);
 	clk_disable_unprepare(dpi->engine_clk);
+	clk_disable_unprepare(dpi->dpi_sel_clk);
+	clk_disable_unprepare(dpi->dpi_ck_cg);
+	clk_disable_unprepare(dpi->hdmi_cg);
+	clk_disable_unprepare(dpi->tvd_clk);
 }
 
 static int mtk_dpi_power_on(struct mtk_dpi *dpi)
@@ -482,12 +498,44 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->dpi_sel_clk);
+	if (ret) {
+		dev_err(dpi->dev, "failed to enable dpi_sel clock: %d\n", ret);
+		goto err_refcount;
+	}
+
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_tvd;
+	}
+
+	ret = clk_prepare_enable(dpi->engine_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable engine clock: %d\n", ret);
+		goto err_engine;
+	}
+
+	ret = clk_prepare_enable(dpi->hdmi_cg);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable hdmi_cg clock: %d\n", ret);
+		goto err_hdmi_cg;
+	}
+
+	ret = clk_prepare_enable(dpi->dpi_ck_cg);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable dpi_ck_cg clock: %d\n", ret);
+		goto err_ck_cg;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
 		goto err_pixel;
 	}
 
+	reset_control_reset(dpi->reset_ctl);
+
 	if (dpi->pinctrl && dpi->pins_dpi)
 		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
 
@@ -495,6 +543,15 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 
 err_pixel:
 	clk_disable_unprepare(dpi->engine_clk);
+	clk_disable_unprepare(dpi->dpi_ck_cg);
+err_ck_cg:
+	clk_disable_unprepare(dpi->hdmi_cg);
+err_hdmi_cg:
+	clk_disable_unprepare(dpi->engine_clk);
+err_engine:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_tvd:
+	clk_disable_unprepare(dpi->dpi_sel_clk);
 err_refcount:
 	dpi->refcount--;
 	return ret;
@@ -538,7 +595,6 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	else
 		clk_set_rate(dpi->pixel_clk, vm.pixelclock);
 
-
 	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
 
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
@@ -605,7 +661,16 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	if (dpi->conf->support_direct_pin) {
 		mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 		mtk_dpi_config_2n_h_fre(dpi);
-		mtk_dpi_dual_edge(dpi);
+		/* DPI could be connecting to external bridge
+		 * or internal HDMI encoder. */
+		if (dpi->conf->is_internal_hdmi) {
+			mtk_dpi_mask(dpi, DPI_CON, DPI_OUTPUT_1T1P_EN,
+				     DPI_OUTPUT_1T1P_EN);
+			mtk_dpi_mask(dpi, DPI_CON, DPI_INPUT_2P_EN,
+				     DPI_INPUT_2P_EN);
+		} else {
+			mtk_dpi_dual_edge(dpi);
+		}
 		mtk_dpi_config_disable_edge(dpi);
 	}
 	if (dpi->conf->input_2pixel) {
@@ -720,7 +785,10 @@ static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
 
-	mtk_dpi_power_off(dpi);
+	if (dpi->conf->is_internal_hdmi)
+		mtk_dpi_power_off(dpi);
+	else
+		mtk_dpi_disable(dpi);
 }
 
 static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
@@ -763,14 +831,16 @@ void mtk_dpi_start(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	mtk_dpi_power_on(dpi);
+	if (!dpi->conf->is_internal_hdmi)
+		mtk_dpi_power_on(dpi);
 }
 
 void mtk_dpi_stop(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	mtk_dpi_power_off(dpi);
+	if (!dpi->conf->is_internal_hdmi)
+		mtk_dpi_power_off(dpi);
 }
 
 static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
@@ -853,6 +923,11 @@ static unsigned int mt8183_calculate_factor(int clock)
 		return 2;
 }
 
+static unsigned int mt8195_calculate_factor(int clock)
+{
+	return 1;
+}
+
 static unsigned int mt8195_dpintf_calculate_factor(int clock)
 {
 	if (clock < 70000)
@@ -946,6 +1021,24 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8195_conf = {
+	.cal_factor = mt8195_calculate_factor,
+	.max_clock_khz = 594000,
+	.reg_h_fre_con = 0xe0,
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.pixels_per_iter = 1,
+	.is_ck_de_pol = true,
+	.swap_input_support = true,
+	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
+	.is_internal_hdmi = true,
+	.support_direct_pin = true,
+};
+
 static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.cal_factor = mt8195_dpintf_calculate_factor,
 	.max_clock_khz = 600000,
@@ -1003,6 +1096,12 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dpi->reset_ctl = devm_reset_control_get_optional_exclusive(dev, "dpi_on");
+	if (IS_ERR(dpi->reset_ctl)) {
+		dev_err(dev, "Failed to get reset_ctl: %ld\n", PTR_ERR(dpi->reset_ctl));
+		return PTR_ERR(dpi->reset_ctl);
+	}
+
 	dpi->engine_clk = devm_clk_get(dev, "engine");
 	if (IS_ERR(dpi->engine_clk)) {
 		ret = PTR_ERR(dpi->engine_clk);
@@ -1012,7 +1111,26 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dpi->pixel_clk = devm_clk_get(dev, "pixel");
+	dpi->hdmi_cg = devm_clk_get_optional(dev, "hdmi_cg");
+	if (IS_ERR(dpi->hdmi_cg)) {
+		ret = PTR_ERR(dpi->hdmi_cg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get hdmi_cg clock: %d\n", ret);
+
+		return ret;
+	}
+
+	dpi->dpi_ck_cg = devm_clk_get_optional(dev, "ck_cg");
+	if (IS_ERR(dpi->dpi_ck_cg)) {
+		ret = PTR_ERR(dpi->dpi_ck_cg);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get dpi ck cg clock: %d\n",
+				ret);
+
+		return ret;
+	}
+
+	dpi->pixel_clk = devm_clk_get_optional(dev, "pixel");
 	if (IS_ERR(dpi->pixel_clk)) {
 		ret = PTR_ERR(dpi->pixel_clk);
 		if (ret != -EPROBE_DEFER)
@@ -1021,7 +1139,7 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dpi->tvd_clk = devm_clk_get(dev, "pll");
+	dpi->tvd_clk = devm_clk_get_optional(dev, "pll");
 	if (IS_ERR(dpi->tvd_clk)) {
 		ret = PTR_ERR(dpi->tvd_clk);
 		if (ret != -EPROBE_DEFER)
@@ -1030,6 +1148,14 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dpi->dpi_sel_clk = devm_clk_get_optional(dev, "dpi_sel");
+	if (IS_ERR(dpi->dpi_sel_clk)) {
+		ret = PTR_ERR(dpi->dpi_sel_clk);
+		dev_err_probe(dev, ret, "Failed to get dpi_Sel_clk clock: %d\n", ret);
+
+		return ret;
+	}
+
 	dpi->irq = platform_get_irq(pdev, 0);
 	if (dpi->irq <= 0)
 		return -EINVAL;
@@ -1085,6 +1211,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8195-dp-intf",
 	  .data = &mt8195_dpintf_conf,
 	},
+	{ .compatible = "mediatek,mt8195-dpi",
+	  .data = &mt8195_conf,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 62bd4931b344..653ef4b93a97 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -43,6 +43,11 @@
 #define DPINTF_YUV422_EN		BIT(24)
 #define DPINTF_CSC_ENABLE		BIT(26)
 #define DPINTF_INPUT_2P_EN		BIT(29)
+#define DPI_OUTPUT_1T1P_EN		BIT(24)
+#define DPI_INPUT_2P_EN			BIT(25)
+#define DPI_EXT_VSYNC_EN		BIT(26)
+#define DPI_RGB565_EN			BIT(27)
+#define DPI_RGB880_EN			BIT(28)
 
 #define DPI_OUTPUT_SETTING	0x14
 #define CH_SWAP				0

-- 
b4 0.11.0-dev
