Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5A60F79E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiJ0Mks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiJ0Mkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:40:37 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427E4054A;
        Thu, 27 Oct 2022 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666874428; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YOr1T8oUsQJZkpF+Sk2DjoRqQo5I98igHbDnsfrbCqo=;
        b=nR+TbAS6AHbixwsYdua78ljTgzQOFLJ8e15C2xlmY68dyuW7WWYWy25XNK2jU2/j2wAvEC
        cknQK9IcRfhbYjYunFKr6me4iMmzLPIUcFjTo9vMnowF3flgDTnQPQfHsFxMWz51BBhNR7
        QK6mlOmrohS0wIqYTiXqz+7NS4ntwRI=
Date:   Thu, 27 Oct 2022 13:40:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 3/6] clk: ingenic: Add .set_rate_hook() for PLL clocks
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, zhouyu@wanyeetech.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5JWEKR.5UVVAJI6C2MK@crapouillou.net>
In-Reply-To: <20221026194345.243007-4-aidanmacdonald.0x0@gmail.com>
References: <20221026194345.243007-1-aidanmacdonald.0x0@gmail.com>
        <20221026194345.243007-4-aidanmacdonald.0x0@gmail.com>
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

Le mer. 26 oct. 2022 =E0 20:43:42 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> The set rate hook is called immediately after updating the clock
> register but before the spinlock is released. This allows another
> register to be updated alongside the main one, which is needed to
> handle the I2S divider on some SoCs.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/cgu.c | 3 +++
>  drivers/clk/ingenic/cgu.h | 4 ++++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
> index aea01b6b2764..b6a4d4236c16 100644
> --- a/drivers/clk/ingenic/cgu.c
> +++ b/drivers/clk/ingenic/cgu.c
> @@ -232,6 +232,9 @@ ingenic_pll_set_rate(struct clk_hw *hw, unsigned=20
> long req_rate,
>=20
>  	writel(ctl, cgu->base + pll_info->reg);
>=20
> +	if (pll_info->set_rate_hook)
> +		pll_info->set_rate_hook(pll_info, rate, parent_rate);
> +
>  	/* If the PLL is enabled, verify that it's stable */
>  	if (pll_info->enable_bit >=3D 0 && (ctl & BIT(pll_info->enable_bit)))
>  		ret =3D ingenic_pll_check_stable(cgu, pll_info);
> diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
> index a5e44ca7f969..99da9bd86e63 100644
> --- a/drivers/clk/ingenic/cgu.h
> +++ b/drivers/clk/ingenic/cgu.h
> @@ -46,6 +46,8 @@
>   *		-1 if there is no enable bit (ie, the PLL is always on)
>   * @stable_bit: the index of the stable bit in the PLL control=20
> register, or
>   *		-1 if there is no stable bit
> + * @set_rate_hook: hook called immediately after updating the CGU=20
> register,
> + *		   before releasing the spinlock
>   */
>  struct ingenic_cgu_pll_info {
>  	unsigned reg;
> @@ -61,6 +63,8 @@ struct ingenic_cgu_pll_info {
>  	void (*calc_m_n_od)(const struct ingenic_cgu_pll_info *pll_info,
>  			    unsigned long rate, unsigned long parent_rate,
>  			    unsigned int *m, unsigned int *n, unsigned int *od);
> +	void (*set_rate_hook)(const struct ingenic_cgu_pll_info *pll_info,
> +			      unsigned long rate, unsigned long parent_rate);
>  };
>=20
>  /**
> --
> 2.38.1
>=20


