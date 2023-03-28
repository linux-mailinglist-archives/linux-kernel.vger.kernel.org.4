Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891CD6CBA98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjC1J1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjC1J1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:27:02 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234095FF9;
        Tue, 28 Mar 2023 02:27:00 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 691891BF20A;
        Tue, 28 Mar 2023 09:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679995618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K24exBI98wXweQY7y30IYJ2xBsXGSBR6A9KtmS/sjh8=;
        b=ZCwG5T6ldREnpQ/+pLuc/js+x6FE/3XfHDl8DhmpB6rnxNQEXUaeqkfsKuGQy0u3+cXjYx
        JT5SBt7wOOjkNcf+tEIpRZ1Ix1hiBpFlYt7rM2hv/y7G1fEWk3sb3dcWAPdgwtEygn9kNu
        uwfvqwCABzqWtwRiux8WQjfN+0BSSrhlFWiBdpCb8gtjlA5OD6uiKFbGTwCZlfuu+Z6klz
        wyPIqLs6Cmvv63iPqsyUuhlmceHwuLf9aH3RvVwwt6F7j0nwtNCprmxoVqRlCycBhkJW9W
        fX6XFANVPe4YTOyhOyTkGav1mdlHORpq4dd2A5b0YJwHzUFguOHJa7eyjRdE5A==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 4/5] ASoC: codecs: Add support for the Lantiq PEF2256 codec
Date:   Tue, 28 Mar 2023 11:26:44 +0200
Message-Id: <20230328092645.634375-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328092645.634375-1-herve.codina@bootlin.com>
References: <20230328092645.634375-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lantiq PEF2256 is a framer and line interface component designed to
fulfill all required interfacing between an analog E1/T1/J1 line and the
digital PCM system highway/H.100 bus.

The codec support allows to use some of the PCM system highway
time-slots as audio channels to transport audio data over the E1/T1/J1
lines. It provides also line carrier detection events reported through
the ALSA jack detection feature.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/Kconfig         |  14 ++
 sound/soc/codecs/Makefile        |   2 +
 sound/soc/codecs/pef2256-codec.c | 390 +++++++++++++++++++++++++++++++
 3 files changed, 406 insertions(+)
 create mode 100644 sound/soc/codecs/pef2256-codec.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0be061953e9a..4f78da914fc7 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -168,6 +168,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_PCM512x_I2C
 	imply SND_SOC_PCM512x_SPI
 	imply SND_SOC_PEB2466
+	imply SND_SOC_PEF2256
 	imply SND_SOC_RK3328
 	imply SND_SOC_RK817
 	imply SND_SOC_RT274
@@ -1252,6 +1253,19 @@ config SND_SOC_PEB2466
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-soc-peb2466.
 
+config SND_SOC_PEF2256
+	tristate "Lantiq PEF2256 codec"
+	depends on MFD_PEF2256
+	help
+	  Enable support for the Lantiq PEF2256 (FALC56) codec.
+	  The PEF2256 is a framer and line interface between analog E1/T1/J1
+	  line and a digital PCM bus.
+	  This codec allows to use some of the time slots available on the
+	  PEF2256 PCM bus to transport some audio data.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-soc-pef2256.
+
 config SND_SOC_RK3328
 	tristate "Rockchip RK3328 audio CODEC"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 20b388b77f1f..11bd66d46f7b 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -188,6 +188,7 @@ snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
 snd-soc-peb2466-objs := peb2466.o
+snd-soc-pef2256-objs := pef2256-codec.o
 snd-soc-rk3328-objs := rk3328_codec.o
 snd-soc-rk817-objs := rk817_codec.o
 snd-soc-rl6231-objs := rl6231.o
@@ -551,6 +552,7 @@ obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
 obj-$(CONFIG_SND_SOC_PEB2466)	+= snd-soc-peb2466.o
+obj-$(CONFIG_SND_SOC_PEF2256)	+= snd-soc-pef2256.o
 obj-$(CONFIG_SND_SOC_RK3328)	+= snd-soc-rk3328.o
 obj-$(CONFIG_SND_SOC_RK817)	+= snd-soc-rk817.o
 obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
