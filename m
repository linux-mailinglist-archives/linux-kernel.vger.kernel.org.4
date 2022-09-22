Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06B5E6D53
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIVUpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIVUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F8106F73
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663879543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pTwmQ+KMlHtgNXiw9Gsc6D/W6nJso72Y3DgksJPfuk=;
        b=ZPvQc6g0pusK7pbgje8NfXLqoG42xMcSVmwfJ3PKTpbLEuyCW1yMwJVKZchTBHRPK8vtUh
        NEcY7niVqJIgK4fp78zHxZTSM8DPwH1qMR37aVCAzJFGeBp0Fxr4KqSYL8ixVHa5t4aKYS
        r1lcQ4uyUwSXiARtNU4NaToZSaGPzko=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-lcjI_PkVNreujrkjd3Bf1A-1; Thu, 22 Sep 2022 16:45:42 -0400
X-MC-Unique: lcjI_PkVNreujrkjd3Bf1A-1
Received: by mail-qv1-f71.google.com with SMTP id nl18-20020a056214369200b004ac52c4b0a4so7258018qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=2pTwmQ+KMlHtgNXiw9Gsc6D/W6nJso72Y3DgksJPfuk=;
        b=sGVk2GoKsC4anPV77eotKtoPdCgPW0WuAIqdU2E8fOXHCxtv+IP0+RvpGvhFqz/fR9
         t4ubnjL2PJ1eAkmc+NGqAonMrMCitiMW+2iufVP3+EqqtZR4125BwqoJXWy2iBmBnihO
         CFG5mNX91UZV77V4LtvojmV057DVsJyOz43726ILT1Zg/ji5jTXGHbJXMyQTE8dZOqRv
         22RMBv862Ic53PexqNwQYekWcAETp/x9756d3KNEj3xfQprq5n9AnNdlxouojTv34wo8
         SGHmnlsvQMwuWohxqAfl8m3w7i73KmCwHe1/ZjEO8T6IL+ZlkDuvrszSoGLmF3h7oeNM
         uvAA==
X-Gm-Message-State: ACrzQf06gurgmeAHxWhPzQ96QHRH3NqhHNNd85xiKnp9/CnG2yAhHPpn
        JeFdpBgiocrEeDH517j3Ps87wTflq9Dq9hRALUzVhEzvLb0MAOb5Jv2oxErpq3MQPN/8x9x4RmX
        Q5s9ErrTZuThIfwhGGFwrwuaz
X-Received: by 2002:ac8:57cc:0:b0:35c:b5d1:9024 with SMTP id w12-20020ac857cc000000b0035cb5d19024mr4552782qta.214.1663879541938;
        Thu, 22 Sep 2022 13:45:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6UJCB0gG/rO87ayUHT6cZoHMF2bD+DFkmZIeVDat+OrR1utdi7dIqfkWvtqZHLQ+pmTyKJ5A==
X-Received: by 2002:ac8:57cc:0:b0:35c:b5d1:9024 with SMTP id w12-20020ac857cc000000b0035cb5d19024mr4552744qta.214.1663879541641;
        Thu, 22 Sep 2022 13:45:41 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ce63901d27sm4686286qkp.4.2022.09.22.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 13:45:40 -0700 (PDT)
Message-ID: <3bfe5ffbba617f56290e79db358364ba8dc49fee.camel@redhat.com>
Subject: Re: [PATCH v2 08/33] drm/connector: Rename
 drm_mode_create_tv_properties
From:   Lyude Paul <lyude@redhat.com>
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Dom Cobley <dom@raspberrypi.com>, linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org
Date:   Thu, 22 Sep 2022 16:45:39 -0400
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-8-f733a0ed9f90@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-f733a0ed9f90@cerno.tech>
         <20220728-rpi-analog-tv-properties-v2-8-f733a0ed9f90@cerno.tech>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nouveau:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Thu, 2022-09-22 at 16:25 +0200, Maxime Ripard wrote:
