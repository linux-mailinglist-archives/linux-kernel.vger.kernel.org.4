Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE06663B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjAKT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbjAKT0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:26:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442DCD2DB;
        Wed, 11 Jan 2023 11:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E7830B81C9B;
        Wed, 11 Jan 2023 19:26:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB83BC433EF;
        Wed, 11 Jan 2023 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673465180;
        bh=UPbsf7hK6LI/9fYSGa56Uex4aDJWhPnt2DVwE2KC6RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbbSLfoUcpHGQq3IgLsSV47Q8RVMXLlQvrEXkd4y7xVA/KKqFq3Euui5gmXaW2GKY
         Ur5wk62tk+XioMbeTxZ02+mPScA170qbF3pWKUzLWelpxLjUv9hUB9s4sWvAFENE5X
         Iygsvy9EIJ5CD0xG8jNuSgMipdpFciq+qh795V7eqxz6O1T21gakFdtau6PUwXMLrn
         ptNO5yTo/B6MvlpiVU51RHq6uYss7NoXjBmusyVLiPSglySevRwzhWRNIDD9n6NloP
         KvUkC07ek0Xt0bJLlOyNHtj/Z1XVJ8MjaBEMx9xJGbyJZrYqOYlSjSYKi418n0I51O
         CQfyYFu4I3poA==
Date:   Wed, 11 Jan 2023 19:26:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu.Beznea@microchip.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: microchip: mpfs-ccc: Use devm_kasprintf() for
 allocating formatted strings
Message-ID: <Y78NWDc8b9YDqHdq@spud>
References: <f904fd28b2087d1463ea65f059924e3b1acc193c.1672764239.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WFNREt5T4zNKwgvA"
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


--WFNREt5T4zNKwgvA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Claudiu,

Could you pick this one up when you get a chance please?

Thanks,
Conor.

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

--WFNREt5T4zNKwgvA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY78NWAAKCRB4tDGHoIJi
0sD4AP9f2q2+IO9ibu6WIBfOj/1YvSSOh5ixFVvBbHDuYlk+VAD+Mf8Gwx2rEzq1
8JU9u0BU2lvtn3zuQR5/O0UVUQt0AwM=
=Bzqk
-----END PGP SIGNATURE-----

--WFNREt5T4zNKwgvA--
