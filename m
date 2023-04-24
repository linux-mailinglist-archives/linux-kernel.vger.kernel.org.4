Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAC6EC846
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjDXJDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXJDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:03:52 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F423211D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:03:51 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fb9384c2dso48990487b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682327030; x=1684919030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cSv908+XbxMNLsKEbTm9jFklu64ICgFxL9KYAhHv6U=;
        b=rGaI5R8xnw5jjlLgvyRcDN8MOmGhLU9gutbCOvkCTQbBB+j+2n1wbu+UrIaQX86gRE
         iX9ivyYi8HeVrwFZZr3hr65F7WfYO0deRCEtc9aUtuMVfCZ1+2Jm/SSZQ+OuUqVDwpT2
         WOk7s7eTJLqytJMxbB5TAJuIpEEflg/IqVdGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327030; x=1684919030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cSv908+XbxMNLsKEbTm9jFklu64ICgFxL9KYAhHv6U=;
        b=f4puQUiMESeeCPzcPVKVc46WCGVOqceUvPij+Pn74hc/5K8CorfEYdeOmNGh1Bgkg2
         3TXVxHDs3Hrqbmg43ZYbXFWEsKt6F3BEAke+4FxU0OUaeia0Ixou+kfkh1+dowa8CMho
         n1mM61eS9zNFw1P1Jm6qWzpRG3Wy4fBXd6ZqZ1+2KyqpYdoT1oUqJ9b6iDExQJn3gMxb
         HLPKQ3vD5lXA4IJhv4d3CZWaovgXa9smbuK2cnKaO3Sk/sB9xCw95cax3uVmWRuDsUHX
         MT2B4voRwaFHScAxTl+V/LYfcxZ/+xjxw+sL76SAjVeyvRqy6aJ6etDJxpnBr9B2xheG
         HzQw==
X-Gm-Message-State: AAQBX9f6frvDpbGdwnPi597KSzfrMsX5exYrOx0tlDL5XQe8jus2Xh+z
        WpK9VkY/SMfqlELMAA6t8rwCtMECTjgQjWpspSiglA==
X-Google-Smtp-Source: AKy350Z7B0vqLEmVxsm8gwNXz0Mr3uw6c5CelEFXXRS8WBWNscFAnrUucpIycBwqf062sEv89dWQgMEgJ48vn/ek6tc=
X-Received: by 2002:a0d:de85:0:b0:527:b681:3e62 with SMTP id
 h127-20020a0dde85000000b00527b6813e62mr6741490ywe.23.1682327030489; Mon, 24
 Apr 2023 02:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230423121232.1345909-1-aford173@gmail.com> <20230423121232.1345909-2-aford173@gmail.com>
In-Reply-To: <20230423121232.1345909-2-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 24 Apr 2023 14:33:38 +0530
Message-ID: <CAMty3ZCn9_AT8SOfFD-MYox16ZcqOEezt_0x6aES6LWQFj8Kpg@mail.gmail.com>
Subject: Re: [PATCH V2 1/6] drm: bridge: samsung-dsim: fix blanking packet
 size calculation
To:     Adam Ford <aford173@gmail.com>, l.stach@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, m.szyprowski@samsung.com,
        aford@beaconembedded.com, dario.binacchi@amarulasolutions.com,
        Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
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

On Sun, Apr 23, 2023 at 5:42=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> From: Lucas Stach <l.stach@pengutronix.de>
>
> Scale the blanking packet sizes to match the ratio between HS clock
> and DPI interface clock. The controller seems to do internal scaling
> to the number of active lanes, so we don't take those into account.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index e0a402a85787..2be3b58624c3 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -874,17 +874,29 @@ static void samsung_dsim_set_display_mode(struct sa=
msung_dsim *dsi)
>         u32 reg;
>
>         if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> +               int byte_clk_khz =3D dsi->burst_clk_rate / 1000 / 8;
> +               int hfp =3D (m->hsync_start - m->hdisplay) * byte_clk_khz=
 / m->clock;

I do not quite understand why it depends on burst_clk_rate, would you
please explain? does it depends on bpp something like this

mipi_dsi_pixel_format_to_bpp(format) / 8

> +               int hbp =3D (m->htotal - m->hsync_end) * byte_clk_khz / m=
->clock;
> +               int hsa =3D (m->hsync_end - m->hsync_start) * byte_clk_kh=
z / m->clock;
> +
> +               /* remove packet overhead when possible */
> +               hfp =3D max(hfp - 6, 0);
> +               hbp =3D max(hbp - 6, 0);
> +               hsa =3D max(hsa - 6, 0);

6 blanking packet overhead here means, 4 bytes + payload + 2 bytes
format? does this packet overhead depends on the respective porch's
like hpf, hbp and hsa has different packet overheads?

Jagan.
