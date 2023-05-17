Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A84705D86
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjEQCzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjEQCze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:55:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F97A4215
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:55:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64ab2a37812so9958143b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684292132; x=1686884132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMclfiyGo0qMnOEsUXx6eVybC9kQxJH7wp/u50FaUx8=;
        b=Yn0BnxDZ0zaDQueocMV3NBj+K2Seb7mJCi3qIT5OJO3pMtumpwRD/p9iVrNdpUl/bb
         ESckLUrRIwmX8IHeE4NClmcy500ZzX/XVCC5ZWtoAiPSUzTRAvMd9k7VFMwJsohV8wdM
         Ozpd51FIuOmGcNpzLMnohfq+EdFPkoemzGF3pT1Nyy8GaJtkei4yUmsZx/2olmd6mIcc
         oWeKt9tvWNYuXsv7RkaO3vI+xcXN+mtQxXiLbC8aqP1Ap+Ay2YZIuLmUh3bBsBeuc1Et
         EN3zzSUqIwzDLjFnjBoJJi/0KZTaTCizcCsv0O4KLCWzVs9IRH8PIqh8uL3wEeUGEJrc
         LONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684292132; x=1686884132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMclfiyGo0qMnOEsUXx6eVybC9kQxJH7wp/u50FaUx8=;
        b=QmQkPRudxNUSrAQ7VEcRu098/v+nFqgiIod0zjLSzbI1m6RsXaIx+gtOedW+c5mqpF
         cp8pYp+8C75I0WpLiie2MqiUUg8DKxmK6/mVkNl8cFvKUiro4RWjN/CZYMAZ3CgcG+ge
         N8CI78vDgnYiuSB8cea1EbPIUX0ehZlxtX5mZu2ac/JoAUwKIR5R8kDMly12ErXw/eAW
         PZAnmz7ZMm+SxeMitz777k1uO2ZgawUGb0qMM/up3/Ma3qKuiXj7+5jhtPKref4CQJe7
         yexKLGkNKrNIySlCTu7DcK3PIsMZw1NOIHsiigCLAZZ0Vq3MTIT0njGHx28MPElYFLjn
         umwA==
X-Gm-Message-State: AC+VfDzAzzVCrV9fZwIFRjyuIex4iqzY4qAYZXrbAYEmhov4JeFk3+M9
        HXcYdTAdBIbabYFLuvyIStTRnwBZtdM6Z+iI1WQ=
X-Google-Smtp-Source: ACHHUZ45UOXr3NZOxad66JB/0zbsfWFh/S4VbTo38RTehwxLZsxSN31juSyIHYGpDexXKnpqRGfeTD1Bwk9cYubX3BQ=
X-Received: by 2002:a17:903:41c8:b0:1ac:6fc3:6beb with SMTP id
 u8-20020a17090341c800b001ac6fc36bebmr994634ple.9.1684292131687; Tue, 16 May
 2023 19:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-6-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-6-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 16 May 2023 21:55:19 -0500
Message-ID: <CAHCN7xL8qkCgXEE3nZvmwbWGO5GtF+37eOVYq63djGOHDaSdmA@mail.gmail.com>
Subject: Re: [PATCH V6 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
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

On Mon, May 15, 2023 at 6:57=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The DPHY timings are currently hard coded. Since the input
> clock can be variable, the phy timings need to be variable
> too.  To facilitate this, we need to cache the hs_clock
> based on what is generated from the PLL.
>
> The phy_mipi_dphy_get_default_config_for_hsclk function
> configures the DPHY timings in pico-seconds, and a small macro
> converts those timings into clock cycles based on the hs_clk.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 57 +++++++++++++++++++++++----
>  include/drm/bridge/samsung-dsim.h     |  1 +
>  2 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 08266303c261..3944b7cfbbdf 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -218,6 +218,8 @@
>
>  #define OLD_SCLK_MIPI_CLK_NAME         "pll_clk"
>
> +#define PS_TO_CYCLE(ps, hz) DIV64_U64_ROUND_CLOSEST(((ps) * (hz)), 10000=
00000000ULL)
> +
>  static const char *const clk_names[5] =3D {
>         "bus_clk",
>         "sclk_mipi",
> @@ -651,6 +653,8 @@ static unsigned long samsung_dsim_set_pll(struct sams=
ung_dsim *dsi,
>                 reg =3D samsung_dsim_read(dsi, DSIM_STATUS_REG);
>         } while ((reg & DSIM_PLL_STABLE) =3D=3D 0);
>
> +       dsi->hs_clock =3D fout;
> +
>         return fout;
>  }
>
> @@ -698,13 +702,46 @@ static void samsung_dsim_set_phy_ctrl(struct samsun=
g_dsim *dsi)
>         const struct samsung_dsim_driver_data *driver_data =3D dsi->drive=
r_data;
>         const unsigned int *reg_values =3D driver_data->reg_values;
>         u32 reg;
> +       struct phy_configure_opts_mipi_dphy cfg;
> +       int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
> +       int hs_exit, hs_prepare, hs_zero, hs_trail;
> +       unsigned long long byte_clock =3D dsi->hs_clock / 8;
>
>         if (driver_data->has_freqband)
>                 return;
>
> +       phy_mipi_dphy_get_default_config_for_hsclk(dsi->hs_clock,
> +                                                  dsi->lanes, &cfg);
> +
> +       /*
> +        * TODO:
> +        * The tech reference manual for i.MX8M Mini/Nano/Plus
> +        * doesn't state what the definition of the PHYTIMING
> +        * bits are beyond their address and bit position.
> +        * After reviewing NXP's downstream code, it appears
> +        * that the various PHYTIMING registers take the number
> +        * of cycles and use various dividers on them.  This
> +        * calculation does not result in an exact match to the
> +        * downstream code, but it is very close, and it appears
> +        * to sync at a variety of resolutions. If someone
> +        * can get a more accurate mathematical equation needed
> +        * for these registers, this should be updated.
> +        */

