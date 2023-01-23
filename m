Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978736776D7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjAWI4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjAWI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:56:42 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B13A5CE;
        Mon, 23 Jan 2023 00:56:36 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BAC1C0007;
        Mon, 23 Jan 2023 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674464195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H7p9HwCMHWkB5pyFFJtTYXTX/6ECRGMmw9bhhCR9wc=;
        b=laxX9N+hPlxksvjzXA7t5kX6Xduk0L5QfNEfEl/x8FviQVr6oOYLv1FNQQlO5f8jb3Hbgw
        luWQzOY2JouebfPeC+e8oB/XLSj5b1qQB8ReTT+YROqmzBWUInKxEEItFQaixtHg/MC2S/
        Q5+FIo7l8Va9FZwBDzmZepq5ZFXX2g3wA9qxId9dTGU59qsncaBtoLLH/q61YuAszcRIkN
        zlnjHsB/H/4ZSQsOb8tNbl1VmYXDik5rqoc54DESZwuUs7HicV8nLpKls5OhN+BNf1NZpS
        xIGfGu4Po2FUCiC6BNFKasxRluxvh+KY1FLM+PWL7UHanNwAt207pcU0J/cD6A==
Date:   Mon, 23 Jan 2023 09:56:31 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/3] ASoC: codecs: Add support for the Renesas
 IDT821034 codec
Message-ID: <20230123095631.4aba35d6@bootlin.com>
In-Reply-To: <d51b826b-e71f-393c-586b-6a1ca953f26f@csgroup.eu>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
        <20230120095036.514639-3-herve.codina@bootlin.com>
        <d51b826b-e71f-393c-586b-6a1ca953f26f@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, 23 Jan 2023 07:53:49 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 20/01/2023 =C3=A0 10:50, Herve Codina a =C3=A9crit=C2=A0:
> > The Renesas IDT821034 codec is four channel PCM codec with on-chip
> > filters and programmable gain setting.
> > It also provides SLIC (Subscriber Line Interface Circuit) signals as
> > GPIOs.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >   sound/soc/codecs/Kconfig     |   12 +
> >   sound/soc/codecs/Makefile    |    2 +
> >   sound/soc/codecs/idt821034.c | 1200 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 1214 insertions(+)
> >   create mode 100644 sound/soc/codecs/idt821034.c
> >=20
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 0f9d71490075..67489b2ebd9f 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -107,6 +107,7 @@ config SND_SOC_ALL_CODECS
> >   	imply SND_SOC_HDAC_HDMI
> >   	imply SND_SOC_HDAC_HDA
> >   	imply SND_SOC_ICS43432
> > +	imply SND_SOC_IDT821034
> >   	imply SND_SOC_INNO_RK3036
> >   	imply SND_SOC_ISABELLE
> >   	imply SND_SOC_JZ4740_CODEC
> > @@ -972,6 +973,17 @@ config SND_SOC_HDA
> >   config SND_SOC_ICS43432
> >   	tristate "ICS43423 and compatible i2s microphones"
> >  =20
> > +config SND_SOC_IDT821034
> > +	tristate "Renesas IDT821034 quad PCM codec"
> > +	depends on SPI
> > +	select REGMAP_SPI =20
>=20
> Is selecting regmap still necessary ?

Indeed, REGMAP_SPI is not needed anymore.
Will be fixed in v3.

