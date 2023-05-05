Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D016F87CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjEERmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEERmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AD01891A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F117061492
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64481C4339E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683308539;
        bh=ut6/lVqqJmW1cLQuZc80y9pn83GlxWwOlfjlc5Kba/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a0+U1PacaHF9Ao/PYDElYvFI0iJ6GonYA+Lr+AaK07Qi64sN1HoUzzB1V2z05uLlu
         AM7GXQ0wpjJj37sV7UtF5wZ5QpWu+PCtVjNE5B4LyvX+sZNLGZW9qX/hLOwX4N5cwM
         BBVW4N+ADXVEaerm2lWsSxTJDHkzcHEMIyXdK/7QjLVA+Uj2cWqqqKBP3HtVx20Woy
         mwiZNAQzrPd2Oa9C76Dhi+BhWuYlkTZ+rWbTo5uq/hwVlmxIZc3o0PqWE8NXuS6Ycp
         gvWF8sJb5CznO+WsXZ9B4WRjj/vW1h6Qkx03n0UJZNhs6gerCi0oNPcQ3IxpUV1y4D
         HKhnlFypWR3Yg==
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-24e0c29733fso1898737a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:42:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDxImh7aWYiCpYvlprrNJsK2IlVxuLzJHKeqCRKXdGPcCUYW4R0J
        ylh6PihOZMTVxaWCcDZg+xEa2FyUMth0gO6guzf6IA==
X-Google-Smtp-Source: ACHHUZ5nEtVNFdqZHzWYZc4jukaaLaGlgFxaaDtDdECBO/OzERpeMEWHGO31OgessDPAwLn3eqfAD6NG61opg48AVAU=
X-Received: by 2002:a17:90b:506:b0:24d:df69:5c67 with SMTP id
 r6-20020a17090b050600b0024ddf695c67mr2495910pjz.12.1683308538986; Fri, 05 May
 2023 10:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-6-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-6-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 19:42:08 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6SF3kqsQ+ktzFiNdtY9AxKC_BPO0RqgOqsE1eakqYh7g@mail.gmail.com>
Message-ID: <CAN6tsi6SF3kqsQ+ktzFiNdtY9AxKC_BPO0RqgOqsE1eakqYh7g@mail.gmail.com>
Subject: Re: [PATCH v1 5/9] drm/bridge: tc358768: fix TCLK_TRAILCNT computation
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
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

On Thu, Apr 27, 2023 at 4:35=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correct computation of TCLK_TRAILCNT register.
>
> The driver does not implement non-continuous clock mode, so the actual
> value doesn't make a practical difference yet. However this change also
> ensures that the value does not write to reserved registers bits in case
> of under/overflow.
>
> This register must be set to a value that ensures that
>
> TCLK-TRAIL > 60ns
>  and
> TEOT <=3D (105 ns + 12 x UI)
>
> with the actual value of TCLK-TRAIL being
>
> (TCLK_TRAILCNT + (1 to 2)) xHSByteClkCycle +
>  (2 + (1 to 2)) * HSBYTECLKCycle - (PHY output delay)
>
> with PHY output delay being about
>
> (2 to 3) x MIPIBitClk cycle in the BitClk conversion.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index aff400c36066..360c7c65f8c4 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -9,6 +9,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> @@ -638,6 +639,7 @@ static void tc358768_bridge_pre_enable(struct drm_bri=
dge *bridge)
>         struct mipi_dsi_device *dsi_dev =3D priv->output.dev;
>         unsigned long mode_flags =3D dsi_dev->mode_flags;
>         u32 val, val2, lptxcnt, hact, data_type;
> +       s32 raw_val;
>         const struct drm_display_mode *mode;
>         u32 dsibclk_nsk, dsiclk_nsk, ui_nsk, phy_delay_nsk;
>         u32 dsiclk, dsibclk, video_start;
> @@ -749,9 +751,9 @@ static void tc358768_bridge_pre_enable(struct drm_bri=
dge *bridge)
>         dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
>
> -       /* TCLK_TRAIL > 60ns + 3*UI */
> -       val =3D 60 + tc358768_to_ns(3 * ui_nsk);
> -       val =3D tc358768_ns_to_cnt(val, dsibclk_nsk) - 5;
> +       /* TCLK_TRAIL > 60ns AND TEOT <=3D 105 ns + 12*UI */
> +       raw_val =3D tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), d=
sibclk_nsk) - 5;
> +       val =3D clamp(raw_val, 0, 127);
>         dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
