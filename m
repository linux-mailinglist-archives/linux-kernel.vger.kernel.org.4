Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE807080B9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjERMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjERMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:07:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890C610A
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:07:21 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-561b43fc896so17538447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1684411641; x=1687003641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+vYjmpxBNlZuPV45+UQsttMirEjwbsfvsjjU7mymMg=;
        b=lDHD9kTyu6C900iWJgAaI2zvYQGebe2WQhin5yh6ukpDVVrT7AgP2envsyg2lltUis
         IlYbmeg4Cul0fO+mjEE5UfTSWx105bkw9tWQ+ekrhA20Oe+A8u8+Ru16OksVoEOR3kL6
         xlDFjtqfMAJMQ39F+6lcfqIfZcRtxr7sxCm4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684411641; x=1687003641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+vYjmpxBNlZuPV45+UQsttMirEjwbsfvsjjU7mymMg=;
        b=ROXbpapBrRkjGuBxynVENOlWKKfcFUS3sZRc8AGGErJx28jzR7s8doHEWwoj6fu/id
         MT0esShpe/MV26sDux1+6DKsxxMkIV0NmtLUtnEgLGejxboDyzW+MP82p+D4hywoEB6F
         SdMBz7e6hy7VfS8O7cALRtPazHmqJ/+pHqdOzqA1vFEluWD+4FrxjCNieyZQA2PzGbud
         /XsitoTcOEYlm0+/TK0VLFR30LJLrY5F1HhPnEmmQJaS+ApnJIE+ruBEmHt4W3DhOAqn
         tPE3SQQ8hQmM3uDwLbqx8gGmQS/s5q66JRoYMr5Xd5R4XXzFtWi5jW58tTy6g7mi97ZA
         kKsQ==
X-Gm-Message-State: AC+VfDzf0x8567Uf42j3C1jcU7ay4p11Cw9fxe/vXhTFz5lVQy9I0unh
        SNeJVKm4emxndkXJUJHRJfxoC7VT5yH8U1w7GORz7g==
X-Google-Smtp-Source: ACHHUZ5EiaNtu81hJhKkwTw8SJXqjOyng0ZWicULB+i56VjifMMg/QzNv0DBYxkU62rX99FrRPP2foSIL7AQqjuKSVc=
X-Received: by 2002:a0d:cb8b:0:b0:561:d21d:8ce4 with SMTP id
 n133-20020a0dcb8b000000b00561d21d8ce4mr1018258ywd.19.1684411640769; Thu, 18
 May 2023 05:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515235713.232939-1-aford173@gmail.com> <20230515235713.232939-7-aford173@gmail.com>
In-Reply-To: <20230515235713.232939-7-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 18 May 2023 17:37:09 +0530
Message-ID: <CAMty3ZBqdE8mLiwFa=QRChBYyQnsOEMYqh2Azj4TxbZbErCsBA@mail.gmail.com>
Subject: Re: [PATCH V6 6/6] drm: bridge: samsung-dsim: Support non-burst mode
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Chen-Yu Tsai <wenst@chromium.org>,
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
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wrot=
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

I dropped this and tested it.

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com> # imx8mm-icore
