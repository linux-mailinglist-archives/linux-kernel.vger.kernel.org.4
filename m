Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA8C64DA28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiLOLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLOLS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:18:58 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6665011476
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:18:57 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-142b72a728fso20500481fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fn2zqsPP+08QxWZvX7V1h6FJWl/peZq+mwwcgAj4da0=;
        b=ZZXgJ0SUB44KDY6gXkxUTEMuEZUHXnx/FLPnvhTfEOkdbaTyTDGtld0l7ocT3gJJP1
         fDyF6DDXMrVgtV8HLG5c37Ocndoh/gV6V0gZ+jtMfRZO0eKaMF6oCMYXch9xs+JBqaHz
         wxEOhI1dVAW6b/vZN6SOPxfz+mTvr60HekVWYeMrGsU0FyjMb9FNCmTyQIkvACjZFmAP
         Tarf3aElOufDj2aK3j5Wt2FaExPBoY4W5rEQtD19fcTJNIulnl9rY5CHGVyVG5p8TGrF
         TYNcC6IvJ279xoyprGSysoMJmPfoMiVdjadER0cTL1AwO0CjsHFzzjaKIgMHM97lHQYe
         yfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn2zqsPP+08QxWZvX7V1h6FJWl/peZq+mwwcgAj4da0=;
        b=yFeytaWRBTXjNTbPpE4selw2oRls2/YNmgr79il4932NJZM8TQ8SIOfRoPkqPujITZ
         i3qQFRgz9aRIRT6JbDbS8TXA5xIoo2jM4CyF0IGZtBcdQHo8C51ESoJr2BxQdFdbqdht
         ExFKtY8CLv1m8TjlBJ12SUjyeI1DYqhBnm8rKsqIjcHdKmctcC+ZG6S+Vz8pYMRyvW6F
         fLz9g7YMORyVJuokSdrZGwuRYwVJuV0EErzGKIIZ8bTwLT34dub1KOQ/c9+KOFjHwVA8
         ZweYXbiJofg66gyZIGClNTphrkQdcOIs/5p6X/XuDlHKlKed3IKt4yR0K2YbhxDtONL+
         mgPg==
X-Gm-Message-State: AFqh2kqnXtdvG4FLSwSHz8DYO4gmA4AuHpGgEQm7Pc1hGaZeOXxV0QaM
        6AF6vci/H0MHzJZqVdfWb/5q1uvsgLQWm23bbXWHaQ==
X-Google-Smtp-Source: AA0mqf7lNFNsw3fiVzXlj6Pjt0dlhaKbZzy10b3twNK4qM4ipWgLYvYrtK45C3ko7zuvu182Y/pqDeRP/tjAflecsW0=
X-Received: by 2002:a05:6870:9e4c:b0:13c:33d0:22e2 with SMTP id
 pt12-20020a0568709e4c00b0013c33d022e2mr592979oab.14.1671103136728; Thu, 15
 Dec 2022 03:18:56 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214125821.12489-7-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-7-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 12:18:46 +0100
Message-ID: <CAG3jFyvwQAXNsLBRj43ZcqX2kWkGT=iLr1NZshfXR6iRWkSdJA@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm: bridge: it66121: Don't use DDC error IRQs
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
> The DDC error IRQs will fire on the IT6610 every time the FIFO is empty,
> which is not very helpful. To resolve this, we can simply disable them,
> and handle DDC errors in it66121_wait_ddc_ready().
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 49 ++++++----------------------
>  1 file changed, 10 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index bfb9c87a7019..06fa59ae5ffc 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -515,16 +515,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>         offset = (block % 2) * len;
>         block = block / 2;
>
> -       ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
> -       if (ret)
> -               return ret;
> -
> -       if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
> -               ret = it66121_abort_ddc_ops(ctx);
> -               if (ret)
> -                       return ret;
> -       }
> -
>         ret = it66121_clear_ddc_fifo(ctx);
>         if (ret)
>                 return ret;
> @@ -545,16 +535,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>                 if (ret)
>                         return ret;
>
> -               ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
> -               if (ret)
> -                       return ret;
> -
> -               if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
> -                       ret = it66121_abort_ddc_ops(ctx);
> -                       if (ret)
> -                               return ret;
> -               }
> -
>                 ret = it66121_preamble_ddc(ctx);
>                 if (ret)
>                         return ret;
> @@ -585,8 +565,10 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>                 remain -= cnt;
>
>                 ret = it66121_wait_ddc_ready(ctx);
> -               if (ret)
> +               if (ret) {
> +                       it66121_abort_ddc_ops(ctx);
>                         return ret;
> +               }
>
>                 ret = regmap_noinc_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG,
>                                         buf, cnt);
> @@ -671,11 +653,7 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>         /* Per programming manual, sleep here for bridge to settle */
>         msleep(50);
>
> -       /* Start interrupts */
> -       return regmap_write_bits(ctx->regmap, IT66121_INT_MASK1_REG,
> -                                IT66121_INT_MASK1_DDC_NOACK |
> -                                IT66121_INT_MASK1_DDC_FIFOERR |
> -                                IT66121_INT_MASK1_DDC_BUSHANG, 0);
> +       return 0;
>  }
>
>  static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
> @@ -926,21 +904,14 @@ static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
>         ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
>         if (ret) {
>                 dev_err(dev, "Cannot read STATUS1_REG %d\n", ret);
> -       } else {
> -               if (val & IT66121_INT_STATUS1_DDC_FIFOERR)
> -                       it66121_clear_ddc_fifo(ctx);
> -               if (val & (IT66121_INT_STATUS1_DDC_BUSHANG |
> -                          IT66121_INT_STATUS1_DDC_NOACK))
> -                       it66121_abort_ddc_ops(ctx);
> -               if (val & IT66121_INT_STATUS1_HPD_STATUS) {
> -                       regmap_write_bits(ctx->regmap, IT66121_INT_CLR1_REG,
> -                                         IT66121_INT_CLR1_HPD, IT66121_INT_CLR1_HPD);
> +       } else if (val & IT66121_INT_STATUS1_HPD_STATUS) {
> +               regmap_write_bits(ctx->regmap, IT66121_INT_CLR1_REG,
> +                                 IT66121_INT_CLR1_HPD, IT66121_INT_CLR1_HPD);
>
> -                       status = it66121_is_hpd_detect(ctx) ? connector_status_connected
> -                                                           : connector_status_disconnected;
> +               status = it66121_is_hpd_detect(ctx) ? connector_status_connected
> +                       : connector_status_disconnected;
>
> -                       event = true;
> -               }
> +               event = true;
>         }
>
>         regmap_write_bits(ctx->regmap, IT66121_SYS_STATUS_REG,
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
