Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C31E61E23F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiKFNFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 08:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKFNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 08:05:14 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360A60F3
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 05:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zu9AvI8pVCg+w6/C4cAjAvLV1abDQEDfDf9UUW1vxDg=; b=gB8dUXELYGglrJq7tEcE5QQsRB
        r+xvFlg6bVTnX5hpcR6TF1milIuxhvFHmOzcTQ+AKlmYmrlp4T7q7grZpuumOnLxEF6vqYKb5gVa2
        rjqJcnxEGCRUZKvLXrkc5sku+L4Jf6QP3k05QOxJ0n65HXml/Amq2cEEnfx022V37sKMr1NKe3q9i
        i4UtuSeZ/UdRDUr7jYPs4FhLEL7l2H8lBg7+Hd6HC0oMSf1plM3XLZsHr/aG+8Tiuh+g86RFhOGFY
        wSUUtbsXJDD/3H0WxMSSP0M3nSGGSxMTzJYZC/Byx7gtbpHht/35mHg1zEXv9kSvRPi3Xh7HkbMiu
        o/5OseHQ==;
Received: from [2a01:799:95a:cb00:a93e:4a2b:2c13:303] (port=57940)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1orfKm-0000YW-K2; Sun, 06 Nov 2022 14:05:08 +0100
Message-ID: <fa1e7635-ffd6-bf01-77aa-4016f31554e1@tronnes.org>
Date:   Sun, 6 Nov 2022 14:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 10/23] drm/modes: Fill drm_cmdline mode from named
 modes
To:     maxime@cerno.tech, Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Ben Skeggs <bskeggs@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>
Cc:     linux-sunxi@lists.linux.dev, intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        nouveau@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v6-0-e7792734108f@cerno.tech>
 <20220728-rpi-analog-tv-properties-v6-10-e7792734108f@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v6-10-e7792734108f@cerno.tech>
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



Den 26.10.2022 17.33, skrev maxime@cerno.tech:
> The current code to deal with named modes will only set the mode name, and
> then it's up to drivers to try to match that name to whatever mode or
> configuration they see fit.
> 

I couldn't find any driver that does that, all I could find that cares
about named modes are drm_client. Did I miss something here?

Apart from that:

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>

> The plan is to remove that need and move the named mode handling out of
> drivers and into the core, and only rely on modes and properties. Let's
> start by properly filling drm_cmdline_mode from a named mode.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/drm_modes.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 7594b657f86a..acee23e1a8b7 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -2226,11 +2226,22 @@ static int drm_mode_parse_cmdline_options(const char *str,
>  
>  struct drm_named_mode {
>  	const char *name;
> +	unsigned int xres;
> +	unsigned int yres;
> +	unsigned int flags;
>  };
>  
> +#define NAMED_MODE(_name, _x, _y, _flags)		\
> +	{						\
> +		.name = _name,				\
> +		.xres = _x,				\
> +		.yres = _y,				\
> +		.flags = _flags,			\
> +	}
> +
>  static const struct drm_named_mode drm_named_modes[] = {
> -	{ "NTSC", },
> -	{ "PAL", },
> +	NAMED_MODE("NTSC", 720, 480, DRM_MODE_FLAG_INTERLACE),
> +	NAMED_MODE("PAL", 720, 576, DRM_MODE_FLAG_INTERLACE),
>  };
>  
>  static int drm_mode_parse_cmdline_named_mode(const char *name,
> @@ -2271,6 +2282,9 @@ static int drm_mode_parse_cmdline_named_mode(const char *name,
>  			continue;
>  
>  		strcpy(cmdline_mode->name, mode->name);
> +		cmdline_mode->xres = mode->xres;
> +		cmdline_mode->yres = mode->yres;
> +		cmdline_mode->interlace = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
>  		cmdline_mode->specified = true;
>  
>  		return 1;
> 
