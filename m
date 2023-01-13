Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D896366901B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbjAMIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjAMIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:07:45 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6137392FD;
        Fri, 13 Jan 2023 00:04:37 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12EE51C000B;
        Fri, 13 Jan 2023 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673597076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvxk6DPDlmeOz1Nn9izcenGUkdQHjs7DPmCAW7HiLUE=;
        b=Bu0gSlWMgpDnKyBJAhbLPzgDZLvaaTCma7cj46th38QxpH/47+drhybCAiePHomM0aTh83
        +PXDsWuxQ0Gze0oSdhbIo31xIIwfPwHPP5kCc5Eb0QcCvts6IrrEX6pBoZYt6mPF/snPmq
        b/DFsQClZhA1dHPWiT9Y+EoRd/xRmZ/MnZQOI5RFkcDPWvXhg88+HqTLhPB/+Twbf/b5xe
        ODYI5UOQVKp0rZnJ69vWJMU1zopXB+Olug2gjyfbsBe3POdUeDo+TzsYBLOc7qApp71wsr
        tGND6/XXAbxN3j8QDXt522WDLId2uUazy6oVdOyihsb9hfF4lAIOzbgsfCRwVw==
Date:   Fri, 13 Jan 2023 09:04:31 +0100
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
Message-ID: <20230113090431.7f84c93a@bootlin.com>
In-Reply-To: <Y774bY4icD8RuMnX@sirena.org.uk>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
        <20230111134905.248305-3-herve.codina@bootlin.com>
        <Y77DKSdZf27qE+xl@sirena.org.uk>
        <20230111174022.077f6a8c@bootlin.com>
        <Y774bY4icD8RuMnX@sirena.org.uk>
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

On Wed, 11 Jan 2023 17:57:01 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jan 11, 2023 at 05:40:22PM +0100, Herve Codina wrote:
> > Mark Brown <broonie@kernel.org> wrote: =20
> > > On Wed, Jan 11, 2023 at 02:49:04PM +0100, Herve Codina wrote: =20
>=20
> > > Without knowing why things are written in this way or what it's trying
> > > to accomplish it's hard to comment in detail on what specifically sho=
uld
> > > be done. =20
>=20
> > Yes, I use regmap to ease the integration of controls and use the
> > already defined controls macros but the device registers do not fit
> > well with regmap. =20
>=20
> If this doesn't fit into regmap then don't try to shoehorn it into
> regmap, that just makes it incredibly hard to follow what's going on.
>=20
> > The device registers are not defined as simple as address/value pairs.
> > Accesses contains one or more bytes and the signification of the
> > data (and bytes) depends on the first bits.
> > - 0b10xxxxxx means 'Control register' with some data as xxxxxx
> >   and one extra byte
> > - 0b1101yyyy means 'Configuration register, slic mode' with
> >   some other data as yyyy and one extra byte
> > - 0b1100zzzz means 'Configuration register, gain mode' with
> >   some other data as zzzz and two extra bytes =20
>=20
> So really the device only has three registers, each of different sizes
> and windowed fields within those registers?  I love innovation,
> innovation is great and it's good that our hardware design colleagues
> work so hard to keep us in jobs.  It seems hardly worth it to treat them
> as registers TBH.  This is so far off a register/value type thing that I
> just wouldn't even try.
>=20
> > Of course, I can describe all of these in details.
> > Where do you want to have this information ? All at the top
> > of the file ? Each part (low-level, virtual regs, ...) at
> > the beginning of each part in the code ? =20
>=20
> I'm not sure what problem it solves to use regmap or have virtual
> registers in the first place.  I think you would be better off with
> custom _EXT controls, you almost have that anway just hidden in the
> middle of the fake register stuff instead of directly there.  My sense
> is that the result would be much less code.  If you are trying to map
> things onto registers you probably want comments at every level since
> you don't know where people are going to end up jumping into the code.
>=20
> Perhaps it's possible to write some new SND_SOC_ helpers that work with
> just a value in the device's driver data rather than a regmap and have
> a callback to trigger a write to the device?  I suspect that'd be
> generally useful actually...

Well, I wil try to use my own .put() and .get() for snd_controls.

For DAPM (struct snd_soc_dapm_widget), no kind of .put() and .get()
are available. I will use some Ids for the 'reg' value and use the
.write() and .read() hooks available in struct snd_soc_component_driver
in order to handle these Ids and so perform the accesses.

Do you think this can be the right way (at least for a first try) ?

Best regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
