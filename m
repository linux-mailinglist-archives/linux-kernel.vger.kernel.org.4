Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A256690AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238902AbjAMIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjAMIWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:22:36 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0692A631BC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:19:52 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o13so10502072ilc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BKMSUmtvQTZR1Bx3nFgy9UiaF+pPDH7HXjpb5m0jErY=;
        b=Ksic6VC372xQWN9jfDMhwisA2M6mj48tLTHoGLbn+xdcflR+rMD3CtuznqAHCPTGnS
         oKjRaOr7TNvVq08GhcPBcUPY9uPLVVBKUBQrfTWVO7NkKBKIEC984s2fPSFXVrLcyKsw
         ezdHPDdJNMsTLEsmeNuB8YNCMgoOgHrl256To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKMSUmtvQTZR1Bx3nFgy9UiaF+pPDH7HXjpb5m0jErY=;
        b=wo1xIzNwhzOJsHL9yc7q7CQuc7RTnPEwgdNP3JboIE7Db5p9YWayxDaZVVrYOarIZ7
         wjw/qU9c3tHPAPbaD6EymV7sglsyAeF0eYiiGulLX7LMIgkdtZt3kcv89ar/hKaWqlTq
         7SKF1qx17Vhhxoopvc+kI4/UKwmfNX4KyntzUg3lkAD8IuQuZp8etoy1v9+IBKuN+jSO
         +dN8oo2otsc8yQdKmD8RZgoxitELZbdGUK//wY6xWg/JAnvQawZhmu6qK4SGKpo67dlv
         lVc8iveDZLkK34SqMScl8/mjSfbNeA0Qp6e9ReMzZBppENnnXGOKNvA2Mri4OTJdFVe8
         bNuA==
X-Gm-Message-State: AFqh2kr/m3TCRprnqanI85tk8/hruLPW4dldkLSDKBx3x1Y0D8hTYc7r
        7CzryZkpvzdjZFQe95JDAO7csyZs3HWNwAxepm1BnQ==
X-Google-Smtp-Source: AMrXdXsDR5dhPIj26bySWnmo5RM8DNKlViIPKfZA1FUN9ZY90xGUdO4m1InJPkTHXxKZpel9gir4SHUCYlhZ9mzltLQ=
X-Received: by 2002:a92:d0f:0:b0:303:96b3:c8a0 with SMTP id
 15-20020a920d0f000000b0030396b3c8a0mr8028094iln.192.1673597991294; Fri, 13
 Jan 2023 00:19:51 -0800 (PST)
MIME-Version: 1.0
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-4-treapking@chromium.org> <87mt6ogndf.fsf@intel.com>
In-Reply-To: <87mt6ogndf.fsf@intel.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Fri, 13 Jan 2023 16:19:40 +0800
Message-ID: <CAEXTbpdjr1ZeOKPsPhKJoByXbwjEiVV8+sxvxjo9==YeQhi-kA@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] drm/display: Add Type-C switch helpers
To:     Jani Nikula <jani.nikula@intel.com>
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
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, chrome-platform@lists.linux.dev,
        Xin Ji <xji@analogixsemi.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Allen Chen <allen.chen@ite.com.tw>,
        linux-acpi@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>
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

Hi Jani,

Thanks for the review.

