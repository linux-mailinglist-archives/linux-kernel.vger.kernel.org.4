Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC09573A94E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjFVUGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:06:29 -0400
Received: from smtpng1.i.mail.ru (smtpng1.i.mail.ru [94.100.181.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C450919B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=WAKyA8qap6cnuN2ifT6hkaVj7Y+yIwHtKUD84PqPiFk=;
        t=1687464386;x=1687554386; 
        b=S+5H8mJ8dsNduxOP9rg97CEh55V7Nn2b1il2bcrNq3Je5CoGo5tTzQdTuj9IINj+AwE6J7Fk2QP5IgXVYyUJ3fUOzbAmKnXJbl+Fho6pmYg1ITx/0t4UIPw2+uLRwqJHR+Gu3fOfJRRcdBGhrQ9/rf9Q9zHd+tlMF/irWrpWUmX0NV364eYizFluchBpRi46XpWT4bNV2huZhFYU0G5qFuuY2YZWA+aOezIFeE4ZTA+HrmczkYqS+GSXbprDIuy8UXmCMVljO495bKepKJvy5r5g9+cW04D4OfdeQzdyC5QNHboIcJZE998xbsc+Uyozvyd0sjL+eBPBF+sMddo8pQ==;
Received: by smtpng1.m.smailru.net with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1qCQZS-000051-JQ; Thu, 22 Jun 2023 23:06:23 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
To:     alsa-devel@alsa-project.org
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: dwc: Add TDM mode support
Date:   Thu, 22 Jun 2023 23:00:29 +0300
Message-Id: <20230622200031.120168-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtpng1.m.smailru.net; auth=pass smtp.auth=fido_max@inbox.ru smtp.mailfrom=fido_max@inbox.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9C3255D34B386091E664FD7FA93D7B6BF6662C23C5EC5C6B6182A05F5380850404C228DA9ACA6FE27A6E8B2B85F79C9D2D5C7826062485917F4F3D71FEA6850DD6FBDF4CBB7AC81FB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D3DF794D859AA4BFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370EBB47D88F71BB738638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D882F7D17082B27B51A315D7EF298AD2D66F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE746CC513BB44FBA1D9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B45CF3281D200C6DFA471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C468D16C903838CAB43847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5A32233ABAAF940FF0DEA1B53B73B05461A880C6E81AC97CE5A4FF58CDAEABE2AA132EA92956906CB6C75489805341C4D559C6C5561145D6F823CB91A9FED034534781492E4B8EEAD86930E2892F4EB08F36E2E0160E5C55395B8A2A0B6518DF68C46860778A80D541C39E39C5FB3188CA1CCA473A088F2E6E17F0F6D6FCACA672FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF26627E0B569FD6DE0357DC0226EF9A8E87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE22020ED9B4190895BC6AFF861209850C3C7233952ABAA0C2ED8AD4A8822414BC69CBF34C6AF1FF5B05B57073EAFDF97809788F1841249CA442E1537E9165801464E0F6E1F48538C02C26D483E81D6BEEB84411BD425175970A7FB4ED9620804ADE12199CE9660BE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB41c+mu8Ac/S/htu6B/JwA==
X-Mailru-Sender: 689FA8AB762F73930F533AC2B33E986B7D28DD0649E0B2B819C01AB36ED988B198CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on hardware implementaion of DWC I2S controller may support
TDM mode if enabled in SoC at design time.
Unfortunately there is no way to detect TDM capability for DWC by
reading registers. Anyway, if such capability enabled, TDM mode
can be enabled and configured by dai-tdm-slot-* DT options.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 sound/soc/dwc/dwc-i2s.c | 65 +++++++++++++++++++++++++++++++++++++++--
 sound/soc/dwc/dwc-pcm.c |  8 ++---
 sound/soc/dwc/local.h   | 24 +++++++++++++++
 3 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 97d652f0e84d..1f1ee14b04e6 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -183,7 +183,15 @@ static void i2s_start(struct dw_i2s_dev *dev,
 {
 	struct i2s_clk_config_data *config = &dev->config;
 
-	i2s_write_reg(dev->i2s_base, IER, 1);
+	u32 reg = IER_IEN;
+
+	if (dev->tdm_slots) {
+		reg |= (dev->tdm_slots - 1) << IER_TDM_SLOTS_SHIFT;
+		reg |= IER_INTF_TYPE;
+		reg |= dev->frame_offset << IER_FRAME_OFF_SHIFT;
+	}
+
+	i2s_write_reg(dev->i2s_base, IER, reg);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		i2s_write_reg(dev->i2s_base, ITER, 1);
@@ -233,13 +241,15 @@ static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 				      dev->xfer_resolution);
 			i2s_write_reg(dev->i2s_base, TFCR(ch_reg),
 				      dev->fifo_th - 1);
-			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+			i2s_write_reg(dev->i2s_base, TER(ch_reg), TER_TXCHEN |
+				      dev->tdm_mask << TER_TXSLOT_SHIFT);
 		} else {
 			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
 				      dev->xfer_resolution);
 			i2s_write_reg(dev->i2s_base, RFCR(ch_reg),
 				      dev->fifo_th - 1);
-			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+			i2s_write_reg(dev->i2s_base, RER(ch_reg), RER_RXCHEN |
+				      dev->tdm_mask << RER_RXSLOT_SHIFT);
 		}
 
 	}
