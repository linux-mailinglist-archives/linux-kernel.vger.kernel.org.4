Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4CD6F8860
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjEESHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEESHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:07:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1781161B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD4F363FC3
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11467C433AC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683310031;
        bh=SLXLVsRKiID4HTKaDJ18JTOztvB3O778HpU6t3fR1U4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kzt08nxPFS8hKFeBDEXS9DAuBEmSltfclRtK0OxvFmPD/vAt0YysnDZF5U7q4n7Vi
         /73HIALD8NRSOAkkw+hnHm40mShBnw6XgD7HRlitLogv7z6T3r4cU9LUyKucZ6PlEs
         ieNwKSW7bmawpk8n0cvzhpa2ss8U01/jYXiSKKxvxTQwCBkHWeK1x2BKE0kUcgeGh7
         a7QiDYcOFX61Yfy1+i2ljRR40fjh/tamqRX4dwOSZYjGF6AB2jpFKnjsJtiIrtvVYZ
         aSPfacCO4iLE4zunbv5EO4mcHGcP+BVVD9pRjPtbcYvT4+TMm49x1jJzEnUbnHgNxj
         HpflT6o3BT9cw==
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-643557840e4so2397484b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:07:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDwNNzUrMt/6/yCqXHXTijgm+YHaccB1BUcEXAA5RgALda7M4b5p
        dF3mJ2EwrjPBHmivMFtweP+Plcz+Dwy1+IU885fLLw==
X-Google-Smtp-Source: ACHHUZ649OwsqyPFugyLLuCFgi4H32qoyAX6lylL2HIG3QYkaeSdoDnaTG+0ODejYNL2rj7aecmY7R4lNSyJi494wR0=
X-Received: by 2002:a05:6a20:748d:b0:f4:24e6:1065 with SMTP id
 p13-20020a056a20748d00b000f424e61065mr3044424pzd.39.1683310030576; Fri, 05
 May 2023 11:07:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-9-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-9-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 20:06:59 +0200
X-Gmail-Original-Message-ID: <CAN6tsi54HRw6STzkxbChxdCK+oV+8EF0taO6dSp8YpsokQ8TCQ@mail.gmail.com>
Message-ID: <CAN6tsi54HRw6STzkxbChxdCK+oV+8EF0taO6dSp8YpsokQ8TCQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/9] drm/bridge: tc358768: fix THS_TRAILCNT computation
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 4:34=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correct computation of THS_TRAILCNT register.
>
> This register must be set to a value that ensure that
> THS_TRAIL > 60 ns + 4 x UI
>  and
> THS_TRAIL > 8 x UI
>  and
> THS_TRAIL < TEOT
>  with
> TEOT =3D 105 ns + (12 x UI)
>
> with the actual value of THS_TRAIL being
>
> (1 + THS_TRAILCNT) x ByteClk cycle + ((1 to 2) + 2) xHSBYTECLK cycle +
>  - (PHY output delay)
>
> with PHY output delay being about
>
> (8 + (5 to 6)) x MIPIBitClk cycle in the BitClk conversion.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 854fc04f08d0..947c7dca567a 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -779,9 +779,10 @@ static void tc358768_bridge_pre_enable(struct drm_br=
idge *bridge)
>         dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
>
> -       /* 60ns + 4*UI < THS_PREPARE < 105ns + 12*UI */
> -       val =3D tc358768_ns_to_cnt(60 + tc358768_to_ns(15 * ui_nsk),
> -                                dsibclk_nsk) - 5;
> +       /* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
> +       raw_val =3D tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
> +                                    dsibclk_nsk) - 4;
> +       val =3D clamp(raw_val, 0, 15);
>         dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_THS_TRAILCNT, val);
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
