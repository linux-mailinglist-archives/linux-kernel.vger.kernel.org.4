Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE626F87B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjEERgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjEERf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6212705
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB53263F85
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDE9C433A0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683308155;
        bh=W4ROzuYY8hYvQggNUA8/ykiv3P1pvU1/88gNYpRZTZg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=amwyLMYQn67nKpkGSiA5hdQEr3zy/qjISEMZ64HPhtOPXzJx4eBRfVIUXwMkZqS0g
         SjzzwVmB4VfReB+/Hg2XSYc53XHz5+07+yojbxg842U6RouTdPHrrvS4JR/9eGShup
         rlBnNoJjZTT/sEnLLw2gfcTDh7hnR5DyCLwYkOXey+0JKarFZGOJk76GojZzk9LU1e
         xNdKo2wAat18OHJlpwXlC2sAAx0PhJZHyl7hCC9jpI3xFrObVr9I51ZUhjUI22SUFY
         dXLFBFocWfpIpwaECdAdtkrtu7anzf9pGYa7hInX81HP0IZaKvbmt9SJKlJyeqVDIG
         6WlE/v1jWSfWA==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-24e2bbec3d5so1522454a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:35:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDziHogPuKoH6CvUTecnlCKzQKKwlOmx7viM0hyu0Ek62OlgP8ji
        I11mB4Rr1V5NMsTQkcx5hMofyiUIZCGi/lHlJ5iGZQ==
X-Google-Smtp-Source: ACHHUZ7A8rFVuk/lhYjJRPuUOZS0temTku2flHOg/BYTVes/Z0tlOBknCt0WKgbNdU0+IhzhmGHT0DgBtpfMGz22zU4=
X-Received: by 2002:a17:90a:cd03:b0:250:275e:e154 with SMTP id
 d3-20020a17090acd0300b00250275ee154mr2207153pju.2.1683308154470; Fri, 05 May
 2023 10:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-2-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-2-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 19:35:43 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7Ja3jhMJEEU2AaGm9A9uRjMK_hhXHF_iTDcbmpbZxvCg@mail.gmail.com>
Message-ID: <CAN6tsi7Ja3jhMJEEU2AaGm9A9uRjMK_hhXHF_iTDcbmpbZxvCg@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] drm/bridge: tc358768: always enable HS video mode
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

On Thu, Apr 27, 2023 at 4:34=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Always enable HS video mode setting the TXMD bit, without this change no
> video output is present with DSI sinks that are setting
> MIPI_DSI_MODE_LPM flag (tested with LT8912B DSI-HDMI bridge).
>
> Previously the driver was enabling HS mode only when the DSI sink was
> not explicitly setting the MIPI_DSI_MODE_LPM, however this is not
> correct.
>
> The MIPI_DSI_MODE_LPM is supposed to indicate that the sink is willing
> to receive data in low power mode, however clearing the
> TC358768_DSI_CONTROL_TXMD bit will make the TC358768 send video in
> LP mode that is not the intended behavior.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 7c0cbe84611b..8f349bf4fc32 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -866,8 +866,7 @@ static void tc358768_bridge_pre_enable(struct drm_bri=
dge *bridge)
>         val =3D TC358768_DSI_CONFW_MODE_SET | TC358768_DSI_CONFW_ADDR_DSI=
_CONTROL;
>         val |=3D (dsi_dev->lanes - 1) << 1;
>
> -       if (!(dsi_dev->mode_flags & MIPI_DSI_MODE_LPM))
> -               val |=3D TC358768_DSI_CONTROL_TXMD;
> +       val |=3D TC358768_DSI_CONTROL_TXMD;
>
>         if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
>                 val |=3D TC358768_DSI_CONTROL_HSCKMD;
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
