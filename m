Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1518F64D18F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLNVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLNVB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:01:27 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54B2C112
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:01:25 -0800 (PST)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1BA7A8431A;
        Wed, 14 Dec 2022 22:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671051683;
        bh=m6GNF+3ObBWAmoieUyN/Lj65l4LYg0I8NRGLYo7td2Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIm0wu5lndMwQlXEcx8yTACG+iEOsKweJ4tjgQbzb98sbCRS6nsF4UqnPFT5+nDGM
         MrRMXelKOOHw5KxHd4Loel9OlYCQ8VIFkvOgiiwc4LuWfbYrfcxS1Y+pbgxQKEDMYf
         rIilIk2X1N+hrm8ASUalMQ0e7PuQSJ7Y0OX15IKgClePg/e+PEDmoD/4KRi0EOimKQ
         UIQtexFP6/IuqbausAf+SQLVaP0OoUYuJtmdbbRvs1RnTmVCWj+XLu1ZvjA7aYik1Q
         wp92+6Hyyh+qSIGGYvfBF0+WWcmwOSnKbzWaT4z1J3Cfm24yy7ue4asuUKlVCUf+km
         XmTUv1YvRSrnA==
Date:   Wed, 14 Dec 2022 22:01:22 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <20221214220122.093f0690@wsk>
In-Reply-To: <20221214133136.GQ105268@ediswmail.ad.cirrus.com>
References: <20221214123743.3713843-1-lukma@denx.de>
        <20221214123743.3713843-3-lukma@denx.de>
        <20221214133136.GQ105268@ediswmail.ad.cirrus.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sJOxWopwBZ1a4iXGwH5qw3i";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sJOxWopwBZ1a4iXGwH5qw3i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Charles,

> On Wed, Dec 14, 2022 at 01:37:41PM +0100, Lukasz Majewski wrote:
> > Without this change, the wm8940 driver is not working when
> > set_sysclk callback (wm8940_set_dai_sysclk) is called with
> > frequency not listed in the switch clause.
> >=20
> > This change adjusts this driver to allow non-standard frequency
> > set (just after the boot) being adjusted afterwards by the sound
> > system core code.
> >=20
> > Moreover, support for internal wm8940's PLL is provided, so it
> > can generate clocks when HOST system is not able to do it.
> >=20
> > Code in this commit is based on previous change done for wm8974
> > (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  	struct snd_soc_component *component =3D dai->component;
> > +	struct wm8940_priv *priv =3D
> > snd_soc_component_get_drvdata(component); u16 iface =3D
> > snd_soc_component_read(component, WM8940_IFACE) & 0xFD9F; u16
> > addcntrl =3D snd_soc_component_read(component, WM8940_ADDCNTRL) &
> > 0xFFF1; u16 companding =3D  snd_soc_component_read(component,
> > WM8940_COMPANDINGCTL) & 0xFFDF; int ret;
> > =20
> > +	priv->fs =3D params_rate(params);
> > +	ret =3D wm8940_update_clocks(dai);
> > +	if (ret)
> > +		return ret;
> > + =20
>=20
> I think this all looks mostly good, my only slight concern would
> be the interaction with the manual functions for settings the PLL
> etc. I guess under this code, whatever manual settings were
> configured

At least on my system - those settings are not set manually. Everythig
is done in the kernel.

This is important, as I do may use several other wm89* codecs, which
drivers are inserted as modules.

> will be overwritten with the new auto settings, I
> think this should be fine as the PLL wants to be run in a pretty
> narrow band anyway, so the settings are likely identical. Do you
> have any thoughts?

This code just follows changes done for WM8974 codec. I would leave the
code as it is in this patch.

>=20
> Thanks,
> Charles



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/sJOxWopwBZ1a4iXGwH5qw3i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmOaOaIACgkQAR8vZIA0
zr0ppwgAq4USumwfUNbFwEE0l2zmXkhpIZd61zZS35gKrBug7RBtZflc8XM20V1T
MRGUW3Q+mns65/tcB+Rl9q6xBhnAK231y9Sn51bxvAJ1l1aqF31zb+4h7RZR46Eu
T2kL8835j400dSZifoSwSCoJdfP84aYd96FlPts99XXVW9ETJSRWJnseoqPFVzQu
E09bFwsB06L9Ugnk1hH38qnl+sbKOtGhtqwIuqB8SFG3eEdLmli7rzqBkNPwn7QD
8JKOfLZgWKZrG24nR42e09O31Q1Q7act4JEYvEhEzsmLwKOLIEqFvztFc9mpyTx5
D9FOqfgNCIxk+284pDoHsFeWbq16mw==
=E278
-----END PGP SIGNATURE-----

--Sig_/sJOxWopwBZ1a4iXGwH5qw3i--
