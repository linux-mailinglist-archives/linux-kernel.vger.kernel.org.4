Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BC27276F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjFHF4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHF4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:56:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491C1984;
        Wed,  7 Jun 2023 22:56:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64d18d772bdso147031b3a.3;
        Wed, 07 Jun 2023 22:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686203776; x=1688795776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZwzO3o0E1olTOiJsENxuVcjT+nDeF5XeaCyL2M7a98=;
        b=a7SMFsYqI2rtfFNH1Fr9g7YlBQX1+mtpWlrE/eI391Pth/XnVfJfhGb8vwcyDG5uTg
         T5PX2JuX2MUEFzlC8Pu1qxz9ypqAPEX6HJx6cvHM50fop0mrglrWH5SO47E1zw5XaXBw
         6hcfvQVToTC0An/X19qGJyi/yu+L5vOZhKwU8ErmADvTley1j6SB3PpbS5GhXDY5z6BC
         W4GOlZYQUjFSWhqST3GjPxRRKLy+D27AnSRUv6TyEgS4a3yfss5evHw0mPXdUwGBdy6+
         UlMah5GiOpXc3dOlHhSlWX4vykDs8dpi1BH+eQtC2wLAzMWlObZFh72fuokmAeZKGZGK
         pDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686203776; x=1688795776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZwzO3o0E1olTOiJsENxuVcjT+nDeF5XeaCyL2M7a98=;
        b=KM5BSXhvo8PcLw/Rhgh6t9FMG/c4ICBByulvTg8lKiTIhjLVWiXrcYUbN3dHdpPj4B
         GM6akpNtG50cPTcMPAd2NS2l8HyAig13iYskVL8AWIhl0Ivsg8SFsyJ1GqV13Sux1BTb
         I00NvnCVIEMMIsH+c9CKn8ehU/plxF75mVYHSkZx8Z2IHCpTrLb1244mDIJADNqJoCqP
         BKjjU1GWZGyWR+dy+0v8VFewl45a6xpW7g8rV378RgpcSoU7/kQsvXUfoXueh7Wky7kE
         iyKG8btoyyOTShBc9AKqEKZD15hni8Nwpx/nmeQtZjkNVlM5qYGWYZM/VslrBBFblS53
         OMkw==
X-Gm-Message-State: AC+VfDyGoRiFGmoobsEI4TOPVrAgUOhJLV5VNOpLx8oAWuhd+hebbkML
        SrAu1oDIPdcSUSsrH5YatC0=
X-Google-Smtp-Source: ACHHUZ7gnr8owF3oPlHuDMQtmzRRgk19juqE+hi6ZsPd9ktJwCzZSYOp0D9+VPom979iEADZAsU5QA==
X-Received: by 2002:a05:6a00:3a26:b0:64c:4f2f:a235 with SMTP id fj38-20020a056a003a2600b0064c4f2fa235mr8768315pfb.30.1686203775918;
        Wed, 07 Jun 2023 22:56:15 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-10.three.co.id. [180.214.233.10])
        by smtp.gmail.com with ESMTPSA id i20-20020aa79094000000b0063d2d9990ecsm303466pfa.87.2023.06.07.22.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:56:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 90A081069EA; Thu,  8 Jun 2023 12:56:11 +0700 (WIB)
Date:   Thu, 8 Jun 2023 12:56:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Richard Fontana <rfontana@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Alexander Kjeldaas <astor@fast.no>,
        Herbert Valerio Riedel <hvr@hvrlab.org>,
        Kyle McMartin <kyle@debian.org>,
        "Adam J . Richter" <adam@yggdrasil.com>,
        Dr Brian Gladman <brg@gladman.me.uk>,
        Stephan Mueller <smueller@chronox.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/8] crypto: Convert dual BSD 3-Clause/GPL 2.0
 boilerplate to SPDX identifier
Message-ID: <ZIFte-Ik0PbwoYm-@debian.me>
References: <20230607053940.39078-10-bagasdotme@gmail.com>
 <20230607053940.39078-11-bagasdotme@gmail.com>
 <CAC1cPGxD6xOLksyMHCcreFyEv5Yoo50LY=xM9BmOEP=oECoNww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7112UkPf1cmvdMEW"
