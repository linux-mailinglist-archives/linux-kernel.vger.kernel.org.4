Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E7750BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjGLPGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjGLPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:05:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2051FEB;
        Wed, 12 Jul 2023 08:05:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9922d6f003cso907018866b.0;
        Wed, 12 Jul 2023 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689174344; x=1691766344;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkzw4GavT9IB1qJxaGP7vKRQ5uqEjDFaYd3YZ2i6avs=;
        b=AA3fm16xA3q1uXwhEwqSLYk3iWw3+FCXqNn+OSJJWck+of8fm1LNFggo9fWLpdhnja
         sErNNC6EIhtNHbaFuFZ6tzSUENORo8G8iMpEf5XPRYP5S8rvX4jTIHtsFWSpUKU5u35E
         8mWjp4/XbfReIpgSkh8WPVoYPtXt8xiN5UUXjbM01yZphWtwgFZSsYNGDvai6yMuvc0v
         ZJNnjo2CsEa4SHZvjBmMrgyraPgiqBYYsYedmeDQt0hTKCjRtuZgY1LeFPRcndcbE+8h
         LBwnDoMWnMWlLwhTD6qYcdza6MGPzmwHztEN8v20N6jtw05fxMbwwY66RGreqz4G186Z
         iWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174344; x=1691766344;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkzw4GavT9IB1qJxaGP7vKRQ5uqEjDFaYd3YZ2i6avs=;
        b=BMCpIb5qQhby3GmG1InA3hqQt5I6P736ocgo+UsHJquOjU3xMZdO/azYayYo/L0QHS
         1FMHz3JHuSAS1ClOD5iUD4RkQnwt3BgBzwT3oy2FCg2otosozHbfvgD4aQ3KDLx5VQgk
         VEdjnpsjIY3ksAVUI11iVCSrlzEtFx0VBbUka7xAWtZ6jFLWtSaCUMu9LUUUrae9Vly/
         YXTCjtLHKz3Q+LfFC2AEbPzouZ6Te4SWM2OFXL6bJjeVt+t9v2loYbMmeLt0CwgxiXKj
         d1fAqQSwH1dvZfK9ayiGEGiw/KAgwHXRPwihK76DzUtHpPz+hqztCYxIvzHQiBV7koUT
         NICA==
X-Gm-Message-State: ABy/qLbX+U5jRtE1jCwWoOyPvjTxZoDtNm+rueLZrkxf3S5fMqu1dxN2
        KDIcH/ANOLUyAvsmGujpE+s=
X-Google-Smtp-Source: APBJJlHg/Cz7FE5jOOJFTlHwoesfOpZ4gi/DZs4K5U557nkB8qnV4ZklPJ+8wh7lYbv+jpeYDhEIyQ==
X-Received: by 2002:a17:907:1dc7:b0:98c:2b5c:429b with SMTP id og7-20020a1709071dc700b0098c2b5c429bmr17795695ejc.57.1689174343872;
        Wed, 12 Jul 2023 08:05:43 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id le12-20020a170906ae0c00b009829d2e892csm2742960ejb.15.2023.07.12.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:05:43 -0700 (PDT)
Date:   Wed, 12 Jul 2023 17:05:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, jonathanh@nvidia.com,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: tegra: Add support to display pin function
Message-ID: <ZK7BRXa9geC8SAGs@orome>
References: <20230712135553.25162-1-pshete@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2YdKNK7uOPK99Kng"
Content-Disposition: inline
In-Reply-To: <20230712135553.25162-1-pshete@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2YdKNK7uOPK99Kng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 07:25:53PM +0530, Prathamesh Shete wrote:
> The current function for a given pin is not displayed via the debugfs.
> Add support to display the current function that is set for each pin.
>=20
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/pinctrl/tegra/pinctrl-tegra.c | 19 +++++++++++++++++--
>  drivers/pinctrl/tegra/pinctrl-tegra.h |  2 ++
>  2 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegr=
a/pinctrl-tegra.c
> index 4547cf66d03b..2752c914f628 100644
> --- a/drivers/pinctrl/tegra/pinctrl-tegra.c
> +++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
> @@ -96,6 +96,7 @@ static const struct cfg_param {
>  	{"nvidia,slew-rate-falling",	TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING},
>  	{"nvidia,slew-rate-rising",	TEGRA_PINCONF_PARAM_SLEW_RATE_RISING},
>  	{"nvidia,drive-type",		TEGRA_PINCONF_PARAM_DRIVE_TYPE},
> +	{"nvidia,func",			TEGRA_PINCONF_PARAM_FUNCTION},

Device tree bindings define the "nvidia,function" property to contain
this information, so shouldn't we use the same name here?

Thierry

--2YdKNK7uOPK99Kng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSuwUMACgkQ3SOs138+
s6FQDRAAoK6Esw601lrSBOA9hLHuIBHRbnjQMnKgSZdA8eiMozPTc/zNQE7y48NV
coFrEGg5SIjmKMxcOIFsifB2VEtBd6R4CgHgvT4LD4IxMar6YhHtBW9uvpzQK4aV
0dgdW4SaFT3nxZDvCQEttCA7a0AzvMMhx/3sWcWPpFKx7ciSNGI+cFoeEQ53eQmC
6rzDpQvG6Wbyb8lypcCXBNyouuHTlpG6wINNpXqsZQGwsDLPRyeTTNTtXFi+ptzV
AM/5kgeNB3Svc7zFvMdvgU0kSux+gp6vziK8qEVeHx9eefGjWxYihMMAXWFHOl2f
Iy21wcyL3o4NK2Send2HJ/iSovJmhzAa1wgkrbYyB62kczl3HhkvAkbukRCv1WMG
zCKoDuyb1u58cDIJ71HQPfOY9ghRWUEUpKb8epwLSMSwOb23TxxjHENTqkiKqVt7
iXoulIqmAoQnVl7WtcD7d8o7ZYcd4kgeqMqjVgz9qJB5rh56IqxR7/a/CTuUGrhW
2/BtfxvKPpAMaa8IrRx1A9JH1fR5SDTN8sdbSMgfQm0tcQncT7ORh8YEtT7i/coO
XV0jqXJXm8l+kHXwgzKm0k1TK52mZjxHam4UgbVfqDm/8dsxrJJHuphnWrEcNHIZ
ToTIa5ulqz1RikLBCfPaH4GwZ6N9imejuFXwNg+cq294c1IbRT4=
=DFoZ
-----END PGP SIGNATURE-----

--2YdKNK7uOPK99Kng--
