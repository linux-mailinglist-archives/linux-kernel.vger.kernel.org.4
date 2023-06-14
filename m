Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1BD7128FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244051AbjEZOy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbjEZOyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:54:21 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA03419D;
        Fri, 26 May 2023 07:54:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 93D5F7FC9;
        Fri, 26 May 2023 22:54:05 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 26 May
 2023 22:54:05 +0800
Received: from SD-Server.starfivetech.com (183.27.98.143) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 26 May 2023 22:54:04 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v5 2/3] ASoC: starfive: Add JH7110 TDM driver
Date:   Fri, 26 May 2023 22:54:01 +0800
Message-ID: <20230526145402.450-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526145402.450-1-walker.chen@starfivetech.com>
References: <20230526145402.450-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.143]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tdm driver support for the StarFive JH7110 SoC.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 MAINTAINERS                     |   6 +
 sound/soc/Kconfig               |   1 +
 sound/soc/Makefile              |   1 +
 sound/soc/starfive/Kconfig      |  15 +
 sound/soc/starfive/Makefile     |   2 +
 sound/soc/starfive/jh7110_tdm.c | 679 ++++++++++++++++++++++++++++++++
 6 files changed, 704 insertions(+)
 create mode 100644 sound/soc/starfive/Kconfig
 create mode 100644 sound/soc/starfive/Makefile
 create mode 100644 sound/soc/starfive/jh7110_tdm.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0496448b7f..00478d07a9f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20132,6 +20132,12 @@ F:	Documentation/devicetree/bindings/power/starfive*
 F:	drivers/soc/starfive/jh71xx_pmu.c
 F:	include/dt-bindings/power/starfive,jh7110-pmu.h
 
+STARFIVE JH7110 TDM DRIVER
+M:	Walker Chen <walker.chen@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
+F:	sound/soc/starfive/jh7110_tdm.c
+
 STARFIVE SOC DRIVERS
 M:	Conor Dooley <conor@kernel.org>
 S:	Maintained
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 848fbae26c3b..8d1d9401ecf2 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -91,6 +91,7 @@ source "sound/soc/sh/Kconfig"
 source "sound/soc/sof/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sprd/Kconfig"
+source "sound/soc/starfive/Kconfig"
 source "sound/soc/sti/Kconfig"
 source "sound/soc/stm/Kconfig"
 source "sound/soc/sunxi/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 507eaed1d6a1..65aeb4ef4068 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SND_SOC)	+= sh/
 obj-$(CONFIG_SND_SOC)	+= sof/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sprd/
+obj-$(CONFIG_SND_SOC)	+= starfive/
 obj-$(CONFIG_SND_SOC)	+= sti/
 obj-$(CONFIG_SND_SOC)	+= stm/
 obj-$(CONFIG_SND_SOC)	+= sunxi/
