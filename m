Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600116F939A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjEFS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEFS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:27:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D540C3
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 11:27:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c6504974dso2678253a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 11:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683397677; x=1685989677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/WwOrZJ5JRzyY6p6wiuOMAhVag97atAR6Wjafb+S2A=;
        b=Ed0WNNwC5JVc/UevED/FuEHi+jsrMHibsAXB7n0Hv6KblssEN8GuVTTkx3Jbl8zlne
         ifBfne1EIZ0L2ZEaowjD216ZVUWg8L4ItBmrxzS6sEbA31bCOzRvOMKRXshU3SiUU57N
         UJKp8EOaPvg4hrgAnrbeRf4yMMdbPlqTyghbQwrx/7GK62MefqKXuuaSs91fwA32Yjeq
         v4182toBBPBGXBJ+A+fes6LALCH2gP8JpwJdZ0I5CtVI8/Kr11V7B3BVeyn9jlW/Qpwt
         Tpk++Jr5DlDwk4y+EjpiKpd7BIALwuIsTUDP5MOSe8T+Qurrmr8Tfy08BZ1lCsBoYyoJ
         0MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683397677; x=1685989677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/WwOrZJ5JRzyY6p6wiuOMAhVag97atAR6Wjafb+S2A=;
        b=DLpCHzJpJkETVuwQdYJzWmRI5Vi5ad1yLrrrTODSWDOAbQs7w3kmohQ9aaoFNAkUPY
         cMGyoweLTN23Iuoa7dkCzQzWX99XvoiF33A5PLnFBHieLuXcgwlqV3BAA8/OBGlhXBmW
         fGI3sJKuj7F72QRMOpC9otkck3hFPP5QAzjH/sJgYb2xVrmL0LcTpaGkHYMl1x2Scp9c
         uV+399VxZ9HuzUUR869npdSs+DN/RmKUcN3VEZEllLUChzcFP4JwZmjfAxOrVDDujYCx
         n5B1HgNYHs8xkFESFo8+craX3o5ldUiT846nHXDPyyMYtGNnmdoNTAA1ohEzmHX09KK+
         15jQ==
X-Gm-Message-State: AC+VfDxmAEFWQz4FyQEYg5Rt4Uz9ZIDPIypUhyPi88Lfh8Lxhu2KDXNf
        ETjifjz6xANJ76xf0d205fc6dGC4A1J1yvRf/qY=
X-Google-Smtp-Source: ACHHUZ4dhBfjviOJchXZhn3Bir28JhXsuvyGtA7iNiGJcSNaCo4NTvQnwHDdb/5h9wBmDdh6jHp/AFrFotWfZQm4Pd8=
X-Received: by 2002:a17:90a:9307:b0:24d:ef6a:dd0a with SMTP id
 p7-20020a17090a930700b0024def6add0amr5444552pjo.5.1683397677239; Sat, 06 May
 2023 11:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230506010933.170939-1-aford173@gmail.com> <20230506010933.170939-4-aford173@gmail.com>
In-Reply-To: <20230506010933.170939-4-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 6 May 2023 13:27:45 -0500
Message-ID: <CAHCN7xLQaqP19zeMy27uUjFxgigKgh8vDRRM1P_uEXzuw5bN=g@mail.gmail.com>
Subject: Re: [PATCH V4 3/6] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
To:     dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Chen-Yu Tsai <wenst@chromium.org>,
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
        linux-kernel@vger.kernel.org
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

On Fri, May 5, 2023 at 8:09=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Make the pll-clock-frequency optional.  If it's present, use it
> to maintain backwards compatibility with existing hardware.  If it
> is absent, read clock rate of "sclk_mipi" to determine the rate.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>


Sorry for the noise.  I forgot to merge in the suggested updates for
the messages so they don't look like errors.  A V5 is coming once I
merge and test the changes.

adam
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index bf4b33d2de76..2dc02a9e37c0 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1726,12 +1726,20 @@ static int samsung_dsim_parse_dt(struct samsung_d=
sim *dsi)
>  {
>         struct device *dev =3D dsi->dev;
>         struct device_node *node =3D dev->of_node;
> +       struct clk *pll_clk;
>         int ret;
>
>         ret =3D samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequen=
cy",
>                                        &dsi->pll_clk_rate);
> -       if (ret < 0)
> -               return ret;
> +
> +       /* If it doesn't exist, read it from the clock instead of failing=
 */
> +       if (ret < 0) {
> +               pll_clk =3D devm_clk_get(dev, "sclk_mipi");
> +               if (!IS_ERR(pll_clk))
> +                       dsi->pll_clk_rate =3D clk_get_rate(pll_clk);
> +               else
> +                       return PTR_ERR(pll_clk);
> +       }
>
>         ret =3D samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequ=
ency",
>                                        &dsi->burst_clk_rate);
> --
> 2.39.2
>
