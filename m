Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B16230C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiKIQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKIQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:55:06 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D6027905;
        Wed,  9 Nov 2022 08:53:58 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A9EDShC027448;
        Wed, 9 Nov 2022 10:53:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=WM6jpW6DgTPjmvd0oslLtgv34/8CnmjVbElriUhAJ7E=;
 b=RCtGJsuZ6il9LrTz8eIp/sQMI+iCv+RGIzfZlTAFcmqlnahhgPhoi4tLEsd1azxCfryq
 a+6EwJalLMDEEGD6/iJjgtxptIPvW82dA/lh4uaRJhfawvuxehrKEG7xcRhkZ/C/97mo
 4vXqbwdSg6xUupiy1hyEsggpgS6cVj28rdDYmQOFVkT1viRhZ+KATlm/7hSEUCNtaPKq
 ZuVrMRFDUdLDRFPMeuh4fB2wqexrkY6JqR1VlGHSLNnHCSJTuwv6XpYpbhu6VATx+5A5
 MRX0+SexegibP6xKtk8SznWAluePlnxyjLmbRkKOH7SFIKmHEjHqrKhYZY0iq/p0OEqd +g== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3knm8pde8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:53:43 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.15; Wed, 9 Nov
 2022 10:53:38 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.15 via Frontend Transport; Wed, 9 Nov 2022 10:53:38 -0600
Received: from debianA11184.ad.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.92])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 41AC4468;
        Wed,  9 Nov 2022 16:53:38 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 12/12] ASoC: cs48l32: Add codec driver for Cirrus Logic CS48L31/32/33
Date:   Wed, 9 Nov 2022 16:53:31 +0000
Message-ID: <20221109165331.29332-13-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109165331.29332-1-rf@opensource.cirrus.com>
References: <20221109165331.29332-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I1EANI6z0MOXU1V1RIAxLhcETBc4_Rbt
X-Proofpoint-GUID: I1EANI6z0MOXU1V1RIAxLhcETBc4_Rbt
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Henderson <stuarth@opensource.cirrus.com>

The CS48L32 is a high-performance low-power audio DSP for smartphones
and other portable audio devices. The CS48L32 combines a programmable
Halo Core DSP with a variety of power-efficient fixed-function audio
processors.

Signed-off-by: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Qi Zhou <qi.zhou@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS                     |    4 +
 include/sound/cs48l32.h         |   89 +
 sound/soc/codecs/Kconfig        |    9 +
 sound/soc/codecs/Makefile       |    2 +
 sound/soc/codecs/cs48l32-core.c | 2782 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs48l32.c      | 1211 ++++++++++++++
 sound/soc/codecs/cs48l32.h      |  386 +++++
 7 files changed, 4483 insertions(+)
 create mode 100644 include/sound/cs48l32.h
 create mode 100644 sound/soc/codecs/cs48l32-core.c
 create mode 100644 sound/soc/codecs/cs48l32.c
 create mode 100644 sound/soc/codecs/cs48l32.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f52e9a6e290c..9d5ddb50f388 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5013,6 +5013,7 @@ F:	Documentation/devicetree/bindings/mfd/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+F:	Documentation/devicetree/bindings/sound/cirrus,cs48l32.yaml
 F:	Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 F:	drivers/gpio/gpio-madera*
 F:	drivers/irqchip/irq-cirrus-cs48l32*
@@ -5021,13 +5022,16 @@ F:	drivers/mfd/cs47l*
 F:	drivers/mfd/cs48l*
 F:	drivers/mfd/madera*
 F:	drivers/pinctrl/cirrus/*
+F:	include/dt-bindings/sound/cs48l32.h
 F:	include/dt-bindings/sound/madera*
 F:	include/linux/irqchip/irq-cirrus-cs48l32*
 F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/cs48l32/*
 F:	include/linux/mfd/madera/*
+F:	include/sound/cs48l32.h
 F:	include/sound/madera*
 F:	sound/soc/codecs/cs47l*
+F:	sound/soc/codecs/cs48l32*
 F:	sound/soc/codecs/madera*
 
 CISCO FCOE HBA DRIVER
diff --git a/include/sound/cs48l32.h b/include/sound/cs48l32.h
new file mode 100644
index 000000000000..3078bb520dae
--- /dev/null
+++ b/include/sound/cs48l32.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Cirrus Logic CS48L32 codec
+ *
+ * Copyright (C) 2016-2018, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef SOUND_CS48L32_H
+#define SOUND_CS48L32_H
+
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/notifier.h>
+#include <sound/soc-component.h>
+
+/* pll_id for snd_soc_component_set_pll() */
+#define CS48L32_FLL1_REFCLK			1
+
+/* source for snd_soc_component_set_pll() */
+#define CS48L32_FLL_SRC_NONE			-1
+#define CS48L32_FLL_SRC_MCLK1			0
+#define CS48L32_FLL_SRC_PDMCLK			5
+#define CS48L32_FLL_SRC_ASP1_BCLK		8
+#define CS48L32_FLL_SRC_ASP2_BCLK		9
+#define CS48L32_FLL_SRC_ASP1_FSYNC		12
+#define CS48L32_FLL_SRC_ASP2_FSYNC		13
+
+/* clk_id for snd_soc_component_set_sysclk() and snd_soc_dai_set_sysclk() */
+#define CS48L32_CLK_SYSCLK_1			1
+#define CS48L32_CLK_SYSCLK_2			2
+#define CS48L32_CLK_SYSCLK_3			3
+#define CS48L32_CLK_SYSCLK_4			4
+#define CS48L32_CLK_DSPCLK			7
+#define CS48L32_CLK_OPCLK			9
+#define CS48L32_CLK_PDM_FLLCLK			13
+
+/* source for snd_soc_component_set_sysclk() */
+#define CS48L32_CLK_SRC_MCLK1			0x0
+#define CS48L32_CLK_SRC_FLL1			0x4
+#define CS48L32_CLK_SRC_ASP1_BCLK		0x8
+#define CS48L32_CLK_SRC_ASP2_BCLK		0x9
+
+/* Notifier events */
+#define CS48L32_NOTIFY_ULTRASONIC		0x1
+
+/**
+ * struct cs48l32_us_notify_data - Ultrasonic event notification data
+ * @us_no: Index of ultrasonic block that reported the event.
+ *
+ * Data passed in an ultrasonic notification event callback.
+ */
+struct cs48l32_us_notify_data {
+	unsigned int us_no;
+};
+
+/**
+ * cs48l32_register_notifier() - Register notification event callback
+ * @component:	ASoC component of the cs48l32 driver.
+ * @nb:		Client struct notifier_block.
+ *
+ * Return: 0 on success else standard negative error code.
+ */
+static inline int cs48l32_register_notifier(struct snd_soc_component *component,
+					    struct notifier_block *nb)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(component->dev->parent);
+
+	return blocking_notifier_chain_register(&mfd->notifier, nb);
+}
+
+/**
+ * cs48l32_unregister_notifier() - Unregister notification event callback
+ * @component:	ASoC component of the cs48l32 driver.
+ * @nb:		Client struct notifier_block.
+ *
+ * Unregister an event notifier callback that was registered by
+ * cs48l32_register_notifier().
+ *
+ * Return: 0 on success else standard negative error code.
+ */
+static inline int cs48l32_unregister_notifier(struct snd_soc_component *component,
+					      struct notifier_block *nb)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(component->dev->parent);
+
+	return blocking_notifier_chain_unregister(&mfd->notifier, nb);
+}
+
+#endif
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7a13e750751a..aadbdf33b373 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -87,6 +87,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_CS47L85
 	imply SND_SOC_CS47L90
 	imply SND_SOC_CS47L92
+	imply SND_SOC_CS48L32
 	imply SND_SOC_CS53L30
 	imply SND_SOC_CX20442
 	imply SND_SOC_CX2072X
@@ -351,6 +352,7 @@ config SND_SOC_WM_ADSP
 	select CS_DSP
 	select SND_SOC_COMPRESS
 	default y if SND_SOC_MADERA=y
+	default y if SND_SOC_CS48L32=y
 	default y if SND_SOC_CS47L24=y
 	default y if SND_SOC_WM5102=y
 	default y if SND_SOC_WM5110=y
@@ -358,6 +360,7 @@ config SND_SOC_WM_ADSP
 	default y if SND_SOC_CS35L41_SPI=y
 	default y if SND_SOC_CS35L41_I2C=y
 	default m if SND_SOC_MADERA=m
+	default m if SND_SOC_CS48L32=m
 	default m if SND_SOC_CS47L24=m
 	default m if SND_SOC_WM5102=m
 	default m if SND_SOC_WM5110=m
@@ -816,6 +819,12 @@ config SND_SOC_CS47L92
 	tristate
 	depends on MFD_CS47L92
 
+config SND_SOC_CS48L32
+	tristate "Cirrus Logic CS48L32 CODEC"
+	depends on MFD_CS48L32
+	help
+		Enable support for the Cirrus Logic CS48L32 codec.
+
 # Cirrus Logic Quad-Channel ADC
 config SND_SOC_CS53L30
 	tristate "Cirrus Logic CS53L30 CODEC"
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9170ee1447dd..2c59463d1085 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -89,6 +89,7 @@ snd-soc-cs47l35-objs := cs47l35.o
 snd-soc-cs47l85-objs := cs47l85.o
 snd-soc-cs47l90-objs := cs47l90.o
 snd-soc-cs47l92-objs := cs47l92.o
+snd-soc-cs48l32-objs := cs48l32.o cs48l32-core.o
 snd-soc-cs53l30-objs := cs53l30.o
 snd-soc-cx20442-objs := cx20442.o
 snd-soc-cx2072x-objs := cx2072x.o
@@ -449,6 +450,7 @@ obj-$(CONFIG_SND_SOC_CS47L35)	+= snd-soc-cs47l35.o
 obj-$(CONFIG_SND_SOC_CS47L85)	+= snd-soc-cs47l85.o
 obj-$(CONFIG_SND_SOC_CS47L90)	+= snd-soc-cs47l90.o
 obj-$(CONFIG_SND_SOC_CS47L92)	+= snd-soc-cs47l92.o
+obj-$(CONFIG_SND_SOC_CS48L32)	+= snd-soc-cs48l32.o
 obj-$(CONFIG_SND_SOC_CS53L30)	+= snd-soc-cs53l30.o
 obj-$(CONFIG_SND_SOC_CX20442)	+= snd-soc-cx20442.o
 obj-$(CONFIG_SND_SOC_CX2072X)	+= snd-soc-cx2072x.o
