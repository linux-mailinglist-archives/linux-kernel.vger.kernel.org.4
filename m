Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D869CA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBTLly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBTLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:41:53 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925781040A;
        Mon, 20 Feb 2023 03:41:50 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8CE3C20003;
        Mon, 20 Feb 2023 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676893308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jY7+m1T4iK7eneAS7by4Sgyb4VAUahP14Dhi2ddZYA4=;
        b=FCFNl1vpj7/nLGwcGSnwVMPbgC+DNQp1hpgREPU1kVSgBRRIWCE937LK3HswkU3HIhXsnb
        faOtZ0WhnqilEsk+CUkssYuqRk02Ki3Q+4paMPjgGIgmwwBeLJgmZ+97UOmaVd19QvBlCt
        9pQiTEBXIzgv9uaQ6zYeAU6HKuc9Zp5xc79KwsT7DMJfxQrvgrygT3knpG2Q2dPU9Qzi1v
        P36VxLAx5cCk88bubNCDY8p92vgVS4CYyhxwLlwBvBZvTEVB1DxH/eDYtqsw0AsFcA2XnI
        ma3lTVVDY7GHJzjFmLr2t9xV473wjsjsYXdxU/2kQmzqbGn7rz1KJGtXeOhh+A==
Date:   Mon, 20 Feb 2023 12:44:20 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: add missing of_node_put() in "assigned-clocks"
 property parsing
Message-ID: <20230220124420.4150c767@fixe.home>
In-Reply-To: <20230131083227.10990-1-clement.leger@bootlin.com>
References: <20230131083227.10990-1-clement.leger@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, 31 Jan 2023 09:32:27 +0100,
Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com> a =C3=A9crit :

Ping ?

> When returning from of_parse_phandle_with_args(), the np member of the
> of_phandle_args structure should be put after usage. Add missing
> of_node_put() calls in both __set_clk_parents() and __set_clk_rates().
>=20
> Fixes: 86be408bfbd8 ("clk: Support for clock parents and rates assigned f=
rom device tree")
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
> v2:
>  - Add "Fixes"
>=20
>  drivers/clk/clk-conf.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
> index 2ef819606c41..1a4e6340f95c 100644
> --- a/drivers/clk/clk-conf.c
> +++ b/drivers/clk/clk-conf.c
> @@ -33,9 +33,12 @@ static int __set_clk_parents(struct device_node *node,=
 bool clk_supplier)
>  			else
>  				return rc;
>  		}
> -		if (clkspec.np =3D=3D node && !clk_supplier)
> +		if (clkspec.np =3D=3D node && !clk_supplier) {
> +			of_node_put(clkspec.np);
>  			return 0;
> +		}
>  		pclk =3D of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
>  		if (IS_ERR(pclk)) {
>  			if (PTR_ERR(pclk) !=3D -EPROBE_DEFER)
>  				pr_warn("clk: couldn't get parent clock %d for %pOF\n",
> @@ -48,10 +51,12 @@ static int __set_clk_parents(struct device_node *node=
, bool clk_supplier)
>  		if (rc < 0)
>  			goto err;
>  		if (clkspec.np =3D=3D node && !clk_supplier) {
> +			of_node_put(clkspec.np);
>  			rc =3D 0;
>  			goto err;
>  		}
>  		clk =3D of_clk_get_from_provider(&clkspec);
> +		of_node_put(clkspec.np);
>  		if (IS_ERR(clk)) {
>  			if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
>  				pr_warn("clk: couldn't get assigned clock %d for %pOF\n",
> @@ -93,10 +98,13 @@ static int __set_clk_rates(struct device_node *node, =
bool clk_supplier)
>  				else
>  					return rc;
>  			}
> -			if (clkspec.np =3D=3D node && !clk_supplier)
> +			if (clkspec.np =3D=3D node && !clk_supplier) {
> +				of_node_put(clkspec.np);
>  				return 0;
> +			}
> =20
>  			clk =3D of_clk_get_from_provider(&clkspec);
> +			of_node_put(clkspec.np);
>  			if (IS_ERR(clk)) {
>  				if (PTR_ERR(clk) !=3D -EPROBE_DEFER)
>  					pr_warn("clk: couldn't get clock %d for %pOF\n",



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