Content-Disposition: inline
In-Reply-To: <CAC1cPGxD6xOLksyMHCcreFyEv5Yoo50LY=xM9BmOEP=oECoNww@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7112UkPf1cmvdMEW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 10:10:34AM -0400, Richard Fontana wrote:
> On Wed, Jun 7, 2023 at 1:42=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > Replace license boilerplate for dual BSD-3-Clause/GPL 2.0 (only or
> > later) with corresponding SPDX license identifier.
>=20
> This is at least the fourth or fifth time (I'm losing track) where you
> have incorrectly assumed a particular non-GPL license text matches a
> particular SPDX identifier without (apparently) checking.
>=20
> Bagas, I urge that you learn more about the nature of SPDX identifiers
> before submitting any further patches at least involving replacement
> of non-GPL notices with SPDX identifiers. For this unprecedented
> license notice replacement initiative to have any legitimacy it must
> attempt to apply SPDX identifiers correctly.
>=20
> > diff --git a/crypto/aes_generic.c b/crypto/aes_generic.c
> > index 666474b81c6aa5..2e042bd306f9c5 100644
> > --- a/crypto/aes_generic.c
> > +++ b/crypto/aes_generic.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-or-later
> >  /*
> >   * Cryptographic API.
> >   *
> > @@ -11,39 +12,9 @@
> >   *  Kyle McMartin <kyle@debian.org>
> >   *  Adam J. Richter <adam@yggdrasil.com> (conversion to 2.5 API).
> >   *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License as published by
> > - * the Free Software Foundation; either version 2 of the License, or
> > - * (at your option) any later version.
> > - *
> >   * -------------------------------------------------------------------=
--------
> >   * Copyright (c) 2002, Dr Brian Gladman <brg@gladman.me.uk>, Worcester=
, UK.
> >   * All rights reserved.
> > - *
> > - * LICENSE TERMS
> > - *
> > - * The free distribution and use of this software in both source and b=
inary
> > - * form is allowed (with or without changes) provided that:
> > - *
> > - *   1. distributions of this source code include the above copyright
> > - *      notice, this list of conditions and the following disclaimer;
> > - *
> > - *   2. distributions in binary form include the above copyright
> > - *      notice, this list of conditions and the following disclaimer
> > - *      in the documentation and/or other associated materials;
> > - *
> > - *   3. the copyright holder's name is not used to endorse products
> > - *      built using this software without specific written permission.
> > - *

Hi Richard,

> > - * ALTERNATIVELY, provided that this notice is retained in full, this =
product
> > - * may be distributed under the terms of the GNU General Public Licens=
e (GPL),
> > - * in which case the provisions of the GPL apply INSTEAD OF those give=
n above.
> > - *
> > - * DISCLAIMER
> > - *
> > - * This software is provided 'as is' with no explicit or implied warra=
nties
> > - * in respect of its properties, including, but not limited to, correc=
tness
> > - * and/or fitness for purpose.
> >   * -------------------------------------------------------------------=
--------
>=20
> This is not BSD-3-Clause as defined by SPDX. It may be a match to
> `Brian-Gladman-3-Clause` but I haven't checked closely.
>=20
> > diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
> > index 407408c437308f..4d4b9e60f72c19 100644
> > --- a/crypto/algif_rng.c
> > +++ b/crypto/algif_rng.c
> > @@ -1,41 +1,10 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
> >  /*
> >   * algif_rng: User-space interface for random number generators
> >   *
> >   * This file provides the user-space API for random number generators.
> >   *
> >   * Copyright (C) 2014, Stephan Mueller <smueller@chronox.de>
> > - *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, and the entire permission notice in its entirety,
> > - *    including the disclaimer of warranties.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in =
the
> > - *    documentation and/or other materials provided with the distribut=
ion.
> > - * 3. The name of the author may not be used to endorse or promote
> > - *    products derived from this software without specific prior
> > - *    written permission.
> > - *
> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the=
 GPL2
> > - * are required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > - * DAMAGE.
> >   */
>=20
> The BSD portion of this license notice is not a match to BSD-3-Clause
> (see my comment on another patch which I think had the same license
> text).

At the time, I guessed that boilerplate wording have the same meaning as
the actual BSD 3-Clause license.

(And no wonder why this file missed previous SPDX batches).

tglx, I'm adding you to Cc:. Please have a look on this (and following
below) BSD wording variants.

