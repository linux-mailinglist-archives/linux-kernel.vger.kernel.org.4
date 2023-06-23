Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019F873B322
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjFWJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjFWI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:59:46 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3BB2684;
        Fri, 23 Jun 2023 01:59:15 -0700 (PDT)
X-GND-Sasl: herve.codina@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687510744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g4cV75C48WjlZ1uH7x686man+Y4XKaXT2s76C7ByXHU=;
        b=cNIG7a7DvSGzDkzG7jWngfe1hIsCX42FUD/E9hv3czwV94WBADyNaPWR1ORdyUGjvG0nCH
        jDUno1CmlOL2ftVZ36lOgj78llIusMdEdB4LSA28nrdLKdUc+CkqPN0uEtsYTwuig5ms2c
        OnnuxwRLQpUectd6SLZM1uqdBsfsw2NgcT2ZSBIshGMNmrM6rggeFctaSMcwxWLz7uyZzN
        uxsKDAPFvV2X2CRQjdBYuMC4Qf88HbTP+pfx6BXNFtvsi0EIBsGLYS8USn2FhHDOZjgJ2N
        qQOGUI8vgX7aICMAhJ7IoZpnYIaiZuD7gjOAY3HyE7n304RacWH9abuoPGjD4w==
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
X-GND-Sasl: herve.codina@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A68C9E000D;
        Fri, 23 Jun 2023 08:59:02 +0000 (UTC)
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 12/13] ASoC: codecs: Add support for the generic IIO auxiliary devices
Date:   Fri, 23 Jun 2023 10:58:29 +0200
Message-Id: <20230623085830.749991-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623085830.749991-1-herve.codina@bootlin.com>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial I/O devices can be present in the audio path.
These devices needs to be used as audio components in order to be
fully integrated in the audio path.

This support allows to consider these Industrial I/O devices as
auxiliary audio devices and allows one to control them using mixer
controls.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 sound/soc/codecs/Kconfig         |  12 ++
 sound/soc/codecs/Makefile        |   2 +
 sound/soc/codecs/audio-iio-aux.c | 344 +++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)
 create mode 100644 sound/soc/codecs/audio-iio-aux.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 44806bfe8ee5..92b7c417f1b2 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -53,6 +53,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_AK5558
 	imply SND_SOC_ALC5623
 	imply SND_SOC_ALC5632
+	imply SND_SOC_AUDIO_IIO_AUX
 	imply SND_SOC_AW8738
 	imply SND_SOC_AW88395
 	imply SND_SOC_BT_SCO
@@ -608,6 +609,17 @@ config SND_SOC_ALC5632
 	tristate
 	depends on I2C
 
+config SND_SOC_AUDIO_IIO_AUX
+	tristate "Audio IIO Auxiliary device"
+	depends on IIO
+	help
+	  Enable support for Industrial I/O devices as audio auxiliary devices.
+	  This allows to have an IIO device present in the audio path and
+	  controlled using mixer controls.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-soc-audio-iio-aux.
+
 config SND_SOC_AW8738
 	tristate "Awinic AW8738 Audio Amplifier"
 	select GPIOLIB
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 2c45c2f97e4e..f2828d3616c5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -45,6 +45,7 @@ snd-soc-ak4671-objs := ak4671.o
 snd-soc-ak5386-objs := ak5386.o
 snd-soc-ak5558-objs := ak5558.o
 snd-soc-arizona-objs := arizona.o arizona-jack.o
+snd-soc-audio-iio-aux-objs := audio-iio-aux.o
 snd-soc-aw8738-objs := aw8738.o
 snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
 snd-soc-aw88395-objs := aw88395/aw88395.o \
@@ -421,6 +422,7 @@ obj-$(CONFIG_SND_SOC_AK5558)	+= snd-soc-ak5558.o
 obj-$(CONFIG_SND_SOC_ALC5623)    += snd-soc-alc5623.o
 obj-$(CONFIG_SND_SOC_ALC5632)	+= snd-soc-alc5632.o
 obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
+obj-$(CONFIG_SND_SOC_AUDIO_IIO_AUX)	+= snd-soc-audio-iio-aux.o
 obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
 obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
 obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
