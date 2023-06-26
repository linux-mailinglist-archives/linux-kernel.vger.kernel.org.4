Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE12573DCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFZLJU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjFZLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:09:18 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBEC7;
        Mon, 26 Jun 2023 04:09:15 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id C230524DEC3;
        Mon, 26 Jun 2023 19:09:12 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:12 +0800
Received: from ubuntu.localdomain (113.72.146.167) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 26 Jun
 2023 19:09:11 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/5] ASoC: codecs: Add StarFive JH7110 dummy PWM-DAC transmitter driver
Date:   Mon, 26 Jun 2023 19:09:06 +0800
Message-ID: <20230626110909.38718-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230626110909.38718-1-hal.feng@starfivetech.com>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.167]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a dummy transmitter driver for StarFive JH7110 PWM-DAC module.
StarFive JH7110 PWM-DAC controller uses this driver.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 sound/soc/codecs/Kconfig                     |  4 ++
 sound/soc/codecs/Makefile                    |  2 +
 sound/soc/codecs/jh7110_pwmdac_transmitter.c | 74 ++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 sound/soc/codecs/jh7110_pwmdac_transmitter.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8020097d4e4c..f2cd8f999649 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -115,6 +115,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_IDT821034
 	imply SND_SOC_INNO_RK3036
 	imply SND_SOC_ISABELLE
+	imply SND_SOC_JH7110_PWMDAC_DIT
 	imply SND_SOC_JZ4740_CODEC
 	imply SND_SOC_JZ4725B_CODEC
 	imply SND_SOC_JZ4760_CODEC
@@ -903,6 +904,9 @@ config SND_SOC_CX2072X
 	help
 	  Enable support for Conexant CX20721 and CX20723 codec chips.
 
+config SND_SOC_JH7110_PWMDAC_DIT
+	tristate "StarFive JH7110 dummy PWM-DAC transmitter"
+
 config SND_SOC_JZ4740_CODEC
 	depends on MACH_INGENIC || COMPILE_TEST
 	depends on OF
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5cdbae88e6e3..8e0e12d7b959 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -122,6 +122,7 @@ snd-soc-ics43432-objs := ics43432.o
 snd-soc-idt821034-objs := idt821034.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
+snd-soc-jh7110-pwmdac-dit-objs := jh7110_pwmdac_transmitter.o
 snd-soc-jz4740-codec-objs := jz4740.o
 snd-soc-jz4725b-codec-objs := jz4725b.o
 snd-soc-jz4760-codec-objs := jz4760.o
@@ -496,6 +497,7 @@ obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_IDT821034)	+= snd-soc-idt821034.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
+obj-$(CONFIG_SND_SOC_JH7110_PWMDAC_DIT)	+= snd-soc-jh7110-pwmdac-dit.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
 obj-$(CONFIG_SND_SOC_JZ4725B_CODEC)	+= snd-soc-jz4725b-codec.o
 obj-$(CONFIG_SND_SOC_JZ4760_CODEC)      += snd-soc-jz4760-codec.o
diff --git a/sound/soc/codecs/jh7110_pwmdac_transmitter.c b/sound/soc/codecs/jh7110_pwmdac_transmitter.c
new file mode 100644
index 000000000000..69077be840c7
--- /dev/null
+++ b/sound/soc/codecs/jh7110_pwmdac_transmitter.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Dummy PWM-DAC transmitter driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <sound/initval.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "pwmdac-dit"
+
+static const struct snd_soc_dapm_widget dit_widgets[] = {
+	SND_SOC_DAPM_OUTPUT("pwmdac-out"),
+};
+
+static const struct snd_soc_dapm_route dit_routes[] = {
+	{ "pwmdac-out", NULL, "Playback" },
+};
+
+static const struct snd_soc_component_driver soc_codec_pwmdac_dit = {
+	.dapm_widgets		= dit_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
+	.dapm_routes		= dit_routes,
+	.num_dapm_routes	= ARRAY_SIZE(dit_routes),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static struct snd_soc_dai_driver dit_stub_dai = {
+	.name		= "pwmdac-dit-hifi",
+	.playback	= {
+		.stream_name	= "Playback",
+		.channels_min	= 1,
+		.channels_max	= 384,
+		.rates		= SNDRV_PCM_RATE_8000_48000,
+		.formats	= SNDRV_PCM_FMTBIT_S16_LE,
+	},
+};
+
+static int pwmdac_dit_probe(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_component(&pdev->dev,
+					       &soc_codec_pwmdac_dit,
+					       &dit_stub_dai, 1);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pwmdac_dit_dt_ids[] = {
+	{ .compatible = "starfive,jh7110-pwmdac-dit", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwmdac_dit_dt_ids);
+#endif
+
+static struct platform_driver pwmdac_dit_driver = {
+	.probe		= pwmdac_dit_probe,
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = of_match_ptr(pwmdac_dit_dt_ids),
+	},
+};
+
+module_platform_driver(pwmdac_dit_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 dummy PWM-DAC transmitter driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.38.1

