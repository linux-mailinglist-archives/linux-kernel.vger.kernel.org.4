Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACCA70669C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEQL2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjEQL2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:28:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C93C34
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:28:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba865ac594bso607664276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 04:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684322883; x=1686914883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o2tVJQBKqbYOhLGPD0uYl/0T73lg7VFfZy9i2I0OMY=;
        b=oqT/+gSqpHczmyKhxBcrWwriOapQ7izKdPneKcvVuY+gcz4PUY3eB9dPNj0ZRml9ku
         NN/tDywHPagraF2TSqg8TBauWdnBhJYR0TiMPnvhCAZOCENkd13b7LgoofwCeOvCceHU
         BRWj5EJ/F0fd1LvOn01GKFTO0980EW7ZqjHnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684322883; x=1686914883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o2tVJQBKqbYOhLGPD0uYl/0T73lg7VFfZy9i2I0OMY=;
        b=H2P0fZo8nJXOqv1r2wuY9uoMjfHvQ3TdPfRygKRYPFE2hQFzBlw6w20dRDIsxmrFXS
         Bl4N0RVDtYi4R/fimkGieA/3103Xt+lqJ9f0Vpig+iplDaf1qewa8t/KnlRg5zysGK3W
         8YjIYjk/T28uD7UuQk000Bzg8Kyo81LmWUey2SmWgndK7+IKb1Jji6wCt7jMXcmth6l1
         +8zJBICSU8gQD1JvceM5mRcwjDU2LREnLI+pzQuwnvcTq5xsyPBUpvxrwjyKrWyUmdkH
         ZICV5L9VUe7cG5UHAL7wWPZNaI7kQ+wImokxry2locK8VCW1sktV466fKyD4utKPsmyt
         OmgQ==
X-Gm-Message-State: AC+VfDzFTRswgiPPlAmtJx5BjnE+VIvof5szghCeaAlOOTdthP9S5qCj
        jm9TbgIScrkmBzVzpmO4JRr3wHGsUhvI8U9f2bdqaw==
X-Google-Smtp-Source: ACHHUZ7sGRYmO33b0LkOTVUhtAasTyty5M2n2uUDIOaIyi6jR9/74q1G9xE1qRJwROFi+UbBSOdupdd/Sn7v5WG2zsU=
X-Received: by 2002:a0d:d895:0:b0:561:9800:81f4 with SMTP id
 a143-20020a0dd895000000b00561980081f4mr3239721ywe.50.1684322883168; Wed, 17
 May 2023 04:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-6-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-6-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 16:57:50 +0530
Message-ID: <CAMty3ZBk-Zg-RFZv1Owo5aE9C8VpFXq45nLE-mBVSc=2o=iq4w@mail.gmail.com>
Subject: Re: [PATCH V6 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
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

Does it mean, Applications Processor Reference Manual? better add it
clear reference.

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

I think we can do some kind of negotiation has done similar in bsp by
taking inputs from bit_clk  and PLL_1432X table. Did you try this? we
thought this approach while writing dsim to support dynamic dphy.

Thanks,
Jagan.
