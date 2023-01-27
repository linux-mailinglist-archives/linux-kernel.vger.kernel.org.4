Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296B167DF28
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjA0IbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjA0IbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:31:02 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F36E4C0F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=DnQWVqwKZ9VayygZqk6ntZ5i+4Mj
        b+GDBVbPSdLENNk=; b=mQtWFZLTaj0W7kKvT7SVZY0NxDcAc4ezpbgPJRVnXdJS
        987P0TO4BSKU8ZvBFdtwuYWIQRF3A+EeTGQyvFl6JtKY5h1OAbdGxuwEw2h2XsvN
        nlKgNxVdVOXrZLg9TuMDkflvtMUzi+tVloafz+IZjYUXRrfEtPWCUr6ReFWKQ5c=
Received: (qmail 4158469 invoked from network); 27 Jan 2023 09:30:52 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 27 Jan 2023 09:30:52 +0100
X-UD-Smtp-Session: l3s3148p1@DJeGrjrzur4ujnvo
Date:   Fri, 27 Jan 2023 09:30:45 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
Message-ID: <Y9OLtbN5uhyPYxyj@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Cong Dang <cong.dang.xn@renesas.com>,
        Hai Pham <hai.pham.ud@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230126173513.36659-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdX6epwBa9fT9MoU=oC9k6YV2L9NXOEd84QkLnSr2vkDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NfKNJifiYwgwGQjp"
Content-Disposition: inline
In-Reply-To: <CAMuHMdX6epwBa9fT9MoU=oC9k6YV2L9NXOEd84QkLnSr2vkDBA@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NfKNJifiYwgwGQjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -       rpc->type =3D (uintptr_t)of_device_get_match_data(dev);
> > +       rpc->size =3D resource_size(res);
>=20
> Nit: No need to move the initialization of rpc->size.

True. It is more cosmetic to have all rpc->* inits in one block. But I
think it is worth it.

> > +       regmap_update_bits(rpc->regmap, RPCIF_PHYCNT,
> > +                          /* create mask with all affected bits set */
> > +                          RPCIF_PHYCNT_STRTIM(BIT(fls(rpc->info->strti=
m)) - 1),
>=20
> Note that this relies on the strtim value being 4 or higher.
> As this value is not user-configurable, but fixed in the driver,
> it's probably OK.

If there was a chance that newer SoCs use such a value, I'd go for the
seperate mask. But I am confident this time has passed and the next
value is likely >15.


> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!


--NfKNJifiYwgwGQjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmPTi7EACgkQFA3kzBSg
KbaRJw//YW0YKRPlT/6a0FFg8SORd6sO441UTATLVZ0ympE/xONAi3MFvXRA5dcm
3wERZCptTfasVuep84BIzN6ZhLpaIAZACPKyUlxDil79WUBqaO77x6IrijyEf8EL
wV0+NLbC9h8MIkymj1LmeADCN4YqNn+ERXlNyv5SAUgXtDs3wwvQnDH35+Km8qDY
GMTgHG+vsTeL/XAuvMg33c3zVK7QfUH+oqGDtP3TyVD5FGITcwfSaeOe2HqAjf+1
JL8I9Od4VJ4ORk+6HhyGKOxQ/d4sWkHl6SpfB6wQ1ByvrAqCYvgmvU91hAMWeigR
EDtmVhu9EgpeBKGzty0CkLxlD2uIPDXh4atKqvB4JaaSEoOvnQF7WLHqNwKiq/aY
WWKljcoNnVZwZLrxp9+fyPH39hrvmgLlxLjIrfRVoL0785GopiklZ35K6Y2GPOpP
xsTtt+8K8cX0IJITl0/Iqoyf1pSsIHxjBfnWfkmjwHF6JSuWWl4ttXwaMks8ZEca
pz79+1oT5cBHyl0Wgm0PAuTJzBkIkAzqwr9YRTMmhmfeqwFgxPY+oOEvfiNQNuKW
4lMQnmbcmpQmI2gMmO7Ui7m38ZvIr4ZdV0IwEpyhdInbk0E5KmFPZ+XAlHq0n0z2
anh8w7hkDgjuX1VRpLk+uwcFax8UPDh827iba6ueRbaJHLHX0zY=
=Zhfj
-----END PGP SIGNATURE-----

--NfKNJifiYwgwGQjp--
