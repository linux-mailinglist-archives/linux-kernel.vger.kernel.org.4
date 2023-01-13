Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54784668AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjAMEcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbjAMEbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:31:08 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770F66996
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:30:13 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id x7so8164603qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eq+rpIkgrrPXtDdDeefRpkU5Rh9fVs13wVLx65BbmY=;
        b=Cz7Jii/Gioxna8Eo3B0OU976JQdUJxqXxDFbY7IOl+GWhthOYCUfpFruf9gUbgWalW
         3QZW2dGQfBnROLSWS26NZrxCx9pyhX7f1CVZDtMUCdVj/yXI1tXqKVpambTLLl2Hb7uH
         Ad0olCYBhig9H+TOUOaAR1xtta0VSvE4d8YEL+hbJMx2KbWK3/SmXjD+EB227L5P2GwI
         RN71kcr9Lw/5nakrsLpFN2toQKZJy0zxtVBxo0dXJkhTEVGyJZY2CnCGP0+0c202Lybv
         9l1rLnwPhyVOYO9hRQ4xGRiD9TuuK92XKNGjaYw5RKGyHKT9skkJq7p3ImyU7mNsLO8a
         vkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eq+rpIkgrrPXtDdDeefRpkU5Rh9fVs13wVLx65BbmY=;
        b=wi0u4W+VVVwmEk2fvAkyCniaWcZHm2ZiBmicSEQhTPYrx2K0B9ucd5briItRNlxecK
         DvxQGuxljxFjfn8dY9E66ILI1pmt5DBRxi8mSZaMWm4WJ/zsdHdkfPkSP0Z6CW43jQ4o
         lqYIRmD2nWr8OrkY1pTm69ieeHPKxZb+t7LI3bxjlE3UwCe5lXX2aaQQMbYekjw9yjur
         P6hInGIiHMef3qXOa0oOAvLUwieOdGUtGMqo/eDnlWRSnsKCax52oT9WrZIqZagP62Cq
         Q/QG7Ek2OVpCenTwgwtdciQcFbSGaWnQQKnf2+Vbuc5V8w1NKtc0F/PKoGIEiRYyQ9uY
         n0DA==
X-Gm-Message-State: AFqh2kpMf2OfjPVb6p6gnGvvN37dwKtpoWWQY9HO3w7dHOYkzXIDODAn
        ATmilzDtLpU+R/O40eDJYY4yGcNENA4=
X-Google-Smtp-Source: AMrXdXtP7TXHPzmkZ+7vV0aehdNZ68hlqGekIMDBecnN7J83DjPf9spa4TeDlmfEvvRVkiLc0yANKA==
X-Received: by 2002:a05:622a:4c88:b0:3a8:21a5:d93 with SMTP id ez8-20020a05622a4c8800b003a821a50d93mr127014366qtb.39.1673584212754;
        Thu, 12 Jan 2023 20:30:12 -0800 (PST)
Received: from localhost ([2607:fea8:a2df:3d00::e680])
        by smtp.gmail.com with ESMTPSA id hg20-20020a05622a611400b003a81eef14efsm10005820qtb.45.2023.01.12.20.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:30:12 -0800 (PST)
Date:   Thu, 12 Jan 2023 23:30:10 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Joel Selvaraj <jo@jsfamily.in>,
        Robert Chiras <robert.chiras@nxp.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Vinay Simha BN <simhavcs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>
Subject: Re: [RFC PATCH] drm/dsi-mipi: Fix byte order of DCS set/get
 brightness
