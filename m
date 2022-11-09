Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90933622EDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiKIPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiKIPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:16:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517581CB24
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:16:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3766C1FB;
        Wed,  9 Nov 2022 07:17:00 -0800 (PST)
Received: from [10.57.1.94] (unknown [10.57.1.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8903F73D;
        Wed,  9 Nov 2022 07:16:51 -0800 (PST)
Message-ID: <b89d6578-6ca5-ae16-9016-4727eb2501fb@arm.com>
Date:   Wed, 9 Nov 2022 15:16:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 16/26] drm: panfrost: Remove #ifdef guards for PM related
 functions
Content-Language: en-GB
To:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175256.360839-1-paul@crapouillou.net>
 <20221107175256.360839-6-paul@crapouillou.net>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20221107175256.360839-6-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 17:52, Paul Cercueil wrote:
> Use the EXPORT_GPL_RUNTIME_DEV_PM_OPS() and pm_ptr() macros to handle
> the PM callbacks.
> 
> These macros allow the PM functions to be automatically dropped by the
> compiler when CONFIG_PM is disabled, without having to use #ifdef
> guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_device.c | 10 ++++++----
>  drivers/gpu/drm/panfrost/panfrost_device.h |  4 ++--
>  drivers/gpu/drm/panfrost/panfrost_drv.c    |  7 +------
>  3 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> index ee612303f076..fa1a086a862b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -6,6 +6,7 @@
>  #include <linux/reset.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "panfrost_device.h"
> @@ -400,8 +401,7 @@ void panfrost_device_reset(struct panfrost_device *pfdev)
>  	panfrost_job_enable_interrupts(pfdev);
>  }
>  
> -#ifdef CONFIG_PM
> -int panfrost_device_resume(struct device *dev)
> +static int panfrost_device_resume(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>  
> @@ -411,7 +411,7 @@ int panfrost_device_resume(struct device *dev)
>  	return 0;
>  }
>  
> -int panfrost_device_suspend(struct device *dev)
> +static int panfrost_device_suspend(struct device *dev)
>  {
>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>  
> @@ -423,4 +423,6 @@ int panfrost_device_suspend(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
> +
> +EXPORT_GPL_RUNTIME_DEV_PM_OPS(panfrost_pm_ops, panfrost_device_suspend,
> +			      panfrost_device_resume, NULL);
> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
> index 8b25278f34c8..d9ba68cffb77 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/io-pgtable.h>
> +#include <linux/pm.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
>  #include <drm/drm_device.h>
> @@ -172,8 +173,7 @@ int panfrost_device_init(struct panfrost_device *pfdev);
>  void panfrost_device_fini(struct panfrost_device *pfdev);
>  void panfrost_device_reset(struct panfrost_device *pfdev);
>  
> -int panfrost_device_resume(struct device *dev);
> -int panfrost_device_suspend(struct device *dev);
> +extern const struct dev_pm_ops panfrost_pm_ops;
>  
>  enum drm_panfrost_exception_type {
>  	DRM_PANFROST_EXCEPTION_OK = 0x00,
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 2fa5afe21288..fa619fe72086 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -676,17 +676,12 @@ static const struct of_device_id dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
>  
> -static const struct dev_pm_ops panfrost_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(panfrost_device_suspend, panfrost_device_resume, NULL)
> -};
> -
>  static struct platform_driver panfrost_driver = {
>  	.probe		= panfrost_probe,
>  	.remove		= panfrost_remove,
>  	.driver		= {
>  		.name	= "panfrost",
> -		.pm	= &panfrost_pm_ops,
> +		.pm	= pm_ptr(&panfrost_pm_ops),
>  		.of_match_table = dt_match,
>  	},
>  };

