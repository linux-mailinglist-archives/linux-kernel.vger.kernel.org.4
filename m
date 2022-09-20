Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BB5BE70A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiITN1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiITN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4654449B59;
        Tue, 20 Sep 2022 06:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8C59623BB;
        Tue, 20 Sep 2022 13:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE75DC433D7;
        Tue, 20 Sep 2022 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663680451;
        bh=/dxfWhqmMkQmV7S5CRMZVDD51+9HbcPvMYerh1tpzBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STSFalZEwXGSEbc6nzmDWOmroSB9N7vampXEwj0HJR6GHPGblhrcNNSGuZL1lggO7
         v+FPFbxoj6zVWhkCs2gQeKfD2+Q/xNK7SOrsQzi1q5igaHHZ6rSXtkg7C44XEK6wq3
         jFfPgH8EufOtbDAaU/gU0osBDkYeqFMSvXv869DRAQOsGIzIYvxFIYFdGpx7OtB6ij
         bk50QXw6rV2MC0/HqyLr9aIyrQRJCaCoiTii94KZdE+fSEfUJMVPjIRVFEGIg+bJ2G
         sFveGHx3WWc5hbVZxENS+TuEV7wp+f6fBC7qkdhPLXE0DfSENDwMNMSfdtaNbo6anC
         pFwb9VxQYe0Mw==
Received: by pali.im (Postfix)
        id 378762B6E; Tue, 20 Sep 2022 15:27:28 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] ASoC: kirkwood: enable Kirkwood driver for Armada 38x platforms
Date:   Tue, 20 Sep 2022 15:26:44 +0200
Message-Id: <20220920132648.2008-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220920132648.2008-1-pali@kernel.org>
References: <20220920132648.2008-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
driver can be used to support it and this commit adds new compatible string
to identify Armada 38x variant.

Two new memory regions are added: first one for PLL configuration and
the second one for choosing one of audio I/O modes (I2S or S/PDIF).
For the latter purpose a new optional DT property is added ('spdif-mode').

kirkwood-i2s driver is extended by adding a new init function for Armada
38x flavor and also a routine that enables PLL output (i.e. MCLK)
configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Tested-by: Star_Automation <star@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
Reviewed-by: Lior Amsalem <alior@marvell.com>
Tested-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Hezi Shahmoon <hezi@marvell.com>
Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
[pali: Fix support for pre-38x SoCs]
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
 sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
 sound/soc/kirkwood/kirkwood.h                 |   2 +
 3 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
index cb8c07c81ce4..4f5dec5cb3c2 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -6,9 +6,14 @@ Required properties:
   "marvell,kirkwood-audio" for Kirkwood platforms
   "marvell,dove-audio" for Dove platforms
   "marvell,armada370-audio" for Armada 370 platforms
+  "marvell,armada-380-audio" for Armada 38x platforms
 
 - reg: physical base address of the controller and length of memory mapped
-  region.
+  region (named "i2s_regs").
+  With "marvell,armada-380-audio" two other regions are required:
+  first of those is dedicated for Audio PLL Configuration registers
+  (named "pll_regs") and the second one ("soc_ctrl") - for register
+  where one of exceptive I/O types (I2S or S/PDIF) is set.
 
 - interrupts:
   with "marvell,kirkwood-audio", the audio interrupt
@@ -23,6 +28,13 @@ Required properties:
 	"internal" for the internal clock
 	"extclk" for the external clock
 
+Optional properties:
+
+- spdif-mode:
+  Enable S/PDIF mode on Armada 38x SoC. Using this property
+  disables standard I2S I/O. Valid only with "marvell,armada-380-audio"
+  compatible string.
+
 Example:
 
 i2s1: audio-controller@b4000 {
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 2a4ffe945177..ac387b5ca094 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -31,6 +31,122 @@
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE)
 
