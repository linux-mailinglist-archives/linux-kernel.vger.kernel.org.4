Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D4A64DA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLOLiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLOLh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:37:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359932BB0C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:37:36 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q186so5025523oia.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9gVSgOkROGEwxsJ0w3CmvpiOrz8WMPdeFu7W80kjVY=;
        b=Da9sUFMuMf7OMzldbcETDbBz47TrsxDAkpSWd4y3Yy+2q4p+RaLVC8lgHE9gBpIAN+
         E8OvBA7D38dc4n9qFNMYehDyAxKtZ/ct9CbYIcCYGdy8JW3szX5gym3/SQaLqxvjgeJU
         5B7aiblJdKdISYlkY16Ko0uldJu+JR9iyEG584fCXX68rhB97Kgqmb3z7V8ptESxnp3d
         ENlbs5SmjmU/SzV8c50iB0bMpVST3MmyIJOsvkXsFs8OIstvFav6lCjk8EVfnrEkoteQ
         GSo8R9sh/RdMAHJcwcK8kdQxc4zkKTsTvOnXwWQSyClFVseDmf57AziW9mHGo65X6Hk8
         Yytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9gVSgOkROGEwxsJ0w3CmvpiOrz8WMPdeFu7W80kjVY=;
        b=SP7bgjM9as2DI6mG/FXYhR7vDmswe7BtYCI8fLA8q43EW3wCHeB3LT7wAfTWGcspLd
         jrfNl6o5Tnjl1BnSW2AXx0rkX6IFau663K7YKktRKPJ3F40SSywIq5mX/sDVhTSaEych
         tJAv3cBwUNotBjnIz6OjxQpVQD2271dwmuq3p2QtVOZVnoSknedx0Z85TDI1LoCgWL0J
         5domzn0MNZMfQK2aQFoW8hPnygVR8Ozpqsxv0TN4gZ6ptCJrPi+ZFrhErHs2UUIWlbD2
         VG709B9VHzoM775P8+LI7+I1C1eccJbe9MqWm7o2JjJxPzLZn4UWgjc4Q5wJqoIRCfah
         sMYw==
X-Gm-Message-State: ANoB5pkk+FxZ1/J0PiZfZ2nrVAZgxNiEi+dU57+kdjHGSEcnmN0BDfun
        rP+D3N+SXrNIynE4cyy6tAqx6CHB2hsoG4H0ReVX3A==
X-Google-Smtp-Source: AA0mqf7BzmAiWPcb9KIGjHV+SyzIt3IQlQgKUbJieTreiEWKW1K6qj8bQe6/Zjvi9UdvOb8LJi1jm/GW+3I1q7GaAR0=
X-Received: by 2002:aca:1c07:0:b0:359:ef86:2f4f with SMTP id
 c7-20020aca1c07000000b00359ef862f4fmr311021oic.14.1671104255444; Thu, 15 Dec
 2022 03:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20221214125821.12489-1-paul@crapouillou.net> <20221214130131.12962-1-paul@crapouillou.net>