>=20
>=20
>=20
>=20
> >  #include <linux/capability.h>
> > diff --git a/crypto/jitterentropy-kcapi.c b/crypto/jitterentropy-kcapi.c
> > index 7d1463a1562acb..78230ce74fc840 100644
> > --- a/crypto/jitterentropy-kcapi.c
> > +++ b/crypto/jitterentropy-kcapi.c
> > @@ -1,40 +1,10 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
> >  /*
> >   * Non-physical true random number generator based on timing jitter --
> >   * Linux Kernel Crypto API specific code
> >   *
> >   * Copyright Stephan Mueller <smueller@chronox.de>, 2015 - 2023
> >   *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, and the entire permission notice in its entirety,
> > - *    including the disclaimer of warranties.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in =
the
> > - *    documentation and/or other materials provided with the distribut=
ion.
> > - * 3. The name of the author may not be used to endorse or promote
> > - *    products derived from this software without specific prior
> > - *    written permission.
> > - *
> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the=
 GPL2 are
> > - * required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > - * DAMAGE.
>=20
> Also not a match to BSD-3-Clause.

See my below reply.

>=20
>=20
> >  #include <crypto/hash.h>
> > diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
> > index c7d7f2caa7793b..c8437bd20dc903 100644
> > --- a/crypto/jitterentropy.c
> > +++ b/crypto/jitterentropy.c
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
> >  /*
> >   * Non-physical true random number generator based on timing jitter --
> >   * Jitter RNG standalone code.
> > @@ -9,40 +10,6 @@
> >   *
> >   * See https://www.chronox.de/jent.html
> >   *
> > - * License
> > - * =3D=3D=3D=3D=3D=3D=3D
> > - *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, and the entire permission notice in its entirety,
> > - *    including the disclaimer of warranties.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in =
the
> > - *    documentation and/or other materials provided with the distribut=
ion.
> > - * 3. The name of the author may not be used to endorse or promote
> > - *    products derived from this software without specific prior
> > - *    written permission.
> > - *
> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the=
 GPL2 are
> > - * required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > - * DAMAGE.
>=20
> Also not a match to BSD-3-Clause.

The first clause also addes disclaimer perseverance as in the second;
and the third clause is worded differently (but same meaning).

>=20
>=20
> > diff --git a/crypto/keywrap.c b/crypto/keywrap.c
> > index 054d9a216fc9f3..8c51235a91a9ae 100644
> > --- a/crypto/keywrap.c
> > +++ b/crypto/keywrap.c
> > @@ -1,39 +1,9 @@
> > +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0-only
> >  /*
> >   * Key Wrapping: RFC3394 / NIST SP800-38F
> >   *
> >   * Copyright (C) 2015, Stephan Mueller <smueller@chronox.de>
> >   *
> > - * Redistribution and use in source and binary forms, with or without
> > - * modification, are permitted provided that the following conditions
> > - * are met:
> > - * 1. Redistributions of source code must retain the above copyright
> > - *    notice, and the entire permission notice in its entirety,
> > - *    including the disclaimer of warranties.
> > - * 2. Redistributions in binary form must reproduce the above copyright
> > - *    notice, this list of conditions and the following disclaimer in =
the
> > - *    documentation and/or other materials provided with the distribut=
ion.
> > - * 3. The name of the author may not be used to endorse or promote
> > - *    products derived from this software without specific prior
> > - *    written permission.
> > - *
> > - * ALTERNATIVELY, this product may be distributed under the terms of
> > - * the GNU General Public License, in which case the provisions of the=
 GPL2
> > - * are required INSTEAD OF the above restrictions.  (This clause is
> > - * necessary due to a potential bad interaction between the GPL and
> > - * the restrictions contained in a BSD-style copyright.)
> > - *
> > - * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > - * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > - * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > - * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > - * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > - * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > - * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > - * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > - * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > - * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > - * DAMAGE.
>=20
> Also not a match to BSD-3-Clause.

See my above reply.

Stephan (original author), was your intention to license these files
under BSD 3-Clause?

Thanks for reviewing.

--=20
An old man doll... just what I always wanted! - Clara

--7112UkPf1cmvdMEW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIFtewAKCRD2uYlJVVFO
o6aPAQC0TpMnZT/6CXlB/GpDwU4wmtEuBmGnhWKL5HYoKfcpdQEA6HK/+R0hHtqU
nmgZQxRBy/srfOQflXFPn1lUy8+yrwM=
=XYcN
-----END PGP SIGNATURE-----

--7112UkPf1cmvdMEW--
