Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744BD60F789
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiJ0Mij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiJ0Mih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:38:37 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C815CB26;
        Thu, 27 Oct 2022 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666874314; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWrIFI7ge6bO/Ji1tjywa7ZOL5L27qwMjMguyEcsJ1c=;
        b=p645aQ7oOBvLNpF3dsWu9LnYa7CD2QStwmz20Eh0Q3zCycirLk1g312XMOhWpF/Oi1Zmh7
        CtPhyO8ez1ROeZFe5wt1bP8qozkmPJPPE1JmUZOzX8vTRsG8A0B1KuaCyRnX5PyqrDSZZ2
        GKRmabSwhIQY0mlRXmq5Lt6o9JwjYUc=
Date:   Thu, 27 Oct 2022 13:38:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/6] clk: ingenic: Make PLL clock "od" field optional
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <0GWEKR.T961XCYIYOL52@crapouillou.net>
In-Reply-To: <20221026194345.243007-2-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
        <20221026194345.243007-2-aidanmacdonald.0x0@gmail.com>
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

Le mer. 26 oct. 2022 =E0 20:43:40 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Add support for defining PLL clocks with od_bits =3D 0, meaning that
> OD is fixed to 1 and there is no OD field in the register. In this
> case od_max must also be 0, which is enforced with BUG_ON().
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v1 -> v2: Simplify od lookup in ingenic_pll_recalc_rate() and
>           enforce od_max =3D=3D 0 when od_bits is zero.
>=20
>  drivers/clk/ingenic/cgu.c | 21 +++++++++++++++------
>  drivers/clk/ingenic/cgu.h |  3 ++-
>  2 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 861c50d6cb24..3481129114b1 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -83,7 +83,7 @@ ingenic_pll_recalc_rate(struct clk_hw *hw, unsigned=20
> long parent_rate)
>  	const struct ingenic_cgu_clk_info *clk_info =3D=20
> to_clk_info(ingenic_clk);
>  	struct ingenic_cgu *cgu =3D ingenic_clk->cgu;
>  	const struct ingenic_cgu_pll_info *pll_info;
> -	unsigned m, n, od_enc, od;
> +	unsigned m, n, od, od_enc =3D 0;
>  	bool bypass;
>  	u32 ctl;
>=20
> @@ -96,8 +96,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw,=20
> unsigned long parent_rate)
>  	m +=3D pll_info->m_offset;
>  	n =3D (ctl >> pll_info->n_shift) & GENMASK(pll_info->n_bits - 1, 0);
>  	n +=3D pll_info->n_offset;
> -	od_enc =3D ctl >> pll_info->od_shift;
> -	od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
> +
> +	if (pll_info->od_bits > 0) {
> +		od_enc =3D ctl >> pll_info->od_shift;
> +		od_enc &=3D GENMASK(pll_info->od_bits - 1, 0);
> +	}
>=20
>  	if (pll_info->bypass_bit >=3D 0) {
>  		ctl =3D readl(cgu->base + pll_info->bypass_reg);
> @@ -112,7 +115,11 @@ ingenic_pll_recalc_rate(struct clk_hw *hw,=20
> unsigned long parent_rate)
>  		if (pll_info->od_encoding[od] =3D=3D od_enc)
>  			break;
>  	}

I'd add a space there.

With that:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

> -	BUG_ON(od =3D=3D pll_info->od_max);
> +	/* if od_max =3D 0, od_bits should be 0 and od is fixed to 1. */
> +	if (pll_info->od_max =3D=3D 0)
> +		BUG_ON(pll_info->od_bits !=3D 0);

I don't think this first BUG_ON() is needed, if we do a good job=20
reviewing patches. But I don't care enough to ask you to remove it.

Cheers,
-Paul

> +	else
> +		BUG_ON(od =3D=3D pll_info->od_max);
>  	od++;
>=20
>  	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
> @@ -215,8 +222,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned=20
> long req_rate,
>  	ctl &=3D ~(GENMASK(pll_info->n_bits - 1, 0) << pll_info->n_shift);
>  	ctl |=3D (n - pll_info->n_offset) << pll_info->n_shift;
>=20
> -	ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
> -	ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
> +	if (pll_info->od_bits > 0) {
> +		ctl &=3D ~(GENMASK(pll_info->od_bits - 1, 0) << pll_info->od_shift);
> +		ctl |=3D pll_info->od_encoding[od - 1] << pll_info->od_shift;
> +	}
>=20
>  	writel(ctl, cgu->base + pll_info->reg);
>=20
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> index 147b7df0d657..567142b584bb 100644
> --- a/drivers/clk/ingenic/cgu.h
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -33,7 +33,8 @@
>   * @od_shift: the number of bits to shift the post-VCO divider value=20
> by (ie.
>   *            the index of the lowest bit of the post-VCO divider=20
> value in
>   *            the PLL's control register)
> - * @od_bits: the size of the post-VCO divider field in bits
> + * @od_bits: the size of the post-VCO divider field in bits, or 0 if=20
> no
> + *	     OD field exists (then the OD is fixed to 1)
>   * @od_max: the maximum post-VCO divider value
>   * @od_encoding: a pointer to an array mapping post-VCO divider=20
> values to
>   *               their encoded values in the PLL control register,=20
> or -1 for
> --
> 2.38.1
>=20


