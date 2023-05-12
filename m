Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831B26FFF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbjELDDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjELDDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:03:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6445E7D;
        Thu, 11 May 2023 20:03:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24e2b2a27ebso8802695a91.3;
        Thu, 11 May 2023 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683860616; x=1686452616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okS0nyCHMJFpWL72iU8CAh7sHogIt3lKsHUa4vkBU1M=;
        b=Vz2Xz5fIUfIpUekI7JwXoYP+4lExRHjzmr6CG2NlIk0P+pYo4T7oBJdVhpmWRFNIEv
         Cxow7nkLGMIKEbxXWZ/R4a0i0eKnZmB8b9KtJNEvQyV12kk+CxLOW0zLrkFDJxDQJmjb
         O9bsT/5BW+K8TPV10KXDhoyq7XKx5YuKw8dlRZ9wjywktUChJb802Hp0FtGJJWbuKr3h
         IzkDCrn+WMOSzufnHPiU1Swzxx0Nxa+YjeoNG4oMbUScwYmLcKeQS6dkhEUIPLvz0vsN
         FyBv3WVy79LuEAW0qvEEh1GmJfJ7PQ3BE/BGvPIH8du3MPgAeZJPsC9CqSWxMZ376Vko
         LOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683860616; x=1686452616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okS0nyCHMJFpWL72iU8CAh7sHogIt3lKsHUa4vkBU1M=;
        b=glwjLj1XZOWJ6c6YhraGN7+IkqQXZDK66vGEsDz1cqu23VMLEezbR6B1DRMXtvAea/
         WX31B9EBWFHz/1Tpim4akAjZKDYJ5qhNYpS0YaTk2eeb9pFAlTXBsMkM9ueQeODUuwHA
         b34D5H2ADzSO6ld4Rd9olofKVOrb8Yl+YyvyAYrUg38gkQMqf+fGgtk4kAjPRdQss0ry
         36v5YVZR029zQvLyFEt3YI2L9fxRotz1W+fsromsE8gX1X0pzcM+4MahjxObKrov1xjL
         eclSOlTogMRlabaPvyazbIcdzSnBR/0Z8g04H7Zj5CGwTYvovZxDwKfSUrSsNienZ7oj
         OnDQ==
X-Gm-Message-State: AC+VfDzDzeB9gtW7vtCnsaGVu14t0eS4CAH2wZbJebH0QhIREqKkk8ox
        0qRllTRY5qeSWioEA/XNQvjvDCKaN0pfl4smeDEae7uQ
X-Google-Smtp-Source: ACHHUZ6Wh335uXznMcbuTN1lz3StON/DPpclASU1JXQSYdEpjSNEcedq6i8xcrAi73ZgjocyJ42jsdW5fbPO4il8qh4=
X-Received: by 2002:a17:90b:1809:b0:250:7d1f:938b with SMTP id
 lw9-20020a17090b180900b002507d1f938bmr16859915pjb.23.1683860615694; Thu, 11
 May 2023 20:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230506195325.876871-1-aford173@gmail.com>
In-Reply-To: <20230506195325.876871-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 11 May 2023 22:03:23 -0500
Message-ID: <CAHCN7xLfh6Ttoi29d6Vn1Hw75GEA8hd-XGec08ofeC176thkPg@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: composite-8m: Add imx8m_divider_determine_rate
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, Abel Vesa <abelvesa@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 6, 2023 at 2:53=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Currently, certain clocks are derrived as a divider from their
> parent clock.  For some clocks, even when CLK_SET_RATE_PARENT
> is set, the parent clock is not properly set which can lead
> to some relatively inaccurate clock values.
>
> Unlike imx/clk-composite-93 and imx/clk-divider-gate, it
> cannot rely on calling a standard determine_rate function,
> because the 8m composite clocks have a pre-divider and
> post-divider. Because of this, a custom determine_rate
> function is necessary to determine the maximum clock
> division which is equivalent to pre-divider * the
> post-divider.
>
> With this added, the system can attempt to adjust the parent rate
> when the proper flags are set which can lead to a more precise clock
> value.
>
> On the imx8mplus, no clock changes are present.
> On the Mini and Nano, this can help achieve more accurate
> lcdif clocks. When trying to get a pixel clock of 31.500MHz
> on an imx8m Nano, the clocks divided the 594MHz down, but
> left the parent rate untouched which caused a calulation error.
>
> Before:
> video_pll              594000000
>   video_pll_bypass     594000000
>     video_pll_out      594000000
>       disp_pixel       31263158
>         disp_pixel_clk 31263158
>
> Variance =3D -236842 Hz
>
> After this patch:
> video_pll               31500000
>   video_pll_bypass      31500000
>     video_pll_out       31500000
>       disp_pixel        31500000
>         disp_pixel_clk  31500000
>
> Variance =3D 0 Hz
>
> All other clocks rates and parent were the same.
> Similar results on imx8mm were found.
>

Peng / Abel,

I was curious if either of you might have time to review this attempt
at enabling determine_rate on the 8m's.  I tested this on the 8mm,
8mn, and 8mp, and found no regressions.

adam
> Fixes: 690dccc4a0bf ("Revert "clk: imx: composite-8m: Add support to dete=
rmine_rate"")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Fix build warning found by build bot and fix prediv_value
>      and div_value because the values stored are the divisor - 1,
>      so we need to add 1 to the values to be correct.
>
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> index cbf0d7955a00..7a6e3ce97133 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -119,10 +119,41 @@ static int imx8m_clk_composite_divider_set_rate(str=
uct clk_hw *hw,
>         return ret;
>  }
>
> +static int imx8m_divider_determine_rate(struct clk_hw *hw,
> +                                     struct clk_rate_request *req)
> +{
> +       struct clk_divider *divider =3D to_clk_divider(hw);
> +       int prediv_value;
> +       int div_value;
> +
> +       /* if read only, just return current value */
> +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> +               u32 val;
> +
> +               val =3D readl(divider->reg);
> +               prediv_value =3D val >> divider->shift;
> +               prediv_value &=3D clk_div_mask(divider->width);
> +               prediv_value++;
> +
> +               div_value =3D val >> PCG_DIV_SHIFT;
> +               div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
> +               div_value++;
> +
> +               return divider_ro_determine_rate(hw, req, divider->table,
> +                                                PCG_PREDIV_WIDTH + PCG_D=
IV_WIDTH,
> +                                                divider->flags, prediv_v=
alue * div_value);
> +       }
> +
> +       return divider_determine_rate(hw, req, divider->table,
> +                                     PCG_PREDIV_WIDTH + PCG_DIV_WIDTH,
> +                                     divider->flags);
> +}
> +
>  static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
>         .recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
>         .round_rate =3D imx8m_clk_composite_divider_round_rate,
>         .set_rate =3D imx8m_clk_composite_divider_set_rate,
> +       .determine_rate =3D imx8m_divider_determine_rate,
>  };
>
>  static u8 imx8m_clk_composite_mux_get_parent(struct clk_hw *hw)
> --
> 2.39.2
>
