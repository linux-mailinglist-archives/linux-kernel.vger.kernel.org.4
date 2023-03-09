Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12736B24E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjCINEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCINDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:03:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB75271;
        Thu,  9 Mar 2023 05:03:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4393FB81EEC;
        Thu,  9 Mar 2023 13:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5955BC433A0;
        Thu,  9 Mar 2023 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678367030;
        bh=pfxyJnjs85wO4NiuLfzFahcSc3GBBsYbvAMDyV/j3MI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jp5/lON5INxPj9KQC1QuWjvJOrkwrLaXJyy2IHBV6IyLSfI8tkfEBVwmCjIVEoHhG
         1CfoKcQcp7zVvZ69soWX23hT1HoVvt74xknYTJmx4heuRbdI0rycK63uWF7xTdw0ik
         ajrlIWg4dd2HcOupAMx4T7N8J4CPGks5eBfIkPQo=
Date:   Thu, 9 Mar 2023 14:03:48 +0100
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
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, okaya@kernel.org,
        harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, pieter.jansen-van-vuuren@amd.com,
        pablo.cascon@amd.com, git@amd.com
Subject: Re: [PATCH v9 7/7] cdx: add device attributes
Message-ID: <ZAnZNEgA/6pXhj7g@kroah.com>
References: <20230307131917.30605-1-nipun.gupta@amd.com>
 <20230307131917.30605-8-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307131917.30605-8-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 06:49:17PM +0530, Nipun Gupta wrote:
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
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx |  44 +++++++
>  drivers/cdx/cdx.c                       | 145 ++++++++++++++++++++++++
>  drivers/cdx/controller/cdx_controller.c |  19 ++++
>  drivers/cdx/controller/mcdi_functions.c |  14 +++
>  drivers/cdx/controller/mcdi_functions.h |  11 ++
>  include/linux/cdx/cdx_bus.h             |  27 +++++
>  6 files changed, 260 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 063d1a0dd866..c553ce3a449a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -10,3 +10,47 @@ Description:
>  		For example::
>  
>  		  # echo 1 > /sys/bus/cdx/rescan
> +
> +What:		/sys/bus/cdx/devices/.../vendor
> +Date:		March 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Vendor ID for this CDX device. Vendor ID is 16 bit
> +		identifier which is specific to the device manufacturer.
> +		Combination of Vendor ID and Device ID identifies a device.
> +
> +What:		/sys/bus/cdx/devices/.../device
> +Date:		March 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Device ID for this CDX device. Device ID is a 16 bit
> +		identifier to identify a device type within the range
> +		of a device manufacturer.
> +		Combination of Vendor ID and Device ID identifies a device.

Are these printed out in hex, decimal, octal, binary, something else?
Please be specific.

> +
> +What:		/sys/bus/cdx/devices/.../reset
> +Date:		March 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		Writing a non-zero value to this file resets the CDX device.
> +		On resetting the device, the corresponding driver is notified
> +		twice, once before the device is being reset, and again after
> +		the reset has been complete.
> +
> +		For example::
> +
> +		  # echo 1 > /sys/bus/cdx/.../reset

Don't do "non-zero", make this explicit.  This implies I can do "echo X"
and it will work, do you want that?

> +
> +What:		/sys/bus/cdx/devices/.../remove
> +Date:		March 2023
> +Contact:	tarak.reddy@amd.com
> +Description:
> +		Writing a non-zero value to this file removes the corresponding
> +		device from the CDX bus. If the device is to be reconfigured
> +		reconfigured in the Hardware, the device can be removed, so
> +		that the device driver does not access the device while it is
> +		being reconfigured.
> +
> +		For example::
> +
> +		  # echo 1 > /sys/bus/cdx/devices/.../remove

Again, not non-zero.

Please use the built-in sysfs function to handle yes/no values being
written to sysfs files for this and only accept the "yes" value.

> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index c981232486dd..0c4f300373e5 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -71,6 +71,39 @@
>  /* CDX controllers registered with the CDX bus */
>  static DEFINE_XARRAY_ALLOC(cdx_controllers);
>  
> +/**
> + * cdx_dev_reset - Reset a CDX device
> + * @dev: CDX device
> + *
> + * Return: -errno on failure, 0 on success.
> + */
> +int cdx_dev_reset(struct device *dev)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	struct cdx_controller *cdx = cdx_dev->cdx;
> +	struct cdx_device_config dev_config;
> +	struct cdx_driver *cdx_drv;
> +	int ret;
> +
> +	cdx_drv = to_cdx_driver(dev->driver);
> +	/* Notify driver that device is being reset */
> +	if (cdx_drv && cdx_drv->reset_prepare)
> +		cdx_drv->reset_prepare(cdx_dev);
> +
> +	dev_config.type = CDX_DEV_RESET_CONF;
> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num,
> +				      cdx_dev->dev_num, &dev_config);

You configure something off of the stack?  Is that wise, it contains
loads of invalid stack-provided data, how does this work at all?

> +	if (ret)
> +		dev_err(dev, "cdx device reset failed\n");
> +
> +	/* Notify driver that device reset is complete */
> +	if (cdx_drv && cdx_drv->reset_done)
> +		cdx_drv->reset_done(cdx_dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cdx_dev_reset);
> +
>  /**
>   * cdx_unregister_device - Unregister a CDX device
>   * @dev: CDX device
> @@ -237,6 +270,117 @@ static int cdx_dma_configure(struct device *dev)
>  	return 0;
>  }
>  
> +/* show configuration fields */
> +#define cdx_config_attr(field, format_string)	\
> +static ssize_t	\
> +field##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
> +{	\
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);	\
> +	return sysfs_emit(buf, format_string, cdx_dev->field);	\
> +}	\
> +static DEVICE_ATTR_RO(field)
> +
> +cdx_config_attr(vendor, "0x%04x\n");
> +cdx_config_attr(device, "0x%04x\n");
> +
> +static ssize_t remove_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	unsigned long val = 0;

Why initialize this?

> +
> +	if (kstrtoul(buf, 0, &val) < 0)
> +		return -EINVAL;

As mentioned above, just use kstrtobool() instead, don't mess around
with unsigned longs, that's not needed at all.

> +static ssize_t driver_override_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +	const char *old = cdx_dev->driver_override;
> +	char *driver_override;
> +	char *cp;
> +
> +	if (WARN_ON(dev->bus != &cdx_bus_type))
> +		return -EINVAL;
> +
> +	if (count >= (PAGE_SIZE - 1))

And how can that happen?

And why does the page size matter?