diff --git a/sound/soc/codecs/cs48l32-core.c b/sound/soc/codecs/cs48l32-core.c
new file mode 100644
index 000000000000..8daebbb0ea50
--- /dev/null
+++ b/sound/soc/codecs/cs48l32-core.c
@@ -0,0 +1,2782 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Cirrus Logic CS48L32 codec core support
+//
+// Copyright (C) 2016-2018, 2020, 2022 Cirrus Logic, Inc. and
+//               Cirrus Logic International Semiconductor Ltd.
+//
+
+#include <dt-bindings/sound/cs48l32.h>
+#include <linux/delay.h>
+#include <linux/gcd.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/tlv.h>
+
+#include "cs48l32.h"
+
+#define CS48L32_ASP_ENABLES1			0x00
+#define CS48L32_ASP_CONTROL1			0x04
+#define CS48L32_ASP_CONTROL2			0x08
+#define CS48L32_ASP_CONTROL3			0x0c
+#define CS48L32_ASP_FRAME_CONTROL1		0x10
+#define CS48L32_ASP_FRAME_CONTROL2		0x14
+#define CS48L32_ASP_FRAME_CONTROL5		0x20
+#define CS48L32_ASP_FRAME_CONTROL6		0x24
+#define CS48L32_ASP_DATA_CONTROL1		0x30
+#define CS48L32_ASP_DATA_CONTROL5		0x40
+
+#define CS48L32_SYSCLK_RATE_6MHZ		0
+#define CS48L32_SYSCLK_RATE_12MHZ		1
+#define CS48L32_SYSCLK_RATE_24MHZ		2
+#define CS48L32_SYSCLK_RATE_49MHZ		3
+#define CS48L32_SYSCLK_RATE_98MHZ		4
+
+#define CS48L32_FLLHJ_INT_MAX_N			1023
+#define CS48L32_FLLHJ_INT_MIN_N			1
+#define CS48L32_FLLHJ_FRAC_MAX_N		255
+#define CS48L32_FLLHJ_FRAC_MIN_N		2
+#define CS48L32_FLLHJ_LP_INT_MODE_THRESH	100000
+#define CS48L32_FLLHJ_LOW_THRESH		192000
+#define CS48L32_FLLHJ_MID_THRESH		1152000
+#define CS48L32_FLLHJ_MAX_THRESH		13000000
+#define CS48L32_FLLHJ_LOW_GAINS			0x23f0
+#define CS48L32_FLLHJ_MID_GAINS			0x22f2
+#define CS48L32_FLLHJ_HIGH_GAINS		0x21f0
+#define CS48L32_FLL_MAX_FOUT			50000000
+#define CS48L32_FLL_MAX_REFDIV			8
+
+#define CS48L32_FLL_CONTROL1_OFFS		0x00
+#define CS48L32_FLL_CONTROL2_OFFS		0x04
+#define CS48L32_FLL_CONTROL3_OFFS		0x08
+#define CS48L32_FLL_CONTROL4_OFFS		0x0c
+#define CS48L32_FLL_CONTROL5_OFFS		0x10
+#define CS48L32_FLL_CONTROL6_OFFS		0x14
+#define CS48L32_FLL_DIGITAL_TEST2_OFFS		0x34
+#define CS48L32_FLL_GPIO_CLOCK_OFFS		0xa0
+
+#define CS48L32_DSP_CLOCK_FREQ_OFFS		0x00000
+
+#define CS48L32_ASP_FMT_DSP_MODE_A		0
+#define CS48L32_ASP_FMT_DSP_MODE_B		1
+#define CS48L32_ASP_FMT_I2S_MODE		2
+#define CS48L32_ASP_FMT_LEFT_JUSTIFIED_MODE	3
+
+#define CS48L32_HALO_SAMPLE_RATE_RX1		0x00080
+#define CS48L32_HALO_SAMPLE_RATE_TX1		0x00280
+#define CS48L32_HALO_DSP_RATE_MASK		0x1f
+
+#define cs48l32_fll_err(_fll, fmt, ...) \
+	dev_err(_fll->cs48l32->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+#define cs48l32_fll_warn(_fll, fmt, ...) \
+	dev_warn(_fll->cs48l32->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+#define cs48l32_fll_dbg(_fll, fmt, ...) \
+	dev_dbg(_fll->cs48l32->dev, "FLL%d: " fmt, _fll->id, ##__VA_ARGS__)
+
+#define cs48l32_asp_err(_dai, fmt, ...) \
+	dev_err(_dai->component->dev, "ASP%d: " fmt, _dai->id, ##__VA_ARGS__)
+#define cs48l32_asp_warn(_dai, fmt, ...) \
+	dev_warn(_dai->component->dev, "ASP%d: " fmt, _dai->id, ##__VA_ARGS__)
+#define cs48l32_asp_dbg(_dai, fmt, ...) \
+	dev_dbg(_dai->component->dev, "ASP%d: " fmt, _dai->id, ##__VA_ARGS__)
+
+const char * const cs48l32_mixer_texts[] = {
+	"None",
+	"Tone Generator 1",
+	"Tone Generator 2",
+	"Noise Generator",
+	"IN1L",
+	"IN1R",
+	"IN2L",
+	"IN2R",
+	"ASP1RX1",
+	"ASP1RX2",
+	"ASP1RX3",
+	"ASP1RX4",
+	"ASP1RX5",
+	"ASP1RX6",
+	"ASP1RX7",
+	"ASP1RX8",
+	"ASP2RX1",
+	"ASP2RX2",
+	"ASP2RX3",
+	"ASP2RX4",
+	"ISRC1INT1",
+	"ISRC1INT2",
+	"ISRC1INT3",
+	"ISRC1INT4",
+	"ISRC1DEC1",
+	"ISRC1DEC2",
+	"ISRC1DEC3",
+	"ISRC1DEC4",
+	"ISRC2INT1",
+	"ISRC2INT2",
+	"ISRC2DEC1",
+	"ISRC2DEC2",
+	"ISRC3INT1",
+	"ISRC3INT2",
+	"ISRC3DEC1",
+	"ISRC3DEC2",
+	"EQ1",
+	"EQ2",
+	"EQ3",
+	"EQ4",
+	"DRC1L",
+	"DRC1R",
+	"DRC2L",
+	"DRC2R",
+	"LHPF1",
+	"LHPF2",
+	"LHPF3",
+	"LHPF4",
+	"Ultrasonic 1",
+	"Ultrasonic 2",
+	"DSP1.1",
+	"DSP1.2",
+	"DSP1.3",
+	"DSP1.4",
+	"DSP1.5",
+	"DSP1.6",
+	"DSP1.7",
+	"DSP1.8",
+};
+
+unsigned int cs48l32_mixer_values[] = {
+	0x000, /* Silence (mute) */
+	0x004, /* Tone generator 1 */
+	0x005, /* Tone generator 2 */
+	0x00C, /* Noise Generator */
+	0x010, /* IN1L signal path */
+	0x011, /* IN1R signal path */
+	0x012, /* IN2L signal path */
+	0x013, /* IN2R signal path */
+	0x020, /* ASP1 RX1 */
+	0x021, /* ASP1 RX2 */
+	0x022, /* ASP1 RX3 */
+	0x023, /* ASP1 RX4 */
+	0x024, /* ASP1 RX5 */
+	0x025, /* ASP1 RX6 */
+	0x026, /* ASP1 RX7 */
+	0x027, /* ASP1 RX8 */
+	0x030, /* ASP2 RX1 */
+	0x031, /* ASP2 RX2 */
+	0x032, /* ASP2 RX3 */
+	0x033, /* ASP2 RX4 */
+	0x098, /* ISRC1 INT1 */
+	0x099, /* ISRC1 INT2 */
+	0x09a, /* ISRC1 INT3 */
+	0x09b, /* ISRC1 INT4 */
+	0x09C, /* ISRC1 DEC1 */
+	0x09D, /* ISRC1 DEC2 */
+	0x09e, /* ISRC1 DEC3 */
+	0x09f, /* ISRC1 DEC4 */
+	0x0A0, /* ISRC2 INT1 */
+	0x0A1, /* ISRC2 INT2 */
+	0x0A4, /* ISRC2 DEC1 */
+	0x0A5, /* ISRC2 DEC2 */
+	0x0A8, /* ISRC3 INT1 */
+	0x0A9, /* ISRC3 INT2 */
+	0x0AC, /* ISRC3 DEC1 */
+	0x0AD, /* ISRC3 DEC2 */
+	0x0B8, /* EQ1 */
+	0x0B9, /* EQ2 */
+	0x0BA, /* EQ3 */
+	0x0BB, /* EQ4 */
+	0x0C0, /* DRC1 Left */
+	0x0C1, /* DRC1 Right */
+	0x0C2, /* DRC2 Left */
+	0x0C3, /* DRC2 Right */
+	0x0C8, /* LHPF1 */
+	0x0C9, /* LHPF2 */
+	0x0CA, /* LHPF3 */
+	0x0CB, /* LHPF4 */
+	0x0D8, /* Ultrasonic 1 */
+	0x0D9, /* Ultrasonic 2 */
+	0x100, /* DSP1 channel 1 */
+	0x101, /* DSP1 channel 2 */
+	0x102, /* DSP1 channel 3 */
+	0x103, /* DSP1 channel 4 */
+	0x104, /* DSP1 channel 5 */
+	0x105, /* DSP1 channel 6 */
+	0x106, /* DSP1 channel 7 */
+	0x107, /* DSP1 channel 8 */
+};
+
+const DECLARE_TLV_DB_SCALE(cs48l32_ana_tlv, 0, 100, 0);
+const DECLARE_TLV_DB_SCALE(cs48l32_eq_tlv, -1200, 100, 0);
+const DECLARE_TLV_DB_SCALE(cs48l32_digital_tlv, -6400, 50, 0);
+const DECLARE_TLV_DB_SCALE(cs48l32_noise_tlv, -10800, 600, 0);
+const DECLARE_TLV_DB_SCALE(cs48l32_mixer_tlv, -3200, 100, 0);
+const DECLARE_TLV_DB_SCALE(cs48l32_us_tlv, 0, 600, 0);
+
+static void cs48l32_spin_sysclk(struct cs48l32 *cs48l32)
+{
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int val;
+	int ret, i;
+
+	/* Skip this if the chip is down */
+	if (pm_runtime_suspended(mfd->dev))
+		return;
+
+	/*
+	 * Just read a register a few times to ensure the internal
+	 * oscillator sends out a some clocks.
+	 */
+	for (i = 0; i < 4; i++) {
+		ret = regmap_read(mfd->regmap, CS48L32_DEVID, &val);
+		if (ret)
+			dev_err(cs48l32->dev, "%s Failed to read register: %d (%d)\n",
+				__func__, ret, i);
+	}
+
+	udelay(300);
+}
+
+static const char * const cs48l32_rate_text[] = {
+	"Sample Rate 1",
+	"Sample Rate 2",
+	"Sample Rate 3",
+	"Sample Rate 4",
+};
+
+static const unsigned int cs48l32_rate_val[] = {
+	0x0, 0x1, 0x2, 0x3,
+};
+
+int cs48l32_rate_put(struct snd_kcontrol *kcontrol,
+		     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	/* Prevent any mixer mux changes while we do this */
+	mutex_lock(&cs48l32->rate_lock);
+
+	/* The write must be guarded by a number of SYSCLK cycles */
+	cs48l32_spin_sysclk(cs48l32);
+	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+	cs48l32_spin_sysclk(cs48l32);
+
+	mutex_unlock(&cs48l32->rate_lock);
+
+	return ret;
+}
+
+static const char * const cs48l32_sample_rate_text[] = {
+	"12kHz",
+	"24kHz",
+	"48kHz",
+	"96kHz",
+	"192kHz",
+	"384kHz",
+	"768kHz",
+	"11.025kHz",
+	"22.05kHz",
+	"44.1kHz",
+	"88.2kHz",
+	"176.4kHz",
+	"352.8kHz",
+	"705.6kHz",
+	"8kHz",
+	"16kHz",
+	"32kHz",
+};
+
+static const unsigned int cs48l32_sample_rate_val[] = {
+	0x01, /* 12kHz */
+	0x02, /* 24kHz */
+	0x03, /* 48kHz */
+	0x04, /* 96kHz */
+	0x05, /* 192kHz */
+	0x06, /* 384kHz */
+	0x07, /* 768kHz */
+	0x09, /* 11.025kHz */
+	0x0a, /* 22.05kHz */
+	0x0b, /* 44.1kHz */
+	0x0c, /* 88.2kHz */
+	0x0d, /* 176.4kHz */
+	0x0e, /* 352.8kHz */
+	0x0f, /* 705.6kHz */
+	0x11, /* 8kHz */
+	0x12, /* 16kHz */
+	0x13, /* 32kHz */
+};
+
+const struct soc_enum cs48l32_sample_rate[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_SAMPLE_RATE1,
+			      CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_1_MASK >> CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_ENUM_SIZE,
+			      cs48l32_sample_rate_text,
+			      cs48l32_sample_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_SAMPLE_RATE2,
+			      CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_1_MASK >> CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_ENUM_SIZE,
+			      cs48l32_sample_rate_text,
+			      cs48l32_sample_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_SAMPLE_RATE3,
+			      CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_1_MASK >> CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_ENUM_SIZE,
+			      cs48l32_sample_rate_text,
+			      cs48l32_sample_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_SAMPLE_RATE4,
+			      CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_1_MASK >> CS48L32_SAMPLE_RATE_1_SHIFT,
+			      CS48L32_SAMPLE_RATE_ENUM_SIZE,
+			      cs48l32_sample_rate_text,
+			      cs48l32_sample_rate_val),
+};
+
+static int cs48l32_inmux_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_dapm_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	unsigned int mux, src_val, in_type;
+	int ret;
+
+	mux = ucontrol->value.enumerated.item[0];
+	if (mux > 1)
+		return -EINVAL;
+
+	switch (e->reg) {
+	case CS48L32_IN1L_CONTROL1:
+		in_type = cs48l32->in_type[0][2 * mux];
+		break;
+	case CS48L32_IN1R_CONTROL1:
+		in_type = cs48l32->in_type[0][1 + (2 * mux)];
+		break;
+	case CS48L32_IN2L_CONTROL1:
+		in_type = cs48l32->in_type[1][2 * mux];
+		break;
+	case CS48L32_IN2R_CONTROL1:
+		in_type = cs48l32->in_type[1][1 + (2 * mux)];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	src_val = mux << e->shift_l;
+
+	if (in_type == CS48L32_IN_TYPE_SE)
+		src_val |= 1 << CS48L32_INx_SRC_SHIFT;
+
+	dev_dbg(cs48l32->dev, "mux=%u reg=0x%x in_type=0x%x val=0x%x\n",
+		mux, e->reg, in_type, src_val);
+
+	ret = snd_soc_component_update_bits(dapm->component,
+					    e->reg,
+					    CS48L32_INx_SRC_MASK,
+					    src_val);
+	if (ret > 0)
+		snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
+
+	return ret;
+}
+
+static const char * const cs48l32_inmux_texts[] = {
+	"Analog 1", "Analog 2",
+};
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_in1muxl_enum,
+			    CS48L32_IN1L_CONTROL1,
+			    CS48L32_INx_SRC_SHIFT + 1,
+			    cs48l32_inmux_texts);
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_in1muxr_enum,
+			    CS48L32_IN1R_CONTROL1,
+			    CS48L32_INx_SRC_SHIFT + 1,
+			    cs48l32_inmux_texts);
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_in2muxl_enum,
+			    CS48L32_IN2L_CONTROL1,
+			    CS48L32_INx_SRC_SHIFT + 1,
+			    cs48l32_inmux_texts);
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_in2muxr_enum,
+			    CS48L32_IN2R_CONTROL1,
+			    CS48L32_INx_SRC_SHIFT + 1,
+			    cs48l32_inmux_texts);
+
+const struct snd_kcontrol_new cs48l32_inmux[] = {
+	SOC_DAPM_ENUM_EXT("IN1L Mux", cs48l32_in1muxl_enum,
+			  snd_soc_dapm_get_enum_double, cs48l32_inmux_put),
+	SOC_DAPM_ENUM_EXT("IN1R Mux", cs48l32_in1muxr_enum,
+			  snd_soc_dapm_get_enum_double, cs48l32_inmux_put),
+	SOC_DAPM_ENUM_EXT("IN2L Mux", cs48l32_in2muxl_enum,
+			  snd_soc_dapm_get_enum_double, cs48l32_inmux_put),
+	SOC_DAPM_ENUM_EXT("IN2R Mux", cs48l32_in2muxr_enum,
+			  snd_soc_dapm_get_enum_double, cs48l32_inmux_put),
+};
+
+static const char * const cs48l32_dmode_texts[] = {
+	"Analog", "Digital",
+};
+
+static int cs48l32_dmode_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	unsigned int mode;
+	int ret, result;
+
+	mode = ucontrol->value.enumerated.item[0];
+	switch (mode) {
+	case 0:
+		ret = snd_soc_component_update_bits(component,
+						    CS48L32_ADC1L_ANA_CONTROL1,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to set ADC1L_INT_ENA_FRC: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_component_update_bits(component,
+						    CS48L32_ADC1R_ANA_CONTROL1,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to set ADC1R_INT_ENA_FRC: %d\n", ret);
+			return ret;
+		}
+
+		result = snd_soc_component_update_bits(component,
+						       e->reg,
+						       BIT(CS48L32_IN1_MODE_SHIFT),
+						       0);
+		if (result < 0) {
+			dev_err(component->dev, "Failed to set input mode: %d\n", result);
+			return result;
+		}
+
+		usleep_range(200, 300);
+
+		ret = snd_soc_component_update_bits(component,
+						    CS48L32_ADC1L_ANA_CONTROL1,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						    0);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to clear ADC1L_INT_ENA_FRC: %d\n", ret);
+			return ret;
+		}
+
+		ret = snd_soc_component_update_bits(component,
+						    CS48L32_ADC1R_ANA_CONTROL1,
+						    CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						    0);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to clear ADC1R_INT_ENA_FRC: %d\n", ret);
+			return ret;
+		}
+
+		if (result > 0)
+			snd_soc_dapm_mux_update_power(dapm, kcontrol, mode, e, NULL);
+
+		return result;
+	case 1:
+		return snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
+	default:
+		return -EINVAL;
+	}
+}
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_in1dmode_enum,
+			    CS48L32_INPUT1_CONTROL1,
+			    CS48L32_IN1_MODE_SHIFT,
+			    cs48l32_dmode_texts);
+
+const struct snd_kcontrol_new cs48l32_dmode_mux[] = {
+	SOC_DAPM_ENUM_EXT("IN1 Mode", cs48l32_in1dmode_enum,
+			  snd_soc_dapm_get_enum_double, cs48l32_dmode_put),
+};
+
+static const char * const cs48l32_in_texts[] = {
+	"IN1L", "IN1R", "IN2L", "IN2R",
+};
+
+static const char * const cs48l32_us_freq_texts[] = {
+	"24.5-40.5kHz", "18-22kHz", "16-24kHz", "20-28kHz",
+};
+
+static const unsigned int cs48l32_us_freq_val[] = {
+	0x2, 0x3,
+};
+
+const struct soc_enum cs48l32_us_freq[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US1_CONTROL,
+			      CS48L32_US1_FREQ_SHIFT,
+			      CS48L32_US1_FREQ_MASK >> CS48L32_US1_FREQ_SHIFT,
+			      ARRAY_SIZE(cs48l32_us_freq_val),
+			      &cs48l32_us_freq_texts[2],
+			      cs48l32_us_freq_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US2_CONTROL,
+			      CS48L32_US1_FREQ_SHIFT,
+			      CS48L32_US1_FREQ_MASK >> CS48L32_US1_FREQ_SHIFT,
+			      ARRAY_SIZE(cs48l32_us_freq_val),
+			      &cs48l32_us_freq_texts[2],
+			      cs48l32_us_freq_val),
+};
+
+static const unsigned int cs48l32_us_in_val[] = {
+	0x0, 0x1, 0x2, 0x3,
+};
+
+static const struct soc_enum cs48l32_us_inmux_enum[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US1_CONTROL,
+			      CS48L32_US1_SRC_SHIFT,
+			      CS48L32_US1_SRC_MASK >> CS48L32_US1_SRC_SHIFT,
+			      ARRAY_SIZE(cs48l32_us_in_val),
+			      cs48l32_in_texts,
+			      cs48l32_us_in_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US2_CONTROL,
+			      CS48L32_US1_SRC_SHIFT,
+			      CS48L32_US1_SRC_MASK >> CS48L32_US1_SRC_SHIFT,
+			      ARRAY_SIZE(cs48l32_us_in_val),
+			      cs48l32_in_texts,
+			      cs48l32_us_in_val),
+};
+
+const struct snd_kcontrol_new cs48l32_us_inmux[] = {
+	SOC_DAPM_ENUM("Ultrasonic 1 Input", cs48l32_us_inmux_enum[0]),
+	SOC_DAPM_ENUM("Ultrasonic 2 Input", cs48l32_us_inmux_enum[1]),
+};
+
+static const char * const cs48l32_us_det_thr_texts[] = {
+	"-6dB", "-9dB", "-12dB", "-15dB", "-18dB", "-21dB", "-24dB", "-27dB",
+};
+
+const struct soc_enum cs48l32_us_det_thr[] = {
+	SOC_ENUM_SINGLE(CS48L32_US1_DET_CONTROL,
+			CS48L32_US1_DET_THR_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_thr_texts),
+			cs48l32_us_det_thr_texts),
+	SOC_ENUM_SINGLE(CS48L32_US2_DET_CONTROL,
+			CS48L32_US1_DET_THR_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_thr_texts),
+			cs48l32_us_det_thr_texts),
+};
+
+static const char * const cs48l32_us_det_num_texts[] = {
+	"1 Sample",
+	"2 Samples",
+	"4 Samples",
+	"8 Samples",
+	"16 Samples",
+	"32 Samples",
+	"64 Samples",
+	"128 Samples",
+	"256 Samples",
+	"512 Samples",
+	"1024 Samples",
+	"2048 Samples",
+	"4096 Samples",
+	"8192 Samples",
+	"16384 Samples",
+	"32768 Samples",
+};
+
+const struct soc_enum cs48l32_us_det_num[] = {
+	SOC_ENUM_SINGLE(CS48L32_US1_DET_CONTROL,
+			CS48L32_US1_DET_NUM_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_num_texts),
+			cs48l32_us_det_num_texts),
+	SOC_ENUM_SINGLE(CS48L32_US2_DET_CONTROL,
+			CS48L32_US1_DET_NUM_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_num_texts),
+			cs48l32_us_det_num_texts),
+};
+
+static const char * const cs48l32_us_det_hold_texts[] = {
+	"0 Samples",
+	"31 Samples",
+	"63 Samples",
+	"127 Samples",
+	"255 Samples",
+	"511 Samples",
+	"1023 Samples",
+	"2047 Samples",
+	"4095 Samples",
+	"8191 Samples",
+	"16383 Samples",
+	"32767 Samples",
+	"65535 Samples",
+	"131071 Samples",
+	"262143 Samples",
+	"524287 Samples",
+};
+
+const struct soc_enum cs48l32_us_det_hold[] = {
+	SOC_ENUM_SINGLE(CS48L32_US1_DET_CONTROL,
+			CS48L32_US1_DET_HOLD_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_hold_texts),
+			cs48l32_us_det_hold_texts),
+	SOC_ENUM_SINGLE(CS48L32_US2_DET_CONTROL,
+			CS48L32_US1_DET_HOLD_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_hold_texts),
+			cs48l32_us_det_hold_texts),
+};
+
+const struct soc_enum cs48l32_us_output_rate[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US1_CONTROL,
+			      CS48L32_US1_RATE_SHIFT,
+			      CS48L32_US1_RATE_MASK >> CS48L32_US1_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_US2_CONTROL,
+			      CS48L32_US1_RATE_SHIFT,
+			      CS48L32_US1_RATE_MASK >> CS48L32_US1_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+};
+
+static const char * const cs48l32_us_det_lpf_cut_texts[] = {
+	"1722Hz", "833Hz", "408Hz", "203Hz",
+};
+
+const struct soc_enum cs48l32_us_det_lpf_cut[] = {
+	SOC_ENUM_SINGLE(CS48L32_US1_DET_CONTROL,
+			CS48L32_US1_DET_LPF_CUT_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_lpf_cut_texts),
+			cs48l32_us_det_lpf_cut_texts),
+	SOC_ENUM_SINGLE(CS48L32_US2_DET_CONTROL,
+			CS48L32_US1_DET_LPF_CUT_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_lpf_cut_texts),
+			cs48l32_us_det_lpf_cut_texts),
+};
+
+static const char * const cs48l32_us_det_dcy_texts[] = {
+	"0 ms", "0.79 ms", "1.58 ms", "3.16 ms", "6.33 ms", "12.67 ms",
+	"25.34 ms", "50.69 ms",
+};
+
+const struct soc_enum cs48l32_us_det_dcy[] = {
+	SOC_ENUM_SINGLE(CS48L32_US1_DET_CONTROL,
+			CS48L32_US1_DET_DCY_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_dcy_texts),
+			cs48l32_us_det_dcy_texts),
+	SOC_ENUM_SINGLE(CS48L32_US2_DET_CONTROL,
+			CS48L32_US1_DET_DCY_SHIFT,
+			ARRAY_SIZE(cs48l32_us_det_dcy_texts),
+			cs48l32_us_det_dcy_texts),
+};
+
+const struct snd_kcontrol_new cs48l32_us_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+};
+
+static const char * const cs48l32_vol_ramp_text[] = {
+	"0ms/6dB", "0.5ms/6dB", "1ms/6dB", "2ms/6dB", "4ms/6dB", "8ms/6dB",
+	"16ms/6dB", "32ms/6dB",
+};
+
+irqreturn_t cs48l32_us1_activity(int irq, void *data)
+{
+	struct cs48l32 *cs48l32 = data;
+	struct cs48l32_us_notify_data us_data;
+
+	us_data.us_no = 1;
+	cs48l32_call_notifiers(cs48l32->mfd, CS48L32_NOTIFY_ULTRASONIC, &us_data);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t cs48l32_us2_activity(int irq, void *data)
+{
+	struct cs48l32 *cs48l32 = data;
+	struct cs48l32_us_notify_data us_data;
+
+	us_data.us_no = 2;
+	cs48l32_call_notifiers(cs48l32->mfd, CS48L32_NOTIFY_ULTRASONIC, &us_data);
+
+	return IRQ_HANDLED;
+}
+
+SOC_ENUM_SINGLE_DECL(cs48l32_in_vd_ramp,
+		     CS48L32_INPUT_VOL_CONTROL,
+		     CS48L32_IN_VD_RAMP_SHIFT,
+		     cs48l32_vol_ramp_text);
+
+SOC_ENUM_SINGLE_DECL(cs48l32_in_vi_ramp,
+		     CS48L32_INPUT_VOL_CONTROL,
+		     CS48L32_IN_VI_RAMP_SHIFT,
+		     cs48l32_vol_ramp_text);
+
+static const char * const cs48l32_in_hpf_cut_text[] = {
+	"2.5Hz", "5Hz", "10Hz", "20Hz", "40Hz"
+};
+
+SOC_ENUM_SINGLE_DECL(cs48l32_in_hpf_cut_enum,
+		     CS48L32_INPUT_HPF_CONTROL,
+		     CS48L32_IN_HPF_CUT_SHIFT,
+		     cs48l32_in_hpf_cut_text);
+
+static const char * const cs48l32_in_dmic_osr_text[] = {
+	"384kHz", "768kHz", "1.536MHz", "2.048MHz", "2.4576MHz", "3.072MHz",
+	"6.144MHz",
+};
+
+const struct soc_enum cs48l32_in_dmic_osr[] = {
+	SOC_ENUM_SINGLE(CS48L32_INPUT1_CONTROL1,
+			CS48L32_IN1_OSR_SHIFT,
+			ARRAY_SIZE(cs48l32_in_dmic_osr_text),
+			cs48l32_in_dmic_osr_text),
+	SOC_ENUM_SINGLE(CS48L32_INPUT2_CONTROL1,
+			CS48L32_IN1_OSR_SHIFT,
+			ARRAY_SIZE(cs48l32_in_dmic_osr_text),
+			cs48l32_in_dmic_osr_text),
+};
+
+int cs48l32_in_rate_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int reg, shift;
+	int ret = 0;
+
+	snd_soc_dapm_mutex_lock(dapm);
+
+	/* Cannot change rate on an active input */
+	reg = snd_soc_component_read(component, CS48L32_INPUT_CONTROL);
+	shift = (e->reg - CS48L32_IN1L_CONTROL1) / 0x20;
+	shift ^= 0x1; /* Flip bottom bit for channel order */
+
+	if ((reg) & (1 << shift)) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+exit:
+	snd_soc_dapm_mutex_unlock(dapm);
+	return ret;
+}
+
+const struct soc_enum cs48l32_input_rate[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_IN1L_CONTROL1,
+			      CS48L32_INx_RATE_SHIFT,
+			      CS48L32_INx_RATE_MASK >> CS48L32_INx_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_IN1R_CONTROL1,
+			      CS48L32_INx_RATE_SHIFT,
+			      CS48L32_INx_RATE_MASK >> CS48L32_INx_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_IN2L_CONTROL1,
+			      CS48L32_INx_RATE_SHIFT,
+			      CS48L32_INx_RATE_MASK >> CS48L32_INx_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_IN2R_CONTROL1,
+			      CS48L32_INx_RATE_SHIFT,
+			      CS48L32_INx_RATE_MASK >> CS48L32_INx_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+};
+
+int cs48l32_low_power_mode_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	unsigned int reg, mask;
+	int ret;
+
+	snd_soc_dapm_mutex_lock(dapm);
+
+	/* Cannot change low power mode on an active input */
+	reg = snd_soc_component_read(component, CS48L32_INPUT_CONTROL);
+	mask = (mc->reg - CS48L32_IN1L_CONTROL1) / 0x20;
+	mask ^= 0x1; /* Flip bottom bit for channel order */
+
+	if ((reg) & (1 << mask)) {
+		ret = -EBUSY;
+		dev_err(component->dev, "Can't change lp mode on an active input\n");
+		goto exit;
+	}
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+
+exit:
+	snd_soc_dapm_mutex_unlock(dapm);
+	return ret;
+}
+
+const struct soc_enum noise_gen_rate =
+	SOC_VALUE_ENUM_SINGLE(CS48L32_COMFORT_NOISE_GENERATOR,
+			      CS48L32_NOISE_GEN_RATE_SHIFT,
+			      CS48L32_NOISE_GEN_RATE_MASK >> CS48L32_NOISE_GEN_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val);
+
+static const char * const cs48l32_auxpdm_freq_texts[] = {
+	"3.072MHz", "2.048MHz", "1.536MHz", "768kHz",
+};
+
+SOC_ENUM_SINGLE_DECL(cs48l32_auxpdm1_freq,
+		     CS48L32_AUXPDM1_CONTROL1,
+		     CS48L32_AUXPDM1_FREQ_SHIFT,
+		     cs48l32_auxpdm_freq_texts);
+
+SOC_ENUM_SINGLE_DECL(cs48l32_auxpdm2_freq,
+		     CS48L32_AUXPDM2_CONTROL1,
+		     CS48L32_AUXPDM1_FREQ_SHIFT,
+		     cs48l32_auxpdm_freq_texts);
+
+static const char * const cs48l32_auxpdm_src_texts[] = {
+	"Analog", "IN1 Digital", "IN2 Digital",
+};
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_auxpdm1_in,
+			    CS48L32_AUXPDM_CTRL2,
+			    CS48L32_AUXPDMDAT1_SRC_SHIFT,
+			    cs48l32_auxpdm_src_texts);
+
+static SOC_ENUM_SINGLE_DECL(cs48l32_auxpdm2_in,
+			    CS48L32_AUXPDM_CTRL2,
+			    CS48L32_AUXPDMDAT2_SRC_SHIFT,
+			    cs48l32_auxpdm_src_texts);
+
+const struct snd_kcontrol_new cs48l32_auxpdm_inmux[] = {
+	SOC_DAPM_ENUM("AUXPDM1 Input", cs48l32_auxpdm1_in),
+	SOC_DAPM_ENUM("AUXPDM2 Input", cs48l32_auxpdm2_in),
+};
+
+static const unsigned int cs48l32_auxpdm_analog_in_val[] = {
+	0x0, 0x1,
+};
+
+static const struct soc_enum cs48l32_auxpdm_analog_inmux_enum[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_AUXPDM1_CONTROL1,
+			      CS48L32_AUXPDM1_SRC_SHIFT,
+			      CS48L32_AUXPDM1_SRC_MASK >> CS48L32_AUXPDM1_SRC_SHIFT,
+			      ARRAY_SIZE(cs48l32_auxpdm_analog_in_val),
+			      cs48l32_in_texts,
+			      cs48l32_auxpdm_analog_in_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_AUXPDM2_CONTROL1,
+			      CS48L32_AUXPDM1_SRC_SHIFT,
+			      CS48L32_AUXPDM1_SRC_MASK >> CS48L32_AUXPDM1_SRC_SHIFT,
+			      ARRAY_SIZE(cs48l32_auxpdm_analog_in_val),
+			      cs48l32_in_texts,
+			      cs48l32_auxpdm_analog_in_val),
+};
+
+const struct snd_kcontrol_new cs48l32_auxpdm_analog_inmux[] = {
+	SOC_DAPM_ENUM("AUXPDM1 Analog Input", cs48l32_auxpdm_analog_inmux_enum[0]),
+	SOC_DAPM_ENUM("AUXPDM2 Analog Input", cs48l32_auxpdm_analog_inmux_enum[1]),
+};
+
+const struct snd_kcontrol_new cs48l32_auxpdm_switch[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+};
+
+const struct soc_enum cs48l32_isrc_fsh[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC1_CONTROL1,
+			      CS48L32_ISRC1_FSH_SHIFT,
+			      CS48L32_ISRC1_FSH_MASK >> CS48L32_ISRC1_FSH_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC2_CONTROL1,
+			      CS48L32_ISRC1_FSH_SHIFT,
+			      CS48L32_ISRC1_FSH_MASK >> CS48L32_ISRC1_FSH_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC3_CONTROL1,
+			      CS48L32_ISRC1_FSH_SHIFT,
+			      CS48L32_ISRC1_FSH_MASK >> CS48L32_ISRC1_FSH_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+};
+
+const struct soc_enum cs48l32_isrc_fsl[] = {
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC1_CONTROL1,
+			      CS48L32_ISRC1_FSL_SHIFT,
+			      CS48L32_ISRC1_FSL_MASK >> CS48L32_ISRC1_FSL_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC2_CONTROL1,
+			      CS48L32_ISRC1_FSL_SHIFT,
+			      CS48L32_ISRC1_FSL_MASK >> CS48L32_ISRC1_FSL_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(CS48L32_ISRC3_CONTROL1,
+			      CS48L32_ISRC1_FSL_SHIFT,
+			      CS48L32_ISRC1_FSL_MASK >> CS48L32_ISRC1_FSL_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val),
+};
+
+const struct soc_enum cs48l32_fx_rate =
+	SOC_VALUE_ENUM_SINGLE(CS48L32_FX_SAMPLE_RATE,
+			      CS48L32_FX_RATE_SHIFT,
+			      CS48L32_FX_RATE_MASK >> CS48L32_FX_RATE_SHIFT,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,
+			      cs48l32_rate_val);
+
+static const char * const cs48l32_lhpf_mode_text[] = {
+	"Low-pass", "High-pass"
+};
+
+const struct soc_enum cs48l32_lhpf_mode[] = {
+	SOC_ENUM_SINGLE(CS48L32_LHPF_CONTROL2, 0,
+			ARRAY_SIZE(cs48l32_lhpf_mode_text), cs48l32_lhpf_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_LHPF_CONTROL2, 1,
+			ARRAY_SIZE(cs48l32_lhpf_mode_text), cs48l32_lhpf_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_LHPF_CONTROL2, 2,
+			ARRAY_SIZE(cs48l32_lhpf_mode_text), cs48l32_lhpf_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_LHPF_CONTROL2, 3,
+			ARRAY_SIZE(cs48l32_lhpf_mode_text), cs48l32_lhpf_mode_text),
+};
+
+int cs48l32_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	__be32 *data = (__be32 *)ucontrol->value.bytes.data;
+	s16 val = (s16)be32_to_cpu(*data);
+
+	if (abs(val) >= 4096) {
+		dev_err(cs48l32->dev, "Rejecting unstable LHPF coefficients\n");
+		return -EINVAL;
+	}
+
+	return snd_soc_bytes_put(kcontrol, ucontrol);
+}
+
+static const char * const cs48l32_eq_mode_text[] = {
+	"Low-pass", "High-pass",
+};
+
+const struct soc_enum cs48l32_eq_mode[] = {
+	SOC_ENUM_SINGLE(CS48L32_EQ_CONTROL2, 0,
+			ARRAY_SIZE(cs48l32_eq_mode_text),
+			cs48l32_eq_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_EQ_CONTROL2, 1,
+			ARRAY_SIZE(cs48l32_eq_mode_text),
+			cs48l32_eq_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_EQ_CONTROL2, 2,
+			ARRAY_SIZE(cs48l32_eq_mode_text),
+			cs48l32_eq_mode_text),
+	SOC_ENUM_SINGLE(CS48L32_EQ_CONTROL2, 3,
+			ARRAY_SIZE(cs48l32_eq_mode_text),
+			cs48l32_eq_mode_text),
+};
+
+int cs48l32_eq_mode_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	unsigned int item;
+
+	item = snd_soc_enum_val_to_item(e, cs48l32->eq_mode[e->shift_l]);
+	ucontrol->value.enumerated.item[0] = item;
+
+	return 0;
+}
+
+int cs48l32_eq_mode_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	unsigned int val;
+	bool changed = false;
+
+	if (item[0] >= e->items)
+		return -EINVAL;
+
+	val = snd_soc_enum_item_to_val(e, item[0]);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	if (cs48l32->eq_mode[e->shift_l] != val) {
+		cs48l32->eq_mode[e->shift_l] = val;
+		changed = true;
+	}
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return changed;
+}
+
+int cs48l32_eq_coeff_info(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_info *uinfo)
+{
+	struct cs48l32_eq_control *ctl = (void *) kcontrol->private_value;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = ctl->max;
+
+	return 0;
+}
+
+int cs48l32_eq_coeff_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_eq_control *params = (void *)kcontrol->private_value;
+	__be16 *coeffs;
+	unsigned int coeff_idx;
+	int block_idx;
+
+	block_idx = ((int) params->block_base - (int) CS48L32_EQ1_BAND1_COEFF1);
+	block_idx /= 68;
+
+	coeffs = &cs48l32->eq_coefficients[block_idx][0];
+
+	coeff_idx = (params->reg - params->block_base) / 2;
+	coeff_idx += ((params->shift == 0) ? 1 : 0);
+
+	ucontrol->value.integer.value[0] = be16_to_cpu(coeffs[coeff_idx]);
+
+	return 0;
+}
+
+int cs48l32_eq_coeff_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_eq_control *params = (void *)kcontrol->private_value;
+	__be16 *coeffs;
+	unsigned int coeff_idx;
+	int block_idx;
+
+	block_idx = ((int) params->block_base - (int) CS48L32_EQ1_BAND1_COEFF1);
+	block_idx /= 68;
+
+	coeffs = &cs48l32->eq_coefficients[block_idx][0];
+
+	coeff_idx = (params->reg - params->block_base) / 2;
+	coeff_idx += ((params->shift == 0) ? 1 : 0);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	coeffs[coeff_idx] = cpu_to_be16(ucontrol->value.integer.value[0]);
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return 0;
+}
+
+const struct snd_kcontrol_new cs48l32_drc_activity_output_mux[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+};
+
+const struct snd_kcontrol_new cs48l32_dsp_trigger_output_mux[] = {
+	SOC_DAPM_SINGLE("Switch", SND_SOC_NOPM, 0, 1, 0),
+};
+
+int cs48l32_dsp_rate_get(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	unsigned int cached_rate;
+	const unsigned int rate_num = e->mask;
+	int item;
+
+	if (rate_num >= ARRAY_SIZE(cs48l32->dsp_dma_rates))
+		return -EINVAL;
+
+	cached_rate = cs48l32->dsp_dma_rates[rate_num];
+	item = snd_soc_enum_val_to_item(e, cached_rate);
+	ucontrol->value.enumerated.item[0] = item;
+
+	return 0;
+}
+
+int cs48l32_dsp_rate_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct soc_enum *e = (struct soc_enum *) kcontrol->private_value;
+	const unsigned int rate_num = e->mask;
+	const unsigned int item = ucontrol->value.enumerated.item[0];
+	unsigned int val;
+	bool changed = false;
+
+	if (item >= e->items)
+		return -EINVAL;
+
+	if (rate_num >= ARRAY_SIZE(cs48l32->dsp_dma_rates))
+		return -EINVAL;
+
+	val = snd_soc_enum_item_to_val(e, item);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	if (cs48l32->dsp_dma_rates[rate_num] != val) {
+		cs48l32->dsp_dma_rates[rate_num] = val;
+		changed = true;
+	}
+	snd_soc_dapm_mutex_unlock(dapm);
+
+	return changed;
+}
+
+const struct soc_enum cs48l32_dsp_rate_enum[] = {
+	/* RX rates */
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      0,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      1,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      2,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      3,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      4,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text,  cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      5,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      6,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      7,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	/* TX rates */
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      8,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      9,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      10,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      11,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      12,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      13,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      14,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+	SOC_VALUE_ENUM_SINGLE(SND_SOC_NOPM, 0,
+			      15,
+			      ARRAY_SIZE(cs48l32_rate_text),
+			      cs48l32_rate_text, cs48l32_rate_val),
+};
+
+int cs48l32_dsp_pre_run(struct wm_adsp *dsp)
+{
+	struct cs48l32 *cs48l32 = container_of(dsp, struct cs48l32, dsp);
+	unsigned int reg;
+	const u8 *rate = cs48l32->dsp_dma_rates;
+	int i;
+
+	reg = dsp->cs_dsp.base + CS48L32_HALO_SAMPLE_RATE_RX1;
+	for (i = 0; i < CS48L32_DSP_N_RX_CHANNELS; ++i) {
+		regmap_update_bits(dsp->cs_dsp.regmap, reg, CS48L32_HALO_DSP_RATE_MASK, *rate);
+		reg += 8;
+		rate++;
+	}
+
+	reg = dsp->cs_dsp.base + CS48L32_HALO_SAMPLE_RATE_TX1;
+	for (i = 0; i < CS48L32_DSP_N_TX_CHANNELS; ++i) {
+		regmap_update_bits(dsp->cs_dsp.regmap, reg, CS48L32_HALO_DSP_RATE_MASK, *rate);
+		reg += 8;
+		rate++;
+	}
+
+	usleep_range(300, 600);
+
+	return 0;
+}
+
+int cs48l32_dsp_memory_enable(struct cs48l32 *cs48l32,
+			      const struct cs48l32_dsp_power_regs *regs)
+{
+	struct regmap *regmap = cs48l32->mfd->regmap;
+	int i, j, ret;
+
+	/* disable power-off */
+	for (i = 0; i < regs->n_ext; ++i) {
+		for (j = regs->ext[i].start; j <= regs->ext[i].end; j += 4) {
+			ret = regmap_write(regmap, j, 0x3);
+			if (ret)
+				goto err;
+		}
+	}
+
+	/* power-up the banks in sequence */
+	for (i = 0; i < regs->n_pwd; ++i) {
+		ret = regmap_write(regmap, regs->pwd[i], 0x1);
+		if (ret)
+			goto err;
+
+		udelay(1); /* allow bank to power-up */
+
+		ret = regmap_write(regmap, regs->pwd[i], 0x3);
+		if (ret)
+			goto err;
+
+		udelay(1); /* allow bank to power-up */
+	}
+
+	return 0;
+
+err:
+	dev_err(cs48l32->dev, "Failed to write SRAM enables (%d)\n", ret);
+	cs48l32_dsp_memory_disable(cs48l32, regs);
+
+	return ret;
+}
+
+void cs48l32_dsp_memory_disable(struct cs48l32 *cs48l32,
+				const struct cs48l32_dsp_power_regs *regs)
+{
+	struct regmap *regmap = cs48l32->mfd->regmap;
+	int i, j, ret;
+
+	for (i = 0; i < regs->n_pwd; ++i) {
+		ret = regmap_write(regmap, regs->pwd[i], 0);
+		if (ret)
+			dev_warn(cs48l32->dev, "Failed to write SRAM enables (%d)\n", ret);
+	}
+
+	for (i = 0; i < regs->n_ext; ++i) {
+		for (j = regs->ext[i].start; j <= regs->ext[i].end; j += 4) {
+			ret = regmap_write(regmap, j, 0);
+			if (ret)
+				dev_warn(cs48l32->dev, "Failed to write SRAM enables (%d)\n", ret);
+		}
+	}
+}
+
+static int cs48l32_dsp_freq_update(struct snd_soc_dapm_widget *w, unsigned int freq_reg,
+				   unsigned int freqsel_reg)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	struct wm_adsp *dsp = &cs48l32->dsp;
+	int ret;
+	unsigned int freq, freq_sel, freq_sts;
+
+	if (!freq_reg)
+		return -EINVAL;
+
+	ret = regmap_read(mfd->regmap, freq_reg, &freq);
+	if (ret) {
+		dev_err(component->dev, "Failed to read 0x%x: %d\n", freq_reg, ret);
+		return ret;
+	}
+
+	if (freqsel_reg) {
+		freq_sts = (freq & CS48L32_SYSCLK_FREQ_STS_MASK) >> CS48L32_SYSCLK_FREQ_STS_SHIFT;
+
+		ret = regmap_read(mfd->regmap, freqsel_reg, &freq_sel);
+		if (ret) {
+			dev_err(component->dev, "Failed to read 0x%x: %d\n", freqsel_reg, ret);
+			return ret;
+		}
+		freq_sel = (freq_sel & CS48L32_SYSCLK_FREQ_MASK) >> CS48L32_SYSCLK_FREQ_SHIFT;
+
+		if (freq_sts != freq_sel) {
+			dev_err(component->dev, "SYSCLK FREQ (0x%x) != FREQ STS (0x%x)\n",
+				freq_sel, freq_sts);
+			return -ETIMEDOUT;
+		}
+	}
+
+	freq &= CS48L32_DSP_CLK_FREQ_MASK;
+	freq >>= CS48L32_DSP_CLK_FREQ_SHIFT;
+
+	ret = regmap_write(dsp->cs_dsp.regmap,
+			   dsp->cs_dsp.base + CS48L32_DSP_CLOCK_FREQ_OFFS, freq);
+	if (ret) {
+		dev_err(component->dev, "Failed to set HALO clock freq: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int cs48l32_dsp_freq_ev(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		return cs48l32_dsp_freq_update(w, CS48L32_SYSTEM_CLOCK2, CS48L32_SYSTEM_CLOCK1);
+	default:
+		return 0;
+	}
+}
+
+irqreturn_t cs48l32_dsp1_irq(int irq, void *data)
+{
+	struct cs48l32 *cs48l32 = data;
+	int ret;
+
+	ret = wm_adsp_compr_handle_irq(&cs48l32->dsp);
+	if (ret == -ENODEV) {
+		dev_err(cs48l32->dev, "Spurious compressed data IRQ\n");
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const unsigned int cs48l32_opclk_ref_48k_rates[] = {
+	6144000,
+	12288000,
+	24576000,
+	49152000,
+};
+
+static const unsigned int cs48l32_opclk_ref_44k1_rates[] = {
+	5644800,
+	11289600,
+	22579200,
+	45158400,
+};
+
+static int cs48l32_set_opclk(struct snd_soc_component *component, unsigned int clk,
+			     unsigned int freq)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	unsigned int reg;
+	const unsigned int *rates;
+	int ref, div, refclk;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_opclk_ref_48k_rates) !=
+		     ARRAY_SIZE(cs48l32_opclk_ref_44k1_rates));
+
+	switch (clk) {
+	case CS48L32_CLK_OPCLK:
+		reg = CS48L32_OUTPUT_SYS_CLK;
+		refclk = cs48l32->sysclk;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (refclk % 4000)
+		rates = cs48l32_opclk_ref_44k1_rates;
+	else
+		rates = cs48l32_opclk_ref_48k_rates;
+
+	for (ref = 0; ref < ARRAY_SIZE(cs48l32_opclk_ref_48k_rates); ++ref) {
+		if (rates[ref] > refclk)
+			continue;
+
+		div = 2;
+		while ((rates[ref] / div >= freq) && (div <= 30)) {
+			if (rates[ref] / div == freq) {
+				dev_dbg(component->dev, "Configured %dHz OPCLK\n", freq);
+				snd_soc_component_update_bits(component, reg,
+							      CS48L32_OPCLK_DIV_MASK |
+							      CS48L32_OPCLK_SEL_MASK,
+							      (div << CS48L32_OPCLK_DIV_SHIFT) |
+							      ref);
+				return 0;
+			}
+			div += 2;
+		}
+	}
+
+	dev_err(component->dev, "Unable to generate %dHz OPCLK\n", freq);
+	return -EINVAL;
+}
+
+static int cs48l32_get_dspclk_setting(struct cs48l32 *cs48l32, unsigned int freq,
+				      int src, unsigned int *val)
+{
+	freq /= 15625; /* convert to 1/64ths of 1MHz */
+	*val |= freq << CS48L32_DSP_CLK_FREQ_SHIFT;
+
+	return 0;
+}
+
+static int cs48l32_get_sysclk_setting(unsigned int freq)
+{
+	switch (freq) {
+	case 0:
+	case 5644800:
+	case 6144000:
+		return CS48L32_SYSCLK_RATE_6MHZ;
+	case 11289600:
+	case 12288000:
+		return CS48L32_SYSCLK_RATE_12MHZ << CS48L32_SYSCLK_FREQ_SHIFT;
+	case 22579200:
+	case 24576000:
+		return CS48L32_SYSCLK_RATE_24MHZ << CS48L32_SYSCLK_FREQ_SHIFT;
+	case 45158400:
+	case 49152000:
+		return CS48L32_SYSCLK_RATE_49MHZ << CS48L32_SYSCLK_FREQ_SHIFT;
+	case 90316800:
+	case 98304000:
+		return CS48L32_SYSCLK_RATE_98MHZ << CS48L32_SYSCLK_FREQ_SHIFT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cs48l32_set_pdm_fllclk(struct snd_soc_component *component, int source)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int val;
+
+	switch (source) {
+	case CS48L32_PDMCLK_SRC_IN1_PDMCLK:
+	case CS48L32_PDMCLK_SRC_IN2_PDMCLK:
+	case CS48L32_PDMCLK_SRC_IN3_PDMCLK:
+	case CS48L32_PDMCLK_SRC_IN4_PDMCLK:
+	case CS48L32_PDMCLK_SRC_AUXPDM1_CLK:
+	case CS48L32_PDMCLK_SRC_AUXPDM2_CLK:
+		val = source << CS48L32_PDM_FLLCLK_SRC_SHIFT;
+		break;
+	default:
+		dev_err(cs48l32->dev, "Invalid PDM FLLCLK src %d\n", source);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(mfd->regmap, CS48L32_INPUT_CONTROL2,
+				  CS48L32_PDM_FLLCLK_SRC_MASK, val);
+}
+
+int cs48l32_set_sysclk(struct snd_soc_component *component, int clk_id, int source,
+		       unsigned int freq, int dir)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	char *name;
+	unsigned int reg;
+	unsigned int mask = CS48L32_SYSCLK_SRC_MASK;
+	unsigned int val = source << CS48L32_SYSCLK_SRC_SHIFT;
+	int clk_freq_sel, *clk;
+
+	switch (clk_id) {
+	case CS48L32_CLK_SYSCLK_1:
+		name = "SYSCLK";
+		reg = CS48L32_SYSTEM_CLOCK1;
+		clk = &cs48l32->sysclk;
+		clk_freq_sel = cs48l32_get_sysclk_setting(freq);
+		mask |= CS48L32_SYSCLK_FREQ_MASK | CS48L32_SYSCLK_FRAC_MASK;
+		break;
+	case CS48L32_CLK_DSPCLK:
+		name = "DSPCLK";
+		reg = CS48L32_DSP_CLOCK1;
+		clk = &cs48l32->dspclk;
+		clk_freq_sel = cs48l32_get_dspclk_setting(cs48l32, freq, source, &val);
+		mask |= CS48L32_DSP_CLK_FREQ_MASK;
+		break;
+	case CS48L32_CLK_OPCLK:
+		return cs48l32_set_opclk(component, clk_id, freq);
+	case CS48L32_CLK_PDM_FLLCLK:
+		return cs48l32_set_pdm_fllclk(component, source);
+	default:
+		return -EINVAL;
+	}
+
+	if (clk_freq_sel < 0) {
+		dev_err(cs48l32->dev, "Failed to get %s setting for %dHZ\n", name, freq);
+		return clk_freq_sel;
+	}
+
+	*clk = freq;
+
+	if (freq == 0) {
+		dev_dbg(cs48l32->dev, "%s cleared\n", name);
+		return 0;
+	}
+
+	val |= clk_freq_sel;
+
+	if (freq % 6144000)
+		val |= CS48L32_SYSCLK_FRAC_MASK;
+
+	dev_dbg(cs48l32->dev, "%s set to %uHz", name, freq);
+
+	return regmap_update_bits(mfd->regmap, reg, mask, val);
+}
+
+static int cs48l32_is_enabled_fll(struct cs48l32_fll *fll, int base)
+{
+	struct cs48l32_mfd *mfd = fll->cs48l32->mfd;
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(mfd->regmap, base + CS48L32_FLL_CONTROL1_OFFS, &reg);
+	if (ret != 0) {
+		cs48l32_fll_err(fll, "Failed to read current state: %d\n", ret);
+		return ret;
+	}
+
+	return reg & CS48L32_FLL_EN_MASK;
+}
+
+static int cs48l32_wait_for_fll(struct cs48l32_fll *fll, bool requested)
+{
+	struct cs48l32_mfd *mfd = fll->cs48l32->mfd;
+	unsigned int val = 0;
+	int i;
+
+	cs48l32_fll_dbg(fll, "Waiting for FLL...\n");
+
+	for (i = 0; i < 30; i++) {
+		regmap_read(mfd->regmap, fll->sts_addr, &val);
+		if (!!(val & fll->sts_mask) == requested)
+			return 0;
+
+		switch (i) {
+		case 0 ... 5:
+			usleep_range(75, 125);
+			break;
+		case 11 ... 20:
+			usleep_range(750, 1250);
+			break;
+		default:
+			msleep(20);
+			break;
+		}
+	}
+
+	cs48l32_fll_warn(fll, "Timed out waiting for %s\n", requested ? "lock" : "unlock");
+
+	return -ETIMEDOUT;
+}
+
+static int cs48l32_fllhj_disable(struct cs48l32_fll *fll)
+{
+	struct cs48l32_mfd *mfd = fll->cs48l32->mfd;
+	bool change;
+
+	cs48l32_fll_dbg(fll, "Disabling FLL\n");
+
+	/*
+	 * Disable lockdet, but don't set ctrl_upd update bit. This allows the
+	 * lock status bit to clear as normal, but should the FLL be enabled
+	 * again due to a control clock being required, the lock won't re-assert
+	 * as the FLL config registers are automatically applied when the FLL
+	 * enables.
+	 */
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			CS48L32_FLL_HOLD_MASK);
+	regmap_clear_bits(mfd->regmap,
+			  fll->base + CS48L32_FLL_CONTROL2_OFFS,
+			  CS48L32_FLL_LOCKDET_MASK);
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL5_OFFS,
+			CS48L32_FLL_FRC_INTEG_UPD_MASK);
+	regmap_update_bits_check(mfd->regmap,
+				 fll->base + CS48L32_FLL_CONTROL1_OFFS,
+				 CS48L32_FLL_EN_MASK,
+				 0,
+				 &change);
+
+	cs48l32_wait_for_fll(fll, false);
+
+	/*
+	 * ctrl_up gates the writes to all the fll's registers, setting it to 0
+	 * here ensures that after a runtime suspend/resume cycle when one
+	 * enables the fll then ctrl_up is the last bit that is configured
+	 * by the fll enable code rather than the cache sync operation which
+	 * would have updated it much earlier before writing out all fll
+	 * registers
+	 */
+	regmap_clear_bits(mfd->regmap,
+			   fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			   CS48L32_FLL_CTRL_UPD_MASK);
+
+	if (change)
+		pm_runtime_put_autosuspend(mfd->dev);
+
+	return 0;
+}
+
+static int cs48l32_fllhj_apply(struct cs48l32_fll *fll, int fin)
+{
+	struct cs48l32_mfd *mfd = fll->cs48l32->mfd;
+	int refdiv, fref, fout, lockdet_thr, fbdiv, fllgcd;
+	bool frac = false;
+	unsigned int fll_n, min_n, max_n, ratio, theta, lambda, hp;
+	unsigned int gains, num;
+
+	cs48l32_fll_dbg(fll, "fin=%d, fout=%d\n", fin, fll->fout);
+
+	for (refdiv = 0; refdiv < 4; refdiv++) {
+		if ((fin / (1 << refdiv)) <= CS48L32_FLLHJ_MAX_THRESH)
+			break;
+	}
+
+	fref = fin / (1 << refdiv);
+	fout = fll->fout;
+	frac = fout % fref;
+
+	if (frac && fll->integer_only) {
+		cs48l32_fll_err(fll, "%u:%u not an integer ratio\n", fin, fout);
+		return -EINVAL;
+	}
+
+	if (fll->max_fref && (fref > fll->max_fref)) {
+		cs48l32_fll_err(fll, "fref=%u too high (max %u)\n",
+			      fref, fll->max_fref);
+		return -EINVAL;
+	}
+
+	/*
+	 * Use simple heuristic approach to find a configuration that
+	 * should work for most input clocks.
+	 */
+	if (fref < CS48L32_FLLHJ_LOW_THRESH) {
+		lockdet_thr = 2;
+		gains = CS48L32_FLLHJ_LOW_GAINS;
+
+		if (frac)
+			fbdiv = 256;
+		else
+			fbdiv = 4;
+	} else if (fref < CS48L32_FLLHJ_MID_THRESH) {
+		lockdet_thr = 8;
+		gains = CS48L32_FLLHJ_MID_GAINS;
+		fbdiv = (frac) ? 16 : 2;
+	} else {
+		lockdet_thr = 8;
+		gains = CS48L32_FLLHJ_HIGH_GAINS;
+		fbdiv = 1;
+	}
+	/* Use high performance mode for fractional configurations. */
+	if (frac) {
+		hp = 0x3;
+		min_n = CS48L32_FLLHJ_FRAC_MIN_N;
+		max_n = CS48L32_FLLHJ_FRAC_MAX_N;
+	} else {
+		if (fll->has_lp && (fref < CS48L32_FLLHJ_LP_INT_MODE_THRESH))
+			hp = 0x0;
+		else
+			hp = 0x1;
+
+		min_n = CS48L32_FLLHJ_INT_MIN_N;
+		max_n = CS48L32_FLLHJ_INT_MAX_N;
+	}
+
+	ratio = fout / fref;
+
+	cs48l32_fll_dbg(fll, "refdiv=%d, fref=%d, frac:%d\n", refdiv, fref, frac);
+
+	while (ratio / fbdiv < min_n) {
+		fbdiv /= 2;
+		if (fbdiv < min_n) {
+			cs48l32_fll_err(fll, "FBDIV (%u) < minimum N (%u)\n", fbdiv, min_n);
+			return -EINVAL;
+		}
+	}
+	while (frac && (ratio / fbdiv > max_n)) {
+		fbdiv *= 2;
+		if (fbdiv >= 1024) {
+			cs48l32_fll_err(fll, "FBDIV (%u) >= 1024\n", fbdiv);
+			return -EINVAL;
+		}
+	}
+
+	cs48l32_fll_dbg(fll, "lockdet=%d, hp=0x%x, fbdiv:%d\n", lockdet_thr, hp, fbdiv);
+
+	/* Calculate N.K values */
+	fllgcd = gcd(fout, fbdiv * fref);
+	num = fout / fllgcd;
+	lambda = (fref * fbdiv) / fllgcd;
+	fll_n = num / lambda;
+	theta = num % lambda;
+
+	cs48l32_fll_dbg(fll, "fll_n=%d, gcd=%d, theta=%d, lambda=%d\n",
+			fll_n, fllgcd, theta, lambda);
+
+	/* Some sanity checks before any registers are written. */
+	if (fll_n < min_n || fll_n > max_n) {
+		cs48l32_fll_err(fll, "N not in valid %s mode range %d-%d: %d\n",
+				frac ? "fractional" : "integer", min_n, max_n, fll_n);
+		return -EINVAL;
+	}
+	if (fbdiv < 1 || (frac && fbdiv >= 1024) || (!frac && fbdiv >= 256)) {
+		cs48l32_fll_err(fll, "Invalid fbdiv for %s mode (%u)\n",
+				frac ? "fractional" : "integer", fbdiv);
+		return -EINVAL;
+	}
+
+	/* clear the ctrl_upd bit to guarantee we write to it later. */
+	regmap_update_bits(mfd->regmap,
+			   fll->base + CS48L32_FLL_CONTROL2_OFFS,
+			   CS48L32_FLL_LOCKDET_THR_MASK |
+			   CS48L32_FLL_PHASEDET_MASK |
+			   CS48L32_FLL_REFCLK_DIV_MASK |
+			   CS48L32_FLL_N_MASK |
+			   CS48L32_FLL_CTRL_UPD_MASK,
+			   (lockdet_thr << CS48L32_FLL_LOCKDET_THR_SHIFT) |
+			   (1 << CS48L32_FLL_PHASEDET_SHIFT) |
+			   (refdiv << CS48L32_FLL_REFCLK_DIV_SHIFT) |
+			   (fll_n << CS48L32_FLL_N_SHIFT));
+
+	regmap_update_bits(mfd->regmap,
+			   fll->base + CS48L32_FLL_CONTROL3_OFFS,
+			   CS48L32_FLL_LAMBDA_MASK |
+			   CS48L32_FLL_THETA_MASK,
+			   (lambda << CS48L32_FLL_LAMBDA_SHIFT) |
+			   (theta << CS48L32_FLL_THETA_SHIFT));
+
+	regmap_update_bits(mfd->regmap,
+			   fll->base + CS48L32_FLL_CONTROL4_OFFS,
+			   (0xffff << CS48L32_FLL_FD_GAIN_COARSE_SHIFT) |
+			   CS48L32_FLL_HP_MASK |
+			   CS48L32_FLL_FB_DIV_MASK,
+			   (gains << CS48L32_FLL_FD_GAIN_COARSE_SHIFT) |
+			   (hp << CS48L32_FLL_HP_SHIFT) |
+			   (fbdiv << CS48L32_FLL_FB_DIV_SHIFT));
+
+	return 0;
+}
+
+static int cs48l32_fllhj_enable(struct cs48l32_fll *fll)
+{
+	struct cs48l32_mfd *mfd = fll->cs48l32->mfd;
+	int already_enabled = cs48l32_is_enabled_fll(fll, fll->base);
+	int ret;
+
+	if (already_enabled < 0)
+		return already_enabled;
+
+	if (!already_enabled)
+		pm_runtime_get_sync(mfd->dev);
+
+	cs48l32_fll_dbg(fll, "Enabling FLL, initially %s\n",
+			already_enabled ? "enabled" : "disabled");
+
+	/* FLLn_HOLD must be set before configuring any registers */
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			CS48L32_FLL_HOLD_MASK);
+
+	/* Apply refclk */
+	ret = cs48l32_fllhj_apply(fll, fll->ref_freq);
+	if (ret) {
+		cs48l32_fll_err(fll, "Failed to set FLL: %d\n", ret);
+		goto out;
+	}
+	regmap_update_bits(mfd->regmap,
+			   fll->base + CS48L32_FLL_CONTROL2_OFFS,
+			   CS48L32_FLL_REFCLK_SRC_MASK,
+			   fll->ref_src << CS48L32_FLL_REFCLK_SRC_SHIFT);
+
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			CS48L32_FLL_EN_MASK);
+
+out:
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL2_OFFS,
+			CS48L32_FLL_LOCKDET_MASK);
+
+	regmap_set_bits(mfd->regmap,
+			fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			CS48L32_FLL_CTRL_UPD_MASK);
+
+	/* Release the hold so that flln locks to external frequency */
+	regmap_clear_bits(mfd->regmap,
+			  fll->base + CS48L32_FLL_CONTROL1_OFFS,
+			  CS48L32_FLL_HOLD_MASK);
+
+	if (!already_enabled)
+		cs48l32_wait_for_fll(fll, true);
+
+	return 0;
+}
+
+static int cs48l32_fllhj_validate(struct cs48l32_fll *fll,
+				  unsigned int ref_in,
+				  unsigned int fout)
+{
+	if (fout && !ref_in) {
+		cs48l32_fll_err(fll, "fllout set without valid input clk\n");
+		return -EINVAL;
+	}
+
+	if (fll->fout && fout != fll->fout) {
+		cs48l32_fll_err(fll, "Can't change output on active FLL\n");
+		return -EINVAL;
+	}
+
+	if (ref_in / CS48L32_FLL_MAX_REFDIV > CS48L32_FLLHJ_MAX_THRESH) {
+		cs48l32_fll_err(fll, "Can't scale %dMHz to <=13MHz\n", ref_in);
+		return -EINVAL;
+	}
+
+	if (fout > CS48L32_FLL_MAX_FOUT) {
+		cs48l32_fll_err(fll, "Fout=%dMHz exceeeds maximum %dMHz\n",
+				fout, CS48L32_FLL_MAX_FOUT);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int cs48l32_fllhj_set_refclk(struct cs48l32_fll *fll, int source,
+			     unsigned int fin, unsigned int fout)
+{
+	int ret = 0;
+
+	if (fll->ref_src == source && fll->ref_freq == fin && fll->fout == fout)
+		return 0;
+
+	if (fin && fout && cs48l32_fllhj_validate(fll, fin, fout))
+		return -EINVAL;
+
+	fll->ref_src = source;
+	fll->ref_freq = fin;
+	fll->fout = fout;
+
+	if (fout)
+		ret = cs48l32_fllhj_enable(fll);
+	else
+		cs48l32_fllhj_disable(fll);
+
+	return ret;
+}
+
+int cs48l32_init_fll(struct cs48l32_fll *fll)
+{
+	fll->ref_src = CS48L32_FLL_SRC_NONE;
+
+	return 0;
+}
+
+static int cs48l32_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int val = 0U;
+	unsigned int base = dai->driver->base;
+	unsigned int mask = CS48L32_ASP_FMT_MASK | CS48L32_ASP_BCLK_INV_MASK |
+			    CS48L32_ASP_BCLK_MSTR_MASK |
+			    CS48L32_ASP_FSYNC_INV_MASK |
+			    CS48L32_ASP_FSYNC_MSTR_MASK;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		val |= (CS48L32_ASP_FMT_DSP_MODE_A << CS48L32_ASP_FMT_SHIFT);
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		if ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_BP_FP) {
+			cs48l32_asp_err(dai, "DSP_B cannot be clock consumer\n");
+			return -EINVAL;
+		}
+		val |= (CS48L32_ASP_FMT_DSP_MODE_B << CS48L32_ASP_FMT_SHIFT);
+		break;
+	case SND_SOC_DAIFMT_I2S:
+		val |= (CS48L32_ASP_FMT_I2S_MODE << CS48L32_ASP_FMT_SHIFT);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		if ((fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) != SND_SOC_DAIFMT_BP_FP) {
+			cs48l32_asp_err(dai, "LEFT_J cannot be clock consumer\n");
+			return -EINVAL;
+		}
+		val |= (CS48L32_ASP_FMT_LEFT_JUSTIFIED_MODE << CS48L32_ASP_FMT_SHIFT);
+		break;
+	default:
+		cs48l32_asp_err(dai, "Unsupported DAI format %d\n",
+				fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_BC_FC:
+		break;
+	case SND_SOC_DAIFMT_BC_FP:
+		val |= CS48L32_ASP_FSYNC_MSTR_MASK;
+		break;
+	case SND_SOC_DAIFMT_BP_FC:
+		val |= CS48L32_ASP_BCLK_MSTR_MASK;
+		break;
+	case SND_SOC_DAIFMT_BP_FP:
+		val |= CS48L32_ASP_BCLK_MSTR_MASK;
+		val |= CS48L32_ASP_FSYNC_MSTR_MASK;
+		break;
+	default:
+		cs48l32_asp_err(dai, "Unsupported clock direction %d\n",
+				fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK);
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		val |= CS48L32_ASP_BCLK_INV_MASK;
+		val |= CS48L32_ASP_FSYNC_INV_MASK;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		val |= CS48L32_ASP_BCLK_INV_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		val |= CS48L32_ASP_FSYNC_INV_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(mfd->regmap, base + CS48L32_ASP_CONTROL2, mask, val);
+
+	return 0;
+}
+
+static const struct {
+	u32 freq;
+	u32 id;
+} cs48l32_sclk_rates[] = {
+	{ 128000,   12 },
+	{ 176400,   13 },
+	{ 192000,   14 },
+	{ 256000,   15 },
+	{ 352800,   16 },
+	{ 384000,   17 },
+	{ 512000,   18 },
+	{ 705600,   19 },
+	{ 768000,   21 },
+	{ 1024000,  23 },
+	{ 1411200,  25 },
+	{ 1536000,  27 },
+	{ 2048000,  29 },
+	{ 2822400,  31 },
+	{ 3072000,  33 },
+	{ 4096000,  36 },
+	{ 5644800,  38 },
+	{ 6144000,  40 },
+	{ 8192000,  47 },
+	{ 11289600, 49 },
+	{ 12288000, 51 },
+	{ 22579200, 57 },
+	{ 24576000, 59 },
+};
+
+#define CS48L32_48K_RATE_MASK	0x0e00fe
+#define CS48L32_44K1_RATE_MASK	0x00fe00
+#define CS48L32_RATE_MASK	(CS48L32_48K_RATE_MASK | CS48L32_44K1_RATE_MASK)
+
+static const unsigned int cs48l32_sr_vals[] = {
+	0,
+	12000,  /* CS48L32_48K_RATE_MASK */
+	24000,  /* CS48L32_48K_RATE_MASK */
+	48000,  /* CS48L32_48K_RATE_MASK */
+	96000,  /* CS48L32_48K_RATE_MASK */
+	192000, /* CS48L32_48K_RATE_MASK */
+	384000, /* CS48L32_48K_RATE_MASK */
+	768000, /* CS48L32_48K_RATE_MASK */
+	0,
+	11025,  /* CS48L32_44K1_RATE_MASK */
+	22050,  /* CS48L32_44K1_RATE_MASK */
+	44100,  /* CS48L32_44K1_RATE_MASK */
+	88200,  /* CS48L32_44K1_RATE_MASK */
+	176400, /* CS48L32_44K1_RATE_MASK */
+	352800, /* CS48L32_44K1_RATE_MASK */
+	705600, /* CS48L32_44K1_RATE_MASK */
+	0,
+	8000,   /* CS48L32_48K_RATE_MASK */
+	16000,  /* CS48L32_48K_RATE_MASK */
+	32000,  /* CS48L32_48K_RATE_MASK */
+};
+
+static const struct snd_pcm_hw_constraint_list cs48l32_constraint = {
+	.count	= ARRAY_SIZE(cs48l32_sr_vals),
+	.list	= cs48l32_sr_vals,
+};
+
+static int cs48l32_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_dai_priv *dai_priv = &cs48l32->dai[dai->id - 1];
+	unsigned int base_rate;
+
+	if (!substream->runtime)
+		return 0;
+
+	switch (dai_priv->clk) {
+	case CS48L32_CLK_SYSCLK_1:
+	case CS48L32_CLK_SYSCLK_2:
+	case CS48L32_CLK_SYSCLK_3:
+	case CS48L32_CLK_SYSCLK_4:
+		base_rate = cs48l32->sysclk;
+		break;
+	default:
+		return 0;
+	}
+
+	if (base_rate == 0)
+		dai_priv->constraint.mask = CS48L32_RATE_MASK;
+	else if (base_rate % 4000)
+		dai_priv->constraint.mask = CS48L32_44K1_RATE_MASK;
+	else
+		dai_priv->constraint.mask = CS48L32_48K_RATE_MASK;
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					  SNDRV_PCM_HW_PARAM_RATE,
+					  &dai_priv->constraint);
+}
+
+static int cs48l32_hw_params_rate(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_dai_priv *dai_priv = &cs48l32->dai[dai->id - 1];
+	unsigned int sr_val, sr_reg, rate;
+
+	rate = params_rate(params);
+	for (sr_val = 0; sr_val < ARRAY_SIZE(cs48l32_sr_vals); sr_val++)
+		if (cs48l32_sr_vals[sr_val] == rate)
+			break;
+
+	if (sr_val == ARRAY_SIZE(cs48l32_sr_vals)) {
+		cs48l32_asp_err(dai, "Unsupported sample rate %dHz\n", rate);
+		return -EINVAL;
+	}
+
+	switch (dai_priv->clk) {
+	case CS48L32_CLK_SYSCLK_1:
+		sr_reg = CS48L32_SAMPLE_RATE1;
+		break;
+	case CS48L32_CLK_SYSCLK_2:
+		sr_reg = CS48L32_SAMPLE_RATE2;
+		break;
+	case CS48L32_CLK_SYSCLK_3:
+		sr_reg = CS48L32_SAMPLE_RATE3;
+		break;
+	case CS48L32_CLK_SYSCLK_4:
+		sr_reg = CS48L32_SAMPLE_RATE3;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_component_update_bits(component, sr_reg, CS48L32_SAMPLE_RATE_1_MASK, sr_val);
+
+	return 0;
+}
+
+static bool cs48l32_asp_cfg_changed(struct snd_soc_component *component,
+				    unsigned int base, unsigned int sclk,
+				    unsigned int slotws, unsigned int dataw)
+{
+	unsigned int val;
+
+	val = snd_soc_component_read(component, base + CS48L32_ASP_CONTROL1);
+	if (sclk != (val & CS48L32_ASP_BCLK_FREQ_MASK))
+		return true;
+
+	val = snd_soc_component_read(component, base + CS48L32_ASP_CONTROL2);
+	if (slotws != (val & (CS48L32_ASP_RX_WIDTH_MASK | CS48L32_ASP_TX_WIDTH_MASK)))
+		return true;
+
+	val = snd_soc_component_read(component, base + CS48L32_ASP_DATA_CONTROL1);
+	if (dataw != (val & (CS48L32_ASP_TX_WL_MASK)))
+		return true;
+
+	val = snd_soc_component_read(component, base + CS48L32_ASP_DATA_CONTROL5);
+	if (dataw != (val & (CS48L32_ASP_RX_WL_MASK)))
+		return true;
+
+	return false;
+}
+
+static int cs48l32_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	int base = dai->driver->base;
+	int dai_id = dai->id - 1;
+	unsigned int rate = params_rate(params);
+	unsigned int dataw = snd_pcm_format_width(params_format(params));
+	unsigned int chan_limit = cs48l32->max_channels_clocked[dai_id];
+	unsigned int asp_state = 0;
+	int sclk, sclk_target;
+	unsigned int slotw, n_slots, n_slots_multiple, val;
+	int i, ret;
+
+	cs48l32_asp_dbg(dai, "hwparams in: ch:%u dataw:%u rate:%u\n",
+			params_channels(params), dataw, rate);
+	/*
+	 * The following calculations hold only under the assumption that
+	 * symmetric_[rates|channels|samplebits] are set to 1
+	 */
+	if (cs48l32->tdm_slots[dai_id]) {
+		n_slots = cs48l32->tdm_slots[dai_id];
+		slotw = cs48l32->tdm_width[dai_id];
+	} else {
+		n_slots = params_channels(params);
+		slotw = dataw;
+	}
+
+	if (chan_limit)
+		n_slots = min(n_slots, chan_limit);
+
+	val = snd_soc_component_read(component, base + CS48L32_ASP_CONTROL2);
+	val = (val & CS48L32_ASP_FMT_MASK) >> CS48L32_ASP_FMT_SHIFT;
+	if (val == CS48L32_ASP_FMT_I2S_MODE)
+		n_slots_multiple = 2;
+	else
+		n_slots_multiple = 1;
+
+	sclk_target = snd_soc_tdm_params_to_bclk(params, slotw, n_slots, n_slots_multiple);
+
+	for (i = 0; i < ARRAY_SIZE(cs48l32_sclk_rates); i++) {
+		if ((cs48l32_sclk_rates[i].freq >= sclk_target) &&
+		    (cs48l32_sclk_rates[i].freq % rate == 0)) {
+			sclk = cs48l32_sclk_rates[i].id;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(cs48l32_sclk_rates)) {
+		cs48l32_asp_err(dai, "Unsupported sample rate %dHz\n", rate);
+		return -EINVAL;
+	}
+
+	cs48l32_asp_dbg(dai, "hwparams out: n_slots:%u dataw:%u slotw:%u bclk:%u bclkid:%u\n",
+			n_slots, dataw, slotw, sclk_target, sclk);
+
+	slotw = (slotw << CS48L32_ASP_TX_WIDTH_SHIFT) |
+		(slotw << CS48L32_ASP_RX_WIDTH_SHIFT);
+
+	if (!cs48l32_asp_cfg_changed(component, base, sclk, slotw, dataw))
+		return cs48l32_hw_params_rate(substream, params, dai);
+
+	/* ASP must be disabled while changing configuration */
+	asp_state = snd_soc_component_read(component, base + CS48L32_ASP_ENABLES1);
+	regmap_clear_bits(mfd->regmap, base + CS48L32_ASP_ENABLES1, 0xff00ff);
+
+	ret = cs48l32_hw_params_rate(substream, params, dai);
+	if (ret != 0)
+		goto restore_asp;
+
+	regmap_update_bits_async(mfd->regmap,
+				 base + CS48L32_ASP_CONTROL1,
+				 CS48L32_ASP_BCLK_FREQ_MASK,
+				 sclk);
+	regmap_update_bits_async(mfd->regmap,
+				 base + CS48L32_ASP_CONTROL2,
+				 CS48L32_ASP_RX_WIDTH_MASK | CS48L32_ASP_TX_WIDTH_MASK,
+				 slotw);
+	regmap_update_bits_async(mfd->regmap,
+				 base + CS48L32_ASP_DATA_CONTROL1,
+				 CS48L32_ASP_TX_WL_MASK,
+				 dataw);
+	regmap_update_bits(mfd->regmap,
+			   base + CS48L32_ASP_DATA_CONTROL5,
+			   CS48L32_ASP_RX_WL_MASK,
+			   dataw);
+
+restore_asp:
+	/* Restore ASP TX/RX enable state */
+	regmap_update_bits(mfd->regmap,
+			   base + CS48L32_ASP_ENABLES1,
+			   0xff00ff,
+			   asp_state);
+	return ret;
+}
+
+static const char * const cs48l32_dai_clk_str(int clk_id)
+{
+	switch (clk_id) {
+	case CS48L32_CLK_SYSCLK_1:
+	case CS48L32_CLK_SYSCLK_2:
+	case CS48L32_CLK_SYSCLK_3:
+	case CS48L32_CLK_SYSCLK_4:
+		return "SYSCLK";
+	default:
+		return "Unknown clock";
+	}
+}
+
+static int cs48l32_dai_set_sysclk(struct snd_soc_dai *dai,
+				  int clk_id, unsigned int freq, int dir)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_dai_priv *dai_priv = &cs48l32->dai[dai->id - 1];
+	unsigned int base = dai->driver->base;
+	unsigned int current_asp_rate, target_asp_rate;
+	bool change_rate_domain = false;
+	int ret;
+
+	if (clk_id == dai_priv->clk)
+		return 0;
+
+	if (snd_soc_dai_active(dai)) {
+		cs48l32_asp_err(dai, "Can't change clock on active DAI\n");
+		return -EBUSY;
+	}
+
+	switch (clk_id) {
+	case CS48L32_CLK_SYSCLK_1:
+		target_asp_rate = 0U << CS48L32_ASP_RATE_SHIFT;
+		break;
+	case CS48L32_CLK_SYSCLK_2:
+		target_asp_rate = 1U << CS48L32_ASP_RATE_SHIFT;
+		break;
+	case CS48L32_CLK_SYSCLK_3:
+		target_asp_rate = 2U << CS48L32_ASP_RATE_SHIFT;
+		break;
+	case CS48L32_CLK_SYSCLK_4:
+		target_asp_rate = 3U << CS48L32_ASP_RATE_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dai_priv->clk = clk_id;
+	cs48l32_asp_dbg(dai, "Setting to %s\n", cs48l32_dai_clk_str(clk_id));
+
+	if (base) {
+		ret = regmap_read(cs48l32->mfd->regmap,
+				  base + CS48L32_ASP_CONTROL1,
+				  &current_asp_rate);
+		if (ret != 0) {
+			cs48l32_asp_err(dai, "Failed to check rate: %d\n", ret);
+			return ret;
+		}
+
+		if ((current_asp_rate & CS48L32_ASP_RATE_MASK) !=
+		    (target_asp_rate & CS48L32_ASP_RATE_MASK)) {
+			change_rate_domain = true;
+
+			mutex_lock(&cs48l32->rate_lock);
+			/* Guard the rate change with SYSCLK cycles */
+			cs48l32_spin_sysclk(cs48l32);
+		}
+
+		snd_soc_component_update_bits(component, base + CS48L32_ASP_CONTROL1,
+					      CS48L32_ASP_RATE_MASK, target_asp_rate);
+
+		if (change_rate_domain) {
+			cs48l32_spin_sysclk(cs48l32);
+			mutex_unlock(&cs48l32->rate_lock);
+		}
+	}
+
+	return 0;
+}
+
+static void cs48l32_set_channels_to_mask(struct snd_soc_dai *dai,
+					 unsigned int base,
+					 int channels, unsigned int mask)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	int slot, i, j = 0, shift;
+	unsigned int frame_ctls[2] = {0, 0};
+
+	for (i = 0; i < channels; ++i) {
+		slot = ffs(mask) - 1;
+		if (slot < 0)
+			return;
+
+		if (i - (j * 4) >= 4) {
+			++j;
+			if (j >= 2)
+				break;
+		}
+
+		shift = (8 * (i - j * 4));
+
+		frame_ctls[j] |= slot << shift;
+
+		mask &= ~(1 << slot); /* ? mask ^= 1 << slot ? */
+	}
+
+	regmap_write(mfd->regmap, base, frame_ctls[0]);
+	regmap_write(mfd->regmap, base + 0x4, frame_ctls[1]);
+
+	if (mask)
+		cs48l32_asp_warn(dai, "Too many channels in TDM mask\n");
+}
+
+static int cs48l32_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	int base = dai->driver->base;
+	int rx_max_chan = dai->driver->playback.channels_max;
+	int tx_max_chan = dai->driver->capture.channels_max;
+
+	/* Only support TDM for the physical ASPs */
+	if (dai->id > CS48L32_MAX_ASP)
+		return -EINVAL;
+
+	if (slots == 0) {
+		tx_mask = (1 << tx_max_chan) - 1;
+		rx_mask = (1 << rx_max_chan) - 1;
+	}
+
+	cs48l32_set_channels_to_mask(dai, base + CS48L32_ASP_FRAME_CONTROL1,
+				   tx_max_chan, tx_mask);
+	cs48l32_set_channels_to_mask(dai, base + CS48L32_ASP_FRAME_CONTROL5,
+				   rx_max_chan, rx_mask);
+
+	cs48l32->tdm_width[dai->id - 1] = slot_width;
+	cs48l32->tdm_slots[dai->id - 1] = slots;
+
+	return 0;
+}
+
+const struct snd_soc_dai_ops cs48l32_dai_ops = {
+	.startup = &cs48l32_startup,
+	.set_fmt = &cs48l32_set_fmt,
+	.set_tdm_slot = &cs48l32_set_tdm_slot,
+	.hw_params = &cs48l32_hw_params,
+	.set_sysclk = &cs48l32_dai_set_sysclk,
+};
+
+int cs48l32_sysclk_ev(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+
+	cs48l32_spin_sysclk(cs48l32);
+
+	return 0;
+}
+
+int cs48l32_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	unsigned int reg;
+
+	if (w->shift % 2)
+		reg = CS48L32_IN1L_CONTROL2 + ((w->shift / 2) * 0x40);
+	else
+		reg = CS48L32_IN1R_CONTROL2 + ((w->shift / 2) * 0x40);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		switch (w->shift) {
+		case CS48L32_IN1L_EN_SHIFT:
+			snd_soc_component_update_bits(component,
+						      CS48L32_ADC1L_ANA_CONTROL1,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK);
+			break;
+		case CS48L32_IN1R_EN_SHIFT:
+			snd_soc_component_update_bits(component,
+						      CS48L32_ADC1R_ANA_CONTROL1,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK);
+			break;
+		default:
+			break;
+		}
+		cs48l32->in_up_pending++;
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		usleep_range(200, 300);
+
+		switch (w->shift) {
+		case CS48L32_IN1L_EN_SHIFT:
+			snd_soc_component_update_bits(component,
+						      CS48L32_ADC1L_ANA_CONTROL1,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						      0);
+			break;
+		case CS48L32_IN1R_EN_SHIFT:
+			snd_soc_component_update_bits(component,
+						      CS48L32_ADC1R_ANA_CONTROL1,
+						      CS48L32_ADC1x_INT_ENA_FRC_MASK,
+						      0);
+			break;
+
+		default:
+			break;
+		}
+		cs48l32->in_up_pending--;
+		snd_soc_component_update_bits(component, reg, CS48L32_INx_MUTE_MASK, 0);
+
+		/* Uncached write-only register, no need for update_bits */
+		if (!cs48l32->in_up_pending)
+			snd_soc_component_write(component, cs48l32->in_vu_reg, CS48L32_IN_VU_MASK);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_component_update_bits(component, reg,
+					      CS48L32_INx_MUTE_MASK, CS48L32_INx_MUTE_MASK);
+		snd_soc_component_write(component, cs48l32->in_vu_reg, CS48L32_IN_VU_MASK);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int cs48l32_in_put_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Uncached write-only register, no need for update_bits.
+	 * Will fail if codec is off but that will be handled by cs48l32_in_ev
+	 */
+	snd_soc_component_write(component, cs48l32->in_vu_reg, CS48L32_IN_VU);
+
+	return ret;
+}
+
+static bool cs48l32_eq_filter_unstable(bool mode, __be16 in_a, __be16 in_b)
+{
+	s16 a = be16_to_cpu(in_a);
+	s16 b = be16_to_cpu(in_b);
+
+	if (!mode)
+		return abs(a) >= 4096;
+
+	if (abs(b) >= 4096)
+		return true;
+
+	return (abs((a << 16) / (4096 - b)) >= 4096 << 4);
+}
+
+int cs48l32_eq_ev(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol,
+		int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int mode = cs48l32->eq_mode[w->shift];
+	unsigned int reg = CS48L32_EQ1_BAND1_COEFF1 + (68 * w->shift);
+	__be16 *data = &cs48l32->eq_coefficients[w->shift][0];
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (cs48l32_eq_filter_unstable(!!mode, data[1], data[0]) ||
+		    cs48l32_eq_filter_unstable(true, data[7], data[6]) ||
+		    cs48l32_eq_filter_unstable(true, data[13], data[12]) ||
+		    cs48l32_eq_filter_unstable(true, data[19], data[18]) ||
+		    cs48l32_eq_filter_unstable(false, data[25], data[24])) {
+			dev_err(cs48l32->dev, "Rejecting unstable EQ coefficients.\n");
+			ret = -EINVAL;
+		} else {
+			ret = regmap_raw_write(mfd->regmap, reg, data,
+					       CS48L32_EQ_BLOCK_SZ);
+			if (ret < 0) {
+				dev_err(cs48l32->dev, "Error writing EQ coefficients: %d\n", ret);
+				goto out;
+			}
+
+			ret = snd_soc_component_update_bits(component,
+							    CS48L32_EQ_CONTROL2,
+							    w->mask,
+							    mode << w->shift);
+			if (ret < 0)
+				dev_err(cs48l32->dev, "Error writing EQ mode: %d\n", ret);
+		}
+		break;
+	default:
+		break;
+	}
+
+out:
+	return ret;
+}
+
+static int cs48l32_get_variable_u32_array(struct cs48l32 *cs48l32,
+					  const char *propname,
+					  u32 *dest,
+					  int n_max,
+					  int multiple)
+{
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	int n, ret;
+
+	n = device_property_read_u32_array(mfd->dev, propname, NULL, 0);
+	if (n == -EINVAL) {
+		return 0;	/* missing, ignore */
+	} else if (n < 0) {
+		dev_warn(cs48l32->dev, "%s malformed (%d)\n", propname, n);
+		return -EINVAL;
+	} else if ((n % multiple) != 0) {
+		dev_warn(cs48l32->dev, "%s not a multiple of %d entries\n", propname, multiple);
+		return -EINVAL;
+	}
+
+	if (n > n_max)
+		n = n_max;
+
+	ret = device_property_read_u32_array(mfd->dev, propname, dest, n);
+
+	if (ret < 0)
+		return ret;
+	else
+		return n;
+}
+
+static void cs48l32_prop_get_in_type(struct cs48l32 *cs48l32)
+{
+	u32 tmp[CS48L32_MAX_INPUT * CS48L32_MAX_MUXED_IN_CHANNELS];
+	int n, i, in_idx, ch_idx;
+
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32->in_type) != CS48L32_MAX_INPUT);
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32->in_type[0]) !=
+		     CS48L32_MAX_MUXED_IN_CHANNELS);
+
+	n = cs48l32_get_variable_u32_array(cs48l32,
+					   "cirrus,in-type",
+					   tmp,
+					   ARRAY_SIZE(tmp),
+					   CS48L32_MAX_MUXED_IN_CHANNELS);
+	if (n < 0)
+		return;
+
+	in_idx = 0;
+	ch_idx = 0;
+	for (i = 0; i < n; ++i) {
+		cs48l32->in_type[in_idx][ch_idx] = tmp[i];
+
+		if (++ch_idx == CS48L32_MAX_MUXED_IN_CHANNELS) {
+			ch_idx = 0;
+			++in_idx;
+		}
+	}
+}
+
+static void cs48l32_prop_get(struct cs48l32 *cs48l32)
+{
+	int ret;
+
+	ret = cs48l32_get_variable_u32_array(cs48l32,
+					     "cirrus,max-channels-clocked",
+					     cs48l32->max_channels_clocked,
+					     ARRAY_SIZE(cs48l32->max_channels_clocked),
+					     1);
+	if (ret < 0)
+		return;
+
+	cs48l32_prop_get_in_type(cs48l32);
+
+	cs48l32_get_variable_u32_array(cs48l32,
+				       "cirrus,pdm-sup",
+				       cs48l32->pdm_sup,
+				       ARRAY_SIZE(cs48l32->pdm_sup),
+				       1);
+}
+
+int cs48l32_init_inputs(struct snd_soc_component *component)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int ana_mode_l, ana_mode_r, dig_mode;
+	int i;
+
+	/*
+	 * Initialize input modes from the A settings. For muxed inputs the
+	 * B settings will be applied if the mux is changed
+	 */
+	for (i = 0; i < cs48l32->max_analogue_inputs; i++) {
+		dev_dbg(cs48l32->dev, "IN%d type %u:%u:%u:%u\n", i + 1,
+			cs48l32->in_type[i][0],
+			cs48l32->in_type[i][1],
+			cs48l32->in_type[i][2],
+			cs48l32->in_type[i][3]);
+
+		switch (cs48l32->in_type[i][0]) {
+		case CS48L32_IN_TYPE_DIFF:
+			ana_mode_l = 0;
+			break;
+		case CS48L32_IN_TYPE_SE:
+			ana_mode_l = 1 << CS48L32_INx_SRC_SHIFT;
+			break;
+		default:
+			dev_warn(cs48l32->dev, "IN%dL_1 Illegal in_type %u ignored\n",
+				 i + 1, cs48l32->in_type[i][0]);
+			continue;
+		}
+
+		switch (cs48l32->in_type[i][1]) {
+		case CS48L32_IN_TYPE_DIFF:
+			ana_mode_r = 0;
+			break;
+		case CS48L32_IN_TYPE_SE:
+			ana_mode_r = 1 << CS48L32_INx_SRC_SHIFT;
+			break;
+		default:
+			dev_warn(cs48l32->dev, "IN%dR_1 Illegal in_type %u ignored\n",
+				 i + 1, cs48l32->in_type[i][1]);
+			continue;
+		}
+
+		dev_dbg(cs48l32->dev, "IN%d_1 Analogue mode=0x%x,0x%x\n",
+			i + 1, ana_mode_l, ana_mode_r);
+
+		regmap_update_bits(mfd->regmap,
+				   CS48L32_IN1L_CONTROL1 + (i * 0x40),
+				   CS48L32_INx_SRC_MASK,
+				   ana_mode_l);
+
+		regmap_update_bits(mfd->regmap,
+				   CS48L32_IN1R_CONTROL1 + (i * 0x40),
+				   CS48L32_INx_SRC_MASK,
+				   ana_mode_r);
+	}
+
+	for (i = 0; i < cs48l32->max_pdm_sup; i++) {
+		dig_mode = cs48l32->pdm_sup[i] << CS48L32_IN1_PDM_SUP_SHIFT;
+
+		dev_dbg(cs48l32->dev, "IN%d PDM_SUP=0x%x\n", i + 1, dig_mode);
+
+		regmap_update_bits(mfd->regmap,
+				   CS48L32_INPUT1_CONTROL1 + (i * 0x40),
+				   CS48L32_IN1_PDM_SUP_MASK, dig_mode);
+	}
+
+	return 0;
+}
+
+int cs48l32_init_dai(struct cs48l32 *cs48l32, int id)
+{
+	struct cs48l32_dai_priv *dai_priv = &cs48l32->dai[id];
+
+	dai_priv->clk = CS48L32_CLK_SYSCLK_1;
+	dai_priv->constraint = cs48l32_constraint;
+
+	return 0;
+}
+
+int cs48l32_init_eq(struct cs48l32 *cs48l32)
+{
+	struct cs48l32_mfd *mfd = cs48l32->mfd;
+	unsigned int reg = CS48L32_EQ1_BAND1_COEFF1, mode;
+	__be16 *data;
+	int i, ret;
+
+	ret = regmap_read(mfd->regmap, CS48L32_EQ_CONTROL2, &mode);
+	if (ret < 0) {
+		dev_err(cs48l32->dev, "Error reading EQ mode: %d\n", ret);
+		goto out;
+	}
+
+	for (i = 0; i < 4; ++i) {
+		cs48l32->eq_mode[i] = (mode >> i) & 0x1;
+
+		data = &cs48l32->eq_coefficients[i][0];
+		ret = regmap_raw_read(mfd->regmap, reg + (i * 68), data,
+				      CS48L32_EQ_BLOCK_SZ);
+		if (ret < 0) {
+			dev_err(cs48l32->dev, "Error reading EQ coefficients: %d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+int cs48l32_core_init(struct cs48l32 *cs48l32)
+{
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_mixer_texts) != CS48L32_NUM_MIXER_INPUTS);
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_mixer_values) != CS48L32_NUM_MIXER_INPUTS);
+	BUILD_BUG_ON(cs48l32_sample_rate_text[CS48L32_SAMPLE_RATE_ENUM_SIZE - 1] == NULL);
+	BUILD_BUG_ON(cs48l32_sample_rate_val[CS48L32_SAMPLE_RATE_ENUM_SIZE - 1] == 0);
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_in_texts) != CS48L32_MAX_INPUT);
+
+	cs48l32_prop_get(cs48l32);
+
+	mutex_init(&cs48l32->rate_lock);
+
+	return 0;
+}
+
+int cs48l32_core_destroy(struct cs48l32 *cs48l32)
+{
+	mutex_destroy(&cs48l32->rate_lock);
+
+	return 0;
+}
diff --git a/sound/soc/codecs/cs48l32.c b/sound/soc/codecs/cs48l32.c
new file mode 100644
index 000000000000..64763772b881
--- /dev/null
+++ b/sound/soc/codecs/cs48l32.c
@@ -0,0 +1,1211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// ALSA SoC Audio driver for CS48L32 codec.
+//
+// Copyright (C) 2018-2020, 2022 Cirrus Logic, Inc. and
+//               Cirrus Logic International Semiconductor Ltd.
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/irqchip/irq-cirrus-cs48l32.h>
+#include <linux/mfd/cs48l32/core.h>
+#include <linux/mfd/cs48l32/registers.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "cs48l32.h"
+#include "wm_adsp.h"
+
+static const struct cs_dsp_region cs48l32_dsp1_regions[] = {
+	{ .type = WMFW_HALO_PM_PACKED, .base = 0x3800000 },
+	{ .type = WMFW_HALO_XM_PACKED, .base = 0x2000000 },
+	{ .type = WMFW_ADSP2_XM, .base = 0x2800000 },
+	{ .type = WMFW_HALO_YM_PACKED, .base = 0x2C00000 },
+	{ .type = WMFW_ADSP2_YM, .base = 0x3400000 },
+};
+
+static const struct cs48l32_dsp_power_reg_block cs48l32_dsp1_sram_ext_regs[] = {
+	{ CS48L32_DSP1_XM_SRAM_IBUS_SETUP_1, CS48L32_DSP1_XM_SRAM_IBUS_SETUP_24 },
+	{ CS48L32_DSP1_YM_SRAM_IBUS_SETUP_1, CS48L32_DSP1_YM_SRAM_IBUS_SETUP_8 },
+	{ CS48L32_DSP1_PM_SRAM_IBUS_SETUP_1, CS48L32_DSP1_PM_SRAM_IBUS_SETUP_7 },
+};
+
+static const unsigned int cs48l32_dsp1_sram_pwd_regs[] = {
+	CS48L32_DSP1_XM_SRAM_IBUS_SETUP_0,
+	CS48L32_DSP1_YM_SRAM_IBUS_SETUP_0,
+	CS48L32_DSP1_PM_SRAM_IBUS_SETUP_0,
+};
+
+static const struct cs48l32_dsp_power_regs cs48l32_dsp_sram_regs = {
+	.ext = cs48l32_dsp1_sram_ext_regs,
+	.n_ext = ARRAY_SIZE(cs48l32_dsp1_sram_ext_regs),
+	.pwd = cs48l32_dsp1_sram_pwd_regs,
+	.n_pwd = ARRAY_SIZE(cs48l32_dsp1_sram_pwd_regs),
+};
+
+static const struct snd_kcontrol_new cs48l32_snd_controls[] = {
+SOC_ENUM("IN1 OSR", cs48l32_in_dmic_osr[0]),
+SOC_ENUM("IN2 OSR", cs48l32_in_dmic_osr[1]),
+
+SOC_SINGLE_RANGE_TLV("IN1L Volume", CS48L32_IN1L_CONTROL2,
+		     CS48L32_INx_PGA_VOL_SHIFT, 0x40, 0x5f, 0, cs48l32_ana_tlv),
+SOC_SINGLE_RANGE_TLV("IN1R Volume", CS48L32_IN1R_CONTROL2,
+		     CS48L32_INx_PGA_VOL_SHIFT, 0x40, 0x5f, 0, cs48l32_ana_tlv),
+
+SOC_ENUM("IN HPF Cutoff Frequency", cs48l32_in_hpf_cut_enum),
+
+SOC_SINGLE_EXT("IN1L LP Switch", CS48L32_IN1L_CONTROL1, CS48L32_INx_LP_MODE_SHIFT,
+	       1, 0, snd_soc_get_volsw, cs48l32_low_power_mode_put),
+SOC_SINGLE_EXT("IN1R LP Switch", CS48L32_IN1R_CONTROL1, CS48L32_INx_LP_MODE_SHIFT,
+	       1, 0, snd_soc_get_volsw, cs48l32_low_power_mode_put),
+
+SOC_SINGLE("IN1L HPF Switch", CS48L32_IN1L_CONTROL1, CS48L32_INx_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN1R HPF Switch", CS48L32_IN1R_CONTROL1, CS48L32_INx_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN2L HPF Switch", CS48L32_IN2L_CONTROL1, CS48L32_INx_HPF_SHIFT, 1, 0),
+SOC_SINGLE("IN2R HPF Switch", CS48L32_IN2R_CONTROL1, CS48L32_INx_HPF_SHIFT, 1, 0),
+
+SOC_SINGLE_EXT_TLV("IN1L Digital Volume", CS48L32_IN1L_CONTROL2,
+		   CS48L32_INx_VOL_SHIFT, 0xbf, 0, snd_soc_get_volsw,
+		   cs48l32_in_put_volsw, cs48l32_digital_tlv),
+SOC_SINGLE_EXT_TLV("IN1R Digital Volume", CS48L32_IN1R_CONTROL2,
+		   CS48L32_INx_VOL_SHIFT, 0xbf, 0, snd_soc_get_volsw,
+		   cs48l32_in_put_volsw, cs48l32_digital_tlv),
+SOC_SINGLE_EXT_TLV("IN2L Digital Volume", CS48L32_IN2L_CONTROL2,
+		   CS48L32_INx_VOL_SHIFT, 0xbf, 0, snd_soc_get_volsw,
+		   cs48l32_in_put_volsw, cs48l32_digital_tlv),
+SOC_SINGLE_EXT_TLV("IN2R Digital Volume", CS48L32_IN2R_CONTROL2,
+		   CS48L32_INx_VOL_SHIFT, 0xbf, 0, snd_soc_get_volsw,
+		   cs48l32_in_put_volsw, cs48l32_digital_tlv),
+
+SOC_ENUM("Input Ramp Up", cs48l32_in_vi_ramp),
+SOC_ENUM("Input Ramp Down", cs48l32_in_vd_ramp),
+
+CS48L32_RATE_ENUM("Ultrasonic 1 Rate", cs48l32_us_output_rate[0]),
+CS48L32_RATE_ENUM("Ultrasonic 2 Rate", cs48l32_us_output_rate[1]),
+
+SOC_ENUM("Ultrasonic 1 Freq", cs48l32_us_freq[0]),
+SOC_ENUM("Ultrasonic 2 Freq", cs48l32_us_freq[1]),
+
+SOC_SINGLE_TLV("Ultrasonic 1 Volume", CS48L32_US1_CONTROL, CS48L32_US1_GAIN_SHIFT,
+	       3, 0, cs48l32_us_tlv),
+SOC_SINGLE_TLV("Ultrasonic 2 Volume", CS48L32_US2_CONTROL, CS48L32_US1_GAIN_SHIFT,
+	       3, 0, cs48l32_us_tlv),
+
+SOC_ENUM("Ultrasonic 1 Activity Detect Threshold", cs48l32_us_det_thr[0]),
+SOC_ENUM("Ultrasonic 2 Activity Detect Threshold", cs48l32_us_det_thr[1]),
+
+SOC_ENUM("Ultrasonic 1 Activity Detect Pulse Length", cs48l32_us_det_num[0]),
+SOC_ENUM("Ultrasonic 2 Activity Detect Pulse Length", cs48l32_us_det_num[1]),
+
+SOC_ENUM("Ultrasonic 1 Activity Detect Hold", cs48l32_us_det_hold[0]),
+SOC_ENUM("Ultrasonic 2 Activity Detect Hold", cs48l32_us_det_hold[1]),
+
+SOC_ENUM("Ultrasonic 1 Activity Detect Decay", cs48l32_us_det_dcy[0]),
+SOC_ENUM("Ultrasonic 2 Activity Detect Decay", cs48l32_us_det_dcy[1]),
+
+SOC_SINGLE("Ultrasonic 1 Activity Detect LPF Switch",
+	   CS48L32_US1_DET_CONTROL, CS48L32_US1_DET_LPF_SHIFT, 1, 0),
+SOC_SINGLE("Ultrasonic 2 Activity Detect LPF Switch",
+	   CS48L32_US2_DET_CONTROL, CS48L32_US1_DET_LPF_SHIFT, 1, 0),
+
+SOC_ENUM("Ultrasonic 1 Activity Detect LPF Cut-off", cs48l32_us_det_lpf_cut[0]),
+SOC_ENUM("Ultrasonic 2 Activity Detect LPF Cut-off", cs48l32_us_det_lpf_cut[1]),
+
+CS48L32_MIXER_CONTROLS("EQ1", CS48L32_EQ1_INPUT1),
+CS48L32_MIXER_CONTROLS("EQ2", CS48L32_EQ2_INPUT1),
+CS48L32_MIXER_CONTROLS("EQ3", CS48L32_EQ3_INPUT1),
+CS48L32_MIXER_CONTROLS("EQ4", CS48L32_EQ4_INPUT1),
+
+SOC_ENUM_EXT("EQ1 Mode", cs48l32_eq_mode[0], cs48l32_eq_mode_get, cs48l32_eq_mode_put),
+
+CS48L32_EQ_COEFF_CONTROLS(EQ1),
+
+SOC_SINGLE_TLV("EQ1 B1 Volume", CS48L32_EQ1_GAIN1, 0, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B2 Volume", CS48L32_EQ1_GAIN1, 8, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B3 Volume", CS48L32_EQ1_GAIN1, 16, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B4 Volume", CS48L32_EQ1_GAIN1, 24, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ1 B5 Volume", CS48L32_EQ1_GAIN2, 0,  24, 0, cs48l32_eq_tlv),
+
+SOC_ENUM_EXT("EQ2 Mode", cs48l32_eq_mode[1], cs48l32_eq_mode_get, cs48l32_eq_mode_put),
+CS48L32_EQ_COEFF_CONTROLS(EQ2),
+SOC_SINGLE_TLV("EQ2 B1 Volume", CS48L32_EQ2_GAIN1, 0, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B2 Volume", CS48L32_EQ2_GAIN1, 8, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B3 Volume", CS48L32_EQ2_GAIN1, 16, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B4 Volume", CS48L32_EQ2_GAIN1, 24, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ2 B5 Volume", CS48L32_EQ2_GAIN2, 0,  24, 0, cs48l32_eq_tlv),
+
+SOC_ENUM_EXT("EQ3 Mode", cs48l32_eq_mode[2], cs48l32_eq_mode_get, cs48l32_eq_mode_put),
+CS48L32_EQ_COEFF_CONTROLS(EQ3),
+SOC_SINGLE_TLV("EQ3 B1 Volume", CS48L32_EQ3_GAIN1, 0, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B2 Volume", CS48L32_EQ3_GAIN1, 8, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B3 Volume", CS48L32_EQ3_GAIN1, 16, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B4 Volume", CS48L32_EQ3_GAIN1, 24, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ3 B5 Volume", CS48L32_EQ3_GAIN2, 0,  24, 0, cs48l32_eq_tlv),
+
+SOC_ENUM_EXT("EQ4 Mode", cs48l32_eq_mode[3], cs48l32_eq_mode_get, cs48l32_eq_mode_put),
+CS48L32_EQ_COEFF_CONTROLS(EQ4),
+SOC_SINGLE_TLV("EQ4 B1 Volume", CS48L32_EQ4_GAIN1, 0, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B2 Volume", CS48L32_EQ4_GAIN1, 8, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B3 Volume", CS48L32_EQ4_GAIN1, 16, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B4 Volume", CS48L32_EQ4_GAIN1, 24, 24, 0, cs48l32_eq_tlv),
+SOC_SINGLE_TLV("EQ4 B5 Volume", CS48L32_EQ4_GAIN2, 0,  24, 0, cs48l32_eq_tlv),
+
+CS48L32_MIXER_CONTROLS("DRC1L", CS48L32_DRC1L_INPUT1),
+CS48L32_MIXER_CONTROLS("DRC1R", CS48L32_DRC1R_INPUT1),
+CS48L32_MIXER_CONTROLS("DRC2L", CS48L32_DRC2L_INPUT1),
+CS48L32_MIXER_CONTROLS("DRC2R", CS48L32_DRC2R_INPUT1),
+
+SND_SOC_BYTES_MASK("DRC1 Coefficients", CS48L32_DRC1_CONTROL1, 4,
+		   BIT(CS48L32_DRC1R_EN_SHIFT) | BIT(CS48L32_DRC1L_EN_SHIFT)),
+SND_SOC_BYTES_MASK("DRC2 Coefficients", CS48L32_DRC2_CONTROL1, 4,
+		   BIT(CS48L32_DRC1R_EN_SHIFT) | BIT(CS48L32_DRC1L_EN_SHIFT)),
+
+CS48L32_MIXER_CONTROLS("LHPF1", CS48L32_LHPF1_INPUT1),
+CS48L32_MIXER_CONTROLS("LHPF2", CS48L32_LHPF2_INPUT1),
+CS48L32_MIXER_CONTROLS("LHPF3", CS48L32_LHPF3_INPUT1),
+CS48L32_MIXER_CONTROLS("LHPF4", CS48L32_LHPF4_INPUT1),
+
+CS48L32_LHPF_CONTROL("LHPF1 Coefficients", CS48L32_LHPF1_COEFF),
+CS48L32_LHPF_CONTROL("LHPF2 Coefficients", CS48L32_LHPF2_COEFF),
+CS48L32_LHPF_CONTROL("LHPF3 Coefficients", CS48L32_LHPF3_COEFF),
+CS48L32_LHPF_CONTROL("LHPF4 Coefficients", CS48L32_LHPF4_COEFF),
+
+SOC_ENUM("LHPF1 Mode", cs48l32_lhpf_mode[0]),
+SOC_ENUM("LHPF2 Mode", cs48l32_lhpf_mode[1]),
+SOC_ENUM("LHPF3 Mode", cs48l32_lhpf_mode[2]),
+SOC_ENUM("LHPF4 Mode", cs48l32_lhpf_mode[3]),
+
+CS48L32_RATE_CONTROL("Sample Rate 1", 1),
+CS48L32_RATE_CONTROL("Sample Rate 2", 2),
+CS48L32_RATE_CONTROL("Sample Rate 3", 3),
+CS48L32_RATE_CONTROL("Sample Rate 4", 4),
+
+CS48L32_RATE_ENUM("FX Rate", cs48l32_fx_rate),
+
+CS48L32_RATE_ENUM("ISRC1 FSL", cs48l32_isrc_fsl[0]),
+CS48L32_RATE_ENUM("ISRC2 FSL", cs48l32_isrc_fsl[1]),
+CS48L32_RATE_ENUM("ISRC3 FSL", cs48l32_isrc_fsl[2]),
+CS48L32_RATE_ENUM("ISRC1 FSH", cs48l32_isrc_fsh[0]),
+CS48L32_RATE_ENUM("ISRC2 FSH", cs48l32_isrc_fsh[1]),
+CS48L32_RATE_ENUM("ISRC3 FSH", cs48l32_isrc_fsh[2]),
+
+SOC_ENUM("AUXPDM1 Rate", cs48l32_auxpdm1_freq),
+SOC_ENUM("AUXPDM2 Rate", cs48l32_auxpdm2_freq),
+
+SOC_ENUM_EXT("IN1L Rate", cs48l32_input_rate[0], snd_soc_get_enum_double, cs48l32_in_rate_put),
+SOC_ENUM_EXT("IN1R Rate", cs48l32_input_rate[1], snd_soc_get_enum_double, cs48l32_in_rate_put),
+SOC_ENUM_EXT("IN2L Rate", cs48l32_input_rate[2], snd_soc_get_enum_double, cs48l32_in_rate_put),
+SOC_ENUM_EXT("IN2R Rate", cs48l32_input_rate[3], snd_soc_get_enum_double, cs48l32_in_rate_put),
+
+CS48L32_RATE_ENUM("Noise Generator Rate", noise_gen_rate),
+
+SOC_SINGLE_TLV("Noise Generator Volume", CS48L32_COMFORT_NOISE_GENERATOR,
+	       CS48L32_NOISE_GEN_GAIN_SHIFT, 0x12, 0, cs48l32_noise_tlv),
+
+CS48L32_MIXER_CONTROLS("ASP1TX1", CS48L32_ASP1TX1_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX2", CS48L32_ASP1TX2_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX3", CS48L32_ASP1TX3_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX4", CS48L32_ASP1TX4_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX5", CS48L32_ASP1TX5_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX6", CS48L32_ASP1TX6_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX7", CS48L32_ASP1TX7_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP1TX8", CS48L32_ASP1TX8_INPUT1),
+
+CS48L32_MIXER_CONTROLS("ASP2TX1", CS48L32_ASP2TX1_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP2TX2", CS48L32_ASP2TX2_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP2TX3", CS48L32_ASP2TX3_INPUT1),
+CS48L32_MIXER_CONTROLS("ASP2TX4", CS48L32_ASP2TX4_INPUT1),
+
+WM_ADSP2_PRELOAD_SWITCH("DSP1", 1),
+
+CS48L32_MIXER_CONTROLS("DSP1RX1", CS48L32_DSP1RX1_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX2", CS48L32_DSP1RX2_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX3", CS48L32_DSP1RX3_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX4", CS48L32_DSP1RX4_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX5", CS48L32_DSP1RX5_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX6", CS48L32_DSP1RX6_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX7", CS48L32_DSP1RX7_INPUT1),
+CS48L32_MIXER_CONTROLS("DSP1RX8", CS48L32_DSP1RX8_INPUT1),
+
+WM_ADSP_FW_CONTROL("DSP1", 0),
+
+CS48L32_DSP_RATE_CONTROL("DSP1RX1", 0),
+CS48L32_DSP_RATE_CONTROL("DSP1RX2", 1),
+CS48L32_DSP_RATE_CONTROL("DSP1RX3", 2),
+CS48L32_DSP_RATE_CONTROL("DSP1RX4", 3),
+CS48L32_DSP_RATE_CONTROL("DSP1RX5", 4),
+CS48L32_DSP_RATE_CONTROL("DSP1RX6", 5),
+CS48L32_DSP_RATE_CONTROL("DSP1RX7", 6),
+CS48L32_DSP_RATE_CONTROL("DSP1RX8", 7),
+CS48L32_DSP_RATE_CONTROL("DSP1TX1", 8),
+CS48L32_DSP_RATE_CONTROL("DSP1TX2", 9),
+CS48L32_DSP_RATE_CONTROL("DSP1TX3", 10),
+CS48L32_DSP_RATE_CONTROL("DSP1TX4", 11),
+CS48L32_DSP_RATE_CONTROL("DSP1TX5", 12),
+CS48L32_DSP_RATE_CONTROL("DSP1TX6", 13),
+CS48L32_DSP_RATE_CONTROL("DSP1TX7", 14),
+CS48L32_DSP_RATE_CONTROL("DSP1TX8", 15),
+};
+
+CS48L32_MIXER_ENUMS(EQ1, CS48L32_EQ1_INPUT1);
+CS48L32_MIXER_ENUMS(EQ2, CS48L32_EQ2_INPUT1);
+CS48L32_MIXER_ENUMS(EQ3, CS48L32_EQ3_INPUT1);
+CS48L32_MIXER_ENUMS(EQ4, CS48L32_EQ4_INPUT1);
+
+CS48L32_MIXER_ENUMS(DRC1L, CS48L32_DRC1L_INPUT1);
+CS48L32_MIXER_ENUMS(DRC1R, CS48L32_DRC1R_INPUT1);
+CS48L32_MIXER_ENUMS(DRC2L, CS48L32_DRC2L_INPUT1);
+CS48L32_MIXER_ENUMS(DRC2R, CS48L32_DRC2R_INPUT1);
+
+CS48L32_MIXER_ENUMS(LHPF1, CS48L32_LHPF1_INPUT1);
+CS48L32_MIXER_ENUMS(LHPF2, CS48L32_LHPF2_INPUT1);
+CS48L32_MIXER_ENUMS(LHPF3, CS48L32_LHPF3_INPUT1);
+CS48L32_MIXER_ENUMS(LHPF4, CS48L32_LHPF4_INPUT1);
+
+CS48L32_MIXER_ENUMS(ASP1TX1, CS48L32_ASP1TX1_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX2, CS48L32_ASP1TX2_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX3, CS48L32_ASP1TX3_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX4, CS48L32_ASP1TX4_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX5, CS48L32_ASP1TX5_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX6, CS48L32_ASP1TX6_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX7, CS48L32_ASP1TX7_INPUT1);
+CS48L32_MIXER_ENUMS(ASP1TX8, CS48L32_ASP1TX8_INPUT1);
+
+CS48L32_MIXER_ENUMS(ASP2TX1, CS48L32_ASP2TX1_INPUT1);
+CS48L32_MIXER_ENUMS(ASP2TX2, CS48L32_ASP2TX2_INPUT1);
+CS48L32_MIXER_ENUMS(ASP2TX3, CS48L32_ASP2TX3_INPUT1);
+CS48L32_MIXER_ENUMS(ASP2TX4, CS48L32_ASP2TX4_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC1INT1, CS48L32_ISRC1INT1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1INT2, CS48L32_ISRC1INT2_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1INT3, CS48L32_ISRC1INT3_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1INT4, CS48L32_ISRC1INT4_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC1DEC1, CS48L32_ISRC1DEC1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1DEC2, CS48L32_ISRC1DEC2_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1DEC3, CS48L32_ISRC1DEC3_INPUT1);
+CS48L32_MUX_ENUMS(ISRC1DEC4, CS48L32_ISRC1DEC4_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC2INT1, CS48L32_ISRC2INT1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC2INT2, CS48L32_ISRC2INT2_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC2DEC1, CS48L32_ISRC2DEC1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC2DEC2, CS48L32_ISRC2DEC2_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC3INT1, CS48L32_ISRC3INT1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC3INT2, CS48L32_ISRC3INT2_INPUT1);
+
+CS48L32_MUX_ENUMS(ISRC3DEC1, CS48L32_ISRC3DEC1_INPUT1);
+CS48L32_MUX_ENUMS(ISRC3DEC2, CS48L32_ISRC3DEC2_INPUT1);
+
+CS48L32_MIXER_ENUMS(DSP1RX1, CS48L32_DSP1RX1_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX2, CS48L32_DSP1RX2_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX3, CS48L32_DSP1RX3_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX4, CS48L32_DSP1RX4_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX5, CS48L32_DSP1RX5_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX6, CS48L32_DSP1RX6_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX7, CS48L32_DSP1RX7_INPUT1);
+CS48L32_MIXER_ENUMS(DSP1RX8, CS48L32_DSP1RX8_INPUT1);
+
+static int cs48l32_dsp_mem_ev(struct snd_soc_dapm_widget *w,
+			      struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		return cs48l32_dsp_memory_enable(cs48l32, &cs48l32_dsp_sram_regs);
+	case SND_SOC_DAPM_PRE_PMD:
+		cs48l32_dsp_memory_disable(cs48l32, &cs48l32_dsp_sram_regs);
+		return 0;
+	default:
+		return 0;
+	}
+}
+
+static const struct snd_soc_dapm_widget cs48l32_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("SYSCLK", CS48L32_SYSTEM_CLOCK1, CS48L32_SYSCLK_EN_SHIFT, 0,
+		    cs48l32_sysclk_ev, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_SUPPLY("OPCLK", CS48L32_OUTPUT_SYS_CLK, CS48L32_OPCLK_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_REGULATOR_SUPPLY("VDD_CP", 20, 0),
+SND_SOC_DAPM_REGULATOR_SUPPLY("VOUT_MIC", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
+
+SND_SOC_DAPM_SUPPLY("MICBIAS1", CS48L32_MICBIAS_CTRL1, CS48L32_MICB1_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_SUPPLY("MICBIAS1A", CS48L32_MICBIAS_CTRL5, CS48L32_MICB1A_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS1B", CS48L32_MICBIAS_CTRL5, CS48L32_MICB1B_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_SUPPLY("MICBIAS1C", CS48L32_MICBIAS_CTRL5, CS48L32_MICB1C_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_SUPPLY("DSP1MEM", SND_SOC_NOPM, 0, 0, cs48l32_dsp_mem_ev,
+		    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+CS48L32_DSP_FREQ_WIDGET_EV("DSP1", 0, cs48l32_dsp_freq_ev),
+
+SND_SOC_DAPM_SIGGEN("TONE"),
+SND_SOC_DAPM_SIGGEN("NOISE"),
+
+SND_SOC_DAPM_INPUT("IN1LN_1"),
+SND_SOC_DAPM_INPUT("IN1LN_2"),
+SND_SOC_DAPM_INPUT("IN1LP_1"),
+SND_SOC_DAPM_INPUT("IN1LP_2"),
+SND_SOC_DAPM_INPUT("IN1RN_1"),
+SND_SOC_DAPM_INPUT("IN1RN_2"),
+SND_SOC_DAPM_INPUT("IN1RP_1"),
+SND_SOC_DAPM_INPUT("IN1RP_2"),
+SND_SOC_DAPM_INPUT("IN1_PDMCLK"),
+SND_SOC_DAPM_INPUT("IN1_PDMDATA"),
+
+SND_SOC_DAPM_INPUT("IN2_PDMCLK"),
+SND_SOC_DAPM_INPUT("IN2_PDMDATA"),
+
+SND_SOC_DAPM_MUX("Ultrasonic 1 Input", SND_SOC_NOPM, 0, 0, &cs48l32_us_inmux[0]),
+SND_SOC_DAPM_MUX("Ultrasonic 2 Input", SND_SOC_NOPM, 0, 0, &cs48l32_us_inmux[1]),
+
+SND_SOC_DAPM_OUTPUT("DRC1 Signal Activity"),
+SND_SOC_DAPM_OUTPUT("DRC2 Signal Activity"),
+
+SND_SOC_DAPM_OUTPUT("DSP Trigger Out"),
+
+SND_SOC_DAPM_MUX("IN1L Mux", SND_SOC_NOPM, 0, 0, &cs48l32_inmux[0]),
+SND_SOC_DAPM_MUX("IN1R Mux", SND_SOC_NOPM, 0, 0, &cs48l32_inmux[1]),
+
+SND_SOC_DAPM_MUX("IN1L Mode", SND_SOC_NOPM, 0, 0, &cs48l32_dmode_mux[0]),
+SND_SOC_DAPM_MUX("IN1R Mode", SND_SOC_NOPM, 0, 0, &cs48l32_dmode_mux[0]),
+
+SND_SOC_DAPM_AIF_OUT("ASP1TX1", NULL, 0, CS48L32_ASP1_ENABLES1, 0, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX2", NULL, 1, CS48L32_ASP1_ENABLES1, 1, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX3", NULL, 2, CS48L32_ASP1_ENABLES1, 2, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX4", NULL, 3, CS48L32_ASP1_ENABLES1, 3, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX5", NULL, 4, CS48L32_ASP1_ENABLES1, 4, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX6", NULL, 5, CS48L32_ASP1_ENABLES1, 5, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX7", NULL, 6, CS48L32_ASP1_ENABLES1, 6, 0),
+SND_SOC_DAPM_AIF_OUT("ASP1TX8", NULL, 7, CS48L32_ASP1_ENABLES1, 7, 0),
+
+SND_SOC_DAPM_AIF_OUT("ASP2TX1", NULL, 0, CS48L32_ASP2_ENABLES1, 0, 0),
+SND_SOC_DAPM_AIF_OUT("ASP2TX2", NULL, 1, CS48L32_ASP2_ENABLES1, 1, 0),
+SND_SOC_DAPM_AIF_OUT("ASP2TX3", NULL, 2, CS48L32_ASP2_ENABLES1, 2, 0),
+SND_SOC_DAPM_AIF_OUT("ASP2TX4", NULL, 3, CS48L32_ASP2_ENABLES1, 3, 0),
+
+SND_SOC_DAPM_SWITCH("AUXPDM1 Output", CS48L32_AUXPDM_CONTROL1, 0, 0, &cs48l32_auxpdm_switch[0]),
+SND_SOC_DAPM_SWITCH("AUXPDM2 Output", CS48L32_AUXPDM_CONTROL1, 1, 0, &cs48l32_auxpdm_switch[1]),
+
+SND_SOC_DAPM_MUX("AUXPDM1 Input", SND_SOC_NOPM, 0, 0, &cs48l32_auxpdm_inmux[0]),
+SND_SOC_DAPM_MUX("AUXPDM2 Input", SND_SOC_NOPM, 0, 0, &cs48l32_auxpdm_inmux[1]),
+
+SND_SOC_DAPM_MUX("AUXPDM1 Analog Input", SND_SOC_NOPM, 0, 0,
+		 &cs48l32_auxpdm_analog_inmux[0]),
+SND_SOC_DAPM_MUX("AUXPDM2 Analog Input", SND_SOC_NOPM, 0, 0,
+		 &cs48l32_auxpdm_analog_inmux[1]),
+
+SND_SOC_DAPM_SWITCH("Ultrasonic 1 Activity Detect", CS48L32_US_CONTROL,
+		    CS48L32_US1_DET_EN_SHIFT, 0, &cs48l32_us_switch[0]),
+SND_SOC_DAPM_SWITCH("Ultrasonic 2 Activity Detect", CS48L32_US_CONTROL,
+		    CS48L32_US1_DET_EN_SHIFT, 0, &cs48l32_us_switch[1]),
+
+/*
+ * mux_in widgets : arranged in the order of sources
+ * specified in CS48L32_MIXER_INPUT_ROUTES
+ */
+SND_SOC_DAPM_PGA("Tone Generator 1", CS48L32_TONE_GENERATOR1, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Tone Generator 2", CS48L32_TONE_GENERATOR1, 1, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("Noise Generator", CS48L32_COMFORT_NOISE_GENERATOR,
+		 CS48L32_NOISE_GEN_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA_E("IN1L PGA", CS48L32_INPUT_CONTROL, CS48L32_IN1L_EN_SHIFT,
+		   0, NULL, 0, cs48l32_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN1R PGA", CS48L32_INPUT_CONTROL, CS48L32_IN1R_EN_SHIFT,
+		   0, NULL, 0, cs48l32_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN2L PGA", CS48L32_INPUT_CONTROL, CS48L32_IN2L_EN_SHIFT,
+		   0, NULL, 0, cs48l32_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+SND_SOC_DAPM_PGA_E("IN2R PGA", CS48L32_INPUT_CONTROL, CS48L32_IN2R_EN_SHIFT,
+		   0, NULL, 0, cs48l32_in_ev,
+		   SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU),
+
+SND_SOC_DAPM_AIF_IN("ASP1RX1", NULL, 0, CS48L32_ASP1_ENABLES1, 16, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX2", NULL, 1, CS48L32_ASP1_ENABLES1, 17, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX3", NULL, 2, CS48L32_ASP1_ENABLES1, 18, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX4", NULL, 3, CS48L32_ASP1_ENABLES1, 19, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX5", NULL, 4, CS48L32_ASP1_ENABLES1, 20, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX6", NULL, 5, CS48L32_ASP1_ENABLES1, 21, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX7", NULL, 6, CS48L32_ASP1_ENABLES1, 22, 0),
+SND_SOC_DAPM_AIF_IN("ASP1RX8", NULL, 7, CS48L32_ASP1_ENABLES1, 23, 0),
+
+SND_SOC_DAPM_AIF_IN("ASP2RX1", NULL, 0, CS48L32_ASP2_ENABLES1, 16, 0),
+SND_SOC_DAPM_AIF_IN("ASP2RX2", NULL, 1, CS48L32_ASP2_ENABLES1, 17, 0),
+SND_SOC_DAPM_AIF_IN("ASP2RX3", NULL, 2, CS48L32_ASP2_ENABLES1, 18, 0),
+SND_SOC_DAPM_AIF_IN("ASP2RX4", NULL, 3, CS48L32_ASP2_ENABLES1, 19, 0),
+
+SND_SOC_DAPM_PGA("ISRC1DEC1", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_DEC1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC2", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_DEC2_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC3", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_DEC3_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1DEC4", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_DEC4_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC1INT1", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_INT1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT2", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_INT2_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT3", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_INT3_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC1INT4", CS48L32_ISRC1_CONTROL2, CS48L32_ISRC1_INT4_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC2DEC1", CS48L32_ISRC2_CONTROL2, CS48L32_ISRC1_DEC1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2DEC2", CS48L32_ISRC2_CONTROL2, CS48L32_ISRC1_DEC2_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC2INT1", CS48L32_ISRC2_CONTROL2, CS48L32_ISRC1_INT1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC2INT2", CS48L32_ISRC2_CONTROL2, CS48L32_ISRC1_INT2_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC3DEC1", CS48L32_ISRC3_CONTROL2, CS48L32_ISRC1_DEC1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC3DEC2", CS48L32_ISRC3_CONTROL2, CS48L32_ISRC1_DEC2_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("ISRC3INT1", CS48L32_ISRC3_CONTROL2, CS48L32_ISRC1_INT1_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("ISRC3INT2", CS48L32_ISRC3_CONTROL2, CS48L32_ISRC1_INT2_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA_E("EQ1", CS48L32_EQ_CONTROL1, 0, 0, NULL, 0, cs48l32_eq_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("EQ2", CS48L32_EQ_CONTROL1, 1, 0, NULL, 0, cs48l32_eq_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("EQ3", CS48L32_EQ_CONTROL1, 2, 0, NULL, 0, cs48l32_eq_ev, SND_SOC_DAPM_PRE_PMU),
+SND_SOC_DAPM_PGA_E("EQ4", CS48L32_EQ_CONTROL1, 3, 0, NULL, 0, cs48l32_eq_ev, SND_SOC_DAPM_PRE_PMU),
+
+SND_SOC_DAPM_PGA("DRC1L", CS48L32_DRC1_CONTROL1, CS48L32_DRC1L_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("DRC1R", CS48L32_DRC1_CONTROL1, CS48L32_DRC1R_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("DRC2L", CS48L32_DRC2_CONTROL1, CS48L32_DRC1L_EN_SHIFT, 0, NULL, 0),
+SND_SOC_DAPM_PGA("DRC2R", CS48L32_DRC2_CONTROL1, CS48L32_DRC1R_EN_SHIFT, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("LHPF1", CS48L32_LHPF_CONTROL1, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("LHPF2", CS48L32_LHPF_CONTROL1, 1, 0, NULL, 0),
+SND_SOC_DAPM_PGA("LHPF3", CS48L32_LHPF_CONTROL1, 2, 0, NULL, 0),
+SND_SOC_DAPM_PGA("LHPF4", CS48L32_LHPF_CONTROL1, 3, 0, NULL, 0),
+
+SND_SOC_DAPM_PGA("Ultrasonic 1", CS48L32_US_CONTROL, 0, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Ultrasonic 2", CS48L32_US_CONTROL, 1, 0, NULL, 0),
+
+WM_ADSP2("DSP1", 0, wm_adsp_early_event),
+
+/* end of ordered widget list */
+
+CS48L32_MIXER_WIDGETS(EQ1, "EQ1"),
+CS48L32_MIXER_WIDGETS(EQ2, "EQ2"),
+CS48L32_MIXER_WIDGETS(EQ3, "EQ3"),
+CS48L32_MIXER_WIDGETS(EQ4, "EQ4"),
+
+CS48L32_MIXER_WIDGETS(DRC1L, "DRC1L"),
+CS48L32_MIXER_WIDGETS(DRC1R, "DRC1R"),
+CS48L32_MIXER_WIDGETS(DRC2L, "DRC2L"),
+CS48L32_MIXER_WIDGETS(DRC2R, "DRC2R"),
+
+SND_SOC_DAPM_SWITCH("DRC1 Activity Output", SND_SOC_NOPM, 0, 0,
+		    &cs48l32_drc_activity_output_mux[0]),
+SND_SOC_DAPM_SWITCH("DRC2 Activity Output", SND_SOC_NOPM, 0, 0,
+		    &cs48l32_drc_activity_output_mux[1]),
+
+CS48L32_MIXER_WIDGETS(LHPF1, "LHPF1"),
+CS48L32_MIXER_WIDGETS(LHPF2, "LHPF2"),
+CS48L32_MIXER_WIDGETS(LHPF3, "LHPF3"),
+CS48L32_MIXER_WIDGETS(LHPF4, "LHPF4"),
+
+CS48L32_MIXER_WIDGETS(ASP1TX1, "ASP1TX1"),
+CS48L32_MIXER_WIDGETS(ASP1TX2, "ASP1TX2"),
+CS48L32_MIXER_WIDGETS(ASP1TX3, "ASP1TX3"),
+CS48L32_MIXER_WIDGETS(ASP1TX4, "ASP1TX4"),
+CS48L32_MIXER_WIDGETS(ASP1TX5, "ASP1TX5"),
+CS48L32_MIXER_WIDGETS(ASP1TX6, "ASP1TX6"),
+CS48L32_MIXER_WIDGETS(ASP1TX7, "ASP1TX7"),
+CS48L32_MIXER_WIDGETS(ASP1TX8, "ASP1TX8"),
+
+CS48L32_MIXER_WIDGETS(ASP2TX1, "ASP2TX1"),
+CS48L32_MIXER_WIDGETS(ASP2TX2, "ASP2TX2"),
+CS48L32_MIXER_WIDGETS(ASP2TX3, "ASP2TX3"),
+CS48L32_MIXER_WIDGETS(ASP2TX4, "ASP2TX4"),
+
+CS48L32_MUX_WIDGETS(ISRC1DEC1, "ISRC1DEC1"),
+CS48L32_MUX_WIDGETS(ISRC1DEC2, "ISRC1DEC2"),
+CS48L32_MUX_WIDGETS(ISRC1DEC3, "ISRC1DEC3"),
+CS48L32_MUX_WIDGETS(ISRC1DEC4, "ISRC1DEC4"),
+
+CS48L32_MUX_WIDGETS(ISRC1INT1, "ISRC1INT1"),
+CS48L32_MUX_WIDGETS(ISRC1INT2, "ISRC1INT2"),
+CS48L32_MUX_WIDGETS(ISRC1INT3, "ISRC1INT3"),
+CS48L32_MUX_WIDGETS(ISRC1INT4, "ISRC1INT4"),
+
+CS48L32_MUX_WIDGETS(ISRC2DEC1, "ISRC2DEC1"),
+CS48L32_MUX_WIDGETS(ISRC2DEC2, "ISRC2DEC2"),
+
+CS48L32_MUX_WIDGETS(ISRC2INT1, "ISRC2INT1"),
+CS48L32_MUX_WIDGETS(ISRC2INT2, "ISRC2INT2"),
+
+CS48L32_MUX_WIDGETS(ISRC3DEC1, "ISRC3DEC1"),
+CS48L32_MUX_WIDGETS(ISRC3DEC2, "ISRC3DEC2"),
+
+CS48L32_MUX_WIDGETS(ISRC3INT1, "ISRC3INT1"),
+CS48L32_MUX_WIDGETS(ISRC3INT2, "ISRC3INT2"),
+
+CS48L32_MIXER_WIDGETS(DSP1RX1, "DSP1RX1"),
+CS48L32_MIXER_WIDGETS(DSP1RX2, "DSP1RX2"),
+CS48L32_MIXER_WIDGETS(DSP1RX3, "DSP1RX3"),
+CS48L32_MIXER_WIDGETS(DSP1RX4, "DSP1RX4"),
+CS48L32_MIXER_WIDGETS(DSP1RX5, "DSP1RX5"),
+CS48L32_MIXER_WIDGETS(DSP1RX6, "DSP1RX6"),
+CS48L32_MIXER_WIDGETS(DSP1RX7, "DSP1RX7"),
+CS48L32_MIXER_WIDGETS(DSP1RX8, "DSP1RX8"),
+
+SND_SOC_DAPM_SWITCH("DSP1 Trigger Output", SND_SOC_NOPM, 0, 0,
+		    &cs48l32_dsp_trigger_output_mux[0]),
+
+SND_SOC_DAPM_OUTPUT("AUXPDM1_CLK"),
+SND_SOC_DAPM_OUTPUT("AUXPDM1_DOUT"),
+SND_SOC_DAPM_OUTPUT("AUXPDM2_CLK"),
+SND_SOC_DAPM_OUTPUT("AUXPDM2_DOUT"),
+
+SND_SOC_DAPM_OUTPUT("MICSUPP"),
+
+SND_SOC_DAPM_OUTPUT("Ultrasonic Dummy Output"),
+};
+
+#define CS48L32_MIXER_INPUT_ROUTES(name) \
+	{ name, "Tone Generator 1", "Tone Generator 1" }, \
+	{ name, "Tone Generator 2", "Tone Generator 2" }, \
+	{ name, "Noise Generator", "Noise Generator" }, \
+	{ name, "IN1L", "IN1L PGA" }, \
+	{ name, "IN1R", "IN1R PGA" }, \
+	{ name, "IN2L", "IN2L PGA" }, \
+	{ name, "IN2R", "IN2R PGA" }, \
+	{ name, "ASP1RX1", "ASP1RX1" }, \
+	{ name, "ASP1RX2", "ASP1RX2" }, \
+	{ name, "ASP1RX3", "ASP1RX3" }, \
+	{ name, "ASP1RX4", "ASP1RX4" }, \
+	{ name, "ASP1RX5", "ASP1RX5" }, \
+	{ name, "ASP1RX6", "ASP1RX6" }, \
+	{ name, "ASP1RX7", "ASP1RX7" }, \
+	{ name, "ASP1RX8", "ASP1RX8" }, \
+	{ name, "ASP2RX1", "ASP2RX1" }, \
+	{ name, "ASP2RX2", "ASP2RX2" }, \
+	{ name, "ASP2RX3", "ASP2RX3" }, \
+	{ name, "ASP2RX4", "ASP2RX4" }, \
+	{ name, "ISRC1DEC1", "ISRC1DEC1" }, \
+	{ name, "ISRC1DEC2", "ISRC1DEC2" }, \
+	{ name, "ISRC1DEC3", "ISRC1DEC3" }, \
+	{ name, "ISRC1DEC4", "ISRC1DEC4" }, \
+	{ name, "ISRC1INT1", "ISRC1INT1" }, \
+	{ name, "ISRC1INT2", "ISRC1INT2" }, \
+	{ name, "ISRC1INT3", "ISRC1INT3" }, \
+	{ name, "ISRC1INT4", "ISRC1INT4" }, \
+	{ name, "ISRC2DEC1", "ISRC2DEC1" }, \
+	{ name, "ISRC2DEC2", "ISRC2DEC2" }, \
+	{ name, "ISRC2INT1", "ISRC2INT1" }, \
+	{ name, "ISRC2INT2", "ISRC2INT2" }, \
+	{ name, "ISRC3DEC1", "ISRC3DEC1" }, \
+	{ name, "ISRC3DEC2", "ISRC3DEC2" }, \
+	{ name, "ISRC3INT1", "ISRC3INT1" }, \
+	{ name, "ISRC3INT2", "ISRC3INT2" }, \
+	{ name, "EQ1", "EQ1" }, \
+	{ name, "EQ2", "EQ2" }, \
+	{ name, "EQ3", "EQ3" }, \
+	{ name, "EQ4", "EQ4" }, \
+	{ name, "DRC1L", "DRC1L" }, \
+	{ name, "DRC1R", "DRC1R" }, \
+	{ name, "DRC2L", "DRC2L" }, \
+	{ name, "DRC2R", "DRC2R" }, \
+	{ name, "LHPF1", "LHPF1" }, \
+	{ name, "LHPF2", "LHPF2" }, \
+	{ name, "LHPF3", "LHPF3" }, \
+	{ name, "LHPF4", "LHPF4" }, \
+	{ name, "Ultrasonic 1", "Ultrasonic 1" }, \
+	{ name, "Ultrasonic 2", "Ultrasonic 2" }, \
+	{ name, "DSP1.1", "DSP1" }, \
+	{ name, "DSP1.2", "DSP1" }, \
+	{ name, "DSP1.3", "DSP1" }, \
+	{ name, "DSP1.4", "DSP1" }, \
+	{ name, "DSP1.5", "DSP1" }, \
+	{ name, "DSP1.6", "DSP1" }, \
+	{ name, "DSP1.7", "DSP1" }, \
+	{ name, "DSP1.8", "DSP1" }
+
+static const struct snd_soc_dapm_route cs48l32_dapm_routes[] = {
+	{ "OPCLK", NULL, "SYSCLK" },
+
+	{ "IN1LN_1", NULL, "SYSCLK" },
+	{ "IN1LN_2", NULL, "SYSCLK" },
+	{ "IN1LP_1", NULL, "SYSCLK" },
+	{ "IN1LP_2", NULL, "SYSCLK" },
+	{ "IN1RN_1", NULL, "SYSCLK" },
+	{ "IN1RN_2", NULL, "SYSCLK" },
+	{ "IN1RP_1", NULL, "SYSCLK" },
+	{ "IN1RP_2", NULL, "SYSCLK" },
+
+	{ "IN1_PDMCLK", NULL, "SYSCLK" },
+	{ "IN1_PDMDATA", NULL, "SYSCLK" },
+	{ "IN2_PDMCLK", NULL, "SYSCLK" },
+	{ "IN2_PDMDATA", NULL, "SYSCLK" },
+
+	{ "DSP1 Preloader", NULL, "DSP1MEM" },
+	{ "DSP1", NULL, "DSP1FREQ" },
+
+	{ "Audio Trace DSP", NULL, "DSP1" },
+	{ "Voice Ctrl DSP", NULL, "DSP1" },
+
+	{ "MICBIAS1", NULL, "VOUT_MIC" },
+
+	{ "MICBIAS1A", NULL, "MICBIAS1" },
+	{ "MICBIAS1B", NULL, "MICBIAS1" },
+	{ "MICBIAS1C", NULL, "MICBIAS1" },
+
+	{ "Tone Generator 1", NULL, "SYSCLK" },
+	{ "Tone Generator 2", NULL, "SYSCLK" },
+	{ "Noise Generator", NULL, "SYSCLK" },
+
+	{ "Tone Generator 1", NULL, "TONE" },
+	{ "Tone Generator 2", NULL, "TONE" },
+	{ "Noise Generator", NULL, "NOISE" },
+
+	{ "ASP1 Capture", NULL, "ASP1TX1" },
+	{ "ASP1 Capture", NULL, "ASP1TX2" },
+	{ "ASP1 Capture", NULL, "ASP1TX3" },
+	{ "ASP1 Capture", NULL, "ASP1TX4" },
+	{ "ASP1 Capture", NULL, "ASP1TX5" },
+	{ "ASP1 Capture", NULL, "ASP1TX6" },
+	{ "ASP1 Capture", NULL, "ASP1TX7" },
+	{ "ASP1 Capture", NULL, "ASP1TX8" },
+
+	{ "ASP1RX1", NULL, "ASP1 Playback" },
+	{ "ASP1RX2", NULL, "ASP1 Playback" },
+	{ "ASP1RX3", NULL, "ASP1 Playback" },
+	{ "ASP1RX4", NULL, "ASP1 Playback" },
+	{ "ASP1RX5", NULL, "ASP1 Playback" },
+	{ "ASP1RX6", NULL, "ASP1 Playback" },
+	{ "ASP1RX7", NULL, "ASP1 Playback" },
+	{ "ASP1RX8", NULL, "ASP1 Playback" },
+
+	{ "ASP2 Capture", NULL, "ASP2TX1" },
+	{ "ASP2 Capture", NULL, "ASP2TX2" },
+	{ "ASP2 Capture", NULL, "ASP2TX3" },
+	{ "ASP2 Capture", NULL, "ASP2TX4" },
+
+	{ "ASP2RX1", NULL, "ASP2 Playback" },
+	{ "ASP2RX2", NULL, "ASP2 Playback" },
+	{ "ASP2RX3", NULL, "ASP2 Playback" },
+	{ "ASP2RX4", NULL, "ASP2 Playback" },
+
+	{ "ASP1 Playback", NULL, "SYSCLK" },
+	{ "ASP2 Playback", NULL, "SYSCLK" },
+
+	{ "ASP1 Capture", NULL, "SYSCLK" },
+	{ "ASP2 Capture", NULL, "SYSCLK" },
+
+	{ "IN1L Mux", "Analog 1", "IN1LN_1" },
+	{ "IN1L Mux", "Analog 2", "IN1LN_2" },
+	{ "IN1L Mux", "Analog 1", "IN1LP_1" },
+	{ "IN1L Mux", "Analog 2", "IN1LP_2" },
+	{ "IN1R Mux", "Analog 1", "IN1RN_1" },
+	{ "IN1R Mux", "Analog 2", "IN1RN_2" },
+	{ "IN1R Mux", "Analog 1", "IN1RP_1" },
+	{ "IN1R Mux", "Analog 2", "IN1RP_2" },
+
+	{ "IN1L PGA", NULL, "IN1L Mode" },
+	{ "IN1R PGA", NULL, "IN1R Mode" },
+
+	{ "IN1L Mode", "Analog", "IN1L Mux" },
+	{ "IN1R Mode", "Analog", "IN1R Mux" },
+
+	{ "IN1L Mode", "Digital", "IN1_PDMCLK" },
+	{ "IN1L Mode", "Digital", "IN1_PDMDATA" },
+	{ "IN1R Mode", "Digital", "IN1_PDMCLK" },
+	{ "IN1R Mode", "Digital", "IN1_PDMDATA" },
+
+	{ "IN1L PGA", NULL, "VOUT_MIC" },
+	{ "IN1R PGA", NULL, "VOUT_MIC" },
+
+	{ "IN2L PGA", NULL, "VOUT_MIC" },
+	{ "IN2R PGA", NULL, "VOUT_MIC" },
+
+	{ "IN2L PGA", NULL, "IN2_PDMCLK" },
+	{ "IN2R PGA", NULL, "IN2_PDMCLK" },
+	{ "IN2L PGA", NULL, "IN2_PDMDATA" },
+	{ "IN2R PGA", NULL, "IN2_PDMDATA" },
+
+	{ "Ultrasonic 1", NULL, "Ultrasonic 1 Input" },
+	{ "Ultrasonic 2", NULL, "Ultrasonic 2 Input" },
+
+	{ "Ultrasonic 1 Input", "IN1L", "IN1L PGA" },
+	{ "Ultrasonic 1 Input", "IN1R", "IN1R PGA" },
+	{ "Ultrasonic 1 Input", "IN2L", "IN2L PGA" },
+	{ "Ultrasonic 1 Input", "IN2R", "IN2R PGA" },
+
+	{ "Ultrasonic 2 Input", "IN1L", "IN1L PGA" },
+	{ "Ultrasonic 2 Input", "IN1R", "IN1R PGA" },
+	{ "Ultrasonic 2 Input", "IN2L", "IN2L PGA" },
+	{ "Ultrasonic 2 Input", "IN2R", "IN2R PGA" },
+
+	{ "Ultrasonic 1 Activity Detect", "Switch", "Ultrasonic 1 Input" },
+	{ "Ultrasonic 2 Activity Detect", "Switch", "Ultrasonic 2 Input" },
+
+	{ "Ultrasonic Dummy Output", NULL, "Ultrasonic 1 Activity Detect" },
+	{ "Ultrasonic Dummy Output", NULL, "Ultrasonic 2 Activity Detect" },
+
+	CS48L32_MIXER_ROUTES("ASP1TX1", "ASP1TX1"),
+	CS48L32_MIXER_ROUTES("ASP1TX2", "ASP1TX2"),
+	CS48L32_MIXER_ROUTES("ASP1TX3", "ASP1TX3"),
+	CS48L32_MIXER_ROUTES("ASP1TX4", "ASP1TX4"),
+	CS48L32_MIXER_ROUTES("ASP1TX5", "ASP1TX5"),
+	CS48L32_MIXER_ROUTES("ASP1TX6", "ASP1TX6"),
+	CS48L32_MIXER_ROUTES("ASP1TX7", "ASP1TX7"),
+	CS48L32_MIXER_ROUTES("ASP1TX8", "ASP1TX8"),
+
+	CS48L32_MIXER_ROUTES("ASP2TX1", "ASP2TX1"),
+	CS48L32_MIXER_ROUTES("ASP2TX2", "ASP2TX2"),
+	CS48L32_MIXER_ROUTES("ASP2TX3", "ASP2TX3"),
+	CS48L32_MIXER_ROUTES("ASP2TX4", "ASP2TX4"),
+
+	CS48L32_MIXER_ROUTES("EQ1", "EQ1"),
+	CS48L32_MIXER_ROUTES("EQ2", "EQ2"),
+	CS48L32_MIXER_ROUTES("EQ3", "EQ3"),
+	CS48L32_MIXER_ROUTES("EQ4", "EQ4"),
+
+	CS48L32_MIXER_ROUTES("DRC1L", "DRC1L"),
+	CS48L32_MIXER_ROUTES("DRC1R", "DRC1R"),
+	CS48L32_MIXER_ROUTES("DRC2L", "DRC2L"),
+	CS48L32_MIXER_ROUTES("DRC2R", "DRC2R"),
+
+	CS48L32_MIXER_ROUTES("LHPF1", "LHPF1"),
+	CS48L32_MIXER_ROUTES("LHPF2", "LHPF2"),
+	CS48L32_MIXER_ROUTES("LHPF3", "LHPF3"),
+	CS48L32_MIXER_ROUTES("LHPF4", "LHPF4"),
+
+	CS48L32_MUX_ROUTES("ISRC1INT1", "ISRC1INT1"),
+	CS48L32_MUX_ROUTES("ISRC1INT2", "ISRC1INT2"),
+	CS48L32_MUX_ROUTES("ISRC1INT3", "ISRC1INT3"),
+	CS48L32_MUX_ROUTES("ISRC1INT4", "ISRC1INT4"),
+
+	CS48L32_MUX_ROUTES("ISRC1DEC1", "ISRC1DEC1"),
+	CS48L32_MUX_ROUTES("ISRC1DEC2", "ISRC1DEC2"),
+	CS48L32_MUX_ROUTES("ISRC1DEC3", "ISRC1DEC3"),
+	CS48L32_MUX_ROUTES("ISRC1DEC4", "ISRC1DEC4"),
+
+	CS48L32_MUX_ROUTES("ISRC2INT1", "ISRC2INT1"),
+	CS48L32_MUX_ROUTES("ISRC2INT2", "ISRC2INT2"),
+
+	CS48L32_MUX_ROUTES("ISRC2DEC1", "ISRC2DEC1"),
+	CS48L32_MUX_ROUTES("ISRC2DEC2", "ISRC2DEC2"),
+
+	CS48L32_MUX_ROUTES("ISRC3INT1", "ISRC3INT1"),
+	CS48L32_MUX_ROUTES("ISRC3INT2", "ISRC3INT2"),
+
+	CS48L32_MUX_ROUTES("ISRC3DEC1", "ISRC3DEC1"),
+	CS48L32_MUX_ROUTES("ISRC3DEC2", "ISRC3DEC2"),
+
+	CS48L32_DSP_ROUTES_1_8_SYSCLK("DSP1"),
+
+	{ "DSP Trigger Out", NULL, "DSP1 Trigger Output" },
+
+	{ "DSP1 Trigger Output", "Switch", "DSP1" },
+
+	{ "AUXPDM1 Analog Input", "IN1L", "IN1L PGA" },
+	{ "AUXPDM1 Analog Input", "IN1R", "IN1R PGA" },
+
+	{ "AUXPDM2 Analog Input", "IN1L", "IN1L PGA" },
+	{ "AUXPDM2 Analog Input", "IN1R", "IN1R PGA" },
+
+	{ "AUXPDM1 Input", "Analog", "AUXPDM1 Analog Input" },
+	{ "AUXPDM1 Input", "IN1 Digital", "IN1L PGA" },
+	{ "AUXPDM1 Input", "IN1 Digital", "IN1R PGA" },
+	{ "AUXPDM1 Input", "IN2 Digital", "IN2L PGA" },
+	{ "AUXPDM1 Input", "IN2 Digital", "IN2R PGA" },
+
+	{ "AUXPDM2 Input", "Analog", "AUXPDM2 Analog Input" },
+	{ "AUXPDM2 Input", "IN1 Digital", "IN1L PGA" },
+	{ "AUXPDM2 Input", "IN1 Digital", "IN1R PGA" },
+	{ "AUXPDM2 Input", "IN2 Digital", "IN2L PGA" },
+	{ "AUXPDM2 Input", "IN2 Digital", "IN2R PGA" },
+
+	{ "AUXPDM1 Output", "Switch", "AUXPDM1 Input" },
+	{ "AUXPDM1_CLK", NULL, "AUXPDM1 Output" },
+	{ "AUXPDM1_DOUT", NULL, "AUXPDM1 Output" },
+
+	{ "AUXPDM2 Output", "Switch", "AUXPDM2 Input" },
+	{ "AUXPDM2_CLK", NULL, "AUXPDM2 Output" },
+	{ "AUXPDM2_DOUT", NULL, "AUXPDM2 Output" },
+
+	{ "MICSUPP", NULL, "SYSCLK" },
+
+	{ "DRC1 Signal Activity", NULL, "DRC1 Activity Output" },
+	{ "DRC2 Signal Activity", NULL, "DRC2 Activity Output" },
+	{ "DRC1 Activity Output", "Switch", "DRC1L" },
+	{ "DRC1 Activity Output", "Switch", "DRC1R" },
+	{ "DRC2 Activity Output", "Switch", "DRC2L" },
+	{ "DRC2 Activity Output", "Switch", "DRC2R" },
+};
+
+static struct snd_soc_dai_driver cs48l32_dai[] = {
+	{
+		.name = "cs48l32-asp1",
+		.id = 1,
+		.base = CS48L32_ASP1_ENABLES1,
+		.playback = {
+			.stream_name = "ASP1 Playback",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASP1 Capture",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		 },
+		.ops = &cs48l32_dai_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+	{
+		.name = "cs48l32-asp2",
+		.id = 2,
+		.base = CS48L32_ASP2_ENABLES1,
+		.playback = {
+			.stream_name = "ASP2 Playback",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+		.capture = {
+			.stream_name = "ASP2 Capture",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		 },
+		.ops = &cs48l32_dai_ops,
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
+	},
+	{
+		.name = "cs48l32-cpu-trace",
+		.id = 3,
+		.capture = {
+			.stream_name = "Audio Trace CPU",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+		.compress_new = &snd_soc_new_compress,
+	},
+	{
+		.name = "cs48l32-dsp-trace",
+		.id = 4,
+		.capture = {
+			.stream_name = "Audio Trace DSP",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+	},
+	{
+		.name = "cs48l32-cpu-voicectrl",
+		.id = 5,
+		.capture = {
+			.stream_name = "Voice Ctrl CPU",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+		.compress_new = &snd_soc_new_compress,
+	},
+	{
+		.name = "cs48l32-dsp-voicectrl",
+		.id = 6,
+		.capture = {
+			.stream_name = "Voice Ctrl DSP",
+			.channels_min = 1,
+			.channels_max = 8,
+			.rates = CS48L32_RATES,
+			.formats = CS48L32_FORMATS,
+		},
+	},
+};
+
+static int cs48l32_compr_open(struct snd_soc_component *component,
+			      struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+
+	if (strcmp(asoc_rtd_to_codec(rtd, 0)->name, "cs48l32-dsp-trace") &&
+	    strcmp(asoc_rtd_to_codec(rtd, 0)->name, "cs48l32-dsp-voicectrl")) {
+		dev_err(cs48l32->dev, "No suitable compressed stream for DAI '%s'\n",
+			asoc_rtd_to_codec(rtd, 0)->name);
+		return -EINVAL;
+	}
+
+	return wm_adsp_compr_open(&cs48l32->dsp, stream);
+}
+
+static int cs48l32_component_probe(struct snd_soc_component *component)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	snd_soc_component_init_regmap(component, cs48l32->mfd->regmap);
+	cs48l32->mfd->dapm = snd_soc_component_get_dapm(component);
+
+	ret = cs48l32_init_inputs(component);
+	if (ret)
+		return ret;
+
+	ret = cs48l32_init_eq(cs48l32);
+	if (ret)
+		return ret;
+
+	wm_adsp2_component_probe(&cs48l32->dsp, component);
+
+	return 0;
+}
+
+static void cs48l32_component_remove(struct snd_soc_component *component)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+
+	wm_adsp2_component_remove(&cs48l32->dsp, component);
+	cs48l32->mfd->dapm = NULL;
+}
+
+static int cs48l32_set_fll(struct snd_soc_component *component, int fll_id,
+			   int source, unsigned int fref, unsigned int fout)
+{
+	struct cs48l32 *cs48l32 = snd_soc_component_get_drvdata(component);
+
+	switch (fll_id) {
+	case CS48L32_FLL1_REFCLK:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return cs48l32_fllhj_set_refclk(&cs48l32->fll, source, fref, fout);
+}
+
+static const struct snd_compress_ops cs48l32_compress_ops = {
+	.open = &cs48l32_compr_open,
+	.free = &wm_adsp_compr_free,
+	.set_params = &wm_adsp_compr_set_params,
+	.get_caps = &wm_adsp_compr_get_caps,
+	.trigger = &wm_adsp_compr_trigger,
+	.pointer = &wm_adsp_compr_pointer,
+	.copy = &wm_adsp_compr_copy,
+};
+
+static const struct snd_soc_component_driver soc_component_dev_cs48l32 = {
+	.probe			= &cs48l32_component_probe,
+	.remove			= &cs48l32_component_remove,
+	.set_sysclk		= &cs48l32_set_sysclk,
+	.set_pll		= &cs48l32_set_fll,
+	.name			= "cs48l32-codec",
+	.compress_ops		= &cs48l32_compress_ops,
+	.controls		= cs48l32_snd_controls,
+	.num_controls		= ARRAY_SIZE(cs48l32_snd_controls),
+	.dapm_widgets		= cs48l32_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(cs48l32_dapm_widgets),
+	.dapm_routes		= cs48l32_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(cs48l32_dapm_routes),
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static const struct {
+	int id;
+	bool wake_source;
+	const char * const name;
+	irq_handler_t handler;
+} cs48l32_interrupts[] = {
+	{ CS48L32_IRQ_US1_ACT_DET_RISE, false, "US1 activity", cs48l32_us1_activity },
+	{ CS48L32_IRQ_US2_ACT_DET_RISE, false, "US2 activity", cs48l32_us2_activity },
+	{ CS48L32_IRQ_DSP1_IRQ0, true, "DSP1 Buffer IRQ", cs48l32_dsp1_irq },
+	{ CS48L32_IRQ_DSP1_MPU_ERR, false, "DSP1 MPU", wm_halo_bus_error },
+	{ CS48L32_IRQ_DSP1_WDT_EXPIRE, false, "DSP1 WDT", wm_halo_wdt_expire },
+};
+
+static void cs48l32_free_interrupts(struct cs48l32 *cs48l32, int num)
+{
+	for (--num; num >= 0; --num) {
+		cs48l32_free_irq(cs48l32->mfd, cs48l32_interrupts[num].id, cs48l32);
+		if (cs48l32_interrupts[num].wake_source)
+			cs48l32_set_irq_wake(cs48l32->mfd, cs48l32_interrupts[num].id, 0);
+	}
+}
+
+static int cs48l32_request_interrupts(struct cs48l32 *cs48l32)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs48l32_interrupts); ++i) {
+		ret = cs48l32_request_irq(cs48l32->mfd,
+					  cs48l32_interrupts[i].id,
+					  cs48l32_interrupts[i].name,
+					  cs48l32_interrupts[i].handler,
+					  cs48l32);
+		if (ret != 0)
+			goto err;
+
+		if (cs48l32_interrupts[i].wake_source) {
+			ret = cs48l32_set_irq_wake(cs48l32->mfd, cs48l32_interrupts[i].id, 1);
+			if (ret)
+				dev_warn(cs48l32->dev, "Failed to set %s wake: %d\n",
+					 cs48l32_interrupts[i].name, ret);
+		}
+	}
+
+	return 0;
+err:
+	dev_err_probe(cs48l32->dev, ret, "Failed to get %s IRQ\n", cs48l32_interrupts[i].name);
+	cs48l32_free_interrupts(cs48l32, i);
+
+	return ret;
+}
+
+static int cs48l32_probe(struct platform_device *pdev)
+{
+	struct cs48l32_mfd *mfd = dev_get_drvdata(pdev->dev.parent);
+	struct cs48l32 *cs48l32;
+	struct wm_adsp *dsp;
+	int i, ret;
+
+	BUILD_BUG_ON(offsetof(struct cs48l32, dsp) != 0);
+	BUILD_BUG_ON(ARRAY_SIZE(cs48l32_dai) > CS48L32_MAX_DAI);
+
+	/* quick exit if irqchip driver hasn't completed probe */
+	if (!mfd->irq_dev) {
+		dev_dbg(&pdev->dev, "irqchip driver not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	cs48l32 = devm_kzalloc(&pdev->dev, sizeof(struct cs48l32), GFP_KERNEL);
+	if (!cs48l32)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cs48l32);
+	pdev->dev.of_node = of_node_get(mfd->dev->of_node);
+
+	cs48l32->mfd = mfd;
+	cs48l32->dev = &pdev->dev;
+	cs48l32->max_analogue_inputs = 1;
+	cs48l32->max_pdm_sup = 2;
+	cs48l32->in_vu_reg = CS48L32_INPUT_CONTROL3;
+
+	ret = cs48l32_core_init(cs48l32);
+	if (ret)
+		return ret;
+
+	ret = cs48l32_request_interrupts(cs48l32);
+	if (ret)
+		goto err;
+
+	dsp = &cs48l32->dsp;
+
+	switch (mfd->part) {
+	case 0x31:
+		dsp->part = "cs48l31";
+		break;
+	case 0x32:
+		dsp->part = "cs48l32";
+		break;
+	case 0x33:
+		dsp->part = "cs48l33";
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+	dsp->cs_dsp.num = 1;
+	dsp->cs_dsp.type = WMFW_HALO;
+	dsp->cs_dsp.rev = 0;
+	dsp->cs_dsp.dev = mfd->dev;
+	dsp->cs_dsp.regmap = mfd->regmap;
+
+	dsp->cs_dsp.base = CS48L32_DSP1_CLOCK_FREQ;
+	dsp->cs_dsp.base_sysinfo = CS48L32_DSP1_SYS_INFO_ID;
+
+	dsp->cs_dsp.mem = cs48l32_dsp1_regions;
+	dsp->cs_dsp.num_mems = ARRAY_SIZE(cs48l32_dsp1_regions);
+	dsp->pre_run = cs48l32_dsp_pre_run;
+
+	ret = wm_halo_init(dsp);
+	if (ret != 0)
+		goto err;
+
+	cs48l32->fll.cs48l32 = cs48l32;
+	cs48l32->fll.id = 1;
+	cs48l32->fll.base = CS48L32_FLL1_CONTROL1;
+	cs48l32->fll.sts_addr = CS48L32_IRQ1_STS_6;
+	cs48l32->fll.sts_mask = CS48L32_FLL1_LOCK_STS1_MASK;
+	cs48l32->fll.has_lp = 1;
+	cs48l32_init_fll(&cs48l32->fll);
+
+	for (i = 0; i < ARRAY_SIZE(cs48l32_dai); i++)
+		cs48l32_init_dai(cs48l32, i);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_idle(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &soc_component_dev_cs48l32,
+					      cs48l32_dai,
+					      ARRAY_SIZE(cs48l32_dai));
+	if (ret < 0) {
+		dev_err_probe(&pdev->dev, ret, "Failed to register component\n");
+		goto err_dsp;
+	}
+
+	return ret;
+err_dsp:
+	wm_adsp2_remove(&cs48l32->dsp);
+err:
+	cs48l32_core_destroy(cs48l32);
+
+	return ret;
+}
+
+static int cs48l32_remove(struct platform_device *pdev)
+{
+	struct cs48l32 *cs48l32 = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+
+	cs48l32_free_interrupts(cs48l32, ARRAY_SIZE(cs48l32_interrupts));
+	wm_adsp2_remove(&cs48l32->dsp);
+
+	cs48l32_core_destroy(cs48l32);
+
+	return 0;
+}
+
+static struct platform_driver cs48l32_codec_driver = {
+	.driver = {
+		.name = "cs48l32-codec",
+	},
+	.probe = &cs48l32_probe,
+	.remove = &cs48l32_remove,
+};
+
+module_platform_driver(cs48l32_codec_driver);
+
+MODULE_SOFTDEP("pre: cs48l32 irq-cirrus-cs48l32 arizona-micsupp");
+MODULE_DESCRIPTION("ASoC CS48L32 driver");
+MODULE_AUTHOR("Stuart Henderson <stuarth@opensource.cirrus.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cs48l32-codec");
diff --git a/sound/soc/codecs/cs48l32.h b/sound/soc/codecs/cs48l32.h
new file mode 100644
index 000000000000..7cbd85077902
--- /dev/null
+++ b/sound/soc/codecs/cs48l32.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Cirrus Logic CS48L32 codec core support
+ *
+ * Copyright (C) 2016-2018, 2022 Cirrus Logic, Inc. and
+ *               Cirrus Logic International Semiconductor Ltd.
+ */
+
+#ifndef ASOC_CS48L32_H
+#define ASOC_CS48L32_H
+
+#include <linux/mfd/cs48l32/core.h>
+#include <sound/cs48l32.h>
+#include <sound/soc.h>
+
+#include "wm_adsp.h"
+
+#define CS48L32_PDMCLK_SRC_IN1_PDMCLK		0x0
+#define CS48L32_PDMCLK_SRC_IN2_PDMCLK		0x1
+#define CS48L32_PDMCLK_SRC_IN3_PDMCLK		0x2
+#define CS48L32_PDMCLK_SRC_IN4_PDMCLK		0x3
+#define CS48L32_PDMCLK_SRC_AUXPDM1_CLK		0x8
+#define CS48L32_PDMCLK_SRC_AUXPDM2_CLK		0x9
+
+#define CS48L32_MAX_DAI				12
+#define CS48L32_MAX_INPUT			4
+#define CS48L32_MAX_MUXED_IN_CHANNELS		4
+#define CS48L32_MAX_ASP				2
+
+#define CS48L32_NUM_MIXER_INPUTS		58
+
+#define CS48L32_EQ_BLOCK_SZ			60
+#define CS48L32_N_EQ_BLOCKS			4
+
+#define CS48L32_DSP_N_RX_CHANNELS		8
+#define CS48L32_DSP_N_TX_CHANNELS		8
+
+#define CS48L32_SAMPLE_RATE_ENUM_SIZE		17
+
+#define CS48L32_MIXER_CONTROLS(name, base) \
+	SOC_SINGLE_RANGE_TLV(name " Input 1 Volume", base,		\
+			     CS48L32_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     cs48l32_mixer_tlv),				\
+	SOC_SINGLE_RANGE_TLV(name " Input 2 Volume", base + 4,		\
+			     CS48L32_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     cs48l32_mixer_tlv),				\
+	SOC_SINGLE_RANGE_TLV(name " Input 3 Volume", base + 8,		\
+			     CS48L32_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     cs48l32_mixer_tlv),				\
+	SOC_SINGLE_RANGE_TLV(name " Input 4 Volume", base + 12,		\
+			     CS48L32_MIXER_VOL_SHIFT, 0x20, 0x50, 0,	\
+			     cs48l32_mixer_tlv)
+
+#define CS48L32_MUX_ENUM_DECL(name, reg) \
+	SOC_VALUE_ENUM_SINGLE_DECL( \
+		name, reg, 0, CS48L32_MIXER_SRC_MASK, \
+		cs48l32_mixer_texts, cs48l32_mixer_values)
+
+#define CS48L32_MUX_CTL_DECL(name) \
+	const struct snd_kcontrol_new name##_mux = SOC_DAPM_ENUM("Route", name##_enum)
+
+#define CS48L32_MUX_ENUMS(name, base_reg) \
+	static CS48L32_MUX_ENUM_DECL(name##_enum, base_reg);	\
+	static CS48L32_MUX_CTL_DECL(name)
+
+#define CS48L32_MIXER_ENUMS(name, base_reg) \
+	CS48L32_MUX_ENUMS(name##_in1, base_reg);     \
+	CS48L32_MUX_ENUMS(name##_in2, base_reg + 4); \
+	CS48L32_MUX_ENUMS(name##_in3, base_reg + 8); \
+	CS48L32_MUX_ENUMS(name##_in4, base_reg + 12)
+
+#define CS48L32_MUX(name, ctrl) SND_SOC_DAPM_MUX(name, SND_SOC_NOPM, 0, 0, ctrl)
+
+#define CS48L32_MUX_WIDGETS(name, name_str) CS48L32_MUX(name_str " Input 1", &name##_mux)
+
+#define CS48L32_MIXER_WIDGETS(name, name_str)	\
+	CS48L32_MUX(name_str " Input 1", &name##_in1_mux), \
+	CS48L32_MUX(name_str " Input 2", &name##_in2_mux), \
+	CS48L32_MUX(name_str " Input 3", &name##_in3_mux), \
+	CS48L32_MUX(name_str " Input 4", &name##_in4_mux), \
+	SND_SOC_DAPM_MIXER(name_str " Mixer", SND_SOC_NOPM, 0, 0, NULL, 0)
+
+#define CS48L32_MUX_ROUTES(widget, name) \
+	{ widget, NULL, name " Input 1" }, \
+	CS48L32_MIXER_INPUT_ROUTES(name " Input 1")
+
+#define CS48L32_MIXER_ROUTES(widget, name)		\
+	{ widget, NULL, name " Mixer" },		\
+	{ name " Mixer", NULL, name " Input 1" },	\
+	{ name " Mixer", NULL, name " Input 2" },	\
+	{ name " Mixer", NULL, name " Input 3" },	\
+	{ name " Mixer", NULL, name " Input 4" },	\
+	CS48L32_MIXER_INPUT_ROUTES(name " Input 1"),	\
+	CS48L32_MIXER_INPUT_ROUTES(name " Input 2"),	\
+	CS48L32_MIXER_INPUT_ROUTES(name " Input 3"),	\
+	CS48L32_MIXER_INPUT_ROUTES(name " Input 4")
+
+#define CS48L32_DSP_ROUTES_1_8_SYSCLK(name)		\
+	{ name, NULL, name " Preloader" },		\
+	{ name, NULL, "SYSCLK" },		\
+	{ name " Preload", NULL, name " Preloader" },	\
+	CS48L32_MIXER_ROUTES(name, name "RX1"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX2"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX3"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX4"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX5"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX6"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX7"),		\
+	CS48L32_MIXER_ROUTES(name, name "RX8")		\
+
+#define CS48L32_DSP_ROUTES_1_8(name)			\
+	{ name, NULL, "DSPCLK" },		\
+	CS48L32_DSP_ROUTES_1_8_SYSCLK(name)		\
+
+#define CS48L32_RATE_CONTROL(name, domain) SOC_ENUM(name, cs48l32_sample_rate[(domain) - 1])
+
+#define CS48L32_RATE_ENUM(name, enum) \
+	SOC_ENUM_EXT(name, enum, snd_soc_get_enum_double, cs48l32_rate_put)
+
+#define CS48L32_DSP_RATE_CONTROL(name, num)			\
+	SOC_ENUM_EXT(name " Rate", cs48l32_dsp_rate_enum[num],	\
+		     cs48l32_dsp_rate_get, cs48l32_dsp_rate_put)
+
+#define CS48L32_EQ_COEFF_CONTROL(xname, xreg, xbase, xshift)	\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
+	.info = cs48l32_eq_coeff_info, .get = cs48l32_eq_coeff_get,	\
+	.put = cs48l32_eq_coeff_put, .private_value =		\
+	(unsigned long)&(struct cs48l32_eq_control) { .reg = xreg,\
+	.shift = xshift, .block_base = xbase, .max = 65535 } }
+
+#define CS48L32_EQ_REG_NAME_PASTER(eq, band, type) \
+	CS48L32_ ## eq ## _ ## band ## _ ## type
+
+#define CS48L32_EQ_BAND_COEFF_CONTROLS(name, band)		\
+	CS48L32_EQ_COEFF_CONTROL(#name " " #band " A",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, band, COEFF1),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		0),				\
+	CS48L32_EQ_COEFF_CONTROL(#name " " #band " B",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, band, COEFF1),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		16),				\
+	CS48L32_EQ_COEFF_CONTROL(#name " " #band " C",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, band, COEFF2),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		0),				\
+	CS48L32_EQ_COEFF_CONTROL(#name " " #band " PG",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, band, PG),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		0)
+
+#define CS48L32_EQ_COEFF_CONTROLS(name)				\
+	CS48L32_EQ_BAND_COEFF_CONTROLS(name, BAND1),		\
+	CS48L32_EQ_BAND_COEFF_CONTROLS(name, BAND2),		\
+	CS48L32_EQ_BAND_COEFF_CONTROLS(name, BAND3),		\
+	CS48L32_EQ_BAND_COEFF_CONTROLS(name, BAND4),		\
+	CS48L32_EQ_COEFF_CONTROL(#name " BAND5 A",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND5, COEFF1),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		0),				\
+	CS48L32_EQ_COEFF_CONTROL(#name " BAND5 B",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND5, COEFF1),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		16),				\
+	CS48L32_EQ_COEFF_CONTROL(#name " BAND5 PG",		\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND5, PG),	\
+		CS48L32_EQ_REG_NAME_PASTER(name, BAND1, COEFF1),	\
+		0)
+
+#define CS48L32_LHPF_CONTROL(xname, xbase)			\
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
+	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get,	\
+	.put = cs48l32_lhpf_coeff_put, .private_value =		\
+	((unsigned long)&(struct soc_bytes) { .base = xbase,	\
+	 .num_regs = 1 }) }
+
+/* these have a subseq number so they run after SYSCLK and DSPCLK widgets */
+#define CS48L32_DSP_FREQ_WIDGET_EV(name, num, event)			\
+	SND_SOC_DAPM_SUPPLY_S(name "FREQ", 100, SND_SOC_NOPM, num, 0,	\
+			      event, SND_SOC_DAPM_POST_PMU)
+
+#define CS48L32_RATES SNDRV_PCM_RATE_KNOT
+
+#define CS48L32_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+struct cs48l32_dai_priv {
+	int clk;
+	struct snd_pcm_hw_constraint_list constraint;
+};
+
+struct cs48l32_dsp_power_reg_block {
+	unsigned int start;
+	unsigned int end;
+};
+
+struct cs48l32_dsp_power_regs {
+	const unsigned int *pwd;
+	unsigned int n_pwd;
+	const struct cs48l32_dsp_power_reg_block *ext;
+	unsigned int n_ext;
+};
+
+struct cs48l32;
+
+struct cs48l32_fll_cfg {
+	int n;
+	unsigned int theta;
+	unsigned int lambda;
+	int refdiv;
+	int fratio;
+	int gain;
+	int alt_gain;
+};
+
+struct cs48l32_fll {
+	struct cs48l32 *cs48l32;
+	int id;
+	unsigned int base;
+
+	unsigned int sts_addr;
+	unsigned int sts_mask;
+
+	unsigned int fout;
+
+	int ref_src;
+	unsigned int ref_freq;
+	struct cs48l32_fll_cfg ref_cfg;
+
+	unsigned int max_fref;
+
+	unsigned int integer_only:1;
+	unsigned int has_lp:1;
+};
+
+struct cs48l32 {
+	struct wm_adsp dsp;
+	struct cs48l32_mfd *mfd;
+	struct device *dev;
+	int sysclk;
+	int dspclk;
+	struct cs48l32_dai_priv dai[CS48L32_MAX_DAI];
+	struct cs48l32_fll fll;
+
+	int max_analogue_inputs;
+	int max_pdm_sup;
+	int num_dmic_clksrc;
+	u32 max_channels_clocked[CS48L32_MAX_ASP];
+	u32 pdm_sup[CS48L32_MAX_INPUT];
+	u32 in_type[CS48L32_MAX_INPUT][CS48L32_MAX_MUXED_IN_CHANNELS];
+
+	unsigned int in_up_pending;
+	unsigned int in_vu_reg;
+
+	struct mutex rate_lock;
+
+	u8 dsp_dma_rates[CS48L32_DSP_N_RX_CHANNELS + CS48L32_DSP_N_TX_CHANNELS];
+
+	int tdm_width[CS48L32_MAX_ASP];
+	int tdm_slots[CS48L32_MAX_ASP];
+
+	unsigned int eq_mode[CS48L32_N_EQ_BLOCKS];
+	__be16 eq_coefficients[CS48L32_N_EQ_BLOCKS][CS48L32_EQ_BLOCK_SZ / 2];
+
+	const struct cs48l32_dsp_power_regs *dsp_power_regs;
+};
+
+struct cs48l32_enum {
+	struct soc_enum mixer_enum;
+	int val;
+};
+
+struct cs48l32_eq_control {
+	unsigned int reg;
+	unsigned int shift;
+	unsigned int block_base;
+	unsigned int max;
+};
+
+extern const char * const cs48l32_mixer_texts[CS48L32_NUM_MIXER_INPUTS];
+extern unsigned int cs48l32_mixer_values[CS48L32_NUM_MIXER_INPUTS];
+
+extern const unsigned int cs48l32_ana_tlv[];
+extern const unsigned int cs48l32_eq_tlv[];
+extern const unsigned int cs48l32_digital_tlv[];
+extern const unsigned int cs48l32_noise_tlv[];
+extern const unsigned int cs48l32_mixer_tlv[];
+extern const unsigned int cs48l32_us_tlv[];
+
+int cs48l32_rate_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+
+extern const struct soc_enum cs48l32_sample_rate[];
+
+extern const struct snd_kcontrol_new cs48l32_inmux[];
+extern const struct snd_kcontrol_new cs48l32_dmode_mux[];
+
+extern const struct soc_enum cs48l32_us_freq[];
+extern const struct snd_kcontrol_new cs48l32_us_inmux[];
+extern const struct soc_enum cs48l32_us_output_rate[];
+extern const struct soc_enum cs48l32_us_det_lpf_cut[];
+extern const struct soc_enum cs48l32_us_det_dcy[];
+extern const struct snd_kcontrol_new cs48l32_us_switch[];
+extern const struct soc_enum cs48l32_us_det_thr[];
+extern const struct soc_enum cs48l32_us_det_num[];
+extern const struct soc_enum cs48l32_us_det_hold[];
+
+extern const struct soc_enum cs48l32_in_vi_ramp;
+extern const struct soc_enum cs48l32_in_vd_ramp;
+extern const struct soc_enum cs48l32_in_hpf_cut_enum;
+extern const struct soc_enum cs48l32_in_dmic_osr[];
+
+irqreturn_t cs48l32_us1_activity(int irq, void *data);
+irqreturn_t cs48l32_us2_activity(int irq, void *data);
+
+int cs48l32_in_rate_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+extern const struct soc_enum cs48l32_input_rate[];
+int cs48l32_low_power_mode_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol);
+
+extern const struct soc_enum noise_gen_rate;
+
+extern const struct soc_enum cs48l32_auxpdm1_freq;
+extern const struct soc_enum cs48l32_auxpdm2_freq;
+extern const struct snd_kcontrol_new cs48l32_auxpdm_inmux[];
+extern const struct snd_kcontrol_new cs48l32_auxpdm_analog_inmux[];
+extern const struct snd_kcontrol_new cs48l32_auxpdm_switch[];
+
+extern const struct soc_enum cs48l32_isrc_fsl[];
+extern const struct soc_enum cs48l32_isrc_fsh[];
+
+extern const struct soc_enum cs48l32_fx_rate;
+
+extern const struct soc_enum cs48l32_lhpf_mode[];
+
+int cs48l32_lhpf_coeff_put(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_value *ucontrol);
+
+extern const struct soc_enum cs48l32_eq_mode[];
+int cs48l32_eq_mode_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int cs48l32_eq_mode_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int cs48l32_eq_coeff_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo);
+int cs48l32_eq_coeff_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int cs48l32_eq_coeff_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+
+extern const struct snd_kcontrol_new cs48l32_drc_activity_output_mux[];
+extern const struct snd_kcontrol_new cs48l32_dsp_trigger_output_mux[];
+int cs48l32_dsp_rate_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+int cs48l32_dsp_rate_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
+extern const struct soc_enum cs48l32_dsp_rate_enum[];
+
+int cs48l32_dsp_pre_run(struct wm_adsp *dsp);
+int cs48l32_dsp_memory_enable(struct cs48l32 *priv,
+			    const struct cs48l32_dsp_power_regs *regs);
+void cs48l32_dsp_memory_disable(struct cs48l32 *priv,
+			      const struct cs48l32_dsp_power_regs *regs);
+int cs48l32_dsp_freq_ev(struct snd_soc_dapm_widget *w,
+			struct snd_kcontrol *kcontrol, int event);
+irqreturn_t cs48l32_dsp1_irq(int irq, void *data);
+
+int cs48l32_set_sysclk(struct snd_soc_component *component, int clk_id,
+		     int source, unsigned int freq, int dir);
+
+extern const struct snd_soc_dai_ops cs48l32_dai_ops;
+
+int cs48l32_sysclk_ev(struct snd_soc_dapm_widget *w,
+		    struct snd_kcontrol *kcontrol,
+		    int event);
+int cs48l32_in_ev(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol,
+		int event);
+int cs48l32_in_put_volsw(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol);
+int cs48l32_eq_ev(struct snd_soc_dapm_widget *w,
+		struct snd_kcontrol *kcontrol,
+		int event);
+
+int cs48l32_fllhj_set_refclk(struct cs48l32_fll *fll, int source,
+			   unsigned int fin, unsigned int fout);
+int cs48l32_init_fll(struct cs48l32_fll *fll);
+int cs48l32_init_inputs(struct snd_soc_component *component);
+int cs48l32_init_dai(struct cs48l32 *priv, int dai);
+int cs48l32_init_eq(struct cs48l32 *priv);
+int cs48l32_core_init(struct cs48l32 *priv);
+int cs48l32_core_destroy(struct cs48l32 *priv);
+
+#endif
-- 
2.30.2