>=20
> > +	help
> > +	  Enable support for the Renesas IDT821034 quad PCM with
> > +	  programmable gain codec.
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called snd-soc-idt821034.
> > +
> >   config SND_SOC_INNO_RK3036
> >   	tristate "Inno codec driver for RK3036 SoC"
> >   	select REGMAP_MMIO
> > diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> > index 71d3ce5867e4..bcf95de654fd 100644
> > --- a/sound/soc/codecs/Makefile
> > +++ b/sound/soc/codecs/Makefile
> > @@ -111,6 +111,7 @@ snd-soc-hdac-hdmi-objs :=3D hdac_hdmi.o
> >   snd-soc-hdac-hda-objs :=3D hdac_hda.o
> >   snd-soc-hda-codec-objs :=3D hda.o hda-dai.o
> >   snd-soc-ics43432-objs :=3D ics43432.o
> > +snd-soc-idt821034-objs :=3D idt821034.o
> >   snd-soc-inno-rk3036-objs :=3D inno_rk3036.o
> >   snd-soc-isabelle-objs :=3D isabelle.o
> >   snd-soc-jz4740-codec-objs :=3D jz4740.o
> > @@ -472,6 +473,7 @@ obj-$(CONFIG_SND_SOC_HDAC_HDMI) +=3D snd-soc-hdac-h=
dmi.o
> >   obj-$(CONFIG_SND_SOC_HDAC_HDA) +=3D snd-soc-hdac-hda.o
> >   obj-$(CONFIG_SND_SOC_HDA) +=3D snd-soc-hda-codec.o
> >   obj-$(CONFIG_SND_SOC_ICS43432)	+=3D snd-soc-ics43432.o
> > +obj-$(CONFIG_SND_SOC_IDT821034)	+=3D snd-soc-idt821034.o
> >   obj-$(CONFIG_SND_SOC_INNO_RK3036)	+=3D snd-soc-inno-rk3036.o
> >   obj-$(CONFIG_SND_SOC_ISABELLE)	+=3D snd-soc-isabelle.o
> >   obj-$(CONFIG_SND_SOC_JZ4740_CODEC)	+=3D snd-soc-jz4740-codec.o
> > diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034.c
> > new file mode 100644
> > index 000000000000..5eb93fec6042
> > --- /dev/null
> > +++ b/sound/soc/codecs/idt821034.c
> > @@ -0,0 +1,1200 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +//
> > +// IDT821034 ALSA SoC driver
> > +//
> > +// Copyright 2022 CS GROUP France
> > +//
> > +// Author: Herve Codina <herve.codina@bootlin.com>
> > +
> > +#include <linux/bitrev.h>
> > +#include <linux/gpio/driver.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/spi/spi.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/tlv.h>
> > +
> > +#define IDT821034_NB_CHANNEL	4
> > +
> > +struct idt821034_amp {
> > +	u16 gain;
> > +	bool is_muted;
> > +};
> > +
> > +struct idt821034 {
> > +	struct spi_device *spi;
> > +	struct mutex mutex;
> > +	u8 spi_tx_buf; /* Cannot use stack area for SPI (dma-safe memory) */
> > +	u8 spi_rx_buf; /* Cannot use stack area for SPI (dma-safe memory) */
> > +	struct {
> > +		u8 codec_conf;
> > +		struct {
> > +			u8 power;
> > +			u8 tx_slot;
> > +			u8 rx_slot;
> > +			u8 slic_conf;
> > +			u8 slic_control;
> > +		} ch[IDT821034_NB_CHANNEL];
> > +	} cache;
> > +	struct {
> > +		struct {
> > +			struct idt821034_amp amp_out;
> > +			struct idt821034_amp amp_in;
> > +		} ch[IDT821034_NB_CHANNEL];
> > +	} amps;
> > +	int max_ch_playback;
> > +	int max_ch_capture;
> > +	struct gpio_chip gpio_chip;
> > +};
> > +
> > +static int idt821034_8bit_write(struct idt821034 *idt821034, u8 val)
> > +{
> > +	struct spi_transfer xfer[] =3D {
> > +		{
> > +			.tx_buf =3D &idt821034->spi_tx_buf,
> > +			.len =3D 1,
> > +		}, {
> > +			.cs_off =3D 1,
> > +			.tx_buf =3D &idt821034->spi_tx_buf,
> > +			.len =3D 1,
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	idt821034->spi_tx_buf =3D val;
> > +
> > +	dev_vdbg(&idt821034->spi->dev, "spi xfer wr 0x%x\n", val);
> > +
> > +	ret =3D spi_sync_transfer(idt821034->spi, xfer, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0; =20
>=20
> Looks like you could just do:
>=20
> 	return spi_sync_transfer(idt821034->spi, xfer, 2);

Yes, I will change in v3.

>=20
> > +}
> > +
> > +static int idt821034_8bit_read(struct idt821034 *idt821034, u8 valw, u=
8 *valr)
> > +{
> > +	struct spi_transfer xfer[] =3D {
> > +		{
> > +			.tx_buf =3D &idt821034->spi_tx_buf,
> > +			.rx_buf =3D &idt821034->spi_rx_buf,
> > +			.len =3D 1,
> > +		}, {
> > +			.cs_off =3D 1,
> > +			.tx_buf =3D &idt821034->spi_tx_buf,
> > +			.len =3D 1,
> > +		}
> > +	};
> > +	int ret;
> > +
> > +	idt821034->spi_tx_buf =3D valw;
> > +
> > +	ret =3D spi_sync_transfer(idt821034->spi, xfer, 2);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*valr =3D idt821034->spi_rx_buf;
> > +
> > +	dev_vdbg(&idt821034->spi->dev, "spi xfer wr 0x%x, rd 0x%x\n",
> > +		 valw, *valr);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Available mode the programming sequence */ =20
>=20
> s/the/for/ ?

Sure, I will change in v3.

>=20
> > +#define IDT821034_MODE_CODEC(_ch) (0x80 | ((_ch) << 2))
> > +#define IDT821034_MODE_SLIC(_ch)  (0xD0 | ((_ch) << 2))
> > +#define IDT821034_MODE_GAIN(_ch)  (0xC0 | ((_ch) << 2))
> > +
> > +/* Power values that can be used in 'power' (can be ORed) */
> > +#define IDT821034_CONF_PWRUP_TX		BIT(1) /* from analog input to PCM */
> > +#define IDT821034_CONF_PWRUP_RX		BIT(0) /* from PCM to analog output */
> > +
> > +static int idt821034_set_channel_power(struct idt821034 *idt821034, u8=
 ch, u8 power)
> > +{
> > +	u8 conf;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "set_channel_power(%u, 0x%x)\n", ch, po=
wer);
> > +
> > +	conf =3D IDT821034_MODE_CODEC(ch) | idt821034->cache.codec_conf;
> > +
> > +	if (power & IDT821034_CONF_PWRUP_RX) {
> > +		ret =3D idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_=
RX);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].rx_s=
lot);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	if (power & IDT821034_CONF_PWRUP_TX) {
> > +		ret =3D idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP_=
TX);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].tx_s=
lot);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +	if (!(power & (IDT821034_CONF_PWRUP_TX | IDT821034_CONF_PWRUP_RX))) {
> > +		ret =3D idt821034_8bit_write(idt821034, conf);
> > +		if (ret)
> > +			return ret;
> > +		ret =3D idt821034_8bit_write(idt821034, 0x00);
> > +		if (ret)
> > +			return ret;
> > +	} =20
>=20
> Can we refactor the three actions with an helper, that could also be=20
> reused for idt821034_set_codec_conf() and idt821034_set_channel_ts() and=
=20
> idt821034_set_slic_conf() and idt821034_write_slic_raw() and=20
> idt821034_set_gain_channel, something like for instance:
>=20
> static int idt821034_set_conf(struct idt821034 *idt821034, u8 conf, u8 va=
l)
> {
> 	ret =3D idt821034_8bit_write(idt821034, conf);
> 	if (ret)
> 		return ret;
> 	return idt821034_8bit_write(idt821034, val);
> }

It can be changed.
The function name will not be idt821034_set_conf() as it is not the same
kind of funtion as the idt821031_set_*() already available in the code.
What do you think about:
  static int idt821034_2x8bit_write(struct idt821034 *idt821034, u8 val1, u=
8 val2)
or
  static int idt821034_conf_write(struct idt821034 *idt821034, u8 conf, u8 =
val)

I prefer the first one but it is only a personal preference.
On your side, what do you prefer ?

>=20
> > +
> > +	idt821034->cache.ch[ch].power =3D power;
> > +
> > +	return 0;
> > +}
> > +
> > +static u8 idt821034_get_channel_power(struct idt821034 *idt821034, u8 =
ch)
> > +{
> > +	return idt821034->cache.ch[ch].power;
> > +}
> > +
> > +/* Codec configuration values that can be used in 'codec_conf' (can be=
 ORed) */
> > +#define IDT821034_CONF_ALAW_MODE	BIT(5)
> > +#define IDT821034_CONF_DELAY_MODE	BIT(4)
> > +
> > +static int idt821034_set_codec_conf(struct idt821034 *idt821034, u8 co=
dec_conf)
> > +{
> > +	u8 conf;
> > +	u8 ts;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "set_codec_conf(0x%x)\n", codec_conf);
> > +
> > +	/* codec conf fields are common to all channel.
> > +	 * Arbitrary use of channel 0 for this configuration.
> > +	 */
> > +
> > +	/* Set Configuration Register */
> > +	conf =3D IDT821034_MODE_CODEC(0) | codec_conf;
> > +
> > +	/* Update conf value and timeslot register value according
> > +	 * to cache values
> > +	 */
> > +	if (idt821034->cache.ch[0].power & IDT821034_CONF_PWRUP_RX) {
> > +		conf |=3D IDT821034_CONF_PWRUP_RX;
> > +		ts =3D idt821034->cache.ch[0].rx_slot;
> > +	} else if (idt821034->cache.ch[0].power & IDT821034_CONF_PWRUP_TX) {
> > +		conf |=3D IDT821034_CONF_PWRUP_TX;
> > +		ts =3D idt821034->cache.ch[0].tx_slot;
> > +	} else {
> > +		ts =3D 0x00;
> > +	}
> > +
> > +	/* Write configuration register and time-slot register */
> > +	ret =3D idt821034_8bit_write(idt821034, conf);
> > +	if (ret)
> > +		return ret;
> > +	ret =3D idt821034_8bit_write(idt821034, ts);
> > +	if (ret)
> > +		return ret;
> > +
> > +	idt821034->cache.codec_conf =3D codec_conf;
> > +	return 0;
> > +}
> > +
> > +static u8 idt821034_get_codec_conf(struct idt821034 *idt821034)
> > +{
> > +	return idt821034->cache.codec_conf;
> > +}
> > +
> > +/* Channel direction values that can be used in 'ch_dir' (can be ORed)=
 */
