Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06ADA678439
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAWSLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjAWSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:11:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052A513B;
        Mon, 23 Jan 2023 10:11:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CE55CE16CF;
        Mon, 23 Jan 2023 18:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE715C433D2;
        Mon, 23 Jan 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674497469;
        bh=2OmojGSly4Xbo9BDz0Gflavvyg4ZZ2ht6xo7TdaAadw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6n3ZqThl4yLZ1MS+9R0c1B7Pn65KULnEhIG+UkdIDy0jh72ChRYzcprAZg5Fbk26
         mf+yy+PVPa+iOErqWy3pc6LG12G/uD1YoU6zm/rR6mr7nBPxudGSWYSFOCb9kJzeae
         5cWVexpNt9iwWmTTeqzZ4zcQLPgT9o4xVKgqTKro=
Date:   Mon, 23 Jan 2023 19:11:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v6 6/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <Y87Nup39ahtymV8n@kroah.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <20230120201104.606876-7-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120201104.606876-7-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 01:41:04AM +0530, Umang Jain wrote:
> The devices that the vchiq interface registers (bcm2835-audio,
> bcm2835-camera) are implemented and exposed by the VC04 firmware.
> The device tree describes the VC04 itself with the resources required
> to communicate with it through a mailbox interface. However, the
> vchiq interface registers these devices as platform devices. This
> also means the specific drivers for these devices are getting
> registered as platform drivers. This is not correct and a blatant
> abuse of platform device/driver.
> 
> Replace the platform device/driver model with a standard device driver
> model. A custom bus_type, vchiq_bus_type, is created in the vchiq
> interface which matches the devices to their specific device drivers
> thereby, establishing driver binding. A struct vchiq_device wraps the
> struct device for each device being registered on the bus by the vchiq
> interface. On the other hand, struct vchiq_driver wraps the struct
> device_driver and the module_vchiq_driver() macro is provided for the
> driver registration.
> 
> Each device registered will expose a 'name' read-only device attribute
> in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
> added by registering on vchiq_bus_type and adding a corresponding
> device name entry in the static list of devices, vchiq_devices. There
> is currently no way to enumerate the VCHIQ devices that are available
> from the firmware.

I took the first 5 patches in this series, but stopped here.

This one needs to be broken up into much smaller pieces.  I suggest
creating the bus, and then move the existing code over to the new
interfaces instead of doing it all at once.  This way is much harder to
review and problems do not stand out very well.

Some minor questions:

> -static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_probe(struct device *dev)

probe functions (and all bus functions) should take your new device
type, not a generic device type, as that's not what they are working
with here at all.


>  {
> -	struct device *dev = &pdev->dev;
>  	int err;
>  
>  	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
> @@ -292,32 +291,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
>  
>  #ifdef CONFIG_PM
>  
> -static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
> +static int snd_bcm2835_alsa_suspend(struct device *pdev,
>  				    pm_message_t state)

Same here, use your real device type.

> -static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
> +static int snd_bcm2835_alsa_resume(struct device *pdev)

And here, a real device type please.

>  MODULE_AUTHOR("Dom Cobley");
>  MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:bcm2835_audio");
> +MODULE_ALIAS("bcm2835_audio");

Why do you need this module alias now?  Are you sure it still works?  If
so, why is it created by hand like this?

> +static const char *const vchiq_devices[] = {
> +	"bcm2835_audio",
> +	"bcm2835-camera",
> +};

A list of device names?  That's really odd, so please really really
document it.

> +static ssize_t vchiq_dev_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct vchiq_device *device = container_of(dev, struct vchiq_device, dev);
> +
> +	return sprintf(buf, "%s", device->name);

sysfs_emit() please.

But why do you have the device name as a sysfs file?  It's the name of
the directory in sysfs already, why have it repeated?

> +}
> +
> +static DEVICE_ATTR_RO(vchiq_dev);
> +
> +static struct attribute *vchiq_dev_attrs[] = {
> +	&dev_attr_vchiq_dev.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(vchiq_dev);
> +
> +static const struct device_type vchiq_device_type = {
> +	.groups         = vchiq_dev_groups
> +};
> +
> +struct bus_type vchiq_bus_type = {
> +	.name   = "vchiq-bus",
> +	.match  = vchiq_bus_type_match,
> +};
> +EXPORT_SYMBOL_GPL(vchiq_bus_type);

Why is this exported?

> +
> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> +{
> +	if (dev->bus == &vchiq_bus_type &&
> +	    strcmp(dev_name(dev), drv->name) == 0)
> +		return 1;
> +	return 0;
> +}
> +
> +static void vchiq_device_release(struct device *dev)
> +{
> +	struct vchiq_device *device;
> +
> +	device = container_of(dev, struct vchiq_device, dev);
> +	kfree(device);
> +}
> +
> +int vchiq_device_register(struct device *parent, const char *name)
> +{
> +	struct vchiq_device *device = NULL;
> +	int ret;
> +
> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> +	if (!device)
> +		return -ENOMEM;
> +
> +	device->name = name;
> +	device->dev.init_name = name;
> +	device->dev.parent = parent;
> +	device->dev.bus = &vchiq_bus_type;
> +	device->dev.type = &vchiq_device_type;
> +	device->dev.release = vchiq_device_release;
> +
> +	ret = device_register(&device->dev);
> +	if (ret) {
> +		put_device(&device->dev);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int vchiq_device_unregister(struct device *dev, void *data)
> +{
> +	device_unregister(dev);
> +	return 0;
> +}
> +
> +int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
> +{
> +	vchiq_drv->driver.bus = &vchiq_bus_type;
> +
> +	return driver_register(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_register);
> +
> +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
> +{
> +	driver_unregister(&vchiq_drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> new file mode 100644
> index 000000000000..0848c1b353f8
> --- /dev/null
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/*
> + * Copyright (c) 2023 Ideas On Board Oy
> + */
> +
> +#ifndef _VCHIQ_DEVICE_H
> +#define _VCHIQ_DEVICE_H
> +
> +#include <linux/device.h>
> +
> +struct vchiq_device {
> +	struct device dev;
> +	const char *name;

Why do you need another name for your device?  What's wrong with the
name field in struct device?

thanks,

greg k-h
