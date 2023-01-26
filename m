Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835667CB3F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAZMth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAZMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:49:34 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2126C12E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=C9BRS5jjDoOuJqnAKQEcu4c78RZU
        KZiobWtbz0yEU68=; b=M8dLHia6RxXnt/vg3FcbOXIF3YgkyjwGYOM7poVbY4wM
        MHf+X2nyOJSTvsz5bIJdGJi8p79tu2FKuD953qxB701u4ZrznVWHjvCDtOge1AgF
        OY8sAu7H/+R0F1y6/Cq0Ype5IbsIY3QgBYeYNheOoyQ/0b1SFhH3vhP6gqGzKLk=
Received: (qmail 3779498 invoked from network); 26 Jan 2023 13:48:32 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 26 Jan 2023 13:48:32 +0100
X-UD-Smtp-Session: l3s3148p1@sbWWKirzNrsujnvo
Date:   Thu, 26 Jan 2023 13:48:32 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y9J2oPHHNQoU+7m7@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdXY0c4qKCi057CtJdhUJ+443rtyCjwYyK3qGgwWTZ2a0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SBOQttDUaUptgdAG"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXY0c4qKCi057CtJdhUJ+443rtyCjwYyK3qGgwWTZ2a0A@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SBOQttDUaUptgdAG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > +static const struct soc_device_attribute rpcif_info_match[]  =3D {
> > +       { .soc_id =3D "r8a7795", .revision =3D "ES1.*", .data =3D &rpci=
f_info_r8a7795_es1 },
> > +       { .soc_id =3D "r8a7796", .revision =3D "ES1.*", .data =3D &rpci=
f_info_r8a7796_es1 },
>=20
> As we do have a separate compatible value for R-Car M3-W+ aka R-Car M3-W =
ES3.0
> ("renesas,r8a77961-rpc-if"), and there is no R-Car M3-W ES2.x (see the PRR
> screwup handling in renesas_soc_init()), you can just match against
> "renesas,r8a7796-rpc-if instead.

Right, I missed that! This is awesome news because with us dropping H3
ES1 support, this means we can drop all the soc_device_match() handling
now and use compatibles only. There, everybody happy :D

> > +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> > +                          /* create mask with all affected bits set */
> > +                          RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strti=
m)) - 1),
>=20
> fls(0) =3D 0, and BIT(-1) is undefined, so this won't work for R-Car
> H3 ES1.x.  So I'm afraid you cannot handle this without storing the
> actual mask ;-)

You misread the parens, it is: BIT(0) - 1 =3D 0

I actually wrote a program to print out the calculations to make sure I
got it right. But yeah, ES1 is obsolete now.

I'll send V3 later today.

Thanks everyone,

   Wolfram


--SBOQttDUaUptgdAG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPSdpwACgkQFA3kzBSg
KbY7IRAAiwQXZG3DVHFKWmGKEXMGRWtzC5nzyYs7xb/taY5bhK/VGaYKgOVSI39w
GvhkAyv38k1jbDgFcKgBh8OE/ygvHfm3XBk0/X7d3U1sCycQA/Qr715HNN0InEqb
OaAUy2j5l5KQgEXZZA3QpAvM30eDasi2FTEimMzhsF91zjoGZkw3SagBsU03gd9d
DIb8hFuinpgOqVrwbzaWDqtj+PbBGvfvz+nQuxtpNEtlF/0ETcuBq2yHoWVm2qZ9
0aSDGXRl06k+l7SyreqBTfZXnsXUfsiA5P7rYyZ2l4DPo5KVKnsadSCvLzFvVfm3
84cvz3cPRtGrAL1AbALy1LQ2A3HIYExRRhvDN4/jl8sBAUNqV6FlPs2vF/OzVk/4
6H5WC/TOq+Zc6Cr0FM2uC541hhKyPeOuJWhsxdIFHy9Ov/kJieaBz9P26UwQKwxI
4+0609PeBjY63OuvGjRVN8FjDUupmpYmga8HzKRgKdFsP+EVEhCtPGwA6tI4AEfx
Lrq4OVnD4zCfZBYdJTFvLxMtkLGeME+T4jRGMeWUwltncKm1dC7hvZ6WkRK7FArX
L+QAZKI5aDW+cPgzjRB9vhK5rb7kxRj+BJC3aGL0ZCtXt9wlzn7z/TNsVB6At3lH
BjDQ/3O3hKu4v0CbyclklAS+2y65+3qG3uQpr9Nlq87Dd3OPkoo=
=povj
-----END PGP SIGNATURE-----

--SBOQttDUaUptgdAG--
