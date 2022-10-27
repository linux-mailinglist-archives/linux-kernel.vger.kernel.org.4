Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16360F78E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbiJ0Mjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbiJ0Mjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:39:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB290B96;
        Thu, 27 Oct 2022 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666874367; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WR5K0m6TzrIk+W7bMl6dNmiiAvPAp408dGMPPaArrQ4=;
        b=nCtlFDdVeFO7zDJ33FvNXl/SeHA+vzg3q8v4tMaIzA0qh1fmwQXdG+9Ip4hWy/IwX2H7Np
        gZDJS2HZOI/KAnodi0vTEvu+NMGNpj1N8pAipg4/xKsL8zmQnnCZj3426k/7XZ9Y3LkQqV
        R9FHbE7biQjHE3pggpUJ/YzilsgWKms=
Date:   Thu, 27 Oct 2022 13:39:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 2/6] clk: ingenic: Make PLL clock enable_bit and
 stable_bit optional
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <HHWEKR.W3ZGGGZ709H01@crapouillou.net>
In-Reply-To: <20221026194345.243007-3-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
        <20221026194345.243007-3-aidanmacdonald.0x0@gmail.com>
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

Le mer. 26 oct. 2022 =E0 20:43:41 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> When the enable bit is undefined, the clock is assumed to be always
> on and enable/disable is a no-op. When the stable bit is undefined,
> the PLL stable check is a no-op.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/cgu.c | 14 +++++++++++++-
>  drivers/clk/ingenic/cgu.h | 10 ++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index 3481129114b1..aea01b6b2764 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -189,6 +189,9 @@ static inline int ingenic_pll_check_stable(struct=20
> ingenic_cgu *cgu,
>  {
>  	u32 ctl;
>=20
> +	if (pll_info->stable_bit < 0)
> +		return 0;
> +
>  	return readl_poll_timeout(cgu->base + pll_info->reg, ctl,
>  				  ctl & BIT(pll_info->stable_bit),
>  				  0, 100 * USEC_PER_MSEC);
> @@ -230,7 +233,7 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned=20
> long req_rate,
>  	writel(ctl, cgu->base + pll_info->reg);
>=20
>  	/* If the PLL is enabled, verify that it's stable */
> -	if (ctl & BIT(pll_info->enable_bit))
> +	if (pll_info->enable_bit >=3D 0 && (ctl & BIT(pll_info->enable_bit)))
>  		ret =3D ingenic_pll_check_stable(cgu, pll_info);
>=20
>  	spin_unlock_irqrestore(&cgu->lock, flags);
> @@ -248,6 +251,9 @@ static int ingenic_pll_enable(struct clk_hw *hw)
>  	int ret;
>  	u32 ctl;
>=20
> +	if (pll_info->enable_bit < 0)
> +		return 0;
> +
>  	spin_lock_irqsave(&cgu->lock, flags);
>  	if (pll_info->bypass_bit >=3D 0) {
>  		ctl =3D readl(cgu->base + pll_info->bypass_reg);
> @@ -278,6 +284,9 @@ static void ingenic_pll_disable(struct clk_hw *hw)
>  	unsigned long flags;
>  	u32 ctl;
>=20
> +	if (pll_info->enable_bit < 0)
> +		return;
> +
>  	spin_lock_irqsave(&cgu->lock, flags);
>  	ctl =3D readl(cgu->base + pll_info->reg);
>=20
> @@ -295,6 +304,9 @@ static int ingenic_pll_is_enabled(struct clk_hw=20
> *hw)
>  	const struct ingenic_cgu_pll_info *pll_info =3D &clk_info->pll;
>  	u32 ctl;
>=20
> +	if (pll_info->enable_bit < 0)
> +		return true;
> +
>  	ctl =3D readl(cgu->base + pll_info->reg);
>=20
>  	return !!(ctl & BIT(pll_info->enable_bit));
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> index 567142b584bb..a5e44ca7f969 100644
> --- a/drivers/clk/ingenic/cgu.h
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -42,8 +42,10 @@
>   * @bypass_reg: the offset of the bypass control register within the=20
> CGU
>   * @bypass_bit: the index of the bypass bit in the PLL control=20
> register, or
>   *              -1 if there is no bypass bit
> - * @enable_bit: the index of the enable bit in the PLL control=20
> register
> - * @stable_bit: the index of the stable bit in the PLL control=20
> register
> + * @enable_bit: the index of the enable bit in the PLL control=20
> register, or
> + *		-1 if there is no enable bit (ie, the PLL is always on)
> + * @stable_bit: the index of the stable bit in the PLL control=20
> register, or
> + *		-1 if there is no stable bit
>   */
>  struct ingenic_cgu_pll_info {
>  	unsigned reg;
> @@ -54,8 +56,8 @@ struct ingenic_cgu_pll_info {
>  	u8 od_shift, od_bits, od_max;
>  	unsigned bypass_reg;
>  	s8 bypass_bit;
> -	u8 enable_bit;
> -	u8 stable_bit;
> +	s8 enable_bit;
> +	s8 stable_bit;
>  	void (*calc_m_n_od)(const struct ingenic_cgu_pll_info *pll_info,
>  			    unsigned long rate, unsigned long parent_rate,
>  			    unsigned int *m, unsigned int *n, unsigned int *od);
> --
> 2.38.1
>=20


