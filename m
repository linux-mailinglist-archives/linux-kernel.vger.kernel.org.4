Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C14600C85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiJQKgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJQKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:36:21 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8D2BD7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RkOJF9SpLP2Tuwb8m8kmcMI162AWfyYlgbz9az1Vuyg=; b=mM2e036ArpX5LtuzgXKAvMNDlk
        6DGgU3LshBPTEFSa9tI8jWUWySY6YQ0jBs2fq4agCSx4PN9IPb2W8fkb25USXDMqRzIta/Vv5QA2c
        ad90/Bd2qXUSYG3e2ZDyZQJ7PB8UnHTRk6pztxuHJ9s86hPBG38K7H/quevtVAoaTQAQAa8DuEGpz
        ytpFmtrJ/egdGt2gFRvxsCbKH4oHhqJzZRc8qY/Rlw813hJ1lijHYZSbPQQ5G0RNU697g8dxuzeG/
        EHfRGHiXRF2Rie2/f0VFBpFbXvsiW51BGhv0uN4Jw9jfdy4AA5N3VCNMBO4T/O5EqKm43FOz+olKp
        qFHzmoeQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:61475 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1okNTl-0005Wj-Mh; Mon, 17 Oct 2022 12:36:17 +0200
Message-ID: <87702f79-36f4-278e-ef98-279543d71318@tronnes.org>
Date:   Mon, 17 Oct 2022 12:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 16/22] drm/atomic-helper: Add a TV properties reset
 helper
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
 <20220728-rpi-analog-tv-properties-v5-16-d841cc64fe4b@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-16-d841cc64fe4b@cerno.tech>
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
> The drm_tv_create_properties() function will create a bunch of properties,
> but it's up to each and every driver using that function to properly reset
> the state of these properties leading to inconsistent behaviours.
> 
> Let's create a helper that will take care of it.
> 
> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 75 +++++++++++++++++++++++++++++++
>  include/drm/drm_atomic_state_helper.h     |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index dfb57217253b..0373c3dc824b 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -481,6 +481,81 @@ void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connecto
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);
>  
> +/**
> + * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector properties
> + * @connector: DRM connector
> + *
> + * Resets the analog TV properties attached to a connector
> + */
> +void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
> +	struct drm_connector_state *state = connector->state;
> +	struct drm_property *prop;
> +	uint64_t val;
> +
> +	prop = dev->mode_config.tv_mode_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.mode = val;
> +
> +	if (cmdline->tv_mode)
> +		state->tv.mode = cmdline->tv_mode;

This can't set ntsc now that the none value is gone.
But we need a tv_mode_specified flag as mentioned in the other patch.

Noralf.

> +
> +	prop = dev->mode_config.tv_select_subconnector_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.select_subconnector = val;
> +
> +	prop = dev->mode_config.tv_subconnector_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.subconnector = val;
> +
> +	prop = dev->mode_config.tv_brightness_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.brightness = val;
> +
> +	prop = dev->mode_config.tv_contrast_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.contrast = val;
> +
> +	prop = dev->mode_config.tv_flicker_reduction_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.flicker_reduction = val;
> +
> +	prop = dev->mode_config.tv_overscan_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.overscan = val;
> +
> +	prop = dev->mode_config.tv_saturation_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.saturation = val;
> +
> +	prop = dev->mode_config.tv_hue_property;
> +	if (prop)
> +		if (!drm_object_property_get_default_value(&connector->base,
> +							   prop, &val))
> +			state->tv.hue = val;
> +
> +	drm_atomic_helper_connector_tv_margins_reset(connector);
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
> +
>  /**
>   * __drm_atomic_helper_connector_duplicate_state - copy atomic connector state
>   * @connector: connector object
> diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
> index 192766656b88..c8fbce795ee7 100644
> --- a/include/drm/drm_atomic_state_helper.h
> +++ b/include/drm/drm_atomic_state_helper.h
> @@ -70,6 +70,7 @@ void __drm_atomic_helper_connector_state_reset(struct drm_connector_state *conn_
>  void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
>  					 struct drm_connector_state *conn_state);
>  void drm_atomic_helper_connector_reset(struct drm_connector *connector);
> +void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
>  void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
>  void
>  __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
> 