@@ -276,6 +286,9 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (dev->tdm_slots)
+		config->data_width = 32;
+
 	config->chan_nr = params_channels(params);
 
 	switch (config->chan_nr) {
@@ -384,14 +397,58 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 		ret = -EINVAL;
 		break;
 	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		dev->frame_offset = 1;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		dev->frame_offset = 0;
+		break;
+	default:
+		dev_err(dev->dev, "DAI format unsupported");
+		return -EINVAL;
+	}
+
 	return ret;
 }
 
+static int dw_i2s_set_tdm_slot(struct snd_soc_dai *cpu_dai,	unsigned int tx_mask,
+			   unsigned int rx_mask, int slots, int slot_width)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (slot_width != 32)
+		return -EINVAL;
+
+	if (slots < 0 || slots > 16)
+		return -EINVAL;
+
+	if (rx_mask != tx_mask)
+		return -EINVAL;
+
+	if (!rx_mask)
+		return -EINVAL;
+
+	dev->tdm_slots = slots;
+	dev->tdm_mask = rx_mask;
+
+	dev->l_reg = RSLOT_TSLOT(ffs(rx_mask) - 1);
+	dev->r_reg = RSLOT_TSLOT(fls(rx_mask) - 1);
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
 	.set_fmt	= dw_i2s_set_fmt,
+	.set_tdm_slot	= dw_i2s_set_tdm_slot,
 };
 
 #ifdef CONFIG_PM
@@ -726,6 +783,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		if (irq >= 0) {
 			ret = dw_pcm_register(pdev);
 			dev->use_pio = true;
+			dev->l_reg = LRBR_LTHR(0);
+			dev->r_reg = RRBR_RTHR(0);
 		} else {
 			ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL,
 					0);
diff --git a/sound/soc/dwc/dwc-pcm.c b/sound/soc/dwc/dwc-pcm.c
index 9f25631d43d3..f99262b89008 100644
--- a/sound/soc/dwc/dwc-pcm.c
+++ b/sound/soc/dwc/dwc-pcm.c
@@ -31,8 +31,8 @@ static unsigned int dw_pcm_tx_##sample_bits(struct dw_i2s_dev *dev, \
 	int i; \
 \
 	for (i = 0; i < dev->fifo_th; i++) { \
-		iowrite32(p[tx_ptr][0], dev->i2s_base + LRBR_LTHR(0)); \
-		iowrite32(p[tx_ptr][1], dev->i2s_base + RRBR_RTHR(0)); \
+		iowrite32(p[tx_ptr][0], dev->i2s_base + dev->l_reg); \
+		iowrite32(p[tx_ptr][1], dev->i2s_base + dev->r_reg); \
 		period_pos++; \
 		if (++tx_ptr >= runtime->buffer_size) \
 			tx_ptr = 0; \
@@ -51,8 +51,8 @@ static unsigned int dw_pcm_rx_##sample_bits(struct dw_i2s_dev *dev, \
 	int i; \
 \
 	for (i = 0; i < dev->fifo_th; i++) { \
-		p[rx_ptr][0] = ioread32(dev->i2s_base + LRBR_LTHR(0)); \
-		p[rx_ptr][1] = ioread32(dev->i2s_base + RRBR_RTHR(0)); \
+		p[rx_ptr][0] = ioread32(dev->i2s_base + dev->l_reg); \
+		p[rx_ptr][1] = ioread32(dev->i2s_base + dev->r_reg); \
 		period_pos++; \
 		if (++rx_ptr >= runtime->buffer_size) \
 			rx_ptr = 0; \
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index ba4e397099be..4ce96bac2f39 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -25,6 +25,13 @@
 #define RXFFR		0x014
 #define TXFFR		0x018
 
+/* Enable register fields */
+#define IER_TDM_SLOTS_SHIFT	8
+#define IER_FRAME_OFF_SHIFT	5
+#define IER_FRAME_OFF	BIT(5)
+#define IER_INTF_TYPE	BIT(1)
+#define IER_IEN		BIT(0)
+
 /* Interrupt status register fields */
 #define ISR_TXFO	BIT(5)
 #define ISR_TXFE	BIT(4)
@@ -46,6 +53,15 @@
 #define TFCR(x)		(0x40 * x + 0x04C)
 #define RFF(x)		(0x40 * x + 0x050)
 #define TFF(x)		(0x40 * x + 0x054)
+#define RSLOT_TSLOT(x)	(0x4 * (x) + 0x224)
+
+/* Receive enable register fields */
+#define RER_RXSLOT_SHIFT	8
+#define RER_RXCHEN	BIT(0)
+
+/* Transmit enable register fields */
+#define TER_TXSLOT_SHIFT	8
+#define TER_TXCHEN	BIT(0)
 
 /* I2SCOMPRegisters */
 #define I2S_COMP_PARAM_2	0x01F0
@@ -105,6 +121,8 @@ struct dw_i2s_dev {
 	u32 ccr;
 	u32 xfer_resolution;
 	u32 fifo_th;
+	u32 l_reg;
+	u32 r_reg;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
@@ -114,6 +132,12 @@ struct dw_i2s_dev {
 
 	/* data related to PIO transfers */
 	bool use_pio;
+
+	/* data related to TDM mode */
+	u32 tdm_slots;
+	u32 tdm_mask;
+	u32 frame_offset;
+
 	struct snd_pcm_substream __rcu *tx_substream;
 	struct snd_pcm_substream __rcu *rx_substream;
 	unsigned int (*tx_fn)(struct dw_i2s_dev *dev,
-- 
2.40.1

