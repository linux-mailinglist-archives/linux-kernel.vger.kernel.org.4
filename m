Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5B625F05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiKKQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiKKQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:02:04 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBCD4D5FB;
        Fri, 11 Nov 2022 08:02:03 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ft34so13422933ejc.12;
        Fri, 11 Nov 2022 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IzFm5yAGqvtfYoy9Qy7K7R0I8+Q4JHlKC2UWUPauEc=;
        b=T5mUCnfvXO8aCAnzaqkQ9C/Ce+CYzaQgWdbmVzg1fEB+7VSkDz4parn/qLenXsf8R3
         6pcKZILDLIOTNr2pbpzDgJvSF4cWyYaFX2ecW7W/gaW3nvfnK5/lCZ/uLX23BTjcFsDl
         n06Zq/aOs78QBYZ52ROBRM9fanf0dFEi0+PJeKBslYZEAlCeFSa8+LnFjsuZQggJ24EZ
         s20tM/a/5lKqxu1uEzD2Z/w5mzFcpAZWEN4WfINmQBV1iIsMYULOnoNfxXMQTdcWOdrT
         0g3niOC1QCKNVrhkDhLmsMU+WxzVHnj/1hAkjCGFJlGQJ7v9kIGwa805Qt8fTGOJUvhK
         ifVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IzFm5yAGqvtfYoy9Qy7K7R0I8+Q4JHlKC2UWUPauEc=;
        b=xQzbf3nVQtBjPpW7CwshQ6qPPQePKaDHx77Ei2LZ/dz91tvXAC92V/hgY0xXUDAukE
         EGqwgsnN3JpNfGL6XDVY1M5/YIhNnlJ+1bi/PEUmahNdZdsP5Yu8KDxHog4Zz/6DyqF+
         f/N5iJ5XVzxgjm1/m6PEEvgUGsAdGFIoBJ/fW3r5DW8QvHuA0XmW80Mpu61ni4v/mN5T
         SCka0PiXjwcVc86Zn9P+Ko+gFhR9fR7G7yw1UCvIXFYixkB5ZowyHIeB1ilL2KKTOWrz
         HwG7gFcWz3QfkbM9isQ6Y/YS41w9NmFWe+ix4Pz/Rr28xmu5L6p8zRrjo8PGhqL6L1DY
         e01A==
X-Gm-Message-State: ANoB5pm35ZUtGeY6irA1i9UOzrtliz/2KFlyTA8hGezsSZql9XLFyoJT
        iKo7r0/4e1nQBqmEiw1X+rs=
X-Google-Smtp-Source: AA0mqf6Y+J1gLFvLkinc8ORWGiRiGy5pZxup2ecYAPeGFKPgaXn/YDVwTYAL6XD5sJV8jGGCcr97TQ==
X-Received: by 2002:a17:906:a386:b0:78d:3f96:b7aa with SMTP id k6-20020a170906a38600b0078d3f96b7aamr2362442ejz.74.1668182521450;
        Fri, 11 Nov 2022 08:02:01 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z10-20020a170906714a00b0078d9b967962sm1008658ejj.65.2022.11.11.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:02:00 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:01:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH 2/7] hte: Add Tegra234 provider
