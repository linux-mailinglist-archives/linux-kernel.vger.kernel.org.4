Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6634E6F885B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjEESEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEESEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E0C1C0DC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12B6C614CB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3DCC4339E
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683309835;
        bh=6CQmJHAWv2zDJ+V7xR9gAKn2jhIg2rUcA8a989LpS1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bGPkNtKVKiU+1j6F2yY+dwXD54ldT1TDiGkj60HMKi2Xr893dwH+9aR3dQKrQ/Ky2
         EGFOUnudWAU31098IkprQQ+jflV1seZ6anJl7ZS5NXtO5EJ9xvhkDO8cGGjvsMMl02
         p9ngwx3PzUp8UkfsPGU/EkABrp+CQ+KuDb/tjMXzgy2KCkNmkKjfhzX8od0CA2/1S5
         QgOIu9iqp/dSOTE5FfYByitMahjYhRizQRI4lCNbVd8CtgUkghZQZSluOOnoVoAzh5
         t75LwFzgZn3+EFUPoHc/tEisfR23JLb2YZZpZkpqrr+HNW13oSRgeihtqW+MV5iK/R
         A6nYiy63cBFnQ==
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517c01edaaaso1355245a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:03:55 -0700 (PDT)
X-Gm-Message-State: AC+VfDywMXPa0bJrIOgDmoBndz/XqTSicPyI0bztNcilgt1+kntuMUQr
        EtF5Md0S/B2XQ3ctWYKDAbEhXVJ390z/hGKln7EKoQ==
X-Google-Smtp-Source: ACHHUZ6GhU4tZQ4aNyZmwtwzcljwMUMcubqi7oUVmu04qxww0SbT48JgMoCp4Jsh0NuyJYzoTY/2qec9nohy44O1dQ4=
X-Received: by 2002:a17:90a:9112:b0:24e:2d3:a404 with SMTP id
 k18-20020a17090a911200b0024e02d3a404mr2416525pjo.4.1683309834972; Fri, 05 May
 2023 11:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-8-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-8-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 20:03:44 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6VuPQuH1LRMFGKs6f6NzTrFZcjtw+GUx-P2CpdbEbdxg@mail.gmail.com>
Message-ID: <CAN6tsi6VuPQuH1LRMFGKs6f6NzTrFZcjtw+GUx-P2CpdbEbdxg@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] drm/bridge: tc358768: fix TXTAGOCNT computation
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

On Thu, Apr 27, 2023 at 4:35=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correct computation of TXTAGOCNT register.
>
> This register must be set to a value that ensure that the
> TTA-GO period =3D (4 x TLPX)
>
> with the actual value of TTA-GO being
>
> 4 x (TXTAGOCNT + 1) x (HSByteClk cycle)
>
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 36e33cba59a2..854fc04f08d0 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -795,7 +795,7 @@ static void tc358768_bridge_pre_enable(struct drm_bri=
dge *bridge)
>
>         /* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
>         val =3D tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
> -       val =3D tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
> +       val =3D tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
>         val2 =3D tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibcl=
k_nsk),
>                                   dsibclk_nsk) - 2;
>         val =3D val << 16 | val2;
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
