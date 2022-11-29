Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5EF63B6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiK2BOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiK2BOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:14:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628DD21E2F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:14:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m19so16575095edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DGaZ8OVtGKgX/mLPb9bYbnNCU4GtJ5ZaE5Va30mZJao=;
        b=ELTV3dgIgDmcf8n+nhp3+EKzarX3RK5zG2X2Wj1L32uLqyj40nfyvEwXi1rdM+K6N5
         2hubboKg8Rv6AiOgSqoaKJ/blr/UIDCSePyTPKtMKEKulQKmEfLPTI8ocUkX+jqDNkGm
         4AE88T0j+84vh8oSq1xNrZK2YtsYqNB1E5H6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGaZ8OVtGKgX/mLPb9bYbnNCU4GtJ5ZaE5Va30mZJao=;
        b=cnRfo2naQh/+iQvJMySqbupipfrDWWoTRPuKLk5TeYxHIpTXOWYP5g94ig0oqcuyOv
         ytmsaM7RBNlb4IYgpPa00DOv9ikIG/BNNPT2/ILueYkoDqr7ypE5GUAYcOmUBXidTE9g
         KySwsshNCgcwrbgaXA18nXo+/BjjVDq1zABi7RaBI89GIj1xMt2dcItU0zPjdy+VVlEE
         Gzac6+YHsqjcSOlAVX2NOjkwWiHKM2eNALrF/VtUCRRdnqamIyHbGa4RgmHzxJRdeJjz
         UTgVv6PWiI+M5ZMWl1cM1VlB7bt8AirAmCk+B6UwT0PN1P2yFBgCAQhdR9XLw22cUigk
         xa6g==
X-Gm-Message-State: ANoB5pngWDGJV9kyaa0UUGoEWClhtRFAOey1DvkMcCxE5atPsKAmRCoo
        owRA0sb8S1VY68cJwlmqHj8UXP/dpuz1vWCn
X-Google-Smtp-Source: AA0mqf7O4/Qa3g6hT0TOaOB1G1ZW2d8IrAWRBdmw2Vd+Tl6GVlnZwcKYEKrQtYijpbeu5eSGsZFdoA==
X-Received: by 2002:a05:6402:2b87:b0:45b:c731:b683 with SMTP id fj7-20020a0564022b8700b0045bc731b683mr51560869edb.251.1669684445760;
        Mon, 28 Nov 2022 17:14:05 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id f2-20020a056402194200b0046182b3ad46sm2128712edz.20.2022.11.28.17.14.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:14:03 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id bs21so19768945wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 17:14:02 -0800 (PST)
X-Received: by 2002:adf:fb4c:0:b0:236:5270:735e with SMTP id
 c12-20020adffb4c000000b002365270735emr22142643wrs.659.1669684442306; Mon, 28
 Nov 2022 17:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
In-Reply-To: <20221125104558.84616-1-eddy.zhang@rock-chips.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Nov 2022 17:13:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XAU8qQ1tFV9_4FF9Rd7ouT5ORzt6JUnQ4KqJgRsEXqHw@mail.gmail.com>
Message-ID: <CAD=FV=XAU8qQ1tFV9_4FF9Rd7ouT5ORzt6JUnQ4KqJgRsEXqHw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Fix output polarity setting bug
To:     Qiqi Zhang <eddy.zhang@rock-chips.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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

On Fri, Nov 25, 2022 at 2:54 AM Qiqi Zhang <eddy.zhang@rock-chips.com> wrote:
>
> According to the description in ti-sn65dsi86's datasheet:
>
> CHA_HSYNC_POLARITY:
> 0 = Active High Pulse. Synchronization signal is high for the sync
> pulse width. (default)
> 1 = Active Low Pulse. Synchronization signal is low for the sync
> pulse width.
>
> CHA_VSYNC_POLARITY:
> 0 = Active High Pulse. Synchronization signal is high for the sync
> pulse width. (Default)
> 1 = Active Low Pulse. Synchronization signal is low for the sync
> pulse width.
>
> We should only set these bits when the polarity is negative.
> Signed-off-by: Qiqi Zhang <eddy.zhang@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 3c3561942eb6..eb24322df721 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -931,9 +931,9 @@ static void ti_sn_bridge_set_video_timings(struct ti_sn65dsi86 *pdata)
>                 &pdata->bridge.encoder->crtc->state->adjusted_mode;
>         u8 hsync_polarity = 0, vsync_polarity = 0;
>
> -       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
>                 hsync_polarity = CHA_HSYNC_POLARITY;
> -       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> +       if (mode->flags & DRM_MODE_FLAG_NVSYNC)
>                 vsync_polarity = CHA_VSYNC_POLARITY;

Looks right to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I've never seen the polarity matter for any eDP panels I've worked
with, which presumably explains why this was wrong for so long. As far
as I can tell, it's been wrong since the start. Probably you should
have:

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")

I put this on a sc7180-trogdor-lazor device and it didn't make
anything worse. Since the sync polarity never mattered to begin with,
I guess this isn't a surprise. ...so I guess that's a weak tested-by:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'm happy to land this patch, but sounds like we're hoping to get
extra testing so I'll hold off for now.

-Doug
