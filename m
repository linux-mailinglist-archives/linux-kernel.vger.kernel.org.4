Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97F746398
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGCT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjGCT5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750A5E69;
        Mon,  3 Jul 2023 12:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A7860FE8;
        Mon,  3 Jul 2023 19:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED19C433C7;
        Mon,  3 Jul 2023 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688414252;
        bh=H9G0JTedWKE7c+iMv9ZhpL/buzoVhwoHAXTZNZuXBB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KT7/VON5HxLKRyET1XLEKgYCRtkQG0BQDJHzgLJtd9WMG3xTnmWOQaNWFNu4GRA9R
         yD4sQtNKP4NeqbiU0pNhFlxYFlPM3K/NgbER4NlnKIxr9f6iZmZp+cdpmZ1IpFuvsY
         eaM9sQjw9z3qz9idYYkjx+Kl66tdj/8wXlqFg1g4=
Date:   Mon, 3 Jul 2023 21:57:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v8 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Message-ID: <2023070301-elective-devious-2204@gregkh>
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-2-umang.jain@ideasonboard.com>
 <2023070302-gallon-unison-2b9c@gregkh>
 <d84acc1e-e933-b304-b513-f097c79d8a17@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d84acc1e-e933-b304-b513-f097c79d8a17@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:15:25PM +0200, Umang Jain wrote:
> Hi Greg,
> 
> (resending because it got bounced off a few lists due a line a copied with
> HTML tag..)
> 
> On 7/3/23 3:28 PM, Greg KH wrote:
> > On Tue, Jun 27, 2023 at 10:16:24PM +0200, Umang Jain wrote:
> > > The devices that the vchiq interface registers (bcm2835-audio,
> > > bcm2835-camera) are implemented and exposed by the VC04 firmware.
> > > The device tree describes the VC04 itself with the resources required
> > > to communicate with it through a mailbox interface. However, the
> > > vchiq interface registers these devices as platform devices. This
> > > also means the specific drivers for these devices are getting
> > > registered as platform drivers. This is not correct and a blatant
> > > abuse of platform device/driver.
> > > 
> > > Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
> > > which will be used to migrate child devices that the vchiq interfaces
> > > creates/registers from the platform device/driver.
> > > 
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >   drivers/staging/vc04_services/Makefile        |  1 +
> > >   .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
> > >   .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
> > >   3 files changed, 122 insertions(+)
> > >   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > >   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
> > > 
> > > diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
> > > index 44794bdf6173..2d071e55e175 100644
> > > --- a/drivers/staging/vc04_services/Makefile
> > > +++ b/drivers/staging/vc04_services/Makefile
> > > @@ -5,6 +5,7 @@ vchiq-objs := \
> > >      interface/vchiq_arm/vchiq_core.o  \
> > >      interface/vchiq_arm/vchiq_arm.o \
> > >      interface/vchiq_arm/vchiq_debugfs.o \
> > > +   interface/vchiq_arm/vchiq_device.o \
> > >      interface/vchiq_arm/vchiq_connected.o \
> > >   ifdef CONFIG_VCHIQ_CDEV
> > > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > > new file mode 100644
> > > index 000000000000..dff312e9735c
> > > --- /dev/null
> > > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
> > > @@ -0,0 +1,78 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * vchiq_device.c - VCHIQ generic device and bus-type
> > > + *
> > > + * Copyright (c) 2023 Ideas On Board Oy
> > > + */
> > > +
> > > +#include <linux/device/bus.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +
> > > +#include "vchiq_device.h"
> > > +
> > > +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv);
> > > +
> > > +struct bus_type vchiq_bus_type = {
> > > +	.name   = "vchiq-bus",
> > > +	.match  = vchiq_bus_type_match,
> > > +};
> > > +
> > > +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
> > > +{
> > > +	if (dev->bus == &vchiq_bus_type &&
> > > +	    strcmp(dev_name(dev), drv->name) == 0)
> > > +		return 1;
> > > +	return 0;
> > > +}
> > > +
> > > +static void vchiq_device_release(struct device *dev)
> > > +{
> > > +	struct vchiq_device *device;
> > > +
> > > +	device = container_of(dev, struct vchiq_device, dev);
> > > +	kfree(device);
> > > +}
> > > +
> > > +int vchiq_device_register(struct device *parent, const char *name)
> > > +{
> > > +	struct vchiq_device *device = NULL;
> > No need to set this to NULL.
> > 
> > > +	int ret;
> > > +
> > > +	device = kzalloc(sizeof(*device), GFP_KERNEL);
> > > +	if (!device)
> > > +		return -ENOMEM;
> > > +
> > > +	device->dev.init_name = name;
> > > +	device->dev.parent = parent;
> > > +	device->dev.bus = &vchiq_bus_type;
> > > +	device->dev.release = vchiq_device_release;
> > > +
> > > +	ret = device_register(&device->dev);
> > > +	if (ret) {
> > > +		put_device(&device->dev);
> > > +		return -EINVAL;
> > Why not return the error given to you?
> > 
> > > +	}
> > > +
> > > +	return 0;
> > You create a new device, shouldn't you return it?  How is it going to be
> > looked up again?
> 
> So I haven't come across usage of the device other than unregistered right
> now. If you look at the platform_device static instances of bcm2835_camera,
> bcm2835-audio, they are also just used for unregistering the devices only.

That feels odd, you need to register a device, use it, and then
unregister it when finished.  Otherwise why have it?

> So for unregistering devices on vchiq_bus - I am using the
> 
>     bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregister);

Ick, no, that is horrid, unregister the device that was created, that's
how all other busses work.

> So basically I can return the instances right now, but there would be no
> user of those instances.

You should save it :)


> > 
> > > +}
> > > +
> > > +int vchiq_device_unregister(struct device *dev, void *data)
> > You should be passing in a sruct vchiq_device *device here, right?
> > 
> > And why the void pointer you do nothing with?
> 
> ack
> > 
> > 
> > > +{
> > > +	device_unregister(dev);
> > > +	return 0;
> > > +}
> > No need to export this?
> 
> In the previous reviews you mentioned not to export it. The vchiq_bus_type
> is internal to the vchiq_driver to register it's child devices. I don't
> think any other module will be using this bus directly? Maybe I'm mistaken?

Ok, just didn't match up with the register function export.

thanks,

greg k-h
