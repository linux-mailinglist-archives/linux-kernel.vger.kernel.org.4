Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8DE73817F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjFUJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjFUJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:20:13 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E9F6E69
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:20:11 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxhMTJwJJkbxQAAA--.157S3;
        Wed, 21 Jun 2023 17:20:09 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM7IwJJk8F4AAA--.2408S3;
        Wed, 21 Jun 2023 17:20:08 +0800 (CST)
Message-ID: <52751b55-ce34-f3a8-b3c0-4858ad984622@loongson.cn>
Date:   Wed, 21 Jun 2023 17:20:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 01/11] drm/etnaviv: Add a dedicated function to
 register an irq handler
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
 <20230620094716.2231414-2-18949883232@163.com>
 <77f62814f98dd2728a1e4747f0db6b2a3cfa2c11.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <77f62814f98dd2728a1e4747f0db6b2a3cfa2c11.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxzM7IwJJk8F4AAA--.2408S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr45CF18Xr4DJFWUXFy5trc_yoW5ur17pF
        ZrGFyYyr1kua42g34xXF98ZFya9w4xXayxCr1Dt3sI9ws0yrn5tryYkF4jka4fAr95Cw4x
        tr4jgr17uF4YvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/21 17:07, Lucas Stach wrote:
> Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Because getting IRQ from a device is platform-dependent, PCI devices have
>> different methods for getting an IRQ. This patch is a preparation to extend
>> this driver for supporting the PCI devices.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 32 +++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> index de8c9894967c..a03e81337d8f 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -1817,6 +1817,27 @@ static const struct of_device_id etnaviv_gpu_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
>>   
>> +static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
>> +{
>> +	struct device *dev = gpu->dev;
>> +	int err;
>> +
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	err = devm_request_irq(dev, irq, irq_handler, 0, dev_name(dev), gpu);
>> +	if (err) {
>> +		dev_err(dev, "failed to request irq %u: %d\n", irq, err);
>> +		return err;
>> +	}
>> +
>> +	gpu->irq = irq;
>> +
>> +	dev_info(dev, "irq(%d) handler registered\n", irq);
> There is no reason to put this into the kernel log.

I want to see the IRQ of the device when debugging,

etnaviv actually print very less.

This serve as a minimal signal  to us the etnaviv_gpu_register_irq() 
function is successful at driver load time.

>   It's no different
> than other resources to the driver and we don't log each one of those
> either.
>
> In fact I don't see any reason for this change in the first place.
> Effectively you are moving a single function call into a new function,
> which doesn't seem like an improvement.

This is to make the patch easy to review, each patch is only introduce a 
small function,

which is paving the way for we introducing the PCI device driver.

Otherwise when we introducing the PCI device driver, the patch is looks 
ugly,

It is difficult to review.

> Regards,
> Lucas
>
>> +
>> +	return 0;
>> +}
>> +
>>   static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -1837,16 +1858,9 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>>   		return PTR_ERR(gpu->mmio);
>>   
>>   	/* Get Interrupt: */
>> -	gpu->irq = platform_get_irq(pdev, 0);
>> -	if (gpu->irq < 0)
>> -		return gpu->irq;
>> -
>> -	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
>> -			       dev_name(gpu->dev), gpu);
>> -	if (err) {
>> -		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
>> +	err = etnaviv_gpu_register_irq(gpu, platform_get_irq(pdev, 0));
>> +	if (err)
>>   		return err;
>> -	}
>>   
>>   	/* Get Clocks: */
>>   	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");

-- 
Jingfeng

