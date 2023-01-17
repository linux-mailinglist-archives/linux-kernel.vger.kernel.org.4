Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E20066E01C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjAQOOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjAQONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:13:52 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC53C283;
        Tue, 17 Jan 2023 06:13:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8209CE138F;
        Tue, 17 Jan 2023 14:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3588CC433D2;
        Tue, 17 Jan 2023 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673964826;
        bh=TTb+U39DOEPUNiFoQ51VYS+Rqn01nJ+QZ8Oueob40pg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FSS8VriTbR1vFjSiNknrFJBE7PHGgaZXZkmTUHhj4gYuh31R9lUaibQXxe16jAnaA
         Cy9CbveSrFYbLRl/64Ss/FS9CpI7DeKz/cazTku2reZczH7Id1+pU3Lm8u3pJmjP9A
         Hhbr6pfTtGf9pfRUeJvZqrOL7tD85Fo6YVXueKPs=
Date:   Tue, 17 Jan 2023 15:13:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH 07/19] bus/cdx: add device attributes
Message-ID: <Y8atGJV6yY4mXD+W@kroah.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-8-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134139.1298-8-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:11:39PM +0530, Nipun Gupta wrote:
> Create sysfs entry for CDX devices.
> 
> Sysfs entries provided in each of the CDX device detected by
> the CDX controller
>  - vendor id
>  - device id
>  - remove
>  - reset of the device.
>  - driver override
> 
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx     |  34 +++++
>  drivers/bus/cdx/cdx.c                       | 144 ++++++++++++++++++++
>  drivers/bus/cdx/controller/cdx_controller.c |  19 +++
>  drivers/bus/cdx/controller/mcdi_functions.c |  14 ++
>  drivers/bus/cdx/controller/mcdi_functions.h |  11 ++
>  include/linux/cdx/cdx_bus.h                 |  23 ++++
>  6 files changed, 245 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 8c2425fdb6d9..1e0fdce18cde 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -10,3 +10,37 @@ Description:
>                  For example::
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
> +
> +What:		/sys/bus/cdx/devices/.../vendor
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Vendor ID for this CDX device

What format is this in?  How big is it?  Examples?

> +
> +What:		/sys/bus/cdx/devices/.../device
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Device ID for this CDX device

Same here, be specific.

> +
> +What:		/sys/bus/cdx/devices/.../reset
> +Date:		January 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing a non-zero value to this file would reset the
> +		CDX device
> +
> +                For example::
> +
> +		  # echo 1 > /sys/bus/cdx/.../reset

Will that remove the device from the driver too?

Again, more documentation please.

> +
> +What:		/sys/bus/cdx/devices/.../remove
> +Date:		January 2023
> +Contact:	tarak.reddy@amd.com
> +Description:
> +		Writing a non-zero value to this file would remove the
> +		corrosponding device from the CDX bus
> +
> +		For example::
> +
> +		# echo 1 > /sys/bus/cdx/devices/.../remove

Why would you want to remove a device from the bus like this?

> diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
> index 2737470f08d3..1372d8dcaa4c 100644
> --- a/drivers/bus/cdx/cdx.c
> +++ b/drivers/bus/cdx/cdx.c
> @@ -72,6 +72,38 @@ static DECLARE_BITMAP(cdx_controller_id_map, MAX_CDX_CONTROLLERS);
>  /* List of CDX controllers registered with the CDX bus */
>  static LIST_HEAD(cdx_controllers);
>  
> +/**
> + * reset_cdx_device - Reset a CDX device
> + * @dev: CDX device
> + * @data: This is always passed as NULL, and is not used in this API,
> + *	  but is required here as the bus_for_each_dev() API expects
> + *	  the passed function (reset_cdx_device) to have this
> + *	  as an argument.
> + *
> + * @return: -errno on failure, 0 on success.

I recommend this function actually be the one without the data pointer,
that way you don't get confused here.

> + */
> +static int reset_cdx_device(struct device *dev, void *data)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	int ret;
> +
> +	dev_config.type = CDX_DEV_RESET_CONF;
> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +				      cdx_dev->dev_num, &dev_config);
> +	if (ret)
> +		dev_err(dev, "cdx device reset failed\n");
> +
> +	return ret;
> +}
> +
> +int cdx_dev_reset(struct device *dev)
> +{
> +	return reset_cdx_device(dev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(cdx_dev_reset);

Remove the indirection as mentioned above please.

Otherwise, very minor comments, nice work.

greg k-h
