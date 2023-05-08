Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E76FAD28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjEHLcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbjEHLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 07:31:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05503DC91
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 04:30:57 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso5073249e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1683545456; x=1686137456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXV6n/ZoBKctzecySAN7sPYLUBR2V7OtAf+/Kf5BsKA=;
        b=jRtjCAcypKAY/Gu9ja9yDpxwx/UWqHXXOoAHQdAeNM6o0l/gf+lfkFTlXuaFhhK4yE
         3rzj7X9wmF2xbyaS3DBcTwkuYi0jYjvyCkVWBa0XdFxuNyHNVRC6+XRy2MzKBZa0MtzO
         5AMw7InyfPJ5mhbF5BPmPnw/I0POgBd7y9rMCYFN4kA4p7Juv0MAj78DXIbftJnezCih
         Iotnwk33EQlsiF3y7/V99vLLV/Hsy6vRkJutoQ+WY2vdzR+yKt4QtiB2mCINzDAAKwbj
         tNKlXrncXdppG6+7iHXeS/MFiAmi/IFLU75eC0ues1kBzy2G2ymeH6e3dzi2vXM8cOx5
         W7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683545456; x=1686137456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXV6n/ZoBKctzecySAN7sPYLUBR2V7OtAf+/Kf5BsKA=;
        b=fHAcnUfptaJBb3aS4oDsFyK/1D8ZY6BRbZjsYvbEHANhiz+O7V6haCybv0Exqye+AG
         Mx+S+vxig2hgs4m06+l5B9Rs/FsTTQpNRI258G76QudK3k/1FkEpl+IZwo382GlVYDih
         j6gDCP7/WDnrbnwTWg8N9KTx0UB7n48ya8jA6G3YvvSjZUXg6KykBea0J5C7SlqJc20h
         5b3DgDYlICQqNP+abDFU5J0kaQ2fa5g0NsDenNG0XS/rrrDISkCiAkCrMAszZoBq8ow0
         zVXVA5BUpDwPvj4We5wZ/Nsw47J3rdZ4z0P0Q4Zw6yc1VtnzOP/nWqsYpbeNMlin7oXz
         dQ/g==
X-Gm-Message-State: AC+VfDyL6oXdx/xvxn4cRLyFPYk1bH5bEFbaY6FoqRUSYotCUe91R3c+
        rJ5KuhWj0/kebl0kaENbWlEeBQ==
X-Google-Smtp-Source: ACHHUZ52jbpSDsNhMgYMTMdCCma+vzl2q3QzDPXEkCR8puwHV4pYcc70RByBdauqf7y0WixG4jzAaA==
X-Received: by 2002:a05:651c:235:b0:2a8:b7e9:82ee with SMTP id z21-20020a05651c023500b002a8b7e982eemr2377512ljn.1.1683545456116;
        Mon, 08 May 2023 04:30:56 -0700 (PDT)
Received: from panikiel.office.semihalf.net ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id k8-20020a2e2408000000b002a8b9353338sm1144406ljk.117.2023.05.08.04.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:30:55 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        amstan@chromium.org,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v2 1/7] ASoC: Add Google Chameleon v3 i2s driver
Date:   Mon,  8 May 2023 13:30:31 +0200
Message-ID: <20230508113037.137627-2-pan@semihalf.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
In-Reply-To: <20230508113037.137627-1-pan@semihalf.com>
References: <20230508113037.137627-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the i2s IP present on Google Chameleon v3

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 sound/soc/Kconfig           |   1 +
 sound/soc/Makefile          |   1 +
 sound/soc/google/Kconfig    |   6 +
 sound/soc/google/Makefile   |   2 +
 sound/soc/google/chv3-i2s.c | 338 ++++++++++++++++++++++++++++++++++++
 5 files changed, 348 insertions(+)
 create mode 100644 sound/soc/google/Kconfig
 create mode 100644 sound/soc/google/Makefile
 create mode 100644 sound/soc/google/chv3-i2s.c

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 848fbae26c3b..48e778c18912 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -75,6 +75,7 @@ source "sound/soc/bcm/Kconfig"
 source "sound/soc/cirrus/Kconfig"
 source "sound/soc/dwc/Kconfig"
 source "sound/soc/fsl/Kconfig"
+source "sound/soc/google/Kconfig"
 source "sound/soc/hisilicon/Kconfig"
 source "sound/soc/jz4740/Kconfig"
 source "sound/soc/kirkwood/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 507eaed1d6a1..d5cc3eb710f9 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SND_SOC)	+= bcm/
 obj-$(CONFIG_SND_SOC)	+= cirrus/
 obj-$(CONFIG_SND_SOC)	+= dwc/
 obj-$(CONFIG_SND_SOC)	+= fsl/
+obj-$(CONFIG_SND_SOC)	+= google/
 obj-$(CONFIG_SND_SOC)	+= hisilicon/
 obj-$(CONFIG_SND_SOC)	+= jz4740/
 obj-$(CONFIG_SND_SOC)	+= img/
diff --git a/sound/soc/google/Kconfig b/sound/soc/google/Kconfig
new file mode 100644
index 000000000000..7603782fb060
--- /dev/null
+++ b/sound/soc/google/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SND_SOC_CHV3_I2S
+	tristate "Google Chameleon v3 I2S device"
+	help
+	  Enable support for the Google Chameleon v3 I2S device.
diff --git a/sound/soc/google/Makefile b/sound/soc/google/Makefile
new file mode 100644
index 000000000000..862496af1ae1
--- /dev/null
+++ b/sound/soc/google/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SND_SOC_CHV3_I2S) += chv3-i2s.o
diff --git a/sound/soc/google/chv3-i2s.c b/sound/soc/google/chv3-i2s.c
new file mode 100644
index 000000000000..0f6513444906
--- /dev/null
+++ b/sound/soc/google/chv3-i2s.c
@@ -0,0 +1,338 @@
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
+ * is one frame behind what it actually is (see chv3_dma_pointer). This
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
+	if (reg & I2S_IRQ_TX_BIT)
+		snd_pcm_period_elapsed(i2s->tx_substream);
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
+	u32 frame_bytes, buffer_bytes;
+	u32 idx_bytes;
+
+	frame_bytes = substream->runtime->frame_bits * 8;
+	buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+
+	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		idx_bytes = chv3_i2s_rd(i2s, I2S_RX_PRODUCER_IDX);
+	} else {
+		idx_bytes = chv3_i2s_rd(i2s, I2S_TX_CONSUMER_IDX);
+		/* lag the pointer by one frame */
+		idx_bytes = (idx_bytes - frame_bytes) & (buffer_bytes - 1);
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
-- 
2.40.1.521.gf1e218fcd8-goog

