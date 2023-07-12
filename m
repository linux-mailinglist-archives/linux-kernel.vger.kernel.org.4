Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACD750565
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjGLLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjGLLEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:04:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED31703;
        Wed, 12 Jul 2023 04:04:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4A161757;
        Wed, 12 Jul 2023 11:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70C5C433C7;
        Wed, 12 Jul 2023 11:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689159850;
        bh=rdm8WjXKH/Znp0e9wHbJbC6k/jQWaZx00+D9CSaZnPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbz9+/NWkxFQdbyjChz27t9IXpRfWc6BNaglL3SF1Q3Tp8OOTXUBHPjQv4s3LKhow
         88Z6aWaBoDxnkx6A4QTaGoOEIX9RU98sGOb/RoHe/Ant5XWIkPBgzq9MQzjn8sTl7s
         d9ycxbbnNuRjm2g+ItMSS30+ynn8eeThv7186OnVGJ8TH/ELq6BL+OBKgEYMP4fw4m
         Ove5LyP6fG5+sOP+p9MJo+meTYlxgwYwubeE5/0ts5kEwYFI4kRjRDGV9ytJv5K2yb
         1opDdMrG00jrJBBQ8AihNvSfLQes3j5FZ+W83M1Vtha+1MWLlUxsFatNVLRu+5S8yF
         dGPQ1j6i6VNGQ==
Date:   Wed, 12 Jul 2023 13:04:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] iio: imu: lsm6dsx: Fix mount matrix retrieval
Message-ID: <ZK6IpZvG47zsKZFk@lore-rh-laptop>
References: <12960181.O9o76ZdvQC@alexpc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1ZHb+yY60egR0aD"
Content-Disposition: inline
In-Reply-To: <12960181.O9o76ZdvQC@alexpc>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1ZHb+yY60egR0aD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The function lsm6dsx_get_acpi_mount_matrix should return true when ACPI
> support is not enabled to allow executing iio_read_mount_matrix in the
> probe function.
>=20
> Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieval")
>=20
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/
> st_lsm6dsx/st_lsm6dsx_core.c
> index 6a18b363cf73..62bc3ee783fb 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct dev=
ice=20
> *dev,
>  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
>  					  struct=20
> iio_mount_matrix *orientation)
>  {
> -	return false;
> +	return true;

I would say it should return something like -EOPNOTSUPP.

Regards,
Lorenzo

>  }
> =20
>  #endif
> --=20
> 2.41.0
>=20
>=20
>=20
>=20

--a1ZHb+yY60egR0aD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZK6IoQAKCRA6cBh0uS2t
rLw5AP97OM4FyYf1bRULy7a0yrejqbRvsTYgBHpnO3Okk3GF+AEA3xnWcjF4LTAO
o3VyGdcNfSq9Vx8lFJwnzaZ/MsMAwAc=
=rqcn
-----END PGP SIGNATURE-----

--a1ZHb+yY60egR0aD--
