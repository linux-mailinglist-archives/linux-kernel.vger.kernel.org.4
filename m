Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4498C737FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFUJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjFUJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:51:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80014213E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:49:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxuMW0x5JkKhYAAA--.162S3;
        Wed, 21 Jun 2023 17:49:40 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uSzx5Jk32gAAA--.2575S3;
        Wed, 21 Jun 2023 17:49:39 +0800 (CST)
Message-ID: <1c7596fd-7e63-6719-2574-7d7820687832@loongson.cn>
Date:   Wed, 21 Jun 2023 17:49:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 03/11] drm/etnaviv: Add dedicated functions to create
 and destroy platform device
Content-Language: en-US
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sui Jingfeng <18949883232@163.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230620094716.2231414-1-18949883232@163.com>
 <20230620094716.2231414-4-18949883232@163.com>
 <0daa7182d6600a24988d1c81cf8fe3c0c9487f52.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <0daa7182d6600a24988d1c81cf8fe3c0c9487f52.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Ax8uSzx5Jk32gAAA--.2575S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFW3Aw1xJF1fKFW8tw1kZwc_yoWruryrpF
        WUGFWYyry8WFWUKw1xXrn8ZFW5Cw1Sq34F9r1qywnF9390vr9YqFyrKF1UAasxJryfGa1F
        vw4UtFs7uF45ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023/6/21 17:15, Lucas Stach wrote:
> Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Also rename the virtual master platform device as etnaviv_platform_device,
>> for better reflection that it is a platform device, not a DRM device.
>>
>> Another benefit is that we no longer need to call of_node_put() for three
>> different cases, Instead, we only need to call it once.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 56 +++++++++++++++++++--------
>>   1 file changed, 39 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index 31a7f59ccb49..cec005035d0e 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -656,12 +656,44 @@ static struct platform_driver etnaviv_platform_driver = {
>>   	},
>>   };
>>   
>> -static struct platform_device *etnaviv_drm;
>> +static struct platform_device *etnaviv_platform_device;
>>   
>> -static int __init etnaviv_init(void)
>> +static int etnaviv_create_platform_device(const char *name,
>> +					  struct platform_device **ppdev)
> As the platform device is a global static variable, there is no need to
> push it through the parameters of this function. Just use the global
> variable directly in this function.

A function reference a global static variable is *NOT* a *pure* fucntion,

it degenerate as a procedure,


The function is perfect in the sense that it does not reference any 
global variable.


etnaviv_create_platform_device() is NOT intended to used by one function,

a specific purpose only, but when create this function, I want to create other

platform device with this function.

Say, You want to create a dummy platform device, targeting to bind to the real master

(the single GPU core) . To verify the idea that we choose the first 3D gpu core as master,

other 2D or VG gpu core is not as important as the 3D one.

The should bind to the 3D GPU core (master).


While back to the question you ask, I want etnaviv_create_platform_device() to be generic,

can be used by multiple place for multiple purpose.

I have successfully copy this to a another drm driver by simply renaming.

The body of the function itself does not need to change.

>>   {
>>   	struct platform_device *pdev;
>>   	int ret;
>> +
>> +	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
>> +	if (!pdev)
>> +		return -ENOMEM;
>> +
>> +	ret = platform_device_add(pdev);
>> +	if (ret) {
>> +		platform_device_put(pdev);
>> +		return ret;
>> +	}
>> +
>> +	*ppdev = pdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static void etnaviv_destroy_platform_device(struct platform_device **ppdev)
>> +{
>> +	struct platform_device *pdev = *ppdev;
> Same here, just use the global variable directly.
>
> Regards,
> Lucas
>
>> +
>> +	if (!pdev)
>> +		return;
>> +
>> +	platform_device_unregister(pdev);
>> +
>> +	*ppdev = NULL;
>> +}
>> +
>> +static int __init etnaviv_init(void)
>> +{
>> +	int ret;
>>   	struct device_node *np;
>>   
>>   	etnaviv_validate_init();
>> @@ -681,23 +713,13 @@ static int __init etnaviv_init(void)
>>   	for_each_compatible_node(np, NULL, "vivante,gc") {
>>   		if (!of_device_is_available(np))
>>   			continue;
>> +		of_node_put(np);
>>   
>> -		pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
>> -		if (!pdev) {
>> -			ret = -ENOMEM;
>> -			of_node_put(np);
>> -			goto unregister_platform_driver;
>> -		}
>> -
>> -		ret = platform_device_add(pdev);
>> -		if (ret) {
>> -			platform_device_put(pdev);
>> -			of_node_put(np);
>> +		ret = etnaviv_create_platform_device("etnaviv",
>> +						     &etnaviv_platform_device);
>> +		if (ret)
>>   			goto unregister_platform_driver;
>> -		}
>>   
>> -		etnaviv_drm = pdev;
>> -		of_node_put(np);
>>   		break;
>>   	}
>>   
>> @@ -713,7 +735,7 @@ module_init(etnaviv_init);
>>   
>>   static void __exit etnaviv_exit(void)
>>   {
>> -	platform_device_unregister(etnaviv_drm);
>> +	etnaviv_destroy_platform_device(&etnaviv_platform_device);
>>   	platform_driver_unregister(&etnaviv_platform_driver);
>>   	platform_driver_unregister(&etnaviv_gpu_driver);
>>   }

-- 
Jingfeng