diff --git a/sound/soc/codecs/pef2256-codec.c b/sound/soc/codecs/pef2256-codec.c
new file mode 100644
index 000000000000..d87fdc771a30
--- /dev/null
+++ b/sound/soc/codecs/pef2256-codec.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// pef2256.c  --  Lantiq PEF2256 ALSA SoC driver
+//
+// Copyright 2023 CS GROUP France
+//
+// Author: Herve Codina <herve.codina@bootlin.com>
+
+#include <linux/clk.h>
+#include <linux/mfd/pef2256.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define PEF2256_NB_CHANNEL	32
+#define PEF2256_JACK_MASK (SND_JACK_LINEIN | SND_JACK_LINEOUT)
+
+struct pef2256_codec {
+	struct pef2256 *pef2256;
+	struct device *dev;
+	struct snd_soc_jack jack;
+	struct notifier_block nb;
+	struct work_struct carrier_work;
+	int max_chan_playback;
+	int max_chan_capture;
+};
+
+static int pef2256_dai_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+				    unsigned int rx_mask, int slots, int width)
+{
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+
+	switch (width) {
+	case 0:
+		/* Not set -> default 8 */
+	case 8:
+		break;
+	default:
+		dev_err(dai->dev, "tdm slot width %d not supported\n", width);
+		return -EINVAL;
+	}
+
+	pef2256->max_chan_playback = hweight32(tx_mask);
+	if (pef2256->max_chan_playback > PEF2256_NB_CHANNEL) {
+		dev_err(dai->dev, "too much tx slots defined (mask = 0x%x) support max %d\n",
+			tx_mask, PEF2256_NB_CHANNEL);
+		return -EINVAL;
+	}
+
+	pef2256->max_chan_capture = hweight32(rx_mask);
+	if (pef2256->max_chan_capture > PEF2256_NB_CHANNEL) {
+		dev_err(dai->dev, "too much rx slots defined (mask = 0x%x) support max %d\n",
+			rx_mask, PEF2256_NB_CHANNEL);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * The constraints for format/channel is to match with the number of 8bit
+ * time-slots available.
+ */
+static int pef2256_dai_hw_rule_channels_by_format(struct snd_soc_dai *dai,
+						  struct snd_pcm_hw_params *params,
+						  unsigned int nb_ts)
+{
+	struct snd_interval *c = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	snd_pcm_format_t format = params_format(params);
+	struct snd_interval ch = {0};
+
+	switch (snd_pcm_format_physical_width(format)) {
+	case 8:
+		ch.max = nb_ts;
+		break;
+	case 16:
+		ch.max = nb_ts/2;
+		break;
+	case 32:
+		ch.max = nb_ts/4;
+		break;
+	case 64:
+		ch.max = nb_ts/8;
+		break;
+	default:
+		dev_err(dai->dev, "format physical width %u not supported\n",
+			snd_pcm_format_physical_width(format));
+		return -EINVAL;
+	}
+
+	ch.min = ch.max ? 1 : 0;
+
+	return snd_interval_refine(c, &ch);
+}
+
+static int pef2256_dai_hw_rule_playback_channels_by_format(struct snd_pcm_hw_params *params,
+							   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_soc_dai *dai = rule->private;
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+
+	return pef2256_dai_hw_rule_channels_by_format(dai, params, pef2256->max_chan_playback);
+}
+
+static int pef2256_dai_hw_rule_capture_channels_by_format(struct snd_pcm_hw_params *params,
+							  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_soc_dai *dai = rule->private;
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+
+	return pef2256_dai_hw_rule_channels_by_format(dai, params, pef2256->max_chan_capture);
+}
+
+static int pef2256_dai_hw_rule_format_by_channels(struct snd_soc_dai *dai,
+						  struct snd_pcm_hw_params *params,
+						  unsigned int nb_ts)
+{
+	struct snd_mask *f_old = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	unsigned int channels = params_channels(params);
+	unsigned int slot_width;
+	struct snd_mask f_new;
+	unsigned int i;
+
+	if (!channels || channels > nb_ts) {
+		dev_err(dai->dev, "channels %u not supported\n", nb_ts);
+		return -EINVAL;
+	}
+
+	slot_width = (nb_ts / channels) * 8;
+
+	snd_mask_none(&f_new);
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		if (snd_mask_test(f_old, i)) {
+			if (snd_pcm_format_physical_width(i) <= slot_width)
+				snd_mask_set(&f_new, i);
+		}
+	}
+
+	return snd_mask_refine(f_old, &f_new);
+}
+
+static int pef2256_dai_hw_rule_playback_format_by_channels(struct snd_pcm_hw_params *params,
+							   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_soc_dai *dai = rule->private;
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+
+	return pef2256_dai_hw_rule_format_by_channels(dai, params, pef2256->max_chan_playback);
+}
+
+static int pef2256_dai_hw_rule_capture_format_by_channels(struct snd_pcm_hw_params *params,
+							  struct snd_pcm_hw_rule *rule)
+{
+	struct snd_soc_dai *dai = rule->private;
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+
+	return pef2256_dai_hw_rule_format_by_channels(dai, params, pef2256->max_chan_capture);
+}
+
+static u64 pef2256_formats(u8 nb_ts)
+{
+	u64 formats;
+	unsigned int chan_width;
+	unsigned int format_width;
+	int i;
+
+	if (!nb_ts)
+		return 0;
+
+	formats = 0;
+	chan_width = nb_ts * 8;
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		/* Support physical width multiple of 8bit */
+		format_width = snd_pcm_format_physical_width(i);
+		if (format_width == 0 || format_width % 8)
+			continue;
+
+		/*
+		 * And support physical width that can fit N times in the
+		 * channel
+		 */
+		if (format_width > chan_width || chan_width % format_width)
+			continue;
+
+		formats |= (1ULL << i);
+	}
+	return formats;
+}
+
+static int pef2256_dai_startup(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(dai->component);
+	snd_pcm_hw_rule_func_t hw_rule_channels_by_format;
+	snd_pcm_hw_rule_func_t hw_rule_format_by_channels;
+	unsigned int frame_bits;
+	u64 format;
+	int ret;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+		format = pef2256_formats(pef2256->max_chan_capture);
+		hw_rule_channels_by_format = pef2256_dai_hw_rule_capture_channels_by_format;
+		hw_rule_format_by_channels = pef2256_dai_hw_rule_capture_format_by_channels;
+		frame_bits = pef2256->max_chan_capture * 8;
+	} else {
+		format = pef2256_formats(pef2256->max_chan_playback);
+		hw_rule_channels_by_format = pef2256_dai_hw_rule_playback_channels_by_format;
+		hw_rule_format_by_channels = pef2256_dai_hw_rule_playback_format_by_channels;
+		frame_bits = pef2256->max_chan_playback * 8;
+	}
+
+	ret = snd_pcm_hw_constraint_mask64(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_FORMAT, format);
+	if (ret) {
+		dev_err(dai->dev, "Failed to add format constraint (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  hw_rule_channels_by_format, dai,
+				  SNDRV_PCM_HW_PARAM_FORMAT, -1);
+	if (ret) {
+		dev_err(dai->dev, "Failed to add channels rule (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0,  SNDRV_PCM_HW_PARAM_FORMAT,
+				  hw_rule_format_by_channels, dai,
+				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
+	if (ret) {
+		dev_err(dai->dev, "Failed to add format rule (%d)\n", ret);
+		return ret;
+	}
+
+	ret = snd_pcm_hw_constraint_single(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_FRAME_BITS,
+					   frame_bits);
+	if (ret < 0) {
+		dev_err(dai->dev, "Failed to add frame_bits constraint (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static u64 pef2256_dai_formats[] = {
+	SND_SOC_POSSIBLE_DAIFMT_DSP_B,
+};
+
+static const struct snd_soc_dai_ops pef2256_dai_ops = {
+	.startup	= pef2256_dai_startup,
+	.set_tdm_slot	= pef2256_dai_set_tdm_slot,
+	.auto_selectable_formats     = pef2256_dai_formats,
+	.num_auto_selectable_formats = ARRAY_SIZE(pef2256_dai_formats),
+};
+
+static struct snd_soc_dai_driver pef2256_dai_driver = {
+	.name = "pef2256",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = PEF2256_NB_CHANNEL,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = U64_MAX, /* Will be refined on DAI .startup() */
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = PEF2256_NB_CHANNEL,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = U64_MAX, /* Will be refined on DAI .startup() */
+	},
+	.ops = &pef2256_dai_ops,
+};
+
+static void pef2256_carrier_work(struct work_struct *work)
+{
+	struct pef2256_codec *pef2256 = container_of(work, struct pef2256_codec, carrier_work);
+	int status;
+
+	status = pef2256_get_carrier(pef2256->pef2256) ? PEF2256_JACK_MASK : 0;
+	snd_soc_jack_report(&pef2256->jack, status, PEF2256_JACK_MASK);
+}
+
+static int pef2256_carrier_notifier(struct notifier_block *nb, unsigned long action,
+				    void *data)
+{
+	struct pef2256_codec *pef2256 = container_of(nb, struct pef2256_codec, nb);
+
+	switch (action) {
+	case PEF2256_EVENT_CARRIER:
+		queue_work(system_power_efficient_wq, &pef2256->carrier_work);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int pef2256_component_probe(struct snd_soc_component *component)
+{
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(component);
+	char *name;
+	int ret;
+
+	INIT_WORK(&pef2256->carrier_work, pef2256_carrier_work);
+
+	name = "carrier";
+	if (component->name_prefix) {
+		name = kasprintf(GFP_KERNEL, "%s carrier", component->name_prefix);
+		if (!name)
+			return -ENOMEM;
+	}
+
+	ret = snd_soc_card_jack_new(component->card, name, PEF2256_JACK_MASK, &pef2256->jack);
+	if (component->name_prefix)
+		kfree(name); /* A copy is done by snd_soc_card_jack_new */
+	if (ret) {
+		dev_err(component->dev, "Cannot create jack\n");
+		return ret;
+	}
+
+	pef2256->nb.notifier_call = pef2256_carrier_notifier;
+	ret = pef2256_register_event_notifier(pef2256->pef2256, &pef2256->nb);
+	if (ret) {
+		dev_err(component->dev, "Cannot register event notifier\n");
+		return ret;
+	}
+
+	/* Queue work to set the initial value */
+	queue_work(system_power_efficient_wq, &pef2256->carrier_work);
+
+	return 0;
+}
+
+static void pef2256_component_remove(struct snd_soc_component *component)
+{
+	struct pef2256_codec *pef2256 = snd_soc_component_get_drvdata(component);
+
+	pef2256_unregister_event_notifier(pef2256->pef2256, &pef2256->nb);
+	cancel_work_sync(&pef2256->carrier_work);
+}
+
+static const struct snd_soc_component_driver pef2256_component_driver = {
+	.probe		= pef2256_component_probe,
+	.remove		= pef2256_component_remove,
+	.endianness	= 1,
+};
+
+static int pef2256_codec_probe(struct platform_device *pdev)
+{
+	struct pef2256_codec *pef2256;
+
+	pef2256 = devm_kzalloc(&pdev->dev, sizeof(*pef2256), GFP_KERNEL);
+	if (!pef2256)
+		return -ENOMEM;
+
+	pef2256->dev = &pdev->dev;
+	pef2256->pef2256 = dev_get_drvdata(pef2256->dev->parent);
+
+	platform_set_drvdata(pdev, pef2256);
+
+	return devm_snd_soc_register_component(&pdev->dev, &pef2256_component_driver,
+					       &pef2256_dai_driver, 1);
+}
+
+static const struct of_device_id pef2256_codec_of_match[] = {
+	{ .compatible = "lantiq,pef2256-codec" },
+	{} /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, pef2256_codec_of_match);
+
+static struct platform_driver pef2256_codec_driver = {
+	.driver = {
+		.name = "lantiq-pef2256-codec",
+		.of_match_table = pef2256_codec_of_match,
+	},
+	.probe = pef2256_codec_probe,
+};
+module_platform_driver(pef2256_codec_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("PEF2256 ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

