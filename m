Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70715609453
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiJWPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJWPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:21:05 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7010D69F65;
        Sun, 23 Oct 2022 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666538463; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3op+VX3yYK2/2LlXgjQoOdhDpt/JM+p44pBcPSyInw=;
        b=uKGOfoF9M7JHALdbD2VAd8XVJOKEIaGHFx+NWCcfcaIiQC9DkRUXI17tgq3h3R8ROMrmGh
        tcHFgh/eD2xCcM8phwIel8tfFll9rrTeVuxc7Y7PorLTCUcpNOFh09O4UUwqEgbmjDW8ch
        QdO3Rn7bXqM+ij+8lafDmrGP17oPdf8=
Date:   Sun, 23 Oct 2022 16:20:53 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/5] clk: ingenic: Make PLL clock "od" field optional
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <TAP7KR.18SEZOBW3THM2@crapouillou.net>
In-Reply-To: <20221023145653.177234-2-aidanmacdonald.0x0@gmail.com>
References: <20221023145653.177234-1-aidanmacdonald.0x0@gmail.com>
        <20221023145653.177234-2-aidanmacdonald.0x0@gmail.com>
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

Le dim. 23 oct. 2022 =E0 15:56:49 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> Add support for defining PLL clocks with od_bits =3D 0, meaning that
> OD is fixed to 1 and there is no OD field in the register.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/clk/ingenic/cgu.c | 28 +++++++++++++++++++---------
>  drivers/clk/ingenic/cgu.h |  3 ++-
>  2 files changed, 21 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 861c50d6cb24..7dc2e2567d53 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
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
> @@ -108,12 +111,17 @@ ingenic_pll_recalc_rate(struct clk_hw *hw,=20
> unsigned long parent_rate)
>  			return parent_rate;
>  	}
>=20
> -	for (od =3D 0; od < pll_info->od_max; od++) {
> -		if (pll_info->od_encoding[od] =3D=3D od_enc)
> -			break;
> +	if (pll_info->od_bits > 0) {
> +		for (od =3D 0; od < pll_info->od_max; od++) {
> +			if (pll_info->od_encoding[od] =3D=3D od_enc)
> +				break;
> +		}
> +		BUG_ON(od =3D=3D pll_info->od_max);
> +		od++;
> +	} else {
> +		/* OD is fixed to 1 if no OD field is present. */
> +		od =3D 1;
>  	}
> -	BUG_ON(od =3D=3D pll_info->od_max);
> -	od++;

I think if pll_info->od_max is 0 you get the same result without=20
modifying this code. You just need to modify the BUG_ON() to only=20
trigger if pll_info->od_max > 0.

Cheers,
-Paul

>=20
>  	return div_u64((u64)parent_rate * m * pll_info->rate_multiplier,
>  		n * od);
> @@ -215,8 +223,10 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned=20
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


