Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD3363BEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiK2LJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiK2LJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:09:31 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0422BC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:09:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n186so14759384oih.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cf9n2jaa6cYTVOklMuNk4qObbBfb+M49DmHuLPAMaG8=;
        b=EQGj1OluD1poCYCp847EqljBv2Ad7K/1G88aFPNPKXsuhiJcjMGoVE4O/IpTOi6grs
         DqYZyeMry7IkWAxmOVsObvHrdr/u4CHzPmyaVR8QTymd3X6LWpY0Dsxs/yLDVDP1VhaP
         tp0sWFghX2mKmvsrtbfPRU8FGxdMLOhH/VuekVTXfdKSaPfa9ZuHJakPCobD31IXWdp4
         +BqClWFUs/lL6XEYozaaPgS+KbkB5k3abcZ8TgF8IvK/p2du9FDw8FXQNZaIfLD9s93T
         2FlZyEzDBvaZtz6FcmRkxwdCpMNAMLiNpNr518cQA9GbdBTia3NupXIlr8ygDt2EeL6l
         ITAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf9n2jaa6cYTVOklMuNk4qObbBfb+M49DmHuLPAMaG8=;
        b=wYynDpaNVWCx/FwuDnN89b73zQbfJP7oMcPoc/L6axOy58ihbMjViyblYxPRRGKRCb
         SCSBKRPGbQzdk27SOkBQUtzZpk6wiAgtOXA5P85+yV2Swf5x746msj3Oa0ovqe8MQlkB
         fR1/7Achhrp9qWmrcvj8ZjGVaApo7VHAXi3fAOLSuStg1t3Rgtc5LwEsm/0ZlvFaiyn2
         MeW/Grh5R1QQmRR2c5AekRz6SerkCoNcmW4Z8SwseYSJpOc1u+lSX/Ioy5q/bfZNT9xl
         SBfZnm/ilXRQETWQOeRwpxIbyTDheQ3e5QnfZERM9H9IVjFCIJL068RYaCCLHH9HMAUu
         FGTg==
X-Gm-Message-State: ANoB5pkX/itb8We05OUO3pT5rKiiLr19GgI6+l4+2rDTb2sIhFUyO9SB
        aOhOK1KJWbKslqcxjd+bmyqgWcKis23HdC9nIEfCDA==
X-Google-Smtp-Source: AA0mqf5fbP4ZbObgYQ/PNpZohM7nKX0Xg43wC7ljqPSKkxNSoLuBv0Tby+XmsYnndNx6Rfpcz+xVv2PD+1lW35gFnFY=
X-Received: by 2002:aca:5bc4:0:b0:35a:7056:4f9c with SMTP id
 p187-20020aca5bc4000000b0035a70564f9cmr30858789oib.72.1669720170072; Tue, 29
 Nov 2022 03:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20221116143523.2126-1-the.cheaterman@gmail.com>
In-Reply-To: <20221116143523.2126-1-the.cheaterman@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 29 Nov 2022 12:09:19 +0100
Message-ID: <CAG3jFytyzmRnpj8pzSUitLhAHQM9b0zhkc2cbfVmgKStfHpwVA@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: dw_hdmi: fix preference of RGB modes over YUV420
To:     Guillaume BRUN <the.cheaterman@gmail.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 at 15:35, Guillaume BRUN <the.cheaterman@gmail.com> wrote:
>
> Cheap monitors sometimes advertise YUV modes they don't really have
> (HDMI specification mandates YUV support so even monitors without actual
> support will often wrongfully advertise it) which results in YUV matches
> and user forum complaints of a red tint to light colour display areas in
> common desktop environments.
>
> Moving the default RGB fall-back before YUV selection results in RGB
> mode matching in most cases, reducing complaints.
>
> Fixes: 6c3c719936da ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
> Signed-off-by: Guillaume BRUN <the.cheaterman@gmail.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 40d8ca37f5bc..aa51c61a78c7 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2720,6 +2720,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>          * if supported. In any case the default RGB888 format is added
>          */
>
> +       /* Default 8bit RGB fallback */
> +       output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> +
>         if (max_bpc >= 16 && info->bpc == 16) {
>                 if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
>                         output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
> @@ -2753,9 +2756,6 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>         if (info->color_formats & DRM_COLOR_FORMAT_YCBCR444)
>                 output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
>
> -       /* Default 8bit RGB fallback */
> -       output_fmts[i++] = MEDIA_BUS_FMT_RGB888_1X24;
> -
>         *num_output_fmts = i;
>
>         return output_fmts;
> --
> 2.37.3
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
