Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C264D811
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiLOIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLOIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:53:52 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED2B47324
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:53:21 -0800 (PST)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2C5F685100;
        Thu, 15 Dec 2022 09:53:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671094399;
        bh=Ey/0RUtMy0IpFfjT6q16I8y7Eg0ha1S8rZ8Cj9Z/uRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H1Iessr4E9jL24o3PaKl0B7z51m3ASO+mxyVXfU3+ApXbI+qvmAaXtFIJKbKV9gvw
         4fR2amBZCy3COByFNxtJ73gjC77TR5h0xvr5EbcfCoqxYDKaZEySS9XzuLQR9TNc2Q
         XJ4WETWuD3OgqvEgTx6koJjnd2gMAv+Ut4pvk6qMrSw2rMemprHclJMirlztNiyXSA
         KiB/yDpC5tltyg20m5iLD3AR/soaT5alnxuNrxh3nZxrPWieod0gUZyF9/QAGyusfo
         icqmjskR9ij+TaRiDAEkdHkO/rz81weSlk2JX/1ImRnoDlJBICq+r7e10p1Vz4Code
         2BFsT9iweKR1g==
Date:   Thu, 15 Dec 2022 09:53:12 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ASoC: wm8940: Mute also the speaker output
Message-ID: <20221215095312.1c0a66f4@wsk>
In-Reply-To: <20221214215546.657a04f3@wsk>
References: <20221214123743.3713843-1-lukma@denx.de>
        <20221214123743.3713843-4-lukma@denx.de>
        <Y5nbf72ksywcXK65@sirena.org.uk>
        <20221214215546.657a04f3@wsk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HwU78dK35ywi0XzN57_5B75";
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

--Sig_/HwU78dK35ywi0XzN57_5B75
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> Hi Mark,
>=20
> > On Wed, Dec 14, 2022 at 01:37:42PM +0100, Lukasz Majewski wrote: =20
> > > Without this change the BTL speaker produces some
> > > "distortion" noise when test program
> > > (speaker-test -t waw) is ended with ctrl+c.   =20
> >  =20
> > > As our design uses speaker outputs to drive BTL speaker,
> > > it was necessary to also mute the speaker via the codec
> > > internal WM8940_SPKVOL register with setting
> > > WM8940_SPKMUTE bit.   =20
> >  =20
> > > @@ -465,9 +465,18 @@ static int wm8940_mute(struct snd_soc_dai
> > > *dai, int mute, int direction) {   =20
> >  =20
> > > +	spkvol_reg &=3D ~WM8940_SPKMUTE;
> > > +	if (mute) {
> > >  		mute_reg |=3D 0x40;
> > > +		spkvol_reg |=3D WM8940_SPKMUTE;
> > > +	}
> > > +
> > > +	ret =3D snd_soc_component_write(component, WM8940_SPKVOL,
> > > spkvol_reg);
> > > +	if (ret)
> > > +		return ret;
> > > =20
> > >  	return snd_soc_component_write(component, WM8940_DAC,
> > > mute_reg);   =20
> >=20
> > In addition to the issue Charles raised this is simply not what the
> > mute callback should do, the mute callback should specifically mute
> > the digital input (with the goal of masking any glitching on there
> > while clocks are started/stopped).  =20
>=20
> Ok
>=20
> > Looking at the driver the device
> > supports analogue bypass paths to the speaker - these will be broken
> > by your patch =20
>=20
> I was not aware about this side effect. I just wanted to be sure that
> the speaker is muted.
>=20
> > so if you genuinely need some workaround in this area
> > I'd be looking at the Speaker Mixer PCM Playback Switch rather than
> > muting the speaker as a whole. =20
>=20
> I would be more than happy if I could use for example the 'amixer'
> command to setup the audio correctly without this patch.=20
>=20
> For example - on this system - before I run any speaker test I need to
> call: amixer -d set 'Speaker Mixer PCM',0 on
>=20
> to unmute the system.
>=20

This patch steamed from 4.4 Linux. On the newer Linux version the
"distortion" problem is not present anymore.

I will drop this patch.

> >  If the device just can't cope without
> > an input then ignore_mdown_time might be what you're looking for, it
> > looks like the device doesn't have any lengthy sleeps in the power
> > up/down paths so that should be fine so long as it doesn't
> > pop/click.=20
>=20
> Ok. I will check this as well.
>=20
> > I'd also check there's not some other system configuration issue
> > here which is more obvious when the input from the DAC stops
> > getting input, check that you don't see similar issues when silence
> > is played for example.  It might be worth checking that none of the
> > analogue bypass paths are enabled. =20
>=20
> Thanks for your hints. I will investigate it further.
>=20
> It looks like this patch is some kind of a hack, to fix my system
> configuration and shall be dropped in v2.
>=20
>=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> --
>=20
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> lukma@denx.de




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/HwU78dK35ywi0XzN57_5B75
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmOa4HgACgkQAR8vZIA0
zr3/8wf/SSX2XaA6y4s6fwzei84BqeyivUN5rkTxnmHx9BoJyvnZu/MDX/ADL/O7
l9wLpPGquyqP8apcikASmcDrrSwkSWGm/Xmb2PVkdgA/Fwlj0Hs1jTuOEn/1RsHC
23GIDuibKlUv0Dc4U8WgzP2oxrvbLm2WFVpPvVoyq8O8XNleGMbpdKrcll3o70e4
Dl7cSQBfRe6N420fVUUaSvjGlRjcmc0vyuPAub6SsVmVAkCDjwSP3milq3vXDiip
CZDtLTbHorss2s6VPA3wla9+vdHGdz90BwwJabFGq4Hdx6dvcBuN8ozgig+NYhE+
QZzgtbsbjRaphdKhZbRaIowyEtO13g==
=Gc1U
-----END PGP SIGNATURE-----

--Sig_/HwU78dK35ywi0XzN57_5B75--