On Thu, Jan 12, 2023 at 4:37 PM Jani Nikula <jani.nikula@intel.com> wrote:
>
> On Thu, 12 Jan 2023, Pin-yen Lin <treapking@chromium.org> wrote:
> > Add helpers to register and unregister Type-C "switches" for bridges
> > capable of switching their output between two downstream devices.
> >
> > The helper registers USB Type-C mode switches when the "mode-switch"
> > and the "data-lanes" properties are available in Device Tree.
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > ---
> >
> > Changes in v10:
> > - Collected Reviewed-by and Tested-by tags
> > - Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
> > - Print out the node name when errors on parsing DT
> > - Use dev_dbg instead of dev_warn when no Type-C switch nodes available
> > - Made the return path of drm_dp_register_mode_switch clearer
> >
> > Changes in v8:
> > - Fixed the build issue when CONFIG_TYPEC=m
> > - Fixed some style issues
> >
> > Changes in v7:
> > - Extracted the common codes to a helper function
> > - New in v7
> >
> >  drivers/gpu/drm/display/drm_dp_helper.c | 134 ++++++++++++++++++++++++
> >  include/drm/display/drm_dp_helper.h     |  17 +++
> >  2 files changed, 151 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> > index 16565a0a5da6..a2ec40a621cb 100644
> > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > @@ -30,11 +30,13 @@
> >  #include <linux/sched.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/string_helpers.h>
> > +#include <linux/usb/typec_mux.h>
> >  #include <linux/dynamic_debug.h>
> >
> >  #include <drm/display/drm_dp_helper.h>
> >  #include <drm/display/drm_dp_mst_helper.h>
> >  #include <drm/drm_edid.h>
> > +#include <drm/drm_of.h>
> >  #include <drm/drm_print.h>
> >  #include <drm/drm_vblank.h>
> >  #include <drm/drm_panel.h>
> > @@ -3891,3 +3893,135 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
> >  EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
> >
> >  #endif
> > +
> > +#if IS_REACHABLE(CONFIG_TYPEC)
>
> I think IS_REACHABLE() is a workaround for not getting the Kconfig
> dependencies right. It allows configurations that silently just don't
> work, instead of warning about it at config time. It fixes a build
> issue, but trades it for an end user configuration issue that you don't
> get any feedback about, and is hard to figure out. It's for people who
> deal with build issues, but don't need to deal with user issues.
>
> BR,
> Jani.
>
I've added "depends on TYPEC || TYPEC=n" on the Kconfigs of its users
(i.e., anx7625 and it6505). I didn't do this on DRM_DISPLAY_DP_HELPER
because that stops all users of DRM_DISPLAY_DP_HELPER, which is a
quite generic helper file, from building TYPEC as a module.

Or, do you have any other suggestions on this? Move these functions to
a separate file?

