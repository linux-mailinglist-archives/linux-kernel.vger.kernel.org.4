Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBB72C348
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjFLLmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbjFLLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:40:36 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AC3E77
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=SJUy69cQdjN34xVgymaNvvbcmcWa
        DjsKYWAzZ7bIJQ8=; b=Ag258Y3Z2HFpAcF+Dq36/G54vS9ThBRpQyiQbz9ylpUg
        g8D6NXXS+MSZYwzEu85FNycDN+MCeVNdqmoQlZOX+S9aIz5ocPoYu9fN8MfPFGEQ
        /DGmFmBjbtHUAVZfJGz/KwUrolUBumaIDPxsSJmC5UOhp1GOQYDvsWFEpdHe1UY=
Received: (qmail 2176161 invoked from network); 12 Jun 2023 13:35:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Jun 2023 13:35:27 +0200
X-UD-Smtp-Session: l3s3148p1@kZJ3He39wtkujnt4
Date:   Mon, 12 Jun 2023 13:35:26 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] WIP: gnss: merge MTK driver into UBX driver
Message-ID: <ZIcC/sg59Ti+lL1N@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XRaSCOdo9TwlJdgC"
Content-Disposition: inline
In-Reply-To: <20230523064310.3005-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XRaSCOdo9TwlJdgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 08:43:06AM +0200, Wolfram Sang wrote:
> This is a proof-of-concept how easy it is to merge those two drivers as
> they are extremly similar. The differences can be abstracted away
> easily. Further work (renaming from 'ubx' to something more generic,
> removing the MTK driver, ...) is postponed until there is agrement that
> merging these drivers is actually wanted. I vote for it, though. I have
> updates to the UBX driver which do make sense for the MTK driver as
> well. Code saving is also a plus. We can always fork into a specific
> driver again if we'd ever need that.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Johan, just from a gut feeling or a hi level glimpse: is this merging of
the driver worth pursuing?

Thanks and all the best,

   Wolfram

> ---
>  drivers/gnss/ubx.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
> index c951be202ca2..c01e1e875727 100644
> --- a/drivers/gnss/ubx.c
> +++ b/drivers/gnss/ubx.c
> @@ -63,12 +63,31 @@ static const struct gnss_serial_ops ubx_gserial_ops =
=3D {
>  	.set_power =3D ubx_set_power,
>  };
> =20
> +struct ubx_info {
> +	enum gnss_type type;
> +	char *v_bckp_name;
> +};
> +
> +const struct ubx_info ubx_info_ubx =3D {
> +	.type =3D GNSS_TYPE_UBX,
> +	.v_bckp_name =3D "v-bckp",
> +};
> +
> +const struct ubx_info ubx_info_mtk =3D {
> +	.type =3D GNSS_TYPE_MTK,
> +	.v_bckp_name =3D "vbackup",
> +};
> +
>  static int ubx_probe(struct serdev_device *serdev)
>  {
> +	const struct ubx_info *info =3D of_device_get_match_data(&serdev->dev);
>  	struct gnss_serial *gserial;
>  	struct ubx_data *data;
>  	int ret;
> =20
> +	if (!info)
> +		return -ENOENT;
> +
>  	gserial =3D gnss_serial_allocate(serdev, sizeof(*data));
>  	if (IS_ERR(gserial)) {
>  		ret =3D PTR_ERR(gserial);
> @@ -77,7 +96,7 @@ static int ubx_probe(struct serdev_device *serdev)
> =20
>  	gserial->ops =3D &ubx_gserial_ops;
> =20
> -	gserial->gdev->type =3D GNSS_TYPE_UBX;
> +	gserial->gdev->type =3D info->type;
> =20
>  	data =3D gnss_serial_get_drvdata(gserial);
> =20
> @@ -87,7 +106,7 @@ static int ubx_probe(struct serdev_device *serdev)
>  		goto err_free_gserial;
>  	}
> =20
> -	data->v_bckp =3D devm_regulator_get_optional(&serdev->dev, "v-bckp");
> +	data->v_bckp =3D devm_regulator_get_optional(&serdev->dev, info->v_bckp=
_name);
>  	if (IS_ERR(data->v_bckp)) {
>  		ret =3D PTR_ERR(data->v_bckp);
>  		if (ret =3D=3D -ENODEV)
> @@ -130,9 +149,10 @@ static void ubx_remove(struct serdev_device *serdev)
> =20
>  #ifdef CONFIG_OF
>  static const struct of_device_id ubx_of_match[] =3D {
> -	{ .compatible =3D "u-blox,neo-6m" },
> -	{ .compatible =3D "u-blox,neo-8" },
> -	{ .compatible =3D "u-blox,neo-m8" },
> +	{ .compatible =3D "u-blox,neo-6m", .data =3D &ubx_info_ubx, },
> +	{ .compatible =3D "u-blox,neo-8", .data =3D &ubx_info_ubx, },
> +	{ .compatible =3D "u-blox,neo-m8", .data =3D &ubx_info_ubx, },
> +	{ .compatible =3D "globaltop,pa6h", .data =3D &ubx_info_mtk },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, ubx_of_match);
> --=20
> 2.35.1
>=20

--XRaSCOdo9TwlJdgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSHAvoACgkQFA3kzBSg
KbazVQ/9Eq0E2g3Vnu4yMua3yX5wPa84jPJIPwfGTi6t0PBh9Fs08stHGQ2VMrAb
k2i/VLC45jbYeDI9f6IU4qDdocHBNP1Tdf2B8q7pB+lw3IzdZswU7RN0wxo9VRCU
UPCUTypRg8amvObl2IgdWikm9ufWL8qrWNetkeM0IJcvE1Olu4d4t2uO2FLWyb7V
Zc+/tdmKDntSGQBBV5FH2PIydwYdlTLqoIY0VRoJ1fMFXbd0PCCFm5FX3LSUNy1/
2C8ZDAQvWWDmFYFtXh7XL+CeE8edsAduIOGYCQbapE9A2tJsMiNgNX5nr5NyIakW
t2xR786TjEan1gl1i3DoHJLMvdGyUnkVLXPcTA6IeIxwZnIALA6AlNm7seYzWein
hneQ8UsNCjKXI5msYVhj/AgZhvSIiY4yQUVn185YlsOdp5PaIJGyR33cVuJcW/VW
m2GvGD+Qi8fxVbEudgqHXq1+1X2/CxFfVOVG4qVVN0lEIoAhOHrXeLk0A4jRSqzD
ZD77/Ru3E6umi35kT6uA3S0P+B4uESqpyDN0oBKqz1hwWWFuvyDhZyfAisA4fUfz
gQrkvZoVZL/RLg1H1FpmpGn2qy9CaoWLnKfpnsHqSyKRELA3unsLxSJWNLEpvZkg
R2WaYxfyVuf/6TQiDrST8QEKnL1LbKnVKXMEpU++B9gCfjYGqm0=
=near
-----END PGP SIGNATURE-----

--XRaSCOdo9TwlJdgC--