Message-ID: <Y8DeUssOz0UbSKxb@radian>
References: <20230113041848.200704-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041848.200704-1-mailingradian@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:18:48PM -0500, Richard Acayan wrote:
> From: Daniel Mentz <danielmentz@google.com>
>
> The MIPI DCS specification demands that brightness values are sent in
> big endian byte order. It also states that one parameter (i.e. one byte)
> shall be sent/received for 8 bit wide values, and two parameters shall
> be used for values that are between 9 and 16 bits wide.
>
> Fixes: 1a9d759331b8 ("drm/dsi: Implement DCS set/get display brightness")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Change-Id: I24306e21ec6a5ff48ea121d977419a81d5b44152
> Link: https://android.googlesource.com/kernel/msm/+/754affd62d0ee268c686c53169b1dbb7deac8550
> [richard: fix 16-bit brightness_get; change brightness call by all panels on the -next tree]
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/gpu/drm/drm_mipi_dsi.c                | 44 ++++++++++++++++---
>  .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  |  4 +-
>  .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    |  4 +-
>  drivers/gpu/drm/panel/panel-ebbg-ft8719.c     |  2 +-
>  drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c  |  2 +-
>  .../gpu/drm/panel/panel-jdi-lt070me05000.c    |  4 +-
>  drivers/gpu/drm/panel/panel-raydium-rm67191.c |  4 +-
>  .../gpu/drm/panel/panel-samsung-s6e63j0x03.c  |  2 +-
>  drivers/gpu/drm/panel/panel-samsung-sofef00.c |  4 +-
>  .../panel/panel-sony-tulip-truly-nt35521.c    |  4 +-
>  include/drm/drm_mipi_dsi.h                    |  4 +-
>  11 files changed, 55 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 497ef4b6a90a..1e6dbf986d97 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -1180,17 +1180,33 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_tear_scanline);
>   *    display
>   * @dsi: DSI peripheral device
>   * @brightness: brightness value
> + * @num_params: Number of parameters (bytes) to encode brightness value in. The
> + *              MIPI specification states that one parameter shall be sent for
> + *              devices that support 8-bit brightness levels. For devices that
> + *              support brightness levels wider than 8-bit, two parameters
> + *              shall be sent.
Only one brightness parameter is always sent, no matter how large it is. This
isn't the number of parameters, but the number of bytes ("num_bytes").

If there are always one or two bytes, would it be better to have this as a
"large" boolean?

