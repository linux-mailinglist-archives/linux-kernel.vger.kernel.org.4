Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D496F87CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjEERlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjEERlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:41:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A34F1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A71F61486
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0438C433D2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683308475;
        bh=VXIPbVt5ooPbkAjjpZpHqh7KRKHYkPDMpipRC+g/0v0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SoSkJRVpidOcO8iGxxBhTDA6YM3VT93vI4KfhxkA9ESb4doBNTMO9HTEYKNYlgJ5q
         UmurNPr6kzsBAQ39jWnzonFivakdo8CJH2QHhVrx5qmHqfLigk2YLiWJ9hWj5IbGXO
         Ofsfd0aVFji9X/WTatbIP5IIZI6kn9LBin6QjmAmle6KnHvuxa5MMpPRnqg3dBiWQH
         MoTAym7TofKO/8QcuVNL7yq2hQ1BH3YCDwMCBIrpS7+La+mLrTvBxFgAQ3rdFfBnit
         P+hOaJeoxk6tSr+gaTlquPGBVA6Y01+V+zaSo2TPI+RNZ06eMIOi/m2NEy/n3rFZMO
         kF+YgcjIRGayw==
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-52160f75920so1408586a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:41:15 -0700 (PDT)
X-Gm-Message-State: AC+VfDxPrfEWQgnUMmZEEAKIbprFrA1JqAIKjAVsiXcAYoWa2cWfCFp5
        E+OA3dRHFcx6id22Iy4UBm2qQqXAfTTLK49n3JRlkQ==
X-Google-Smtp-Source: ACHHUZ7V0c8GuBWBpRyAstUWowwNQf+aYXoWkIYfxe801StPrNtcqkzx6w+RRrSKryhYqCm8BNK7dWJHW1lex6Pon8E=
X-Received: by 2002:a17:90b:3a8d:b0:23f:9fac:6b35 with SMTP id
 om13-20020a17090b3a8d00b0023f9fac6b35mr2173471pjb.39.1683308475334; Fri, 05
 May 2023 10:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-5-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-5-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 19:41:04 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4NmNbQ3dava=rr-Jx4tV37QD6=ujNq2bXDuSaoP8mdrQ@mail.gmail.com>
Message-ID: <CAN6tsi4NmNbQ3dava=rr-Jx4tV37QD6=ujNq2bXDuSaoP8mdrQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/9] drm/bridge: tc358768: fix TCLK_ZEROCNT computation
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
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> Correct computation of TCLK_ZEROCNT register.
>
> This register must be set to a value that ensure that
> (TCLK-PREPARECNT + TCLK-ZERO) > 300ns
>
> with the actual value of (TCLK-PREPARECNT + TCLK-ZERO) being
>
> (1 to 2) + (TCLK_ZEROCNT + 1)) x HSByteClkCycle + (PHY output delay)
>
> with PHY output delay being about
>
> (2 to 3) x MIPIBitClk cycle in the BitClk conversion.
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index dba1bf3912f1..aff400c36066 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -742,10 +742,10 @@ static void tc358768_bridge_pre_enable(struct drm_b=
ridge *bridge)
>
>         /* 38ns < TCLK_PREPARE < 95ns */
>         val =3D tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
> -       /* TCLK_PREPARE > 300ns */
> -       val2 =3D tc358768_ns_to_cnt(300 + tc358768_to_ns(3 * ui_nsk),
> -                                 dsibclk_nsk);
> -       val |=3D (val2 - tc358768_to_ns(phy_delay_nsk - dsibclk_nsk)) << =
8;
> +       /* TCLK_PREPARE + TCLK_ZERO > 300ns */
> +       val2 =3D tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
> +                                 dsibclk_nsk) - 2;
> +       val |=3D val2 << 8;
>         dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
