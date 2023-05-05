Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F363D6F8853
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjEESAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjEESAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:00:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954A01BDD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323C963FC0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C8C433A8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683309642;
        bh=xErPs+VqEKdkUkp1VUoR5GVkI6OEzsZUpFt685ro0k8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fGylqDF9vB56uuxd7oA0tqiP76AuKj42WB4/hkWQ7l03u4hiA7eKuEhJvoecZRls0
         fY1dsdvDdzoEVKRrTeye8E7Q8EC+EMAT7MTjA56/FjuEkPO9Cgqhjh/vSIqDAiXzBt
         Szqxs6KW5hFtqWEg9+9UthQD92bVGqglwStRJWkaEIWm8di8TK5EcaH5Y04c8IO5TM
         EY0dEG3xqTrjSHEfwARi5FcTfnAvIod0V212zm9EpQDJ9zePE2RsSxi0DN6mD9sO1G
         qctleqRRZdLWVIYGfVmtQBHKXjcMkvMj8oUegRPAh7+xNijUTFj2JuxDOT0rX22FD8
         9wbrOcWAN8KJg==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-24e16918323so1525882a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 11:00:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDycyOzbF9BDurrGuOcXhKBiaz/JctSPVRknTQ7kFfl99NqpgN0X
        rL/2d7ovP8ymYe62iOXhjsVSG7nJI+MAYpob5Bqfwg==
X-Google-Smtp-Source: ACHHUZ4Czw82TyqnQb9t53sAiUwOEjTQ/bcQcjn2nZZ0qsZ1UQt8q6NiOEFe/BHJaQDmvZq9j+UJj0QfVee4t8kB0C8=
X-Received: by 2002:a17:90a:2bc5:b0:24e:993:115c with SMTP id
 n5-20020a17090a2bc500b0024e0993115cmr2245759pje.43.1683309642065; Fri, 05 May
 2023 11:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230427142934.55435-1-francesco@dolcini.it> <20230427142934.55435-7-francesco@dolcini.it>
In-Reply-To: <20230427142934.55435-7-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 5 May 2023 20:00:30 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4YdZ976bzy1xxVh=aBd56zJkipe87iEqPUOQD1PC1R5A@mail.gmail.com>
Message-ID: <CAN6tsi4YdZ976bzy1xxVh=aBd56zJkipe87iEqPUOQD1PC1R5A@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] drm/bridge: tc358768: fix THS_ZEROCNT computation
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

On Thu, Apr 27, 2023 at 4:33=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Correct computation of THS_ZEROCNT register.
>
> This register must be set to a value that ensure that
> THS_PREPARE + THS_ZERO > 145ns + 10*UI
>
> with the actual value of (THS_PREPARE + THS_ZERO) being
>
> ((1 to 2) + 1 + (TCLK_ZEROCNT + 1) + (3 to 4)) x ByteClk cycle +
>   + HSByteClk x (2 + (1 to 2)) + (PHY delay)
>
> with PHY delay being about
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
> index 360c7c65f8c4..36e33cba59a2 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -760,9 +760,10 @@ static void tc358768_bridge_pre_enable(struct drm_br=
idge *bridge)
>         /* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
>         val =3D 50 + tc358768_to_ns(4 * ui_nsk);
>         val =3D tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
> -       /* THS_ZERO > 145ns + 10*UI */
> -       val2 =3D tc358768_ns_to_cnt(145 - tc358768_to_ns(ui_nsk), dsibclk=
_nsk);
> -       val |=3D (val2 - tc358768_to_ns(phy_delay_nsk)) << 8;
> +       /* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
> +       raw_val =3D tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), =
dsibclk_nsk) - 10;
> +       val2 =3D clamp(raw_val, 0, 127);
> +       val |=3D val2 << 8;
>         dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
>         tc358768_write(priv, TC358768_THS_HEADERCNT, val);
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