Marek Szyprowski -

I was curious to know if you have any opinion on this TODO note and/or
if you have any stuff you can share about how the values of the
following variables are configured?
> +
> +       lpx =3D PS_TO_CYCLE(cfg.lpx, byte_clock);
> +       hs_exit =3D PS_TO_CYCLE(cfg.hs_exit, byte_clock);
> +       clk_prepare =3D PS_TO_CYCLE(cfg.clk_prepare, byte_clock);
> +       clk_zero =3D PS_TO_CYCLE(cfg.clk_zero, byte_clock);
> +       clk_post =3D PS_TO_CYCLE(cfg.clk_post, byte_clock);
> +       clk_trail =3D PS_TO_CYCLE(cfg.clk_trail, byte_clock);
> +       hs_prepare =3D PS_TO_CYCLE(cfg.hs_prepare, byte_clock);
> +       hs_zero =3D PS_TO_CYCLE(cfg.hs_zero, byte_clock);
> +       hs_trail =3D PS_TO_CYCLE(cfg.hs_trail, byte_clock);
> +

These 'work' but they don't exactly match the NXP reference code, but
they're not significantly different.  The NXP reference manual doesn't
describe how these registers are set, they only publish the register
and bits used.  Since you work for Samsung, I was hoping you might
have inside information to know if this is a reasonable approach.

thanks

adam

>         /* B D-PHY: D-PHY Master & Slave Analog Block control */
>         reg =3D reg_values[PHYCTRL_ULPS_EXIT] | reg_values[PHYCTRL_VREG_L=
P] |
>                 reg_values[PHYCTRL_SLEW_UP];
> +
>         samsung_dsim_write(dsi, DSIM_PHYCTRL_REG, reg);
>
>         /*
> @@ -712,7 +749,9 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_=
dsim *dsi)
>          * T HS-EXIT: Time that the transmitter drives LP-11 following a =
HS
>          *      burst
>          */
> -       reg =3D reg_values[PHYTIMING_LPX] | reg_values[PHYTIMING_HS_EXIT]=
;
> +
> +       reg  =3D DSIM_PHYTIMING_LPX(lpx) | DSIM_PHYTIMING_HS_EXIT(hs_exit=
);
> +
>         samsung_dsim_write(dsi, DSIM_PHYTIMING_REG, reg);
>
>         /*
> @@ -728,10 +767,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsun=
g_dsim *dsi)
>          * T CLK-TRAIL: Time that the transmitter drives the HS-0 state a=
fter
>          *      the last payload clock bit of a HS transmission burst
>          */
> -       reg =3D reg_values[PHYTIMING_CLK_PREPARE] |
> -               reg_values[PHYTIMING_CLK_ZERO] |
> -               reg_values[PHYTIMING_CLK_POST] |
> -               reg_values[PHYTIMING_CLK_TRAIL];
> +
> +       reg =3D DSIM_PHYTIMING1_CLK_PREPARE(clk_prepare)  |
> +             DSIM_PHYTIMING1_CLK_ZERO(clk_zero)        |
> +             DSIM_PHYTIMING1_CLK_POST(clk_post)        |
> +             DSIM_PHYTIMING1_CLK_TRAIL(clk_trail);
>
>         samsung_dsim_write(dsi, DSIM_PHYTIMING1_REG, reg);
>
> @@ -744,8 +784,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsung=
_dsim *dsi)
>          * T HS-TRAIL: Time that the transmitter drives the flipped diffe=
rential
>          *      state after last payload data bit of a HS transmission bu=
rst
>          */
> -       reg =3D reg_values[PHYTIMING_HS_PREPARE] | reg_values[PHYTIMING_H=
S_ZERO] |
> -               reg_values[PHYTIMING_HS_TRAIL];
> +
> +       reg =3D DSIM_PHYTIMING2_HS_PREPARE(hs_prepare) |
> +             DSIM_PHYTIMING2_HS_ZERO(hs_zero) |
> +             DSIM_PHYTIMING2_HS_TRAIL(hs_trail);
> +
>         samsung_dsim_write(dsi, DSIM_PHYTIMING2_REG, reg);
>  }
>
> diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsu=
ng-dsim.h
> index a1a5b2b89a7a..d9d431e3b65a 100644
> --- a/include/drm/bridge/samsung-dsim.h
> +++ b/include/drm/bridge/samsung-dsim.h
> @@ -93,6 +93,7 @@ struct samsung_dsim {
>
>         u32 pll_clk_rate;
>         u32 burst_clk_rate;
> +       u32 hs_clock;
>         u32 esc_clk_rate;
>         u32 lanes;
>         u32 mode_flags;
> --
> 2.39.2
>
