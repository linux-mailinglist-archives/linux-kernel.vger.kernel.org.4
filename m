Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACC5E60AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIVLPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiIVLOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:14:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28D8DE0D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663845266; x=1695381266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i5JTykQjkQrnv8/srjhrjiQdqD23bv6meNMcD41b40Y=;
  b=JXmlWq7iEiddEWAV6bLmuZAeQQ1FatDtXALu6AawT6SpnepjRVBkc+sP
   pc1eW44Z/LdNUnNRrcHh+pWjEqhnSP2lupeRsDgdGB8nxBJt4KN2wYgci
   SQQQ5lFy1TsATbCtRO5e7DzcXKvZIvJbt7gG+ytVnHvxO0Ga1mirOqQcR
   fEnDfwnMkyPCF5EcE6T+vMH65QS0LNmGFNHPiLq/H6OQ/v3z/TscEBMaY
   +hd0r1CB906kYQXjL+F8luf5+6UixBzo/KOx9n2VnuWYUoImlG/plL/Yi
   7y7dkgLByOJN7MhO7e4RtPRtgte9nf7aosvEaO7OJyiDOf2C7AwjijVkU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="301677556"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="301677556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 04:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762144417"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 22 Sep 2022 04:14:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 22 Sep 2022 14:14:15 +0300
Date:   Thu, 22 Sep 2022 14:14:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Won Chung <wonchung@google.com>
Cc:     bleung@google.com, pmalani@chromium.org, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sysfs: Link DRM connectors to corresponding Type-C
 connectors
Message-ID: <YyxDh1CZ+oHJqND4@kuha.fi.intel.com>
References: <20220921182637.4056670-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921182637.4056670-1-wonchung@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

On Wed, Sep 21, 2022 at 06:26:37PM +0000, Won Chung wrote:
> Create a symlink pointing to USB Type-C connector for DRM connectors
> when they are created. The link will be created only if the firmware is
> able to describe the connection beween the two connectors.
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
>  drivers/gpu/drm/drm_sysfs.c | 42 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..8270b02e6783 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -11,12 +11,14 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/component.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  #include <linux/i2c.h>
>  #include <linux/kdev_t.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  
>  #include <drm/drm_connector.h>
> @@ -95,6 +97,36 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
>  	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
>  }
>  
> +static int typec_connector_bind(struct device *dev,
> +	struct device *typec_connector, void *data)
> +{
> +	int ret;
> +
> +	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj,
> +		"typec_connector");

One line is enough.

> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj,
> +		"drm_connector");

Ditto.

> +	if (ret)
> +		sysfs_remove_link(&dev->kobj, "typec_connector");
> +
> +	return ret;
> +}
> +
> +static void typec_connector_unbind(struct device *dev,
> +	struct device *typec_connector, void *data)
> +{
> +	sysfs_remove_link(&typec_connector->kobj, "drm_connector");
> +	sysfs_remove_link(&dev->kobj, "typec_connector");
> +}
> +
> +static const struct component_ops typec_connector_ops = {
> +	.bind = typec_connector_bind,
> +	.unbind = typec_connector_unbind,
> +};
> +
>  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>  
>  /**
> @@ -355,6 +387,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
>  	if (connector->ddc)
>  		return sysfs_create_link(&connector->kdev->kobj,
>  				 &connector->ddc->dev.kobj, "ddc");
> +
> +	if (dev_fwnode(kdev)) {
> +		r = component_add(kdev, &typec_connector_ops);
> +		if (r)
> +			drm_err(dev, "failed to add component\n");
> +	}
> +
>  	return 0;
>  
>  err_free:
> @@ -367,6 +406,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
>  	if (!connector->kdev)
>  		return;
>  
> +	if (dev_fwnode(connector->kdev))
> +		component_del(connector->kdev, &typec_connector_ops);
> +
>  	if (connector->ddc)
>  		sysfs_remove_link(&connector->kdev->kobj, "ddc");
>  
> -- 
> 2.37.2.789.g6183377224-goog

-- 
heikki
