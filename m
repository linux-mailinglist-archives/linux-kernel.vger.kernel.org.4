Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DA266229A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjAIKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjAIKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:11:28 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D418B3E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:10:13 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id z128so1173764vsb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BFmXd/4UPgu9PVqNm6AoWBgVTa6i3g45dnuCERHZ2NU=;
        b=WE0liED5Ie5eQRiaAGOQPuSdlhQLG5j7HuHrVbP1gPaqIdGF6HPe9F+Fl7aIFsgP1w
         +zX09nmDVwU4BStTcFX224IgsQsAyjzkXXkgrvHA8/C6yUrlmTre922pIfb0EU3E/KFH
         xDTSsgR8Tta0VXepTvmkaqjG0iwVjWnuTGlLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFmXd/4UPgu9PVqNm6AoWBgVTa6i3g45dnuCERHZ2NU=;
        b=pGp5d/xI2H2AB+A4wRpl8RSs0ZCogTJnYW/j3mj1o9/7b+y3BUwFq0/uNFOVEVECgb
         xJx7L8R9x4YFdJZzKSOCX9WRcUwR9fMLHYSSvm+hafncVPvvjhq6p9/m/3j2MaDQiHBI
         clU1klT/Lwr8L2DMWyzL7C9eAZZUpCyKgQ9kFc60Kf/H9gR+Gk15Lfu9/C++imekMUOB
         c8C547nvwM2cc0Xk6nLnMcEcyIKmBNWqpcjFzvfTpnyJLRaoU9nDCnmnHYivXmgPNhej
         gMTIJ1p9ta0MtrYLtGCxXf8rVv+tHy4TptM8aI2Z7F5Y5Iv9L+nDNLfmD1bgvhUBb1On
         mPtA==
X-Gm-Message-State: AFqh2koh5lfz8HzhkoNZPfyjbID5Wj1nupCOUt9G8wS0LCwwbdIQW2eA
        KlaYolay0UNUJQ9/miu+eSnVRJwH1mjv+vOpVQxwUA==
X-Google-Smtp-Source: AMrXdXswh5fHslW6qG2CKCrGJyPGVtfkg3sYDGWs2LeCd5aO4LLL2z1s6q88e5jJJhhVmRcH4ARrlwrJQirdLbbhANg=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr7195348vsv.9.1673259012171; Mon, 09 Jan
 2023 02:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20230109084101.265664-1-treapking@chromium.org> <20230109084101.265664-4-treapking@chromium.org>
In-Reply-To: <20230109084101.265664-4-treapking@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 9 Jan 2023 18:10:01 +0800
Message-ID: <CAGXv+5G2bUNrA5zfmzZeXJjOgvKc0tFq_qd3UR11qeyNb=xNHQ@mail.gmail.com>
Subject: Re: [PATCH v9 3/9] drm/display: Add Type-C switch helpers
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Jani Nikula <jani.nikula@intel.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Stephen Boyd <swboyd@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 4:41 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Add helpers to register and unregister Type-C "switches" for bridges
> capable of switching their output between two downstream devices.
>
> The helper registers USB Type-C mode switches when the "mode-switch"
> and the "data-lanes" properties are available in Device Tree.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on MT8192 based Hayato (ASUS Chromebook Flip CM3200).

> ---
>
> (no changes since v8)
>
> Changes in v8:
> - Fixed the build issue when CONFIG_TYPEC=m
> - Fixed some style issues
>
> Changes in v7:
> - Extracted the common codes to a helper function
> - New in v7
>
>  drivers/gpu/drm/display/drm_dp_helper.c | 132 ++++++++++++++++++++++++
>  include/drm/display/drm_dp_helper.h     |  16 +++
>  2 files changed, 148 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 16565a0a5da6..fb9e23744c08 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -30,11 +30,13 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/string_helpers.h>
> +#include <linux/usb/typec_mux.h>
>  #include <linux/dynamic_debug.h>
>
>  #include <drm/display/drm_dp_helper.h>
>  #include <drm/display/drm_dp_mst_helper.h>
>  #include <drm/drm_edid.h>
> +#include <drm/drm_of.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_panel.h>
> @@ -3891,3 +3893,133 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
>  EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
>
>  #endif
> +
> +#if IS_REACHABLE(CONFIG_TYPEC)
> +static int drm_dp_register_mode_switch(struct device *dev, struct device_node *node,
> +                                      struct drm_dp_typec_switch_desc *switch_desc,
> +                                      void *data, void *mux_set)
> +{
> +       struct drm_dp_typec_port_data *port_data;
> +       struct typec_mux_desc mux_desc = {};
> +       char name[32];
> +       u32 dp_lanes[2];
> +       int ret, num_lanes, port_num = -1;
> +
> +       num_lanes = drm_of_get_data_lanes_count(node, 0, 2);
> +       if (num_lanes <= 0) {
> +               dev_err(dev, "Error on getting data lanes count: %d\n",
> +                       num_lanes);

Also printing out the full node name (endpoint@N) would be more helpful.

> +               return num_lanes;
> +       }
> +
> +       ret = of_property_read_u32_array(node, "data-lanes", dp_lanes, num_lanes);
> +       if (ret) {
> +               dev_err(dev, "Failed to read the data-lanes variable: %d\n",
> +                       ret);

Same here.

> +               return ret;
> +       }
> +
> +       port_num = dp_lanes[0] / 2;
> +
> +       port_data = &switch_desc->typec_ports[port_num];
> +       port_data->data = data;
> +       mux_desc.fwnode = &node->fwnode;
> +       mux_desc.drvdata = port_data;
> +       snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
> +       mux_desc.name = name;
> +       mux_desc.set = mux_set;
> +
> +       port_data->typec_mux = typec_mux_register(dev, &mux_desc);
> +       if (IS_ERR(port_data->typec_mux)) {
> +               ret = PTR_ERR(port_data->typec_mux);
> +               dev_err(dev, "Mode switch register for port %d failed: %d\n",
> +                       port_num, ret);
> +       }
> +
> +       return ret;
> +}
> +
> +/**
> + * drm_dp_register_typec_switches() - register Type-C switches
> + * @dev: Device that registers Type-C switches
> + * @port: Device node for the switch
> + * @switch_desc: A Type-C switch descriptor
> + * @data: Private data for the switches
> + * @mux_set: Callback function for typec_mux_set
> + *
> + * This function registers USB Type-C switches for DP bridges that can switch
> + * the output signal between their output pins.
> + *
> + * Currently only mode switches are implemented, and the function assumes the
> + * given @port device node has endpoints with "mode-switch" property.
> + * Register the endpoint as port 0 if the "data-lanes" property falls in 0/1,
> + * and register it as port 1 if "data-lanes" falls in 2/3.
> + */
> +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> +                                  struct drm_dp_typec_switch_desc *switch_desc,
> +                                  void *data, void *mux_set)
> +{
> +       struct device_node *sw;
> +       int ret;
> +
> +       for_each_child_of_node(port, sw) {
> +               if (of_property_read_bool(sw, "mode-switch"))
> +                       switch_desc->num_typec_switches++;
> +       }
> +
> +       if (!switch_desc->num_typec_switches) {
> +               dev_warn(dev, "No Type-C switches node found\n");

Maybe change this to dev_info or even dev_debug? A warning would be too
noisy if the bridge drivers are calling this helper unconditionally.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
