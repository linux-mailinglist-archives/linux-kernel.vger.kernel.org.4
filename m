Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5295674608D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGCQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGCQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:15:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF97138;
        Mon,  3 Jul 2023 09:15:31 -0700 (PDT)
Received: from [192.168.0.136] (85-160-45-219.reb.o2.cz [85.160.45.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD379558;
        Mon,  3 Jul 2023 18:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688400886;
        bh=gYlggtONKgyVLfFg4FtFyUz5L/xvCsECWtCLrY31uig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=msRwoBw60b1gOoHX+D4O5wN+njZRs2V+cqX9TQ9jTLW9ddVBQi4ACufTLFzJVsXHD
         ckis2R45sa+5xOn/piTaBdeZMqOAbVRJQhObYnwzFd5g9wrzWe3fFA+WADD2T9+0vB
         RWKkDvAcCn+VBzFxKyGf3OGuRkHU32TLzxX4s7KI=
Message-ID: <d84acc1e-e933-b304-b513-f097c79d8a17@ideasonboard.com>
Date:   Mon, 3 Jul 2023 18:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 1/5] staging: vc04_services: vchiq_arm: Add new bus
 type and device type
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-2-umang.jain@ideasonboard.com>
 <2023070302-gallon-unison-2b9c@gregkh>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <2023070302-gallon-unison-2b9c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

(resending because it got bounced off a few lists due a line a copied 
with HTML tag..)

On 7/3/23 3:28 PM, Greg KH wrote:
> On Tue, Jun 27, 2023 at 10:16:24PM +0200, Umang Jain wrote:
>> The devices that the vchiq interface registers (bcm2835-audio,
>> bcm2835-camera) are implemented and exposed by the VC04 firmware.
>> The device tree describes the VC04 itself with the resources required
>> to communicate with it through a mailbox interface. However, the
>> vchiq interface registers these devices as platform devices. This
>> also means the specific drivers for these devices are getting
>> registered as platform drivers. This is not correct and a blatant
>> abuse of platform device/driver.
>>
>> Add a new bus type, vchiq_bus_type and device type (struct vchiq_device)
>> which will be used to migrate child devices that the vchiq interfaces
>> creates/registers from the platform device/driver.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/staging/vc04_services/Makefile        |  1 +
>>   .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
>>   .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
>>   3 files changed, 122 insertions(+)
>>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>>   create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h
>>
>> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
>> index 44794bdf6173..2d071e55e175 100644
>> --- a/drivers/staging/vc04_services/Makefile
>> +++ b/drivers/staging/vc04_services/Makefile
>> @@ -5,6 +5,7 @@ vchiq-objs := \
>>      interface/vchiq_arm/vchiq_core.o  \
>>      interface/vchiq_arm/vchiq_arm.o \
>>      interface/vchiq_arm/vchiq_debugfs.o \
>> +   interface/vchiq_arm/vchiq_device.o \
>>      interface/vchiq_arm/vchiq_connected.o \
>>   
>>   ifdef CONFIG_VCHIQ_CDEV
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> new file mode 100644
>> index 000000000000..dff312e9735c
>> --- /dev/null
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * vchiq_device.c - VCHIQ generic device and bus-type
>> + *
>> + * Copyright (c) 2023 Ideas On Board Oy
>> + */
>> +
>> +#include <linux/device/bus.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +
>> +#include "vchiq_device.h"
>> +
>> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv);
>> +
>> +struct bus_type vchiq_bus_type = {
>> +	.name   = "vchiq-bus",
>> +	.match  = vchiq_bus_type_match,
>> +};
>> +
>> +static int vchiq_bus_type_match(struct device *dev, struct device_driver *drv)
>> +{
>> +	if (dev->bus == &vchiq_bus_type &&
>> +	    strcmp(dev_name(dev), drv->name) == 0)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static void vchiq_device_release(struct device *dev)
>> +{
>> +	struct vchiq_device *device;
>> +
>> +	device = container_of(dev, struct vchiq_device, dev);
>> +	kfree(device);
>> +}
>> +
>> +int vchiq_device_register(struct device *parent, const char *name)
>> +{
>> +	struct vchiq_device *device = NULL;
> No need to set this to NULL.
>
>> +	int ret;
>> +
>> +	device = kzalloc(sizeof(*device), GFP_KERNEL);
>> +	if (!device)
>> +		return -ENOMEM;
>> +
>> +	device->dev.init_name = name;
>> +	device->dev.parent = parent;
>> +	device->dev.bus = &vchiq_bus_type;
>> +	device->dev.release = vchiq_device_release;
>> +
>> +	ret = device_register(&device->dev);
>> +	if (ret) {
>> +		put_device(&device->dev);
>> +		return -EINVAL;
> Why not return the error given to you?
>
>> +	}
>> +
>> +	return 0;
> You create a new device, shouldn't you return it?  How is it going to be
> looked up again?

So I haven't come across usage of the device other than unregistered 
right now. If you look at the platform_device static instances of 
bcm2835_camera, bcm2835-audio, they are also just used for unregistering 
the devices only.

So for unregistering devices on vchiq_bus - I am using the

     bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregister);

in patch 3/5.

So basically I can return the instances right now, but there would be no 
user of those instances.
>
>> +}
>> +
>> +int vchiq_device_unregister(struct device *dev, void *data)
> You should be passing in a sruct vchiq_device *device here, right?
>
> And why the void pointer you do nothing with?

ack
>
>
>> +{
>> +	device_unregister(dev);
>> +	return 0;
>> +}
> No need to export this?

In the previous reviews you mentioned not to export it. The 
vchiq_bus_type is internal to the vchiq_driver to register it's child 
devices. I don't think any other module will be using this bus directly? 
Maybe I'm mistaken?
>
> thanks,
>
> greg k-h

