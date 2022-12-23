Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74F654C35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLWF2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWF2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:28:47 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729281CB30;
        Thu, 22 Dec 2022 21:28:45 -0800 (PST)
Received: from [IPV6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a] (unknown [IPv6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C736F93;
        Fri, 23 Dec 2022 06:28:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671773322;
        bh=Lew3jrQRHjRkccU+AQDJAFQBxkdZnuSTUagLXbMqiIk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pnQNdZrdaRnxHqDRXI7NV3hu+0Ab9FozDptohx38HkRCag0hE1WY//6HScF5/p8CA
         1+lj5CkbuJGybjA1Ll+W2tK3wl1bNa+pjZMkLHzpAaMQsh+UVGZ9J0WbgxWv85h74B
         ww4AbXvhY0REUucqOCdF4JDquO76LzbCcOTlno9Y=
Message-ID: <3c864c60-91a6-9ef4-367e-3c8d453b765b@ideasonboard.com>
Date:   Fri, 23 Dec 2022 10:58:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/4] staging: vc04_services: Stop leaking platform
 device on error path
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <20221222191500.515795-1-umang.jain@ideasonboard.com>
 <20221222191500.515795-2-umang.jain@ideasonboard.com>
 <Y6S+d512bYo2BF0O@pendragon.ideasonboard.com>
From:   Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <Y6S+d512bYo2BF0O@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/23/22 2:00 AM, Laurent Pinchart wrote:
> Hi Umang,
>
> Thank you for the patch.
>
> On Fri, Dec 23, 2022 at 12:44:57AM +0530, Umang Jain wrote:
>> vchiq driver registers the child platform devices in
>> vchiq_register_child(). However, in the registration error code path,
>> currently the driver is leaking platform devices by not destroying the
>> return platform device. Plug this leak using platform_device_put() as
>> mentioned in the documentation for platform_device_register().
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index dc33490ba7fb..fc7ea7ba97b2 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -1779,6 +1779,7 @@ vchiq_register_child(struct platform_device *pdev, const char *name)
>>   	child = platform_device_register_full(&pdevinfo);
>>   	if (IS_ERR(child)) {
>>   		dev_warn(&pdev->dev, "%s not registered\n", name);
>> +		platform_device_put(child);
> If IS_ERR(child), what do you expect platform_device_put(child) to do ?
> And have you read the implementation of platform_device_register_full()
> ?

Errr, yeah - it is handling the platform_device_put() as well. Stupid me!

(dropping this patch for v3)
>
>>   		child = NULL;
>>   	}
>>   

