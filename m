Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887825E9DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiIZJbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiIZJb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:31:28 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC62255AC;
        Mon, 26 Sep 2022 02:30:17 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85EE1240005;
        Mon, 26 Sep 2022 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664184615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4DIslgriYh/ETMrXcfHJGuJVgbSPAelyn/x0LZzTFuw=;
        b=hZ5XaLg6Wt9nBt34WKi4TMYczvDeAu3+nimfXO7cj8VdOd5cFS4US/KXGRSzhxoDgfJjHQ
        QsMwqfQatDBuYqhK8KfWLNkl5LPzR5/6WQITG/D71yIrrqGHuzoXjBUcuvs52qRG/kuoE7
        XmS6Ig3DGmXKXnwUAjVWOANaqPFQhFlqfE+VQchDvNYcvV4RSJpJ9tWy3wZyuyay+lpTh6
        8vnfHoU0lsEm1W4w1vxy6/LREPmniLDPXETky1/LnMzlF5t5djjH65g+KD/0EIoAhe/rNt
        7yrHmDjvz3uH4oXu+2gVP0hhEc8nCyYFZS0kHM8R4CTDOTMTiNPeAnPBrYdBgg==
Date:   Mon, 26 Sep 2022 11:30:13 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/8] phy: allwinner: phy-sun6i-mipi-dphy: Make RX support
 optional
Message-ID: <YzFxJUhypKHkSGgy@aptenodytes>
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xoZ1kkt8jdbs2RvB"
Content-Disposition: inline
In-Reply-To: <20220812075603.59375-6-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xoZ1kkt8jdbs2RvB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Fri 12 Aug 22, 02:56, Samuel Holland wrote:
> While all variants of the DPHY likely support RX mode, the new variant
> in the A100 is not used in this direction by the BSP, and it has some
> analog register changes, so its RX power-on sequence is unknown. To be
> safe, limit RX support to variants where the power-on sequence is known.

Coming back to this series, with some minor cosmetic suggestions.

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 25 +++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/al=
lwinner/phy-sun6i-mipi-dphy.c
> index 3900f1650851..625c6e1e9990 100644
> --- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> +++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> @@ -114,6 +114,10 @@ enum sun6i_dphy_direction {
>  	SUN6I_DPHY_DIRECTION_RX,
>  };
> =20
> +struct sun6i_dphy_variant {
> +	bool	supports_rx;

Since you're introducing a "tx_power_on" field later on, it would be more
consistent to call this one "rx_supported".

> +};
> +
>  struct sun6i_dphy {
>  	struct clk				*bus_clk;
>  	struct clk				*mod_clk;
> @@ -123,6 +127,7 @@ struct sun6i_dphy {
>  	struct phy				*phy;
>  	struct phy_configure_opts_mipi_dphy	config;
> =20
> +	const struct sun6i_dphy_variant		*variant;
>  	enum sun6i_dphy_direction		direction;
>  };
> =20
> @@ -409,6 +414,10 @@ static int sun6i_dphy_probe(struct platform_device *=
pdev)
>  	if (!dphy)
>  		return -ENOMEM;
> =20
> +	dphy->variant =3D device_get_match_data(&pdev->dev);
> +	if (!dphy->variant)
> +		return -EINVAL;
> +
>  	regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs)) {
>  		dev_err(&pdev->dev, "Couldn't map the DPHY encoder registers\n");
> @@ -445,8 +454,13 @@ static int sun6i_dphy_probe(struct platform_device *=
pdev)
>  	ret =3D of_property_read_string(pdev->dev.of_node, "allwinner,direction=
",
>  				      &direction);
> =20
> -	if (!ret && !strncmp(direction, "rx", 2))
> +	if (!ret && !strncmp(direction, "rx", 2)) {
> +		if (!dphy->variant->supports_rx) {
> +			dev_err(&pdev->dev, "RX not supported on this variant\n");
> +			return -EOPNOTSUPP;
> +		}

Maybe add a blank line here for readability.

Looks good to me otherwise!

Paul

>  		dphy->direction =3D SUN6I_DPHY_DIRECTION_RX;
> +	}
> =20
>  	phy_set_drvdata(dphy->phy, dphy);
>  	phy_provider =3D devm_of_phy_provider_register(&pdev->dev, of_phy_simpl=
e_xlate);
> @@ -454,8 +468,15 @@ static int sun6i_dphy_probe(struct platform_device *=
pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
> =20
> +static const struct sun6i_dphy_variant sun6i_a31_mipi_dphy_variant =3D {
> +	.supports_rx	=3D true,
> +};
> +
>  static const struct of_device_id sun6i_dphy_of_table[] =3D {
> -	{ .compatible =3D "allwinner,sun6i-a31-mipi-dphy" },
> +	{
> +		.compatible	=3D "allwinner,sun6i-a31-mipi-dphy",
> +		.data		=3D &sun6i_a31_mipi_dphy_variant,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sun6i_dphy_of_table);
> --=20
> 2.35.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--xoZ1kkt8jdbs2RvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmMxcSUACgkQ3cLmz3+f
v9HgvggAgB23uIrZwveFcOqLL25MJcIrZoNcRPexfnFQcvz/nerHdLde83N+Q2uh
IiksEqx3C3iRc3Tw1OGvzg9MDWMW+w/rFTo4Fwx6kO8QtfpQ15wL0pL/VX+CxCoB
16cABES3igwy2adnVEWnWqEETdexJDgvKgXxVIalYB7pcoCKxnsyfQie6nMfiozz
bkar91bBTlbbZ/tQcGWtYwF3HJhWxQDsTnrHRHolNTn8+2iGzldKjfNjjON8hTjI
RIInNPKY64O2Qhep++QvfkERmjmfgewhQaHWOTWO9rEbgWhlTcULDX5idNGpJahn
W1LA84xdKPzwLkQSXzqeZXZf3yRflw==
=KS3e
-----END PGP SIGNATURE-----

--xoZ1kkt8jdbs2RvB--
