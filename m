Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B441B72E8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjFMQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjFMQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:48:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B61BC6;
        Tue, 13 Jun 2023 09:48:02 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-170.ewe-ip-backbone.de [91.248.189.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFE936601F5E;
        Tue, 13 Jun 2023 17:48:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686674880;
        bh=Vfsp4MJKJl01zeaV5MXk17AXCk6laqudfFFj8VAdsO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1Qs0uVaLNFTMtpVuMgb/CEr4VcVnk3t29wGt20lOzzaVQec+ErQHN57Xnp9cxcJp
         JyWjxzknDrkNXy/QOW3Oqq5p+/vHPZfZACch8PhNJ1500Ae38Ypy42N6L5gclJl2hO
         iHwe3gSMy04IP59PV6D65gCVLO+RjhZuT0NnmobLEyUjqpTOorQ3AP2bJE/QEM1pAF
         mmzSX8yZCCFmMnx29E/kM3WJ4mtM+6nQvgM7CXqiJ2kSN/Qmdb0iSZlfh4f5HNPcRw
         otYXzMUjYXhXEr8u50NSjfYq6S+8EfThEcYhnBK8Gk1P9hA7RFIEBLOIsznYwmGkUa
         iD74dFjRQFyqw==
Received: by mercury (Postfix, from userid 1000)
        id BFE1B1066FBA; Tue, 13 Jun 2023 18:47:58 +0200 (CEST)
Date:   Tue, 13 Jun 2023 18:47:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 11/25] PM / devfreq: rockchip-dfi: Handle LPDDR2
 correctly
Message-ID: <20230613164758.qjjjtog5bjnhjry5@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-12-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4yktvbxgbrrvhkrz"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-12-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4yktvbxgbrrvhkrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:39AM +0200, Sascha Hauer wrote:
> According to the downstream driver the DDRMON_CTRL_LPDDR23 bit must be
> set for both LPDDR2 and LPDDR3. Add the missing LPDDR2 case and while
> at it turn the if/else if/else into switch/case which makes it easier
> to read.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/devfreq/event/rockchip-dfi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 261d112580c9e..16cd5365671f7 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -82,12 +82,19 @@ static void rockchip_dfi_start_hardware_counter(struc=
t devfreq_event_dev *edev)
>  		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
> =20
>  	/* set ddr type to dfi */
> -	if (dfi->ddr_type =3D=3D ROCKCHIP_DDRTYPE_LPDDR3)
> +	switch (dfi->ddr_type) {
> +	case ROCKCHIP_DDRTYPE_LPDDR2:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
>  		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE=
_MASK),
>  			       dfi_regs + DDRMON_CTRL);
> -	else if (dfi->ddr_type =3D=3D ROCKCHIP_DDRTYPE_LPDDR4)
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
>  		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_=
MASK),
>  			       dfi_regs + DDRMON_CTRL);
> +		break;
> +	default:
> +		break;
> +	}
> =20
>  	/* enable count, use software mode */
>  	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTW=
ARE_EN),
> --=20
> 2.39.2
>=20

--4yktvbxgbrrvhkrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSInb4ACgkQ2O7X88g7
+prLsg/+OFMv+BneIBfQR6aVu6uaeszYHoFsIk7sydXblAcOfo7MGACwwpiW3Fig
h8gftrpDOi6qfCjzOzhR0WkKacHVt5xrY3lpkC06i+0Ri81LXxXKpAYMx3G6XVQv
W/0invqIS8Q6FbQi+a33Bdt1cCKQgcYSMFlQsSMnlYGiW6ixOlbsF2WtT7WjG7aC
PhACLPESyedGRXSVsvy9z81kSmNOs2blGNpXnJhYn5kNHsymlZLcMR7OsWkmUC+0
pHkYx/XrFSBPe5tT22YHoNeBIjxYA+GS7ZWmn+pgt1Sy/Zqd0w8L9hTTpuN1t4tu
Syzy1Q8tUp9sFV1qqJwaA4zx0xQ6KJvGh1laebyBlW4Ej9igWklUGM5xlfMGNsaz
1usQVasNBlC28y8x3rUZSFxFocnvCMU9Upg9+Xsx+jRq2PG5H2KJQuWpdndk5PIA
GTeEvkdJ63XTSoL3UQ9nx5KkiEOMn4MWsTBORaNOLzcNAe3OD2VKeXmDqeL26qV4
LgyB4txXEJG55VQXNVZ5SV0j8l2xS9M6LLq5G4DbV4bl0i0m2+RxSB9XouokM1G/
W2zzn6VXu2Z/442GjoohwC8QA9pOug/ZB1BYd20S8h7TDrGZ3QkPzhjt/nHC1LAS
h82umKSpYRHGLAfnboV4/Xk1KcMbn1sXX8uk+vjE7I/TuA+b5wc=
=kmuy
-----END PGP SIGNATURE-----

--4yktvbxgbrrvhkrz--
