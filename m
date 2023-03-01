Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE8A6A69FB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCAJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCAJoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:44:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62710A94
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677663862; x=1709199862;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=7nWm1f6bPfOKsLZiND0bxe7rNCn2HYYOED5hRyMYTto=;
  b=amgjS4bBk0UYZtL8hlgD2gDKZTDYMzq+RyQRqXOxMz/qJaOTJ3YOBHrk
   fxxXtmDsvpixhtARFm2BiEZb0MKRb9ePEb4mK4UiW7+2Em1kJ09mg6q9/
   ss1poHogpKiuoXc3XI1IIWATyaUPkRbh1TYVr8vLaIyhKayTpLkDmApkr
   D3j5GMNRv8AvVYKlDod90tEApnJFKzu5dYQoWWwzSdfLhNzWFcIRXQy2R
   e5BYmxhB0hbljq7jhuIlNBhHGx0PiSyrYAAAnXqzzR8ASEJ36nja+HAhC
   H1i/TwDc1MTUjPVE4KcAx26GVDaFgugrvLFTpYRur1dKjmkgzGuiZ0jz/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="322627866"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="322627866"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 01:44:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="624419635"
X-IronPort-AV: E=Sophos;i="5.98,224,1673942400"; 
   d="scan'208";a="624419635"
Received: from dsvarnas-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.46.249])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 01:44:10 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Siddh Raman Pant <code@siddh.me>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jim Cromie <jim.cromie@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Suraj Upadhyay <usuraj35@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v8 1/8] Revert "drm: mipi-dsi: Convert logging to drm_*
 functions."
In-Reply-To: <e427dcb5cff953ace36df3225b8444da5cd83f8b.1677574322.git.code@siddh.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1677574322.git.code@siddh.me>
 <e427dcb5cff953ace36df3225b8444da5cd83f8b.1677574322.git.code@siddh.me>
Date:   Wed, 01 Mar 2023 11:44:08 +0200
Message-ID: <87edq8x0uv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Siddh Raman Pant <code@siddh.me> wrote:
> This reverts commit 1040e424353f5f4d39f6f3aa8723eb3bd6ea6446.
>
> It used an incorrect way to use drm_* functions. Only drm_device ptrs
> should be passed, but the mentioned commit passed mipi_dsi_host ptr.
> It worked by accident due to macro magic.
>
> Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/drm_mipi_dsi.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index 4bc15fbd009d..398fac95dfc0 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -33,7 +33,6 @@
>  
>  #include <drm/display/drm_dsc.h>
>  #include <drm/drm_mipi_dsi.h>
> -#include <drm/drm_print.h>
>  
>  #include <video/mipi_display.h>
>  
> @@ -156,18 +155,19 @@ static int mipi_dsi_device_add(struct mipi_dsi_device *dsi)
>  static struct mipi_dsi_device *
>  of_mipi_dsi_device_add(struct mipi_dsi_host *host, struct device_node *node)
>  {
> +	struct device *dev = host->dev;
>  	struct mipi_dsi_device_info info = { };
>  	int ret;
>  	u32 reg;
>  
>  	if (of_modalias_node(node, info.type, sizeof(info.type)) < 0) {
> -		drm_err(host, "modalias failure on %pOF\n", node);
> +		dev_err(dev, "modalias failure on %pOF\n", node);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	ret = of_property_read_u32(node, "reg", &reg);
>  	if (ret) {
> -		drm_err(host, "device node %pOF has no valid reg property: %d\n",
> +		dev_err(dev, "device node %pOF has no valid reg property: %d\n",
>  			node, ret);
>  		return ERR_PTR(-EINVAL);
>  	}
> @@ -202,21 +202,22 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  			      const struct mipi_dsi_device_info *info)
>  {
>  	struct mipi_dsi_device *dsi;
> +	struct device *dev = host->dev;
>  	int ret;
>  
>  	if (!info) {
> -		drm_err(host, "invalid mipi_dsi_device_info pointer\n");
> +		dev_err(dev, "invalid mipi_dsi_device_info pointer\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	if (info->channel > 3) {
> -		drm_err(host, "invalid virtual channel: %u\n", info->channel);
> +		dev_err(dev, "invalid virtual channel: %u\n", info->channel);
>  		return ERR_PTR(-EINVAL);
>  	}
>  
>  	dsi = mipi_dsi_device_alloc(host);
>  	if (IS_ERR(dsi)) {
> -		drm_err(host, "failed to allocate DSI device %ld\n",
> +		dev_err(dev, "failed to allocate DSI device %ld\n",
>  			PTR_ERR(dsi));
>  		return dsi;
>  	}
> @@ -227,7 +228,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *host,
>  
>  	ret = mipi_dsi_device_add(dsi);
>  	if (ret) {
> -		drm_err(host, "failed to add DSI device %d\n", ret);
> +		dev_err(dev, "failed to add DSI device %d\n", ret);
>  		kfree(dsi);
>  		return ERR_PTR(ret);
>  	}

-- 
Jani Nikula, Intel Open Source Graphics Center
