Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5911600CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJQKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJQKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:44:58 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6912B23146
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qeYGbN2RwRCxQ6AMeNN4NET15UVb7PUi0OEIs+b6DkY=; b=jaCLyiJIXlOFybxMXHamoKAPkX
        RHSfiMXeX4fvs7LiQKE8Q5e/06tx2cQwr8jIMeCYwO8NUrWL3TOpqtA2uuBb8mjxfcD0MAqHQqqkI
        Oj0+Yj+NMSh0lSKW99AmftyTYxvcUU2ptJHFipdq3DamjRcFZtnVbWv5KRKncuGL/Krgp/IS887/G
        r8Dq6EE2ZunlWE/VAXv2ZEK9A6NSKX4L0v5limK7McDeDp08wbRQGG4IrtApe/df2nrJCJF4LNJ78
        0Mj+gtIYfPtsmTPGfDKoclxCyXLbsoHiRVtCqON1ffVLz7nhdhmuCaWLHwoRJejNa4R42VHxxPD9I
        rhlfsfCA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:62495 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1okNc1-0003mn-9T; Mon, 17 Oct 2022 12:44:49 +0200
Message-ID: <7dcf479c-8ac7-ed47-8587-30268684373c@tronnes.org>
Date:   Mon, 17 Oct 2022 12:44:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 12/22] drm/connector: Add a function to lookup a TV
 mode by its name
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
 <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v5-12-d841cc64fe4b@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 13.10.2022 15.18, skrev Maxime Ripard:
> As part of the command line parsing rework coming in the next patches,
> we'll need to lookup drm_connector_tv_mode values by their name, already
> defined in drm_tv_mode_enum_list.
> 
> In order to avoid any code duplication, let's do a function that will
> perform a lookup of a TV mode name and return its value.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/drm_connector.c | 24 ++++++++++++++++++++++++
>  include/drm/drm_connector.h     |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 820f4c730b38..30611c616435 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -991,6 +991,30 @@ static const struct drm_prop_enum_list drm_tv_mode_enum_list[] = {
>  };
>  DRM_ENUM_NAME_FN(drm_get_tv_mode_name, drm_tv_mode_enum_list)
>  
> +/**
> + * drm_get_tv_mode_from_name - Translates a TV mode name into its enum value
> + * @name: TV Mode name we want to convert
> + * @len: Length of @name
> + *
> + * Translates @name into an enum drm_connector_tv_mode.
> + *
> + * Returns: the enum value on success, a negative errno otherwise.
> + */
> +int drm_get_tv_mode_from_name(const char *name, size_t len)

Do we really need to pass in length here?
item->name has to always be NUL terminated otherwise things would break
elsewhere, so it shouldn't be necessary AFAICS.

Noralf.

> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(drm_tv_mode_enum_list); i++) {
> +		const struct drm_prop_enum_list *item = &drm_tv_mode_enum_list[i];
> +
> +		if (strlen(item->name) == len && !strncmp(item->name, name, len))
> +			return item->type;
> +	}
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(drm_get_tv_mode_from_name);
> +
>  static const struct drm_prop_enum_list drm_tv_select_enum_list[] = {
>  	{ DRM_MODE_SUBCONNECTOR_Automatic, "Automatic" }, /* DVI-I and TV-out */
>  	{ DRM_MODE_SUBCONNECTOR_Composite, "Composite" }, /* TV-out */
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index a501db7d2222..a33f24a76738 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1864,6 +1864,8 @@ const char *drm_get_dp_subconnector_name(int val);
>  const char *drm_get_content_protection_name(int val);
>  const char *drm_get_hdcp_content_type_name(int val);
>  
> +int drm_get_tv_mode_from_name(const char *name, size_t len);
> +
>  int drm_mode_create_dvi_i_properties(struct drm_device *dev);
>  void drm_connector_attach_dp_subconnector_property(struct drm_connector *connector);
>  
> 