> drm_mode_create_tv_properties(), among other things, will create the
> "mode" property that stores the analog TV mode that connector is
> supposed to output.
> 
> However, that property is getting deprecated, so let's rename that
> function to mention it's deprecated. We'll introduce a new variant of
> that function creating the property superseeding it in a later patch.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 17a5913cefe3..4e4fbc9e0049 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1600,7 +1600,7 @@ EXPORT_SYMBOL(drm_connector_attach_tv_margin_properties);
>   * Called by a driver's HDMI connector initialization routine, this function
>   * creates the TV margin properties for a given device. No need to call this
>   * function for an SDTV connector, it's already called from
> - * drm_mode_create_tv_properties().
> + * drm_mode_create_tv_properties_legacy().
>   *
>   * Returns:
>   * 0 on success or a negative error code on failure.
> @@ -1635,7 +1635,7 @@ int drm_mode_create_tv_margin_properties(struct drm_device *dev)
>  EXPORT_SYMBOL(drm_mode_create_tv_margin_properties);
>  
>  /**
> - * drm_mode_create_tv_properties - create TV specific connector properties
> + * drm_mode_create_tv_properties_legacy - create TV specific connector properties
>   * @dev: DRM device
>   * @num_modes: number of different TV formats (modes) supported
>   * @modes: array of pointers to strings containing name of each format
> @@ -1648,9 +1648,9 @@ EXPORT_SYMBOL(drm_mode_create_tv_margin_properties);
>   * Returns:
>   * 0 on success or a negative error code on failure.
>   */
> -int drm_mode_create_tv_properties(struct drm_device *dev,
> -				  unsigned int num_modes,
> -				  const char * const modes[])
> +int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
> +					 unsigned int num_modes,
> +					 const char * const modes[])
>  {
>  	struct drm_property *tv_selector;
>  	struct drm_property *tv_subconnector;
> @@ -1733,7 +1733,7 @@ int drm_mode_create_tv_properties(struct drm_device *dev,
>  nomem:
>  	return -ENOMEM;
>  }
> -EXPORT_SYMBOL(drm_mode_create_tv_properties);
> +EXPORT_SYMBOL(drm_mode_create_tv_properties_legacy);
>  
>  /**
>   * drm_mode_create_scaling_mode_property - create scaling mode property
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
> index 86e992b2108b..034e78360d4f 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -400,7 +400,7 @@ static int gud_connector_add_tv_mode(struct gud_device *gdrm, struct drm_connect
>  	for (i = 0; i < num_modes; i++)
>  		modes[i] = &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
>  
> -	ret = drm_mode_create_tv_properties(connector->dev, num_modes, modes);
> +	ret = drm_mode_create_tv_properties_legacy(connector->dev, num_modes, modes);
>  free:
>  	kfree(buf);
>  	if (ret < 0)
> @@ -539,7 +539,7 @@ static int gud_connector_add_properties(struct gud_device *gdrm, struct gud_conn
>  			fallthrough;
>  		case GUD_PROPERTY_TV_HUE:
>  			/* This is a no-op if already added. */
> -			ret = drm_mode_create_tv_properties(drm, 0, NULL);
> +			ret = drm_mode_create_tv_properties_legacy(drm, 0, NULL);
>  			if (ret)
>  				goto out;
>  			break;
> diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
> index d29b63fd6178..506f6f932518 100644
> --- a/drivers/gpu/drm/i2c/ch7006_drv.c
> +++ b/drivers/gpu/drm/i2c/ch7006_drv.c
> @@ -250,7 +250,7 @@ static int ch7006_encoder_create_resources(struct drm_encoder *encoder,
>  	struct drm_device *dev = encoder->dev;
>  	struct drm_mode_config *conf = &dev->mode_config;
>  
> -	drm_mode_create_tv_properties(dev, NUM_TV_NORMS, ch7006_tv_norm_names);
> +	drm_mode_create_tv_properties_legacy(dev, NUM_TV_NORMS, ch7006_tv_norm_names);
>  
>  	priv->scale_property = drm_property_create_range(dev, 0, "scale", 0, 2);
>  	if (!priv->scale_property)
> diff --git a/drivers/gpu/drm/i915/display/intel_tv.c b/drivers/gpu/drm/i915/display/intel_tv.c
> index abaf9ded942d..5e88da8185ee 100644
> --- a/drivers/gpu/drm/i915/display/intel_tv.c
> +++ b/drivers/gpu/drm/i915/display/intel_tv.c
> @@ -1984,7 +1984,7 @@ intel_tv_init(struct drm_i915_private *dev_priv)
>  
>  		tv_format_names[i] = tv_modes[i].name;
>  	}
> -	drm_mode_create_tv_properties(dev, i, tv_format_names);
> +	drm_mode_create_tv_properties_legacy(dev, i, tv_format_names);
>  
>  	drm_object_attach_property(&connector->base,
>  				   dev->mode_config.legacy_tv_mode_property,
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 1a15534adc60..e5480dab55e3 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -653,7 +653,7 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
>  			tv_enc->tv_norm = i;
>  	}
>  
> -	drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
> +	drm_mode_create_tv_properties_legacy(dev, num_tv_norms, nv17_tv_norm_names);
>  
>  	drm_object_attach_property(&connector->base,
>  					conf->tv_select_subconnector_property,
> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> index 77c50ecb0309..f31fef938f11 100644
> --- a/drivers/gpu/drm/vc4/vc4_vec.c
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -514,8 +514,9 @@ static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
>  	struct vc4_vec *vec;
>  	int ret;
>  
> -	ret = drm_mode_create_tv_properties(drm, ARRAY_SIZE(tv_mode_names),
> -					    tv_mode_names);
> +	ret = drm_mode_create_tv_properties_legacy(drm,
> +						   ARRAY_SIZE(tv_mode_names),
> +						   tv_mode_names);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 5cfad8b6ad83..d566b4a4709c 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1799,9 +1799,9 @@ int drm_mode_create_dvi_i_properties(struct drm_device *dev);
>  void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector);
>  
>  int drm_mode_create_tv_margin_properties(struct drm_device *dev);
> -int drm_mode_create_tv_properties(struct drm_device *dev,
> -				  unsigned int num_modes,
> -				  const char * const modes[]);
> +int drm_mode_create_tv_properties_legacy(struct drm_device *dev,
> +					 unsigned int num_modes,
> +					 const char * const modes[]);
>  void drm_connector_attach_tv_margin_properties(struct drm_connector *conn);
>  int drm_mode_create_scaling_mode_property(struct drm_device *dev);
>  int drm_connector_attach_content_type_property(struct drm_connector *dev);
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

