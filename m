Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E0666C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjALIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbjALIjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:39:02 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35354E439;
        Thu, 12 Jan 2023 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673512635; x=1705048635;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hvwRtkreyAhWnyxXEJP/jnyuD4/eP1gQB70X6Y+Mouk=;
  b=hsh1WaHekNOFYN+3K2rd4aQZDi8zaQD3AjVB4g5uon4dRmuU80kG9LVm
   aaAG/D7pPWV+SRCjfhRjREaWNiGuZdd2f04qYN+C8ubGMALcemUXhbERC
   dP29LZr6dkSJc33bTm7FD9bfiSd7WaoEjMytUMr/AgnVlLMKnDjFIOKSZ
   Gy68QmIFWFoMKs8tWXKVcuAXlRkLOzY/9K765myfT/SDyrEW1RaTQBa44
   fr/k+z4I6EtI15Ek/0zjqjpVuRve5rjymE4sD8wAx1yIVvdD6Zr09FKJ4
   /f6zTWQ7VEFn0r5OXopftIXjoJV/caUZgL9UqYg3Kb7XKSdmyWCDdWHPN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321339069"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321339069"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:37:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="657718736"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="657718736"
Received: from lhazellx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.27.83])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 00:37:02 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
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
        Guenter Roeck <groeck@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        =?utf-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
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
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        shaomin Deng <dengshaomin@cdjrlc.com>
Subject: Re: [PATCH v10 3/9] drm/display: Add Type-C switch helpers
In-Reply-To: <20230112042104.4107253-4-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230112042104.4107253-1-treapking@chromium.org>
 <20230112042104.4107253-4-treapking@chromium.org>
Date:   Thu, 12 Jan 2023 10:37:00 +0200
Message-ID: <87mt6ogndf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023, Pin-yen Lin <treapking@chromium.org> wrote:
> Add helpers to register and unregister Type-C "switches" for bridges
> capable of switching their output between two downstream devices.
>
> The helper registers USB Type-C mode switches when the "mode-switch"
> and the "data-lanes" properties are available in Device Tree.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> ---
>
> Changes in v10:
> - Collected Reviewed-by and Tested-by tags
> - Replaced "void *" with "typec_mux_set_fn_t" for mux_set callbacks
> - Print out the node name when errors on parsing DT
> - Use dev_dbg instead of dev_warn when no Type-C switch nodes available
> - Made the return path of drm_dp_register_mode_switch clearer
>
> Changes in v8:
> - Fixed the build issue when CONFIG_TYPEC=m
> - Fixed some style issues
>
> Changes in v7:
> - Extracted the common codes to a helper function
> - New in v7
>
>  drivers/gpu/drm/display/drm_dp_helper.c | 134 ++++++++++++++++++++++++
>  include/drm/display/drm_dp_helper.h     |  17 +++
>  2 files changed, 151 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 16565a0a5da6..a2ec40a621cb 100644
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
> @@ -3891,3 +3893,135 @@ int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
>  EXPORT_SYMBOL(drm_panel_dp_aux_backlight);
>  
>  #endif
> +
> +#if IS_REACHABLE(CONFIG_TYPEC)

I think IS_REACHABLE() is a workaround for not getting the Kconfig
dependencies right. It allows configurations that silently just don't
work, instead of warning about it at config time. It fixes a build
issue, but trades it for an end user configuration issue that you don't
get any feedback about, and is hard to figure out. It's for people who
deal with build issues, but don't need to deal with user issues.

BR,
Jani.



