Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D96687FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbjALXxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237200AbjALXxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:53:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BEF5D434;
        Thu, 12 Jan 2023 15:53:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E65B815FA;
        Thu, 12 Jan 2023 23:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896BFC433D2;
        Thu, 12 Jan 2023 23:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673567612;
        bh=ZI8k44b6vA0SNkTgF4tI5V/ADqEolyTUYI+fC7Jcmuk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bpPiJb+W7TpzDtyjBnxkj1daJPsx7uAMQYHUfHl+VNmwj8n9SoK+Aoa34w4pzGfqh
         5ijDvKjhgSR+w5PBLWE76vHYz9VxrtxxdBqUZojX8vDm+7JQLk/o+WV9FsYhJVNyQ6
         ho1KxPKUo0AuJfWZsSlU9vPcwmB9Yia+N6v8E+U5eBIzB83wmVFiQYVUfo6qCpEFcF
         zj5I8JUhcnZm2oS61f/FXmqFC0i1l1EmU3Z1ULZDGKVPtqKw1mwuWdEYzXjxsnT6i5
         170rn4nJo9dp72OiV8/ZvyaSLZ+oP60LXedAfBWMR7AnZtdphYGzMh32XdfMxCZT8y
         gvjodiJH8t88Q==
Message-ID: <fd150fa2b35e1e07808e3d1e67e1def7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221227132507.2506-1-quic_kathirav@quicinc.com>
References: <20221227132507.2506-1-quic_kathirav@quicinc.com>
Subject: Re: [PATCH V4] clk: qcom: clk-alpha-pll: Add support for Stromer PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        Sricharan R <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Date:   Thu, 12 Jan 2023 15:53:30 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kathiravan T (2022-12-27 05:25:07)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index f9e4cfd7261c..29866100df08 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -204,9 +204,24 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] =3D {
>                 [PLL_OFF_CONFIG_CTL] =3D 0x1C,
>                 [PLL_OFF_STATUS] =3D 0x20,
>         },
> +       [CLK_ALPHA_PLL_TYPE_STROMER] =3D {
> +               [PLL_OFF_L_VAL] =3D 0x08,
> +               [PLL_OFF_ALPHA_VAL] =3D 0x10,
> +               [PLL_OFF_ALPHA_VAL_U] =3D 0x14,
> +               [PLL_OFF_USER_CTL] =3D 0x18,
> +               [PLL_OFF_USER_CTL_U] =3D 0x1c,
> +               [PLL_OFF_CONFIG_CTL] =3D 0x20,
> +               [PLL_OFF_CONFIG_CTL_U] =3D 0xff,
> +               [PLL_OFF_TEST_CTL] =3D 0x30,
> +               [PLL_OFF_TEST_CTL_U] =3D 0x34,
> +               [PLL_OFF_STATUS] =3D 0x28,
> +       },
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
> =20
> +static unsigned long
> +alpha_pll_round_rate(unsigned long rate, unsigned long prate, u32 *l, u6=
4 *a,

Is this necessary?

> +                    u32 alpha_width);
>  /*
>   * Even though 40 bits are present, use only 32 for ease of calculation.
>   */
> @@ -215,6 +230,8 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  #define ALPHA_BITWIDTH         32U
>  #define ALPHA_SHIFT(w)         min(w, ALPHA_BITWIDTH)
> =20
> +#define        ALPHA_PLL_STATUS_REG_SHIFT      8
> +
>  #define PLL_HUAYRA_M_WIDTH             8
>  #define PLL_HUAYRA_M_SHIFT             8
>  #define PLL_HUAYRA_M_MASK              0xff
> @@ -325,7 +342,7 @@ static void clk_alpha_pll_write_config(struct regmap =
*regmap, unsigned int reg,
>  void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *r=
egmap,
>                              const struct alpha_pll_config *config)
>  {
> -       u32 val, mask;
> +       u32 val, val_u, mask, mask_u;
> =20
>         regmap_write(regmap, PLL_L_VAL(pll), config->l);
>         regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
> @@ -355,14 +372,85 @@ void clk_alpha_pll_configure(struct clk_alpha_pll *=
pll, struct regmap *regmap,
>         mask |=3D config->pre_div_mask;
>         mask |=3D config->post_div_mask;
>         mask |=3D config->vco_mask;
> +       mask |=3D config->alpha_en_mask;
> +       mask |=3D config->alpha_mode_mask;
> =20
>         regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
> =20
> +       /* Stromer APSS PLL does not enable LOCK_DET by default, so enabl=
e it */

Instead of adding these things to clk_alpha_pll_configure() can you
introduce another api like clk_stromer_pll_configure() that sets these
values unconditionally? That way we don't have to think or worry about
the other alpha PLLs (of which there are many).

> +       val_u =3D config->status_reg_val << ALPHA_PLL_STATUS_REG_SHIFT;
> +       val_u |=3D config->lock_det;
> +
> +       mask_u =3D config->status_reg_mask;
> +       mask_u |=3D config->lock_det;
> +
> +       if (val_u)
> +               regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, v=
al_u);
> +
> +       if (config->test_ctl_val)
> +               regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_=
val);
> +
> +       if (config->test_ctl_hi_val)
> +               regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ct=
l_hi_val);
> +
>         if (pll->flags & SUPPORTS_FSM_MODE)
>                 qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
>  }
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
> =20
> +static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
> +                                               struct clk_rate_request *=
req)
> +{
> +       u32 l;
> +       u64 a;
> +
> +       req->rate =3D alpha_pll_round_rate(req->rate, req->best_parent_ra=
te,
> +                                        &l, &a, ALPHA_REG_BITWIDTH);
> +
> +       return 0;
> +}
> +
> +static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned lo=
ng rate,
> +                                         unsigned long prate)
> +{
> +       struct clk_alpha_pll *pll =3D to_clk_alpha_pll(hw);
> +       u32 l;
> +       int ret;
> +       u64 a;
> +
> +       rate =3D alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITW=
IDTH);
> +
> +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
> +                    a >> ALPHA_BITWIDTH);
> +
> +       regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
> +                          PLL_ALPHA_EN, PLL_ALPHA_EN);
> +
> +       if (!clk_hw_is_enabled(hw))
> +               return 0;
> +
> +       /*
> +        * Stromer PLL supports Dynamic programming.
> +        * It allows the PLL frequency to be changed on-the-fly without f=
irst
> +        * execution of a shutdown procedure followed by a bring up proce=
dure.
> +        */
> +