Message-ID: <Y25x9gc4tpF1f022@orome>
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-3-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dyfI+VVQf83HGbpw"
Content-Disposition: inline
In-Reply-To: <20221103174523.29592-3-dipenp@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dyfI+VVQf83HGbpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2022 at 10:45:18AM -0700, Dipen Patel wrote:
> The Tegra234 AON GPIO instance and LIC IRQ support HTE. For the GPIO
> HTE support, it requires to add mapping between GPIO and HTE framework.
>=20
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  drivers/hte/hte-tegra194-test.c |   2 +-
>  drivers/hte/hte-tegra194.c      | 124 ++++++++++++++++++++++++++++++--
>  2 files changed, 121 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hte/hte-tegra194-test.c b/drivers/hte/hte-tegra194-t=
est.c
> index 5d776a185bd6..d79c28a80517 100644
> --- a/drivers/hte/hte-tegra194-test.c
> +++ b/drivers/hte/hte-tegra194-test.c
> @@ -16,7 +16,7 @@
>  #include <linux/hte.h>
> =20
>  /*
> - * This sample HTE GPIO test driver demonstrates HTE API usage by enabli=
ng
> + * This sample HTE test driver demonstrates HTE API usage by enabling
>   * hardware timestamp on gpio_in and specified LIC IRQ lines.
>   *
>   * Note: gpio_out and gpio_in need to be shorted externally in order for=
 this
> diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
> index 49a27af22742..5d1f947db0f6 100644
> --- a/drivers/hte/hte-tegra194.c
> +++ b/drivers/hte/hte-tegra194.c
> @@ -62,6 +62,10 @@
>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_25	25
>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_26	26
>  #define NV_AON_HTE_SLICE2_IRQ_GPIO_27	27
> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_28	28
> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_29	29
> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_30	30
> +#define NV_AON_HTE_SLICE2_IRQ_GPIO_31	31
> =20
>  #define HTE_TECTRL		0x0
>  #define HTE_TETSCH		0x4
> @@ -220,7 +224,100 @@ static const struct tegra_hte_line_mapped tegra194_=
aon_gpio_sec_map[] =3D {
>  	[39] =3D {NV_AON_SLICE_INVALID, 0},
>  };
> =20
> -static const struct tegra_hte_data aon_hte =3D {
> +static const struct tegra_hte_line_mapped tegra234_aon_gpio_map[] =3D {
> +	/* gpio, slice, bit_index */
> +	/* AA port */
> +	[0]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
> +	[1]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
> +	[2]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
> +	[3]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
> +	[4]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
> +	[5]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
> +	[6]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
> +	[7]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
> +	/* BB port */
> +	[8]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
> +	[9]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
> +	[10] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
> +	[11] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
> +	/* CC port */
> +	[12] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
> +	[13] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
> +	[14] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
> +	[15] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
> +	[16] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
> +	[17] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
> +	[18] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
> +	[19] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
> +	/* DD port */
> +	[20] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
> +	[21] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
> +	[22] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
> +	/* EE port */
> +	[23] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
> +	[24] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
> +	[25] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
> +	[26] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
> +	[27] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
> +	[28] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
> +	[29] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
> +	[30] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
> +	/* GG port */
> +	[31] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
> +};
> +
> +static const struct tegra_hte_line_mapped tegra234_aon_gpio_sec_map[] =
=3D {
> +	/* gpio, slice, bit_index */
> +	/* AA port */
> +	[0]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_11},
> +	[1]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_10},
> +	[2]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_9},
> +	[3]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_8},
> +	[4]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_7},
> +	[5]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_6},
> +	[6]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_5},
> +	[7]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_4},
> +	/* BB port */
> +	[8]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_3},
> +	[9]  =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_2},
> +	[10] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_1},
> +	[11] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_0},
> +	[12] =3D {NV_AON_SLICE_INVALID, 0},
> +	[13] =3D {NV_AON_SLICE_INVALID, 0},
> +	[14] =3D {NV_AON_SLICE_INVALID, 0},
> +	[15] =3D {NV_AON_SLICE_INVALID, 0},
> +	/* CC port */
> +	[16] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_22},
> +	[17] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_21},
> +	[18] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_20},
> +	[19] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_19},
> +	[20] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_18},
> +	[21] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_17},
> +	[22] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_16},
> +	[23] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_15},
> +	/* DD port */
> +	[24] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_14},
> +	[25] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_13},
> +	[26] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_12},
> +	[27] =3D {NV_AON_SLICE_INVALID, 0},
> +	[28] =3D {NV_AON_SLICE_INVALID, 0},
> +	[29] =3D {NV_AON_SLICE_INVALID, 0},
> +	[30] =3D {NV_AON_SLICE_INVALID, 0},
> +	[31] =3D {NV_AON_SLICE_INVALID, 0},
> +	/* EE port */
> +	[32] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_31},
> +	[33] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_30},
> +	[34] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_29},
> +	[35] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_28},
> +	[36] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_27},
> +	[37] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_26},
> +	[38] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_25},
> +	[39] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_24},
> +	/* GG port */
> +	[40] =3D {2, NV_AON_HTE_SLICE2_IRQ_GPIO_23},
> +};
> +
> +static const struct tegra_hte_data t194_aon_hte =3D {
>  	.map_sz =3D ARRAY_SIZE(tegra194_aon_gpio_map),
>  	.map =3D tegra194_aon_gpio_map,
>  	.sec_map_sz =3D ARRAY_SIZE(tegra194_aon_gpio_sec_map),
> @@ -228,6 +325,14 @@ static const struct tegra_hte_data aon_hte =3D {
>  	.type =3D HTE_TEGRA_TYPE_GPIO,
>  };
> =20
> +static const struct tegra_hte_data t234_aon_hte =3D {
> +	.map_sz =3D ARRAY_SIZE(tegra234_aon_gpio_map),
> +	.map =3D tegra234_aon_gpio_map,
> +	.sec_map_sz =3D ARRAY_SIZE(tegra234_aon_gpio_sec_map),
> +	.sec_map =3D tegra234_aon_gpio_sec_map,
> +	.type =3D HTE_TEGRA_TYPE_GPIO,
> +};
> +
>  static const struct tegra_hte_data lic_hte =3D {
>  	.map_sz =3D 0,
>  	.map =3D NULL,
> @@ -535,7 +640,9 @@ static bool tegra_hte_match_from_linedata(const struc=
t hte_chip *chip,
> =20
>  static const struct of_device_id tegra_hte_of_match[] =3D {
>  	{ .compatible =3D "nvidia,tegra194-gte-lic", .data =3D &lic_hte},
> -	{ .compatible =3D "nvidia,tegra194-gte-aon", .data =3D &aon_hte},
> +	{ .compatible =3D "nvidia,tegra194-gte-aon", .data =3D &t194_aon_hte},
> +	{ .compatible =3D "nvidia,tegra234-gte-lic", .data =3D &lic_hte},
> +	{ .compatible =3D "nvidia,tegra234-gte-aon", .data =3D &t234_aon_hte},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tegra_hte_of_match);
> @@ -635,8 +742,17 @@ static int tegra_hte_probe(struct platform_device *p=
dev)
> =20
>  		gc->match_from_linedata =3D tegra_hte_match_from_linedata;
> =20
> -		hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> -					   tegra_get_gpiochip_from_name);
> +		if (of_device_is_compatible(dev->of_node,
> +					    "nvidia,tegra194-gte-aon"))
> +			hte_dev->c =3D gpiochip_find("tegra194-gpio-aon",
> +						tegra_get_gpiochip_from_name);
> +		else if (of_device_is_compatible(dev->of_node,
> +						 "nvidia,tegra234-gte-aon"))
> +			hte_dev->c =3D gpiochip_find("tegra234-gpio-aon",
> +						tegra_get_gpiochip_from_name);
> +		else
> +			return -ENODEV;

I'm wondering: instead of doing this cumbersome lookup, perhaps it would
be easier to create a direct link to the right GPIO controller with a
phandle?

Thierry

--dyfI+VVQf83HGbpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNucfYACgkQ3SOs138+
s6HrSQ/+MdLNVwtKRzyACdsByavI0GX3zfBSNTl+UKVriDgHS9qLtb3hARiAzaCp
XI68gQKZTJZ5VvKomZWLNwO4GGglOnmd7efHjYSA3ddEGulP/6jRAd3zoLJclG+6
cmd/eAsiXQELX35Zs2pkVWZb9Yor13ZldF+29R9QxtzC49v7rU0uJMctEMkuq0/R
p4oducDhbsAIgPT+PqPMfUIzYuOvTdHpokNZn9J0nhZzYPqOiuztDTIVjtv0MI9c
7kkP1Ar7oyoMshMwOQz4rmTMTNn/nQFRcpS9ur6iRCtNbxrLxwDiBMqYLARfAPUM
j4O0vKR6dlMuhJSTiSGbnfY3paWLaS9y1/InCkNAJ0wUsry+CbyNts0qv+A7aqec
djbmkPGYKFdjqdwvtuYR41My+M0wBN/AzEuCNIgeWL+IP6HGu7fDz0q+DFdDLfAn
sNisK9k9SgKghX1IFw00nQLF6CEbMxz5a2ovJCB1Zce0QrbBAL94M92K3JXFTFDF
75rBD8Ylw3RKFyZRqnCbwB6s4f9i0/ukK/mg3qmRwkCvaFvRTHJ36nTQZEksoFl3
iOwUuXdkTFSJcvVQRD8HVuoSTj0Xbhpx0Byk+S5exP1UsD3L6nKFK9/tVKDth1Tn
pmF9BFS+tGyqWJdPTf9kVdSdOZcdswpLkLooNHnODAN9r1Pxp3Y=
=sSlo
-----END PGP SIGNATURE-----

--dyfI+VVQf83HGbpw--
