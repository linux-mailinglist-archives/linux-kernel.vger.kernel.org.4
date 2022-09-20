Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725455BE701
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiITNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiITNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:25:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635D518361;
        Tue, 20 Sep 2022 06:25:23 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 141A01C0011;
        Tue, 20 Sep 2022 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663680321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYeC4eRq5RlMrUFjZ+fZ/i+94z9oPYyN1F3IkNjUduA=;
        b=jfdDLHPtE8UCO8JtQrFXucuEIwhzmLa9F73A0xZNIOmO6IO7OmAK0F3mYbcdfdrE2mua0Z
        6Qwi6KsO88oBtk+X+E0EQxURr1QG0iRmnOvIkBAnfKYbFNzXZCOQjKKokaUUgTtrLroKMn
        8E9JluBgaW6HcuXq98RridYXxwI1r5SltUaObqa/x9PzvJ1v0Q/OmwUT+iToVrSfkeEREG
        PlvV4gTn8vdZyAW6quv6eZzpjF1D5oXgKMSch0JVm3dc6yiYmIma57rS73DUFYak/TluRe
        jIfdX4mNTxReQkrLIyI4gUVQJ9Ir7PBgNayyuTJutX4b1qw4L6C1VTlsuSv0eQ==
Date:   Tue, 20 Sep 2022 15:25:20 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Message-ID: <Yym/QDURAtn1LX8i@aptenodytes>
References: <20220919023247.731106-1-rafaelmendsr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9uSi25hGhxag/Hrg"
Content-Disposition: inline
In-Reply-To: <20220919023247.731106-1-rafaelmendsr@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9uSi25hGhxag/Hrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rafael,

On Sun 18 Sep 22, 23:32, Rafael Mendonca wrote:
> The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
> a memleak.

Thanks for this patch, good catch!

I agree with Jacopo, you shouldn't add a newline before the call.
Feel free to send a v2 with that fixed and include my:

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor=
")
> Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
> ---
>  drivers/media/i2c/ov5648.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
> index dfcd33e9ee13..95850f06112b 100644
> --- a/drivers/media/i2c/ov5648.c
> +++ b/drivers/media/i2c/ov5648.c
> @@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *client)
>  	mutex_destroy(&sensor->mutex);
>  	media_entity_cleanup(&subdev->entity);
> =20
> +	v4l2_fwnode_endpoint_free(&sensor->endpoint);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.34.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--9uSi25hGhxag/Hrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMpv0AACgkQ3cLmz3+f
v9FR8Qf/YtP4XukNSQNQ6xjgkO5Nl4UDlg/p3v3HkQhsgpDasIQUrFhSgjwcJ0HI
sA07XaEtElbrbAwbLyqhuxJc/sSYXlhSzaEp7YMm6NwjPmAVXY1cYmU0qRXcupEE
KIZWjdVA+O+FR2DTmHLxIb2e4nRKSw5Et1er8kVdxJ58Zy57I+clIidNJFJYh2c1
P5iGPsnYLSIvbHdZhgvocfE7lrs34o+fZGZfSLtGxPpZzRABVVwv7exPL4feC64x
n6s7iNGxMBH3SHu0JJCQ+yDA6El20sQxbUpoMNawI/MWDjn6G7a4HKpCx8qPxldP
JyaATLXCdPuaFQPZ9ot04/lYksARqA==
=x+Bz
-----END PGP SIGNATURE-----

--9uSi25hGhxag/Hrg--
