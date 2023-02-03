Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2D6689790
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjBCLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjBCLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:14:40 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824CC79639;
        Fri,  3 Feb 2023 03:14:38 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id ECB891C0018;
        Fri,  3 Feb 2023 11:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675422877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B138WsRSYzV/E8WT0lEWOcdHSuB7G8fsLebv6AbPjI=;
        b=bJXqoxVtEdLVSsEfkNhCZgLZ2isvARJIOyyihsuwupTJ6KB+aEkxJIxjIGI2QrfAw9DWmE
        KP5g+KD2tOqoSA3apz5T9Bb4Fi5T0wWyKC4S5DJJS2rqWX2WvpIirFm0YqFSbZPJ4gUfkF
        DkM1K9t5nj3fbRBSFEMyKrVcL0XPtjJUWur6IuwtPd1PqEJM4G1fd3D2BWK4LSjxmVE+av
        BpoNUR3T+WFUuODVlZezKdb4MyYe53z2RHB3Dt1cuHmQeqg+CqDvWAHURxe+jRehMJ1rOr
        SVaLddTP83RMblqrMdu/NtKhTo9qqy9EBt/PCOLUDnrg6+DnMfuvIEBaMNSuOQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] ASoC: codecs: Add support for the Renesas X9250 potentiometers
Date:   Fri,  3 Feb 2023 12:14:21 +0100
Message-Id: <20230203111422.142479-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203111422.142479-1-herve.codina@bootlin.com>
References: <20230203111422.142479-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas X9250 is a quad digitally controlled potentiometers.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/Kconfig  |  11 ++
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/x9250.c  | 276 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 sound/soc/codecs/x9250.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 5531bf8d4b3f..19afa0067305 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -314,6 +314,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_WM9713
 	imply SND_SOC_WSA881X
 	imply SND_SOC_WSA883X
+	imply SND_SOC_X9250
 	imply SND_SOC_ZL38060
 	help
 	  Normally ASoC codec drivers are only built if a machine driver which
@@ -2053,6 +2054,16 @@ config SND_SOC_WSA883X
 	  This enables support for Qualcomm WSA8830/WSA8835 Class-D
 	  Smart Speaker Amplifier.
 
+config SND_SOC_X9250
+	tristate "Renesas X9250 quad controlled potentiometers"
+	depends on SPI
+	help
+	  Enable support for the Renesas X9250 quad controlled
+	  potentiometers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-soc-x9250.
+
 config SND_SOC_ZL38060
 	tristate "Microsemi ZL38060 Connected Home Audio Processor"
 	depends on SPI_MASTER
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index bcf95de654fd..a1d6de6a18f6 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -346,6 +346,7 @@ snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
 snd-soc-wsa881x-objs := wsa881x.o
 snd-soc-wsa883x-objs := wsa883x.o
+snd-soc-x9250-objs := x9250.o
 snd-soc-zl38060-objs := zl38060.o
 # Amp
 snd-soc-max9877-objs := max9877.o
@@ -708,6 +709,7 @@ obj-$(CONFIG_SND_SOC_WM_ADSP)	+= snd-soc-wm-adsp.o
 obj-$(CONFIG_SND_SOC_WM_HUBS)	+= snd-soc-wm-hubs.o
 obj-$(CONFIG_SND_SOC_WSA881X)	+= snd-soc-wsa881x.o
 obj-$(CONFIG_SND_SOC_WSA883X)	+= snd-soc-wsa883x.o
+obj-$(CONFIG_SND_SOC_X9250)	+= snd-soc-x9250.o
 obj-$(CONFIG_SND_SOC_ZL38060)	+= snd-soc-zl38060.o
 
 # Amp
