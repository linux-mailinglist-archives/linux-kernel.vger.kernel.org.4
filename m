Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1965B6EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjABTWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjABTWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:22:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEFBB7EE;
        Mon,  2 Jan 2023 11:22:50 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 567766600366;
        Mon,  2 Jan 2023 19:22:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672687369;
        bh=pIy7CdocbAmO6g0Vpge6r8RkPfNWteN8URfk7q7yXMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEFz7JzK+aMwEhaSRndT85vi7jwp9cKOPrayU6NmWxFncKZ4fnZT2R2h+rLFoesP1
         FoFURBAj2js3Bkyg9l1s2/lAiDzph4zvCEYehBJctxM/UTV7HU3HhpK6+eI3jUAbdH
         vNhCS/Cgg8MV1a1ayCbbfxwedjQD/O6GELPzTSjx4bh8UX8I8UuRE0xcpE2CfcskjU
         f5h/W+cM8YvF/ciVY1pIf9Wnv2pKLqPo9ItN/oZ4c8f/R/wKzXJ9FKZ35EYbmoMR5p
         pzisrjIojPLowxji0vNj62yi9+OsCRv2aHdCoLApAj66FIgvKHJ4gW7/WzINDnLGwj
         vWX/UIxdq16SQ==
Received: by mercury (Postfix, from userid 1000)
        id 14B0B106076E; Mon,  2 Jan 2023 20:22:47 +0100 (CET)
Date:   Mon, 2 Jan 2023 20:22:47 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] power: supply: da9150: Remove redundant error logging
Message-ID: <20230102192247.rgqcmuyqpultvwsx@mercury.elektranox.org>
References: <Y6SRZZUDoiIKJ0rJ@qemulion>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhmmz776lzybvn6w"
Content-Disposition: inline
In-Reply-To: <Y6SRZZUDoiIKJ0rJ@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhmmz776lzybvn6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 22, 2022 at 10:48:29PM +0530, Deepak R Varma wrote:
> A call to platform_get_irq_byname() already prints an error on failure
> within its own implementation. So printing another error based on its
> return value in the caller is redundant and should be removed. The
> clean up also makes if condition block braces and the device pointer
> variable dev unnecessary. Remove those as well.
>=20
> Issue identified using platform_get_irq.cocci coccinelle semantic patch.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Thanks, queued.

-- Sebastian

> Note: The change was build tested using ARM64 defconfig.
>=20
>  drivers/power/supply/da9150-charger.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply=
/da9150-charger.c
> index f9314cc0cd75..14da5c595dd9 100644
> --- a/drivers/power/supply/da9150-charger.c
> +++ b/drivers/power/supply/da9150-charger.c
> @@ -466,10 +466,8 @@ static int da9150_charger_register_irq(struct platfo=
rm_device *pdev,
>  	int irq, ret;
>=20
>  	irq =3D platform_get_irq_byname(pdev, irq_name);
> -	if (irq < 0) {
> -		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>=20
>  	ret =3D request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, irq_name,
>  				   charger);
> @@ -482,15 +480,12 @@ static int da9150_charger_register_irq(struct platf=
orm_device *pdev,
>  static void da9150_charger_unregister_irq(struct platform_device *pdev,
>  					  const char *irq_name)
>  {
> -	struct device *dev =3D &pdev->dev;
>  	struct da9150_charger *charger =3D platform_get_drvdata(pdev);
>  	int irq;
>=20
>  	irq =3D platform_get_irq_byname(pdev, irq_name);
> -	if (irq < 0) {
> -		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
> +	if (irq < 0)
>  		return;
> -	}
>=20
>  	free_irq(irq, charger);
>  }
> --
> 2.34.1
>=20
>=20
>=20

--yhmmz776lzybvn6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOzLwYACgkQ2O7X88g7
+ppQfg//edSdOgWKgG0oZOTII18b+uYQwQw5SZgEHaaQeLcOnWJSJ/3A9HKFHXRH
KmBJrGYVcizG85rIqLA+OyK7RNbt+c4AcbF633uoB4lHQhtcjctimx+rMo1DSwt9
bUsOtyqQw8jVefbHwsuuDGQ8o9tOh4TTH3wT1oHNoZ6wsmDCVI1GOi2jLjjjQbyi
2/TaFs+eosRF7s/tSrDSC5TwlQKtPF2s7emHmDKaQfOqB5WBVV0amisF00lEK7M2
jq6nUQrzoyVg4yaBnblHb41cmIbKSfDUEYfD47rQO7wCtg7k2fr48yPq5dOxqFf1
aOPw1DI3xNLLcFxn/4P50J86Bhirn7k/KbTlNxw4uT25Ht6L45mPOLreUIRBA1s7
x/gRc0hScu/ZubsQMfvfbDzvdVED2kFel04DR1Gr1Z11fJzVInxRltLcfrgcY+Rz
S5p3VF1lxy2YhZIVDb615d9XcV//UJk+UF9soOQVIhyMtQ4wR2Y4PUNAUW18rNUt
7W/XxLPcXNYmhyuJQnC4k6fnpAl7V5QZVrJ6+SH2GFqzeVAYMfvEqOma365OAHHd
moSZaaYEc9rlIwMyK9fOYmSWeKFRR8bWQYV2W8rQqltyQ7a/wx6MX/HPc31Khbhx
qq96F7zhex9kP/K6YMZquQ1qU9EV0e/iKd9O8QP1e6uccoYZJQY=
=JV7R
-----END PGP SIGNATURE-----

--yhmmz776lzybvn6w--