diff --git a/sound/soc/starfive/Kconfig b/sound/soc/starfive/Kconfig
new file mode 100644
index 000000000000..fafb681f8c0a
--- /dev/null
+++ b/sound/soc/starfive/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SND_SOC_STARFIVE
+	tristate "Audio support for StarFive SoC"
+	depends on COMPILE_TEST || ARCH_STARFIVE
+	help
+	  Say Y or M if you want to add support for codecs attached to
+	  the Starfive SoCs' Audio interfaces. You will also need to
+	  select the audio interfaces to support below.
+
+config SND_SOC_JH7110_TDM
+	tristate "JH7110 TDM device driver"
+	depends on HAVE_CLK && SND_SOC_STARFIVE
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y or M if you want to add support for StarFive TDM driver.
diff --git a/sound/soc/starfive/Makefile b/sound/soc/starfive/Makefile
new file mode 100644
index 000000000000..f7d960211d72
--- /dev/null
+++ b/sound/soc/starfive/Makefile
@@ -0,0 +1,2 @@
+# StarFive Platform Support
+obj-$(CONFIG_SND_SOC_JH7110_TDM) += jh7110_tdm.o
diff --git a/sound/soc/starfive/jh7110_tdm.c b/sound/soc/starfive/jh7110_tdm.c
new file mode 100644
index 000000000000..973b910d2d3e
--- /dev/null
+++ b/sound/soc/starfive/jh7110_tdm.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * jh7110_tdm.c -- StarFive JH7110 TDM driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Walker Chen <walker.chen@starfivetech.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/types.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#define TDM_PCMGBCR			0x00
+	#define PCMGBCR_MASK		0x1e
+	#define PCMGBCR_ENABLE		BIT(0)
+	#define PCMGBCR_TRITXEN		BIT(4)
+	#define CLKPOL_BIT		5
+	#define TRITXEN_BIT		4
+	#define ELM_BIT			3
+	#define SYNCM_BIT		2
+	#define MS_BIT			1
+#define TDM_PCMTXCR			0x04
+	#define PCMTXCR_TXEN		BIT(0)
+	#define IFL_BIT			11
+	#define WL_BIT			8
+	#define SSCALE_BIT		4
+	#define SL_BIT			2
+	#define LRJ_BIT			1
+#define TDM_PCMRXCR			0x08
+	#define PCMRXCR_RXEN		BIT(0)
+	#define PCMRXCR_RXSL_MASK	0xc
+	#define PCMRXCR_RXSL_16BIT	0x4
+	#define PCMRXCR_RXSL_32BIT	0x8
+	#define PCMRXCR_SCALE_MASK	0xf0
+	#define PCMRXCR_SCALE_1CH	0x10
+#define TDM_PCMDIV			0x0c
+
+#define JH7110_TDM_FIFO			0x170c0000
+#define JH7110_TDM_FIFO_DEPTH		32
+
+enum TDM_MASTER_SLAVE_MODE {
+	TDM_AS_MASTER = 0,
+	TDM_AS_SLAVE,
+};
+
+enum TDM_CLKPOL {
+	/* tx raising and rx falling */
+	TDM_TX_RASING_RX_FALLING = 0,
+	/* tx falling and rx raising */
+	TDM_TX_FALLING_RX_RASING,
+};
+
+enum TDM_ELM {
+	/* only work while SYNCM=0 */
+	TDM_ELM_LATE = 0,
+	TDM_ELM_EARLY,
+};
+
+enum TDM_SYNCM {
+	/* short frame sync */
+	TDM_SYNCM_SHORT = 0,
+	/* long frame sync */
+	TDM_SYNCM_LONG,
+};
+
+enum TDM_IFL {
+	/* FIFO to send or received : half-1/2, Quarter-1/4 */
+	TDM_FIFO_HALF = 0,
+	TDM_FIFO_QUARTER,
+};
+
+enum TDM_WL {
+	/* send or received word length */
+	TDM_8BIT_WORD_LEN = 0,
+	TDM_16BIT_WORD_LEN,
+	TDM_20BIT_WORD_LEN,
+	TDM_24BIT_WORD_LEN,
+	TDM_32BIT_WORD_LEN,
+};
+
+enum TDM_SL {
+	/* send or received slot length */
+	TDM_8BIT_SLOT_LEN = 0,
+	TDM_16BIT_SLOT_LEN,
+	TDM_32BIT_SLOT_LEN,
+};
+
+enum TDM_LRJ {
+	/* left-justify or right-justify */
+	TDM_RIGHT_JUSTIFY = 0,
+	TDM_LEFT_JUSTIFT,
+};
+
+struct tdm_chan_cfg {
+	enum TDM_IFL ifl;
+	enum TDM_WL  wl;
+	unsigned char sscale;
+	enum TDM_SL  sl;
+	enum TDM_LRJ lrj;
+	unsigned char enable;
+};
+
+struct jh7110_tdm_dev {
+	void __iomem *tdm_base;
+	struct device *dev;
+	struct clk_bulk_data clks[6];
+	struct reset_control *resets;
+
+	enum TDM_CLKPOL clkpolity;
+	enum TDM_ELM	elm;
+	enum TDM_SYNCM	syncm;
+	enum TDM_MASTER_SLAVE_MODE ms_mode;
+
+	struct tdm_chan_cfg tx;
+	struct tdm_chan_cfg rx;
+
+	u16 syncdiv;
+	u32 samplerate;
+	u32 pcmclk;
+
+	/* data related to DMA transfers b/w tdm and DMAC */
+	struct snd_dmaengine_dai_dma_data play_dma_data;
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	u32 saved_pcmgbcr;
+	u32 saved_pcmtxcr;
+	u32 saved_pcmrxcr;
+	u32 saved_pcmdiv;
+};
+
+static inline u32 jh7110_tdm_readl(struct jh7110_tdm_dev *tdm, u16 reg)
+{
+	return readl_relaxed(tdm->tdm_base + reg);
+}
+
+static inline void jh7110_tdm_writel(struct jh7110_tdm_dev *tdm, u16 reg, u32 val)
+{
+	writel_relaxed(val, tdm->tdm_base + reg);
+}
+
+static void jh7110_tdm_save_context(struct jh7110_tdm_dev *tdm,
+				    struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		tdm->saved_pcmtxcr = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
+	else
+		tdm->saved_pcmrxcr = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
+}
+
+static void jh7110_tdm_start(struct jh7110_tdm_dev *tdm,
+			     struct snd_pcm_substream *substream)
+{
+	u32 data;
+
+	data = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
+	jh7110_tdm_writel(tdm, TDM_PCMGBCR, data | PCMGBCR_ENABLE);
+
+	/* restore context */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		jh7110_tdm_writel(tdm, TDM_PCMTXCR, tdm->saved_pcmtxcr | PCMTXCR_TXEN);
+	else
+		jh7110_tdm_writel(tdm, TDM_PCMRXCR, tdm->saved_pcmrxcr | PCMRXCR_RXEN);
+}
+
+static void jh7110_tdm_stop(struct jh7110_tdm_dev *tdm,
+			    struct snd_pcm_substream *substream)
+{
+	unsigned int val;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		val = jh7110_tdm_readl(tdm, TDM_PCMTXCR);
+		val &= ~PCMTXCR_TXEN;
+		jh7110_tdm_writel(tdm, TDM_PCMTXCR, val);
+	} else {
+		val = jh7110_tdm_readl(tdm, TDM_PCMRXCR);
+		val &= ~PCMRXCR_RXEN;
+		jh7110_tdm_writel(tdm, TDM_PCMRXCR, val);
+	}
+}
+
+static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
+{
+	u32 sl, sscale, syncdiv;
+
+	if (tdm->rx.sl >= tdm->tx.sl)
+		sl = tdm->rx.sl;
+	else
+		sl = tdm->tx.sl;
+
+	if (tdm->rx.sscale >= tdm->tx.sscale)
+		sscale = tdm->rx.sscale;
+	else
+		sscale = tdm->tx.sscale;
+
+	syncdiv = tdm->pcmclk / tdm->samplerate - 1;
+
+	if ((syncdiv + 1) < (sl * sscale)) {
+		dev_err(tdm->dev, "Failed to set syncdiv!\n");
+		return -EINVAL;
+	}
+
+	if (tdm->syncm == TDM_SYNCM_LONG &&
+	    (tdm->rx.sscale <= 1 || tdm->tx.sscale <= 1) &&
+	    ((syncdiv + 1) <= sl)) {
+		dev_err(tdm->dev, "Wrong syncdiv! It must be (syncdiv+1) > max[tx.sl, rx.sl]\n");
+		return -EINVAL;
+	}
+
+	jh7110_tdm_writel(tdm, TDM_PCMDIV, syncdiv);
+	return 0;
+}
+
+static int jh7110_tdm_config(struct jh7110_tdm_dev *tdm,
+			     struct snd_pcm_substream *substream)
+{
+	u32 datarx, datatx;
+	int ret;
+
+	ret = jh7110_tdm_syncdiv(tdm);
+	if (ret)
+		return ret;
+
+	datarx = (tdm->rx.ifl << IFL_BIT) |
+		  (tdm->rx.wl << WL_BIT) |
+		  (tdm->rx.sscale << SSCALE_BIT) |
+		  (tdm->rx.sl << SL_BIT) |
+		  (tdm->rx.lrj << LRJ_BIT);
+
+	datatx = (tdm->tx.ifl << IFL_BIT) |
+		  (tdm->tx.wl << WL_BIT) |
+		  (tdm->tx.sscale << SSCALE_BIT) |
+		  (tdm->tx.sl << SL_BIT) |
+		  (tdm->tx.lrj << LRJ_BIT);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		jh7110_tdm_writel(tdm, TDM_PCMTXCR, datatx);
+	else
+		jh7110_tdm_writel(tdm, TDM_PCMRXCR, datarx);
+
+	return 0;
+}
+
+static void jh7110_tdm_clk_disable(struct jh7110_tdm_dev *tdm)
+{
+	clk_bulk_disable_unprepare(ARRAY_SIZE(tdm->clks), tdm->clks);
+}
+
+static int jh7110_tdm_clk_enable(struct jh7110_tdm_dev *tdm)
+{
+	int ret;
+
+	ret = clk_bulk_prepare_enable(ARRAY_SIZE(tdm->clks), tdm->clks);
+	if (ret) {
+		dev_err(tdm->dev, "Failed to enable tdm clocks\n");
+		return ret;
+	}
+
+	ret = reset_control_deassert(tdm->resets);
+	if (ret) {
+		dev_err(tdm->dev, "Failed to deassert tdm resets\n");
+		goto dis_tdm_clk;
+	}
+
+	/* select tdm_ext clock as the clock source for tdm */
+	ret = clk_set_parent(tdm->clks[5].clk, tdm->clks[4].clk);
+	if (ret) {
+		dev_err(tdm->dev, "Can't set extern clock source for clk_tdm\n");
+		goto dis_tdm_clk;
+	}
+
+	return 0;
+
+dis_tdm_clk:
+	clk_bulk_disable_unprepare(ARRAY_SIZE(tdm->clks), tdm->clks);
+
+	return ret;
+}
+
+static int jh7110_tdm_runtime_suspend(struct device *dev)
+{
+	struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
+
+	jh7110_tdm_clk_disable(tdm);
+	return 0;
+}
+
+static int jh7110_tdm_runtime_resume(struct device *dev)
+{
+	struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
+
+	return jh7110_tdm_clk_enable(tdm);
+}
+
+static int jh7110_tdm_system_suspend(struct device *dev)
+{
+	struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
+
+	/* save context */
+	tdm->saved_pcmgbcr = jh7110_tdm_readl(tdm, TDM_PCMGBCR);
+	tdm->saved_pcmdiv = jh7110_tdm_readl(tdm, TDM_PCMDIV);
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int jh7110_tdm_system_resume(struct device *dev)
+{
+	struct jh7110_tdm_dev *tdm = dev_get_drvdata(dev);
+
+	/* restore context */
+	jh7110_tdm_writel(tdm, TDM_PCMGBCR, tdm->saved_pcmgbcr);
+	jh7110_tdm_writel(tdm, TDM_PCMDIV, tdm->saved_pcmdiv);
+
+	return pm_runtime_force_resume(dev);
+}
+
+static const struct snd_soc_component_driver jh7110_tdm_component = {
+	.name = "jh7110-tdm",
+};
+
+static int jh7110_tdm_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+	dai_link->stop_dma_first = 1;
+
+	return 0;
+}
+
+static int jh7110_tdm_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
+	int chan_wl, chan_sl, chan_nr;
+	unsigned int data_width;
+	unsigned int dma_bus_width;
+	struct snd_dmaengine_dai_dma_data *dma_data = NULL;
+	int ret;
+
+	data_width = params_width(params);
+
+	tdm->samplerate = params_rate(params);
+	tdm->pcmclk = params_channels(params) * tdm->samplerate * data_width;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		chan_wl = TDM_16BIT_WORD_LEN;
+		chan_sl = TDM_16BIT_SLOT_LEN;
+		dma_bus_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		chan_wl = TDM_32BIT_WORD_LEN;
+		chan_sl = TDM_32BIT_SLOT_LEN;
+		dma_bus_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+
+	default:
+		dev_err(tdm->dev, "tdm: unsupported PCM fmt");
+		return -EINVAL;
+	}
+
+	chan_nr = params_channels(params);
+	switch (chan_nr) {
+	case 1:
+	case 2:
+	case 4:
+	case 6:
+	case 8:
+		break;
+	default:
+		dev_err(tdm->dev, "channel not supported\n");
+		return -EINVAL;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		tdm->tx.wl = chan_wl;
+		tdm->tx.sl = chan_sl;
+		tdm->tx.sscale = chan_nr;
+		tdm->play_dma_data.addr_width = dma_bus_width;
+		dma_data = &tdm->play_dma_data;
+	} else {
+		tdm->rx.wl = chan_wl;
+		tdm->rx.sl = chan_sl;
+		tdm->rx.sscale = chan_nr;
+		tdm->capture_dma_data.addr_width = dma_bus_width;
+		dma_data = &tdm->capture_dma_data;
+	}
+
+	snd_soc_dai_set_dma_data(dai, substream, dma_data);
+
+	ret = jh7110_tdm_config(tdm, substream);
+	if (ret)
+		return ret;
+
+	jh7110_tdm_save_context(tdm, substream);
+	return 0;
+}
+
+static int jh7110_tdm_trigger(struct snd_pcm_substream *substream,
+			      int cmd, struct snd_soc_dai *dai)
+{
+	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		jh7110_tdm_start(tdm, substream);
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		jh7110_tdm_stop(tdm, substream);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int jh7110_tdm_set_dai_fmt(struct snd_soc_dai *cpu_dai,
+				  unsigned int fmt)
+{
+	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned int gbcr;
+
+	/* set master/slave audio interface */
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BP_FP:
+		/* cpu is master */
+		tdm->ms_mode = TDM_AS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_BC_FC:
+		/* codec is master */
+		tdm->ms_mode = TDM_AS_SLAVE;
+		break;
+	case SND_SOC_DAIFMT_BC_FP:
+	case SND_SOC_DAIFMT_BP_FC:
+		return -EINVAL;
+	default:
+		dev_dbg(tdm->dev, "dwc : Invalid clock provider format\n");
+		return -EINVAL;
+	}
+
+	gbcr = (tdm->clkpolity << CLKPOL_BIT) |
+		(tdm->elm << ELM_BIT) |
+		(tdm->syncm << SYNCM_BIT) |
+		(tdm->ms_mode << MS_BIT);
+	jh7110_tdm_writel(tdm, TDM_PCMGBCR, gbcr);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops jh7110_tdm_dai_ops = {
+	.startup	= jh7110_tdm_startup,
+	.hw_params	= jh7110_tdm_hw_params,
+	.trigger	= jh7110_tdm_trigger,
+	.set_fmt	= jh7110_tdm_set_dai_fmt,
+};
+
+static int jh7110_tdm_dai_probe(struct snd_soc_dai *dai)
+{
+	struct jh7110_tdm_dev *tdm = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai, &tdm->play_dma_data, &tdm->capture_dma_data);
+	snd_soc_dai_set_drvdata(dai, tdm);
+	return 0;
+}
+
+#define JH7110_TDM_RATES	SNDRV_PCM_RATE_8000_48000
+
+#define JH7110_TDM_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver jh7110_tdm_dai = {
+	.name = "sf_tdm",
+	.id = 0,
+	.playback = {
+		.stream_name    = "Playback",
+		.channels_min   = 1,
+		.channels_max   = 8,
+		.rates          = JH7110_TDM_RATES,
+		.formats        = JH7110_TDM_FORMATS,
+	},
+	.capture = {
+		.stream_name    = "Capture",
+		.channels_min   = 1,
+		.channels_max   = 8,
+		.rates          = JH7110_TDM_RATES,
+		.formats        = JH7110_TDM_FORMATS,
+	},
+	.ops = &jh7110_tdm_dai_ops,
+	.probe = jh7110_tdm_dai_probe,
+	.symmetric_rate = 1,
+};
+
+static const struct snd_pcm_hardware jh7110_pcm_hardware = {
+	.info			= (SNDRV_PCM_INFO_MMAP		|
+				   SNDRV_PCM_INFO_MMAP_VALID	|
+				   SNDRV_PCM_INFO_PAUSE		|
+				   SNDRV_PCM_INFO_RESUME	|
+				   SNDRV_PCM_INFO_INTERLEAVED	|
+				   SNDRV_PCM_INFO_BLOCK_TRANSFER),
+	.buffer_bytes_max	= 192512,
+	.period_bytes_min	= 4096,
+	.period_bytes_max	= 32768,
+	.periods_min		= 1,
+	.periods_max		= 48,
+	.fifo_size		= 16,
+};
+
+static const struct snd_dmaengine_pcm_config jh7110_dmaengine_pcm_config = {
+	.pcm_hardware = &jh7110_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.prealloc_buffer_size = 192512,
+};
+
+static void jh7110_tdm_init_params(struct jh7110_tdm_dev *tdm)
+{
+	tdm->clkpolity = TDM_TX_RASING_RX_FALLING;
+	tdm->elm = TDM_ELM_LATE;
+	tdm->syncm = TDM_SYNCM_SHORT;
+
+	tdm->rx.ifl = TDM_FIFO_HALF;
+	tdm->tx.ifl = TDM_FIFO_HALF;
+	tdm->rx.wl = TDM_16BIT_WORD_LEN;
+	tdm->tx.wl = TDM_16BIT_WORD_LEN;
+	tdm->rx.sscale = 2;
+	tdm->tx.sscale = 2;
+	tdm->rx.lrj = TDM_LEFT_JUSTIFT;
+	tdm->tx.lrj = TDM_LEFT_JUSTIFT;
+
+	tdm->play_dma_data.addr = JH7110_TDM_FIFO;
+	tdm->play_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	tdm->play_dma_data.fifo_size = JH7110_TDM_FIFO_DEPTH / 2;
+	tdm->play_dma_data.maxburst = 16;
+
+	tdm->capture_dma_data.addr = JH7110_TDM_FIFO;
+	tdm->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	tdm->capture_dma_data.fifo_size = JH7110_TDM_FIFO_DEPTH / 2;
+	tdm->capture_dma_data.maxburst = 8;
+}
+
+static int jh7110_tdm_clk_reset_get(struct platform_device *pdev,
+				    struct jh7110_tdm_dev *tdm)
+{
+	int ret;
+
+	tdm->clks[0].id = "mclk_inner";
+	tdm->clks[1].id = "tdm_ahb";
+	tdm->clks[2].id = "tdm_apb";
+	tdm->clks[3].id = "tdm_internal";
+	tdm->clks[4].id = "tdm_ext";
+	tdm->clks[5].id = "tdm";
+
+	ret = devm_clk_bulk_get(&pdev->dev, ARRAY_SIZE(tdm->clks), tdm->clks);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to get tdm clocks\n");
+		return ret;
+	}
+
+	tdm->resets = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR_OR_NULL(tdm->resets)) {
+		ret = PTR_ERR(tdm->resets);
+		dev_err(&pdev->dev, "Failed to get tdm resets");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int jh7110_tdm_probe(struct platform_device *pdev)
+{
+	struct jh7110_tdm_dev *tdm;
+	int ret;
+
+	tdm = devm_kzalloc(&pdev->dev, sizeof(*tdm), GFP_KERNEL);
+	if (!tdm)
+		return -ENOMEM;
+
+	tdm->tdm_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tdm->tdm_base))
+		return PTR_ERR(tdm->tdm_base);
+
+	tdm->dev = &pdev->dev;
+
+	ret = jh7110_tdm_clk_reset_get(pdev, tdm);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to enable audio-tdm clock\n");
+		return ret;
+	}
+
+	jh7110_tdm_init_params(tdm);
+
+	dev_set_drvdata(&pdev->dev, tdm);
+	ret = devm_snd_soc_register_component(&pdev->dev, &jh7110_tdm_component,
+					      &jh7110_tdm_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register dai\n");
+		return ret;
+	}
+
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev,
+					      &jh7110_dmaengine_pcm_config,
+					      SND_DMAENGINE_PCM_FLAG_COMPAT);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not register pcm: %d\n", ret);
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	if (!pm_runtime_enabled(&pdev->dev)) {
+		ret = jh7110_tdm_runtime_resume(&pdev->dev);
+		if (ret)
+			goto err_pm_disable;
+	}
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int jh7110_tdm_dev_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id jh7110_tdm_of_match[] = {
+	{ .compatible = "starfive,jh7110-tdm", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, jh7110_tdm_of_match);
+
+static const struct dev_pm_ops jh7110_tdm_pm_ops = {
+	RUNTIME_PM_OPS(jh7110_tdm_runtime_suspend,
+		       jh7110_tdm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(jh7110_tdm_system_suspend,
+			    jh7110_tdm_system_resume)
+};
+
+static struct platform_driver jh7110_tdm_driver = {
+	.driver = {
+		.name = "jh7110-tdm",
+		.of_match_table = jh7110_tdm_of_match,
+		.pm = pm_ptr(&jh7110_tdm_pm_ops),
+	},
+	.probe = jh7110_tdm_probe,
+	.remove = jh7110_tdm_dev_remove,
+};
+module_platform_driver(jh7110_tdm_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 TDM ASoC Driver");
+MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_LICENSE("GPL");
-- 
2.17.1

