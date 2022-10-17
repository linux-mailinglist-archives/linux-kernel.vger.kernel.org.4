Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D06600DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 13:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJQLja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 07:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiJQLj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 07:39:27 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD228E85
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NqoPivWXTQc91lM55scp1TsWM7KYAkZKCYYjTFjLwwA=; b=eP3AtQH8Ft3/1aQU3b50ikl2kh
        uvnK5IAtJPeRye3apH7rCXI3m1SN4WPI63uFXBNEjPmv4cDphteZ42pnT7TPGmxW5RXz81CHXczTh
        OzjCvLGsT/gN3QlrIDNHh69a4JM45LViFEJP3NkC5h1OqLxWYzzfv8mI8BJ7DgsVBoXipFtEYGf5K
        PrXWqugX074d4EkbM0Wpd7NTVwt7SU2Hi6//t2gsOHwfgWzeLcdO6IpR8ghDmzqVbEE6rGt4Z/Sr1
        3nf0XARAeZo8X02Q+ULbLP+mjGvrtH4rU4sL9cUAPzXI6gMHmgrwhoIS87WDVJ3AVZDPsTxWdT/bE
        mCVLwX2g==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53192 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1okOSo-0007Ky-Cl; Mon, 17 Oct 2022 13:39:22 +0200
Message-ID: <a2720899-e93b-6b84-f30b-8d3d28986259@tronnes.org>
Date:   Mon, 17 Oct 2022 13:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 20/22] drm/vc4: vec: Convert to the new TV mode
 property
To:     Maxime Ripard <maxime@cerno.tech>,
        Karol Herbst <kherbst@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v5-0-d841cc64fe4b@cerno.tech>
 <20220728-rpi-analog-tv-properties-v5-20-d841cc64fe4b@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-20-d841cc64fe4b@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 13.10.2022 15.19, skrev Maxime Ripard:
> Now that the core can deal fine with analog TV modes, let's convert the vc4
> VEC driver to leverage those new features.
> 
> We've added some backward compatibility to support the old TV mode property
> and translate it into the new TV norm property. We're also making use of
> the new analog TV atomic_check helper to make sure we trigger a modeset
> whenever the TV mode is updated.
> 
> Acked-by: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---

