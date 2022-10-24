Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A892609BD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJXHyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJXHyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:54:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09658558C4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:54:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x2so816157edd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=np2MboBXPdpCjk4yE/v8jv8Cr7DEE4vCXR9aVi6NMuQ=;
        b=CMfk1o4OzpbnoEvbhSyBTJsc/lrFji4JSwldqbnj0/xw470NWf7R+wmCYUepa+ANkJ
         5CeKo+mBrV14/fFMP8oBwYEsPOFmx0WtYZpdB4J3MFuHO2oyRtloK7Z7tkh/cC1UdlpZ
         c7a6zfTprLyLbJmyuI5W0tu6AGhJtfxkY6J3ihr1hhZq4NUoHfG0jKZPbqLU2/mFLCog
         c8nfgJncBPWcxcmDo0iowNsBIaBfTau0X7FrfJ/uM8g0rNHwu5NxkETe2Hj/euYNdwaU
         t7iXge1x2pLZqxc29oeANjgRIAa7iPWvIBDoRUqShLblruOgKxIodgqvYcacLKeIg/hN
         0wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np2MboBXPdpCjk4yE/v8jv8Cr7DEE4vCXR9aVi6NMuQ=;
        b=NmwoKIwP4xH1cs+t2jymv/jtpighyiJII8Lz5bpdHE+FeHsmO6VyegjLAvJyC3K653
         dVj/QzL0kP0sz26rbIPvlzxvUwLlq99ZCMRjnjr15/ap+/caYgeiJNGOuuljAWh4InEv
         dZCv1/a7VhL8xsUKqLDQl6N/osvrJqTrKgAl268r2Cj5j5zvlW8QyEP6bcT0lD50VG1q
         nE5rfsfyspmKpYMLN4dEZKjUWAZoHNwI9abRyrv3MCk9XWGHji0vkoH8XVtmTjSroNAa
         DXusEUdMfLPFYDEG3uc3orKJNOH5K0mA4UC+5toPk7GMGghPGokgNTZykWK1zzuin0AB
         QC8A==
X-Gm-Message-State: ACrzQf2jLM2wWC7ZTgmbUD03DZZFCiYatPt/Q67vsxDTYDbdOORdQv5x
        1qvyaw4Km4Iro7TT2A9TPVTQgQiTB9vc4uwgu22CUQ==
X-Google-Smtp-Source: AMsMyM5RUZsUyR2VAgEGNQhyqaYgUWUOzkKTKiVhONd3/DbV5cnoVhbDHvfQmdSFYJzw5VqN16sbZw1Hkcd5ncPmz8k=
X-Received: by 2002:aa7:c792:0:b0:453:98b7:213c with SMTP id
 n18-20020aa7c792000000b0045398b7213cmr29135252eds.159.1666598050510; Mon, 24
 Oct 2022 00:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221013110411.1674359-1-treapking@chromium.org> <20221013110411.1674359-2-treapking@chromium.org>
In-Reply-To: <20221013110411.1674359-2-treapking@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 24 Oct 2022 09:53:59 +0200
Message-ID: <CAG3jFyusEzjGN5qmXXfQSpYoPudOGTXHsOpucqbVhN0Zr9nBbw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/bridge: it6505: Initialize AUX channel in it6505_i2c_probe
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 at 13:04, Pin-yen Lin <treapking@chromium.org> wrote:
>
> During device boot, the HPD interrupt could be triggered before the DRM
> subsystem registers it6505 as a DRM bridge. In such cases, the driver
> tries to access AUX channel and causes NULL pointer dereference.
> Initializing the AUX channel earlier to prevent such error.
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/gpu/drm/bridge/ite-it6505.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index a4302492cf8d..f7f6c3e20fae 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -2871,10 +2871,7 @@ static int it6505_bridge_attach(struct drm_bridge *bridge,
>         }
>
>         /* Register aux channel */
> -       it6505->aux.name = "DP-AUX";
> -       it6505->aux.dev = dev;
>         it6505->aux.drm_dev = bridge->dev;
> -       it6505->aux.transfer = it6505_aux_transfer;
>
>         ret = drm_dp_aux_register(&it6505->aux);
>
> @@ -3354,6 +3351,11 @@ static int it6505_i2c_probe(struct i2c_client *client,
>         debugfs_init(it6505);
>         pm_runtime_enable(dev);
>
> +       it6505->aux.name = "DP-AUX";
> +       it6505->aux.dev = dev;
> +       it6505->aux.transfer = it6505_aux_transfer;
> +       drm_dp_aux_init(&it6505->aux);
> +
>         it6505->bridge.funcs = &it6505_bridge_funcs;
>         it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
>         it6505->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
