Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60772C26E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjFLLGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbjFLLFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FDA274;
        Mon, 12 Jun 2023 03:53:41 -0700 (PDT)
X-UUID: 6172414c090f11ee9cb5633481061a41-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MJEyL8jMkELitxC8ODg8qd4/tZzZRqnj1z2BFS+GrJU=;
        b=RmJrnLlteUpJINA3EoAphI8FY3hMyofHodMV1UvbP/YGMlc50F8GJqx47pkJDU1vnd673eB/tWS7I0q/muMe4rEp+oBoJ3DjTGIq3jFWXFboUysahUpQp2uZPs4uI9RwH22IR28N8PqYHrZkWW0fTCIkxUp8kliiPjVvdrRErzw=;
X-CID-CACHE: Type:Local,Time:202306121844+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:f434cd60-ecac-4c96-a030-68c38fafb66a,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:2622ce6e-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6172414c090f11ee9cb5633481061a41-20230612
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 499495370; Mon, 12 Jun 2023 18:53:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:34 +0800
From:   Maso Hunag <maso.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 3/7] ASoC: mediatek: mt79xx: add platform driver
Date:   Mon, 12 Jun 2023 18:52:46 +0800
Message-ID: <20230612105250.15441-4-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230612105250.15441-1-maso.huang@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maso Huang <maso.huang@mediatek.com>

Add mt79xx platform driver.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/Kconfig                 |  10 +
 sound/soc/mediatek/Makefile                |   1 +
 sound/soc/mediatek/mt79xx/Makefile         |   9 +
 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c | 608 +++++++++++++++++++++
 4 files changed, 628 insertions(+)
 create mode 100644 sound/soc/mediatek/mt79xx/Makefile
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 4baac72677d9..192546078d5e 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -54,6 +54,16 @@ config SND_SOC_MT6797_MT6351
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT79XX
+	tristate "ASoC support for Mediatek MT79XX chip"
+	depends on ARCH_MEDIATEK
+	select SND_SOC_MEDIATEK
+	help
+	  This adds ASoC platform driver support for MediaTek MT79XX chip
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8173
 	tristate "ASoC support for Mediatek MT8173 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 3de38cfc69e5..b2e530629887 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_SND_SOC_MEDIATEK) += common/
 obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
+obj-$(CONFIG_SND_SOC_MT79XX) += mt79xx/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
 obj-$(CONFIG_SND_SOC_MT8183) += mt8183/
 obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