diff --git a/sound/soc/codecs/x9250.c b/sound/soc/codecs/x9250.c
new file mode 100644
index 000000000000..14f80009f085
--- /dev/null
+++ b/sound/soc/codecs/x9250.c
@@ -0,0 +1,276 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// x9250.c  --  Renesas X9250 ALSA SoC driver
+//
+// Copyright 2023 CS GROUP France
+//
+// Author: Herve Codina <herve.codina@bootlin.com>
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define X9250_NB_CHANNEL	4
+
+struct x9250 {
+	struct spi_device *spi;
+	u8 spi_tx_buf[3]; /* Cannot use stack area for SPI (dma-safe memory) */
+	u8 spi_rx_buf[3]; /* Cannot use stack area for SPI (dma-safe memory) */
+	int cmd_inv;
+};
+
+#define X9250_CMD_RD_WCR(_p)    (0x90 | (_p))
+#define X9250_CMD_WR_WCR(_p)    (0xa0 | (_p))
+
+static int x9250_write8(struct x9250 *x9250, u8 cmd, u8 val)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = &x9250->spi_tx_buf,
+		.len = 3,
+	};
+
+	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);
+
+	x9250->spi_tx_buf[0] = 0x50;
+	x9250->spi_tx_buf[1] = cmd;
+	x9250->spi_tx_buf[2] = val;
+
+	return spi_sync_transfer(x9250->spi, &xfer, 1);
+}
+
+static int x9250_read8(struct x9250 *x9250, u8 cmd, u8 *val)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = &x9250->spi_tx_buf,
+		.rx_buf = &x9250->spi_rx_buf,
+		.len = 3,
+	};
+	int ret;
+
+	BUILD_BUG_ON(sizeof(x9250->spi_tx_buf) < 3);
+	BUILD_BUG_ON(sizeof(x9250->spi_rx_buf) < 3);
+
+	x9250->spi_tx_buf[0] = 0x50;
+	x9250->spi_tx_buf[1] = cmd;
+
+	ret = spi_sync_transfer(x9250->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	*val = x9250->spi_rx_buf[2];
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget x9250_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("IN0"),
+	SND_SOC_DAPM_INPUT("IN1"),
+	SND_SOC_DAPM_INPUT("IN2"),
+	SND_SOC_DAPM_INPUT("IN3"),
+
+	SND_SOC_DAPM_PGA("CH0 PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("CH1 PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("CH2 PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("CH3 PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_OUTPUT("OUT0"),
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+};
+
+static const struct snd_soc_dapm_route x9250_dapm_routes[] = {
+	{ "CH0 PGA", NULL, "IN0" },
+	{ "CH1 PGA", NULL, "IN1" },
+	{ "CH2 PGA", NULL, "IN2" },
+	{ "CH3 PGA", NULL, "IN3" },
+
+	{ "OUT0", NULL, "CH0 PGA" },
+	{ "OUT1", NULL, "CH1 PGA" },
+	{ "OUT2", NULL, "CH2 PGA" },
+	{ "OUT3", NULL, "CH3 PGA" },
+};
+
+static int x8250_kctrl_cmd_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct x9250 *x9250 = snd_soc_component_get_drvdata(component);
+	int min = mc->min;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
+	int ret;
+	u8 val;
+	u8 wcr;
+
+	wcr = mc->reg;
+	if (wcr > 4)
+		return -EINVAL;
+
+	ret = x9250_read8(x9250, X9250_CMD_RD_WCR(wcr), &val);
+	if (ret)
+		return ret;
+
+	ucontrol->value.integer.value[0] = (val & mask) - min;
+	if (invert)
+		ucontrol->value.integer.value[0] = max - ucontrol->value.integer.value[0];
+
+	return 0;
+}
+
+static int x8250_kctrl_cmd_put(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct x9250 *x9250 = snd_soc_component_get_drvdata(component);
+	int min = mc->min;
+	int max = mc->max;
+	unsigned int mask = (1 << fls(max)) - 1;
+	unsigned int invert = mc->invert;
+	unsigned int val;
+	int ret;
+	u8 wcr;
+	u8 tmp;
+
+	wcr = mc->reg;
+	if (wcr > 4)
+		return -EINVAL;
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
+	ret = x9250_read8(x9250, X9250_CMD_RD_WCR(wcr), &tmp);
+	if (ret)
+		return ret;
+
+	if (tmp == val)
+		return 0;
+
+	ret = x9250_write8(x9250, X9250_CMD_WR_WCR(wcr), val);
+	if (ret)
+		return ret;
+
+	return 1; /* The value changed */
+}
+
+static const struct snd_kcontrol_new x9250_controls_std[] = {
+	SOC_SINGLE_EXT("CMD0", 0, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD1", 1, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD2", 2, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD3", 3, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+};
+
+static const struct snd_kcontrol_new x9250_controls_inv[] = {
+	SOC_SINGLE_EXT("CMD0", 0, 0, 255, 1, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD1", 1, 0, 255, 1, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD2", 2, 0, 255, 1, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+	SOC_SINGLE_EXT("CMD3", 3, 0, 255, 1, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
+};
+
+static int x9250_component_probe(struct snd_soc_component *component)
+{
+	struct x9250 *x9250 = snd_soc_component_get_drvdata(component);
+	struct snd_kcontrol_new control[X9250_NB_CHANNEL];
+	int ret;
+	u8 wcr;
+	int i;
+
+	/* Check arrays compatibility */
+	BUILD_BUG_ON(ARRAY_SIZE(x9250_controls_std) != X9250_NB_CHANNEL);
+	BUILD_BUG_ON(ARRAY_SIZE(x9250_controls_inv) != X9250_NB_CHANNEL);
+	BUILD_BUG_ON(sizeof(control[0]) != sizeof(x9250_controls_std[0]));
+	BUILD_BUG_ON(sizeof(control[0]) != sizeof(x9250_controls_inv[0]));
+
+	for (i = 0; i < X9250_NB_CHANNEL; i++) {
+		if (x9250->cmd_inv & (1 << i)) {
+			wcr = 0xff;
+			memcpy(&control[i], &x9250_controls_inv[i], sizeof(control[i]));
+		} else {
+			wcr = 0x00;
+			memcpy(&control[i], &x9250_controls_std[i], sizeof(control[i]));
+		}
+		ret = x9250_write8(x9250, X9250_CMD_WR_WCR(i), wcr);
+		if (ret)
+			return ret;
+	}
+
+	return snd_soc_add_component_controls(component, control, ARRAY_SIZE(control));
+}
+
+static const struct snd_soc_component_driver x9250_component_driver = {
+	.probe			= x9250_component_probe,
+	.dapm_widgets		= x9250_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(x9250_dapm_widgets),
+	.dapm_routes		= x9250_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(x9250_dapm_routes),
+};
+
+static int x9250_spi_probe(struct spi_device *spi)
+{
+	struct x9250 *x9250;
+	int ret;
+
+	spi->bits_per_word = 8;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	x9250 = devm_kzalloc(&spi->dev, sizeof(*x9250), GFP_KERNEL);
+	if (x9250 == NULL)
+		return -ENOMEM;
+
+	x9250->spi = spi;
+
+	x9250->cmd_inv = 0;
+	if (of_property_read_bool(spi->dev.of_node, "renesas,cmd0-invert"))
+		x9250->cmd_inv |= (1 << 0);
+	if (of_property_read_bool(spi->dev.of_node, "renesas,cmd1-invert"))
+		x9250->cmd_inv |= (1 << 1);
+	if (of_property_read_bool(spi->dev.of_node, "renesas,cmd2-invert"))
+		x9250->cmd_inv |= (1 << 2);
+	if (of_property_read_bool(spi->dev.of_node, "renesas,cmd3-invert"))
+		x9250->cmd_inv |= (1 << 3);
+
+	spi_set_drvdata(spi, x9250);
+
+	return devm_snd_soc_register_component(&spi->dev, &x9250_component_driver,
+					       NULL, 0);
+}
+
+static const struct of_device_id x9250_of_match[] = {
+	{ .compatible = "renesas,x9250", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, x9250_of_match);
+
+static const struct spi_device_id x9250_id_table[] = {
+	{ "x9250", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, x9250_id_table);
+
+static struct spi_driver x9250_spi_driver = {
+	.driver  = {
+		.name   = "x9250",
+		.of_match_table = x9250_of_match,
+	},
+	.id_table = x9250_id_table,
+	.probe  = x9250_spi_probe,
+};
+
+module_spi_driver(x9250_spi_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("X9250 ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
2.39.0