> > +#define IDT821034_CH_RX		BIT(0) /* from PCM to analog output */
> > +#define IDT821034_CH_TX		BIT(1) /* from analog input to PCM */
> > +
> > +static int idt821034_set_channel_ts(struct idt821034 *idt821034, u8 ch=
, u8 ch_dir, u8 ts_num)
> > +{
> > +	u8 conf;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "set_channel_ts(%u, 0x%x, %d)\n", ch, c=
h_dir, ts_num);
> > +
> > +	conf =3D IDT821034_MODE_CODEC(ch) | idt821034->cache.codec_conf;
> > +
> > +	if (ch_dir & IDT821034_CH_RX) {
> > +		if (idt821034->cache.ch[ch].power & IDT821034_CONF_PWRUP_RX) {
> > +			ret =3D idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP=
_RX);
> > +			if (ret)
> > +				return ret;
> > +			ret =3D idt821034_8bit_write(idt821034, ts_num);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		idt821034->cache.ch[ch].rx_slot =3D ts_num;
> > +	}
> > +	if (ch_dir & IDT821034_CH_TX) {
> > +		if (idt821034->cache.ch[ch].power & IDT821034_CONF_PWRUP_TX) {
> > +			ret =3D idt821034_8bit_write(idt821034, conf | IDT821034_CONF_PWRUP=
_TX);
> > +			if (ret)
> > +				return ret;
> > +			ret =3D idt821034_8bit_write(idt821034, ts_num);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +		idt821034->cache.ch[ch].tx_slot =3D ts_num;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* SLIC direction values that can be used in 'slic_dir' (can be ORed) =
*/
> > +#define IDT821034_SLIC_IO1_IN       BIT(1)
> > +#define IDT821034_SLIC_IO0_IN       BIT(0)
> > +
> > +static int idt821034_set_slic_conf(struct idt821034 *idt821034, u8 ch,=
 u8 slic_dir)
> > +{
> > +	u8 conf;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "set_slic_conf(%u, 0x%x)\n", ch, slic_d=
ir);
> > +
> > +	conf =3D IDT821034_MODE_SLIC(ch) | slic_dir;
> > +	ret =3D idt821034_8bit_write(idt821034, conf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, idt821034->cache.ch[ch].slic_=
control);
> > +	if (ret)
> > +		return ret;
> > +
> > +	idt821034->cache.ch[ch].slic_conf =3D slic_dir;
> > +
> > +	return 0;
> > +}
> > +
> > +static u8 idt821034_get_slic_conf(struct idt821034 *idt821034, u8 ch)
> > +{
> > +	return idt821034->cache.ch[ch].slic_conf;
> > +}
> > +
> > +static int idt821034_write_slic_raw(struct idt821034 *idt821034, u8 ch=
, u8 slic_raw)
> > +{
> > +	u8 conf;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "write_slic_raw(%u, 0x%x)\n", ch, slic_=
raw);
> > +
> > +	/*
> > +	 * On write, slic_raw is mapped as follow :
> > +	 *   b4: O_4
> > +	 *   b3: O_3
> > +	 *   b2: O_2
> > +	 *   b1: I/O_1
> > +	 *   b0: I/O_0
> > +	 */
> > +
> > +	conf =3D IDT821034_MODE_SLIC(ch) | idt821034->cache.ch[ch].slic_conf;
> > +	ret =3D idt821034_8bit_write(idt821034, conf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, slic_raw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	idt821034->cache.ch[ch].slic_control =3D slic_raw;
> > +	return 0;
> > +}
> > +
> > +static u8 idt821034_get_written_slic_raw(struct idt821034 *idt821034, =
u8 ch)
> > +{
> > +	return idt821034->cache.ch[ch].slic_control;
> > +}
> > +
> > +static int idt821034_read_slic_raw(struct idt821034 *idt821034, u8 ch,=
 u8 *slic_raw)
> > +{
> > +	u8 val;
> > +	int ret;
> > +
> > +	/*
> > +	 * On read, slic_raw is mapped as follow :
> > +	 *   b7: I/O_0
> > +	 *   b6: I/O_1
> > +	 *   b5: O_2
> > +	 *   b4: O_3
> > +	 *   b3: O_4
> > +	 *   b2: I/O1_0, I/O_0 from channel 1 (no matter ch value)
> > +	 *   b1: I/O2_0, I/O_0 from channel 2 (no matter ch value)
> > +	 *   b2: I/O3_0, I/O_0 from channel 3 (no matter ch value)
> > +	 */
> > +
> > +	val =3D IDT821034_MODE_SLIC(ch) | idt821034->cache.ch[ch].slic_conf;
> > +	ret =3D idt821034_8bit_write(idt821034, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_read(idt821034, idt821034->cache.ch[ch].slic_c=
ontrol, slic_raw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "read_slic_raw(%i) 0x%x\n", ch, *slic_r=
aw);
> > +
> > +	return 0;
> > +}
> > +
> > +/* Gain type values that can be used in 'gain_type' (cannot be ORed) */
> > +#define IDT821034_GAIN_RX		(0 << 1) /* from PCM to analog output */
> > +#define IDT821034_GAIN_TX		(1 << 1) /* from analog input to PCM */
> > +
> > +static int idt821034_set_gain_channel(struct idt821034 *idt821034, u8 =
ch,
> > +				      u8 gain_type, u16 gain_val)
> > +{
> > +	u8 conf;
> > +	int ret;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "set_gain_channel(%u, 0x%x, 0x%x-%d)\n",
> > +		ch, gain_type, gain_val, gain_val);
> > +
> > +	/*
> > +	 * The gain programming coefficients should be calculated as:
> > +	 *   Transmit : Coeff_X =3D round [ gain_X0dB =C3=97 gain_X ]
> > +	 *   Receive: Coeff_R =3D round [ gain_R0dB =C3=97 gain_R ]
> > +	 * where:
> > +	 *   gain_X0dB =3D 1820;
> > +	 *   gain_X is the target gain;
> > +	 *   Coeff_X should be in the range of 0 to 8192.
> > +	 *   gain_R0dB =3D 2506;
> > +	 *   gain_R is the target gain;
> > +	 *   Coeff_R should be in the range of 0 to 8192.
> > +	 *
> > +	 * A gain programming coefficient is 14-bit wide and in binary format.
> > +	 * The 7 Most Significant Bits of the coefficient is called
> > +	 * GA_MSB_Transmit for transmit path, or is called GA_MSB_Receive for
> > +	 * receive path; The 7 Least Significant Bits of the coefficient is
> > +	 * called GA_LSB_ Transmit for transmit path, or is called
> > +	 * GA_LSB_Receive for receive path.
> > +	 *
> > +	 * An example is given below to clarify the calculation of the
> > +	 * coefficient. To program a +3 dB gain in transmit path and a -3.5 dB
> > +	 * gain in receive path:
> > +	 *
> > +	 * Linear Code of +3dB =3D 10^(3/20)=3D 1.412537545
> > +	 * Coeff_X =3D round (1820 =C3=97 1.412537545) =3D 2571
> > +	 *                                      =3D 0b001010_00001011
> > +	 * GA_MSB_Transmit =3D 0b0010100
> > +	 * GA_LSB_Transmit =3D 0b0001011
> > +	 *
> > +	 * Linear Code of -3.5dB =3D 10^(-3.5/20) =3D 0.668343917
> > +	 * Coeff_R=3D round (2506 =C3=97 0.668343917) =3D 1675
> > +	 *                                     =3D 0b0001101_0001011
> > +	 * GA_MSB_Receive =3D 0b0001101
> > +	 * GA_LSB_Receive =3D 0b0001011
> > +	 */
> > +
> > +	conf =3D IDT821034_MODE_GAIN(ch) | gain_type;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, conf | 0x00);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, gain_val & 0x007F);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, conf | 0x01);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_8bit_write(idt821034, (gain_val >> 7) & 0x7F);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/* Id helpers used in controls and dapm */
> > +#define IDT821034_DIR_OUT (1 << 3)
> > +#define IDT821034_DIR_IN  (0 << 3)
> > +#define IDT821034_ID(_ch, _dir) (((_ch) & 0x03) | (_dir))
> > +#define IDT821034_ID_OUT(_ch) IDT821034_ID(_ch, IDT821034_DIR_OUT)
> > +#define IDT821034_ID_IN(_ch)  IDT821034_ID(_ch, IDT821034_DIR_IN)
> > +
> > +#define IDT821034_ID_GET_CHAN(_id) ((_id) & 0x03)
> > +#define IDT821034_ID_GET_DIR(_id) ((_id) & (1 << 3))
> > +#define IDT821034_ID_IS_OUT(_id) (IDT821034_ID_GET_DIR(_id) =3D=3D IDT=
821034_DIR_OUT)
> > +
> > +static int idt821034_kctrl_gain_get(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct soc_mixer_control *mc =3D (struct soc_mixer_control *)kcontrol=
->private_value;
> > +	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kc=
ontrol);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	int min =3D mc->min;
> > +	int max =3D mc->max;
> > +	unsigned int mask =3D (1 << fls(max)) - 1;
> > +	unsigned int invert =3D mc->invert;
> > +	int val;
> > +	u8 ch;
> > +
> > +	ch =3D IDT821034_ID_GET_CHAN(mc->reg);
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +	if (IDT821034_ID_IS_OUT(mc->reg))
> > +		val =3D idt821034->amps.ch[ch].amp_out.gain;
> > +	else
> > +		val =3D idt821034->amps.ch[ch].amp_in.gain;
> > +	mutex_unlock(&idt821034->mutex);
> > +
> > +	ucontrol->value.integer.value[0] =3D val & mask;
> > +	if (invert)
> > +		ucontrol->value.integer.value[0] =3D max - ucontrol->value.integer.v=
alue[0];
> > +	else
> > +		ucontrol->value.integer.value[0] =3D ucontrol->value.integer.value[0=
] - min;
> > +
> > +	return 0;
> > +}
> > +
> > +static int idt821034_kctrl_gain_put(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct soc_mixer_control *mc =3D (struct soc_mixer_control *)kcontrol=
->private_value;
> > +	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kc=
ontrol);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	struct idt821034_amp *amp;
> > +	int min =3D mc->min;
> > +	int max =3D mc->max;
> > +	unsigned int mask =3D (1 << fls(max)) - 1;
> > +	unsigned int invert =3D mc->invert;
> > +	unsigned int val;
> > +	int ret;
> > +	u8 gain_type;
> > +	u8 ch;
> > +
> > +	val =3D ucontrol->value.integer.value[0];
> > +	if (val < 0)
> > +		return -EINVAL;
> > +	if (val > max - min)
> > +		return -EINVAL;
> > +
> > +	if (invert)
> > +		val =3D (max - val) & mask;
> > +	else
> > +		val =3D (val + min) & mask;
> > +
> > +	ch =3D IDT821034_ID_GET_CHAN(mc->reg);
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	if (IDT821034_ID_IS_OUT(mc->reg)) {
> > +		amp =3D &idt821034->amps.ch[ch].amp_out;
> > +		gain_type =3D IDT821034_GAIN_RX;
> > +	} else {
> > +		amp =3D &idt821034->amps.ch[ch].amp_in;
> > +		gain_type =3D IDT821034_GAIN_TX;
> > +	}
> > +
> > +	if (!amp->is_muted) {
> > +		ret =3D idt821034_set_gain_channel(idt821034, ch, gain_type, val);
> > +		if (ret)
> > +			goto end;
> > +	}
> > +
> > +	amp->gain =3D val;
> > +	ret =3D 0;
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_kctrl_mute_get(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kc=
ontrol);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	int id =3D kcontrol->private_value;
> > +	bool is_muted;
> > +	u8 ch;
> > +
> > +	ch =3D IDT821034_ID_GET_CHAN(id);
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +	is_muted =3D IDT821034_ID_IS_OUT(id) ?
> > +			idt821034->amps.ch[ch].amp_out.is_muted:
> > +			idt821034->amps.ch[ch].amp_in.is_muted;
> > +	mutex_unlock(&idt821034->mutex);
> > +
> > +	ucontrol->value.integer.value[0] =3D !is_muted;
> > +
> > +	return 0;
> > +}
> > +
> > +static int idt821034_kctrl_mute_put(struct snd_kcontrol *kcontrol,
> > +				    struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_component *component =3D snd_soc_kcontrol_component(kc=
ontrol);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	int id =3D kcontrol->private_value;
> > +	struct idt821034_amp *amp;
> > +	bool is_mute;
> > +	u8 gain_type;
> > +	int ret;
> > +	u8 ch;
> > +
> > +	ch =3D IDT821034_ID_GET_CHAN(id);
> > +	is_mute =3D !ucontrol->value.integer.value[0];
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	if (IDT821034_ID_IS_OUT(id)) {
> > +		amp =3D &idt821034->amps.ch[ch].amp_out;
> > +		gain_type =3D IDT821034_GAIN_RX;
> > +	} else {
> > +		amp =3D &idt821034->amps.ch[ch].amp_in;
> > +		gain_type =3D IDT821034_GAIN_TX;
> > +	}
> > +
> > +	ret =3D idt821034_set_gain_channel(idt821034, ch, gain_type,
> > +					 is_mute ? 0 : amp->gain);
> > +	if (ret)
> > +		goto end;
> > +
> > +	amp->is_muted =3D is_mute;
> > +
> > +	ret =3D 0;
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static const DECLARE_TLV_DB_LINEAR(idt821034_gain_in, -6520, 1306);
> > +#define IDT821034_GAIN_IN_MIN_RAW	1 /* -65.20 dB -> 10^(-65.2/20.0) * =
1820 =3D 1 */
> > +#define IDT821034_GAIN_IN_MAX_RAW	8191 /* 13.06 dB -> 10^(13.06/20.0) =
* 1820 =3D 8191 */
> > +#define IDT821034_GAIN_IN_INIT_RAW	1820 /* 0dB -> 10^(0/20) * 1820 =3D=
 1820 */
> > +
> > +static const DECLARE_TLV_DB_LINEAR(idt821034_gain_out, -6798, 1029);
> > +#define IDT821034_GAIN_OUT_MIN_RAW	1 /* -67.98 dB -> 10^(-67.98/20.0) =
* 2506 =3D 1*/
> > +#define IDT821034_GAIN_OUT_MAX_RAW	8191 /* 10.29 dB -> 10^(10.29/20.0)=
 * 2506 =3D 8191 */
> > +#define IDT821034_GAIN_OUT_INIT_RAW	2506 /* 0dB -> 10^(0/20) * 2506 =
=3D 2506 */
> > +
> > +static const struct snd_kcontrol_new idt821034_controls[] =3D {
> > +	/* DAC volume control */
> > +	SOC_SINGLE_RANGE_EXT_TLV("DAC0 Playback Volume", IDT821034_ID_OUT(0),=
 0,
> > +				 IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_out),
> > +	SOC_SINGLE_RANGE_EXT_TLV("DAC1 Playback Volume", IDT821034_ID_OUT(1),=
 0,
> > +				 IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_out),
> > +	SOC_SINGLE_RANGE_EXT_TLV("DAC2 Playback Volume", IDT821034_ID_OUT(2),=
 0,
> > +				 IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_out),
> > +	SOC_SINGLE_RANGE_EXT_TLV("DAC3 Playback Volume", IDT821034_ID_OUT(3),=
 0,
> > +				 IDT821034_GAIN_OUT_MIN_RAW, IDT821034_GAIN_OUT_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_out),
> > +
> > +	/* DAC mute control */
> > +	SOC_SINGLE_BOOL_EXT("DAC0 Playback Switch", IDT821034_ID_OUT(0),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("DAC1 Playback Switch", IDT821034_ID_OUT(1),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("DAC2 Playback Switch", IDT821034_ID_OUT(2),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("DAC3 Playback Switch", IDT821034_ID_OUT(3),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +
> > +	/* ADC volume control */
> > +	SOC_SINGLE_RANGE_EXT_TLV("ADC0 Capture Volume", IDT821034_ID_IN(0), 0,
> > +				 IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_in),
> > +	SOC_SINGLE_RANGE_EXT_TLV("ADC1 Capture Volume", IDT821034_ID_IN(1), 0,
> > +				 IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_in),
> > +	SOC_SINGLE_RANGE_EXT_TLV("ADC2 Capture Volume", IDT821034_ID_IN(2), 0,
> > +				 IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_in),
> > +	SOC_SINGLE_RANGE_EXT_TLV("ADC3 Capture Volume", IDT821034_ID_IN(3), 0,
> > +				 IDT821034_GAIN_IN_MIN_RAW, IDT821034_GAIN_IN_MAX_RAW,
> > +				 0, idt821034_kctrl_gain_get, idt821034_kctrl_gain_put,
> > +				 idt821034_gain_in),
> > +
> > +	/* ADC mute control */
> > +	SOC_SINGLE_BOOL_EXT("ADC0 Capture Switch", IDT821034_ID_IN(0),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("ADC1 Capture Switch", IDT821034_ID_IN(1),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("ADC2 Capture Switch", IDT821034_ID_IN(2),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +	SOC_SINGLE_BOOL_EXT("ADC3 Capture Switch", IDT821034_ID_IN(3),
> > +			    idt821034_kctrl_mute_get, idt821034_kctrl_mute_put),
> > +};
> > +
> > +static int idt821034_power_event(struct snd_soc_dapm_widget *w,
> > +				 struct snd_kcontrol *kcontrol, int event)
> > +{
> > +	struct snd_soc_component *component =3D snd_soc_dapm_to_component(w->=
dapm);
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	unsigned int id =3D w->shift;
> > +	u8 power, mask;
> > +	int ret;
> > +	u8 ch;
> > +
> > +	ch =3D IDT821034_ID_GET_CHAN(id);
> > +	mask =3D IDT821034_ID_IS_OUT(id) ? IDT821034_CONF_PWRUP_RX : IDT82103=
4_CONF_PWRUP_TX;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	power =3D idt821034_get_channel_power(idt821034, ch);
> > +	if (SND_SOC_DAPM_EVENT_ON(event))
> > +		power |=3D mask;
> > +	else
> > +		power &=3D ~mask;
> > +	ret =3D idt821034_set_channel_power(idt821034, ch, power);
> > +
> > +	mutex_unlock(&idt821034->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct snd_soc_dapm_widget idt821034_dapm_widgets[] =3D {
> > +	SND_SOC_DAPM_DAC_E("DAC0", "Playback", SND_SOC_NOPM, IDT821034_ID_OUT=
(0), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("DAC1", "Playback", SND_SOC_NOPM, IDT821034_ID_OUT=
(1), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("DAC2", "Playback", SND_SOC_NOPM, IDT821034_ID_OUT=
(2), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("DAC3", "Playback", SND_SOC_NOPM, IDT821034_ID_OUT=
(3), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +
> > +	SND_SOC_DAPM_OUTPUT("OUT0"),
> > +	SND_SOC_DAPM_OUTPUT("OUT1"),
> > +	SND_SOC_DAPM_OUTPUT("OUT2"),
> > +	SND_SOC_DAPM_OUTPUT("OUT3"),
> > +
> > +	SND_SOC_DAPM_DAC_E("ADC0", "Capture", SND_SOC_NOPM, IDT821034_ID_IN(0=
), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("ADC1", "Capture", SND_SOC_NOPM, IDT821034_ID_IN(1=
), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("ADC2", "Capture", SND_SOC_NOPM, IDT821034_ID_IN(2=
), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +	SND_SOC_DAPM_DAC_E("ADC3", "Capture", SND_SOC_NOPM, IDT821034_ID_IN(3=
), 0,
> > +			   idt821034_power_event,
> > +			   SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> > +
> > +	SND_SOC_DAPM_INPUT("IN0"),
> > +	SND_SOC_DAPM_INPUT("IN1"),
> > +	SND_SOC_DAPM_INPUT("IN2"),
> > +	SND_SOC_DAPM_INPUT("IN3"),
> > +};
> > +
> > +static const struct snd_soc_dapm_route idt821034_dapm_routes[] =3D {
> > +	{ "OUT0", NULL, "DAC0" },
> > +	{ "OUT1", NULL, "DAC1" },
> > +	{ "OUT2", NULL, "DAC2" },
> > +	{ "OUT3", NULL, "DAC3" },
> > +
> > +	{ "ADC0", NULL, "IN0" },
> > +	{ "ADC1", NULL, "IN1" },
> > +	{ "ADC2", NULL, "IN2" },
> > +	{ "ADC3", NULL, "IN3" },
> > +};
> > +
> > +static int idt821034_dai_set_tdm_slot(struct snd_soc_dai *dai,
> > +				      unsigned int tx_mask, unsigned int rx_mask,
> > +				      int slots, int width)
> > +{
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(dai->co=
mponent);
> > +	unsigned int mask;
> > +	u8 slot;
> > +	int ret;
> > +	u8 ch;
> > +
> > +	switch (width) {
> > +	case 0: /* Not set -> default 8 */
> > +	case 8:
> > +		break;
> > +	default:
> > +		dev_err(dai->dev, "tdm slot width %d not supported\n", width);
> > +		return -EINVAL;
> > +	}
> > +
> > +	mask =3D tx_mask;
> > +	slot =3D 0;
> > +	ch =3D 0;
> > +	while (mask && ch < IDT821034_NB_CHANNEL) {
> > +		if (mask & 0x1) {
> > +			mutex_lock(&idt821034->mutex);
> > +			ret =3D idt821034_set_channel_ts(idt821034, ch, IDT821034_CH_RX, sl=
ot);
> > +			mutex_unlock(&idt821034->mutex);
> > +			if (ret) {
> > +				dev_err(dai->dev, "ch%u set tx tdm slot failed (%d)\n",
> > +					ch, ret);
> > +				return ret;
> > +			}
> > +			ch++;
> > +		}
> > +		mask >>=3D 1;
> > +		slot++;
> > +	}
> > +	if (mask) {
> > +		dev_err(dai->dev, "too much tx slots defined (mask =3D 0x%x) support=
 max %d\n",
> > +			tx_mask, IDT821034_NB_CHANNEL);
> > +		return -EINVAL;
> > +	}
> > +	idt821034->max_ch_playback =3D ch;
> > +
> > +	mask =3D rx_mask;
> > +	slot =3D 0;
> > +	ch =3D 0;
> > +	while (mask && ch < IDT821034_NB_CHANNEL) {
> > +		if (mask & 0x1) {
> > +			mutex_lock(&idt821034->mutex);
> > +			ret =3D idt821034_set_channel_ts(idt821034, ch, IDT821034_CH_TX, sl=
ot);
> > +			mutex_unlock(&idt821034->mutex);
> > +			if (ret) {
> > +				dev_err(dai->dev, "ch%u set rx tdm slot failed (%d)\n",
> > +					ch, ret);
> > +				return ret;
> > +			}
> > +			ch++;
> > +		}
> > +		mask >>=3D 1;
> > +		slot++;
> > +	}
> > +	if (mask) {
> > +		dev_err(dai->dev, "too much rx slots defined (mask =3D 0x%x) support=
 max %d\n",
> > +			rx_mask, IDT821034_NB_CHANNEL);
> > +		return -EINVAL;
> > +	}
> > +	idt821034->max_ch_capture =3D ch;
> > +
> > +	return 0;
> > +}
> > +
> > +static int idt821034_dai_set_fmt(struct snd_soc_dai *dai, unsigned int=
 fmt)
> > +{
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(dai->co=
mponent);
> > +	u8 conf;
> > +	int ret;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	conf =3D idt821034_get_codec_conf(idt821034);
> > +
> > +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> > +	case SND_SOC_DAIFMT_DSP_A:
> > +		conf |=3D IDT821034_CONF_DELAY_MODE;
> > +		break;
> > +	case SND_SOC_DAIFMT_DSP_B:
> > +		conf &=3D ~IDT821034_CONF_DELAY_MODE;
> > +		break;
> > +	default:
> > +		dev_err(dai->dev, "Unsupported DAI format 0x%x\n",
> > +			fmt & SND_SOC_DAIFMT_FORMAT_MASK);
> > +		ret =3D -EINVAL;
> > +		goto end;
> > +	}
> > +	ret =3D idt821034_set_codec_conf(idt821034, conf);
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_dai_hw_params(struct snd_pcm_substream *substream,
> > +				   struct snd_pcm_hw_params *params,
> > +				   struct snd_soc_dai *dai)
> > +{
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(dai->co=
mponent);
> > +	u8 conf;
> > +	int ret;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	conf =3D idt821034_get_codec_conf(idt821034);
> > +
> > +	switch (params_format(params)) {
> > +	case SNDRV_PCM_FORMAT_A_LAW:
> > +		conf |=3D IDT821034_CONF_ALAW_MODE;
> > +		break;
> > +	case SNDRV_PCM_FORMAT_MU_LAW:
> > +		conf &=3D ~IDT821034_CONF_ALAW_MODE;
> > +		break;
> > +	default:
> > +		dev_err(dai->dev, "Unsupported PCM format 0x%x\n",
> > +			params_format(params));
> > +		ret =3D -EINVAL;
> > +		goto end;
> > +	}
> > +	ret =3D idt821034_set_codec_conf(idt821034, conf);
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static const unsigned int idt821034_sample_bits[] =3D {8};
> > +
> > +static struct snd_pcm_hw_constraint_list idt821034_sample_bits_constr =
=3D {
> > +	.list =3D idt821034_sample_bits,
> > +	.count =3D ARRAY_SIZE(idt821034_sample_bits),
> > +};
> > +
> > +static int idt821034_dai_startup(struct snd_pcm_substream *substream,
> > +				 struct snd_soc_dai *dai)
> > +{
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(dai->co=
mponent);
> > +	unsigned int max_ch =3D 0;
> > +	int ret;
> > +
> > +	max_ch =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) ?
> > +		idt821034->max_ch_playback : idt821034->max_ch_capture;
> > +
> > +	/*
> > +	 * Disable stream support (min =3D 0, max =3D 0) if no timeslots were
> > +	 * configured otherwise, limit the number of channels to those
> > +	 * configured.
> > +	 */
> > +	ret =3D snd_pcm_hw_constraint_minmax(substream->runtime, SNDRV_PCM_HW=
_PARAM_CHANNELS,
> > +					   max_ch ? 1 : 0, max_ch);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D snd_pcm_hw_constraint_list(substream->runtime, 0, SNDRV_PCM_H=
W_PARAM_SAMPLE_BITS,
> > +					 &idt821034_sample_bits_constr);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static u64 idt821034_dai_formats[] =3D {
> > +	SND_SOC_POSSIBLE_DAIFMT_DSP_A	|
> > +	SND_SOC_POSSIBLE_DAIFMT_DSP_B,
> > +};
> > +
> > +static const struct snd_soc_dai_ops idt821034_dai_ops =3D {
> > +	.startup      =3D idt821034_dai_startup,
> > +	.hw_params    =3D idt821034_dai_hw_params,
> > +	.set_tdm_slot =3D idt821034_dai_set_tdm_slot,
> > +	.set_fmt      =3D idt821034_dai_set_fmt,
> > +	.auto_selectable_formats     =3D idt821034_dai_formats,
> > +	.num_auto_selectable_formats =3D ARRAY_SIZE(idt821034_dai_formats),
> > +};
> > +
> > +static struct snd_soc_dai_driver idt821034_dai_driver =3D {
> > +	.name =3D "idt821034",
> > +	.playback =3D {
> > +		.stream_name =3D "Playback",
> > +		.channels_min =3D 1,
> > +		.channels_max =3D IDT821034_NB_CHANNEL,
> > +		.rates =3D SNDRV_PCM_RATE_8000,
> > +		.formats =3D SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
> > +	},
> > +	.capture =3D {
> > +		.stream_name =3D "Capture",
> > +		.channels_min =3D 1,
> > +		.channels_max =3D IDT821034_NB_CHANNEL,
> > +		.rates =3D SNDRV_PCM_RATE_8000,
> > +		.formats =3D SNDRV_PCM_FMTBIT_MU_LAW | SNDRV_PCM_FMTBIT_A_LAW,
> > +	},
> > +	.ops =3D &idt821034_dai_ops,
> > +};
> > +
> > +static int idt821034_reset_audio(struct idt821034 *idt821034)
> > +{
> > +	int ret;
> > +	u8 i;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	ret =3D idt821034_set_codec_conf(idt821034, 0);
> > +	if (ret)
> > +		goto end;
> > +
> > +	for (i =3D 0; i < IDT821034_NB_CHANNEL; i++) {
> > +		idt821034->amps.ch[i].amp_out.gain =3D IDT821034_GAIN_OUT_INIT_RAW;
> > +		idt821034->amps.ch[i].amp_out.is_muted =3D false;
> > +		ret =3D idt821034_set_gain_channel(idt821034, i, IDT821034_GAIN_RX,
> > +						 idt821034->amps.ch[i].amp_out.gain);
> > +		if (ret)
> > +			goto end;
> > +
> > +		idt821034->amps.ch[i].amp_in.gain =3D IDT821034_GAIN_IN_INIT_RAW;
> > +		idt821034->amps.ch[i].amp_in.is_muted =3D false;
> > +		ret =3D idt821034_set_gain_channel(idt821034, i, IDT821034_GAIN_TX,
> > +						 idt821034->amps.ch[i].amp_in.gain);
> > +		if (ret)
> > +			goto end;
> > +
> > +		ret =3D idt821034_set_channel_power(idt821034, i, 0);
> > +		if (ret)
> > +			goto end;
> > +	}
> > +
> > +	ret =3D 0;
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_component_probe(struct snd_soc_component *compone=
nt)
> > +{
> > +	struct idt821034 *idt821034 =3D snd_soc_component_get_drvdata(compone=
nt);
> > +	int ret;
> > +
> > +	/* reset idt821034 audio part*/
> > +	ret =3D idt821034_reset_audio(idt821034);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct snd_soc_component_driver idt821034_component_drive=
r =3D {
> > +	.probe			=3D idt821034_component_probe,
> > +	.controls		=3D idt821034_controls,
> > +	.num_controls		=3D ARRAY_SIZE(idt821034_controls),
> > +	.dapm_widgets		=3D idt821034_dapm_widgets,
> > +	.num_dapm_widgets	=3D ARRAY_SIZE(idt821034_dapm_widgets),
> > +	.dapm_routes		=3D idt821034_dapm_routes,
> > +	.num_dapm_routes	=3D ARRAY_SIZE(idt821034_dapm_routes),
> > +	.endianness		=3D 1,
> > +};
> > +
> > +#if IS_ENABLED(CONFIG_GPIOLIB) =20
>=20
> #ifdef CONFIG_GPIOLIB ?
>=20
> Is that #if section needed at all ? Isn't it possible to have it all the=
=20
> time and check IS_ENABLED(CONFIG_GPIOLIB) in the probe before calling=20
> the init ? Something like :
>=20
>          if (IS_ENABLED(CONFIG_GPIOLIB))
> 		return idt821034_gpio_init(idt821034);
> 	return 0;

The following functions:
 - idt821034_chip_gpio_set(),
 - idt821034_chip_gpio_get(),
 - idt821034_chip_get_direction(),
 - idt821034_chip_direction_input(),
 - idt821034_chip_direction_output()=20
use gpiochip_get_data() to retrieve private data.

gpiochip_get_data() is defined only when CONFIG_GPIOLIB is set.
That's why the #if section is used.

>=20
> > +#define IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(_offset) (((_offset) / 5=
) % 4)
> > +#define IDT821034_GPIO_OFFSET_TO_SLIC_MASK(_offset)    BIT((_offset) %=
 5)
> > +
> > +static void idt821034_chip_gpio_set(struct gpio_chip *c, unsigned int =
offset, int val)
> > +{
> > +	u8 ch =3D IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
> > +	u8 mask =3D IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
> > +	struct idt821034 *idt821034 =3D gpiochip_get_data(c);
> > +	u8 slic_raw;
> > +	int ret;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	slic_raw =3D idt821034_get_written_slic_raw(idt821034, ch);
> > +	if (val)
> > +		slic_raw |=3D mask;
> > +	else
> > +		slic_raw &=3D ~mask;
> > +	ret =3D idt821034_write_slic_raw(idt821034, ch, slic_raw);
> > +	if (ret) {
> > +		dev_err(&idt821034->spi->dev, "set gpio %d (%u, 0x%x) failed (%d)\n",
> > +			offset, ch, mask, ret);
> > +	}
> > +
> > +	mutex_unlock(&idt821034->mutex);
> > +}
> > +
> > +static int idt821034_chip_gpio_get(struct gpio_chip *c, unsigned int o=
ffset)
> > +{
> > +	u8 ch =3D IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
> > +	u8 mask =3D IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
> > +	struct idt821034 *idt821034 =3D gpiochip_get_data(c);
> > +	u8 slic_raw;
> > +	int ret;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +	ret =3D idt821034_read_slic_raw(idt821034, ch, &slic_raw);
> > +	mutex_unlock(&idt821034->mutex);
> > +	if (ret) {
> > +		dev_err(&idt821034->spi->dev, "get gpio %d (%u, 0x%x) failed (%d)\n",
> > +			offset, ch, mask, ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * SLIC IOs are read in reverse order compared to write.
> > +	 * Reverse the read value here in order to have IO0 at lsb (ie same
> > +	 * order as write)
> > +	 */
> > +	return !!(bitrev8(slic_raw) & mask);
> > +}
> > +
> > +static int idt821034_chip_get_direction(struct gpio_chip *c, unsigned =
int offset)
> > +{
> > +	u8 ch =3D IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
> > +	u8 mask =3D IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
> > +	struct idt821034 *idt821034 =3D gpiochip_get_data(c);
> > +	u8 slic_dir;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +	slic_dir =3D idt821034_get_slic_conf(idt821034, ch);
> > +	mutex_unlock(&idt821034->mutex);
> > +
> > +	return slic_dir & mask ? GPIO_LINE_DIRECTION_IN : GPIO_LINE_DIRECTION=
_OUT;
> > +}
> > +
> > +static int idt821034_chip_direction_input(struct gpio_chip *c, unsigne=
d int offset)
> > +{
> > +	u8 ch =3D IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
> > +	u8 mask =3D IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
> > +	struct idt821034 *idt821034 =3D gpiochip_get_data(c);
> > +	u8 slic_conf;
> > +	int ret;
> > +
> > +	/* Only IO0 and IO1 can be set as input */
> > +	if (mask & ~(IDT821034_SLIC_IO1_IN | IDT821034_SLIC_IO0_IN))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	slic_conf =3D idt821034_get_slic_conf(idt821034, ch) | mask;
> > +
> > +	ret =3D idt821034_set_slic_conf(idt821034, ch, slic_conf);
> > +	if (ret) {
> > +		dev_err(&idt821034->spi->dev, "dir in gpio %d (%u, 0x%x) failed (%d)=
\n",
> > +			offset, ch, mask, ret);
> > +	}
> > +
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_chip_direction_output(struct gpio_chip *c, unsign=
ed int offset, int val)
> > +{
> > +	u8 ch =3D IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(offset);
> > +	u8 mask =3D IDT821034_GPIO_OFFSET_TO_SLIC_MASK(offset);
> > +	struct idt821034 *idt821034 =3D gpiochip_get_data(c);
> > +	u8 slic_conf;
> > +	int ret;
> > +
> > +	idt821034_chip_gpio_set(c, offset, val);
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	slic_conf =3D idt821034_get_slic_conf(idt821034, ch) & ~mask;
> > +
> > +	ret =3D idt821034_set_slic_conf(idt821034, ch, slic_conf);
> > +	if (ret) {
> > +		dev_err(&idt821034->spi->dev, "dir in gpio %d (%u, 0x%x) failed (%d)=
\n",
> > +			offset, ch, mask, ret);
> > +	}
> > +
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_reset_gpio(struct idt821034 *idt821034)
> > +{
> > +	int ret;
> > +	u8 i;
> > +
> > +	mutex_lock(&idt821034->mutex);
> > +
> > +	/* IO0 and IO1 as input for all channels and output IO set to 0 */
> > +	for (i =3D 0; i < IDT821034_NB_CHANNEL; i++) {
> > +		ret =3D idt821034_set_slic_conf(idt821034, i,
> > +					      IDT821034_SLIC_IO1_IN | IDT821034_SLIC_IO0_IN);
> > +		if (ret)
> > +			goto end;
> > +
> > +		ret =3D idt821034_write_slic_raw(idt821034, i, 0);
> > +		if (ret)
> > +			goto end;
> > +
> > +	}
> > +	ret =3D 0;
> > +end:
> > +	mutex_unlock(&idt821034->mutex);
> > +	return ret;
> > +}
> > +
> > +static int idt821034_gpio_init(struct idt821034 *idt821034)
> > +{
> > +	int ret;
> > +
> > +	ret =3D idt821034_reset_gpio(idt821034);
> > +	if (ret)
> > +		return ret;
> > +
> > +	idt821034->gpio_chip.owner =3D THIS_MODULE; =20
>=20
> Is the owner really needed ?

I think it is:
  https://elixir.bootlin.com/linux/latest/source/include/linux/gpio/driver.=
h#L319

and look at drivers/gpio/, a lot of drivers (all ?) set the owner value.

>=20
> > +	idt821034->gpio_chip.label =3D dev_name(&idt821034->spi->dev);
> > +	idt821034->gpio_chip.parent =3D &idt821034->spi->dev;
> > +	idt821034->gpio_chip.base =3D -1;
> > +	idt821034->gpio_chip.ngpio =3D 5 * 4; /* 5 GPIOs on 4 channels */
> > +	idt821034->gpio_chip.get_direction =3D idt821034_chip_get_direction;
> > +	idt821034->gpio_chip.direction_input =3D idt821034_chip_direction_inp=
ut;
> > +	idt821034->gpio_chip.direction_output =3D idt821034_chip_direction_ou=
tput;
> > +	idt821034->gpio_chip.get =3D idt821034_chip_gpio_get;
> > +	idt821034->gpio_chip.set =3D idt821034_chip_gpio_set;
> > +	idt821034->gpio_chip.can_sleep =3D true;
> > +
> > +	return devm_gpiochip_add_data(&idt821034->spi->dev, &idt821034->gpio_=
chip,
> > +				      idt821034);
> > +}
> > +#else /* IS_ENABLED(CONFIG_GPIOLIB) */
> > +static int idt821034_gpio_init(struct idt821034 *idt821034)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static int idt821034_spi_probe(struct spi_device *spi)
> > +{
> > +	struct idt821034 *idt821034;
> > +	int ret;
> > +
> > +	spi->bits_per_word =3D 8;
> > +	ret =3D spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	idt821034 =3D devm_kzalloc(&spi->dev, sizeof(*idt821034), GFP_KERNEL);
> > +	if (!idt821034)
> > +		return -ENOMEM;
> > +
> > +	idt821034->spi =3D spi;
> > +
> > +	mutex_init(&idt821034->mutex);
> > +
> > +	spi_set_drvdata(spi, idt821034);
> > +
> > +	ret =3D devm_snd_soc_register_component(&spi->dev, &idt821034_compone=
nt_driver,
> > +					      &idt821034_dai_driver, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D idt821034_gpio_init(idt821034);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id idt821034_of_match[] =3D {
> > +	{ .compatible =3D "renesas,idt821034", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, idt821034_of_match);
> > +
> > +static const struct spi_device_id idt821034_id_table[] =3D {
> > +	{ "idt821034", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, idt821034_id_table);
> > +
> > +static struct spi_driver idt821034_spi_driver =3D {
> > +	.driver  =3D {
> > +		.name   =3D "idt821034",
> > +		.of_match_table =3D idt821034_of_match,
> > +	},
> > +	.id_table =3D idt821034_id_table,
> > +	.probe  =3D idt821034_spi_probe,
> > +};
> > +
> > +module_spi_driver(idt821034_spi_driver);
> > +
> > +MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
> > +MODULE_DESCRIPTION("IDT821034 ALSA SoC driver");
> > +MODULE_LICENSE("GPL"); =20

Thanks for the review,

Herv=C3=A9
--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