>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
> -					u16 brightness)
> +					u16 brightness, size_t num_params)
>  {
> -	u8 payload[2] = { brightness & 0xff, brightness >> 8 };
> +	u8 payload[2];
>  	ssize_t err;
>  
> +	switch (num_params) {
> +	case 1:
> +		payload[0] = brightness & 0xff;
> +		break;
> +	case 2:
> +		payload[0] = brightness >> 8;
> +		payload[1] = brightness & 0xff;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  	err = mipi_dsi_dcs_write(dsi, MIPI_DCS_SET_DISPLAY_BRIGHTNESS,
> -				 payload, sizeof(payload));
> +				 payload, num_params);
>  	if (err < 0)
>  		return err;
>  
> @@ -1203,16 +1219,25 @@ EXPORT_SYMBOL(mipi_dsi_dcs_set_display_brightness);
>   *    of the display
>   * @dsi: DSI peripheral device
>   * @brightness: brightness value
> + * @num_params: Number of parameters (i.e. bytes) the brightness value is
> + *              encoded in. The MIPI specification states that one parameter
> + *              shall be returned from devices that support 8-bit brightness
> + *              levels. Devices that support brightness levels wider than
> + *              8-bit return two parameters (i.e. bytes).
>   *
>   * Return: 0 on success or a negative error code on failure.
>   */
>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
> -					u16 *brightness)
> +					u16 *brightness, size_t num_params)
>  {
> +	u8 payload[2];
>  	ssize_t err;
>  
> +	if (!(num_params == 1 || num_params == 2))
> +		return -EINVAL;
> +
>  	err = mipi_dsi_dcs_read(dsi, MIPI_DCS_GET_DISPLAY_BRIGHTNESS,
> -				brightness, sizeof(*brightness));
> +				payload, num_params);
>  	if (err <= 0) {
>  		if (err == 0)
>  			err = -ENODATA;
> @@ -1220,6 +1245,15 @@ int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
>  		return err;
>  	}
>  
> +	switch (num_params) {
> +	case 1:
> +		*brightness = payload[0];
> +		break;
> +	case 2:
> +		*brightness = (payload[0] << 8) | payload[1];
> +		break;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(mipi_dsi_dcs_get_display_brightness);
> diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> index b3235781e6ba..9f849c68d57c 100644
> --- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> +++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
> @@ -220,7 +220,7 @@ static int tm5p5_nt35596_bl_update_status(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -237,7 +237,7 @@ static int tm5p5_nt35596_bl_get_brightness(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> index ad58840eda41..5a0366366055 100644
> --- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> +++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
> @@ -253,7 +253,7 @@ static int boe_bf060y8m_aj0_bl_update_status(struct backlight_device *bl)
>  	u16 brightness = backlight_get_brightness(bl);
>  	int ret;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -266,7 +266,7 @@ static int boe_bf060y8m_aj0_bl_get_brightness(struct backlight_device *bl)
>  	u16 brightness;
>  	int ret;
>  
> -	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> index e85d63a176d0..0666e0390c7c 100644
> --- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> +++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> @@ -62,7 +62,7 @@ static int ebbg_ft8719_on(struct ebbg_ft8719 *ctx)
>  
>  	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff, 1);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set display brightness: %d\n", ret);
>  		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> index d8765b2294fb..47ebf7b7da4a 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
> @@ -102,7 +102,7 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
>  		return ret;
>  	}
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff, 1);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set display brightness: %d\n", ret);
>  		return ret;
> diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> index 8f4f137a2af6..7d2f147a2504 100644
> --- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> +++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
> @@ -332,7 +332,7 @@ static int dsi_dcs_bl_get_brightness(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -348,7 +348,7 @@ static int dsi_dcs_bl_update_status(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> index dbb1ed4efbed..00f6bd163af2 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
> @@ -473,7 +473,7 @@ static int rad_bl_get_brightness(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -493,7 +493,7 @@ static int rad_bl_update_status(struct backlight_device *bl)
>  
>  	dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, bl->props.brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> index e06fd35de814..f5e235db7ad2 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
> @@ -365,7 +365,7 @@ static int s6e63j0x03_enable(struct drm_panel *panel)
>  		return ret;
>  
>  	/* set default white brightness */
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panel/panel-samsung-sofef00.c b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> index 1a0d24595faa..b481195c9b8f 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-sofef00.c
> @@ -224,10 +224,8 @@ static int sofef00_panel_bl_update_status(struct backlight_device *bl)
>  	u16 brightness;
>  
>  	brightness = (u16)backlight_get_brightness(bl);
> -	// This panel needs the high and low bytes swapped for the brightness value
> -	brightness = __swab16(brightness);
>  
> -	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	err = mipi_dsi_dcs_set_display_brightness(dsi, brightness, 2);
>  	if (err < 0)
>  		return err;
>  
> diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> index fa9be3c299c0..dbf179fdda88 100644
> --- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> +++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
> @@ -420,7 +420,7 @@ static int truly_nt35521_bl_update_status(struct backlight_device *bl)
>  	u16 brightness = backlight_get_brightness(bl);
>  	int ret;
>  
> -	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness);
> +	ret = mipi_dsi_dcs_set_display_brightness(dsi, brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -433,7 +433,7 @@ static int truly_nt35521_bl_get_brightness(struct backlight_device *bl)
>  	u16 brightness;
>  	int ret;
>  
> -	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness);
> +	ret = mipi_dsi_dcs_get_display_brightness(dsi, &brightness, 1);
>  	if (ret < 0)
>  		return ret;
>  
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 4f503d99f668..da02f09f251b 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -293,9 +293,9 @@ int mipi_dsi_dcs_set_tear_on(struct mipi_dsi_device *dsi,
>  int mipi_dsi_dcs_set_pixel_format(struct mipi_dsi_device *dsi, u8 format);
>  int mipi_dsi_dcs_set_tear_scanline(struct mipi_dsi_device *dsi, u16 scanline);
>  int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
> -					u16 brightness);
> +					u16 brightness, size_t num_params);
>  int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
> -					u16 *brightness);
> +					u16 *brightness, size_t num_params);
>  
>  /**
>   * mipi_dsi_generic_write_seq - transmit data using a generic write packet
> -- 
> 2.39.0
>