> +static int drm_dp_register_mode_switch(struct device *dev, struct device_node *node,
> +				       struct drm_dp_typec_switch_desc *switch_desc,
> +				       void *data, typec_mux_set_fn_t mux_set)
> +{
> +	struct drm_dp_typec_port_data *port_data;
> +	struct typec_mux_desc mux_desc = {};
> +	char name[32];
> +	u32 dp_lanes[2];
> +	int ret, num_lanes, port_num = -1;
> +
> +	num_lanes = drm_of_get_data_lanes_count(node, 0, 2);
> +	if (num_lanes <= 0) {
> +		dev_err(dev, "Error on getting data lanes count from %s: %d\n",
> +			node->name, num_lanes);
> +		return num_lanes;
> +	}
> +
> +	ret = of_property_read_u32_array(node, "data-lanes", dp_lanes, num_lanes);
> +	if (ret) {
> +		dev_err(dev, "Failed to read the data-lanes variable from %s: %d\n",
> +			node->name, ret);
> +		return ret;
> +	}
> +
> +	port_num = dp_lanes[0] / 2;
> +
> +	port_data = &switch_desc->typec_ports[port_num];
> +	port_data->data = data;
> +	mux_desc.fwnode = &node->fwnode;
> +	mux_desc.drvdata = port_data;
> +	snprintf(name, sizeof(name), "%s-%u", node->name, port_num);
> +	mux_desc.name = name;
> +	mux_desc.set = mux_set;
> +
> +	port_data->typec_mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(port_data->typec_mux)) {
> +		ret = PTR_ERR(port_data->typec_mux);
> +		dev_err(dev, "Mode switch register for port %d failed: %d\n",
> +			port_num, ret);
> +
> +		return ret;
> +	}
> +
> +	return 0;
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
> +				   struct drm_dp_typec_switch_desc *switch_desc,
> +				   void *data, typec_mux_set_fn_t mux_set)
> +{
> +	struct device_node *sw;
> +	int ret;
> +
> +	for_each_child_of_node(port, sw) {
> +		if (of_property_read_bool(sw, "mode-switch"))
> +			switch_desc->num_typec_switches++;
> +	}
> +
> +	if (!switch_desc->num_typec_switches) {
> +		dev_dbg(dev, "No Type-C switches node found\n");
> +		return 0;
> +	}
> +
> +	switch_desc->typec_ports = devm_kcalloc(
> +		dev, switch_desc->num_typec_switches,
> +		sizeof(struct drm_dp_typec_port_data), GFP_KERNEL);
> +
> +	if (!switch_desc->typec_ports)
> +		return -ENOMEM;
> +
> +	/* Register switches for each connector. */
> +	for_each_child_of_node(port, sw) {
> +		if (!of_property_read_bool(sw, "mode-switch"))
> +			continue;
> +		ret = drm_dp_register_mode_switch(dev, sw, switch_desc, data, mux_set);
> +		if (ret)
> +			goto err_unregister_typec_switches;
> +	}
> +
> +	return 0;
> +
> +err_unregister_typec_switches:
> +	of_node_put(sw);
> +	drm_dp_unregister_typec_switches(switch_desc);
> +	dev_err(dev, "Failed to register mode switch: %d\n", ret);
> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_dp_register_typec_switches);
> +
> +/**
> + * drm_dp_unregister_typec_switches() - unregister Type-C switches
> + * @switch_desc: A Type-C switch descriptor
> + */
> +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> +{
> +	int i;
> +
> +	for (i = 0; i < switch_desc->num_typec_switches; i++)
> +		typec_mux_unregister(switch_desc->typec_ports[i].typec_mux);
> +}
> +EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
> +#else
> +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> +{
> +}
> +EXPORT_SYMBOL(drm_dp_register_typec_switches);
> +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> +				   struct drm_dp_typec_switch_desc *switch_desc,
> +				   void *data, typec_mux_set_fn_t mux_set)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_dp_unregister_typec_switches);
> +#endif
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index ab55453f2d2c..5a3824f13b4e 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -25,6 +25,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> +#include <linux/usb/typec_mux.h>
>  
>  #include <drm/display/drm_dp.h>
>  #include <drm/drm_connector.h>
> @@ -763,4 +764,20 @@ bool drm_dp_downstream_rgb_to_ycbcr_conversion(const u8 dpcd[DP_RECEIVER_CAP_SIZ
>  					       const u8 port_cap[4], u8 color_spc);
>  int drm_dp_pcon_convert_rgb_to_ycbcr(struct drm_dp_aux *aux, u8 color_spc);
>  
> +struct drm_dp_typec_port_data {
> +	struct typec_mux_dev *typec_mux;
> +	void *data;
> +	bool dp_connected;
> +};
> +
> +struct drm_dp_typec_switch_desc {
> +	int num_typec_switches;
> +	struct drm_dp_typec_port_data *typec_ports;
> +};
> +
> +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc);
> +int drm_dp_register_typec_switches(struct device *dev, struct device_node *port,
> +				   struct drm_dp_typec_switch_desc *switch_desc,
> +				   void *data, typec_mux_set_fn_t mux_set);
> +
>  #endif /* _DRM_DP_HELPER_H_ */

-- 
Jani Nikula, Intel Open Source Graphics Center
