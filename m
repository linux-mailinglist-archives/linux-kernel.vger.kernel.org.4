Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A822A64D199
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLNVKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:10:40 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D51DB861
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:10:38 -0800 (PST)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DE2638431A;
        Wed, 14 Dec 2022 22:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1671052237;
        bh=7dtoXhtnaVnh5Z6efBy24a1ZLt8Pv0Iv7af81Gd4QuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uBILq3XzKI4YnEVM8OoAWrXo5syr0ROMYUdDCd9dCvnuM6DsvgLZYJAEmSdkCBhv9
         wzHG97dppQHK1UFEH+uX22ntqB0VfeT9EJPPj9V+mVJgqnh4rReITpeFumBBpyVElo
         jT1MHTi6iasa7hWGmvURynWGXu9EyffDyYKr5uMAolMv05joXuXu+YO1Ya32277WDR
         WjEWW0J0OjGbZWId+xEVlEDbxbmcvOCNcTS5Y6w0LX8Kzq7PbSUbwklNaxMrkxUuUz
         yGRHtuPfJO8SXfofEUCrtT9l0jiL0vR8q5dOJVBkmBEG2oXvmaKbcy4AeOxBAGD773
         qvivIUN3qDMbg==
Date:   Wed, 14 Dec 2022 22:10:35 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Stephen Kitt <steve@sk2.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: wm8940: Rewrite code to set proper clocks
Message-ID: <20221214221035.25347427@wsk>
In-Reply-To: <Y5nWEPTDenOIrXFY@sirena.org.uk>
References: <20221214123743.3713843-1-lukma@denx.de>
        <20221214123743.3713843-3-lukma@denx.de>
        <Y5nWEPTDenOIrXFY@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QNpDM0lSQp3YUsIs1hh5dY5";
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

--Sig_/QNpDM0lSQp3YUsIs1hh5dY5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Wed, Dec 14, 2022 at 01:37:41PM +0100, Lukasz Majewski wrote:
>=20
> > Without this change, the wm8940 driver is not working when
> > set_sysclk callback (wm8940_set_dai_sysclk) is called with
> > frequency not listed in the switch clause. =20
>=20
> Your commit log doesn't actually describe what this change is...
>=20
> > This change adjusts this driver to allow non-standard frequency
> > set (just after the boot) being adjusted afterwards by the sound
> > system core code. =20
>=20
> This doesn't appear to correspond to the commit.  The change will
> result in the driver automatically configuring it's PLL.
>=20

Yes, indeed - I will update the description.

The problem with the old code was that after boot up - the frequency
was not in the 'switch' values, so the driver aborted in early init.

> > Code in this commit is based on previous change done for wm8974
> > (SHA1: 51b2bb3f2568e6d9d81a001d38b8d70c2ba4af99). =20
>=20
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet
> access. I do frequently catch up on my mail on flights or while
> otherwise travelling so this is even more pressing for me than just
> being about making things a bit easier to read.

Ok. I will provide proper description.

>=20
> > @@ -496,7 +505,6 @@ static int wm8940_set_bias_level(struct
> > snd_soc_component *component, return ret;
> >  			}
> >  		}
> > -
> >  		/* ensure bufioen and biasen */
> >  		pwr_reg |=3D (1 << 2) | (1 << 3);
> >  		/* set vmid to 300k for standby */ =20
>=20
> Unrelated (and questionable) whitespace change.

Ok. I will remove it.

Thanks for the review.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/QNpDM0lSQp3YUsIs1hh5dY5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmOaO8wACgkQAR8vZIA0
zr2Utwf+K6mHim7wUuBqEsORod1LhFNJ6FO47rpdO1WayfqWjVQJ28/0CbQ6ZpmZ
CuDzOvjP/T6+tfAVmIkrbqMI6JSpWZznbbWjO38SlymTriKKTh5sBWDIspRZ+mnN
WCUo+okBaeUgJqVCARMse+i8WpJWLAtMFaID6oV01cqcKPaw61yhECpw1U4v1sa5
uwZyr3SOVrZ40gK7xZIeVQzuQZ52GVPBr/VvweSwiOsgbKvjYECQ1TmZQYtWM3QE
FJAKbd8v5Ad/CPkH34KohoxCzQyl0B7GS+ImCr05LS9iDi78iwfVbA8XX0dB5LX8
pazkoNn8U1O3hhfKdxk4HK8NTYHbRA==
=kxtP
-----END PGP SIGNATURE-----

--Sig_/QNpDM0lSQp3YUsIs1hh5dY5--
