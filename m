Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F594677C0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjAWM7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjAWM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:59:46 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5CB448E;
        Mon, 23 Jan 2023 04:59:43 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B97EE24000E;
        Mon, 23 Jan 2023 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674478782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=na7HRl0jra781/0Bx/fX+Bp8fWBwR3ej1zRQGenoYHY=;
        b=G8/vJ77o1xKjT2Zinoy5wk7M6XQTQgH5tPbUFgFhQxZNzL7xLHHP1mbuDIwNez0tAPniFS
        CkIIVMEIGJGJROyFIkBnHONfa4eyly0C0ACx9vrvaTutKt9DpG0ta8paxapZd4tNO8/h+m
        DOEFfOmPWB7whrHFQt5kvbdMK4h1RIsYmXCLLQnpmAdP+23fTC3Mphq+RwoB5oJBMqSOF7
        zkfmj1k+1kovZuzySlRFHsjF/HWOZbsL57hNjDy00pXfhKjLA6Vb4nM7ghRV6eM2YAeO7s
        VZaurQTn2NePS8ig0yR1Aoe8fyP+gag8TRaQncLCydFTQpOZ69tfYj7Eao+Akg==
Date:   Mon, 23 Jan 2023 13:59:38 +0100
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
Message-ID: <20230123135938.1855d6a8@bootlin.com>
In-Reply-To: <79b35117-98aa-dc7c-2a27-805cd4ac2c71@csgroup.eu>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
        <20230120095036.514639-3-herve.codina@bootlin.com>
        <d51b826b-e71f-393c-586b-6a1ca953f26f@csgroup.eu>
        <20230123095631.4aba35d6@bootlin.com>
        <eb20dc66-f564-ed7e-8873-65621e5970de@csgroup.eu>
        <20230123131755.1f5702be@bootlin.com>
        <79b35117-98aa-dc7c-2a27-805cd4ac2c71@csgroup.eu>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 12:30:32 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> Le 23/01/2023 =C3=A0 13:17, Herve Codina a =C3=A9crit=C2=A0:
> > Hi Christophe,
> >=20
> > On Mon, 23 Jan 2023 11:13:23 +0000
> > Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> >  =20
> >> Hi Herv=C3=A9,
> >>
> >> Le 23/01/2023 =C3=A0 09:56, Herve Codina a =C3=A9crit=C2=A0: =20
> >>>
> >>> gpiochip_get_data() is defined only when CONFIG_GPIOLIB is set.
> >>> That's why the #if section is used. =20
> >>
> >> gpiochip_get_data() is still declared when CONFIG_GPIOLIB is not set, =
so
> >> it is not a problem, the call to it will be eliminated at buildtime.
> >>
> >> By the way, at the time being I get the following warnings:
> >>
> >>     CC      sound/soc/codecs/idt821034.o
> >> sound/soc/codecs/idt821034.c:310:12: warning: 'idt821034_read_slic_raw'
> >> defined but not used [-Wunused-function]
> >>     310 | static int idt821034_read_slic_raw(struct idt821034 *idt8210=
34,
> >> u8 ch, u8 *slic_raw)
> >>         |            ^~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc/codecs/idt821034.c:305:11: warning:
> >> 'idt821034_get_written_slic_raw' defined but not used [-Wunused-functi=
on]
> >>     305 | static u8 idt821034_get_written_slic_raw(struct idt821034
> >> *idt821034, u8 ch)
> >>         |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc/codecs/idt821034.c:276:12: warning: 'idt821034_write_slic_ra=
w'
> >> defined but not used [-Wunused-function]
> >>     276 | static int idt821034_write_slic_raw(struct idt821034
> >> *idt821034, u8 ch, u8 slic_raw)
> >>         |            ^~~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc/codecs/idt821034.c:271:11: warning: 'idt821034_get_slic_conf'
> >> defined but not used [-Wunused-function]
> >>     271 | static u8 idt821034_get_slic_conf(struct idt821034 *idt82103=
4,
> >> u8 ch)
> >>         |           ^~~~~~~~~~~~~~~~~~~~~~~
> >> sound/soc/codecs/idt821034.c:250:12: warning: 'idt821034_set_slic_conf'
> >> defined but not used [-Wunused-function]
> >>     250 | static int idt821034_set_slic_conf(struct idt821034 *idt8210=
34,
> >> u8 ch, u8 slic_dir)
> >>         |            ^~~~~~~~~~~~~~~~~~~~~~~
> >>
> >>
> >> With the following changes I have no warning and an objdump -x on
> >> idt821034.o shows no reference to gpiochip_get_data()
> >>
> >> diff --git a/sound/soc/codecs/idt821034.c b/sound/soc/codecs/idt821034=
.c
> >> index 5eb93fec6042..8b75388e22ce 100644
> >> --- a/sound/soc/codecs/idt821034.c
> >> +++ b/sound/soc/codecs/idt821034.c
> >> @@ -968,7 +968,6 @@ static const struct snd_soc_component_driver
> >> idt821034_component_driver =3D {
> >>    	.endianness		=3D 1,
> >>    };
> >>
> >> -#if IS_ENABLED(CONFIG_GPIOLIB)
> >>    #define IDT821034_GPIO_OFFSET_TO_SLIC_CHANNEL(_offset) (((_offset) /
> >> 5) % 4)
> >>    #define IDT821034_GPIO_OFFSET_TO_SLIC_MASK(_offset)    BIT((_offset=
) % 5)
> >>
> >> @@ -1133,12 +1132,6 @@ static int idt821034_gpio_init(struct idt821034
> >> *idt821034)
> >>    	return devm_gpiochip_add_data(&idt821034->spi->dev,
> >> &idt821034->gpio_chip,
> >>    				      idt821034);
> >>    }
> >> -#else /* IS_ENABLED(CONFIG_GPIOLIB) */
> >> -static int idt821034_gpio_init(struct idt821034 *idt821034)
> >> -{
> >> -	return 0;
> >> -}
> >> -#endif
> >>
> >>    static int idt821034_spi_probe(struct spi_device *spi)
> >>    {
> >> @@ -1165,6 +1158,9 @@ static int idt821034_spi_probe(struct spi_device=
 *spi)
> >>    	if (ret)
> >>    		return ret;
> >>
> >> +	if (!IS_ENABLED(CONFIG_GPIOLIB))
> >> +		return 0;
> >> +
> >>    	ret =3D idt821034_gpio_init(idt821034);
> >>    	if (ret)
> >>    		return ret;
> >>
> >>
> >> Christophe =20
> >=20
> > Right, I did the test too and indeed, I can remove the #if section.
> >=20
> > I will use (I think is clearer) at idt821034_spi_probe():
> > 	if (!IS_ENABLED(CONFIG_GPIOLIB)) {
> >     		ret =3D idt821034_gpio_init(idt821034);
> > 		if (ret)
> >     			return ret;
> > 	}
> >  =20
>=20
>=20
> I guess you mean :
>=20
> 	if (IS_ENABLED(CONFIG_GPIOLIB))

Yes of course. Sorry for the typo.

>=20
>=20
> > Is that ok for you ? =20
>=20
>=20
>=20
> What about:
>=20
> 	if (IS_ENABLED(CONFIG_GPIOLIB))
> 		return idt821034_gpio_init(idt821034);
> 	else
> 		return 0;
>=20
> Christophe

Well, maybe this version ?

static int idt821034_spi_probe(struct spi_device *spi)
{
	...

	if (IS_ENABLED(CONFIG_GPIOLIB))
 		return idt821034_gpio_init(idt821034);

	return 0;
}

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
