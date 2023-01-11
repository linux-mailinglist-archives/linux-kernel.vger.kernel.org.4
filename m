Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467CA6660D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAKQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjAKQlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:41:36 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529A41C93C;
        Wed, 11 Jan 2023 08:40:26 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 42BD2C000D;
        Wed, 11 Jan 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673455225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oGdtiEMVVLmjdlMhzVMr6gYLdJzA+jzOtls9FW8855g=;
        b=bmCljGHAKJnjYOgao3zIAnf1JX2bGWcKm8KDBBfKhvUuexUL+GP4D1cLbWCfWqKv7wnoJY
        5APlF6VCuTJUCGVpR7tGH+2eGPGyq4eu9mJ9o5PTDo0YWGA7JajFJ1VOFU+ihFzcX6emdM
        grTDbC3NW45Hoymvdigaao6b2rgM03skXrgY97dmZRics5n+NnJFlQmiux0UTDIVLoOiZC
        aMvQVWGI280RbKkqUXTq2n2G8toi3MOMZKpGFloB5PtqtC+Y4kOVYbHubyedANb0F7Acc1
        xfiucowxIj7OEwgj67voWbr2h+TKolLLxpHYdnl/M6eibt7nLpHOPH05Y3oaeg==
Date:   Wed, 11 Jan 2023 17:40:22 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas IDT821034
 codec
Message-ID: <20230111174022.077f6a8c@bootlin.com>
In-Reply-To: <Y77DKSdZf27qE+xl@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
        <20230111134905.248305-3-herve.codina@bootlin.com>
        <Y77DKSdZf27qE+xl@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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

Hi Mark,

On Wed, 11 Jan 2023 14:09:45 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jan 11, 2023 at 02:49:04PM +0100, Herve Codina wrote:
>=20
> > +++ b/sound/soc/codecs/idt821034.c
> > @@ -0,0 +1,1234 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IDT821034 ALSA SoC driver =20
>=20
> Please make the entire comment a C++ one so things look more
> intentional.

Ok, I will change in v2.

>=20
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
> > +	ret =3D spi_sync_transfer(idt821034->spi, xfer, 2); =20
>=20
> Why is this open coding register I/O rather than using regmap?
>=20
> > +	conf =3D 0x80 | idt821034->cache.codec_conf | IDT821034_CONF_CHANNEL(=
ch); =20
>=20
> regmap provides cache support too.
>=20
> > +static int idt821034_reg_write_gain(struct idt821034 *idt821034,
> > +				    unsigned int reg, unsigned int val)
> > +{
> > +	u16 gain_val;
> > +	u8 gain_type;
> > +	u8 ch;
> > +
> > +	ch =3D IDT821034_REGMAP_ADDR_GET_CH(reg);
> > +	gain_type =3D IDT821034_REGMAP_ADDR_IS_DIR_OUT(reg) ?
> > +			IDT821034_GAIN_RX : IDT821034_GAIN_TX;
> > +	gain_val =3D (val & 0x01) ? 0 : val >> 1;
> > +
> > +	return idt821034_set_gain_channel(idt821034, ch, gain_type, gain_val);
> > +} =20
>=20
> So if the low bit of the gain is zero we just discard the value?  This
> really needs some comments...
>=20
> > +static int idt821034_reg_write(void *context, unsigned int reg, unsign=
ed int val)
> > +{
> > +	struct idt821034 *idt821034 =3D context;
> > +
> > +	dev_dbg(&idt821034->spi->dev, "reg_write(0x%x, 0x%x)\n", reg, val);
> > +
> > +	switch (IDT821034_REGMAP_ADDR_GET_TYPE(reg)) {
> > +	case IDT821034_REGMAP_ADDR_TYPE_GBLCONF:
> > +		return idt821034_reg_write_gblconf(idt821034, reg, val);
> > + =20
>=20
> Oh, so there is some regmap stuff but it's not actually a regmap and is
> instead some virtual thing which rewrites all the values with no
> comments or anything explaining what's going on....  this all feels very
> confused.  I would expect the regmap usage to be such that the regmap
> represents the physical device, any rewriting of the values or anything
> like that should be done on top of the regmap rather than underneath it.
>=20
> Without knowing why things are written in this way or what it's trying
> to accomplish it's hard to comment in detail on what specifically should
> be done.

Yes, I use regmap to ease the integration of controls and use the
already defined controls macros but the device registers do not fit
well with regmap.

The device registers are not defined as simple as address/value pairs.
Accesses contains one or more bytes and the signification of the
data (and bytes) depends on the first bits.
- 0b10xxxxxx means 'Control register' with some data as xxxxxx
  and one extra byte
- 0b1101yyyy means 'Configuration register, slic mode' with
  some other data as yyyy and one extra byte
- 0b1100zzzz means 'Configuration register, gain mode' with
  some other data as zzzz and two extra bytes

The datasheet is available at
  https://www.renesas.com/us/en/document/dst/821034-data-sheet

This does not fit well for a regmap usage.

So I wrote some low-level access functions to handle this
protocol and use some kind of "virtual registers" to map
this protocol to regmap and use them in controls.

The "virtual registers" were defined to match what I need.

For instance, idt821034_reg_write_gain() is the regmap
write access for one of the gain "virtual register".
The mapping of this virtual register is:
   |15          1|0|
   | Gain value  |M|
With M for Mute flag.

The gain value is not discarded as it is available in the
regmap cache.
For the low-level access, I write the 'Gain Value' or 0 if
the mute flag was set.

In some low level accesses, I need save some data (cache) in
order to be able to use them later for an other access.
For instance when a channel is powered-on, a timeslot
need to be present in the bytes sent.

Of course, I can describe all of these in details.
Where do you want to have this information ? All at the top
of the file ? Each part (low-level, virtual regs, ...) at
the beginning of each part in the code ?

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
