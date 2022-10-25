Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2B860D0BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiJYPfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiJYPfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:35:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22060C896D;
        Tue, 25 Oct 2022 08:35:44 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 49DEE40005;
        Tue, 25 Oct 2022 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666712142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gljpnoLdjIj8FbPBucJH+YyBjAPYhwcjGzRd/+2JJQw=;
        b=T/k+AbuL8LIp52QrJAzo2LJ42AWkOjjNgtqUWu+ZMYuYLjkK3uHkRY6euDkBQnKVI9swFN
        eOjXRCVBfx+yazWvnC1AOhcEucXdZPWFju49HXACZIR7D8mRxKNbKpg2QSWDYTFqQcN+sy
        Y9dbhiVyXdoXaKIevjkUq5tefS2e1VC/T0JcLSt121Yo+11tj33qPc+MJ9qoZXqHrqlxsh
        LaeJFQJii+k3kuHzbDgEGFsl7CBdrnzDqbo8UQiKjF+WDjbqNrpzUy/QaH5Q30BWBwLU+M
        7IIibejt4/ltjZ2XrdJXEMLVK0j6ygPsAAzFrlKNc44EqHWs2/T30qqRGGzQzA==
Date:   Tue, 25 Oct 2022 17:35:33 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, mripard@kernel.org,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Message-ID: <Y1gCRR8gMwy84WiT@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <13124586.uLZWGnKmhe@jernej-laptop>
 <Y1f/U8NxyJo/pMAH@aptenodytes>
 <8131177.T7Z3S40VBb@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0MKLJJwphdxhPi/7"
Content-Disposition: inline
In-Reply-To: <8131177.T7Z3S40VBb@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0MKLJJwphdxhPi/7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 25 Oct 22, 17:28, Jernej =C5=A0krabec wrote:
> Dne torek, 25. oktober 2022 ob 17:22:59 CEST je Paul Kocialkowski napisal=
(a):
> > Hi Jernej,
> >=20
> > On Tue 25 Oct 22, 17:17, Jernej =C5=A0krabec wrote:
> > > Dne torek, 25. oktober 2022 ob 08:30:28 CEST je Dan Carpenter napisal=
(a):
> > > > On Mon, Oct 24, 2022 at 10:15:08PM +0200, Jernej Skrabec wrote:
> > > > > There is several different Cedrus cores with varying capabilities=
, so
> > > > > some operations like listing formats depends on checks if feature=
 is
> > > > > supported or not.
> > > > >=20
> > > > > Currently check for capabilities is only in format enumeration he=
lper,
> > > > > but it will be used also elsewhere later. Let's convert this chec=
k to
> > > > > helper and while at it, also simplify it. There is no need to che=
ck if
> > > > > capability mask is zero, condition will still work properly.
> > > >=20
> > > > Sure.  That's true.  Out of curiousity, can
> > > > cedrus_formats[i].capabilities
> > > > be zero?  Because it feels like that's what should be checked.
> > >=20
> > > Yes, it can be. It's the case for V4L2_PIX_FMT_NV12_32L32. All varian=
ts
> > > supports it, so there is no special capability needed in order to be
> > > listed. What would you check in such case? Condition still works for =
this
> > > case.
> > I think the problem is that (bits & 0) =3D=3D 0 is always true.
> > So if the input caps are 0, we need to make sure to return false.
>=20
> No. If format (or any other) capabilities are 0, means they are supported=
 by=20
> all variants and it's expected from cedrus_is_capable() to return true.

Mhh, yeah. Not sure what I was thinking. Sorry for the noise.

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--0MKLJJwphdxhPi/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNYAkUACgkQ3cLmz3+f
v9ExOgf+JjLX4UvV2q9WgfaedsDfvk8XQ59souVqoWl11kJGfLC74ip19V7R5ttI
wo4Vl3QiaxHTpEYnd+v2TEMNDQwJtDsiGk5q3WseMkq+43RNU2CVO7+CUHSZOx6P
YYoAxWRCHLdXReHCGlfLsTc2UrarJpwXrHZmb/90czDBLoLJ2vmlmKPUbGq1lLyx
EfYgbipaDMydKh5EVaQ8/1cGzDhZ37eUiISHtz/0yppi87pkLPK27AHMKtwSlThU
GSqVolVkhfnSqDZGFoMsjQ+SiWA+4ff1WSOZeJcEfr0mNoFi0rh0ZWz0mkpZoRfd
XzMOHG4IkTS/kHaQ9Th2p3x+9ANCXw==
=8Pgc
-----END PGP SIGNATURE-----

--0MKLJJwphdxhPi/7--
