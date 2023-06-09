Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6832B729F54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbjFIP4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbjFIP4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B903589;
        Fri,  9 Jun 2023 08:56:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8912465983;
        Fri,  9 Jun 2023 15:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B6BC4339B;
        Fri,  9 Jun 2023 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686326169;
        bh=lmii+YJHW/Bw7Ht4zJ7k+kVHnXkIAIs1YZPvgbtm5Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4be1us2J7XeI1Rc8ukeNLGkR9Gg0eOph7dL53plXqRfgFWKS1TquNmnP8Fn5j7pb
         Y7spCK6IzRyBnBySUIIBU1MBAyMq7BQqapLeKfY3XPPxXKADQUKv2YtyCsgd90ere1
         HG0MeQN+l9nYBSwxjSuRouQd+oUhIy34z4cRvkjleCOO0Qiml2d0YEWBB09WNiJKyx
         aJda8E9GG++9v9XJXw1ZRqm7uoL8Su3sFDjSbKxKHOg8pReNMb6nng1QUoL7EFCxDd
         kRoctvtBY3Ftf4vFVb1yatYlzPgoC0LTBFoEUFhtjnTZBeMzAM5feolCqVHFW5FS8a
         /qE7JEQpY2Mlw==
Date:   Fri, 9 Jun 2023 16:56:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
Message-ID: <20230609-unpaved-propeller-b361fba89913@spud>
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T+MxQ7SbKoVjteRl"
Content-Disposition: inline
In-Reply-To: <20230609083009.2822259-4-wenst@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T+MxQ7SbKoVjteRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 04:30:00PM +0800, Chen-Yu Tsai wrote:
> The VCN33_BT and VCN33_WIFI regulators are actually the same regulator,
> having the same voltage setting and output pin. There are simply two
> enable bits that are ORed together to enable the regulator.
>=20
> Having two regulators representing the same output pin is misleading
> from a design matching standpoint, and also error-prone in driver
> implementations. If consumers try to set different voltages on either
> regulator, the one set later would override the one set before. There
> are ways around this, such as chaining them together and having the
> downstream one act as a switch. But given there's only one output pin,
> such a workaround doesn't match reality.
>=20
> Remove the VCN33_WIFI regulator. During the probe phase, have the driver
> sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffix
> so that the regulator name matches the pin name in the datasheet.
>=20
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++-----
>  include/linux/regulator/mt6358-regulator.h |  6 +-
>  2 files changed, 52 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6=
358-regulator.c
> index c9e16bd092f6..faf6b0757019 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] =3D {
>  	2800000, 2900000, 3000000,
>  };
> =20
> -static const unsigned int vcn33_bt_wifi_voltages[] =3D {
> +static const unsigned int vcn33_voltages[] =3D {
>  	3300000, 3400000, 3500000,
>  };
> =20
> @@ -321,7 +321,7 @@ static const u32 vcama_idx[] =3D {
>  	0, 7, 9, 10, 11, 12,
>  };
> =20
> -static const u32 vcn33_bt_wifi_idx[] =3D {
> +static const u32 vcn33_idx[] =3D {
>  	1, 2, 3,
>  };
> =20
> @@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulator=
s[] =3D {
>  		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
>  	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
>  		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -	MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> -	MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
> -		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
> -		   0, MT6358_VCN33_ANA_CON0, 0x300),
> +	MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
> +		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),

Excuse me if I am being daft here, but could you explain how this change
is compatible with existing devicetrees?

Thanks,
Conor.

--T+MxQ7SbKoVjteRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZINLlAAKCRB4tDGHoIJi
0hc0APoD4n3DH6dCcYO0STxD8ItqnpeAbuJrfOHQaaItXKlm7gD9HgNapaxBYCau
9GrvWUDp8b42402vX7pth4xpW08aIgw=
=TL4I
-----END PGP SIGNATURE-----

--T+MxQ7SbKoVjteRl--
