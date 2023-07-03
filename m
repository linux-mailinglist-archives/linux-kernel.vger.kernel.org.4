Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DC1745EF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGCOp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjGCOpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:45:11 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5010CE;
        Mon,  3 Jul 2023 07:44:52 -0700 (PDT)
Received: from [192.168.0.136] (85-160-45-219.reb.o2.cz [85.160.45.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D019558;
        Mon,  3 Jul 2023 16:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688395445;
        bh=gY4+xWjRxQqKzgbz5r4Gqf9iuuKb3qum48HfTwqVoME=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kvCmMAlOGe3KhkmBcK3B67kVoraHZWy5ufOidnsjV5bHCemAe1MVvtRf8pSXemww7
         jKKrwVTjJ3qSkL4cd+7+0mb4MEyw6S1cgiUZUmp3OI6vzVWF9HJf/Qzi8Zic0+Xe0N
         /xaafLDmvyd7Rmi9jfuj33F6V+DjiOH+T1zZUsbM=
Message-ID: <f080a725-65ea-c3fe-896a-5ac711dddfc1@ideasonboard.com>
Date:   Mon, 3 Jul 2023 16:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 3/5] staging: bcm2835-camera: Register bcm2835-camera
 with vchiq_bus_type
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
 <20230627201628.207483-4-umang.jain@ideasonboard.com>
 <2023070319-daycare-pointless-abba@gregkh>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <2023070319-daycare-pointless-abba@gregkh>
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

On 7/3/23 3:29 PM, Greg KH wrote:
> On Tue, Jun 27, 2023 at 10:16:26PM +0200, Umang Jain wrote:
>> Register the bcm2835-camera with the vchiq_bus_type instead of using
>> platform driver/device.
>>
>> Also the VCHIQ firmware doesn't support device enumeration, hence
>> one has to maintain a list of devices to be registered in the interface.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   .../bcm2835-camera/bcm2835-camera.c           | 16 +++++++-------
>>   .../interface/vchiq_arm/vchiq_arm.c           | 21 ++++++++++++++++---
>>   2 files changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>> index 346d00df815a..f37b2a881d92 100644
>> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
>> @@ -24,8 +24,9 @@
>>   #include <media/v4l2-event.h>
>>   #include <media/v4l2-common.h>
>>   #include <linux/delay.h>
>> -#include <linux/platform_device.h>
>>   
>> +#include "../interface/vchiq_arm/vchiq_arm.h"
>> +#include "../interface/vchiq_arm/vchiq_device.h"
>>   #include "../vchiq-mmal/mmal-common.h"
>>   #include "../vchiq-mmal/mmal-encodings.h"
>>   #include "../vchiq-mmal/mmal-vchiq.h"
>> @@ -1841,7 +1842,7 @@ static struct v4l2_format default_v4l2_format = {
>>   	.fmt.pix.sizeimage = 1024 * 768,
>>   };
>>   
>> -static int bcm2835_mmal_probe(struct platform_device *pdev)
>> +static int bcm2835_mmal_probe(struct vchiq_device *device)
>>   {
>>   	int ret;
>>   	struct bcm2835_mmal_dev *dev;
>> @@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>>   						       &camera_instance);
>>   		ret = v4l2_device_register(NULL, &dev->v4l2_dev);
>>   		if (ret) {
>> -			dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
>> +			dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
>>   				__func__, ret);
>>   			goto free_dev;
>>   		}
>> @@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>>   	return ret;
>>   }
>>   
>> -static void bcm2835_mmal_remove(struct platform_device *pdev)
>> +static void bcm2835_mmal_remove(struct vchiq_device *device)
>>   {
>>   	int camera;
>>   	struct vchiq_mmal_instance *instance = gdev[0]->instance;
>> @@ -1988,17 +1989,16 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
>>   	vchiq_mmal_finalise(instance);
>>   }
>>   
>> -static struct platform_driver bcm2835_camera_driver = {
>> +static struct vchiq_driver bcm2835_camera_driver = {
>>   	.probe		= bcm2835_mmal_probe,
>> -	.remove_new	= bcm2835_mmal_remove,
>> +	.remove		= bcm2835_mmal_remove,
> No need to change this here, right?  That's independant of this patch
> series.

Why not ?

Should I have "remove_new()"  in the struct vchiq_driver {..} [Patch 
1/5] instead of "remove()"  -  match up with platform_driver virtual 
interface ?

>
> thanks,
>
> greg k-h

