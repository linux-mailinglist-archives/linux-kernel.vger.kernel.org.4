Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2566DC79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjAQLc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjAQLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:31:55 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632382E0F7;
        Tue, 17 Jan 2023 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673955111; x=1705491111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CfMaOv1TVhzpe25wcQY53st61m4z6TQuhUI+F0Ssj/o=;
  b=XKGedOe4i0HViO5fV6iwK+1U0Gubk41uOWsTzRzf89VcxBLiSxgD9+Ku
   6UjEaD2TcEB013l6HHCKH+EiERVIJ+SkZo/HpVQQT0H9IZ9/Wfc88BVXf
   bh3LkmfiL5N6RBoB8uNfOnuBQLZEtwOuwE0skhU5LSckKYosJtTUX9sNw
   vfmqw3r7W4T5G2EtwV4yHqnSJm3vN2ppMCO4FjvhW0NEGuIh8CCjvKSK+
   v8Og9uKeGksS478d0gGEgwcF07Gsty094Qrn7FS5czdGiRqu96DpTVGch
   5GRE3jmxpOg3xkHu3S+b2XfRHAX+DLH5Tj8hqY9uH0g8WR+MZPH1aYG+k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324726032"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324726032"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:31:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="659358777"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="659358777"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.10.213]) ([10.213.10.213])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:31:45 -0800
Message-ID: <cdd3c75a-de9f-e1d7-2997-64cc0008c629@intel.com>
Date:   Tue, 17 Jan 2023 12:31:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Content-Language: en-US
To:     Rahul T R <r-ravikumar@ti.com>, dri-devel@lists.freedesktop.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, tomi.valkeinen@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        jpawar@cadence.com, sjakhade@cadence.com, mparab@cadence.com,
        a-bhatia1@ti.com, devicetree@vger.kernel.org, vigneshr@ti.com,
        lee.jones@linaro.org
References: <20230103101951.10963-1-r-ravikumar@ti.com>
 <20230103101951.10963-4-r-ravikumar@ti.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20230103101951.10963-4-r-ravikumar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.2023 11:19, Rahul T R wrote:
> Move the cadence dsi bridge under drm/bridge/cadence directory, to
> prepare for adding j721e wrapper support
>
> Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>

Regards
Andrzej
> ---
>   drivers/gpu/drm/bridge/Kconfig                        | 11 -----------
>   drivers/gpu/drm/bridge/Makefile                       |  1 -
>   drivers/gpu/drm/bridge/cadence/Kconfig                | 11 +++++++++++
>   drivers/gpu/drm/bridge/cadence/Makefile               |  2 ++
>   .../bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c}    |  0
>   5 files changed, 13 insertions(+), 12 deletions(-)
>   rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (100%)
>
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 57946d80b02d..8b2226f72b24 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -15,17 +15,6 @@ config DRM_PANEL_BRIDGE
>   menu "Display Interface Bridges"
>   	depends on DRM && DRM_BRIDGE
>   
> -config DRM_CDNS_DSI
> -	tristate "Cadence DPI/DSI bridge"
> -	select DRM_KMS_HELPER
> -	select DRM_MIPI_DSI
> -	select DRM_PANEL_BRIDGE
> -	select GENERIC_PHY_MIPI_DPHY
> -	depends on OF
> -	help
> -	  Support Cadence DPI to DSI bridge. This is an internal
> -	  bridge and is meant to be directly embedded in a SoC.
> -
>   config DRM_CHIPONE_ICN6211
>   	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
>   	depends on OF
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index 1884803c6860..52f6e8b4a821 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -1,5 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
>   obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
>   obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
>   obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
> index 1d06182bea71..5f39859dcfdd 100644
> --- a/drivers/gpu/drm/bridge/cadence/Kconfig
> +++ b/drivers/gpu/drm/bridge/cadence/Kconfig
> @@ -1,4 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +config DRM_CDNS_DSI
> +	tristate "Cadence DPI/DSI bridge"
> +	select DRM_KMS_HELPER
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL_BRIDGE
> +	select GENERIC_PHY_MIPI_DPHY
> +	depends on OF
> +	help
> +	  Support Cadence DPI to DSI bridge. This is an internal
> +	  bridge and is meant to be directly embedded in a SoC.
> +
>   config DRM_CDNS_MHDP8546
>   	tristate "Cadence DPI/DP bridge"
>   	select DRM_DISPLAY_DP_HELPER
> diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
> index 4d2db8df1bc6..9e2f34c84480 100644
> --- a/drivers/gpu/drm/bridge/cadence/Makefile
> +++ b/drivers/gpu/drm/bridge/cadence/Makefile
> @@ -1,4 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
> +cdns-dsi-y := cdns-dsi-core.o
>   obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
>   cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
>   cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
> diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
> similarity index 100%
> rename from drivers/gpu/drm/bridge/cdns-dsi.c
> rename to drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c

