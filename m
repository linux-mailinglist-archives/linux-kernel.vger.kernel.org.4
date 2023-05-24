Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3100B70FDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjEXScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEXScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D5E9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE926401F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 18:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C201CC433D2;
        Wed, 24 May 2023 18:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684953159;
        bh=uFZPCbHEYeXgYDFz65rOjbiqiUImhLgK0E8x5feuEKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZtd2LdKWfRDBnCoJ6EYhcuWNgS2um6RFiNnHZDt+LI5CbTSO17VhhXORgr9JSWT1
         U4P7ze0gPdi8MiocbUw33VXy2XGz/vQLJVRTKl4K8Sxx4mKutrUC6JTg9sei9he8Fg
         DPCJbijV91IjtC8C9iTSekbXH/dTD9tYFr6zAsBk=
Date:   Wed, 24 May 2023 19:32:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     nikhil.agarwal@amd.com, Nipun.Gupta@amd.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH v2] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Message-ID: <2023052401-overact-unbend-5a68@gregkh>
References: <20230524181613.5351-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524181613.5351-1-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:46:13PM +0530, Abhijit Gangurde wrote:
> MCDI_LOGGING is too generic considering other MCDI users
> SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
> CDX_MCDI_LOGGING makes it more domain specific.
> 
> Also, Move CONFIG_CDX_MCDI_LOGGING to header file
> and make logging variable as a configurable sysfs parameter.

No, sorry, that is not allowed.  Just use the normal dynamic debugging
in the kernel like everyone else uses.

Also you didn't document your new sysfs file, which would have not
allowed me to take this no matter what.

> 
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Changes v1->v2:
> - Moved CONFIG_CDX_MCDI_LOGGING flag to header file
> - Added sysfs entry to enable/disable mcdi logging
> 
>  drivers/cdx/controller/Kconfig          |  2 +-
>  drivers/cdx/controller/cdx_controller.c | 21 ++++++++++++
>  drivers/cdx/controller/mcdi.c           | 45 ++++++++++++-------------
>  drivers/cdx/controller/mcdi.h           |  8 +++--
>  4 files changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
> index c3e3b9ff8dfe..e7014e9819ea 100644
> --- a/drivers/cdx/controller/Kconfig
> +++ b/drivers/cdx/controller/Kconfig
> @@ -18,7 +18,7 @@ config CDX_CONTROLLER
>  
>  	  If unsure, say N.
>  
> -config MCDI_LOGGING
> +config CDX_MCDI_LOGGING
>  	bool "MCDI Logging for the CDX controller"
>  	depends on CDX_CONTROLLER
>  	help
> diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
> index dc52f95f8978..e5b1a2c01b87 100644
> --- a/drivers/cdx/controller/cdx_controller.c
> +++ b/drivers/cdx/controller/cdx_controller.c
> @@ -124,6 +124,23 @@ static struct cdx_ops cdx_ops = {
>  	.dev_configure	= cdx_configure_device,
>  };
>  
> +static ssize_t mcdi_logging_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	struct cdx_controller *cdx = dev_get_drvdata(dev);
> +	bool enable;
> +
> +	if (kstrtobool(buf, &enable) < 0)
> +		return -EINVAL;
> +
> +	if (cdx_enable_mcdi_logging(cdx->priv, enable))
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_WO(mcdi_logging);
> +
>  static int xlnx_cdx_probe(struct platform_device *pdev)
>  {
>  	struct cdx_controller *cdx;
> @@ -154,6 +171,9 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
>  	cdx->priv = cdx_mcdi;
>  	cdx->ops = &cdx_ops;
>  
> +	if (device_create_file(&pdev->dev, &dev_attr_mcdi_logging))
> +		dev_warn(&pdev->dev, "Failed to create sysfs file\n");

You just raced with userspace and lost.  Even if this feature was ok,
this is not how to create sysfs files, sorry.

greg k-h
