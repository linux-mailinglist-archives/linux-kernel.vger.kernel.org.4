Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8405873217C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjFOVTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjFOVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:19:31 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E505D2960;
        Thu, 15 Jun 2023 14:19:28 -0700 (PDT)
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
X-GND-Sasl: cyril@debamax.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 653F160009;
        Thu, 15 Jun 2023 21:19:25 +0000 (UTC)
Date:   Thu, 15 Jun 2023 23:19:24 +0200
From:   Cyril Brulebois <cyril@debamax.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fbdev/offb: Update expected device name
Message-ID: <20230615211924.cf2qs52cfaf7m3f7@debamax.com>
Organization: DEBAMAX
References: <20230412095509.2196162-1-cyril@debamax.com>
 <20230412095509.2196162-2-cyril@debamax.com>
 <ZDvrY7X9mpJ7WZ3z@eldamar.lan>
 <11b342dc-1a46-d1be-5fdd-c6eee661e15a@leemhuis.info>
 <fe3b90b0-b52f-9677-0245-a201975c3e0c@suse.de>
 <20230615132107.GA9196@kitsune.suse.cz>
 <20230615200901.GA1572644-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpftdcurb5ffwnvh"
Content-Disposition: inline
In-Reply-To: <20230615200901.GA1572644-robh@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zpftdcurb5ffwnvh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Rob Herring <robh@kernel.org> (2023-06-15):
> On Thu, Jun 15, 2023 at 03:21:07PM +0200, Michal Such=C3=A1nek wrote:
> > At the time this was proposed it was said that "of-display", is wrong,
> > and that "of-display.0" must be used for the first device instead, and
> > if something breaks an alias can be provided.
> >=20
> > So how does one provide an alias so that offb can find "of-display.0"
> > as "of-display"?
>=20
> I'm not aware of any way. There isn't because device names and paths are=
=20
> not considered ABI. There are mechanisms for getting stable class device=
=20
> indices (e.g. i2c0, mmcblk0, fb0, fb1, etc.) though not implemented for=
=20
> fbN (and please don't add it).=20
>=20
> In any case, this should be an easy fix. Though if "linux,opened" or=20
> "linux,boot-display" is not set, then you'd still get "of-display.0":
>=20
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 78ae84187449..e46482cef9c7 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -553,7 +553,7 @@ static int __init of_platform_default_populate_init(v=
oid)
>                         if (!of_get_property(node, "linux,opened", NULL) =
||
>                             !of_get_property(node, "linux,boot-display", =
NULL))
>                                 continue;
> -                       dev =3D of_platform_device_create(node, "of-displ=
ay.0", NULL);
> +                       dev =3D of_platform_device_create(node, "of-displ=
ay", NULL);
>                         of_node_put(node);
>                         if (WARN_ON(!dev))
>                                 return -ENOMEM;

I've just replaced my clueless workaround with this patch on top of the
kernel found in Debian 12 (Bookworm), i.e. 6.1.27 at this point, and it
indeed fixes the black screen problem in the installer's context.

I didn't run a full installation to check whether this kernel is also fine
after rebooting into the installed system, but as far as I understood for
the original bug report[1], it wasn't affected in the first place.

 1. https://bugs.debian.org/1033058

Will somebody else pick up the torch from here, and submit that for
inclusion in master? Or should I re-submit the above patch on my own?

I see my Debian colleagues have already pushed an updated v6.4-rc6 in
experimental, so it should be rather easy to combine checking latest
master with the distribution's packaging. Once that's done, I'm quite
familiar with building an updated installer image on top of it=E2=80=A6


Thanks,
--=20
Cyril Brulebois -- Debian Consultant @ DEBAMAX -- https://debamax.com/

--zpftdcurb5ffwnvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEHoutkuoaze1Qayc7lZpsmSeGm2EFAmSLgE4ACgkQlZpsmSeG
m2HGdxAAjx/OIUvMJXqRQbNU18DH4aIs8GtXVP74rC39FpYhMiT25ZtEpk2fwGaL
VaCspAGK1CqN5usg4hD1x8mN7zhROE6gd9fwd5a+wxhDsCWyF3BdpwKrlVpGTjFz
3hCukzRW42ERph5rC93ffpP8xCmwHBMOl8wEXhhHcMoC92LIQt2W8YxK5dK6CdHD
pVNDjluHpsRoOKg8ljJG2PpqSyrYv1gVyNrA2fdmR7cfgxCdHdwqyG0YqXKP5gBM
V642y/YhM1Ds0LuCVtvZi6eU+lqXhEQIr/PFN+2gfvS6q768utWAuvPHHONuF+gU
bzee336Skny9W6B2mUngreLm/JwXBuroaSDEcH1r0fKCOztSs7ii21psBfDp+6ji
fhZfLja0Dm3JMmKrL0T6cF/a5q+ZbStutmiZZu9nQ31xHTs6jky89ZDbN5kWIoXT
ahYfEwy4br3uLu0ddrWSnBsEzZFCBsZjaMuWOnAP1iIADEkxyGeG1HyAmG2Bm6u/
CjpoyKfzt/lSL0wdbJEhhJv5r/sGndmznMfcflveIlAtoqwGef13O2phfanXdS9u
4PkBkzt3IdBKM7rocmH+eo8SNBmaVnjq5tfRgiLfp4HKvv4QRzBPSippVn53CjKX
NlH9CNA9MVJL3YZzJ+f9W1JHG/hz1zugKsKJQMCJXpz7VJ6Y6cI=
=6dGw
-----END PGP SIGNATURE-----

--zpftdcurb5ffwnvh--
