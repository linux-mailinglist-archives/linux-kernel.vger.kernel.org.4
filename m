Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272F463D89F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiK3O61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiK3O6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:58:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8D286CD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:58:23 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id e27so41968614ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iUf7tHbOiTNFxm9NG1RAoNmYcPKyh2MOWhQXpw+Jkiw=;
        b=A8aEOTll3/YjbHk0UTM1xHykcTPnT60aMQD4cX4BswRSwu55TFbnZ2y7phFBPvFEgR
         ad+ilkzGeMWMJ7yH5g0KEF5FaAq+zAM/qCpNs3tPjD/7spSo9QMLEMzlMZfYi4DNaVlz
         5zujILxnGiBtxNbxGsUyWoM6YSqVtP1TwDUA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUf7tHbOiTNFxm9NG1RAoNmYcPKyh2MOWhQXpw+Jkiw=;
        b=XJ2V6CllhqLxGaHxNKqFigu4qqFhsg0RP6LimpfUrQniPFg88zEpHcGSP/UazWoio5
         i2crTIJDKcD+uzaztFuOSM+BVWRfoEn66h4za3MEIEJ3weml4VcsGeQRms/kD3v3Ilum
         aj2j94WCzF41HeC7V4VAibMaeGEpnoGXLK/8fp2stoA54RC9y9X8AXUV3cnAhZ58l3el
         +NsE3/JpcZooa6RBstq+Bp2srpiat6XZ0DLbJNshw6R5d3B3x7odOi9tMJ1PjGRrydQh
         iLa5AJIwHTNqZ3RPO9aIz9ylaIT5/it/dH7VS/6DFH8CWoC4ExcLTFTnxv7O3Jowi4tG
         mkoA==
X-Gm-Message-State: ANoB5plzm0/0LUwbvqJwVrb8evHgKYdMJJMqb7guf6qTYYJMgdg80dCO
        mzXrdvS3Jyfu+COraKxLGecyUxzeWf5l8qYl
X-Google-Smtp-Source: AA0mqf5CyY/60CG0cTzaulnJCjA9y0tkoB4dWAu2GMSOhPnlLXzDhAWRgDwBJ4Lwl4xrLIpFujny9w==
X-Received: by 2002:a17:907:3fa9:b0:7bf:5446:389d with SMTP id hr41-20020a1709073fa900b007bf5446389dmr14326149ejc.449.1669820301493;
        Wed, 30 Nov 2022 06:58:21 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm714143ejc.210.2022.11.30.06.58.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 06:58:20 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id g12so27471697wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:58:19 -0800 (PST)
X-Received: by 2002:a5d:6409:0:b0:241:f7ae:b1dd with SMTP id
 z9-20020a5d6409000000b00241f7aeb1ddmr21393491wru.138.1669820299103; Wed, 30
 Nov 2022 06:58:19 -0800 (PST)
MIME-Version: 1.0
References: <34c2e9c8-9e3d-129c-8295-18ff440f1f84@ideasonboard.com> <20221130054551.112944-1-eddy.zhang@rock-chips.com>
In-Reply-To: <20221130054551.112944-1-eddy.zhang@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Nov 2022 06:58:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WRbg=VyNHfteBBuijC-uhx5Oyc2TX40BEQ2SHv6s=puQ@mail.gmail.com>
Message-ID: <CAD=FV=WRbg=VyNHfteBBuijC-uhx5Oyc2TX40BEQ2SHv6s=puQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
To:     Qiqi Zhang <eddy.zhang@rock-chips.com>
Cc:     tomi.valkeinen@ideasonboard.com, Laurent.pinchart@ideasonboard.com,
        airlied@gmail.com, andrzej.hajda@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        jonas@kwiboo.se, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org, robert.foss@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 29, 2022 at 9:46 PM Qiqi Zhang <eddy.zhang@rock-chips.com> wrote:
>
> Hi,
>
> on Nov. 29, 2022, 11:45 a.m. Tomi wrote:
> >On 29/11/2022 03:13, Doug Anderson wrote:
> >> Hi,
> >>
> >> On Fri, Nov 25, 2022 at 2:54 AM Qiqi Zhang <eddy.zhang@rock-chips.com> wrote:
> >>>
> >>> According to the description in ti-sn65dsi86's datasheet:
> >>>
> >>> CHA_HSYNC_POLARITY:
> >>> 0 = Active High Pulse. Synchronization signal is high for the sync
> >>> pulse width. (default)
> >>> 1 = Active Low Pulse. Synchronization signal is low for the sync
> >>> pulse width.
> >>>
> >>> CHA_VSYNC_POLARITY:
> >>> 0 = Active High Pulse. Synchronization signal is high for the sync
> >>> pulse width. (Default)
> >>> 1 = Active Low Pulse. Synchronization signal is low for the sync
> >>> pulse width.
> >>>
> >>> We should only set these bits when the polarity is negative.
> >>> Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
> >>> ---
> >>>   drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
> >>>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >>> index 3c3561942eb6..eb24322df721 100644
> >>> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >>> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> >>> @@ -931,9 +931,9 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
> >>>                  &pdata->bridge.encoder->crtc->state->adjusted_mode;
> >>>          u8 hsync_polarity = 0, vsync_polarity = 0;
> >>>
> >>> -       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >>> +       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> >>>                  hsync_polarity = CHA_HSYNC_POLARITY;
> >>> -       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >>> +       if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> >>>                  vsync_polarity = CHA_VSYNC_POLARITY;
> >>
> >> Looks right to me.
> >>
> >> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> I've never seen the polarity matter for any eDP panels I've worked
> >> with, which presumably explains why this was wrong for so long. As far
> >
> >Afaik, DP doesn't have sync polarity as such (neither does DSI), and the
> >sync polarity is just "metadata". So if you're in full-DP domain, I
> >don't see why it would matter. I guess it becomes relevant when you
> >convert from DP to some other bus format.
>
> Just like Tomi said, the wrong polarity worked fine on my eDP panel(LP079QX1)
> and standard DP monitor, I didn't notice the polarity configuration problem
> here until my customer used the following solution and got a abnormal display:
> GPU->mipi->eDP->DP->lvds->panel.

Wow, that's convoluted, but makes sense. I think this fully explains
why this is a problem for you but wasn't in the past.


> >> as I can tell, it's been wrong since the start. Probably you should
> >> have:
> >>
> >> Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
>
> Doug you mean I need to update my commit message? It's my first time using
> kernel list and I'm a little confused about this.

Nah, I'll add it in and land it. OK, pushed to drm-misc-fixes:

8c115864501f drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
