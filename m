Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A9D6EAAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjDUMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjDUMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:43:15 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA8CC16;
        Fri, 21 Apr 2023 05:42:45 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D1B2940002;
        Fri, 21 Apr 2023 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682080963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=169cNx1n7ZwFZR/MsassqaqgZLC71GGKyN2GetFRRIU=;
        b=LugssXjr9Rhn0BhOfTceS1X+dPtcN7Fy/iBAVZrAT1BBweYuSNVmaU2HYy58w4qYKOQtFs
        sytRpTW18QdAm3IQny91Lq5Qle9WkA81VKKvR8MMHflc3UYhg/5RxLSRrjw1kwrXfgEzOh
        07K44MwrFpOHaQr1kwsOeZxUD3IJV7rnxVe4qdVSo9KIgZe2dNEJlFb7CYHoJy2Hr7Mgx9
        0xWy3r75PmbFiYf4xsKF2Gr5N3e+J81WKGSV41LXDEB/OBg9PmAeRYcihxRkBZtlgxJ1Rz
        F/RXzj7lAnRxMb/ENX1QV9DPOv6zUdmz0+NVDED3v1NHw1QpDmvIcXHj9sSuJQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 4/4] ASoC: codecs: Add support for the generic IIO auxiliary devices
Date:   Fri, 21 Apr 2023 14:41:22 +0200
Message-Id: <20230421124122.324820-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421124122.324820-1-herve.codina@bootlin.com>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Industrial I/O devices can be present in the audio path.
These devices needs to be used as audio components in order to be fully
integrated in the audio path.

This support allows to consider these Industrial I/O devices as auxliary
audio devices and allows to control them using mixer controls.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/Kconfig          |  12 ++
 sound/soc/codecs/Makefile         |   2 +
 sound/soc/codecs/simple-iio-aux.c | 307 ++++++++++++++++++++++++++++++
 3 files changed, 321 insertions(+)
 create mode 100644 sound/soc/codecs/simple-iio-aux.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4f78da914fc7..ee87e0125bfd 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -211,6 +211,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_SGTL5000
 	imply SND_SOC_SI476X
 	imply SND_SOC_SIMPLE_AMPLIFIER
+	imply SND_SOC_SIMPLE_IIO_AUX
 	imply SND_SOC_SIMPLE_MUX
 	imply SND_SOC_SMA1303
 	imply SND_SOC_SPDIF
@@ -1555,6 +1556,17 @@ config SND_SOC_SIGMADSP_REGMAP
 config SND_SOC_SIMPLE_AMPLIFIER
 	tristate "Simple Audio Amplifier"
 
+config SND_SOC_SIMPLE_IIO_AUX
+	tristate "Simple IIO Auxiliary device"
+	depends on IIO
+	help
+	  Enable support for Industrial I/O devices as audio auxiliary devices.
+	  This allows to have an IIO device present in the audio path and
+	  controlled using mixer controls.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-soc-simple-iio-aux.
+
 config SND_SOC_SIMPLE_MUX
 	tristate "Simple Audio Mux"
 	depends on GPIOLIB
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 11bd66d46f7b..f2b1ee22b57c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -359,6 +359,7 @@ snd-soc-zl38060-objs := zl38060.o
 snd-soc-max9877-objs := max9877.o
 snd-soc-max98504-objs := max98504.o
 snd-soc-simple-amplifier-objs := simple-amplifier.o
+snd-soc-simple-iio-aux-objs := simple-iio-aux.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
 snd-soc-tas2552-objs := tas2552.o
 snd-soc-tas2562-objs := tas2562.o
@@ -729,6 +730,7 @@ obj-$(CONFIG_SND_SOC_ZL38060)	+= snd-soc-zl38060.o
 obj-$(CONFIG_SND_SOC_MAX9877)	+= snd-soc-max9877.o
 obj-$(CONFIG_SND_SOC_MAX98504)	+= snd-soc-max98504.o
 obj-$(CONFIG_SND_SOC_SIMPLE_AMPLIFIER)	+= snd-soc-simple-amplifier.o
+obj-$(CONFIG_SND_SOC_SIMPLE_IIO_AUX)	+= snd-soc-simple-iio-aux.o
 obj-$(CONFIG_SND_SOC_TPA6130A2)	+= snd-soc-tpa6130a2.o
 obj-$(CONFIG_SND_SOC_LPASS_MACRO_COMMON)	+= snd-soc-lpass-macro-common.o
 obj-$(CONFIG_SND_SOC_LPASS_WSA_MACRO)	+= snd-soc-lpass-wsa-macro.o
