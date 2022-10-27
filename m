Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF5860F9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiJ0N7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiJ0N6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:58:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E5B1863F2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:58:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f27so4894964eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H9twCSyGmHCfZTs1VqmLobwiwtuvoOis8W3XsKIxLx8=;
        b=B8yOwFyva/x37BSg5YDwe/WTfn4Dy+OrYCl6yAd0D663EOKU10TTXX8ypPceVKOQQU
         WY5R0qdFqm87oaw6Kk/HgZWE+b93ELqsR/67egZ41eYecVTXylNCRrYJDMsq2am/USo1
         6zOYJXNTJGCwjZa93uQA6i4+k2VGkojOf1NK7Cw37b3PtWI24ZMohrhW0zhL6vsyLWry
         Kahv2nEBm7gxo4D/PdPJZGXpQr6qQegXrhvjJWKCIyiYoFW+DWEV4FdYp7njscxE0Xuz
         hKQNglNp2/mpEWnl6QRo8g+FgoOG6v/JfXwHTIYpHe+FC/WfNr+pl7j39QBAsn0axctO
         dhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9twCSyGmHCfZTs1VqmLobwiwtuvoOis8W3XsKIxLx8=;
        b=HXRq+oe5f7uraMBdyjTlseWz335Dr5do7zGpQxniovpAal5hgUuw/2VUPmW2aHOwxq
         jx5YeUyOumlb3e/wc5lyIU6wMkCJDwYFzYrmc73NnUP1bntA3lCyjgtnvxgII6btFzBZ
         I99WkHapqdv2p57PC9/oSKKabQevif0NnMXnF5B7vk2nksErAkiNNLess5oKqNOoNTtS
         3Z7ShHh25UXixzwfy3J1KPTNSK/MQSHi/uDybOWNCESebj1dS4Yd5On7NYr9mFGU7+DR
         X4QzwkYb4QMoE+cWoZjogy2d8hZM53Ii1lANXCvTOGbU2KMmgDVOm6B4vYucVIIDF6CP
         tohQ==
X-Gm-Message-State: ACrzQf3SnimI4LMPktP6Nct1NzINvhcze7Ny2Zd1QZGpxs7pd5XU6q8I
        XN8eqeUIKLY6sADAb+gAOT/Dme9Y6Ibpwi3bAAyaOw==
X-Google-Smtp-Source: AMsMyM4V4CJCvWjZUc/wuUPnShNPdQnD1fPVocjSK9OtmP7BhvowApGpOFwkw7Gvj2mgE8ZRTqrzyxI6fUECIDlD/m4=
X-Received: by 2002:a17:907:1c98:b0:78d:3b08:33ef with SMTP id
 nb24-20020a1709071c9800b0078d3b0833efmr43344625ejc.175.1666879125532; Thu, 27
 Oct 2022 06:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech> <20220815-rpi-fix-4k-60-v5-5-fe9e7ac8b111@cerno.tech>
In-Reply-To: <20220815-rpi-fix-4k-60-v5-5-fe9e7ac8b111@cerno.tech>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 27 Oct 2022 14:58:30 +0100
Message-ID: <CAPY8ntCft8_8TimHVs9LJk11Z6PEKtZynCfSUz_3g6-saVyzPQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>, Ray Jui <rjui@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
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

