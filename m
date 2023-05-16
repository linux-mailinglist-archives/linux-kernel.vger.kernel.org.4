Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E667043ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 05:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEPD0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 23:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 23:26:17 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7193D4227
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:26:16 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-77d049b9040so1581947241.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684207575; x=1686799575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5lwx9Jf07i09UJuTXUkKPSduss3VnLZfVldzH8agBY=;
        b=PgM1jKoPYp/WcFdxHutBCUIjnDa0d/Zi/7j2JnmgRx3Ylgct09kATGYCfxn572oeqp
         KTAp9SY/StmCmaRrHFxqG9IKXk6srLkjsszKL0D0xd3dlFPngcTrTe7VIJNL+CM6GS3E
         xTsJMZqrsfgflj8rD6G+PfvY7dlqFQzmnylFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684207575; x=1686799575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5lwx9Jf07i09UJuTXUkKPSduss3VnLZfVldzH8agBY=;
        b=li0QowwHybhNGsu6qT2Vpbx5s/k1pFzmUesIFh3LYMMhQYhQ76wbtLyzplmSZfShkA
         wH9H9Bii+XJ2rqq3GXLVJUY3lvnVS0LgFT8CJZBi2IcXkPvloqli7LoXw2Ry6RAp1oXW
         j9DbkOLNWjixfhbD1yqSo2rWYbRCAj9XBuidiF7sXpMKFedSXAxKk9BDmNnMiMGwuDOi
         Z7vIrYip6RRJSma0QUjIo902xwhf5cdI1hoCngHSu6asIMr7cAJZv5Hm3WtDry2LjuWJ
         /5taelUkGQpc9kK/nPWiSp9LwbEPIavvniBhVzhO/TorUDjuclK5lfJm5Sew2co6ajhw
         Vhhg==
X-Gm-Message-State: AC+VfDxqHbKpKd05w3ifAo1WtOroHHbdFDEdOIplLNzgi9x/IhPmtrKo
        HIr7XRMTyH3AnNqBD20jD15zrd+Kkh6PFbaEHnx5Sw==
X-Google-Smtp-Source: ACHHUZ5erLgUarQCkUtKfKybfPcSlj7g9pdBXtQEW1xJT0qRyMLNAVKQS7MyKDcQijob+hEvN3uRyr241Ur4ezpJX6E=
X-Received: by 2002:a1f:5c90:0:b0:440:4946:fac with SMTP id
 q138-20020a1f5c90000000b0044049460facmr13239709vkb.4.1684207575548; Mon, 15
 May 2023 20:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-7-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-7-aford173@gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 16 May 2023 11:26:04 +0800
Message-ID: <CAGXv+5EDYvjOiAWDnQsrrp=0iWm54N+pR3O43xDFXYE=UxAw-g@mail.gmail.com>
Subject: Re: [PATCH V6 6/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:57=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
e:
>
> The high-speed clock is hard-coded to the burst-clock
> frequency specified in the device tree.  However, when
> using devices like certain bridge chips without burst mode
> and varying resolutions and refresh rates, it may be
> necessary to set the high-speed clock dynamically based
> on the desired pixel clock for the connected device.
>
> This also removes the need to set a clock speed from
> the device tree for non-burst mode operation, since the
> pixel clock rate is the rate requested from the attached
> device like a bridge chip.  This should have no impact
> for people using burst-mode and setting the burst clock
> rate is still required for those users.  If the burst
> clock is not present, change the error message to
> dev_info indicating the clock use the pixel clock.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 3944b7cfbbdf..03b21d13f067 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -655,16 +655,28 @@ static unsigned long samsung_dsim_set_pll(struct sa=
msung_dsim *dsi,
>
>         dsi->hs_clock =3D fout;
>
> +       dsi->hs_clock =3D fout;
> +

Not sure about the double assignment. Was this caused by a rebase?

ChenYu

>         return fout;
>  }
>
>  static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
>  {
> -       unsigned long hs_clk, byte_clk, esc_clk;
> +       unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
>         unsigned long esc_div;
>         u32 reg;
> +       struct drm_display_mode *m =3D &dsi->mode;
> +       int bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> +
> +       /* m->clock is in KHz */
> +       pix_clk =3D m->clock * 1000;
> +
> +       /* Use burst_clk_rate if available, otherwise use the pix_clk */
> +       if (dsi->burst_clk_rate)
> +               hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rate)=
;
> +       else
> +               hs_clk =3D samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk=
 * bpp, dsi->lanes));
>
> -       hs_clk =3D samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
>         if (!hs_clk) {
>                 dev_err(dsi->dev, "failed to configure DSI PLL\n");
>                 return -EFAULT;
> @@ -935,7 +947,7 @@ static void samsung_dsim_set_display_mode(struct sams=
ung_dsim *dsi)
>         u32 reg;
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -               int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> +               int byte_clk_khz =3D dsi->hs_clock / 1000 / 8;
>                 int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk_khz=
 / m->clock;
>                 int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz / m=
->clock;
>                 int hsa =3D (m->hsync_end - m->hsync_start) * byte_clk_kh=
z / m->clock;
> @@ -1785,10 +1797,13 @@ static int samsung_dsim_parse_dt(struct samsung_d=
sim *dsi)
>                         return PTR_ERR(pll_clk);
>         }
>
> +       /* If it doesn't exist, use pixel clock instead of failing */
>         ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
> -                                      &dsi->burst_clk_rate, 0);
> -       if (ret < 0)
> -               return ret;
> +                                      &dsi->burst_clk_rate, 1);
> +       if (ret < 0) {
> +               dev_info(dev, "Using pixel clock for HS clock frequency\n=
");
> +               dsi->burst_clk_rate =3D 0;
> +       }
>
>         ret =3D samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequen=
cy",
>                                        &dsi->esc_clk_rate, 0);
> --
> 2.39.2
>