>
>
> > +static int drm_dp_register_mode_switch(struct device *dev, struct device_node *node,
> > +                                    struct drm_dp_typec_switch_desc *switch_desc,
> > +                                    void *data, typec_mux_set_fn_t mux_set)
> > +{
> > +     struct drm_dp_typec_port_data *port_data;
> > +     struct typec_mux_desc mux_desc = {};
> > +     char name[32];
> > +     u32 dp_lanes[2];
> > +     int ret, num_lanes, port_num = -1;
> > +
> > +     num_lanes = drm_of_get_data_lanes_count(node, 0, 2);
> > +     if (num_lanes <= 0) {
> > +             dev_err(dev, "Error on getting data lanes count from %s: %d\n",
> > +                     node->name, num_lanes);
> > +             return num_lanes;
> > +     }
> > +
> > +     ret = of_property_read_u32_array(node, "data-lanes", dp_lanes, num_lanes);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to read the data-lanes variable from %s: %d\n",
> > +                     node->name, ret);
> > +             return ret;
> > +     }
> > +
> > +     port_num = dp_lanes[0] / 2;
> > +
> > +     port_data = &switch_desc->typec_ports[port_num];
> > +     port_data->data = data;
> > +     mux_desc.fwnode = &node->fwnode;
> > +     mux_desc.drvdata = port_data;
> > +     snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
> > +     mux_desc.name = name;
> > +     mux_desc.set = mux_set;
> > +
> > +     port_data->typec_mux = typec_mux_register(dev, &mux_desc);
> > +     if (IS_ERR(port_data->typec_mux)) {
> > +             ret = PTR_ERR(port_data->typec_mux);
> > +             dev_err(dev, "Mode switch register for port %d failed: %d\n",
> > +                     port_num, ret);
> > +
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * drm_dp_register_typec_switches() - register Type-C switches
> > + * @dev: Device that registers Type-C switches
> > + * @port: Device node for the switch
> > + * @switch_desc: A Type-C switch descriptor
> > + * @data: Private data for the switches
> > + * @mux_set: Callback function for typec_mux_set
> > + *
> > + * This function registers USB Type-C switches for DP bridges that can switch
> > + * the output signal between their output pins.
> > + *
> > + * Currently only mode switches are implemented, and the function assumes the
> > + * given @port device node has endpoints with "mode-switch" property.
> > + * Register the endpoint as port 0 if the "data-lanes" property falls in 0/1,
> > + * and register it as port 1 if "data-lanes" falls in 2/3.
> > + */
> > +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> > +                                struct drm_dp_typec_switch_desc *switch_desc,
> > +                                void *data, typec_mux_set_fn_t mux_set)
> > +{
> > +     struct device_node *sw;
> > +     int ret;
> > +
> > +     for_each_child_of_node(port, sw) {
> > +             if (of_property_read_bool(sw, "mode-switch"))
> > +                     switch_desc->num_typec_switches++;
> > +     }
> > +
> > +     if (!switch_desc->num_typec_switches) {
> > +             dev_dbg(dev, "No Type-C switches node found\n");
> > +             return 0;
> > +     }
> > +
> > +     switch_desc->typec_ports = devm_kcalloc(
> > +             dev, switch_desc->num_typec_switches,
> > +             sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
> > +
> > +     if (!switch_desc->typec_ports)
> > +             return -ENOMEM;
> > +
> > +     /* Register switches for each connector. */
> > +     for_each_child_of_node(port, sw) {
> > +             if (!of_property_read_bool(sw, "mode-switch"))
> > +                     continue;
> > +             ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
> > +             if (ret)
> > +                     goto err_unregister_typec_switches;
> > +     }
> > +
> > +     return 0;
> > +
> > +err_unregister_typec_switches:
> > +     of_node_put(sw);
> > +     drm_dp_unregister_typec_switches(switch_desc);
> > +     dev_err(dev, "Failed to register mode switch: %d\n", ret);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(drm_dp_register_typec_switches);
> > +
> > +/**
> > + * drm_dp_unregister_typec_switches() - unregister Type-C switches
> > + * @switch_desc: A Type-C switch descriptor
> > + */
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> > +{
> > +     int i;
> > +
> > +     for (i = 0; i < switch_desc->num_typec_switches; i++)
> > +             typec_mux_unregister(switch_desc->typec_ports[i].typec_mux);
> > +}
> > +EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
> > +#else
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> > +{
> > +}
> > +EXPORT_SYMBOL(drm_dp_register_typec_switches);
> > +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> > +                                struct drm_dp_typec_switch_desc *switch_desc,
> > +                                void *data, typec_mux_set_fn_t mux_set)
> > +{
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
> > +#endif
> > diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> > index ab55453f2d2c..5a3824f13b4e 100644
> > --- a/include/drm/display/drm_dp_helper.h
> > +++ b/include/drm/display/drm_dp_helper.h
> > @@ -25,6 +25,7 @@
> >
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > +#include <linux/usb/typec_mux.h>
> >
> >  #include <drm/display/drm_dp.h>
> >  #include <drm/drm_connector.h>
> > @@ -763,4 +764,20 @@ bool drm_dp_downstream_rgb_to_ycbcr_conversion(const u8 dpcd[DP_RECEIVER_CAP_SIZ
> >                                              const u8 port_cap[4], u8 color_spc);
> >  int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc);
> >
> > +struct drm_dp_typec_port_data {
> > +     struct typec_mux_dev *typec_mux;
> > +     void *data;
> > +     bool dp_connected;
> > +};
> > +
> > +struct drm_dp_typec_switch_desc {
> > +     int num_typec_switches;
> > +     struct drm_dp_typec_port_data *typec_ports;
> > +};
> > +
> > +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc);
> > +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> > +                                struct drm_dp_typec_switch_desc *switch_desc,
> > +                                void *data, typec_mux_set_fn_t mux_set);
> > +
> >  #endif /* _DRM_DP_HELPER_H_ */
>
> --
> Jani Nikula, Intel Open Source Graphics Center

Best regards,
Pin-yen
