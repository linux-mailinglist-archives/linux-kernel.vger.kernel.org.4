Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA12622AFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKILyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKILyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:54:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E162CE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:54:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f5so46014230ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbjdwZrO7CchEGO52zV1EUktiYbcH8urhzFHSgEULX8=;
        b=icI6//b9KXQ9JyGkkWGolJBXMaLR5OOL0QzWOOUfc8Nv1c7/dHXb+Vp595R1bPKzRe
         WDpWoHdjrjlIpSO7FF0zBnHnEtFRTOyQuPJ6ygGucJNbQAWzriyHTLAqD5FRAHJ/04Ub
         a8FGSqIsvRGiC1/j+Qb3WSwi14RvbW73qGVSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbjdwZrO7CchEGO52zV1EUktiYbcH8urhzFHSgEULX8=;
        b=xsWRE4kSet675iOPSU8V5oHD90CeykUzs/QwsbcaGSjqAEZN07MC+uKSXibM9oE0Wn
         LQyNP2NeMMkqKrkAOoRdY2QC615mKCQfMbWMiqxWW4GNJSC7rQrZSyzU2vWk5HbKwwyw
         a8J/klCDxS/03nFGqDCPyJiPxQgkc+s9ZooYdPXpHmQe2ux8hihmJmpQQd+6EHueJQT3
         4GbH10XFkkFNaHkTFZWKXTRPqmABz9Xve8ANeRP+FkYppZnaEHiPeXgbZ1rgsLUEdsrU
         led16a8SupX3nUdGgPqYiPh1EHQZF6CtSK0csOJPcnoCdxTaGlhTo5F7xrgabPorqWgr
         1PaA==
X-Gm-Message-State: ACrzQf1Olfuzn/rmt13TVqBdJCWAQuhUS4nZqSjAbftwHyDOndaUC9Lg
        t0yoWanVhP5tAy+9pixDCVUSUg==
X-Google-Smtp-Source: AMsMyM7tJboAJn8/zR1Qol4Ci1YxaGiHmLXPdkvLdXrkiCVD2g8z27QU1BOeWL9thcN1Q2vhSiMnWw==
X-Received: by 2002:a17:907:7da9:b0:7ad:f381:b9f7 with SMTP id oz41-20020a1709077da900b007adf381b9f7mr40990549ejc.729.1667994873103;
        Wed, 09 Nov 2022 03:54:33 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0073dc5bb7c32sm5864101eja.64.2022.11.09.03.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:54:32 -0800 (PST)
Date:   Wed, 9 Nov 2022 12:54:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Won Chung <wonchung@google.com>
Cc:     bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/sysfs: Link DRM connectors to corresponding
 Type-C connectors
Message-ID: <Y2uU9YUZYqbL4uB7@phenom.ffwll.local>
Mail-Followup-To: Won Chung <wonchung@google.com>, bleung@google.com,
        pmalani@chromium.org, heikki.krogerus@linux.intel.com,
        imre.deak@intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221108185004.2263578-1-wonchung@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108185004.2263578-1-wonchung@google.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 06:50:04PM +0000, Won Chung wrote:
> Create a symlink pointing to USB Type-C connector for DRM connectors
> when they are created. The link will be created only if the firmware is
> able to describe the connection beween the two connectors.
> 
> Currently, even if a display uses a USB Type-C port, there is no way for
> the userspace to find which port is used for which display. With the
> symlink, display information would be accessible from Type-C connectors
> and port information would be accessible from DRM connectors.
> Associating the two subsystems, userspace would have potential to expose
> and utilize more complex information, such as bandwidth used for a
> specific USB Type-C port.
> 
> Signed-off-by: Won Chung <wonchung@google.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
> Changes from v3:
> - Append to the commit message on why this patch is needed
> 
> Changes from v2:
> - Resend the patch to dri-devel list
> 
> Changes from v1:
> - Fix multiple lines to single line

We seem to be spinning wheels a bit here (or at least I'm missing a lot of
important information from this series alone) with already at v4 but the
fundamentals not answered:

- where's the usb side of this, and anything we need to do in drivers?
  This should all be one series, or if that's too big, then a link in the
  cover letter for where to find all the other pieces

- since I'm guessing this is for cros, will this also work on standard
  acpi x86 that are built for windows? arm with dt? Might be answered with
  the full picture

- you say this helps userspace, but how? Best way here is to just point at
  the userspace change set that makes use of this link, code explains
  concepts much more precisely than lots of words, and it's also easier to
  review for corner cases that might be missed. That link also needs to be
  in the commit message/cover letter somewhere, so people can find it.

In principle nothing against the idea, seems reasonable (but I'm also not
sure what exact problem it's solving) - but all the detail work to make
this work than an RFP to kick of some discussion is missing. And I think
it's not even enough to really kick off a discussion as-is since there's
really no user of this at all (in-kernel or userspace) linked.

Cheers, Daniel

> 
> 
>  drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 430e00b16eec..6a9904fa9186 100644
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
> @@ -95,6 +97,34 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
>  	return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
>  }
>  
> +static int typec_connector_bind(struct device *dev,
> +	struct device *typec_connector, void *data)
> +{
> +	int ret;
> +
> +	ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
> +	if (ret)
> +		return ret;
> +
> +	ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
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
> @@ -355,6 +385,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
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
> @@ -367,6 +404,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
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
> 2.37.3.998.g577e59143f-goog
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
