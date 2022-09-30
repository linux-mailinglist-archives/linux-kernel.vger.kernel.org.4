Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9995F0B02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiI3Lua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiI3Lt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:49:57 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A301288AA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IifDSaiSaen7SDFh+4iH9IwPZlddD8Axc+s6Pi1ODoY=; b=OYj/yleDGKQJZnmZIrlEbeP/b/
        DoAf3KiJo708NW1GO9RM8Z0+qA/GZsSTYp623JXFCkgvJEkD7l059APXopLJt3s4dB4BYpBi29rDP
        NI+lAlBtvJE5WCKwt8oBRNksB3aLgmGnEcT32XxqmqSa+FRLo/DpbyhRogW6WUmikYauxGu65WXKu
        AGiTYT3bUNYgYIlD0pNZwY7ND2rRwa0GJMbrjn2bjKkl2T+yzthf3wPj4JShRhiBeCWEntMXdpx5u
        8NWKpSyVfeG5PDsXJd8qWDfPuX//9GUVhLdFQO691ossfQdYJDnMUYwa6FlsyJ2LNeWm7Vzwk7hW4
        l1wydY+Q==;
Received: from [2a01:799:961:d200:c807:6849:43f8:dd23] (port=55455)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oeETG-0003MV-SM; Fri, 30 Sep 2022 13:46:22 +0200
Message-ID: <fc7664cc-25f4-ee37-5261-fc6e35259e50@tronnes.org>
Date:   Fri, 30 Sep 2022 13:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 10/30] drm/connector: Add TV standard property
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Karol Herbst <kherbst@redhat.com>,
        Samuel Holland <samuel@sholland.org>,
        Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        intel-gfx@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
        Hans de Goede <hdegoede@redhat.com>,
        nouveau@lists.freedesktop.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Dom Cobley <dom@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v4-0-60d38873f782@cerno.tech>
 <20220728-rpi-analog-tv-properties-v4-10-60d38873f782@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v4-10-60d38873f782@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,WEIRD_QUOTING autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.09.2022 18.31, skrev Maxime Ripard:
> The TV mode property has been around for a while now to select and get the
> current TV mode output on an analog TV connector.
> 
> Despite that property name being generic, its content isn't and has been
> driver-specific which makes it hard to build any generic behaviour on top
> of it, both in kernel and user-space.
> 
> Let's create a new enum tv norm property, that can contain any of the
> analog TV standards currently supported by kernel drivers. Each driver can
> then pass in a bitmask of the modes it supports, and the property
> creation function will filter out the modes not supported.
> 
> We'll then be able to phase out the older tv mode property.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> ---
> Changes in v4:
> - Add property documentation to kms-properties.csv
> - Fix documentation
> ---
>  Documentation/gpu/kms-properties.csv |  1 +
>  drivers/gpu/drm/drm_atomic_uapi.c    |  4 +++
>  drivers/gpu/drm/drm_connector.c      | 57 +++++++++++++++++++++++++++++++-
>  include/drm/drm_connector.h          | 64 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_mode_config.h        |  8 +++++
>  5 files changed, 133 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> index 45c12e3e82f4..3498bd5d5856 100644
> --- a/Documentation/gpu/kms-properties.csv
> +++ b/Documentation/gpu/kms-properties.csv
> @@ -91,6 +91,7 @@ omap,Generic,“zorder”,RANGE,"Min=0, Max=3","CRTC, Plane",TBD
>  qxl,Generic,"“hotplug_mode_update""",RANGE,"Min=0, Max=1",Connector,TBD
>  radeon,DVI-I,“coherent”,RANGE,"Min=0, Max=1",Connector,TBD
>  ,DAC enable load detect,“load detection”,RANGE,"Min=0, Max=1",Connector,TBD
> +,TV Mode,"""TV Mode""",ENUM,"{ ""NTSC"", ""NTSC-443"", ""NTSC-J"", ""PAL"", ""PAL-M"", ""PAL-N"", ""SECAM"" }",Connector,TBD
>  ,legacy TMDS PLL detect,"""tmds_pll""",ENUM,"{ ""driver"", ""bios"" }",-,TBD
>  ,Underscan,"""underscan""",ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
>  ,,"""underscan hborder""",RANGE,"Min=0, Max=128",Connector,TBD

Turns out I was wrong about adding the property to this file, Daniel
says it's deprecated in f0f0657b108c ("drm/doc: Drop "content type" from
the legacy kms property table").

If you look at the Fixes commit it adds a kernel doc HDMI property
section and TV should probably have something like that.

Noralf.
