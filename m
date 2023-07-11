Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0474F0FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjGKOCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjGKOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B4BC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:02:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689F161426
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78621C433C7;
        Tue, 11 Jul 2023 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689084148;
        bh=J0mnrRSkQMQUWh5hTNL2UkXUNT9zUxoDqxir9bgX870=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lF+xvxUOw2RImmvmN2c/rrz8RFcmSHMUrtawXTgX/xCmNHvBbWGQ/6UFbRT7z0rhe
         Y1nsafB3QqswYSvP5Cj5787UaKcnFumnFkb7pQnMRC3jnfOaWMwh9nZZIVfPZgyLgQ
         Z3VXLrG4ky3oyNfdOyjw7TTVOMX66B7QCLzRwHMM=
Date:   Tue, 11 Jul 2023 16:02:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org, Nipun.Gupta@amd.com,
        nikhil.agarwal@amd.com, puneet.gupta@amd.com, git@amd.com,
        michal.simek@amd.com,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Subject: Re: [PATCH 4/4] cdx: add sysfs for subsystem, class and revision
Message-ID: <2023071144-reason-defraud-b8b5@gregkh>
References: <20230711121027.936487-1-abhijit.gangurde@amd.com>
 <20230711121027.936487-5-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711121027.936487-5-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:40:27PM +0530, Abhijit Gangurde wrote:
> RPU provides subsystem_vendor, subsystem_device, class and revision
> info of the device.

What is "RPU"?

> Use the Subsystem vendor id, device id and class
> to match the cdx device. Subsystem vendor and device combination
> can be used to identify the card. This identification would be useful
> for cdx device driver for card specific operations.

Why aren't you binding devices to drivers based on this like all other
bus types do?

