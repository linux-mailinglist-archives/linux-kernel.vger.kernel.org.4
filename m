Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C96E2510
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDNODh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDNODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008255BB0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:58 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y35so4153985ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480964; x=1684072964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bxyap3C7vnCZiYWpHQpZz2VAx2t0ZhWrLbyvgckvU+w=;
        b=Gmjqkxzo0Ck8WXLqKCS9AX4CDT5afRvDrQ056Cxb+7URvPCCz52K9LHM9xdOe1eB3Q
         YYXx57/aeFlMeSfqfwdlGYby2qHNZw3tU8RT1qzD/FSDO8CaEQSGTDVhtCUafa0gq+cs
         JVfA2W7e9VIOYwjOFJnvwHBgZYT+NRJoKH2a3270NYNRZoQgN/cTrdVD2hQum6JbkXq1
         ee/+scJ6CLbubujQ8zSxxye9zexdPAZAKEjtv5qNEoXBvUWBJY3064Pare1kJ39wm7se
         p/QY6G4R1ZW3xXDv+qTo4HU74giHUYMZAcwoyYqifB9WMib8xRcrxQrcHYWc4RbDF+mt
         NJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480964; x=1684072964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bxyap3C7vnCZiYWpHQpZz2VAx2t0ZhWrLbyvgckvU+w=;
        b=i5VXCvlDATnuYUCV35dLg2uijLAWqGRDOokSIo5AtS3Ix6nCMvFm7WvGqIQf/ZUEC0
         +UDFrmJO4zO83G/Z9tIaYyBXJO4Xx+yCfwtCsW3lth30ztxj/uIM61d5LGLuw94BDosC
         XwzndC+Ox9WmQZdjauxER/TvrLiB5jNNQ62hOMsMTHoHLflJUc+/tPrZBgvkokDyTDo3
         77QWC7SBtTO2c2gYB72w/w5L6GarH7PHBB7g4XfFUbezL45wPVnp4hqd8Jum6OMkSNv5
         ScqJfGK6/1YLqek5R+WpVItlk0kbntjys7KtsQC7Iwl2+Ry99G+tesZteSIcIz5/3HXA
         McBQ==
X-Gm-Message-State: AAQBX9ekOn+izZil1bAGDUd6S8zC7C+bWKI31zSgPJJ6cPXIpUNjTrcC
        rfAzY/ChK1LXltJOq/jh7VZabA==
X-Google-Smtp-Source: AKy350b5uDMDwSZXnP+ykH/7bIaFsCQIcUysiVn/LCImS52AjBEm2D7lyPja+s0isp2EYILrAX1fyg==
X-Received: by 2002:a2e:9f14:0:b0:29a:9b26:4e25 with SMTP id u20-20020a2e9f14000000b0029a9b264e25mr1698870ljk.6.1681480963267;
        Fri, 14 Apr 2023 07:02:43 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:42 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 1/9] ASoC: Add Chameleon v3 audio
Date:   Fri, 14 Apr 2023 16:01:55 +0200
Message-ID: <20230414140203.707729-2-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add machine and platform drivers for ASoC audio on Chameleon v3.

The board has two audio sources: HDMI audio from the it68051 chip
(RX only), and analog audio from the ssm2603 chip (RX and TX).

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 .../boot/dts/socfpga_arria10_chameleonv3.dts  |  28 ++
 sound/soc/Kconfig                             |   1 +
 sound/soc/Makefile                            |   1 +
 sound/soc/chameleonv3/Kconfig                 |   7 +
 sound/soc/chameleonv3/Makefile                |   2 +
 sound/soc/chameleonv3/chv3-audio.c            | 111 ++++++
 sound/soc/chameleonv3/chv3-i2s.c              | 347 ++++++++++++++++++
 sound/soc/chameleonv3/chv3-it68051.c          |  41 +++
 8 files changed, 538 insertions(+)
 create mode 100644 sound/soc/chameleonv3/Kconfig
 create mode 100644 sound/soc/chameleonv3/Makefile
 create mode 100644 sound/soc/chameleonv3/chv3-audio.c
 create mode 100644 sound/soc/chameleonv3/chv3-i2s.c
 create mode 100644 sound/soc/chameleonv3/chv3-it68051.c

diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
index 422d00cd4c74..c75f41058196 100644
--- a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
@@ -15,6 +15,34 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 	};
+
+	soc {
+		i2s0: i2s@c0060300 {
+			compatible = "google,chv3-i2s";
+			reg = <0xc0060300 0x100>,
+			      <0xc0060f00 0x10>;
+			interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		i2s1: i2s@c0060400 {
+			compatible = "google,chv3-i2s";
+			reg = <0xc0060400 0x100>,
+			      <0xc0060f10 0x10>;
+			interrupts = <0 21 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "google,chv3-audio";
+		google,audio-cpu0 = <&i2s1>;
+		google,audio-codec0 = <&ssm2603>;
+		google,audio-cpu1 = <&i2s0>;
+		google,audio-codec1 = <&it68051>;
+	};
+
+	it68051: audio-codec {
+		compatible = "ite,it68051";
+	};
 };
 
 &gmac0 {
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 848fbae26c3b..d5a24819a0eb 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -72,6 +72,7 @@ source "sound/soc/apple/Kconfig"
 source "sound/soc/atmel/Kconfig"
 source "sound/soc/au1x/Kconfig"
 source "sound/soc/bcm/Kconfig"
+source "sound/soc/chameleonv3/Kconfig"
 source "sound/soc/cirrus/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 507eaed1d6a1..5572f4ebe59e 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_SND_SOC)	+= amd/
 obj-$(CONFIG_SND_SOC)	+= atmel/
 obj-$(CONFIG_SND_SOC)	+= au1x/
 obj-$(CONFIG_SND_SOC)	+= bcm/
+obj-$(CONFIG_SND_SOC)	+= chameleonv3/
 obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
diff --git a/sound/soc/chameleonv3/Kconfig b/sound/soc/chameleonv3/Kconfig
new file mode 100644
index 000000000000..8386c44d6e92
--- /dev/null
+++ b/sound/soc/chameleonv3/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SND_SOC_CHV3
+	tristate "SoC Audio support for Chameleon v3"
+	select SND_SOC_SSM2602
+	select SND_SOC_SSM2602_I2C
+	help
+	  Say Y if you want to add audio support for the Chameleon v3.
diff --git a/sound/soc/chameleonv3/Makefile b/sound/soc/chameleonv3/Makefile
new file mode 100644
index 000000000000..a542ad412b93
--- /dev/null
+++ b/sound/soc/chameleonv3/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SND_SOC_CHV3) += chv3-i2s.o chv3-audio.o chv3-it68051.o
diff --git a/sound/soc/chameleonv3/chv3-audio.c b/sound/soc/chameleonv3/chv3-audio.c
new file mode 100644
index 000000000000..e860447c2cef
--- /dev/null
+++ b/sound/soc/chameleonv3/chv3-audio.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <sound/soc.h>
+
+static int chv3_ssm2603_hw_params(struct snd_pcm_substream *substream,
+			  struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct snd_soc_dai *dai = asoc_rtd_to_codec(rtd, 0);
+
+	return snd_soc_dai_set_sysclk(dai, 0, 22579200, SND_SOC_CLOCK_IN);
+}
+
+static const struct snd_soc_ops chv3_ssm2603_ops = {
+	.hw_params = chv3_ssm2603_hw_params,
+};
+
+SND_SOC_DAILINK_DEFS(ssm2603,
+	DAILINK_COMP_ARRAY(COMP_CPU("chv3-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "ssm2602-hifi")), /* 2602 - not a typo */
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(it68051,
+	DAILINK_COMP_ARRAY(COMP_CPU("chv3-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "it68051-hifi")),
+	DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+static struct snd_soc_dai_link chv3_audio_dais[] = {
+{
+	.name = "ssm2603",
+	.stream_name = "ssm2603 PCM",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
+	.ops = &chv3_ssm2603_ops,
+	SND_SOC_DAILINK_REG(ssm2603),
+},
+{
+	.name = "it68051",
+	.stream_name = "it68051 PCM",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
+	SND_SOC_DAILINK_REG(it68051),
+},
+};
+
+static struct snd_soc_card chv3_audio_card = {
+	.name = "chv3-audio",
+	.owner = THIS_MODULE,
+	.dai_link = chv3_audio_dais,
+	.num_links = 2,
+};
+
+static int chv3_audio_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &chv3_audio_card;
+	struct device_node *np;
+
+	card->dev = &pdev->dev;
+
+	np = of_parse_phandle(pdev->dev.of_node, "google,audio-cpu0", 0);
+	if (!np) {
+		dev_err(&pdev->dev, "no google,audio-cpu0 property\n");
+		return -EINVAL;
+	}
+	chv3_audio_dais[0].cpus->of_node = np;
+	chv3_audio_dais[0].platforms->of_node = np;
+
+	np = of_parse_phandle(pdev->dev.of_node, "google,audio-codec0", 0);
+	if (!np) {
+		dev_err(&pdev->dev, "no google,audio-codec0 property\n");
+		return -EINVAL;
+	}
+	chv3_audio_dais[0].codecs->of_node = np;
+
+	np = of_parse_phandle(pdev->dev.of_node, "google,audio-cpu1", 0);
+	if (!np) {
+		dev_err(&pdev->dev, "no google,audio-cpu1 property\n");
+		return -EINVAL;
+	}
+	chv3_audio_dais[1].cpus->of_node = np;
+	chv3_audio_dais[1].platforms->of_node = np;
+
+	np = of_parse_phandle(pdev->dev.of_node, "google,audio-codec1", 0);
+	if (!np) {
+		dev_err(&pdev->dev, "no google,audio-codec1 property\n");
+		return -EINVAL;
+	}
+	chv3_audio_dais[1].codecs->of_node = np;
+
+	return devm_snd_soc_register_card(card->dev, card);
+}
+
+static const struct of_device_id chv3_audio_dt_ids[] = {
+	{ .compatible = "google,chv3-audio" },
+	{ },
+};
+
+static struct platform_driver chv3_audio_driver = {
+	.driver = {
+		.name = "chv3-audio",
+		.of_match_table = of_match_ptr(chv3_audio_dt_ids),
+	},
+	.probe = chv3_audio_probe,
+};
+
+module_platform_driver(chv3_audio_driver);
+
+MODULE_AUTHOR("Pawel Anikiel <pan@semihalf.com>");
+MODULE_DESCRIPTION("ALSA SoC Chameleon v3 audio driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/chameleonv3/chv3-i2s.c b/sound/soc/chameleonv3/chv3-i2s.c
new file mode 100644
index 000000000000..e946bff2e6fc
--- /dev/null
+++ b/sound/soc/chameleonv3/chv3-i2s.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <sound/soc.h>
+
+/*
+ * The I2S interface consists of two ring buffers - one for RX and one for
+ * TX.  A ring buffer has a producer index and a consumer index. Depending
+ * on which way the data is flowing, either the software or the hardware
+ * writes data and updates the producer index, and the other end reads data
+ * and updates the consumer index.
+ *
+ * The pointer managed by software is updated using the .ack callback
+ * (see chv3_dma_ack). This seems to be the only way to reliably obtain
+ * the appl_ptr from within the driver and pass it to hardware.
+ *
+ * Because of the two pointer design, the ring buffer can never be full. With
+ * capture this isn't a problem, because the hardware being the producer
+ * will wait for the consumer index to move out of the way.  With playback,
+ * however, this is problematic, because ALSA wants to fill up the buffer
+ * completely when waiting for hardware. In the .ack callback, the driver
+ * would have to wait for the consumer index to move out of the way by
+ * busy-waiting, which would keep stalling the kernel for quite a long time.
+ *
+ * The workaround to this problem is to "lie" to ALSA that the hw_pointer
+ * is one period behind what it actually is (see chv3_dma_pointer). This
+ * way, ALSA will not try to fill up the entire buffer, and all callbacks
+ * are wait-free.
+ */
+
+#define I2S_TX_ENABLE		0x00
+#define I2S_TX_BASE_ADDR	0x04
+#define I2S_TX_BUFFER_SIZE	0x08
+#define I2S_TX_PRODUCER_IDX	0x0c
+#define I2S_TX_CONSUMER_IDX	0x10
+#define I2S_RX_ENABLE		0x14
+#define I2S_RX_BASE_ADDR	0x18
+#define I2S_RX_BUFFER_SIZE	0x1c
+#define I2S_RX_PRODUCER_IDX	0x20
+#define I2S_RX_CONSUMER_IDX	0x24
+
+#define I2S_SOFT_RESET		0x2c
+#define I2S_SOFT_RESET_RX_BIT	0x1
+#define I2S_SOFT_RESET_TX_BIT	0x2
+
+#define I2S_RX_IRQ		0x4c
+#define I2S_RX_IRQ_CONST	0x50
+#define I2S_TX_IRQ		0x54
+#define I2S_TX_IRQ_CONST	0x58
+
+#define I2S_IRQ_MASK	0x8
+#define I2S_IRQ_CLR	0xc
+#define I2S_IRQ_RX_BIT	0x1
+#define I2S_IRQ_TX_BIT	0x2
+
+#define I2S_MAX_BUFFER_SIZE	0x200000
+
+struct chv3_i2s_dev {
+	struct device *dev;
+	void __iomem *iobase;
+	void __iomem *iobase_irq;
+	struct snd_pcm_substream *rx_substream;
+	struct snd_pcm_substream *tx_substream;
+	int tx_bytes_to_fetch;
+	bool tx_ready;
+};
+
+static struct snd_soc_dai_driver chv3_i2s_dai = {
+	.name = "chv3-i2s",
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 128,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 96000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 128,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 8000,
+		.rate_max = 96000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+};
+
+static const struct snd_pcm_hardware chv3_dma_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER,
+	.buffer_bytes_max = I2S_MAX_BUFFER_SIZE,
+	.period_bytes_min = 64,
+	.period_bytes_max = 8192,
+	.periods_min = 4,
+	.periods_max = 256,
+};
+
+static inline void chv3_i2s_wr(struct chv3_i2s_dev *i2s, int offset, u32 val)
+{
+	writel(val, i2s->iobase + offset);
+}
+
+static inline u32 chv3_i2s_rd(struct chv3_i2s_dev *i2s, int offset)
+{
+	return readl(i2s->iobase + offset);
+}
+
+static irqreturn_t chv3_i2s_isr(int irq, void *data)
+{
+	struct chv3_i2s_dev *i2s = data;
+	u32 reg;
+
+	reg = readl(i2s->iobase_irq + I2S_IRQ_CLR);
+	if (!reg)
+		return IRQ_NONE;
+
+	if (reg & I2S_IRQ_RX_BIT)
+		snd_pcm_period_elapsed(i2s->rx_substream);
+
+	if (reg & I2S_IRQ_TX_BIT) {
+		if (i2s->tx_ready)
+			snd_pcm_period_elapsed(i2s->tx_substream);
+		i2s->tx_ready = 1;
+	}
+
+	writel(reg, i2s->iobase_irq + I2S_IRQ_CLR);
+
+	return IRQ_HANDLED;
+}
+
+static int chv3_dma_open(struct snd_soc_component *component,
+			 struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+	int res;
+
+	snd_soc_set_runtime_hwparams(substream, &chv3_dma_hw);
+
+	res = snd_pcm_hw_constraint_pow2(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
+	if (res)
+		return res;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		i2s->rx_substream = substream;
+	else
+		i2s->tx_substream = substream;
+
+	return 0;
+}
+static int chv3_dma_close(struct snd_soc_component *component,
+			  struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+		chv3_i2s_wr(i2s, I2S_RX_ENABLE, 0);
+	else
+		chv3_i2s_wr(i2s, I2S_TX_ENABLE, 0);
+
+	return 0;
+}
+
+static int chv3_dma_pcm_construct(struct snd_soc_component *component,
+				  struct snd_soc_pcm_runtime *rtd)
+{
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+	struct snd_pcm_substream *substream;
+	int res;
+
+	substream = rtd->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	if (substream) {
+		res = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, i2s->dev,
+				I2S_MAX_BUFFER_SIZE, &substream->dma_buffer);
+		if (res)
+			return res;
+	}
+
+	substream = rtd->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
+	if (substream) {
+		res = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, i2s->dev,
+				I2S_MAX_BUFFER_SIZE, &substream->dma_buffer);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int chv3_dma_hw_params(struct snd_soc_component *component,
+			      struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	return 0;
+}
+
+static int chv3_dma_prepare(struct snd_soc_component *component,
+			    struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+	unsigned int buffer_bytes, period_bytes, period_size;
+
+	buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+	period_bytes = snd_pcm_lib_period_bytes(substream);
+	period_size = substream->runtime->period_size;
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		chv3_i2s_wr(i2s, I2S_SOFT_RESET, I2S_SOFT_RESET_RX_BIT);
+		chv3_i2s_wr(i2s, I2S_RX_BASE_ADDR, substream->dma_buffer.addr);
+		chv3_i2s_wr(i2s, I2S_RX_BUFFER_SIZE, buffer_bytes);
+		chv3_i2s_wr(i2s, I2S_RX_IRQ, (period_size << 8) | 1);
+		chv3_i2s_wr(i2s, I2S_RX_ENABLE, 1);
+	} else {
+		i2s->tx_ready = 0;
+		chv3_i2s_wr(i2s, I2S_SOFT_RESET, I2S_SOFT_RESET_TX_BIT);
+		chv3_i2s_wr(i2s, I2S_TX_BASE_ADDR, substream->dma_buffer.addr);
+		chv3_i2s_wr(i2s, I2S_TX_BUFFER_SIZE, buffer_bytes);
+		chv3_i2s_wr(i2s, I2S_TX_IRQ, ((period_bytes / i2s->tx_bytes_to_fetch) << 8) | 1);
+		chv3_i2s_wr(i2s, I2S_TX_ENABLE, 1);
+	}
+	writel(I2S_IRQ_RX_BIT | I2S_IRQ_TX_BIT, i2s->iobase_irq + I2S_IRQ_MASK);
+
+	return 0;
+}
+
+static snd_pcm_uframes_t chv3_dma_pointer(struct snd_soc_component *component,
+					  struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+	u32 period_bytes, buffer_bytes;
+	u32 idx_bytes;
+
+	period_bytes = snd_pcm_lib_period_bytes(substream);
+	buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		idx_bytes = chv3_i2s_rd(i2s, I2S_RX_PRODUCER_IDX);
+	} else {
+		idx_bytes = chv3_i2s_rd(i2s, I2S_TX_CONSUMER_IDX);
+		if (i2s->tx_ready)
+			idx_bytes = (idx_bytes - period_bytes) & (buffer_bytes - 1);
+		else
+			idx_bytes = 0;
+	}
+
+	return bytes_to_frames(substream->runtime, idx_bytes);
+}
+
+static int chv3_dma_ack(struct snd_soc_component *component,
+			struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct chv3_i2s_dev *i2s = snd_soc_dai_get_drvdata(asoc_rtd_to_cpu(rtd, 0));
+	unsigned int bytes, idx;
+
+	bytes = frames_to_bytes(runtime, runtime->control->appl_ptr);
+	idx = bytes & (snd_pcm_lib_buffer_bytes(substream) - 1);
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
+		chv3_i2s_wr(i2s, I2S_RX_CONSUMER_IDX, idx);
+	else
+		chv3_i2s_wr(i2s, I2S_TX_PRODUCER_IDX, idx);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver chv3_i2s_comp = {
+	.name = "chv3-i2s-comp",
+	.open = chv3_dma_open,
+	.close = chv3_dma_close,
+	.pcm_construct = chv3_dma_pcm_construct,
+	.hw_params = chv3_dma_hw_params,
+	.prepare = chv3_dma_prepare,
+	.pointer = chv3_dma_pointer,
+	.ack = chv3_dma_ack,
+};
+
+static int chv3_i2s_probe(struct platform_device *pdev)
+{
+	struct chv3_i2s_dev *i2s;
+	int res;
+	int irq;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s)
+		return -ENOMEM;
+
+	i2s->iobase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(i2s->iobase))
+		return PTR_ERR(i2s->iobase);
+
+	i2s->iobase_irq = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(i2s->iobase_irq))
+		return PTR_ERR(i2s->iobase_irq);
+
+	i2s->tx_bytes_to_fetch = (chv3_i2s_rd(i2s, I2S_TX_IRQ_CONST) >> 8) & 0xffff;
+
+	i2s->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, i2s);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENXIO;
+	res = devm_request_irq(i2s->dev, irq, chv3_i2s_isr, 0, "chv3-i2s", i2s);
+	if (res)
+		return res;
+
+	res = devm_snd_soc_register_component(&pdev->dev, &chv3_i2s_comp,
+					      &chv3_i2s_dai, 1);
+	if (res) {
+		dev_err(&pdev->dev, "couldn't register component: %d\n", res);
+		return res;
+	}
+
+	dev_info(&pdev->dev, "probed\n");
+
+	return 0;
+}
+
+static const struct of_device_id chv3_i2s_of_match[] = {
+	{ .compatible = "google,chv3-i2s" },
+	{},
+};
+
+static struct platform_driver chv3_i2s_driver = {
+	.probe = chv3_i2s_probe,
+	.driver = {
+		.name = "chv3-i2s",
+		.of_match_table = chv3_i2s_of_match,
+	},
+};
+
+module_platform_driver(chv3_i2s_driver);
+
+MODULE_AUTHOR("Pawel Anikiel <pan@semihalf.com>");
+MODULE_DESCRIPTION("Chameleon v3 I2S interface");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/chameleonv3/chv3-it68051.c b/sound/soc/chameleonv3/chv3-it68051.c
new file mode 100644
index 000000000000..4813e699ec9c
--- /dev/null
+++ b/sound/soc/chameleonv3/chv3-it68051.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <sound/soc.h>
+
+static struct snd_soc_dai_driver it68051_dai = {
+	.name = "it68051-hifi",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 8,
+		.channels_max = 8,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	},
+};
+
+static const struct snd_soc_component_driver soc_component_dev_it68051 = {
+};
+
+static int it68051_probe(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_component(&pdev->dev,
+		&soc_component_dev_it68051, &it68051_dai, 1);
+}
+
+static const struct of_device_id it68051_of_match[] = {
+	{ .compatible = "ite,it68051", },
+	{ }
+};
+
+static struct platform_driver it68051_platform_driver = {
+	.driver = {
+		.name = "it68051",
+		.of_match_table = it68051_of_match,
+	},
+	.probe = it68051_probe,
+};
+module_platform_driver(it68051_platform_driver);
+
+MODULE_DESCRIPTION("ASoC IT68051 driver");
+MODULE_AUTHOR("Pawel Anikiel <pan@semihalf.com>");
+MODULE_LICENSE("GPL");
-- 
2.40.0.634.g4ca3ef3211-goog