In-Reply-To: <20221214130131.12962-1-paul@crapouillou.net>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 12:37:24 +0100
Message-ID: <CAG3jFytCuh_20=3r3c=Dtahu-Btjixq4QFeVneDmsFYRUvM+-g@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm: bridge: it66121: Add support for the IT6610
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 14:01, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add support for the IT6610 HDMI encoder.
>
> The hardware is very similar, and therefore the driver did not require
> too many changes. Some bits are only available on the IT66121, and
> vice-versa. Also, the IT6610 requires specific polarities on the DE and
> pixel lines.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 108 +++++++++++++++++++++------
>  1 file changed, 86 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 43b027b85b8e..b34860871627 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -68,6 +68,7 @@
>  #define IT66121_AFE_XP_ENO                     BIT(4)
>  #define IT66121_AFE_XP_RESETB                  BIT(3)
>  #define IT66121_AFE_XP_PWDI                    BIT(2)
> +#define IT6610_AFE_XP_BYPASS                   BIT(0)
>
>  #define IT66121_AFE_IP_REG                     0x64
>  #define IT66121_AFE_IP_GAINBIT                 BIT(7)
> @@ -284,7 +285,13 @@
>
>  #define IT66121_AFE_CLK_HIGH                   80000 /* Khz */
>
> +enum chip_id {
> +       ID_IT6610,
> +       ID_IT66121,
> +};
> +
>  struct it66121_chip_info {
> +       enum chip_id id;
>         u16 vid, pid;
>  };
>
> @@ -391,16 +398,22 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
>
>                 ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>                                         IT66121_AFE_IP_GAINBIT |
> -                                       IT66121_AFE_IP_ER0 |
> -                                       IT66121_AFE_IP_EC1,
> +                                       IT66121_AFE_IP_ER0,
>                                         IT66121_AFE_IP_GAINBIT);
>                 if (ret)
>                         return ret;
>
> -               ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
> -                                       IT66121_AFE_XP_EC1_LOWCLK, 0x80);
> -               if (ret)
> -                       return ret;
> +               if (ctx->info->id == ID_IT66121) {
> +                       ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
> +                                               IT66121_AFE_IP_EC1, 0);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
> +                                               IT66121_AFE_XP_EC1_LOWCLK, 0x80);
> +                       if (ret)
> +                               return ret;
> +               }
>         } else {
>                 ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
>                                         IT66121_AFE_XP_GAINBIT |
> @@ -411,17 +424,24 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
>
>                 ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>                                         IT66121_AFE_IP_GAINBIT |
> -                                       IT66121_AFE_IP_ER0 |
> -                                       IT66121_AFE_IP_EC1, IT66121_AFE_IP_ER0 |
> -                                       IT66121_AFE_IP_EC1);
> +                                       IT66121_AFE_IP_ER0,
> +                                       IT66121_AFE_IP_ER0);
>                 if (ret)
>                         return ret;
>
> -               ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
> -                                       IT66121_AFE_XP_EC1_LOWCLK,
> -                                       IT66121_AFE_XP_EC1_LOWCLK);
> -               if (ret)
> -                       return ret;
> +               if (ctx->info->id == ID_IT66121) {
> +                       ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
> +                                               IT66121_AFE_IP_EC1,
> +                                               IT66121_AFE_IP_EC1);
> +                       if (ret)
> +                               return ret;
> +
> +                       ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
> +                                               IT66121_AFE_XP_EC1_LOWCLK,
> +                                               IT66121_AFE_XP_EC1_LOWCLK);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>
>         /* Clear reset flags */
> @@ -430,6 +450,14 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
>         if (ret)
>                 return ret;
>
> +       if (ctx->info->id == ID_IT6610) {
> +               ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
> +                                       IT6610_AFE_XP_BYPASS,
> +                                       IT6610_AFE_XP_BYPASS);
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return it66121_fire_afe(ctx);
>  }
>
> @@ -491,7 +519,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
>                                   unsigned int block, size_t len)
>  {
>         struct it66121_ctx *ctx = context;
> -       unsigned int val;
>         int remain = len;
>         int offset = 0;
>         int ret, cnt;
> @@ -572,10 +599,12 @@ static int it66121_bridge_attach(struct drm_bridge *bridge,
>         if (ret)
>                 return ret;
>
> -       ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> -                               IT66121_CLK_BANK_PWROFF_RCLK, 0);
> -       if (ret)
> -               return ret;
> +       if (ctx->info->id == ID_IT66121) {
> +               ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> +                                       IT66121_CLK_BANK_PWROFF_RCLK, 0);
> +               if (ret)
> +                       return ret;
> +       }
>
>         ret = regmap_write_bits(ctx->regmap, IT66121_INT_REG,
>                                 IT66121_INT_TX_CLK_OFF, 0);
> @@ -713,6 +742,24 @@ static void it66121_bridge_disable(struct drm_bridge *bridge,
>         ctx->connector = NULL;
>  }
>
> +static int it66121_bridge_check(struct drm_bridge *bridge,
> +                               struct drm_bridge_state *bridge_state,
> +                               struct drm_crtc_state *crtc_state,
> +                               struct drm_connector_state *conn_state)
> +{
> +       struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
> +
> +       if (ctx->info->id == ID_IT6610) {
> +               /* The IT6610 only supports these settings */
> +               bridge_state->input_bus_cfg.flags |= DRM_BUS_FLAG_DE_HIGH |
> +                       DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
> +               bridge_state->input_bus_cfg.flags &=
> +                       ~DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
> +       }
> +
> +       return 0;
> +}
> +
>  static
>  void it66121_bridge_mode_set(struct drm_bridge *bridge,
>                              const struct drm_display_mode *mode,
> @@ -758,9 +805,12 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
>         if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
>                 goto unlock;
>
> -       if (regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> -                             IT66121_CLK_BANK_PWROFF_TXCLK, IT66121_CLK_BANK_PWROFF_TXCLK))
> +       if (ctx->info->id == ID_IT66121 &&
> +           regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> +                             IT66121_CLK_BANK_PWROFF_TXCLK,
> +                             IT66121_CLK_BANK_PWROFF_TXCLK)) {
>                 goto unlock;
> +       }
>
>         if (it66121_configure_input(ctx))
>                 goto unlock;
> @@ -768,7 +818,11 @@ void it66121_bridge_mode_set(struct drm_bridge *bridge,
>         if (it66121_configure_afe(ctx, adjusted_mode))
>                 goto unlock;
>
> -       regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG, IT66121_CLK_BANK_PWROFF_TXCLK, 0);
> +       if (ctx->info->id == ID_IT66121 &&
> +           regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
> +                             IT66121_CLK_BANK_PWROFF_TXCLK, 0)) {
> +               goto unlock;
> +       }
>
>  unlock:
>         mutex_unlock(&ctx->lock);
> @@ -859,6 +913,7 @@ static const struct drm_bridge_funcs it66121_bridge_funcs = {
>         .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
>         .atomic_enable = it66121_bridge_enable,
>         .atomic_disable = it66121_bridge_disable,
> +       .atomic_check = it66121_bridge_check,
>         .mode_set = it66121_bridge_mode_set,
>         .mode_valid = it66121_bridge_mode_valid,
>         .detect = it66121_bridge_detect,
> @@ -1557,17 +1612,26 @@ static void it66121_remove(struct i2c_client *client)
>
>  static const struct of_device_id it66121_dt_match[] = {
>         { .compatible = "ite,it66121" },
> +       { .compatible = "ite,it6610" },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, it66121_dt_match);
>
>  static const struct it66121_chip_info it66121_chip_info = {
> +       .id = ID_IT66121,
>         .vid = 0x4954,
>         .pid = 0x0612,
>  };
>
> +static const struct it66121_chip_info it6610_chip_info = {
> +       .id = ID_IT6610,
> +       .vid = 0xca00,
> +       .pid = 0x0611,
> +};
> +
>  static const struct i2c_device_id it66121_id[] = {
>         { "it66121", (kernel_ulong_t) &it66121_chip_info },
> +       { "it6610", (kernel_ulong_t) &it6610_chip_info },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, it66121_id);
> --
> 2.35.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
