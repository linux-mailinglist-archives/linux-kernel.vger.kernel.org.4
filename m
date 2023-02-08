Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841C168E8B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjBHHK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:10:55 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E216ACC;
        Tue,  7 Feb 2023 23:10:52 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3DEF8240005;
        Wed,  8 Feb 2023 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675840251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMJxOP//3lmrdw4Ez3gU5F4BL9UKnlN7VOGF3OJa748=;
        b=OMnfkutDt91abAJjp/6eauDG4dn+ggxo319G0cGWyRerN8lLWv11QT+Q2aXz0hYl18sfcr
        1nyuc2cnZez0LUK59e9ONCp7mG1JLW/oSfTh+nmn3GefZ7tf8GDA2pSi2dwnFSxNjVzN3m
        7xvfUg5TGFKW2/bauuCcMxiG4W4bw/i6PYUyQe7F4tWnZQM6CtT9yJ92d9Hr24dqzNgmVM
        duzmoNKG8VJJHzy2h8n2IkgRFNZpo30RPq0LCK6DCkCgKXheSLd3PaKT3CIkP28nfX7zYG
        yp5ZngE3YFdFDtbWkb0z+1aYLotqX8/B3KtQwIwovQ9yES4CESUYt0scjA+56Q==
Date:   Wed, 8 Feb 2023 08:10:48 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Infineon PEB2466
 codec
Message-ID: <20230208081048.0708037f@bootlin.com>
In-Reply-To: <fd3ccda3-f964-6904-6056-f93c43b85a0f@wanadoo.fr>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
        <20230206144904.91078-3-herve.codina@bootlin.com>
        <fd3ccda3-f964-6904-6056-f93c43b85a0f@wanadoo.fr>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2023 22:17:39 +0100
Hi Christophe,

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 06/02/2023 =C3=A0 15:49, Herve Codina a =C3=A9crit=C2=A0:
> > The Infineon PEB2466 codec is a programmable DSP-based four channels
> > codec with filters capabilities.
> > It also provides signals as GPIOs.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >   sound/soc/codecs/Kconfig   |   12 +
> >   sound/soc/codecs/Makefile  |    2 +
> >   sound/soc/codecs/peb2466.c | 2071 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 2085 insertions(+)
> >   create mode 100644 sound/soc/codecs/peb2466.c
> >  =20
>=20
> [...]
>=20
> > +static int peb2466_spi_probe(struct spi_device *spi)
> > +{
> > +	struct peb2466 *peb2466;
> > +	unsigned long mclk_rate;
> > +	int ret;
> > +	u8 xr5;
> > +
> > +	spi->bits_per_word =3D 8;
> > +	ret =3D spi_setup(spi);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	peb2466 =3D devm_kzalloc(&spi->dev, sizeof(*peb2466), GFP_KERNEL);
> > +	if (!peb2466)
> > +		return -ENOMEM;
> > +
> > +	peb2466->spi =3D spi;
> > +
> > +	peb2466->regmap =3D devm_regmap_init(&peb2466->spi->dev, NULL, peb246=
6,
> > +					   &peb2466_regmap_config);
> > +	if (IS_ERR(peb2466->regmap))
> > +		return PTR_ERR(peb2466->regmap);
> > +
> > +	peb2466->reset_gpio =3D devm_gpiod_get_optional(&peb2466->spi->dev,
> > +						      "reset", GPIOD_OUT_LOW);
> > +	if (IS_ERR(peb2466->reset_gpio))
> > +		return PTR_ERR(peb2466->reset_gpio);
> > +
> > +	peb2466->mclk =3D devm_clk_get(&peb2466->spi->dev, "mclk"); =20
>=20
> Hi,
>=20
> Up to you to decide if it is a good idea or not, but using=20
> devm_clk_get_enabled() would save the 'mclk' field in peb2466 ...
>=20
> > +	if (IS_ERR(peb2466->mclk))
> > +		return PTR_ERR(peb2466->mclk);
> > +	ret =3D clk_prepare_enable(peb2466->mclk);
> > +	if (ret)
> > +		return ret; =20
>=20
> ... these 3 lines ...
>=20
> > +
> > +	if (peb2466->reset_gpio) {
> > +		gpiod_set_value_cansleep(peb2466->reset_gpio, 1);
> > +		udelay(4);
> > +		gpiod_set_value_cansleep(peb2466->reset_gpio, 0);
> > +		udelay(4);
> > +	}
> > +
> > +	spi_set_drvdata(spi, peb2466); =20
>=20
> ... this spi_set_drvdata() call ...
>=20
> > +
> > +	mclk_rate =3D clk_get_rate(peb2466->mclk);
> > +	switch (mclk_rate) {
> > +	case 1536000:
> > +		xr5 =3D PEB2466_XR5_MCLK_1536;
> > +		break;
> > +	case 2048000:
> > +		xr5 =3D PEB2466_XR5_MCLK_2048;
> > +		break;
> > +	case 4096000:
> > +		xr5 =3D PEB2466_XR5_MCLK_4096;
> > +		break;
> > +	case 8192000:
> > +		xr5 =3D PEB2466_XR5_MCLK_8192;
> > +		break;
> > +	default:
> > +		dev_err(&peb2466->spi->dev, "Unsupported clock rate %lu\n",
> > +			mclk_rate);
> > +		ret =3D -EINVAL;
> > +		goto failed;
> > +	}
> > +	ret =3D regmap_write(peb2466->regmap, PEB2466_XR5, xr5);
> > +	if (ret) {
> > +		dev_err(&peb2466->spi->dev, "Setting MCLK failed (%d)\n", ret);
> > +		goto failed;
> > +	}
> > +
> > +	ret =3D devm_snd_soc_register_component(&spi->dev, &peb2466_component=
_driver,
> > +					      &peb2466_dai_driver, 1);
> > +	if (ret)
> > +		goto failed;
> > +
> > +	if (IS_ENABLED(CONFIG_GPIOLIB)) {
> > +		ret =3D peb2466_gpio_init(peb2466);
> > +		if (ret)
> > +			goto failed;
> > +	}
> > +
> > +	return 0;
> > +
> > +failed:
> > +	clk_disable_unprepare(peb2466->mclk);
> > +	return ret; =20
>=20
> ... this error handling path ...
>=20
> > +}
> > +
> > +static void peb2466_spi_remove(struct spi_device *spi)
> > +{
> > +	struct peb2466 *peb2466 =3D spi_get_drvdata(spi);
> > +
> > +	clk_disable_unprepare(peb2466->mclk);
> > +} =20
>=20
> ... and the remove function.
>=20
> CJ
>=20

Thanks for pointing this.
I will use devm_clk_get_enabled() in the next series iteration as suggested.

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