> @@ -276,19 +292,96 @@ static void vc4_vec_connector_reset(struct drm_connector *connector)
>  
>  static int vc4_vec_connector_get_modes(struct drm_connector *connector)
>  {
> -	struct drm_connector_state *state = connector->state;
>  	struct drm_display_mode *mode;
>  
> -	mode = drm_mode_duplicate(connector->dev,
> -				  vc4_vec_tv_modes[state->tv.legacy_mode].mode);
> +	mode = drm_mode_analog_ntsc_480i(connector->dev);
>  	if (!mode) {
>  		DRM_ERROR("Failed to create a new display mode\n");
>  		return -ENOMEM;
>  	}
>  
> +	mode->type |= DRM_MODE_TYPE_PREFERRED;
>  	drm_mode_probed_add(connector, mode);
>  
> -	return 1;
> +	mode = drm_mode_analog_pal_576i(connector->dev);
> +	if (!mode) {
> +		DRM_ERROR("Failed to create a new display mode\n");
> +		return -ENOMEM;

I just remembered that you can't return an error from .get_modes, it
should only return the number of modes added. From doc:

	 * RETURNS:
	 *
	 * The number of modes added by calling drm_mode_probed_add().

See also the use of count in drm_helper_probe_single_connector_modes().

Patch 14 and 22 has the same issue.

Noralf.

> +	}
> +
> +	drm_mode_probed_add(connector, mode);
> +
> +	return 2;
> +}
> +
> +static int
> +vc4_vec_connector_set_property(struct drm_connector *connector,
> +			       struct drm_connector_state *state,
> +			       struct drm_property *property,
> +			       uint64_t val)
> +{
> +	struct vc4_vec *vec = connector_to_vc4_vec(connector);
> +
> +	if (property != vec->legacy_tv_mode_property)
> +		return -EINVAL;
> +
> +	switch (val) {
> +	case VC4_VEC_TV_MODE_NTSC:
> +		state->tv.mode = DRM_MODE_TV_MODE_NTSC;
> +		break;
> +
> +	case VC4_VEC_TV_MODE_NTSC_J:
> +		state->tv.mode = DRM_MODE_TV_MODE_NTSC_J;
> +		break;
> +
> +	case VC4_VEC_TV_MODE_PAL:
> +		state->tv.mode = DRM_MODE_TV_MODE_PAL;
> +		break;
> +
> +	case VC4_VEC_TV_MODE_PAL_M:
> +		state->tv.mode = DRM_MODE_TV_MODE_PAL_M;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +vc4_vec_connector_get_property(struct drm_connector *connector,
> +			       const struct drm_connector_state *state,
> +			       struct drm_property *property,
> +			       uint64_t *val)
> +{
> +	struct vc4_vec *vec = connector_to_vc4_vec(connector);
> +
> +	if (property != vec->legacy_tv_mode_property)
> +		return -EINVAL;
> +
> +	switch (state->tv.mode) {
> +	case DRM_MODE_TV_MODE_NTSC:
> +		*val = VC4_VEC_TV_MODE_NTSC;
> +		break;
> +
> +	case DRM_MODE_TV_MODE_NTSC_J:
> +		*val = VC4_VEC_TV_MODE_NTSC_J;
> +		break;
> +
> +	case DRM_MODE_TV_MODE_PAL:
> +		*val = VC4_VEC_TV_MODE_PAL;
> +		break;
> +
> +	case DRM_MODE_TV_MODE_PAL_M:
> +		*val = VC4_VEC_TV_MODE_PAL_M;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
>  }
>  
>  static const struct drm_connector_funcs vc4_vec_connector_funcs = {
> @@ -297,15 +390,19 @@ static const struct drm_connector_funcs vc4_vec_connector_funcs = {
>  	.reset = vc4_vec_connector_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +	.atomic_get_property = vc4_vec_connector_get_property,
> +	.atomic_set_property = vc4_vec_connector_set_property,
>  };
>  
>  static const struct drm_connector_helper_funcs vc4_vec_connector_helper_funcs = {
> +	.atomic_check = drm_atomic_helper_connector_tv_check,
>  	.get_modes = vc4_vec_connector_get_modes,
>  };
>  
>  static int vc4_vec_connector_init(struct drm_device *dev, struct vc4_vec *vec)
>  {
>  	struct drm_connector *connector = &vec->connector;
> +	struct drm_property *prop;
>  	int ret;
>  
>  	connector->interlace_allowed = true;
> @@ -318,8 +415,17 @@ static int vc4_vec_connector_init(struct drm_device *dev, struct vc4_vec *vec)
>  	drm_connector_helper_add(connector, &vc4_vec_connector_helper_funcs);
>  
>  	drm_object_attach_property(&connector->base,
> -				   dev->mode_config.legacy_tv_mode_property,
> -				   VC4_VEC_TV_MODE_NTSC);
> +				   dev->mode_config.tv_mode_property,
> +				   DRM_MODE_TV_MODE_NTSC);
> +
> +	prop = drm_property_create_enum(dev, 0, "mode",
> +					legacy_tv_mode_names,
> +					ARRAY_SIZE(legacy_tv_mode_names));
> +	if (!prop)
> +		return -ENOMEM;
> +	vec->legacy_tv_mode_property = prop;
> +
> +	drm_object_attach_property(&connector->base, prop, VC4_VEC_TV_MODE_NTSC);
>  
>  	drm_connector_attach_encoder(connector, &vec->encoder.base);
>  
> @@ -366,13 +472,16 @@ static void vc4_vec_encoder_enable(struct drm_encoder *encoder,
>  	struct drm_connector *connector = &vec->connector;
>  	struct drm_connector_state *conn_state =
>  		drm_atomic_get_new_connector_state(state, connector);
> -	const struct vc4_vec_tv_mode *tv_mode =
> -		&vc4_vec_tv_modes[conn_state->tv.legacy_mode];
> +	const struct vc4_vec_tv_mode *tv_mode;
>  	int idx, ret;
>  
>  	if (!drm_dev_enter(drm, &idx))
>  		return;
>  
> +	tv_mode = vc4_vec_tv_mode_lookup(conn_state->tv.mode);
> +	if (!tv_mode)
> +		goto err_dev_exit;
> +
>  	ret = pm_runtime_get_sync(&vec->pdev->dev);
>  	if (ret < 0) {
>  		DRM_ERROR("Failed to retain power domain: %d\n", ret);
> @@ -454,13 +563,6 @@ static int vc4_vec_encoder_atomic_check(struct drm_encoder *encoder,
>  					struct drm_connector_state *conn_state)
>  {
>  	const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> -	const struct vc4_vec_tv_mode *vec_mode;
> -
> -	vec_mode = &vc4_vec_tv_modes[conn_state->tv.legacy_mode];
> -
> -	if (conn_state->crtc &&
> -	    !drm_mode_equal(vec_mode->mode, &crtc_state->adjusted_mode))
> -		return -EINVAL;
>  
>  	if (mode->crtc_hdisplay % 4)
>  		return -EINVAL;
> @@ -554,13 +656,6 @@ static const struct of_device_id vc4_vec_dt_match[] = {
>  	{ /* sentinel */ },
>  };
>  
> -static const char * const tv_mode_names[] = {
> -	[VC4_VEC_TV_MODE_NTSC] = "NTSC",
> -	[VC4_VEC_TV_MODE_NTSC_J] = "NTSC-J",
> -	[VC4_VEC_TV_MODE_PAL] = "PAL",
> -	[VC4_VEC_TV_MODE_PAL_M] = "PAL-M",
> -};
> -
>  static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -568,9 +663,11 @@ static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
>  	struct vc4_vec *vec;
>  	int ret;
>  
> -	ret = drm_mode_create_tv_properties_legacy(drm,
> -						   ARRAY_SIZE(tv_mode_names),
> -						   tv_mode_names);
> +	ret = drm_mode_create_tv_properties(drm,
> +					    BIT(DRM_MODE_TV_MODE_NTSC) |
> +					    BIT(DRM_MODE_TV_MODE_NTSC_J) |
> +					    BIT(DRM_MODE_TV_MODE_PAL) |
> +					    BIT(DRM_MODE_TV_MODE_PAL_M));
>  	if (ret)
>  		return ret;
>  
> 