+/* These registers are relative to the second register region -
+ * audio pll configuration.
+ */
+#define A38X_PLL_CONF_REG0			0x0
+#define     A38X_PLL_FB_CLK_DIV_OFFSET		10
+#define     A38X_PLL_FB_CLK_DIV_MASK		0x7fc00
+#define A38X_PLL_CONF_REG1			0x4
+#define     A38X_PLL_FREQ_OFFSET_MASK		0xffff
+#define     A38X_PLL_FREQ_OFFSET_VALID		BIT(16)
+#define     A38X_PLL_SW_RESET			BIT(31)
+#define A38X_PLL_CONF_REG2			0x8
+#define     A38X_PLL_AUDIO_POSTDIV_MASK		0x7f
+
+/* Bit below belongs to SoC control register corresponding to the third
+ * register region.
+ */
+#define A38X_SPDIF_MODE_ENABLE			BIT(27)
+
+static int armada_38x_i2s_init_quirk(struct platform_device *pdev,
+				     struct kirkwood_dma_data *priv,
+				     struct snd_soc_dai_driver *dai_drv)
+{
+	struct device_node *np = pdev->dev.of_node;
+	u32 reg_val;
+	int i;
+
+	priv->pll_config = devm_platform_ioremap_resource_byname(pdev, "pll_regs");
+	if (IS_ERR(priv->pll_config))
+		return -ENOMEM;
+
+	priv->soc_control = devm_platform_ioremap_resource_byname(pdev, "soc_ctrl");
+	if (IS_ERR(priv->soc_control))
+		return -ENOMEM;
+
+	/* Select one of exceptive modes: I2S or S/PDIF */
+	reg_val = readl(priv->soc_control);
+	if (of_property_read_bool(np, "spdif-mode")) {
+		reg_val |= A38X_SPDIF_MODE_ENABLE;
+		dev_info(&pdev->dev, "using S/PDIF mode\n");
+	} else {
+		reg_val &= ~A38X_SPDIF_MODE_ENABLE;
+		dev_info(&pdev->dev, "using I2S mode\n");
+	}
+	writel(reg_val, priv->soc_control);
+
+	/* Update available rates of mclk's fs */
+	for (i = 0; i < 2; i++) {
+		dai_drv[i].playback.rates |= SNDRV_PCM_RATE_192000;
+		dai_drv[i].capture.rates |= SNDRV_PCM_RATE_192000;
+	}
+
+	return 0;
+}
+
+static inline void armada_38x_set_pll(void __iomem *base, unsigned long rate)
+{
+	u32 reg_val;
+	u16 freq_offset = 0x22b0;
+	u8 audio_postdiv, fb_clk_div = 0x1d;
+
+	/* Set frequency offset value to not valid and enable PLL reset */
+	reg_val = readl(base + A38X_PLL_CONF_REG1);
+	reg_val &= ~A38X_PLL_FREQ_OFFSET_VALID;
+	reg_val &= ~A38X_PLL_SW_RESET;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	udelay(1);
+
+	/* Update PLL parameters */
+	switch (rate) {
+	default:
+	case 44100:
+		freq_offset = 0x735;
+		fb_clk_div = 0x1b;
+		audio_postdiv = 0xc;
+		break;
+	case 48000:
+		audio_postdiv = 0xc;
+		break;
+	case 96000:
+		audio_postdiv = 0x6;
+		break;
+	case 192000:
+		audio_postdiv = 0x3;
+		break;
+	}
+
+	reg_val = readl(base + A38X_PLL_CONF_REG0);
+	reg_val &= ~A38X_PLL_FB_CLK_DIV_MASK;
+	reg_val |= (fb_clk_div << A38X_PLL_FB_CLK_DIV_OFFSET);
+	writel(reg_val, base + A38X_PLL_CONF_REG0);
+
+	reg_val = readl(base + A38X_PLL_CONF_REG2);
+	reg_val &= ~A38X_PLL_AUDIO_POSTDIV_MASK;
+	reg_val |= audio_postdiv;
+	writel(reg_val, base + A38X_PLL_CONF_REG2);
+
+	reg_val = readl(base + A38X_PLL_CONF_REG1);
+	reg_val &= ~A38X_PLL_FREQ_OFFSET_MASK;
+	reg_val |= freq_offset;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	udelay(1);
+
+	/* Disable reset */
+	reg_val |= A38X_PLL_SW_RESET;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+
+	/* Wait 50us for PLL to lock */
+	udelay(50);
+
+	/* Restore frequency offset value validity */
+	reg_val |= A38X_PLL_FREQ_OFFSET_VALID;
+	writel(reg_val, base + A38X_PLL_CONF_REG1);
+}
+
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
@@ -106,7 +222,10 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
 		 * defined in kirkwood_i2s_dai */
 		dev_dbg(dai->dev, "%s: dco set rate = %lu\n",
 			__func__, rate);
-		kirkwood_set_dco(priv->io, rate);
+		if (priv->pll_config)
+			armada_38x_set_pll(priv->pll_config, rate);
+		else
+			kirkwood_set_dco(priv->io, rate);
 
 		clks_ctrl = KIRKWOOD_MCLK_SOURCE_DCO;
 	} else {
@@ -532,7 +651,10 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, priv);
 
-	priv->io = devm_platform_ioremap_resource(pdev, 0);
+	if (of_device_is_compatible(np, "marvell,armada-380-audio"))
+		priv->io = devm_platform_ioremap_resource_byname(pdev, "i2s_regs");
+	else
+		priv->io = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
@@ -540,6 +662,15 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	if (priv->irq < 0)
 		return priv->irq;
 
+	if (of_device_is_compatible(np, "marvell,armada-380-audio")) {
+		err = armada_38x_i2s_init_quirk(pdev, priv, soc_dai);
+		/* Set initial pll frequency */
+		if (priv->pll_config)
+			armada_38x_set_pll(priv->pll_config, 44100);
+		if (err < 0)
+			return err;
+	}
+
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
 	} else if (data) {
@@ -623,6 +754,7 @@ static const struct of_device_id mvebu_audio_of_match[] = {
 	{ .compatible = "marvell,kirkwood-audio" },
 	{ .compatible = "marvell,dove-audio" },
 	{ .compatible = "marvell,armada370-audio" },
+	{ .compatible = "marvell,armada-380-audio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index a1733a6aace5..79bb9aa7f086 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -131,6 +131,8 @@
 
 struct kirkwood_dma_data {
 	void __iomem *io;
+	void __iomem *pll_config;
+	void __iomem *soc_control;
 	struct clk *clk;
 	struct clk *extclk;
 	uint32_t ctl_play;
-- 
2.20.1

