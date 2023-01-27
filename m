Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441267ECFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjA0SCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbjA0SCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:02:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529717CCB9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:02:35 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw16so15771290ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2Q86j92pQ9q2wsMYUDefPiRAUR/rCfcZ3Y/y0U02v8=;
        b=CdDAORiYi7i8Rh5tx0vLXUjR6M49l7zi6wYWbctYHIiW9d5EDVrOzpXzWHxCvweTiM
         VsRE9D8RDYs6Gc07Ig3Gv2Goti67GkR3oaCqb91zHJ/hTw59daVB1+K0ukgP5parwwp9
         GZPYuqHvTRS3J1F85pOsxMJNi9unlWXkqxle8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2Q86j92pQ9q2wsMYUDefPiRAUR/rCfcZ3Y/y0U02v8=;
        b=v/GGe3Y9bhPM6S56G+rt95NpwAc8UA6Z9ujkeqETPIqgp7HOYwEK5ZwHRd0DXOP4Zj
         Pzy2Yforx0DbwAjBIpMvd2DF+H8TwX6+WpNC9lCjY0bpofkoD6XbymMrQSW27VlG7Me4
         WaMbe4zouV7EgHhhlgpYzYF3bHbtqDcGhLcIbcBahN0Fb3/e8+m5mZ7jGCTvcaMiHWXS
         ktJ/G1WtHwzFhE6CmXGFv+ogHnVDaaL7gquC3dvsleRzoxaSTq/pqRCWjZ/VVhU8r5Fr
         FmGEg4XDhFYeCmZkU6Q65oLRiMJoLDfkDrf+FVemtnAPknw5DIszm/2/jjeAQCa2m6Pj
         mYJg==
X-Gm-Message-State: AFqh2kpirUiexNfonR2xlIRbLT5XMrotNWj5qYrmkGybe9qvojoiw2Ye
        UOWdPDH7ODDEReq0BB2U84zHjJO1XtCD2Qu4WRc=
X-Google-Smtp-Source: AMrXdXtZJ7QuLiKv83mvgteNPI3W35XJBzP5NrdOjmgRSJdycTAKC21kVV208ESF9/crd+Jax+7nhg==
X-Received: by 2002:a17:906:c008:b0:859:1d78:765 with SMTP id e8-20020a170906c00800b008591d780765mr38784271ejz.11.1674842553765;
        Fri, 27 Jan 2023 10:02:33 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id s19-20020a1709060c1300b008699bacc03csm2647656ejf.14.2023.01.27.10.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 10:02:31 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id h12so5679625wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 10:02:31 -0800 (PST)
X-Received: by 2002:a5d:6b51:0:b0:2bf:c5cc:e1d6 with SMTP id
 x17-20020a5d6b51000000b002bfc5cce1d6mr164739wrw.659.1674842551177; Fri, 27
 Jan 2023 10:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20230127165409.3512501-1-robdclark@gmail.com>
In-Reply-To: <20230127165409.3512501-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 27 Jan 2023 10:02:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XL_KKB1vbU=gZVXYJzs4pLEnACysp0Q9DxhkHGTR9AgA@mail.gmail.com>
Message-ID: <CAD=FV=XL_KKB1vbU=gZVXYJzs4pLEnACysp0Q9DxhkHGTR9AgA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: Remove unused GEM DMA header include
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:DRM DRIVERS FOR MEDIATEK" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
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

On Fri, Jan 27, 2023 at 8:54 AM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> No longer needed since the removal of dependency on DMA helper.
>
> Fixes: 2ea8aec56bf1 ("drm/mediatek: Remove dependency on GEM DMA helper")
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reported-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cd5b18ef7951..7e2fad8e8444 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -20,8 +20,8 @@
>  #include <drm/drm_fbdev_generic.h>
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_gem.h>
> -#include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_ioctl.h>

It took me a little while to realize why you needed this extra
include. I guess DEFINE_DRM_GEM_FOPS implicitly refers to drm_ioctl().
Seems like really drm_gem.h ought to be the one including drm_ioctl.h,
but maybe there's a good reason why we don't do that?

-Doug
