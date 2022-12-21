Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD80652EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiLUJyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiLUJyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:54:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8223EAB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671616214; x=1703152214;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IxPBcswAu/FPTNKbtGLPljIPJQ0RCng05/tC/MUeyF8=;
  b=FayjQ7jfHpFL4DzuBx5EyyoD4TJxCOwVQpIiRNATDs7lc7ck0AcyOL4v
   UXzhPNPZYy6hSZhd9KN1nJPejbGPKSWRHv1M/O1FijkHxsxD0ibn4DhlH
   SR7FLoSUtq8rFpJcVvyDbKrcU3qUUlCwps4ivmy8AAT6Joa7hU1AZCF70
   oEX7f3c/WgGG/eoMEuB84dWJEpCpmmrOZCuizeQDIegz7Igb0gu2UV09b
   eV/L8DV0TJRsBB6a7ARs8eD+A56l9U9CWpioLIs8MT0nPXLV1sDykYdyG
   0NhoDg4Q2Lfgjh8WW62DwcXyuFmgH4Lwx5UWFxvPY24z7TY3Xw/klhpfG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="406071306"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="406071306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 01:50:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="825584348"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="825584348"
Received: from jorgeblx-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.46.119])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 01:49:59 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Siddh Raman Pant <code@siddh.me>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 01/10] drm: Remove usage of deprecated DRM_INFO
In-Reply-To: <da27fd5d4725a8becd426c01ba5652a44cf62ce5.1671566741.git.code@siddh.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1671566741.git.code@siddh.me>
 <da27fd5d4725a8becd426c01ba5652a44cf62ce5.1671566741.git.code@siddh.me>
Date:   Wed, 21 Dec 2022 11:49:57 +0200
Message-ID: <87a63h2iii.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2022, Siddh Raman Pant <code@siddh.me> wrote:
> drm_print.h says DRM_INFO is deprecated.
> Thus, use newer printing macros drm_info() and pr_info().

I think it's a bit odd some of the conversion is to pr_*() and some to
drm_*(NULL, ...) depending on the logging level etc.

Notably the pr_*() debugs will lack the [drm] part as well as the
function name, which makes some of the logging harder to map to what's
going on.

Maybe all of them should use the drm_*() calls, with better handling of
NULL drm device.

BR,
Jani.






>
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 2 +-
>  drivers/gpu/drm/drm_connector.c      | 7 ++++---
>  drivers/gpu/drm/drm_drv.c            | 2 +-
>  drivers/gpu/drm/drm_pci.c            | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
> index d553e793e673..2b76d4828c5f 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -335,7 +335,7 @@ static bool drm_client_target_cloned(struct drm_device *dev,
>  		DRM_DEBUG_KMS("can clone using 1024x768\n");
>  		return true;
>  	}
> -	DRM_INFO("kms: can't enable cloning when we probably wanted to.\n");
> +	drm_info(dev, "kms: can't enable cloning when we probably wanted to.\n");
>  	return false;
>  }
>  
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 547356e00341..34c26b2a974e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -165,13 +165,14 @@ static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
>  		return;
>  
>  	if (mode->force) {
> -		DRM_INFO("forcing %s connector %s\n", connector->name,
> -			 drm_get_connector_force_name(mode->force));
> +		drm_info(connector->dev, "forcing %s connector %s\n",
> +			 connector->name, drm_get_connector_force_name(mode->force));
>  		connector->force = mode->force;
>  	}
>  
>  	if (mode->panel_orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN) {
> -		DRM_INFO("cmdline forces connector %s panel_orientation to %d\n",
> +		drm_info(connector->dev,
> +			 "cmdline forces connector %s panel_orientation to %d\n",
>  			 connector->name, mode->panel_orientation);
>  		drm_connector_set_panel_orientation(connector,
>  						    mode->panel_orientation);
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 73b845a75d52..bc98e4bcf2c1 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -938,7 +938,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
>  	if (drm_core_check_feature(dev, DRIVER_MODESET))
>  		drm_modeset_register_all(dev);
>  
> -	DRM_INFO("Initialized %s %d.%d.%d %s for %s on minor %d\n",
> +	drm_info(dev, "Initialized %s %d.%d.%d %s for %s on minor %d\n",
>  		 driver->name, driver->major, driver->minor,
>  		 driver->patchlevel, driver->date,
>  		 dev->dev ? dev_name(dev->dev) : "virtual device",
> diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
> index 39d35fc3a43b..18cf7fa23698 100644
> --- a/drivers/gpu/drm/drm_pci.c
> +++ b/drivers/gpu/drm/drm_pci.c
> @@ -262,7 +262,7 @@ void drm_legacy_pci_exit(const struct drm_driver *driver,
>  		}
>  		mutex_unlock(&legacy_dev_list_lock);
>  	}
> -	DRM_INFO("Module unloaded\n");
> +	pr_info("Module unloaded\n");
>  }
>  EXPORT_SYMBOL(drm_legacy_pci_exit);

-- 
Jani Nikula, Intel Open Source Graphics Center