diff --git a/sound/soc/mediatek/mt79xx/Makefile b/sound/soc/mediatek/mt79xx/Makefile
new file mode 100644
index 000000000000..984b20ae8819
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# platform driver
+snd-soc-mt79xx-afe-objs := \
+	mt79xx-afe-pcm.o \
+	mt79xx-afe-clk.o \
+	mt79xx-dai-etdm.o
+
+obj-$(CONFIG_SND_SOC_MT79XX) += snd-soc-mt79xx-afe.o
diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c b/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
new file mode 100644
index 000000000000..69c5f3f3f84b
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-pcm.c
@@ -0,0 +1,608 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek ALSA SoC AFE platform driver for MT79xx
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+
+#include "mt79xx-afe-common.h"
+#include "mt79xx-afe-clk.h"
+#include "mt79xx-reg.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-afe-fe-dai.h"
+
+enum {
+	MTK_AFE_RATE_8K = 0,
+	MTK_AFE_RATE_11K = 1,
+	MTK_AFE_RATE_12K = 2,
+	MTK_AFE_RATE_16K = 4,
+	MTK_AFE_RATE_22K = 5,
+	MTK_AFE_RATE_24K = 6,
+	MTK_AFE_RATE_32K = 8,
+	MTK_AFE_RATE_44K = 9,
+	MTK_AFE_RATE_48K = 10,
+	MTK_AFE_RATE_88K = 13,
+	MTK_AFE_RATE_96K = 14,
+	MTK_AFE_RATE_176K = 17,
+	MTK_AFE_RATE_192K = 18,
+};
+
+unsigned int mt79xx_afe_rate_transform(struct device *dev,
+				       unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_RATE_8K;
+	case 11025:
+		return MTK_AFE_RATE_11K;
+	case 12000:
+		return MTK_AFE_RATE_12K;
+	case 16000:
+		return MTK_AFE_RATE_16K;
+	case 22050:
+		return MTK_AFE_RATE_22K;
+	case 24000:
+		return MTK_AFE_RATE_24K;
+	case 32000:
+		return MTK_AFE_RATE_32K;
+	case 44100:
+		return MTK_AFE_RATE_44K;
+	case 48000:
+		return MTK_AFE_RATE_48K;
+	case 88200:
+		return MTK_AFE_RATE_88K;
+	case 96000:
+		return MTK_AFE_RATE_96K;
+	case 176400:
+		return MTK_AFE_RATE_176K;
+	case 192000:
+		return MTK_AFE_RATE_192K;
+	default:
+		dev_warn(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__, rate, MTK_AFE_RATE_48K);
+		return MTK_AFE_RATE_48K;
+	}
+}
+
+static const struct snd_pcm_hardware mt79xx_afe_hardware = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP_VALID,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE |
+		   SNDRV_PCM_FMTBIT_S24_LE |
+		   SNDRV_PCM_FMTBIT_S32_LE,
+	.period_bytes_min = 256,
+	.period_bytes_max = 4 * 48 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 8 * 48 * 1024,
+	.fifo_size = 0,
+};
+
+static int mt79xx_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return mt79xx_afe_rate_transform(afe->dev, rate);
+}
+
+static int mt79xx_irq_fs(struct snd_pcm_substream *substream,
+			 unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return mt79xx_afe_rate_transform(afe->dev, rate);
+}
+
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		       SNDRV_PCM_RATE_88200 |\
+		       SNDRV_PCM_RATE_96000 |\
+		       SNDRV_PCM_RATE_176400 |\
+		       SNDRV_PCM_RATE_192000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mt79xx_memif_dai_driver[] = {
+	/* FE DAIs: memory intefaces to CPU */
+	{
+		.name = "DL1",
+		.id = MT79XX_MEMIF_DL1,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+	{
+		.name = "UL1",
+		.id = MT79XX_MEMIF_VUL12,
+		.capture = {
+			.stream_name = "UL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mtk_afe_fe_ops,
+	},
+};
+
+static const struct snd_kcontrol_new o018_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I150_Switch", AFE_CONN018_4, 22, 1, 0),
+};
+
+static const struct snd_kcontrol_new o019_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I151_Switch", AFE_CONN019_4, 23, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget mt79xx_memif_widgets[] = {
+	/* DL */
+	SND_SOC_DAPM_MIXER("I032", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_MIXER("I033", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* UL */
+	SND_SOC_DAPM_MIXER("O018", SND_SOC_NOPM, 0, 0,
+			   o018_mix, ARRAY_SIZE(o018_mix)),
+	SND_SOC_DAPM_MIXER("O019", SND_SOC_NOPM, 0, 0,
+			   o019_mix, ARRAY_SIZE(o019_mix)),
+};
+
+static const struct snd_soc_dapm_route mt79xx_memif_routes[] = {
+	{"I032", NULL, "DL1"},
+	{"I033", NULL, "DL1"},
+	{"UL1", NULL, "O018"},
+	{"UL1", NULL, "O019"},
+	{"O018", "I150_Switch", "I150"},
+	{"O019", "I151_Switch", "I151"},
+};
+
+static const struct snd_soc_component_driver mt79xx_afe_pcm_dai_component = {
+	.name = "mt79xx-afe-pcm-dai",
+};
+
+static const struct mtk_base_memif_data memif_data[MT79XX_MEMIF_NUM] = {
+	[MT79XX_MEMIF_DL1] = {
+		.name = "DL1",
+		.id = MT79XX_MEMIF_DL1,
+		.reg_ofs_base = AFE_DL0_BASE,
+		.reg_ofs_cur = AFE_DL0_CUR,
+		.reg_ofs_end = AFE_DL0_END,
+		.reg_ofs_base_msb = AFE_DL0_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL0_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL0_END_MSB,
+		.fs_reg = AFE_DL0_CON0,
+		.fs_shift =  DL0_MODE_SFT,
+		.fs_maskbit =  DL0_MODE_MASK,
+		.mono_reg = AFE_DL0_CON0,
+		.mono_shift = DL0_MONO_SFT,
+		.enable_reg = AFE_DL0_CON0,
+		.enable_shift = DL0_ON_SFT,
+		.hd_reg = AFE_DL0_CON0,
+		.hd_shift = DL0_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL0_CON0,
+		.hd_align_mshift = DL0_HALIGN_SFT,
+		.pbuf_reg = AFE_DL0_CON0,
+		.pbuf_shift = DL0_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL0_CON0,
+		.minlen_shift = DL0_MINLEN_SFT,
+	},
+	[MT79XX_MEMIF_VUL12] = {
+		.name = "VUL12",
+		.id = MT79XX_MEMIF_VUL12,
+		.reg_ofs_base = AFE_VUL0_BASE,
+		.reg_ofs_cur = AFE_VUL0_CUR,
+		.reg_ofs_end = AFE_VUL0_END,
+		.reg_ofs_base_msb = AFE_VUL0_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL0_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL0_END_MSB,
+		.fs_reg = AFE_VUL0_CON0,
+		.fs_shift = VUL0_MODE_SFT,
+		.fs_maskbit = VUL0_MODE_MASK,
+		.mono_reg = AFE_VUL0_CON0,
+		.mono_shift = VUL0_MONO_SFT,
+		.enable_reg = AFE_VUL0_CON0,
+		.enable_shift = VUL0_ON_SFT,
+		.hd_reg = AFE_VUL0_CON0,
+		.hd_shift = VUL0_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL0_CON0,
+		.hd_align_mshift = VUL0_HALIGN_SFT,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[MT79XX_IRQ_NUM] = {
+	[MT79XX_IRQ_0] = {
+		.id = MT79XX_IRQ_0,
+		.irq_cnt_reg = AFE_IRQ0_MCU_CFG1,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ0_MCU_CFG0,
+		.irq_fs_shift = IRQ_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ0_MCU_CFG0,
+		.irq_en_shift = IRQ_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ0_MCU_CLR_SFT,
+	},
+	[MT79XX_IRQ_1] = {
+		.id = MT79XX_IRQ_1,
+		.irq_cnt_reg = AFE_IRQ1_MCU_CFG1,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ1_MCU_CFG0,
+		.irq_fs_shift = IRQ_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ1_MCU_CFG0,
+		.irq_en_shift = IRQ_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ1_MCU_CLR_SFT,
+	},
+	[MT79XX_IRQ_2] = {
+		.id = MT79XX_IRQ_2,
+		.irq_cnt_reg = AFE_IRQ2_MCU_CFG1,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ2_MCU_CFG0,
+		.irq_fs_shift = IRQ_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ2_MCU_CFG0,
+		.irq_en_shift = IRQ_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ2_MCU_CLR_SFT,
+	},
+};
+
+static bool mt79xx_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* these auto-gen reg has read-only bit, so put it as volatile */
+	/* volatile reg cannot be cached, so cannot be set when power off */
+	switch (reg) {
+	case AFE_DL0_CUR_MSB:
+	case AFE_DL0_CUR:
+	case AFE_DL0_RCH_MON:
+	case AFE_DL0_LCH_MON:
+	case AFE_VUL0_CUR_MSB:
+	case AFE_VUL0_CUR:
+	case AFE_IRQ_MCU_STATUS:
+	case AFE_MEMIF_RD_MON:
+	case AFE_MEMIF_WR_MON:
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config mt79xx_afe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.volatile_reg = mt79xx_is_volatile_reg,
+	.max_register = AFE_MAX_REGISTER,
+	.num_reg_defaults_raw = ((AFE_MAX_REGISTER / 4) + 1),
+};
+
+static irqreturn_t mt79xx_afe_irq_handler(int irq_id, void *dev)
+{
+	struct mtk_base_afe *afe = dev;
+	struct mtk_base_afe_irq *irq;
+	unsigned int status;
+	unsigned int status_mcu;
+	unsigned int mcu_en;
+	int ret;
+	int i;
+	irqreturn_t irq_ret = IRQ_HANDLED;
+
+	/* get irq that is sent to MCU */
+	regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
+
+	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
+	/* only care IRQ which is sent to MCU */
+	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
+
+	if (ret || status_mcu == 0) {
+		dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x,
+			mcu_en 0x%x\n", __func__, ret, status, mcu_en);
+
+		irq_ret = IRQ_NONE;
+		goto err_irq;
+	}
+
+	for (i = 0; i < MT79XX_MEMIF_NUM; i++) {
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+
+		if (!memif->substream)
+			continue;
+
+		if (memif->irq_usage < 0)
+			continue;
+
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
+			snd_pcm_period_elapsed(memif->substream);
+	}
+
+err_irq:
+	/* clear irq */
+	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, status_mcu);
+
+	return irq_ret;
+}
+
+static int mt79xx_afe_runtime_suspend(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	/* disable clk*/
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4, 0x3fff, 0x3fff);
+	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_APLL2_EN_MASK,
+			   0);
+	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_26M_EN_MASK,
+			   0);
+
+	/* make sure all irq status are cleared, twice intended */
+	regmap_update_bits(afe->regmap, AFE_IRQ_MCU_CLR, 0xffff, 0xffff);
+
+skip_regmap:
+	return mt79xx_afe_disable_clock(afe);
+}
+
+static int mt79xx_afe_runtime_resume(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt79xx_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = mt79xx_afe_enable_clock(afe);
+	if (ret)
+		return ret;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	/* enable clk*/
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4, 0x3fff, 0);
+	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_APLL2_EN_MASK,
+			   AUD_APLL2_EN);
+	regmap_update_bits(afe->regmap, AUDIO_ENGEN_CON0, AUD_26M_EN_MASK,
+			   AUD_26M_EN);
+
+skip_regmap:
+	return 0;
+}
+
+static int mt79xx_afe_component_probe(struct snd_soc_component *component)
+{
+	return mtk_afe_add_sub_dai_control(component);
+}
+
+static const struct snd_soc_component_driver mt79xx_afe_component = {
+	.name = AFE_PCM_NAME,
+	.probe = mt79xx_afe_component_probe,
+	.pointer	= mtk_afe_pcm_pointer,
+	.pcm_construct	= mtk_afe_pcm_new,
+};
+
+static int mt79xx_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mt79xx_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mt79xx_memif_dai_driver);
+
+	dai->dapm_widgets = mt79xx_memif_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mt79xx_memif_widgets);
+	dai->dapm_routes = mt79xx_memif_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mt79xx_memif_routes);
+
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	mt79xx_dai_etdm_register,
+	mt79xx_dai_memif_register,
+};
+
+static int mt79xx_afe_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe;
+	struct mt79xx_afe_private *afe_priv;
+	struct device *dev;
+	int i, irq_id, ret;
+
+	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, afe);
+
+	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
+					  GFP_KERNEL);
+	if (!afe->platform_priv)
+		return -ENOMEM;
+
+	afe_priv = afe->platform_priv;
+	afe->dev = &pdev->dev;
+	dev = afe->dev;
+
+	afe->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(afe->base_addr))
+		return PTR_ERR(afe->base_addr);
+
+	/* initial audio related clock */
+	ret = mt79xx_init_clock(afe);
+	if (ret) {
+		dev_err(dev, "init clock error\n");
+		return ret;
+	}
+
+	pm_runtime_enable(dev);
+
+	/* enable clock for regcache get default value from hw */
+	afe_priv->pm_runtime_bypass_reg_ctl = true;
+	pm_runtime_get_sync(&pdev->dev);
+
+	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
+		      &mt79xx_afe_regmap_config);
+	if (IS_ERR(afe->regmap)) {
+		ret = PTR_ERR(afe->regmap);
+		goto err_pm_disable;
+	}
+
+	pm_runtime_put_sync(&pdev->dev);
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
+	/* init memif */
+	afe->memif_size = MT79XX_MEMIF_NUM;
+	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
+				  GFP_KERNEL);
+	if (!afe->memif)
+		goto err_pm_disable;
+
+	for (i = 0; i < afe->memif_size; i++) {
+		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].irq_usage = -1;
+	}
+
+	mutex_init(&afe->irq_alloc_lock);
+
+	/* irq initialize */
+	afe->irqs_size = MT79XX_IRQ_NUM;
+	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
+				 GFP_KERNEL);
+	if (!afe->irqs)
+		goto err_pm_disable;
+
+	for (i = 0; i < afe->irqs_size; i++)
+		afe->irqs[i].irq_data = &irq_data[i];
+
+	/* request irq */
+	irq_id = platform_get_irq(pdev, 0);
+	if (!irq_id) {
+		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
+		goto err_pm_disable;
+	}
+	ret = devm_request_irq(dev, irq_id, mt79xx_afe_irq_handler,
+			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
+	if (ret) {
+		dev_err(dev, "could not request_irq for asys-isr\n");
+		goto err_pm_disable;
+	}
+
+	/* init sub_dais */
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret) {
+			dev_warn(afe->dev, "dai register i %d fail, ret %d\n",
+				 i, ret);
+			goto err_pm_disable;
+		}
+	}
+
+	/* init dai_driver and component_driver */
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret) {
+		dev_warn(afe->dev, "mtk_afe_combine_sub_dai fail, ret %d\n",
+			 ret);
+		goto err_pm_disable;
+	}
+
+	afe->mtk_afe_hardware = &mt79xx_afe_hardware;
+	afe->memif_fs = mt79xx_memif_fs;
+	afe->irq_fs = mt79xx_irq_fs;
+
+	afe->runtime_resume = mt79xx_afe_runtime_resume;
+	afe->runtime_suspend = mt79xx_afe_runtime_suspend;
+
+	/* register component */
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &mt79xx_afe_component,
+					      NULL, 0);
+	if (ret) {
+		dev_warn(dev, "err_platform\n");
+		goto err_pm_disable;
+	}
+
+	ret = devm_snd_soc_register_component(afe->dev,
+					      &mt79xx_afe_pcm_dai_component,
+					      afe->dai_drivers,
+					      afe->num_dai_drivers);
+	if (ret) {
+		dev_warn(dev, "err_dai_component\n");
+		goto err_pm_disable;
+	}
+
+	return ret;
+
+err_pm_disable:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static int mt79xx_afe_pcm_dev_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mt79xx_afe_runtime_suspend(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id mt79xx_afe_pcm_dt_match[] = {
+	{ .compatible = "mediatek,mt79xx-afe", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt79xx_afe_pcm_dt_match);
+
+static const struct dev_pm_ops mt79xx_afe_pm_ops = {
+	SET_RUNTIME_PM_OPS(mt79xx_afe_runtime_suspend,
+			   mt79xx_afe_runtime_resume, NULL)
+};
+
+static struct platform_driver mt79xx_afe_pcm_driver = {
+	.driver = {
+		   .name = "mt79xx-audio",
+		   .of_match_table = mt79xx_afe_pcm_dt_match,
+		   .pm = &mt79xx_afe_pm_ops,
+	},
+	.probe = mt79xx_afe_pcm_dev_probe,
+	.remove = mt79xx_afe_pcm_dev_remove,
+};
+
+module_platform_driver(mt79xx_afe_pcm_driver);
+
+MODULE_DESCRIPTION("Mediatek SoC AFE platform driver for ALSA MT79xx");
+MODULE_AUTHOR("Vic Wu <vic.wu@mediatek.com>");
+MODULE_LICENSE("GPL");
-- 
2.18.0