diff --git a/sound/soc/codecs/simple-iio-aux.c b/sound/soc/codecs/simple-iio-aux.c
new file mode 100644
index 000000000000..77f7fb11e416
--- /dev/null
+++ b/sound/soc/codecs/simple-iio-aux.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// simple-iio-aux.c  --  ALSA SoC glue to use IIO devices as audio components
+//
+// Copyright 2023 CS GROUP France
+//
+// Author: Herve Codina <herve.codina@bootlin.com>
+
+#include <linux/iio/consumer.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+struct simple_iio_aux_chan {
+	struct iio_channel *iio_chan;
+	const char *name;
+	bool is_inverted;
+	int max;
+	int min;
+};
+
+struct simple_iio_aux {
+	struct device *dev;
+	struct simple_iio_aux_chan *chans;
+	unsigned int num_chans;
+};
+
+static int simple_iio_aux_info_volsw(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	struct simple_iio_aux_chan *chan =
+		(struct simple_iio_aux_chan *)kcontrol->private_value;
+
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = chan->max - chan->min;
+	uinfo->type = (uinfo->value.integer.max == 1) ?
+			SNDRV_CTL_ELEM_TYPE_BOOLEAN : SNDRV_CTL_ELEM_TYPE_INTEGER;
+	return 0;
+}
+
+static int simple_iio_aux_get_volsw(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
+	int max = chan->max;
+	int min = chan->min;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = chan->is_inverted;
+	int ret;
+	int val;
+
+	ret = iio_read_channel_raw(chan->iio_chan, &val);
+	if (ret < 0)
+		return ret;
+
+	ucontrol->value.integer.value[0] = (val & mask) - min;
+	if (invert)
+		ucontrol->value.integer.value[0] = max - ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static int simple_iio_aux_put_volsw(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct simple_iio_aux_chan *chan = (struct simple_iio_aux_chan *)kcontrol->private_value;
+	int max = chan->max;
+	int min = chan->min;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = chan->is_inverted;
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
+	val = (val + min) & mask;
+	if (invert)
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
+static int simple_iio_aux_add_controls(struct snd_soc_component *component,
+				       struct simple_iio_aux_chan *chan)
+{
+	struct snd_kcontrol_new control = {0};
+
+	control.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	control.name = chan->name;
+	control.info = simple_iio_aux_info_volsw;
+	control.get = simple_iio_aux_get_volsw;
+	control.put = simple_iio_aux_put_volsw;
+	control.private_value = (unsigned long)chan;
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
+static struct snd_soc_dapm_widget widgets[3] = {0};
+static struct snd_soc_dapm_route routes[2] = {0};
+
+static int simple_iio_aux_add_dapms(struct snd_soc_component *component,
+				    struct simple_iio_aux_chan *chan)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	char *input_name = NULL;
+	char *output_name = NULL;
+	char *pga_name = NULL;
+	int ret;
+
+	input_name = kasprintf(GFP_KERNEL, "%s IN", chan->name);
+	if (!input_name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	output_name = kasprintf(GFP_KERNEL, "%s OUT", chan->name);
+	if (!output_name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	pga_name = kasprintf(GFP_KERNEL, "%s PGA", chan->name);
+	if (!pga_name) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(widgets) < 3);
+	widgets[0] = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(input_name));
+	widgets[1] = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_OUTPUT(output_name));
+	widgets[2] = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_PGA(pga_name, SND_SOC_NOPM, 0, 0, NULL, 0));
+	ret = snd_soc_dapm_new_controls(dapm, widgets, 3);
+	if (ret)
+		goto end;
+
+	BUILD_BUG_ON(ARRAY_SIZE(routes) < 2);
+	routes[0].sink = pga_name;
+	routes[0].control = NULL;
+	routes[0].source = input_name;
+	routes[1].sink = output_name;
+	routes[1].control = NULL;
+	routes[1].source = pga_name;
+	ret = snd_soc_dapm_add_routes(dapm, routes, 2);
+
+end:
+	/* Allocated names are no more needed (duplicated in ASoC internals) */
+	kfree(pga_name);
+	kfree(output_name);
+	kfree(input_name);
+
+	return ret;
+}
+
+static int simple_iio_aux_component_probe(struct snd_soc_component *component)
+{
+	struct simple_iio_aux *iio_aux = snd_soc_component_get_drvdata(component);
+	struct simple_iio_aux_chan *chan;
+	int ret;
+	int i;
+
+	for (i = 0; i < iio_aux->num_chans; i++) {
+		chan = iio_aux->chans + i;
+
+		ret = iio_read_max_channel_raw(chan->iio_chan, &chan->max);
+		if (ret) {
+			dev_err(component->dev, "chan[%d] %s: Cannot get max raw value (%d)\n",
+				i, chan->name, ret);
+			return ret;
+		}
+
+		ret = iio_read_min_channel_raw(chan->iio_chan, &chan->min);
+		if (ret) {
+			dev_err(component->dev, "chan[%d] %s: Cannot get min raw value (%d)\n",
+				i, chan->name, ret);
+			return ret;
+		}
+
+		/* Set initial value */
+		ret = iio_write_channel_raw(chan->iio_chan,
+					    chan->is_inverted ? chan->max : chan->min);
+		if (ret) {
+			dev_err(component->dev, "chan[%d] %s: Cannot set initial value (%d)\n",
+				i, chan->name, ret);
+			return ret;
+		}
+
+		ret = simple_iio_aux_add_controls(component, chan);
+		if (ret)
+			return ret;
+
+		ret = simple_iio_aux_add_dapms(component, chan);
+		if (ret)
+			return ret;
+
+		dev_dbg(component->dev, "chan[%d]: Added %s (min=%d, max=%d, invert=%s)\n",
+			i, chan->name, chan->min, chan->max,
+			chan->is_inverted ? "on" : "off");
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver simple_iio_aux_component_driver = {
+	.probe = simple_iio_aux_component_probe,
+};
+
+static int simple_iio_aux_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct simple_iio_aux_chan *iio_aux_chan;
+	struct simple_iio_aux *iio_aux;
+	int count;
+	u32 tmp;
+	int ret;
+	int i;
+
+	iio_aux = devm_kzalloc(&pdev->dev, sizeof(*iio_aux), GFP_KERNEL);
+	if (!iio_aux)
+		return -ENOMEM;
+
+	iio_aux->dev = &pdev->dev;
+
+	count = of_property_count_strings(np, "io-channel-names");
+	if (count < 0) {
+		dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names\n", np);
+		return count;
+	}
+
+	iio_aux->chans = devm_kmalloc_array(&pdev->dev, count,
+					    sizeof(*iio_aux->chans), GFP_KERNEL);
+	if (!iio_aux->chans)
+		return -ENOMEM;
+	iio_aux->num_chans = count;
+
+	for (i = 0; i < iio_aux->num_chans; i++) {
+		iio_aux_chan = iio_aux->chans + i;
+
+		ret = of_property_read_string_index(np, "io-channel-names", i,
+						    &iio_aux_chan->name);
+		if (ret < 0) {
+			dev_err(iio_aux->dev, "%pOF: failed to read io-channel-names[%d]\n", np, i);
+			return ret;
+		}
+
+		iio_aux_chan->iio_chan = devm_iio_channel_get(iio_aux->dev, iio_aux_chan->name);
+		if (IS_ERR(iio_aux_chan->iio_chan)) {
+			ret = PTR_ERR(iio_aux_chan->iio_chan);
+			return dev_err_probe(iio_aux->dev, ret,
+					     "get IIO channel '%s' failed (%d)\n",
+					     iio_aux_chan->name, ret);
+		}
+
+		tmp = 0;
+		of_property_read_u32_index(np, "invert", i, &tmp);
+		iio_aux_chan->is_inverted = !!tmp;
+	}
+
+	platform_set_drvdata(pdev, iio_aux);
+
+	return devm_snd_soc_register_component(iio_aux->dev,
+					       &simple_iio_aux_component_driver,
+					       NULL, 0);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id simple_iio_aux_ids[] = {
+	{ .compatible = "simple-iio-aux", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, simple_iio_aux_ids);
+#endif
+
+static struct platform_driver simple_iio_aux_driver = {
+	.driver = {
+		.name = "simple-iio-aux",
+		.of_match_table = of_match_ptr(simple_iio_aux_ids),
+	},
+	.probe = simple_iio_aux_probe,
+};
+
+module_platform_driver(simple_iio_aux_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("IIO ALSA SoC aux driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

