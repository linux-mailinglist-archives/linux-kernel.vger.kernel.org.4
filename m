Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EE64DA19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLOLOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLOLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:14:33 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9582A713
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:14:30 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1447c7aa004so20465194fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5fr4gxcVjc8CL9ZfRWUTh2EMQZ1tDH3lBxxvI+OSGE=;
        b=QwvuDGM8ZyygeBDcwhmIEH9zfT446KZK9OhIUxOEpvRB3EHL/GxDQJZcPxL/mejlkP
         QvbMftVSqo9vqKT3m4OxfIqtY/hG59lB+tiopaQ330pLo+xTIffq4n6V5xXYPJDwIoXo
         4B/DdwZPZG0c6PkzQAXI4m9qUCb6kREVIov2cKAnBqArqkyoaPb1kuIGO8kY6qYQmfBJ
         eQg2p+6o6DQ8v0ubrSeEdwV+ZV6QlsEOzENfesJPrqMT/QDhtQ3hI4DG8cJ6GmEeLKUU
         Q9fJADNoGBRW8NwpuOCUJeHt55JV8rpMW1t+rpW6hRJcNGvkuGbx0oIrf88x5A2Z/ClA
         kjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5fr4gxcVjc8CL9ZfRWUTh2EMQZ1tDH3lBxxvI+OSGE=;
        b=66jkNrdZmd6O+s4JcJwxN0H9y0C1WgIZEAMCj0FxjVg8Xokw9krUuxb7kxeGd2lxNj
         M5TWsCbmh+QGSKnASr3GuqkVH4xv1uMPLjxAipJsvjkvBoCXppbHfV50ATfbq3CQKAf1
         4FeSCSCKdBpalFZk0zYfnQs0OGdI6ObAqubjbe9Yidc5HBpZSw/aCUlA5FxwM7aGdtPm
         1kskSdnwUX2dhnkWyx23PcpoToqKLyBUX+j/9Y6wSl/qNkGzIYTfZizyK2uerFCFZZyz
         QTYhJnv8LEDZYac6z/MnhDZDYAlxxSnm+XVBE9PNvZxN+u180RCTWUbTS6T7Fid8zaY/
         8nzw==
X-Gm-Message-State: AFqh2kr0SbrsdR0LsZkMi3UL1QGR8El7i9hQvAOpMf3Z/w+dDTptKKWt
        TZ7eRhOngUoZiFhRDE3aAFz4bamxOtoedKV24miXbw==
X-Google-Smtp-Source: AA0mqf6quCz8KDvBxxZEwcDqLtkYPh9KhjhUgQFkL5EDWWeQGWdZbtOOmQW7301huPxm4rjA8jIyc2peFeFI57VlQyE=
X-Received: by 2002:a05:6870:9e4c:b0:13c:33d0:22e2 with SMTP id
 pt12-20020a0568709e4c00b0013c33d022e2mr591942oab.14.1671102870205; Thu, 15
 Dec 2022 03:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214125821.12489-6-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-6-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 12:14:19 +0100
Message-ID: <CAG3jFyu8tjBRNANsOKfpOXJCNVP9FFjT9Q6n4KHBkDVZM5KKTw@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm: bridge: it66121: Fix wait for DDC ready
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 13:59, Paul Cercueil <paul@crapouillou.net> wrote:
>
> The function it66121_wait_ddc_ready() would previously read the status
> register until "true", which means it never actually polled anything and
> would just read the register once.
>
> Now, it will properly wait until the DDC hardware is ready or until it
> reported an error.
>
> The 'busy' variable was also renamed to 'error' since these bits are set
> on error and not when the DDC hardware is busy.
>
> Since the DDC ready function is now working properly, the msleep(20) can
> be removed.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 0a4fdfd7af44..bfb9c87a7019 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -440,15 +440,17 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
>  static inline int it66121_wait_ddc_ready(struct it66121_ctx *ctx)
>  {
>         int ret, val;
> -       u32 busy = IT66121_DDC_STATUS_NOACK | IT66121_DDC_STATUS_WAIT_BUS |
> -                  IT66121_DDC_STATUS_ARBI_LOSE;
> +       u32 error = IT66121_DDC_STATUS_NOACK | IT66121_DDC_STATUS_WAIT_BUS |
> +                   IT66121_DDC_STATUS_ARBI_LOSE;
> +       u32 done = IT66121_DDC_STATUS_TX_DONE;
>
> -       ret = regmap_read_poll_timeout(ctx->regmap, IT66121_DDC_STATUS_REG, val, true,
> -                                      IT66121_EDID_SLEEP_US, IT66121_EDID_TIMEOUT_US);
> +       ret = regmap_read_poll_timeout(ctx->regmap, IT66121_DDC_STATUS_REG, val,
> +                                      val & (error | done), IT66121_EDID_SLEEP_US,
> +                                      IT66121_EDID_TIMEOUT_US);
>         if (ret)
>                 return ret;
>
> -       if (val & busy)
> +       if (val & error)
>                 return -EAGAIN;
>
>         return 0;
> @@ -582,9 +584,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>                 offset += cnt;
>                 remain -= cnt;
>
> -               /* Per programming manual, sleep here before emptying the FIFO */
> -               msleep(20);
> -
>                 ret = it66121_wait_ddc_ready(ctx);
>                 if (ret)
>                         return ret;
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
