Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21BE686325
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbjBAJv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBAJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:51:25 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCB269F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:51:24 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id y8so19086947vsq.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/VlM7cprC4lMoay4b4iDq0wmzylPk+HkhDJk/zhG2Y=;
        b=H3SQNrssQf8a9mTT6XChvo0/W1NYkCLCBXshDml7DWgkvDYxMHwm3SC1Spd2lhiXKz
         uqQse5Gqzkvx46gI2HD/aq6q60VRJ1LYYGzlhCIW/bsZ8DqRa32+jqSw1NSfiXJZMPku
         FTTzBF0TKGM6zy3JEmmFBiESFxzq9OuUtyPPZEE4oynJCKrWauGmBcn23ItXCkhqRcJ6
         f0JUMeeVAzoFk5xR5dqiDz7wzkc3F+25pY+GVDVxJF2vz3hWnvytxNQ/XaxCVx9gTTnU
         bulEHDn9yZzFvHsawWaSIa/q66TkSaCCPty63/w5PoFd6gfWMVKsv128YlaS6NIp1lCv
         gyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/VlM7cprC4lMoay4b4iDq0wmzylPk+HkhDJk/zhG2Y=;
        b=s9Xn++5vwTZEeBFKsQ0kySh30yutxOVRfl6LTgdtX362xYG0mL074Rahnsn4MptQUU
         JqRJpPOUqtxOEn7emBWb0s9+30UMWxBoCjlsuTlun8KXGqXq375YCUgOtLDk1eJXFsjD
         IqXmjUXJniRzD6f750R1LVwXXGcCCSZONzhQHLx+4MZKawhDkHXF/t+/admpgciAJfji
         0y6r1KBIAWicI5FKh6vgyE6Qn29FNFrG+uDMCKrB9WixTWJzI1dWN9LIzeIvVWTnNVkz
         emcbkdGwbIxguqPAYa1hIuv/JUCSENoSQOreC/dQc99oqeWsxw/F7Xdl/zw45HpkDw9f
         aC7w==
X-Gm-Message-State: AO0yUKWmbpSF8dEy1pEK3sxRIJ0+VeCa8TKpIOg+CB4nDLARGmi20sjj
        H+O5D53zhVH7n2TZJZuEX8i7y9gzD/mnWHVJEEg+sQ==
X-Google-Smtp-Source: AK7set86IzPhUo1uZ+cu7Tw/u3cqoDAPwj0LQna9LX1UbPlTaCnreZPgZXNal+QPDxwu/wJrvnP7JMh4zKK+BBpDqY8=
X-Received: by 2002:a05:6102:1609:b0:3ed:2cb7:5695 with SMTP id
 cu9-20020a056102160900b003ed2cb75695mr375015vsb.84.1675245083209; Wed, 01 Feb
 2023 01:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
In-Reply-To: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Wed, 1 Feb 2023 09:51:06 +0000
Message-ID: <CAPY8ntAUhVB6UtQTeHAcxNW950Ou+NcEoGwk3JnVWLay89_0Nw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set pre_enable_prev_first
To:     Douglas Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 at 22:22, Douglas Anderson <dianders@chromium.org> wrote:
>
> Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
> ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
> order"). This should allow us to revert commit ec7981e6c614
> ("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") and
> commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> time").

I see no reference in the TC358762 datasheet to requiring the DSI
interface to be in any particular state.
However, setting this flag does mean that the DSI host doesn't need to
power up and down for each host_transfer request from
tc358762_pre_enable/tc358762_init, so on that basis I'm good with it.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/bridge/tc358762.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
> index 0b6a28436885..77f7f7f54757 100644
> --- a/drivers/gpu/drm/bridge/tc358762.c
> +++ b/drivers/gpu/drm/bridge/tc358762.c
> @@ -229,6 +229,7 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>         ctx->bridge.funcs = &tc358762_bridge_funcs;
>         ctx->bridge.type = DRM_MODE_CONNECTOR_DPI;
>         ctx->bridge.of_node = dev->of_node;
> +       ctx->bridge.pre_enable_prev_first = true;
>
>         drm_bridge_add(&ctx->bridge);
>
> --
> 2.39.1.456.gfc5497dd1b-goog
>
