Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B8974252A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjF2Lt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjF2LtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:49:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338EB10A;
        Thu, 29 Jun 2023 04:49:24 -0700 (PDT)
Received: from [192.168.150.202] (unknown [193.85.242.128])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 95756905;
        Thu, 29 Jun 2023 13:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688039321;
        bh=44CIGU77FMtsYtSehr/5wIKmF12qgnwZDyqVCWTkKZI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nR397gLCp3NBOf4wHaUF8RaTnnLyMw4FeZfwuAY98pu08GZOwMmoFMULfDS8gXGZT
         QtzGvHOFVvpRIKp5GGCIo08QXjva4Tp8Thrh0/5ydlNxh9A0hmRQqIfnWfLibNQ6W3
         idgd/90vk7k4UnQr7HnUKnqogLFaZJNtFOZi3nik=
Message-ID: <2373ef89-4d93-d675-c050-4539a753a4d6@ideasonboard.com>
Date:   Thu, 29 Jun 2023 13:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v8 3/5] staging: bcm2835-camera: Register bcm2835-camera
 with vchiq_bus_type
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com
References: <20230627201628.207483-1-umang.jain@ideasonboard.com>
 <20230627201628.207483-4-umang.jain@ideasonboard.com>
 <168799227183.3298351.12365161998104715465@Monstersaurus>
Content-Language: en-US
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <168799227183.3298351.12365161998104715465@Monstersaurus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 6/29/23 12:44 AM, Kieran Bingham wrote:
> Quoting Umang Jain (2023-06-27 21:16:26)
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
>>          .fmt.pix.sizeimage = 1024 * 768,
>>   };
>>   
>> -static int bcm2835_mmal_probe(struct platform_device *pdev)
>> +static int bcm2835_mmal_probe(struct vchiq_device *device)
>>   {
>>          int ret;
>>          struct bcm2835_mmal_dev *dev;
>> @@ -1896,7 +1897,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>>                                                         &camera_instance);
>>                  ret = v4l2_device_register(NULL, &dev->v4l2_dev);
>>                  if (ret) {
>> -                       dev_err(&pdev->dev, "%s: could not register V4L2 device: %d\n",
>> +                       dev_err(&device->dev, "%s: could not register V4L2 device: %d\n",
>>                                  __func__, ret);
>>                          goto free_dev;
>>                  }
>> @@ -1976,7 +1977,7 @@ static int bcm2835_mmal_probe(struct platform_device *pdev)
>>          return ret;
>>   }
>>   
>> -static void bcm2835_mmal_remove(struct platform_device *pdev)
>> +static void bcm2835_mmal_remove(struct vchiq_device *device)
>>   {
>>          int camera;
>>          struct vchiq_mmal_instance *instance = gdev[0]->instance;
>> @@ -1988,17 +1989,16 @@ static void bcm2835_mmal_remove(struct platform_device *pdev)
>>          vchiq_mmal_finalise(instance);
>>   }
>>   
>> -static struct platform_driver bcm2835_camera_driver = {
>> +static struct vchiq_driver bcm2835_camera_driver = {
>>          .probe          = bcm2835_mmal_probe,
>> -       .remove_new     = bcm2835_mmal_remove,
>> +       .remove         = bcm2835_mmal_remove,
>>          .driver         = {
>>                  .name   = "bcm2835-camera",
>>          },
>>   };
>>   
>> -module_platform_driver(bcm2835_camera_driver)
>> +module_vchiq_driver(bcm2835_camera_driver)
>>   
>>   MODULE_DESCRIPTION("Broadcom 2835 MMAL video capture");
>>   MODULE_AUTHOR("Vincent Sanders");
>>   MODULE_LICENSE("GPL");
>> -MODULE_ALIAS("platform:bcm2835-camera");
> This bit worries me. I think that's how module autoloading is handled.
>
> Can you check into the details of MODULE_ALIAS and follow the rabbit
> hole for a bit? It's a few years since I last went down there so I can't
> remember the specifics right now.

vchiq_probe() will register both the bcm2385_audio and bcm2835-camera 
hence, we don't need MODULE_ALIAS for those two.

So what I also tested is that, when bcm2835_vchiq loads, it will 
auto-load both audio and camera with it (since these are child devices 
of vchiq). I think that's the correct way.
>
> Except for that, I think this looks good.
>
>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index e8d40f891449..79d4d0eeb5fb 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -67,7 +67,6 @@ int vchiq_susp_log_level = VCHIQ_LOG_ERROR;
>>   DEFINE_SPINLOCK(msg_queue_spinlock);
>>   struct vchiq_state g_state;
>>   
>> -static struct platform_device *bcm2835_camera;
>>   static struct platform_device *bcm2835_audio;
>>   
>>   struct vchiq_drvdata {
>> @@ -134,6 +133,15 @@ struct vchiq_pagelist_info {
>>          unsigned int scatterlist_mapped;
>>   };
>>   
>> +/*
>> + * The devices implemented in the VCHIQ firmware are not discoverable,
>> + * so we need to maintain a list of them in order to register them with
>> + * the interface.
>> + */
>> +static const char *const vchiq_devices[] = {
>> +       "bcm2835-camera",
>> +};
>> +
>>   static void __iomem *g_regs;
>>   /* This value is the size of the L2 cache lines as understood by the
>>    * VPU firmware, which determines the required alignment of the
>> @@ -1798,6 +1806,7 @@ static int vchiq_probe(struct platform_device *pdev)
>>          struct device_node *fw_node;
>>          const struct of_device_id *of_id;
>>          struct vchiq_drvdata *drvdata;
>> +       unsigned int i;
>>          int err;
>>   
>>          of_id = of_match_node(vchiq_of_match, pdev->dev.of_node);
>> @@ -1840,9 +1849,15 @@ static int vchiq_probe(struct platform_device *pdev)
>>                  goto error_exit;
>>          }
>>   
>> -       bcm2835_camera = vchiq_register_child(pdev, "bcm2835-camera");
>>          bcm2835_audio = vchiq_register_child(pdev, "bcm2835_audio");
>>   
>> +       for (i = 0; i < ARRAY_SIZE(vchiq_devices); i++) {
>> +               err = vchiq_device_register(&pdev->dev, vchiq_devices[i]);
>> +               if (err)
>> +                       dev_err(&pdev->dev, "Failed to register %s vchiq device\n",
>> +                       vchiq_devices[i]);
>> +       }
>> +
>>          return 0;
>>   
>>   failed_platform_init:
>> @@ -1854,7 +1869,7 @@ static int vchiq_probe(struct platform_device *pdev)
>>   static void vchiq_remove(struct platform_device *pdev)
>>   {
>>          platform_device_unregister(bcm2835_audio);
>> -       platform_device_unregister(bcm2835_camera);
>> +       bus_for_each_dev(&vchiq_bus_type, NULL, NULL, vchiq_device_unregister);
>>          vchiq_debugfs_deinit();
>>          vchiq_deregister_chrdev();
>>   }
>> -- 
>> 2.39.1
>>

