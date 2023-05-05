Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FE96F87C7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjEERjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjEERjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4563B559E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF19614A0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33356C4339E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683308352;
        bh=He2VD5WDJqObFt05b2FpAEZOvPVyPfhb6478Y3/8MxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eQYJY2iF5yjQC7rU1s/b490L/utwiGhyxd+4mDES2GFaugkxpHqeRv5PaEJRitgXc
         xVswx8FbPQorgmnLl+ReF5FFefbX+yeRR/jMEbhmWVwtCVtkpGxxiSr+Kpm3cI6jsT
         8SEzZFk6CG4t//A8Z4tqO02jj9ZXVv4dBpwHOqySvQFLonXHn2alAaOgjK0E4Vl3YO
         JfQT8QeAp+yqtySUfwI9AehFyJj2lcdKzeim29E4DFcngvKy7KrXtwZat/cra7I96U
         LcWjd5t+Gu+qlRWy8VYvEBdS+n3HVaAIOt6j8BXHj64aaJhzskp4ZlOxCLrLsdfrQQ
         7Kr7nQc0KEnBg==
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-24e25e2808fso1898138a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:39:12 -0700 (PDT)
X-Gm-Message-State: AC+VfDwqm+Vl9RTDusdy+uEWEL8QTi+dcD/Qy46qy3ekI5GVC7urgPlP
        wHdwOa/+bGh1FWeLjoo7uXZNEzWZ9wAY7kdSY6C2mA==
X-Google-Smtp-Source: ACHHUZ4Srhe0cJpjgons5yFqosWk+nmV6h5CJkAZUs0SS+EYfHlmueEYNFOMB1s8KLFPSPTA2LJj9MO5MZNVlWjyVGo=
X-Received: by 2002:a17:90a:8e83:b0:250:3e1e:acd with SMTP id
 f3-20020a17090a8e8300b002503e1e0acdmr985112pjo.7.1683308351652; Fri, 05 May
 2023 10:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-4-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-4-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 19:39:00 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5fBur-WSd5xN-=yyFDGiUWEq-U9=xXbYRSqzdeo8CxLw@mail.gmail.com>
Message-ID: <CAN6tsi5fBur-WSd5xN-=yyFDGiUWEq-U9=xXbYRSqzdeo8CxLw@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] drm/bridge: tc358768: fix PLL target frequency
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 4:32=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correctly compute the PLL target frequency, the current formula works
> correctly only when the input bus width is 24bit, actually to properly
> compute the PLL target frequency what is relevant is the bits-per-pixel
> on the DSI link.
>
> No regression expected since the DSI format is currently hard-coded as
> MIPI_DSI_FMT_RGB888.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index e9e3f9e02bba..dba1bf3912f1 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -146,6 +146,7 @@ struct tc358768_priv {
>
>         u32 pd_lines; /* number of Parallel Port Input Data Lines */
>         u32 dsi_lanes; /* number of DSI Lanes */
> +       u32 dsi_bpp; /* number of Bits Per Pixel over DSI */
>
>         /* Parameters for PLL programming */
>         u32 fbd;        /* PLL feedback divider */
> @@ -284,12 +285,12 @@ static void tc358768_hw_disable(struct tc358768_pri=
v *priv)
>
>  static u32 tc358768_pll_to_pclk(struct tc358768_priv *priv, u32 pll_clk)
>  {
> -       return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->pd_line=
s);
> +       return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->dsi_bpp=
);
>  }
>
>  static u32 tc358768_pclk_to_pll(struct tc358768_priv *priv, u32 pclk)
>  {
> -       return (u32)div_u64((u64)pclk * priv->pd_lines, priv->dsi_lanes);
> +       return (u32)div_u64((u64)pclk * priv->dsi_bpp, priv->dsi_lanes);
>  }
>
>  static int tc358768_calc_pll(struct tc358768_priv *priv,
> @@ -426,6 +427,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_h=
ost *host,
>         priv->output.panel =3D panel;
>
>         priv->dsi_lanes =3D dev->lanes;
> +       priv->dsi_bpp =3D mipi_dsi_pixel_format_to_bpp(dev->format);
>
>         /* get input ep (port0/endpoint0) */
>         ret =3D -EINVAL;
> @@ -437,7 +439,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_h=
ost *host,
>         }
>
>         if (ret)
> -               priv->pd_lines =3D mipi_dsi_pixel_format_to_bpp(dev->form=
at);
> +               priv->pd_lines =3D priv->dsi_bpp;
>
>         drm_bridge_add(&priv->bridge);
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
