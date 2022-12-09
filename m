Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA66480A4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLIKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:09:59 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A82227CE0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:09:58 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id z12so261706qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MET+kFCxdRFSOqLhj+cqUkWiO2GHijv7TD+TrYs2J6g=;
        b=kFdKU6KSVYPDZISxGfROglkB3ZJTj3dRX1Du6W30RJq8g0X0WSQjCEmBOvtNMNocY2
         zHyRz6BEiFAiLB9C6n3ReZ8+ic9XG62DtNyAxLnOd9TLr1OfCY8ZbgfxLd1XVCySUf6t
         rTQ3s/vX1ifn6/0cqR4oRPHiDpik8s6XOOlBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MET+kFCxdRFSOqLhj+cqUkWiO2GHijv7TD+TrYs2J6g=;
        b=iOS5sz8kVZ3nluVezYfXAggEqW9dLAAgtLEhk8G29hlkc5SbdrCZHMRT5yJ+kQQBgh
         27+M6w3RTtEoL9x8YqWxO3wE7mJKc2qN7mKrm/YYnj7UCWLopGnQjfO0LIakf0PzOnoJ
         BT2t7xMaJaLqpgc5uFMMp7NQEWA0YyoBon+DaY033bfTkHil7L9y10uckB9oJ7BVBr7l
         qtwhlhO8lpOIhuQzw+BlKNIUSzNY27rcuzP49fP/duht4JQlwa5fZExLCCxUZy6cYNP2
         8vn06WZ/NQixe9Up5m7Z/WxywHoB7S+sdXan9tYj1kOXC4NgJMAuLplWycqCX+bz9niv
         mUxg==
X-Gm-Message-State: ANoB5pmcwoR822P2IHNEdjRaddu3oJEj+neaY2gmPRr+Lc8tYDRQ7uUw
        zFLfbyGFXxBZOZTpSw7s7M/zdHK5hyWM6UG8IRucrw==
X-Google-Smtp-Source: AA0mqf6fKRu84ern+dyhkt1nbBBrIimUzYhW8E7dwHUKYjkvzXRubt0s00UaPIfc5fUgi7GXtsXAHLl3cD81X/21SDs=
X-Received: by 2002:ac8:6798:0:b0:3a7:fda5:1a89 with SMTP id
 b24-20020ac86798000000b003a7fda51a89mr1146949qtp.108.1670580597239; Fri, 09
 Dec 2022 02:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20221209030418.713935-1-xji@analogixsemi.com>
In-Reply-To: <20221209030418.713935-1-xji@analogixsemi.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 9 Dec 2022 18:09:31 +0800
Message-ID: <CAJMQK-hTDv9FwQboeV2v9KwrNKAdYDjsEqCHcOqxqc2tkJEavA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: keep last configure timing
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 11:05 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> Sometimes kernel may resume back quickly after suspend,
> and DRM not call .mode_set() to re-config
> display timing before calling .atomic_enable(), bridge
> driver with this patch to keep last configure timing.
>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>

Acked-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index b0ff1ecb80a5..eb9116503b63 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1403,7 +1403,6 @@ static void anx7625_stop_dp_work(struct anx7625_data *ctx)
>  {
>         ctx->hpd_status = 0;
>         ctx->hpd_high_cnt = 0;
> -       ctx->display_timing_valid = 0;
>  }
>
>  static void anx7625_start_dp_work(struct anx7625_data *ctx)
> --
> 2.25.1
>
