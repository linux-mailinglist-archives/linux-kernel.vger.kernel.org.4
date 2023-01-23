Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A32E678488
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjAWSWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAWSWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:22:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F009A5E3;
        Mon, 23 Jan 2023 10:22:22 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA35D2D9;
        Mon, 23 Jan 2023 19:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674498140;
        bh=f2RzI2Qo2MGN2kAX9LbM1xztzGR1EzOfGn9ssFnhtlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FpSwjd3j+FIel649gfF1BIEjJTynaZbZ6LryogBejx4N//lUP2Tu7F6IMyRrCeJ2b
         8hKqp7aG5+Hujb73kZmCjCw2HJcVN0jQC/k1DjBOwfVV+hokvqGJwFdQS5UhUm3Zms
         uf8w1Bk5sba67eeqAqkXkX6nNIf57zbAYUsEwrLc=
Date:   Mon, 23 Jan 2023 20:22:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
Subject: Re: [PATCH v6 6/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <Y87QWLkjBYwPaNAh@pendragon.ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <20230120201104.606876-7-umang.jain@ideasonboard.com>
 <Y87Nup39ahtymV8n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y87Nup39ahtymV8n@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jan 23, 2023 at 07:11:06PM +0100, Greg Kroah-Hartman wrote:
> On Sat, Jan 21, 2023 at 01:41:04AM +0530, Umang Jain wrote:
> > The devices that the vchiq interface registers (bcm2835-audio,
> > bcm2835-camera) are implemented and exposed by the VC04 firmware.
> > The device tree describes the VC04 itself with the resources required
> > to communicate with it through a mailbox interface. However, the
> > vchiq interface registers these devices as platform devices. This
> > also means the specific drivers for these devices are getting
> > registered as platform drivers. This is not correct and a blatant
> > abuse of platform device/driver.
> > 
> > Replace the platform device/driver model with a standard device driver
> > model. A custom bus_type, vchiq_bus_type, is created in the vchiq
> > interface which matches the devices to their specific device drivers
> > thereby, establishing driver binding. A struct vchiq_device wraps the
> > struct device for each device being registered on the bus by the vchiq
> > interface. On the other hand, struct vchiq_driver wraps the struct
> > device_driver and the module_vchiq_driver() macro is provided for the
> > driver registration.
> > 
> > Each device registered will expose a 'name' read-only device attribute
> > in sysfs (/sys/bus/vchiq-bus/devices). New devices and drivers can be
> > added by registering on vchiq_bus_type and adding a corresponding
> > device name entry in the static list of devices, vchiq_devices. There
> > is currently no way to enumerate the VCHIQ devices that are available
> > from the firmware.
> 
> I took the first 5 patches in this series, but stopped here.
> 
> This one needs to be broken up into much smaller pieces.  I suggest
> creating the bus, and then move the existing code over to the new
> interfaces instead of doing it all at once.  This way is much harder to
> review and problems do not stand out very well.
> 
> Some minor questions:
> 
> > -static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
> > +static int snd_bcm2835_alsa_probe(struct device *dev)
> 
> probe functions (and all bus functions) should take your new device
> type, not a generic device type, as that's not what they are working
> with here at all.
> 
> >  {
> > -	struct device *dev = &pdev->dev;
> >  	int err;
> >  
> >  	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
> > @@ -292,32 +291,32 @@ static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
> >  
> >  #ifdef CONFIG_PM
> >  
> > -static int snd_bcm2835_alsa_suspend(struct platform_device *pdev,
> > +static int snd_bcm2835_alsa_suspend(struct device *pdev,
> >  				    pm_message_t state)
> 
> Same here, use your real device type.
> 
> > -static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
> > +static int snd_bcm2835_alsa_resume(struct device *pdev)
> 
> And here, a real device type please.
> 
> >  MODULE_AUTHOR("Dom Cobley");
> >  MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
> >  MODULE_LICENSE("GPL");
> > -MODULE_ALIAS("platform:bcm2835_audio");
> > +MODULE_ALIAS("bcm2835_audio");
> 
> Why do you need this module alias now?  Are you sure it still works?  If
> so, why is it created by hand like this?

I like when you beat me to review a series, and point out all the things
I would have pointed out too :-)

> > +static const char *const vchiq_devices[] = {
> > +	"bcm2835_audio",
> > +	"bcm2835-camera",
> > +};
> 
> A list of device names?  That's really odd, so please really really
> document it.

As discussed previously, the devices implemented in the firmware are not
discoverable, so we need to hardcode them here. A comment is indeed
needed.

> > +static ssize_t vchiq_dev_show(struct device *dev,
> > +			      struct device_attribute *attr, char *buf)
> > +{
> > +	struct vchiq_device *device = container_of(dev, struct vchiq_device, dev);
> > +
> > +	return sprintf(buf, "%s", device->name);
> 
> sysfs_emit() please.
> 
> But why do you have the device name as a sysfs file?  It's the name of
> the directory in sysfs already, why have it repeated?
> 
> > +}
> > +
> > +static DEVICE_ATTR_RO(vchiq_dev);
> > +
> > +static struct attribute *vchiq_dev_attrs[] = {
> > +	&dev_attr_vchiq_dev.attr,
> > +	NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(vchiq_dev);
> > +
> > +static const struct device_type vchiq_device_type = {
> > +	.groups         = vchiq_dev_groups
> > +};
> > +
> > +struct bus_type vchiq_bus_type = {
> > +	.name   = "vchiq-bus",
> > +	.match  = vchiq_bus_type_match,
> > +};
> > +EXPORT_SYMBOL_GPL(vchiq_bus_type);
> 
> Why is this exported?
> 
> > +
> > +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> > +{
> > +	if (dev->bus == &vchiq_bus_type &&
> > +	    strcmp(dev_name(dev), drv->name) == 0)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> > +static void vchiq_device_release(struct device *dev)
> > +{
> > +	struct vchiq_device *device;
> > +
> > +	device = container_of(dev, struct vchiq_device, dev);
> > +	kfree(device);
> > +}
> > +
> > +int vchiq_device_register(struct device *parent, const char *name)
> > +{
> > +	struct vchiq_device *device = NULL;
> > +	int ret;
> > +
> > +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> > +	if (!device)
> > +		return -ENOMEM;
> > +
> > +	device->name = name;
> > +	device->dev.init_name = name;
> > +	device->dev.parent = parent;
> > +	device->dev.bus = &vchiq_bus_type;
> > +	device->dev.type = &vchiq_device_type;
> > +	device->dev.release = vchiq_device_release;
> > +
> > +	ret = device_register(&device->dev);
> > +	if (ret) {
> > +		put_device(&device->dev);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int vchiq_device_unregister(struct device *dev, void *data)
> > +{
> > +	device_unregister(dev);
> > +	return 0;
> > +}
> > +
> > +int vchiq_driver_register(struct vchiq_driver *vchiq_drv)
> > +{
> > +	vchiq_drv->driver.bus = &vchiq_bus_type;
> > +
> > +	return driver_register(&vchiq_drv->driver);
> > +}
> > +EXPORT_SYMBOL_GPL(vchiq_driver_register);
> > +
> > +void vchiq_driver_unregister(struct vchiq_driver *vchiq_drv)
> > +{
> > +	driver_unregister(&vchiq_drv->driver);
> > +}
> > +EXPORT_SYMBOL_GPL(vchiq_driver_unregister);
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> > new file mode 100644
> > index 000000000000..0848c1b353f8
> > --- /dev/null
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> > +/*
> > + * Copyright (c) 2023 Ideas On Board Oy
> > + */
> > +
> > +#ifndef _VCHIQ_DEVICE_H
> > +#define _VCHIQ_DEVICE_H
> > +
> > +#include <linux/device.h>
> > +
> > +struct vchiq_device {
> > +	struct device dev;
> > +	const char *name;
> 
> Why do you need another name for your device?  What's wrong with the
> name field in struct device?
> 
> thanks,
> 
> greg k-h

-- 
Regards,

Laurent Pinchart
