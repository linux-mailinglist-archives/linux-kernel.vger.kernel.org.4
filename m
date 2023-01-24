Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D70678FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjAXFjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXFjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:39:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4BA2B284;
        Mon, 23 Jan 2023 21:39:43 -0800 (PST)
Received: from [192.168.1.103] (unknown [103.86.18.176])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E03C68A9;
        Tue, 24 Jan 2023 06:39:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674538781;
        bh=/566U6Y7/ZQ4upvMkjhqi1q909njv5QcMXsfjYkMa9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qRrxIPK8mrD2ncgeLuM683ZZ28iPFs7N6jneMihIZT67aL1j+1l6iUZGq1aG7SQIT
         vsXcKQTVNJ1Z9PM4uRrf6983fEW0M9Gy5KQyDhj79/3fLJ/gbzhG6kkL8zb8WrAgS7
         rdCX4jJJZ3W42XdkvOjRJNaewXsS49rh1KbvjlFA=
Message-ID: <0a00331f-4107-2028-a54b-d600df4e9a68@ideasonboard.com>
Date:   Tue, 24 Jan 2023 11:09:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>
References: <20230120201104.606876-1-umang.jain@ideasonboard.com>
 <786df750-221e-82fc-a324-d30261296974@i2se.com>
 <62644cd8-c871-aee0-30b7-2fbab097504c@ideasonboard.com>
 <53a8f159-22ab-b280-17b2-b80f59256342@i2se.com>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <53a8f159-22ab-b280-17b2-b80f59256342@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan

On 1/23/23 10:58 PM, Stefan Wahren wrote:
> Hi Umang,
>
> Am 23.01.23 um 08:48 schrieb Umang Jain:
>> Hi Stefan,
>>
>> Thank for the testing.
>>
>> On 1/23/23 5:04 AM, Stefan Wahren wrote:
>>> Hi Umang,
>>>
>>> Am 20.01.23 um 21:10 schrieb Umang Jain:
>>>> This series just introduces five extra patches for dropping include
>>>> directives from Makefiles (suggested by Greg KH) and rebased.
>>>>
>>>> The main patch (6/6) removes platform device/driver abuse and moves
>>>> things to standard device/driver model using a custom_bus. Specific
>>>> details are elaborated in the commit message.
>>>>
>>>> The patch series is based on top of d514392f17fd (tag: next-20230120)
>>>> of linux-next.
>>>
>>> applied this series on top of linux-next and build it with 
>>> arm/multi_v7_defconfig plus the following:
>>>
>>> CONFIG_BCM_VIDEOCORE=y
>>> CONFIG_BCM2835_VCHIQ=m
>>> CONFIG_VCHIQ_CDEV=y
>>> CONFIG_SND_BCM2835=m
>>> CONFIG_VIDEO_BCM2835=m
>>> CONFIG_BCM2835_VCHIQ_MMAL=m
>>>
>>> and the devices doesn't register on Raspberry Pi 3 B Plus:
>>>
>>> [   25.523337] vchiq: module is from the staging directory, the 
>>> quality is unknown, you have been warned.
>>> [   25.541647] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>>> bcm2835_audio vchiq device
>>> [   25.553692] bcm2835_vchiq 3f00b840.mailbox: Failed to register 
>>> bcm2835-camera vchiq device
>>
>> I was able to reproduce and it seems the issue here is the change 
>> mentioned in the cover
>>
>> - drop dma_set_mask_and_coherent
>>
>> in V6.
>>
>> (I usually test patches on RPi 4B with vcsm-cma and bcm2835-isp 
>> applied so my branch has the DMA hunk included while I was testing V6)
>>
>> Below is the hunk which should resolve the issue.
>>
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
>> @@ -6,6 +6,7 @@
>>   */
>>
>>  #include <linux/device/bus.h>
>> +#include <linux/dma-mapping.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>
>> @@ -72,6 +73,12 @@ int vchiq_device_register(struct device *parent, 
>> const char *name)
>>         device->dev.type = &vchiq_device_type;
>>         device->dev.release = vchiq_device_release;
>>
>> +       ret = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
>> +       if (ret < 0) {
>> +               vchiq_device_release(&device->dev);
>> +               return ret;
>> +       }
>> +
>>         ret = device_register(&device->dev);
>>         if (ret) {
>>                 put_device(&device->dev);
> Yes, this patch fixes the errors above. But i noticed that the series 
> also break autoprobing of bcm2835-audio and bcm2835-camera.

For the diff concerned, I am still looking into why is this needed.

Regarding the autoprobing, I have noticed that as well. It seems the 
probing is automatic for platform driver/devices and we are moving away 
from the platform driver/devices. So, this is expected I suppose?

Reading from Documentation/driver-api/driver-model/platform.rst

"""
Driver binding is performed automatically by the driver core, invoking 
driver probe() after finding a match between device and driver. If the 
probe() succeeds, the driver and device are bound as usual
"""

Should we retain this behavior ?
>>
>> It seems we need to include the dma_set_mask_and_coherent() even if 
>> bcm2835-audio, bcm2835-camera device doesn't do DMA? I need to look 
>> into why is that/
>>
>>  Laurent, any thoughts on this please?
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