diff --git a/sound/soc/codecs/audio-iio-aux.c b/sound/soc/codecs/audio-iio-aux.c
new file mode 100644
index 000000000000..a8bf14239bd7
--- /dev/null
+++ b/sound/soc/codecs/audio-iio-aux.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// ALSA SoC glue to use IIO devices as audio components
+//
+// Copyright 2023 CS GROUP France
+//
+// Author: Herve Codina <herve.codina@bootlin.com>
+
+#include <linux/iio/consumer.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string_helpers.h>
+
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+struct audio_iio_aux_chan {
+	struct iio_channel *iio_chan;
+	const char *name;
+	int max;
+	int min;
+	bool is_invert_range;
+};
+
+struct audio_iio_aux {
+	struct device *dev;
+	struct audio_iio_aux_chan *chans;
+	unsigned int num_chans;
+};
+
+static int audio_iio_aux_info_volsw(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	struct audio_iio_aux_chan *chan = (struct audio_iio_aux_chan *)kcontrol->private_value;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = chan->max - chan->min;
+	uinfo->type = (uinfo->value.integer.max == 1) ?
+			SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	return 0;
+}
+
+static int audio_iio_aux_get_volsw(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct audio_iio_aux_chan *chan = (struct audio_iio_aux_chan *)kcontrol->private_value;
+	int max = chan->max;
+	int min = chan->min;
+	bool invert_range = chan->is_invert_range;
+	int ret;
+	int val;
+
+	ret = iio_read_channel_raw(chan->iio_chan, &val);
+	if (ret < 0)
+		return ret;
+
+	ucontrol->value.integer.value[0] = val - min;
+	if (invert_range)
+		ucontrol->value.integer.value[0] = max - ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static int audio_iio_aux_put_volsw(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct audio_iio_aux_chan *chan = (struct audio_iio_aux_chan *)kcontrol->private_value;
+	int max = chan->max;
+	int min = chan->min;
+	bool invert_range = chan->is_invert_range;
+	int val;
+	int ret;
+	int tmp;
+
+	val = ucontrol->value.integer.value[0];
+	if (val < 0)
+		return -EINVAL;
+	if (val > max - min)
+		return -EINVAL;
+
+	val = val + min;
+	if (invert_range)
+		val = max - val;
+
+	ret = iio_read_channel_raw(chan->iio_chan, &tmp);
+	if (ret < 0)
+		return ret;
+
+	if (tmp == val)
+		return 0;
+
+	ret = iio_write_channel_raw(chan->iio_chan, val);
+	if (ret)
+		return ret;
+
+	return 1; /* The value changed */
+}
+
+static int audio_iio_aux_add_controls(struct snd_soc_component *component,
+				      struct audio_iio_aux_chan *chan)
+{
+	struct snd_kcontrol_new control = {
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = chan->name,
+		.info = audio_iio_aux_info_volsw,
+		.get = audio_iio_aux_get_volsw,
+		.put = audio_iio_aux_put_volsw,
+		.private_value = (unsigned long)chan,
+	};
+
+	return snd_soc_add_component_controls(component, &control, 1);
+}
+
+/*
+ * These data could be on stack but they are pretty big.
+ * As ASoC internally copy them and protect them against concurrent accesses
+ * (snd_soc_bind_card() protects using client_mutex), keep them in the global
+ * data area.
+ */
+static struct snd_soc_dapm_widget widgets[3];
+static struct snd_soc_dapm_route routes[2];
+
+/* Be sure sizes are correct (need 3 widgets and 2 routes) */
+static_assert(ARRAY_SIZE(widgets) >= 3, "3 widgets are needed");
+static_assert(ARRAY_SIZE(routes) >= 2, "2 routes are needed");
+
+static int audio_iio_aux_add_dapms(struct snd_soc_component *component,
+				   struct audio_iio_aux_chan *chan)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	char *output_name;
+	char *input_name;
+	char *pga_name;
+	int ret;
+
+	input_name = kasprintf(GFP_KERNEL, "%s IN", chan->name);
+	if (!input_name)
+		return -ENOMEM;
+
+	output_name = kasprintf(GFP_KERNEL, "%s OUT", chan->name);
+	if (!output_name) {
+		ret = -ENOMEM;
+		goto out_free_input_name;
+	}
+
+	pga_name = kasprintf(GFP_KERNEL, "%s PGA", chan->name);
+	if (!pga_name) {
+		ret = -ENOMEM;
+		goto out_free_output_name;
+	}
+
+	widgets[0] = SND_SOC_DAPM_INPUT(input_name);
+	widgets[1] = SND_SOC_DAPM_OUTPUT(output_name);
+	widgets[2] = SND_SOC_DAPM_PGA(pga_name, SND_SOC_NOPM, 0, 0, NULL, 0);
+	ret = snd_soc_dapm_new_controls(dapm, widgets, 3);
+	if (ret)
+		goto out_free_pga_name;
+
+	routes[0].sink = pga_name;
+	routes[0].control = NULL;
+	routes[0].source = input_name;
+	routes[1].sink = output_name;
+	routes[1].control = NULL;
+	routes[1].source = pga_name;
+	ret = snd_soc_dapm_add_routes(dapm, routes, 2);
+
+	/* Allocated names are no more needed (duplicated in ASoC internals) */
+
+out_free_pga_name:
+	kfree(pga_name);
+out_free_output_name:
+	kfree(output_name);
+out_free_input_name:
+	kfree(input_name);
+	return ret;
+}
+
+static int audio_iio_aux_component_probe(struct snd_soc_component *component)
+{
+	struct audio_iio_aux *iio_aux = snd_soc_component_get_drvdata(component);
+	struct audio_iio_aux_chan *chan;
+	int ret;
+	int i;
+
+	for (i = 0; i < iio_aux->num_chans; i++) {
+		chan = iio_aux->chans + i;
+
+		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
+		if (ret)
+			return dev_err_probe(component->dev, ret,
+					     "chan[%d] %s: Cannot get max raw value\n",
+					     i, chan->name);
+
+		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
+		if (ret)
+			return dev_err_probe(component->dev, ret,
+					     "chan[%d] %s: Cannot get min raw value\n",
+					     i, chan->name);
+
+		if (chan->min > chan->max) {
+			/*
+			 * This should never happen but to avoid any check
+			 * later, just swap values here to ensure that the
+			 * minimum value is lower than the maximum value.
+			 */
+			dev_dbg(component->dev, "chan[%d] %s: Swap min and max\n",
+				i, chan->name);
+			swap(chan->min, chan->max);
+		}
+
+		/* Set initial value */
+		ret = iio_write_channel_raw(chan->iio_chan,
+					    chan->is_invert_range ? chan->max : chan->min);
+		if (ret)
+			return dev_err_probe(component->dev, ret,
+					     "chan[%d] %s: Cannot set initial value\n",
+					     i, chan->name);
+
+		ret = audio_iio_aux_add_controls(component, chan);
+		if (ret)
+			return ret;
+
+		ret = audio_iio_aux_add_dapms(component, chan);
+		if (ret)
+			return ret;
+
+		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
+			i, chan->name, chan->min, chan->max,
+			str_on_off(chan->is_invert_range));
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver audio_iio_aux_component_driver = {
+	.probe = audio_iio_aux_component_probe,
+};
+
+static int audio_iio_aux_probe(struct platform_device *pdev)
+{
+	struct audio_iio_aux_chan *iio_aux_chan;
+	struct device *dev = &pdev->dev;
+	struct audio_iio_aux *iio_aux;
+	const char **names;
+	u32 *invert_ranges;
+	int count;
+	int ret;
+	int i;
+
+	iio_aux = devm_kzalloc(dev, sizeof(*iio_aux), GFP_KERNEL);
+	if (!iio_aux)
+		return -ENOMEM;
+
+	iio_aux->dev = dev;
+
+	count = device_property_string_array_count(dev, "io-channel-names");
+	if (count < 0)
+		return dev_err_probe(dev, count, "failed to count io-channel-names\n");
+
+	iio_aux->num_chans = count;
+
+	iio_aux->chans = devm_kmalloc_array(dev, iio_aux->num_chans,
+					    sizeof(*iio_aux->chans), GFP_KERNEL);
+	if (!iio_aux->chans)
+		return -ENOMEM;
+
+	names = kcalloc(iio_aux->num_chans, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return -ENOMEM;
+
+	invert_ranges = kcalloc(iio_aux->num_chans, sizeof(*invert_ranges), GFP_KERNEL);
+	if (!invert_ranges) {
+		ret = -ENOMEM;
+		goto out_free_names;
+	}
+
+	ret = device_property_read_string_array(dev, "io-channel-names",
+						names, iio_aux->num_chans);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to read io-channel-names\n");
+		goto out_free_invert_ranges;
+	}
+
+	/*
+	 * snd-control-invert-range is optional and can contain fewer items
+	 * than the number of channels. Unset values default to 0.
+	 */
+	count = device_property_count_u32(dev, "snd-control-invert-range");
+	if (count > 0) {
+		count = min_t(unsigned int, count, iio_aux->num_chans);
+		ret = device_property_read_u32_array(dev, "snd-control-invert-range",
+						     invert_ranges, count);
+		if (ret < 0) {
+			dev_err_probe(dev, ret, "failed to read snd-control-invert-range\n");
+			goto out_free_invert_ranges;
+		}
+	}
+
+	for (i = 0; i < iio_aux->num_chans; i++) {
+		iio_aux_chan = iio_aux->chans + i;
+		iio_aux_chan->name = names[i];
+		iio_aux_chan->is_invert_range = invert_ranges[i];
+
+		iio_aux_chan->iio_chan = devm_iio_channel_get(dev, iio_aux_chan->name);
+		if (IS_ERR(iio_aux_chan->iio_chan)) {
+			ret = PTR_ERR(iio_aux_chan->iio_chan);
+			dev_err_probe(dev, ret, "get IIO channel '%s' failed\n",
+				      iio_aux_chan->name);
+			goto out_free_invert_ranges;
+		}
+	}
+
+	platform_set_drvdata(pdev, iio_aux);
+
+	ret = devm_snd_soc_register_component(dev, &audio_iio_aux_component_driver,
+					      NULL, 0);
+out_free_invert_ranges:
+	kfree(invert_ranges);
+out_free_names:
+	kfree(names);
+	return ret;
+}
+
+static const struct of_device_id audio_iio_aux_ids[] = {
+	{ .compatible = "audio-iio-aux" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, audio_iio_aux_ids);
+
+static struct platform_driver audio_iio_aux_driver = {
+	.driver = {
+		.name = "audio-iio-aux",
+		.of_match_table = audio_iio_aux_ids,
+	},
+	.probe = audio_iio_aux_probe,
+};
+module_platform_driver(audio_iio_aux_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("IIO ALSA SoC aux driver");
+MODULE_LICENSE("GPL");
-- 
2.40.1

