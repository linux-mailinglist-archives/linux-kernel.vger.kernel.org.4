Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254367EDF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjA0TF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjA0TFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:05:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1339C2006D;
        Fri, 27 Jan 2023 11:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36CD61D8F;
        Fri, 27 Jan 2023 19:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC35C433EF;
        Fri, 27 Jan 2023 19:05:50 +0000 (UTC)
Date:   Fri, 27 Jan 2023 19:05:47 +0000
From:   Mark Brown <broonie@debian.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Luca Di Stefano <luca.distefano@linaro.org>,
        993612@bugs.debian.org, stable@kernel.org
Subject: Re: [PATCH] of/address: Return an error when no valid dma-ranges are
 found
Message-ID: <Y9Qgi2osVrP/qcAM@sirena.org.uk>
References: <20230126-synquacer-boot-v1-1-94ed0eb1011f@kernel.org>
 <CAL_JsqLPUKS2+8-sShADSYxAgxjP3mh=TcZPszFeYbMTiPvjYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UnZ9XPcC2SdAdzt2"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLPUKS2+8-sShADSYxAgxjP3mh=TcZPszFeYbMTiPvjYQ@mail.gmail.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UnZ9XPcC2SdAdzt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 12:37:35PM -0600, Rob Herring wrote:

> Looks to me like we are leaking 'r' with this change.

Oh, probably now that you mention it.  Usually the OF code keeps
track of more things than I expect...

> Wouldn't this change work:

> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index c34ac33b7338..f43311f01c32 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -968,6 +968,11 @@ int of_dma_get_range(struct device_node *np,
> const struct bus_dma_region **map)
>         for_each_of_range(&parser, &range)
>                 num_ranges++;
>=20
> +       if (!num_ranges) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +

Not as-is, there is a range counted by that first loop but it's
then rejected by the check in the second loop for cpu_addr =3D=3D
OF_BAD_ADDR.  We'd need to add a similar check in the first loop.
It should work otherwise though and avoids doing the allocation
in this case.

--UnZ9XPcC2SdAdzt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPUIIoACgkQJNaLcl1U
h9BWWgf/fmh+vNOYgJclVva+npcQWUCr724F0B6EUwZhP8m1z7ltvq8qnzdPRo4K
XU+25ixFsMoD0D4hiAQYWweXEzre+sEkpggC7ujSMjMqjYdi2JKuJWVYsQCc4fIt
R67C5beB5xy3jvu5lNujixhC+p4+mvUteOxrbGPjZzKLao/1cX8uI1FuXjGRX6j8
oe7Arw13DwS/0nKjn7CuU1XSLKuYzJ1M6keRj54cDqCvrl87werGGyYGQmr1p1DT
AB71on2CPiWsITqqHi6jbMwcwNOVg9I/024R0GIH1fWqad+1cmnC5yICTlTYwICV
HyehNSl/7fpE3ZRq+EF5HKjUNv7DZA==
=gn0r
-----END PGP SIGNATURE-----

--UnZ9XPcC2SdAdzt2--
