Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFE665CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjAKNtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjAKNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:49:28 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397EE626C;
        Wed, 11 Jan 2023 05:49:24 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 6D4BEFF807;
        Wed, 11 Jan 2023 13:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673444962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrvjjeVFrIWnJQ/EQH4ErskGXEIlJpdAmokNIg9IVlQ=;
        b=egjuL1ihU2Ab6xDDCLfeMiF/HWkUT23l9Mjqu2rMuSZPe/Kez7Ddv0aN9VGZemaq5ljysl
        wxlLMzAf32jaU8nXJIch+gQyMhAlSAwdNg6maTbA/GRaV9I6LVOl08xXkRrEZC5Uu7PpgB
        +y1gymi6kELn2J1NMg366wGnmba9QxAdc9lEH7zLsWo+6XrtWcptOw51psAnLJGQVpl0Xy
        C/bH0Qaibt3JFlDekTV2UyFE34vkvnhGePUaH8MrarbgoYDOuW2oZGGP1y+zJlSOdwWfPF
        Oc6ZsWniEJkO80U8VyUAIv6a3AxYQ+3yMddUu4pSTHXXqm0EORHA0kJ/idf1aw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034 codec
Date:   Wed, 11 Jan 2023 14:49:04 +0100
Message-Id: <20230111134905.248305-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230111134905.248305-1-herve.codina@bootlin.com>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas IDT821034 codec is four channel PCM codec with
on-chip filters and programmable gain setting.
It also provides SLIC (Subscriber Line Interface Circuit)
signals as GPIOs.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/codecs/Kconfig     |   12 +
 sound/soc/codecs/Makefile    |    2 +
 sound/soc/codecs/idt821034.c | 1234 ++++++++++++++++++++++++++++++++++
 3 files changed, 1248 insertions(+)
 create mode 100644 sound/soc/codecs/idt821034.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0f9d71490075..67489b2ebd9f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -107,6 +107,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_HDAC_HDMI
 	imply SND_SOC_HDAC_HDA
 	imply SND_SOC_ICS43432
+	imply SND_SOC_IDT821034
 	imply SND_SOC_INNO_RK3036
 	imply SND_SOC_ISABELLE
 	imply SND_SOC_JZ4740_CODEC
@@ -972,6 +973,17 @@ config SND_SOC_HDA
 config SND_SOC_ICS43432
 	tristate "ICS43423 and compatible i2s microphones"
 
+config SND_SOC_IDT821034
+	tristate "Renesas IDT821034 quad PCM codec"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Enable support for the Renesas IDT821034 quad PCM with
+	  programmable gain codec.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-soc-idt821034.
+
 config SND_SOC_INNO_RK3036
 	tristate "Inno codec driver for RK3036 SoC"
 	select REGMAP_MMIO
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 71d3ce5867e4..bcf95de654fd 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -111,6 +111,7 @@ snd-soc-hdac-hdmi-objs := hdac_hdmi.o
 snd-soc-hdac-hda-objs := hdac_hda.o
 snd-soc-hda-codec-objs := hda.o hda-dai.o
 snd-soc-ics43432-objs := ics43432.o
+snd-soc-idt821034-objs := idt821034.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
 snd-soc-jz4740-codec-objs := jz4740.o
@@ -472,6 +473,7 @@ obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
 obj-$(CONFIG_SND_SOC_HDA) += snd-soc-hda-codec.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
+obj-$(CONFIG_SND_SOC_IDT821034)	+= snd-soc-idt821034.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
 obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+= snd-soc-jz4740-codec.o
diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
new file mode 100644
index 000000000000..48ea9f6fa40f
--- /dev/null
+++ b/sound/soc/codecs/idt821034.c
@@ -0,0 +1,1234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IDT821034 ALSA SoC driver
+ *
+ * Copyright 2022 CS GROUP France
+ *
+ * Author: Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/bitrev.h>
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#define IDT821034_NB_CHANNEL	4
+
+struct idt821034 {
+	struct spi_device *spi;
+	u8 spi_tx_buf; /* Cannot use stack area for SPI (dma-safe memory) */
+	u8 spi_rx_buf; /* Cannot use stack area for SPI (dma-safe memory) */
+	struct regmap *regmap;
+	struct cache {
+		u8 codec_conf;
+		struct ch {
+			u8 power;
+			u8 tx_slot;
+			u8 rx_slot;
+			u8 slic_conf;
+			u8 slic_control;
+		} ch[IDT821034_NB_CHANNEL];
+	} cache;
+	int max_chan_playback;
+	int max_chan_capture;
+	struct gpio_chip gpio_chip;
+};
+
+static int idt821034_8bit_write(struct idt821034 *idt821034, u8 val)
+{
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &idt821034->spi_tx_buf,
+			.len = 1,
+		}, {
+			.cs_off = 1,
+			.tx_buf = &idt821034->spi_tx_buf,
+			.len = 1,
+		}
+	};
+	int ret;
+
+	idt821034->spi_tx_buf = val;
+
+	dev_vdbg(&idt821034->spi->dev, "spi xfer wr 0x%x\n", val);
+
+	ret = spi_sync_transfer(idt821034->spi, xfer, 2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int idt821034_8bit_read(struct idt821034 *idt821034, u8 valw, u8 *valr)
+{
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &idt821034->spi_tx_buf,
+			.rx_buf = &idt821034->spi_rx_buf,
+			.len = 1,
+		}, {
+			.cs_off = 1,
+			.tx_buf = &idt821034->spi_tx_buf,
+			.len = 1,
+		}
+	};
+	int ret;
+
+	idt821034->spi_tx_buf = valw;
+
+	ret = spi_sync_transfer(idt821034->spi, xfer, 2);
+	if (ret)
+		return ret;
+
+	*valr = idt821034->spi_rx_buf;
+
+	dev_vdbg(&idt821034->spi->dev, "spi xfer wr 0x%x, rd 0x%x\n",
+		 valw, *valr);
+
+	return 0;
+}
+
+#define IDT821034_CONF_MASK		(0x3 << 4)
+#define IDT821034_CONF_ALAW_MODE	(1 << 5)
+#define IDT821034_CONF_MULAW_MODE	(0 << 5)
+#define IDT821034_CONF_DELAY_MODE	(1 << 4)
+#define IDT821034_CONF_NONDELAY_MODE	(0 << 4)
+#define IDT821034_CONF_CHANNEL(_ch)	((_ch) << 2)
+#define IDT821034_CONF_PWRUP_RX		(1 << 0)
+#define IDT821034_CONF_PWRUP_TX		(1 << 1)
+#define IDT821034_CONF_PWRDOWN		(0 << 0)
+
+static int idt821034_set_codec_conf(struct idt821034 *idt821034, u8 codec_conf)
+{
+	u8 conf;
+	u8 ts;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "set_codec_conf(0x%x)\n", codec_conf);
+
+	/* codec conf fields are common to all channel.
+	 * Arbitrary use of channel 0 for this configuration.
+	 */
+
+	/* Set Configuration Register */
+	conf = 0x80 | codec_conf | IDT821034_CONF_CHANNEL(0);
+
+	/* Update conf value and timeslot register value according
+	 * to cache values
+	 */
+	if (idt821034->cache.ch[0].power & IDT821034_CONF_PWRUP_RX) {
+		conf |= IDT821034_CONF_PWRUP_RX;
+		ts = idt821034->cache.ch[0].rx_slot;
+	} else if (idt821034->cache.ch[0].power & IDT821034_CONF_PWRUP_TX) {
+		conf |= IDT821034_CONF_PWRUP_TX;
+		ts = idt821034->cache.ch[0].tx_slot;
+	} else {
+		ts = 0x00;
+	}
+
+	/* Write configuration register and time-slot register */
+	ret = idt821034_8bit_write(idt821034, conf);
+	if (ret)
+		return ret;
+	ret = idt821034_8bit_write(idt821034, ts);
+	if (ret)
+		return ret;
+
+	idt821034->cache.codec_conf = codec_conf;
+	return 0;
+}
+
+static int idt821034_set_channel_power(struct idt821034 *idt821034, u8 ch, u8 power)
+{
+	u8 conf;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "set_channel_power(%u, 0x%x)\n", ch, power);
+
+	conf = 0x80 | idt821034->cache.codec_conf | IDT821034_CONF_CHANNEL(ch);
+
+	if (power & IDT821034_CONF_PWRUP_RX) {
+		ret = idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_RX);
+		if (ret)
+			return ret;
+		ret = idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].rx_slot);
+		if (ret)
+			return ret;
+	}
+	if (power & IDT821034_CONF_PWRUP_TX) {
+		ret = idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_TX);
+		if (ret)
+			return ret;
+		ret = idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].tx_slot);
+		if (ret)
+			return ret;
+	}
+	if (!(power & (IDT821034_CONF_PWRUP_TX | IDT821034_CONF_PWRUP_RX))) {
+		ret = idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRDOWN);
+		if (ret)
+			return ret;
+		ret = idt821034_8bit_write(idt821034, 0x00);
+		if (ret)
+			return ret;
+	}
+
+	idt821034->cache.ch[ch].power = power;
+
+	return 0;
+}
+
+/* In the codec documentation, 'transmit' is from analog input to PCM and
+ * 'receive' is from PCM to analog output.
+ * We keep the same terminology in this source code.
+ */
+#define IDT821034_CH_RX (0x1 << 0) /* from PCM to analog output */
+#define IDT821034_CH_TX (0x1 << 1) /* from analog input to PCM */
+#define IDT821034_CH_RXTX (IDT821034_CH_RX | IDT821034_CH_TX)
+
+static int idt821034_set_channel_ts(struct idt821034 *idt821034, u8 ch, u8 ch_dir, u8 ts_num)
+{
+	u8 conf;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "set_channel_ts(%u, 0x%x, %d)\n", ch, ch_dir, ts_num);
+
+	conf = 0x80 | idt821034->cache.codec_conf | IDT821034_CONF_CHANNEL(ch);
+
+	if (ch_dir & IDT821034_CH_RX) {
+		if (idt821034->cache.ch[ch].power & IDT821034_CONF_PWRUP_RX) {
+			ret = idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_RX);
+			if (ret)
+				return ret;
+			ret = idt821034_8bit_write(idt821034, ts_num);
+			if (ret)
+				return ret;
+		}
+		idt821034->cache.ch[ch].rx_slot = ts_num;
+	}
+	if (ch_dir & IDT821034_CH_TX) {
+		if (idt821034->cache.ch[ch].power & IDT821034_CONF_PWRUP_TX) {
+			ret = idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_TX);
+			if (ret)
+				return ret;
+			ret = idt821034_8bit_write(idt821034, ts_num);
+			if (ret)
+				return ret;
+		}
+		idt821034->cache.ch[ch].tx_slot = ts_num;
+	}
+
+	return 0;
+}
+
+#define IDT821034_SLIC_CHANNEL(_ch) ((_ch) << 2)
+#define IDT821034_SLIC_IO1_IN       (1 << 1)
+#define IDT821034_SLIC_IO0_IN       (1 << 0)
+
+static int idt821034_set_slic_conf(struct idt821034 *idt821034, u8 ch, u8 slic_dir)
+{
+	u8 conf;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "set_slic_conf(%u, 0x%x)\n", ch, slic_dir);
+
+	conf = 0xD0 | IDT821034_SLIC_CHANNEL(ch) | slic_dir;
+	ret = idt821034_8bit_write(idt821034, conf);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].slic_control);
+	if (ret)
+		return ret;
+
+	idt821034->cache.ch[ch].slic_conf = slic_dir;
+
+	return 0;
+}
+
+static int idt821034_write_slic_raw(struct idt821034 *idt821034, u8 ch, u8 slic_raw)
+{
+	u8 conf;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "write_slic_raw(%u, 0x%x)\n", ch, slic_raw);
+
+	/* On write, slic_raw:
+	 *   b4: O_4
+	 *   b3: O_3
+	 *   b2: O_2
+	 *   b1: I/O_1
+	 *   b0: I/O_0
+	 */
+
+	conf = 0xD0 | IDT821034_SLIC_CHANNEL(ch) | idt821034->cache.ch[ch].slic_conf;
+	ret = idt821034_8bit_write(idt821034, conf);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_write(idt821034, slic_raw);
+	if (ret)
+		return ret;
+
+	idt821034->cache.ch[ch].slic_control = slic_raw;
+	return 0;
+}
+
+static int idt821034_read_slic_raw(struct idt821034 *idt821034, u8 ch, u8 *slic_raw)
+{
+	u8 val;
+	int ret;
+
+	/* On read, slic_raw:
+	 *   b7: I/O_0
+	 *   b6: I/O_1
+	 *   b5: O_2
+	 *   b4: O_3
+	 *   b3: O_4
+	 *   b2: I/O1_0, I/O_0 from channel 1 (no matter channel_addr value)
+	 *   b1: I/O2_0, I/O_0 from channel 2 (no matter channel_addr value)
+	 *   b2: I/O3_0, I/O_0 from channel 3 (no matter channel_addr value)
+	 */
+
+	val = 0xD0 | IDT821034_SLIC_CHANNEL(ch) | idt821034->cache.ch[ch].slic_conf;
+	ret = idt821034_8bit_write(idt821034, val);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_read(idt821034, idt821034->cache.ch[ch].slic_control, slic_raw);
+	if (ret)
+		return ret;
+
+	dev_dbg(&idt821034->spi->dev, "read_slic_raw(%i) 0x%x\n", ch, *slic_raw);
+
+	return 0;
+}
+
+#define IDT821034_GAIN_CHANNEL(_ch)	((_ch) << 2)
+#define IDT821034_GAIN_RX		(0 << 1) /* from PCM to analog output*/
+#define IDT821034_GAIN_TX		(1 << 1) /* from analog input to PCM */
+
+static int idt821034_set_gain_channel(struct idt821034 *idt821034, u8 ch,
+				      u8 gain_type, u16 gain_val)
+{
+	u8 conf;
+	int ret;
+
+	dev_dbg(&idt821034->spi->dev, "set_gain_channel(%u, 0x%x, 0x%x-%d)\n",
+		ch, gain_type, gain_val, gain_val);
+
+	/* The gain programming coefficients should be calculated as:
+	 *   Transmit : Coeff_X = round [ gain_X0dB × gain_X ]
+	 *   Receive: Coeff_R = round [ gain_R0dB × gain_R ]
+	 * where:
+	 *   gain_X0dB = 1820;
+	 *   gain_X is the target gain;
+	 *   Coeff_X should be in the range of 0 to 8192.
+	 *   gain_R0dB = 2506;
+	 *   gain_R is the target gain;
+	 *   Coeff_R should be in the range of 0 to 8192.
+	 *
+	 * A gain programming coefficient is 14-bit wide and in binary format.
+	 * The 7 Most Significant Bits of the coefficient is called
+	 * GA_MSB_Transmit for transmit path, or is called GA_MSB_Receive for
+	 * receive path; The 7 Least Significant Bits of the coefficient is
+	 * called GA_LSB_ Transmit for transmit path, or is called
+	 * GA_LSB_Receive for receive path.
+	 *
+	 * An example is given below to clarify the calculation of the
+	 * coefficient. To program a +3 dB gain in transmit path and a -3.5 dB
+	 * gain in receive path:
+	 *
+	 * Linear Code of +3dB = 10^(3/20)= 1.412537545
+	 * Coeff_X = round (1820 × 1.412537545) = 2571
+	 *                                      = 0b001010_00001011
+	 * GA_MSB_Transmit = 0b0010100
+	 * GA_LSB_Transmit = 0b0001011
+	 *
+	 * Linear Code of -3.5dB = 10^(-3.5/20) = 0.668343917
+	 * Coeff_R= round (2506 × 0.668343917) = 1675
+	 *                                     = 0b0001101_0001011
+	 * GA_MSB_Receive = 0b0001101
+	 * GA_LSB_Receive = 0b0001011
+	 */
+
+	conf = 0xC0 | IDT821034_GAIN_CHANNEL(ch) | gain_type;
+
+	ret = idt821034_8bit_write(idt821034, conf | 0x00);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_write(idt821034, gain_val & 0x007F);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_write(idt821034, conf | 0x01);
+	if (ret)
+		return ret;
+
+	ret = idt821034_8bit_write(idt821034, (gain_val >> 7) & 0x7F);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+#define IDT821034_REGMAP_ADDR_DIR_MASK	(1 << 0)
+#define IDT821034_REGMAP_ADDR_DIR_IN	(0 << 0)
+#define IDT821034_REGMAP_ADDR_DIR_OUT	(1 << 0)
+#define IDT821034_REGMAP_ADDR_IS_DIR_OUT(_addr) (!!((_addr) & 1))
+
+#define IDT821034_REGMAP_ADDR_CH_MASK	(3 << 1)
+#define IDT821034_REGMAP_ADDR_CH(_ch)	(((_ch) & 3) << 1)
+#define IDT821034_REGMAP_ADDR_GET_CH(_addr) (((_addr) >> 1) & 3)
+
+#define IDT821034_REGMAP_ADDR_TYPE_MASK		(0x07 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_GBLCONF	(0x00 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_GAIN		(0x01 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_POWER	(0x02 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_TS		(0x03 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_SLIC_CONF	(0x04 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_SLIC_DIN	(0x05 << 3)
+#define IDT821034_REGMAP_ADDR_TYPE_SLIC_DOUT	(0x06 << 3)
+#define IDT821034_REGMAP_ADDR_GET_TYPE(_addr)	((_addr) & IDT821034_REGMAP_ADDR_TYPE_MASK)
+
+#define IDT821034_REGMAP_ADDR(_type, _ch, _dir) ((_type) | (_ch) | (_dir))
+
+#define IDT821034_REGMAP_MAX_REGISTER  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_MASK, \
+						0, 0)
+
+/* Global configuration */
+#define IDT821034_REGMAP_GBLCONF  IDT821034_REGMAP_ADDR( \
+					IDT821034_REGMAP_ADDR_TYPE_GBLCONF, \
+					0, 0)
+#define IDT821034_REGMAP_GBLCONF_ALAW_MODE	(1 << 0)
+#define IDT821034_REGMAP_GBLCONF_MULAW_MODE	(0 << 0)
+#define IDT821034_REGMAP_GBLCONF_DELAY_MODE	(1 << 1)
+#define IDT821034_REGMAP_GBLCONF_NONDELAY_MODE	(0 << 1)
+
+/* Gain (14 bits gain value + mute flag)
+ *   bit0 : 0 unmute, 1 mute (internaly set gain to 0x00)
+ *   bit1..15: gain value
+ */
+#define IDT821034_REGMAP_CH_GAIN_OUT(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_GAIN, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						IDT821034_REGMAP_ADDR_DIR_OUT)
+#define IDT821034_REGMAP_CH0_GAIN_OUT	IDT821034_REGMAP_CH_GAIN_OUT(0)
+#define IDT821034_REGMAP_CH1_GAIN_OUT	IDT821034_REGMAP_CH_GAIN_OUT(1)
+#define IDT821034_REGMAP_CH2_GAIN_OUT	IDT821034_REGMAP_CH_GAIN_OUT(2)
+#define IDT821034_REGMAP_CH3_GAIN_OUT	IDT821034_REGMAP_CH_GAIN_OUT(3)
+#define IDT821034_REGMAP_CH_GAIN_IN(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_GAIN, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						IDT821034_REGMAP_ADDR_DIR_IN)
+#define IDT821034_REGMAP_CH0_GAIN_IN	IDT821034_REGMAP_CH_GAIN_IN(0)
+#define IDT821034_REGMAP_CH1_GAIN_IN	IDT821034_REGMAP_CH_GAIN_IN(1)
+#define IDT821034_REGMAP_CH2_GAIN_IN	IDT821034_REGMAP_CH_GAIN_IN(2)
+#define IDT821034_REGMAP_CH3_GAIN_IN	IDT821034_REGMAP_CH_GAIN_IN(3)
+
+/* Channel power */
+#define IDT821034_REGMAP_CH_POWER(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_POWER, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						0)
+#define IDT821034_REGMAP_CH0_POWER	IDT821034_REGMAP_CH_POWER(0)
+#define IDT821034_REGMAP_CH1_POWER	IDT821034_REGMAP_CH_POWER(1)
+#define IDT821034_REGMAP_CH2_POWER	IDT821034_REGMAP_CH_POWER(2)
+#define IDT821034_REGMAP_CH3_POWER	IDT821034_REGMAP_CH_POWER(3)
+#define IDT821034_REGMAP_POWER_OUT	(1 << 1)
+#define IDT821034_REGMAP_POWER_IN	(1 << 0)
+
+/* Channel TimeSlot */
+#define IDT821034_REGMAP_CH_TS_OUT(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_TS, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						IDT821034_REGMAP_ADDR_DIR_OUT)
+#define IDT821034_REGMAP_CH_TS_IN(_ch)   IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_TS, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						IDT821034_REGMAP_ADDR_DIR_IN)
+#define IDT821034_REGMAP_CH0_TS_OUT	IDT821034_REGMAP_CH_TS_OUT(0)
+#define IDT821034_REGMAP_CH1_TS_OUT	IDT821034_REGMAP_CH_TS_OUT(1)
+#define IDT821034_REGMAP_CH2_TS_OUT	IDT821034_REGMAP_CH_TS_OUT(2)
+#define IDT821034_REGMAP_CH3_TS_OUT	IDT821034_REGMAP_CH_TS_OUT(3)
+#define IDT821034_REGMAP_CH0_TS_IN	IDT821034_REGMAP_CH_TS_IN(0)
+#define IDT821034_REGMAP_CH1_TS_IN	IDT821034_REGMAP_CH_TS_IN(1)
+#define IDT821034_REGMAP_CH2_TS_IN	IDT821034_REGMAP_CH_TS_IN(2)
+#define IDT821034_REGMAP_CH3_TS_IN	IDT821034_REGMAP_CH_TS_IN(3)
+
+/* Slic configuration */
+#define IDT821034_REGMAP_CH_SLIC_CONF(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_SLIC_CONF, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						0)
+#define IDT821034_REGMAP_CH0_SLIC_CONF	IDT821034_REGMAP_CH_SLIC_CONF(0)
+#define IDT821034_REGMAP_CH1_SLIC_CONF	IDT821034_REGMAP_CH_SLIC_CONF(1)
+#define IDT821034_REGMAP_CH2_SLIC_CONF	IDT821034_REGMAP_CH_SLIC_CONF(2)
+#define IDT821034_REGMAP_CH3_SLIC_CONF	IDT821034_REGMAP_CH_SLIC_CONF(3)
+
+/* Slic data in */
+#define IDT821034_REGMAP_CH_SLIC_DIN(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_SLIC_DIN, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						0)
+#define IDT821034_REGMAP_CH0_SLIC_DIN	IDT821034_REGMAP_CH_SLIC_DIN(0)
+#define IDT821034_REGMAP_CH1_SLIC_DIN	IDT821034_REGMAP_CH_SLIC_DIN(1)
+#define IDT821034_REGMAP_CH2_SLIC_DIN	IDT821034_REGMAP_CH_SLIC_DIN(2)
+#define IDT821034_REGMAP_CH3_SLIC_DIN	IDT821034_REGMAP_CH_SLIC_DIN(3)
+
+/* Slic data out */
+#define IDT821034_REGMAP_CH_SLIC_DOUT(_ch)  IDT821034_REGMAP_ADDR( \
+						IDT821034_REGMAP_ADDR_TYPE_SLIC_DOUT, \
+						IDT821034_REGMAP_ADDR_CH(_ch), \
+						0)
+#define IDT821034_REGMAP_CH0_SLIC_DOUT	IDT821034_REGMAP_CH_SLIC_DOUT(0)
+#define IDT821034_REGMAP_CH1_SLIC_DOUT	IDT821034_REGMAP_CH_SLIC_DOUT(1)
+#define IDT821034_REGMAP_CH2_SLIC_DOUT	IDT821034_REGMAP_CH_SLIC_DOUT(2)
+#define IDT821034_REGMAP_CH3_SLIC_DOUT	IDT821034_REGMAP_CH_SLIC_DOUT(3)
+
+static int idt821034_reg_write_gblconf(struct idt821034 *idt821034,
+				       unsigned int reg, unsigned int val)
+{
+	u8 conf;
+
+	conf = 0;
+	if (val & IDT821034_REGMAP_GBLCONF_ALAW_MODE)
+		conf |= IDT821034_CONF_ALAW_MODE;
+	if (val & IDT821034_REGMAP_GBLCONF_DELAY_MODE)
+		conf |= IDT821034_CONF_DELAY_MODE;
+
+	return idt821034_set_codec_conf(idt821034, conf);
+}
+
+static int idt821034_reg_write_gain(struct idt821034 *idt821034,
+				    unsigned int reg, unsigned int val)
+{
+	u16 gain_val;
+	u8 gain_type;
+	u8 ch;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+	gain_type = IDT821034_REGMAP_ADDR_IS_DIR_OUT(reg) ?
+			IDT821034_GAIN_RX : IDT821034_GAIN_TX;
+	gain_val = (val & 0x01) ? 0 : val >> 1;
+
+	return idt821034_set_gain_channel(idt821034, ch, gain_type, gain_val);
+}
+
+static int idt821034_reg_write_power(struct idt821034 *idt821034,
+				     unsigned int reg, unsigned int val)
+{
+	u8 power;
+	u8 ch;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+
+	power = 0;
+	if (val & IDT821034_REGMAP_POWER_OUT)
+		power |= IDT821034_CONF_PWRUP_RX; /* PCM to analog output */
+	if (val & IDT821034_REGMAP_POWER_IN)
+		power |= IDT821034_CONF_PWRUP_TX; /* analog input to PCM */
+
+	return idt821034_set_channel_power(idt821034, ch, power);
+}
+
+static int idt821034_reg_write_ts(struct idt821034 *idt821034,
+				  unsigned int reg, unsigned int val)
+{
+	u8 ts_val;
+	u8 ch_dir;
+	u8 ch;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+	ch_dir = IDT821034_REGMAP_ADDR_IS_DIR_OUT(reg) ?
+			IDT821034_CH_RX : IDT821034_CH_TX;
+	ts_val = val;
+
+	return idt821034_set_channel_ts(idt821034, ch, ch_dir, ts_val);
+}
+
+static int idt821034_reg_write_slic_conf(struct idt821034 *idt821034,
+					 unsigned int reg, unsigned int val)
+{
+	u8 slic_dir;
+	u8 ch;
+
+	/* Only IO0 and IO1 can be set as input */
+	if (val & ~0x03)
+		return -EPERM;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+
+	slic_dir = 0;
+	if (val & (1 << 0))
+		slic_dir |= IDT821034_SLIC_IO0_IN;
+	if (val & (1 << 1))
+		slic_dir |= IDT821034_SLIC_IO1_IN;
+
+	return idt821034_set_slic_conf(idt821034, ch, slic_dir);
+}
+
+static int idt821034_reg_write_slic_dout(struct idt821034 *idt821034,
+					 unsigned int reg, unsigned int val)
+{
+	u8 slic_val;
+	u8 ch;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+	slic_val = val & 0x1f;
+
+	return idt821034_write_slic_raw(idt821034, ch, slic_val);
+}
+
+static int idt821034_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct idt821034 *idt821034 = context;
+
+	dev_dbg(&idt821034->spi->dev, "reg_write(0x%x, 0x%x)\n", reg, val);
+
+	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
+	case IDT821034_REGMAP_ADDR_TYPE_GBLCONF:
+		return idt821034_reg_write_gblconf(idt821034, reg, val);
+
+	case IDT821034_REGMAP_ADDR_TYPE_GAIN:
+		return idt821034_reg_write_gain(idt821034, reg, val);
+
+	case IDT821034_REGMAP_ADDR_TYPE_POWER:
+		return idt821034_reg_write_power(idt821034, reg, val);
+
+	case IDT821034_REGMAP_ADDR_TYPE_TS:
+		return idt821034_reg_write_ts(idt821034, reg, val);
+
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_CONF:
+		return idt821034_reg_write_slic_conf(idt821034, reg, val);
+
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_DOUT:
+		return idt821034_reg_write_slic_dout(idt821034, reg, val);
+
+	default:
+		break;
+	}
+
+	dev_err(&idt821034->spi->dev, "unknown write reg 0x%x\n", reg);
+	return -EIO;
+}
+
+static bool idt821034_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
+	case IDT821034_REGMAP_ADDR_TYPE_GBLCONF:
+	case IDT821034_REGMAP_ADDR_TYPE_GAIN:
+	case IDT821034_REGMAP_ADDR_TYPE_POWER:
+	case IDT821034_REGMAP_ADDR_TYPE_TS:
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_CONF:
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_DOUT:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static int idt821034_reg_read_slic_din(struct idt821034 *idt821034,
+				       unsigned int reg, unsigned int *val)
+{
+	u8 slic_val;
+	int ret;
+	u8 ch;
+
+	ch = IDT821034_REGMAP_ADDR_GET_CH(reg);
+
+	ret = idt821034_read_slic_raw(idt821034, ch, &slic_val);
+	if (ret)
+		return ret;
+
+	/* SLIC IOs are read in reverse order compared to write.
+	 * Reverse read value here in order to have IO0 at lsb (ie same order
+	 * as write)
+	 */
+	*val = bitrev8(slic_val) & 0x1f;
+	return 0;
+}
+
+static int idt821034_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct idt821034 *idt821034 = context;
+
+	dev_dbg(&idt821034->spi->dev, "reg_read(0x%x)\n", reg);
+
+	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_DIN:
+		return idt821034_reg_read_slic_din(idt821034, reg, val);
+	default:
+		break;
+	}
+
+	dev_err(&idt821034->spi->dev, "unknown read reg 0x%x\n", reg);
+	return -EIO;
+}
+
+static bool idt821034_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_DIN:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static bool idt821034_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
+	case IDT821034_REGMAP_ADDR_TYPE_SLIC_DIN:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static const struct regmap_config idt821034_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	//.max_register = IDT821034_REGMAP_MAX_REGISTER,
+	.reg_write = idt821034_reg_write,
+	.reg_read = idt821034_reg_read,
+	.writeable_reg = idt821034_writeable_reg,
+	.readable_reg = idt821034_readable_reg,
+	.volatile_reg = idt821034_volatile_reg,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -6520, 1306);
+#define IDT821034_GAIN_IN_MIN_RAW	1 /* -65.20 dB -> 10^(-65.2/20.0) * 1820 = 1 */
+#define IDT821034_GAIN_IN_MAX_RAW	8191 /* 13.06 dB -> 10^(13.06/20.0) * 1820 = 8191 */
+#define IDT821034_GAIN_IN_INIT_RAW	1820 /* 0dB -> 10^(0/20) * 1820 = 1820 */
+
+static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -6797, 1028);
+#define IDT821034_GAIN_OUT_MIN_RAW	1 /* -67.97 dB -> 10^(-67.97/20.0) * 2506 = 1*/
+#define IDT821034_GAIN_OUT_MAX_RAW	8191 /* 10.28 dB -> 10^(12.88/20.0) * 2506 = 8191 */
+#define IDT821034_GAIN_OUT_INIT_RAW	2506 /* 0dB -> 10^(0/20) * 2506 = 2506 */
+
+static const struct snd_kcontrol_new idt821034_controls[] = {
+	/* DAC volume control */
+	SOC_SINGLE_RANGE_TLV("DAC0 Playback Volume", IDT821034_REGMAP_CH0_GAIN_OUT,
+			     1, IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
+			     0, idt821034_gain_out),
+	SOC_SINGLE_RANGE_TLV("DAC1 Playback Volume", IDT821034_REGMAP_CH1_GAIN_OUT,
+			     1, IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
+			     0, idt821034_gain_out),
+	SOC_SINGLE_RANGE_TLV("DAC2 Playback Volume", IDT821034_REGMAP_CH2_GAIN_OUT,
+			     1, IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
+			     0, idt821034_gain_out),
+	SOC_SINGLE_RANGE_TLV("DAC3 Playback Volume", IDT821034_REGMAP_CH3_GAIN_OUT,
+			     1, IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
+			     0, idt821034_gain_out),
+
+	/* DAC mute control */
+	SOC_SINGLE("DAC0 Playback Switch", IDT821034_REGMAP_CH0_GAIN_OUT, 0, 1, 1),
+	SOC_SINGLE("DAC1 Playback Switch", IDT821034_REGMAP_CH1_GAIN_OUT, 0, 1, 1),
+	SOC_SINGLE("DAC2 Playback Switch", IDT821034_REGMAP_CH2_GAIN_OUT, 0, 1, 1),
+	SOC_SINGLE("DAC3 Playback Switch", IDT821034_REGMAP_CH3_GAIN_OUT, 0, 1, 1),
+
+	/* ADC volume control */
+	SOC_SINGLE_RANGE_TLV("ADC0 Capture Volume", IDT821034_REGMAP_CH0_GAIN_IN,
+			     1, IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
+			     0, idt821034_gain_in),
+	SOC_SINGLE_RANGE_TLV("ADC1 Capture Volume", IDT821034_REGMAP_CH1_GAIN_IN,
+			     1, IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
+			     0, idt821034_gain_in),
+	SOC_SINGLE_RANGE_TLV("ADC2 Capture Volume", IDT821034_REGMAP_CH2_GAIN_IN,
+			     1, IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
+			     0, idt821034_gain_in),
+	SOC_SINGLE_RANGE_TLV("ADC3 Capture Volume", IDT821034_REGMAP_CH3_GAIN_IN,
+			     1, IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
+			     0, idt821034_gain_in),
+
+	/* ADC mute control */
+	SOC_SINGLE("ADC0 Capture Switch", IDT821034_REGMAP_CH0_GAIN_IN, 0, 1, 1),
+	SOC_SINGLE("ADC1 Capture Switch", IDT821034_REGMAP_CH1_GAIN_IN, 0, 1, 1),
+	SOC_SINGLE("ADC2 Capture Switch", IDT821034_REGMAP_CH2_GAIN_IN, 0, 1, 1),
+	SOC_SINGLE("ADC3 Capture Switch", IDT821034_REGMAP_CH3_GAIN_IN, 0, 1, 1),
+};
+
+static const struct snd_soc_dapm_widget idt821034_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC0", "Playback", IDT821034_REGMAP_CH0_POWER, 1, 0),
+	SND_SOC_DAPM_DAC("DAC1", "Playback", IDT821034_REGMAP_CH1_POWER, 1, 0),
+	SND_SOC_DAPM_DAC("DAC2", "Playback", IDT821034_REGMAP_CH2_POWER, 1, 0),
+	SND_SOC_DAPM_DAC("DAC3", "Playback", IDT821034_REGMAP_CH3_POWER, 1, 0),
+	SND_SOC_DAPM_OUTPUT("OUT0"),
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+
+	SND_SOC_DAPM_DAC("ADC0", "Capture", IDT821034_REGMAP_CH0_POWER, 0, 0),
+	SND_SOC_DAPM_DAC("ADC1", "Capture", IDT821034_REGMAP_CH1_POWER, 0, 0),
+	SND_SOC_DAPM_DAC("ADC2", "Capture", IDT821034_REGMAP_CH2_POWER, 0, 0),
+	SND_SOC_DAPM_DAC("ADC3", "Capture", IDT821034_REGMAP_CH3_POWER, 0, 0),
+	SND_SOC_DAPM_INPUT("IN0"),
+	SND_SOC_DAPM_INPUT("IN1"),
+	SND_SOC_DAPM_INPUT("IN2"),
+	SND_SOC_DAPM_INPUT("IN3"),
+};
+
+static const struct snd_soc_dapm_route idt821034_dapm_routes[] = {
+	{ "OUT0", NULL, "DAC0" },
+	{ "OUT1", NULL, "DAC1" },
+	{ "OUT2", NULL, "DAC2" },
+	{ "OUT3", NULL, "DAC3" },
+
+	{ "ADC0", NULL, "IN0" },
+	{ "ADC1", NULL, "IN1" },
+	{ "ADC2", NULL, "IN2" },
+	{ "ADC3", NULL, "IN3" },
+};
+
+static int idt821034_dai_set_tdm_slot(struct snd_soc_dai *dai,
+				      unsigned int tx_mask, unsigned int rx_mask,
+				      int slots, int width)
+{
+	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int chan;
+	unsigned int mask;
+	u8 slot;
+	int ret;
+
+	switch (width) {
+	case 0: /* Not set -> default 8 */
+	case 8:
+		break;
+	default:
+		dev_err(dai->dev, "tdm slot width %d not supported\n", width);
+		return -EINVAL;
+	}
+
+	mask = tx_mask;
+	slot = 0;
+	chan = 0;
+	while (mask && chan < IDT821034_NB_CHANNEL) {
+		if (mask & 0x1) {
+			ret = regmap_write(idt821034->regmap, IDT821034_REGMAP_CH_TS_OUT(chan),
+					   slot);
+			if (ret) {
+				dev_err(dai->dev, "chan %d set tx tdm slot failed (%d)\n",
+					chan, ret);
+				return ret;
+			}
+			chan++;
+		}
+		mask >>= 1;
+		slot++;
+	}
+	if (mask) {
+		dev_err(dai->dev, "too much tx slots defined (mask = 0x%x) support max %d\n",
+			tx_mask, IDT821034_NB_CHANNEL);
+		return -EINVAL;
+	}
+	idt821034->max_chan_playback = chan;
+
+	mask = rx_mask;
+	slot = 0;
+	chan = 0;
+	while (mask && chan < IDT821034_NB_CHANNEL) {
+		if (mask & 0x1) {
+			ret = regmap_write(idt821034->regmap, IDT821034_REGMAP_CH_TS_IN(chan),
+					   slot);
+			if (ret) {
+				dev_err(dai->dev, "chan %d set rx tdm slot failed (%d)\n",
+					chan, ret);
+				return ret;
+			}
+			chan++;
+		}
+		mask >>= 1;
+		slot++;
+	}
+	if (mask) {
+		dev_err(dai->dev, "too much rx slots defined (mask = 0x%x) support max %d\n",
+			rx_mask, IDT821034_NB_CHANNEL);
+		return -EINVAL;
+	}
+	idt821034->max_chan_capture = chan;
+
+	return 0;
+}
+
+static int idt821034_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(dai->component);
+	u16 mode;
+	int ret;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mode = IDT821034_REGMAP_GBLCONF_DELAY_MODE;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		mode = IDT821034_REGMAP_GBLCONF_NONDELAY_MODE;
+		break;
+	default:
+		dev_err(dai->dev, "Unsupported format 0x%x\n",
+			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(idt821034->regmap, IDT821034_REGMAP_GBLCONF,
+				 IDT821034_REGMAP_GBLCONF_DELAY_MODE, mode);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int idt821034_dai_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params,
+				   struct snd_soc_dai *dai)
+{
+	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(dai->component);
+	u8 mode;
+	int ret;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_MU_LAW:
+		mode = IDT821034_REGMAP_GBLCONF_MULAW_MODE;
+		break;
+	case SNDRV_PCM_FORMAT_A_LAW:
+		mode = IDT821034_REGMAP_GBLCONF_ALAW_MODE;
+		break;
+	default:
+		dev_err(&idt821034->spi->dev, "Unsupported format 0x%x\n",
+			params_format(params));
+		return -EINVAL;
+	}
+	ret = regmap_update_bits(idt821034->regmap, IDT821034_REGMAP_GBLCONF,
+				 IDT821034_REGMAP_GBLCONF_ALAW_MODE, mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const unsigned int idt821034_sample_bits[] = {8};
+
+static struct snd_pcm_hw_constraint_list idt821034_sample_bits_constr = {
+	.list = idt821034_sample_bits,
+	.count = ARRAY_SIZE(idt821034_sample_bits),
+};
+
+static int idt821034_dai_startup(struct snd_pcm_substream *substream,
+				 struct snd_soc_dai *dai)
+{
+	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(dai->component);
+	unsigned int max_channels = 0;
+	int ret;
+
+	max_channels = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+			idt821034->max_chan_playback :
+			idt821034->max_chan_capture;
+
+	/* Disable stream support (min = 0, max = 0) if no timeslots were
+	 * Configured
+	 */
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_CHANNELS,
+					   max_channels ? 1 : 0,
+					   max_channels);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+					 &idt821034_sample_bits_constr);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static u64 idt821034_dai_formats[] = {
+	SND_SOC_POSSIBLE_DAIFMT_DSP_A	|
+	SND_SOC_POSSIBLE_DAIFMT_DSP_B,
+};
+
+static const struct snd_soc_dai_ops idt821034_dai_ops = {
+	.startup      = idt821034_dai_startup,
+	.hw_params    = idt821034_dai_hw_params,
+	.set_tdm_slot = idt821034_dai_set_tdm_slot,
+	.set_fmt      = idt821034_dai_set_fmt,
+	.auto_selectable_formats     = idt821034_dai_formats,
+	.num_auto_selectable_formats = ARRAY_SIZE(idt821034_dai_formats),
+};
+
+static struct snd_soc_dai_driver idt821034_dai_driver = {
+	.name = "idt821034",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = IDT821034_NB_CHANNEL,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = IDT821034_NB_CHANNEL,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
+	},
+	.ops = &idt821034_dai_ops,
+};
+
+static int idt821034_reset(struct idt821034 *idt821034)
+{
+	static const struct reg_sequence reg_reset[] = {
+		{ .reg = IDT821034_REGMAP_GBLCONF,      .def = 0x0000 },
+		{ .reg = IDT821034_REGMAP_CH0_POWER,    .def = 0x0000 },
+		{ .reg = IDT821034_REGMAP_CH1_POWER,    .def = 0x0000 },
+		{ .reg = IDT821034_REGMAP_CH2_POWER,    .def = 0x0000 },
+		{ .reg = IDT821034_REGMAP_CH3_POWER,    .def = 0x0000 },
+		{ .reg = IDT821034_REGMAP_CH0_GAIN_OUT, .def = IDT821034_GAIN_OUT_INIT_RAW << 1 },
+		{ .reg = IDT821034_REGMAP_CH1_GAIN_OUT, .def = IDT821034_GAIN_OUT_INIT_RAW << 1 },
+		{ .reg = IDT821034_REGMAP_CH2_GAIN_OUT, .def = IDT821034_GAIN_OUT_INIT_RAW << 1 },
+		{ .reg = IDT821034_REGMAP_CH3_GAIN_OUT, .def = IDT821034_GAIN_OUT_INIT_RAW << 1 },
+		{ .reg = IDT821034_REGMAP_CH0_GAIN_IN,  .def = IDT821034_GAIN_IN_INIT_RAW << 1},
+		{ .reg = IDT821034_REGMAP_CH1_GAIN_IN,  .def = IDT821034_GAIN_IN_INIT_RAW << 1},
+		{ .reg = IDT821034_REGMAP_CH2_GAIN_IN,  .def = IDT821034_GAIN_IN_INIT_RAW << 1},
+		{ .reg = IDT821034_REGMAP_CH3_GAIN_IN,  .def = IDT821034_GAIN_IN_INIT_RAW << 1},
+	};
+
+	return regmap_multi_reg_write(idt821034->regmap,
+				       reg_reset, ARRAY_SIZE(reg_reset));
+}
+
+static int idt821034_component_probe(struct snd_soc_component *component)
+{
+	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	/* reset idt821034 */
+	ret = idt821034_reset(idt821034);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver idt821034_component_driver = {
+	.probe			= idt821034_component_probe,
+	.controls		= idt821034_controls,
+	.num_controls		= ARRAY_SIZE(idt821034_controls),
+	.dapm_widgets		= idt821034_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(idt821034_dapm_widgets),
+	.dapm_routes		= idt821034_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(idt821034_dapm_routes),
+	.endianness		= 1,
+};
+
+#if IS_ENABLED(CONFIG_GPIOLIB)
+#define IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(_offset) (((_offset) / 5) % 4)
+#define IDT821034_GPIO_OFFSET_TO_SLIC_MASK(_offset)    BIT((_offset) % 5)
+
+static void idt821034_chip_gpio_set(struct gpio_chip *c, unsigned int offset, int val)
+{
+	unsigned int channel = IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
+	unsigned int mask = IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
+	struct idt821034 *idt821034 = gpiochip_get_data(c);
+	int ret;
+
+	ret = regmap_update_bits(idt821034->regmap, IDT821034_REGMAP_CH_SLIC_DOUT(channel),
+				 mask, val ? mask : 0);
+	if (ret) {
+		dev_err(&idt821034->spi->dev, "set gpio %d (%d, 0x%x) failed (%d)\n",
+			offset, channel, mask, ret);
+	}
+}
+
+static int idt821034_chip_gpio_get(struct gpio_chip *c, unsigned int offset)
+{
+	unsigned int channel = IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
+	unsigned int mask = IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
+	struct idt821034 *idt821034 = gpiochip_get_data(c);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(idt821034->regmap, IDT821034_REGMAP_CH_SLIC_DIN(channel), &val);
+	if (ret) {
+		dev_err(&idt821034->spi->dev, "get gpio %d (%d, 0x%x) failed (%d)\n",
+			offset, channel, mask, ret);
+	}
+
+	return !!(val & mask);
+}
+
+static int idt821034_chip_get_direction(struct gpio_chip *c, unsigned int offset)
+{
+	unsigned int channel = IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
+	unsigned int mask = IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
+	struct idt821034 *idt821034 = gpiochip_get_data(c);
+	int val;
+	int ret;
+
+	ret = regmap_read(idt821034->regmap, IDT821034_REGMAP_CH_SLIC_CONF(channel), &val);
+	if (ret) {
+		dev_err(&idt821034->spi->dev, "get dir gpio %d (%d, 0x%x) failed (%d)\n",
+			offset, channel, mask, ret);
+		return ret;
+	}
+	return val & mask ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION_OUT;
+}
+
+static int idt821034_chip_direction_input(struct gpio_chip *c, unsigned int offset)
+{
+	unsigned int channel = IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
+	unsigned int mask = IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
+	struct idt821034 *idt821034 = gpiochip_get_data(c);
+	int ret;
+
+	ret = regmap_update_bits(idt821034->regmap, IDT821034_REGMAP_CH_SLIC_CONF(channel),
+				 mask, mask);
+	if (ret) {
+		dev_err(&idt821034->spi->dev, "dir in gpio %d (%d, 0x%x) failed (%d)\n",
+			offset, channel, mask, ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int idt821034_chip_direction_output(struct gpio_chip *c, unsigned int offset, int val)
+{
+	unsigned int channel = IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
+	unsigned int mask = IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
+	struct idt821034 *idt821034 = gpiochip_get_data(c);
+	int ret;
+
+	idt821034_chip_gpio_set(c, offset, val);
+
+	ret = regmap_update_bits(idt821034->regmap, IDT821034_REGMAP_CH_SLIC_CONF(channel),
+				 mask, 0);
+	if (ret) {
+		dev_err(&idt821034->spi->dev, "dir out gpio %d (%d, 0x%x) failed (%d)\n",
+			offset, channel, mask, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int idt821034_reset_gpio(struct idt821034 *idt821034)
+{
+	static const struct reg_sequence reg_reset[] = {
+		/* IO0 and IO1 as input for all channels and output IO set to 0 */
+		{ .reg = IDT821034_REGMAP_CH0_SLIC_CONF, .def = 0x3 },
+		{ .reg = IDT821034_REGMAP_CH0_SLIC_DOUT, .def = 0 },
+		{ .reg = IDT821034_REGMAP_CH1_SLIC_CONF, .def = 0x3 },
+		{ .reg = IDT821034_REGMAP_CH1_SLIC_DOUT, .def = 0 },
+		{ .reg = IDT821034_REGMAP_CH2_SLIC_CONF, .def = 0x3 },
+		{ .reg = IDT821034_REGMAP_CH2_SLIC_DOUT, .def = 0 },
+		{ .reg = IDT821034_REGMAP_CH3_SLIC_CONF, .def = 0x3 },
+		{ .reg = IDT821034_REGMAP_CH3_SLIC_DOUT, .def = 0 },
+	};
+
+	return  regmap_multi_reg_write(idt821034->regmap,
+				       reg_reset, ARRAY_SIZE(reg_reset));
+}
+
+static int idt821034_gpio_init(struct idt821034 *idt821034)
+{
+	int ret;
+
+	ret = idt821034_reset_gpio(idt821034);
+	if (ret)
+		return ret;
+
+	idt821034->gpio_chip.owner = THIS_MODULE;
+	idt821034->gpio_chip.label = dev_name(&idt821034->spi->dev);
+	idt821034->gpio_chip.parent = &idt821034->spi->dev;
+	idt821034->gpio_chip.base = -1;
+	idt821034->gpio_chip.ngpio = 5 * 4; /* 5 GPIOs on 4 channels */
+	idt821034->gpio_chip.get_direction = idt821034_chip_get_direction;
+	idt821034->gpio_chip.direction_input = idt821034_chip_direction_input;
+	idt821034->gpio_chip.direction_output = idt821034_chip_direction_output;
+	idt821034->gpio_chip.get = idt821034_chip_gpio_get;
+	idt821034->gpio_chip.set = idt821034_chip_gpio_set;
+	idt821034->gpio_chip.can_sleep = true;
+
+	return devm_gpiochip_add_data(&idt821034->spi->dev, &idt821034->gpio_chip,
+				      idt821034);
+}
+#else /* IS_ENABLED(CONFIG_GPIOLIB) */
+static int idt821034_gpio_init(struct idt821034 *idt821034)
+{
+	return 0;
+}
+#endif
+
+static int idt821034_spi_probe(struct spi_device *spi)
+{
+	struct idt821034 *idt821034;
+	int ret;
+
+	spi->bits_per_word = 8;
+	ret = spi_setup(spi);
+	if (ret < 0)
+		return ret;
+
+	idt821034 = devm_kzalloc(&spi->dev, sizeof(*idt821034), GFP_KERNEL);
+	if (!idt821034)
+		return -ENOMEM;
+
+	idt821034->spi = spi;
+
+	idt821034->regmap = devm_regmap_init(&idt821034->spi->dev, NULL, idt821034,
+					     &idt821034_regmap_config);
+	if (IS_ERR(idt821034->regmap)) {
+		ret = PTR_ERR(idt821034->regmap);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, idt821034);
+
+	ret = devm_snd_soc_register_component(&spi->dev, &idt821034_component_driver,
+					      &idt821034_dai_driver, 1);
+	if (ret)
+		return ret;
+
+	ret = idt821034_gpio_init(idt821034);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id idt821034_of_match[] = {
+	{ .compatible = "renesas,idt821034", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, idt821034_of_match);
+
+static const struct spi_device_id idt821034_id_table[] = {
+	{ "idt821034", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, idt821034_id_table);
+
+static struct spi_driver idt821034_spi_driver = {
+	.driver  = {
+		.name   = "idt821034",
+		.of_match_table = idt821034_of_match,
+	},
+	.id_table = idt821034_id_table,
+	.probe  = idt821034_spi_probe,
+};
+
+module_spi_driver(idt821034_spi_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("IDT821034 ALSA SoC driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