> 
> Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cdx | 45 +++++++++++++++++++++++++
>  drivers/cdx/cdx.c                       | 29 +++++++++++++++-
>  drivers/cdx/cdx.h                       |  8 +++++
>  drivers/cdx/controller/mcdi_functions.c |  7 ++++
>  include/linux/cdx/cdx_bus.h             | 27 +++++++++++++--
>  include/linux/mod_devicetable.h         | 10 ++++++
>  scripts/mod/devicetable-offsets.c       |  4 +++
>  scripts/mod/file2alias.c                |  8 +++++
>  8 files changed, 135 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cdx b/Documentation/ABI/testing/sysfs-bus-cdx
> index 6ca47b6442ce..da6459ac8fb2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cdx
> +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> @@ -50,6 +50,36 @@ Description:
>  		of a device manufacturer.
>  		Combination of Vendor ID and Device ID identifies a device.
>  
> +What:		/sys/bus/cdx/devices/.../subsystem_vendor
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		Subsystem Vendor ID for this CDX device, in hexadecimal.
> +		Subsystem Vendor ID is 16 bit identifier specific to the
> +		card manufacturer.
> +
> +What:		/sys/bus/cdx/devices/.../subsystem_device
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		Subsystem Device ID for this CDX device, in hexadecimal
> +		Subsystem Device ID is 16 bit identifier specific to the
> +		card manufacturer.
> +
> +What:		/sys/bus/cdx/devices/.../class
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		This file contains the class of the CDX device, in hexadecimal.
> +		Class is 24 bit identifier specifies the functionality of the device.
> +
> +What:		/sys/bus/cdx/devices/.../revision
> +Date:		July 2023
> +Contact:	puneet.gupta@amd.com
> +Description:
> +		This file contains the revision field of the CDX device, in hexadecimal.
> +		Revision is 8 bit revision identifier of the device.
> +
>  What:		/sys/bus/cdx/devices/.../reset
>  Date:		March 2023
>  Contact:	nipun.gupta@amd.com
> @@ -91,3 +121,18 @@ Contact:	puneet.gupta@amd.com
>  Description:
>  		The resource binary file contains the content of the memory
>  		regions. These files can be m'maped from userspace.
> +
> +What:		/sys/bus/cdx/devices/.../modalias
> +Date:		July 2023
> +Contact:	nipun.gupta@amd.com
> +Description:
> +		This attribute indicates the CDX ID of the device.
> +		That is in the format:
> +		cdx:vXXXXdXXXXsvXXXXsdXXXXcXXXXXX,
> +		where:
> +
> +		    - vXXXX contains the vendor ID;
> +		    - dXXXX contains the device ID;
> +		    - svXXXX contains the subsystem vendor ID;
> +		    - sdXXXX contains the subsystem device ID;
> +		    - cXXXXXX contains the device class.
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 9d568df8e566..e9055baf14bb 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -162,7 +162,10 @@ cdx_match_one_device(const struct cdx_device_id *id,
>  {
>  	/* Use vendor ID and device ID for matching */
>  	if ((id->vendor == CDX_ANY_ID || id->vendor == dev->vendor) &&
> -	    (id->device == CDX_ANY_ID || id->device == dev->device))
> +	    (id->device == CDX_ANY_ID || id->device == dev->device) &&
> +	    (id->subvendor == CDX_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
> +	    (id->subdevice == CDX_ANY_ID || id->subdevice == dev->subsystem_device) &&
> +	    !((id->class ^ dev->class) & id->class_mask))
>  		return id;
>  	return NULL;
>  }
> @@ -308,6 +311,10 @@ static DEVICE_ATTR_RO(field)
>  
>  cdx_config_attr(vendor, "0x%04x\n");
>  cdx_config_attr(device, "0x%04x\n");
> +cdx_config_attr(subsystem_vendor, "0x%04x\n");
> +cdx_config_attr(subsystem_device, "0x%04x\n");
> +cdx_config_attr(revision, "0x%02x\n");
> +cdx_config_attr(class, "0x%06x\n");
>  
>  static ssize_t remove_store(struct device *dev,
>  			    struct device_attribute *attr,
> @@ -353,6 +360,17 @@ static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(reset);
>  
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
> +
> +	return sprintf(buf, "cdx:v%04Xd%04Xsv%04Xsd%04Xc%06X\n", cdx_dev->vendor,
> +			cdx_dev->device, cdx_dev->subsystem_vendor, cdx_dev->subsystem_device,
> +			cdx_dev->class);
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
>  static ssize_t driver_override_store(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t count)
> @@ -403,6 +421,11 @@ static struct attribute *cdx_dev_attrs[] = {
>  	&dev_attr_reset.attr,
>  	&dev_attr_vendor.attr,
>  	&dev_attr_device.attr,
> +	&dev_attr_subsystem_vendor.attr,
> +	&dev_attr_subsystem_device.attr,
> +	&dev_attr_class.attr,
> +	&dev_attr_revision.attr,
> +	&dev_attr_modalias.attr,
>  	&dev_attr_driver_override.attr,
>  	&dev_attr_resource.attr,
>  	NULL,
> @@ -652,6 +675,10 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>  	cdx_dev->req_id = dev_params->req_id;
>  	cdx_dev->vendor = dev_params->vendor;
>  	cdx_dev->device = dev_params->device;
> +	cdx_dev->subsystem_vendor = dev_params->subsys_vendor;
> +	cdx_dev->subsystem_device = dev_params->subsys_device;
> +	cdx_dev->class = dev_params->class;
> +	cdx_dev->revision = dev_params->revision;
>  	cdx_dev->bus_num = dev_params->bus_num;
>  	cdx_dev->dev_num = dev_params->dev_num;
>  	cdx_dev->cdx = dev_params->cdx;
> diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
> index c436ac7ac86f..d17b5a501e8d 100644
> --- a/drivers/cdx/cdx.h
> +++ b/drivers/cdx/cdx.h
> @@ -16,21 +16,29 @@
>   * @parent: Associated CDX controller
>   * @vendor: Vendor ID for CDX device
>   * @device: Device ID for CDX device
> + * @subsys_vendor: Sub vendor ID for CDX device
> + * @subsys_device: Sub device ID for CDX device
>   * @bus_num: Bus number for this CDX device
>   * @dev_num: Device number for this device
>   * @res: array of MMIO region entries
>   * @res_count: number of valid MMIO regions
>   * @req_id: Requestor ID associated with CDX device
> + * @class: Class of the CDX Device
> + * @revision: Revision of the CDX device
>   */
>  struct cdx_dev_params {
>  	struct cdx_controller *cdx;
>  	u16 vendor;
>  	u16 device;
> +	u16 subsys_vendor;
> +	u16 subsys_device;
>  	u8 bus_num;
>  	u8 dev_num;
>  	struct resource res[MAX_CDX_DEV_RESOURCES];
>  	u8 res_count;
>  	u32 req_id;
> +	u32 class;
> +	u8 revision;
>  };
>  
>  /**
> diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
> index 400fdc771104..a227922a03ca 100644
> --- a/drivers/cdx/controller/mcdi_functions.c
> +++ b/drivers/cdx/controller/mcdi_functions.c
> @@ -120,6 +120,13 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
>  
>  	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
>  	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
> +	dev_params->subsys_vendor = MCDI_WORD(outbuf,
> +					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_VENDOR_ID);
> +	dev_params->subsys_device = MCDI_WORD(outbuf,
> +					      CDX_BUS_GET_DEVICE_CONFIG_OUT_SUBSYS_DEVICE_ID);
> +	dev_params->class = MCDI_DWORD(outbuf,
> +				       CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_CLASS) & 0xFFFFFF;
> +	dev_params->revision = MCDI_BYTE(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_REVISION);
>  
>  	return 0;
>  }
> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index e93f1cd8ae33..2fa727770d6d 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -36,6 +36,19 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
>  				    u8 bus_num, u8 dev_num,
>  				    struct cdx_device_config *dev_config);
>  
> +/**
> + * CDX_DEVICE - macro used to describe a specific CDX device
> + * @vend: the 16 bit CDX Vendor ID
> + * @dev: the 16 bit CDX Device ID
> + *
> + * This macro is used to create a struct cdx_device_id that matches a
> + * specific device. The subvendor and subdevice fields will be set to
> + * CDX_ANY_ID.
> + */
> +#define CDX_DEVICE(vend, dev) \
> +	.vendor = (vend), .device = (dev), \
> +	.subvendor = CDX_ANY_ID, .subdevice = CDX_ANY_ID
> +
>  /**
>   * CDX_DEVICE_DRIVER_OVERRIDE - macro used to describe a CDX device with
>   *                              override_only flags.
> @@ -44,10 +57,12 @@ typedef int (*cdx_dev_configure_cb)(struct cdx_controller *cdx,
>   * @driver_override: the 32 bit CDX Device override_only
>   *
>   * This macro is used to create a struct cdx_device_id that matches only a
> - * driver_override device.
> + * driver_override device. The subvendor and subdevice fields will be set to
> + * CDX_ANY_ID.
>   */
>  #define CDX_DEVICE_DRIVER_OVERRIDE(vend, dev, driver_override) \
> -	.vendor = (vend), .device = (dev), .override_only = (driver_override)
> +	.vendor = (vend), .device = (dev), .subvendor = CDX_ANY_ID,\
> +	.subdevice = CDX_ANY_ID, .override_only = (driver_override)
>  
>  /**
>   * struct cdx_ops - Callbacks supported by CDX controller.
> @@ -84,6 +99,10 @@ struct cdx_controller {
>   * @cdx: CDX controller associated with the device
>   * @vendor: Vendor ID for CDX device
>   * @device: Device ID for CDX device
> + * @subsystem_vendor: Subsystem Vendor ID for CDX device
> + * @subsystem_device: Subsystem Device ID for CDX device
> + * @class: Class for the CDX device
> + * @revision: Revision of the CDX device
>   * @bus_num: Bus number for this CDX device
>   * @dev_num: Device number for this device
>   * @res: array of MMIO region entries
> @@ -101,6 +120,10 @@ struct cdx_device {
>  	struct cdx_controller *cdx;
>  	u16 vendor;
>  	u16 device;
> +	u16 subsystem_vendor;
> +	u16 subsystem_device;
> +	u32 class;

What endian are these attributes?  Please be specific for all of them
(also for vendor and device, right?)

thanks,

greg k-h
