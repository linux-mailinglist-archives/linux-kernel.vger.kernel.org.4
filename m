Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BA965C522
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjACRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjACRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:32:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B71112605;
        Tue,  3 Jan 2023 09:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A42B161488;
        Tue,  3 Jan 2023 17:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862D8C433EF;
        Tue,  3 Jan 2023 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672767138;
        bh=A5nDrEpe1e6m7M5sQQYdF7NrGQIutL/ZR2MPitemRS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=myWGraxTzypbHe8tgM/PuXAcZye01rJD00pPoC+mrHZqWeCK9RSgbqbhHT0VzGhOW
         /ZIt8opb9Y+sj5GfDHoD9Ae3NEYmHzFoWAY3mx9KxoK3fauQZtu8n2miYHl0qMUk88
         56RxoI/e/WpF/55KjOseZZgKdeJB37Denm40Q+P8DqCEc0CDbqOBouDTnVofaQ9Fpc
         5oXY/f0FxJnvpLW6UcPLUngeXpokSsJ/M6uXV+X1xZkARvtB1j2T3slX3MB+ZQVclS
         5K0c6fmQdqAQtPGRMxzCU4nu/BttnTqSV0NZ9GiQEy2+2su8e3N0ylMmdUuDyD1TcR
         IphHTOxZGGeTQ==
Date:   Tue, 3 Jan 2023 17:32:14 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Message-ID: <Y7RmnswYX+1g5vci@spud>
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YvKQCHSpAD8v+v18"
Content-Disposition: inline
In-Reply-To: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YvKQCHSpAD8v+v18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2023 at 05:45:30PM +0100, Geert Uytterhoeven wrote:
> In various places, string buffers of a fixed size are allocated, and
> filled using snprintf() with the same fixed size, which is error-prone.
>=20
> Replace this by calling devm_kasprintf() instead, which always uses the
> appropriate size.
>=20
> While at it, remove an unneeded intermediate variable, which allows us
> to drop a cast as a bonus.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

I half wonder if this should actually have a fixes tag too. Since it
used what came after the @ in $full_name, it'd be possible to create
(an incorrect) DTS that would lead to a clash between pll names &
therefore probe would fail.
The tag would be:
Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock suppor=
t")

Either way, thanks for pointing out a function that does exactly what I
initially wanted to do but could not find! Glad to be rid of those
"oddly specific" allocations.

Thanks,
Conor.
> ---
>  drivers/clk/microchip/clk-mpfs-ccc.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microchip=
/clk-mpfs-ccc.c
> index 32aae880a14f3b1c..0ddc73e07be42973 100644
> --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> @@ -164,12 +164,11 @@ static int mpfs_ccc_register_outputs(struct device =
*dev, struct mpfs_ccc_out_hw_
> =20
>  	for (unsigned int i =3D 0; i < num_clks; i++) {
>  		struct mpfs_ccc_out_hw_clock *out_hw =3D &out_hws[i];
> -		char *name =3D devm_kzalloc(dev, 23, GFP_KERNEL);
> +		char *name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_out%u", parent->nam=
e, i);
> =20
>  		if (!name)
>  			return -ENOMEM;
> =20
> -		snprintf(name, 23, "%s_out%u", parent->name, i);
>  		out_hw->divider.hw.init =3D CLK_HW_INIT_HW(name, &parent->hw, &clk_div=
ider_ops, 0);
>  		out_hw->divider.reg =3D data->pll_base[i / MPFS_CCC_OUTPUTS_PER_PLL] +
>  			out_hw->reg_offset;
> @@ -201,14 +200,13 @@ static int mpfs_ccc_register_plls(struct device *de=
v, struct mpfs_ccc_pll_hw_clo
> =20
>  	for (unsigned int i =3D 0; i < num_clks; i++) {
>  		struct mpfs_ccc_pll_hw_clock *pll_hw =3D &pll_hws[i];
> -		char *name =3D devm_kzalloc(dev, 18, GFP_KERNEL);
> =20
> -		if (!name)
> +		pll_hw->name =3D devm_kasprintf(dev, GFP_KERNEL, "ccc%s_pll%u",
> +					      strchrnul(dev->of_node->full_name, '@'), i);
> +		if (!pll_hw->name)
>  			return -ENOMEM;
> =20
>  		pll_hw->base =3D data->pll_base[i];
> -		snprintf(name, 18, "ccc%s_pll%u", strchrnul(dev->of_node->full_name, '=
@'), i);
> -		pll_hw->name =3D (const char *)name;
>  		pll_hw->hw.init =3D CLK_HW_INIT_PARENTS_DATA_FIXED_SIZE(pll_hw->name,
>  								      pll_hw->parents,
>  								      &mpfs_ccc_pll_ops, 0);
> --=20
> 2.25.1
>=20
>=20

--YvKQCHSpAD8v+v18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7RmnQAKCRB4tDGHoIJi
0qXMAQCbwp9Fb8Bmn3P56tCHIvNpx+ztMfDWLVpz7Z8bMSjQFgEAiilrMNqmAtuY
O4NG4cOO6rC5q55zrR2qsL2ccp0+LwI=
=loe4
-----END PGP SIGNATURE-----

--YvKQCHSpAD8v+v18--