Drop newline above please.

> +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
> +                          PLL_UPDATE);
> +
> +       ret =3D wait_for_pll_update(pll);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D wait_for_pll_enable_lock(pll);
> +       if (ret)
> +               return ret;
> +
> +       return 0;

Just use

	return wait_for_pll_enable_lock(pll);

> +}
> +
>  static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
>  {
>         int ret;
> @@ -1013,6 +1101,16 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops =3D {
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
> =20
> +const struct clk_ops clk_alpha_pll_stromer_ops =3D {
> +       .enable =3D clk_alpha_pll_enable,
> +       .disable =3D clk_alpha_pll_disable,
> +       .is_enabled =3D clk_alpha_pll_is_enabled,
> +       .recalc_rate =3D clk_alpha_pll_recalc_rate,
> +       .determine_rate =3D clk_alpha_pll_stromer_determine_rate,
> +       .set_rate =3D clk_alpha_pll_stromer_set_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> +
>  const struct clk_ops clk_alpha_pll_fixed_trion_ops =3D {
>         .enable =3D clk_trion_pll_enable,
>         .disable =3D clk_trion_pll_disable,
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alph=
a-pll.h
> index 2bdae362c827..1d122919e275 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/* Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved. =
*/
> +/* Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reser=
ved. */

2022 or 2023?