On Thu, 27 Oct 2022 at 13:53, Maxime Ripard <maxime@cerno.tech> wrote:
>
> In order to support higher HDMI frequencies, users have to set the
> hdmi_enable_4kp60 parameter in their config.txt file.
>
> This will have the side-effect of raising the maximum of the core clock,
> tied to the HVS, and managed by the HVS driver.
>
> However, we are querying this in the HDMI driver by poking into the HVS
> structure to get our struct clk handle.
>
> Let's make this part of the HVS bind implementation to have all the core
> clock related setup in the same place.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Thanks for the rename of the variable - pulling scrambling into it
made it confusing.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_drv.h  | 10 ++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 15 ++++-----------
>  drivers/gpu/drm/vc4/vc4_hdmi.h |  8 --------
>  drivers/gpu/drm/vc4/vc4_hvs.c  | 23 +++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index 418a8242691f..8da2b80fdbd3 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -326,6 +326,8 @@ struct vc4_hvs {
>
>         struct clk *core_clk;
>
> +       unsigned long max_core_rate;
> +
>         /* Memory manager for CRTCs to allocate space in the display
>          * list.  Units are dwords.
>          */
> @@ -337,6 +339,14 @@ struct vc4_hvs {
>         struct drm_mm_node mitchell_netravali_filter;
>
>         struct debugfs_regset32 regset;
> +
> +       /*
> +        * Even if HDMI0 on the RPi4 can output modes requiring a pixel
> +        * rate higher than 297MHz, it needs some adjustments in the
> +        * config.txt file to be able to do so and thus won't always be
> +        * available.
> +        */
> +       bool vc5_hdmi_enable_hdmi_20;
>  };
>
>  struct vc4_plane {
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 3acc1858c55f..98a6643821bb 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -46,7 +46,6 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/rational.h>
>  #include <linux/reset.h>
> -#include <soc/bcm2835/raspberrypi-clocks.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/hdmi-codec.h>
>  #include <sound/pcm_drm_eld.h>
> @@ -460,6 +459,7 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
>  static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
>  {
>         struct vc4_hdmi *vc4_hdmi = connector_to_vc4_hdmi(connector);
> +       struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
>         int ret = 0;
>         struct edid *edid;
>
> @@ -483,7 +483,7 @@ static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)
>         ret = drm_add_edid_modes(connector, edid);
>         kfree(edid);
>
> -       if (vc4_hdmi->disable_4kp60) {
> +       if (!vc4->hvs->vc5_hdmi_enable_hdmi_20) {
>                 struct drm_device *drm = connector->dev;
>                 const struct drm_display_mode *mode;
>
> @@ -1757,11 +1757,12 @@ vc4_hdmi_encoder_clock_valid(const struct vc4_hdmi *vc4_hdmi,
>  {
>         const struct drm_connector *connector = &vc4_hdmi->connector;
>         const struct drm_display_info *info = &connector->display_info;
> +       struct vc4_dev *vc4 = to_vc4_dev(connector->dev);
>
>         if (clock > vc4_hdmi->variant->max_pixel_clock)
>                 return MODE_CLOCK_HIGH;
>
> -       if (vc4_hdmi->disable_4kp60 && clock > HDMI_14_MAX_TMDS_CLK)
> +       if (!vc4->hvs->vc5_hdmi_enable_hdmi_20 && clock > HDMI_14_MAX_TMDS_CLK)
>                 return MODE_CLOCK_HIGH;
>
>         if (info->max_tmds_clock && clock > (info->max_tmds_clock * 1000))
> @@ -3428,14 +3429,6 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
>         vc4_hdmi->disable_wifi_frequencies =
>                 of_property_read_bool(dev->of_node, "wifi-2.4ghz-coexistence");
>
> -       if (variant->max_pixel_clock == 600000000) {
> -               struct vc4_dev *vc4 = to_vc4_dev(drm);
> -               unsigned int max_rate = rpi_firmware_clk_get_max_rate(vc4->hvs->core_clk);
> -
> -               if (max_rate < 550000000)
> -                       vc4_hdmi->disable_4kp60 = true;
> -       }
> -
>         ret = devm_pm_runtime_enable(dev);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> index db823efb2563..e3619836ca17 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> @@ -156,14 +156,6 @@ struct vc4_hdmi {
>          */
>         bool disable_wifi_frequencies;
>
> -       /*
> -        * Even if HDMI0 on the RPi4 can output modes requiring a pixel
> -        * rate higher than 297MHz, it needs some adjustments in the
> -        * config.txt file to be able to do so and thus won't always be
> -        * available.
> -        */
> -       bool disable_4kp60;
> -
>         struct cec_adapter *cec_adap;
>         struct cec_msg cec_rx_msg;
>         bool cec_tx_ok;
> diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
> index 4ac9f5a2d5f9..fc4b7310bf63 100644
> --- a/drivers/gpu/drm/vc4/vc4_hvs.c
> +++ b/drivers/gpu/drm/vc4/vc4_hvs.c
> @@ -28,6 +28,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_vblank.h>
>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>  #include "vc4_drv.h"
>  #include "vc4_regs.h"
>
> @@ -791,12 +793,33 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
>         hvs->regset.nregs = ARRAY_SIZE(hvs_regs);
>
>         if (vc4->is_vc5) {
> +               struct rpi_firmware *firmware;
> +               struct device_node *node;
> +               unsigned int max_rate;
> +
> +               node = rpi_firmware_find_node();
> +               if (!node)
> +                       return -EINVAL;
> +
> +               firmware = rpi_firmware_get(node);
> +               of_node_put(node);
> +               if (!firmware)
> +                       return -EPROBE_DEFER;
> +
>                 hvs->core_clk = devm_clk_get(&pdev->dev, NULL);
>                 if (IS_ERR(hvs->core_clk)) {
>                         dev_err(&pdev->dev, "Couldn't get core clock\n");
>                         return PTR_ERR(hvs->core_clk);
>                 }
>
> +               max_rate = rpi_firmware_clk_get_max_rate(firmware,
> +                                                        RPI_FIRMWARE_CORE_CLK_ID);
> +               rpi_firmware_put(firmware);
> +               if (max_rate >= 550000000)
> +                       hvs->vc5_hdmi_enable_hdmi_20 = true;
> +
> +               hvs->max_core_rate = max_rate;
> +
>                 ret = clk_prepare_enable(hvs->core_clk);
>                 if (ret) {
>                         dev_err(&pdev->dev, "Couldn't enable the core clock\n");
>
> --
> b4 0.11.0-dev-99e3a