> +		return -EINVAL;
> +
> +	driver_override = kstrndup(buf, count, GFP_KERNEL);
> +	if (!driver_override)
> +		return -ENOMEM;
> +
> +	cp = strchr(driver_override, '\n');
> +	if (cp)
> +		*cp = '\0';
> +
> +	if (strlen(driver_override)) {
> +		cdx_dev->driver_override = driver_override;
> +	} else {
> +		kfree(driver_override);
> +		cdx_dev->driver_override = NULL;
> +	}
> +
> +	kfree(old);
> +
> +	return count;
> +}
> +
> +static int cdx_configure_device(struct cdx_controller *cdx,
> +				u8 bus_num, u8 dev_num,
> +				struct cdx_device_config *dev_config)
> +{
> +	int ret = 0;
> +
> +	switch (dev_config->type) {
> +	case CDX_DEV_RESET_CONF:
> +		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
> +		break;
> +	default:
> +		dev_err(cdx->dev, "Invalid device configuration flag\n");
> +		ret = -EINVAL;

Can userspace cause this to happen?  If so, please do not allow it to
spam the kernel log.

If not, who will see this error?

> +	}
> +
> +	return ret;
> +}
> +
>  static int cdx_scan_devices(struct cdx_controller *cdx)
>  {
>  	struct cdx_mcdi *cdx_mcdi = cdx->priv;
> @@ -104,6 +122,7 @@ static int cdx_scan_devices(struct cdx_controller *cdx)
>  
>  static struct cdx_ops cdx_ops = {
>  	.scan		= cdx_scan_devices,
> +	.dev_configure	= cdx_configure_device,
>  };
>  
>  static int xlnx_cdx_probe(struct platform_device *pdev)
> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
> index 012b52881dd5..0158f26533dd 100644
> --- a/drivers/cdx/controller/mcdi_functions.c
> +++ b/drivers/cdx/controller/mcdi_functions.c
> @@ -123,3 +123,17 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>  
>  	return 0;
>  }
> +
> +int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
> +{
> +	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
> +	int ret;
> +
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_BUS, bus_num);
> +	MCDI_SET_DWORD(inbuf, CDX_DEVICE_RESET_IN_DEVICE, dev_num);
> +
> +	ret = cdx_mcdi_rpc(cdx, MC_CMD_CDX_DEVICE_RESET, inbuf, sizeof(inbuf),
> +			   NULL, 0, NULL);
> +
> +	return ret;
> +}
> diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
> index 6bf5a4a0778f..7440ace5539a 100644
> --- a/drivers/cdx/controller/mcdi_functions.h
> +++ b/drivers/cdx/controller/mcdi_functions.h
> @@ -47,4 +47,15 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>  			    u8 bus_num, u8 dev_num,
>  			    struct cdx_dev_params *dev_params);
>  
> +/**
> + * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
> + * @cdx: pointer to MCDI interface.
> + * @bus_num: Bus number.
> + * @dev_num: Device number.
> + *
> + * Return: 0 on success, <0 on failure
> + */
> +int cdx_mcdi_reset_device(struct cdx_mcdi *cdx,
> +			  u8 bus_num, u8 dev_num);
> +
>  #endif /* CDX_MCDI_FUNCTIONS_H */
> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index d134e0104724..35ef41d8a61a 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -21,8 +21,20 @@
>  /* Forward declaration for CDX controller */
>  struct cdx_controller;
>  
> +enum {
> +	CDX_DEV_RESET_CONF,
> +};
> +
> +struct cdx_device_config {
> +	u8 type;
> +};
> +
>  typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
>  
> +typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
> +				    u8 bus_num, u8 dev_num,
> +				    struct cdx_device_config *dev_config);
> +
>  /**
>   * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
>   *                              override_only flags.
> @@ -39,9 +51,12 @@ typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
>  /**
>   * struct cdx_ops - Callbacks supported by CDX controller.
>   * @scan: scan the devices on the controller
> + * @dev_configure: configuration like reset, master_enable,
> + *		   msi_config etc for a CDX device
>   */
>  struct cdx_ops {
>  	cdx_scan_cb scan;
> +	cdx_dev_configure_cb dev_configure;
>  };
>  
>  /**
> @@ -101,6 +116,8 @@ struct cdx_device {
>   * @probe: Function called when a device is added
>   * @remove: Function called when a device is removed
>   * @shutdown: Function called at shutdown time to quiesce the device
> + * @reset_prepare: Function called before is reset to notify driver
> + * @reset_done: Function called after reset is complete to notify driver
>   * @driver_managed_dma: Device driver doesn't use kernel DMA API for DMA.
>   *		For most device drivers, no need to care about this flag
>   *		as long as all DMAs are handled through the kernel DMA API.
> @@ -115,6 +132,8 @@ struct cdx_driver {
>  	int (*probe)(struct cdx_device *dev);
>  	int (*remove)(struct cdx_device *dev);
>  	void (*shutdown)(struct cdx_device *dev);
> +	void (*reset_prepare)(struct cdx_device *dev);

This can never fail?  Why not?

thanks,

greg k-h
