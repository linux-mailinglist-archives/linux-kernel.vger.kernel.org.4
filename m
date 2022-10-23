Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E887609471
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJWPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJWPfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:35:14 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBEF2981A;
        Sun, 23 Oct 2022 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666539308; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Jivb1GiQTg1GHvq4OafqU6HklinZswkG0b9+Dw4jUE=;
        b=docbR5fulR37C2JGn19iGiT1TTFB+mYm/hUHmQcpCCBrGaca14OXqakZy6A4XXdjD1hHdo
        Z4tagc8Wc2eaN/8CbgT1dAwRasc4KU206jut7Jl7cASXWtGdNwZMIVf+LyLs9qsIVxtO8a
        85YdU59VvVGcleVM0KisUCiiDEFsCpI=
Date:   Sun, 23 Oct 2022 16:34:58 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 5/5] clk: ingenic: Add X1000 audio clocks
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <AYP7KR.ZQW0GW51WJAG@crapouillou.net>
In-Reply-To: <20221023145653.177234-6-aidanmacdonald.0x0@gmail.com>
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
        <20221023145653.177234-6-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le dim. 23 oct. 2022 =E0 15:56:53 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The X1000's CGU supplies the I2S system clock to the AIC module
> and ultimately the audio codec, represented by the "i2s" clock.
> It is a simple mux which can either pass through EXCLK or a PLL
> multiplied by a fractional divider (the "i2s_pll" clock).
>=20
> The AIC contains a separate 1/N divider controlled by the I2S
> driver, which generates the bit clock from the system clock.
> The frame clock is always fixed to 1/64th of the bit clock.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/clk/ingenic/x1000-cgu.c | 69=20
> +++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/drivers/clk/ingenic/x1000-cgu.c=20
> b/drivers/clk/ingenic/x1000-cgu.c
> index b2ce3fb83f54..341276e5e1ef 100644
> --- a/drivers/clk/ingenic/x1000-cgu.c
> +++ b/drivers/clk/ingenic/x1000-cgu.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/rational.h>
>=20
>  #include <dt-bindings/clock/ingenic,x1000-cgu.h>
>=20
> @@ -168,6 +169,37 @@ static const struct clk_ops x1000_otg_phy_ops =3D {
>  	.is_enabled	=3D x1000_usb_phy_is_enabled,
>  };
>=20
> +static void
> +x1000_i2spll_calc_m_n_od(const struct ingenic_cgu_pll_info *pll_info,
> +			 unsigned long rate, unsigned long parent_rate,
> +			 unsigned int *pm, unsigned int *pn, unsigned int *pod)
> +{
> +	const unsigned long m_max =3D GENMASK(pll_info->m_bits - 1, 0);
> +	const unsigned long n_max =3D GENMASK(pll_info->n_bits - 1, 0);
> +	unsigned long m, n;
> +
> +	rational_best_approximation(rate, parent_rate, m_max, n_max, &m,=20
> &n);
> +
> +	/* n should not be less than 2*m */
> +	if (n < 2 * m)
> +		n =3D 2 * m;
> +
> +	*pm =3D m;
> +	*pn =3D n;
> +	*pod =3D 1;
> +}
> +
> +static void
> +x1000_i2spll_set_rate_hook(const struct ingenic_cgu_pll_info=20
> *pll_info,
> +			   unsigned long rate, unsigned long parent_rate)
> +{
> +	/*
> +	 * For some reason, the I2S divider doesn't work properly after
> +	 * updating I2SCDR unless I2SCDR1 is read & written back.
> +	 */
> +	writel(readl(cgu->base + CGU_REG_I2SCDR1), cgu->base +=20
> CGU_REG_I2SCDR1);

Not fond of the nesting here, just use a variable.

Besides... According to the documentation, bits 31 and 30 of this=20
register are misconnected: writing to bit 31 will be reflected in bit=20
30, and vice-versa. So this would work only if the bits 30 and 31 have=20
the same value.

And worse than that, where do you actually set the register's value?=20
Because bits 30/31, if cleared, will automatically compute the M/N=20
values to the I2SCDR fields, overriding what the driver's .set_rate()=20
callback is doing.

Either we want that, and in that case the I2S clock should be a custom=20
clock (since it wouldn't need to compute or write M/N), or we don't,=20
and in this case bits 30/31 of this register should be set.

> +}
> +
>  static const s8 pll_od_encoding[8] =3D {
>  	0x0, 0x1, -1, 0x2, -1, -1, -1, 0x3,
>  };
> @@ -319,6 +351,37 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>  		.gate =3D { CGU_REG_CLKGR, 25 },
>  	},
>=20
> +	[X1000_CLK_I2SPLLMUX] =3D {
> +		"i2s_pll_mux", CGU_CLK_MUX,
> +		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },

If you have only 1 bit you can only have two parents, so you can remove=20
the -1s.

> +		.mux =3D { CGU_REG_I2SCDR, 31, 1 },
> +	},
> +
> +	[X1000_CLK_I2SPLL] =3D {
> +		"i2s_pll", CGU_CLK_PLL,
> +		.parents =3D { X1000_CLK_I2SPLLMUX, -1, -1, -1 },

.parents =3D { X1000_CLK_I2SPLLMUX, },

> +		.pll =3D {
> +			.reg =3D CGU_REG_I2SCDR,
> +			.rate_multiplier =3D 1,
> +			.m_shift =3D 13,
> +			.m_bits =3D 9,
> +			.n_shift =3D 0,
> +			.n_bits =3D 13,
> +			.calc_m_n_od =3D x1000_i2spll_calc_m_n_od,
> +			.set_rate_hook =3D x1000_i2spll_set_rate_hook,
> +		},
> +	},
> +
> +	[X1000_CLK_I2S] =3D {
> +		"i2s", CGU_CLK_MUX,
> +		.parents =3D { X1000_CLK_EXCLK, -1, -1, X1000_CLK_I2SPLL },
> +		/*
> +		 * NOTE: the mux is at bit 30; bit 29 enables the M/N divider.
> +		 * Therefore, the divider is disabled when EXCLK is selected.
> +		 */
> +		.mux =3D { CGU_REG_I2SCDR, 29, 2 },
> +	},
> +
>  	[X1000_CLK_LCD] =3D {
>  		"lcd", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
>  		.parents =3D { X1000_CLK_SCLKA, X1000_CLK_MPLL },
> @@ -426,6 +489,12 @@ static const struct ingenic_cgu_clk_info=20
> x1000_cgu_clocks[] =3D {
>  		.gate =3D { CGU_REG_CLKGR, 9 },
>  	},
>=20
> +	[X1000_CLK_AIC] =3D {
> +		"aic", CGU_CLK_GATE,
> +		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },

.parents =3D { X1000_CLK_EXCLK, },

Cheers,
-Paul

> +		.gate =3D { CGU_REG_CLKGR, 11 },
> +	},
> +
>  	[X1000_CLK_UART0] =3D {
>  		"uart0", CGU_CLK_GATE,
>  		.parents =3D { X1000_CLK_EXCLK, -1, -1, -1 },
> --
> 2.38.1
>=20


