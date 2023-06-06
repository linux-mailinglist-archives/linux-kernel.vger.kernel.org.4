Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081D3724B9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbjFFSoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238358AbjFFSoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:44:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A42010F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:44:16 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxIOlRfn9kLksAAA--.358S3;
        Wed, 07 Jun 2023 02:43:29 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxFORPfn9kJvACAA--.11400S3;
        Wed, 07 Jun 2023 02:43:27 +0800 (CST)
Message-ID: <234586a0-995c-b4c4-3b7b-35afeea1a797@loongson.cn>
Date:   Wed, 7 Jun 2023 02:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 7/7] drm/etnaviv: add support for the dma coherent
 device
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sui Jingfeng <15330273260@189.cn>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        etnaviv@lists.freedesktop.org
References: <20230606165624.GA1127373@bhelgaas>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <20230606165624.GA1127373@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFORPfn9kJvACAA--.11400S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr47Jw45Xr1rWryDCr15trc_yoWxGw43pF
        W5CFWYyrWDXry8Kw1xuw48uFyFv3yfJayFyryDt3W7Z398ZryFqrW8AF4Y9r98Ar4SgF4Y
        vr4DKFyUZF98ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I love your reviews


On 2023/6/7 00:56, Bjorn Helgaas wrote:
> On Sat, Jun 03, 2023 at 06:59:43PM +0800, Sui Jingfeng wrote:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> Loongson CPUs maintain cache coherency by hardware, which means that the
>> data in the CPU cache is identical to the data in main system memory. As
>> for the peripheral device, most of Loongson chips chose to define the
>> peripherals as DMA coherent by default, device drivers do not need to
>> maintain the coherency between a processor and an I/O device manually.
>>
>> There are exceptions, for LS2K1000 SoC, part of peripheral device can be
>> configured as dma non-coherent. But there is no released version of such
>> firmware exist in the market. Peripherals of older ls2k1000 is also DMA
>> non-conherent, but they are nearly outdated. So, those are trivial cases.
> s/dma/DMA/
> s/non-conherent/non-coherent/
> s/ls2k1000/LS2K1000/

So sharpen eyes, as before. :-)


> I guess when you say these are "trivial cases," you mean you don't
> care about supporting those devices?

Not exactly, Its just that its kernel side thing.

the kernel side should tell us whether a peripheral device is dma 
coherent or not.


I do try to support the LSDC/GC1000 as DMA non-coherent peripheral 
device in the past,

It's no fun, Only helps to study knowledge, experiment, testing and 
comparison(with the dma coherent case).


It requires me compile the PMON firmware on myself. And flash it to the 
ROM the board.

change firmware is complex, there a lot of address windows and cross 
bar(control

a access either go the cached path or go the non cached path) setting which

only firmware engineer know about.


If there a user want ask me to do it, I will try to test this driver on 
such old chip again.

Now, I believe that the support is *already* there.

As etnaviv already works on DMA non-coherent platform originally.


The DC in Loongson Mips/LoongArch SoC can scanout from cached system RAM.

low-end application relay on CPU software rendering only.

There no need to do something like flush cache(write the data in the cache

back to system ram), invalid the cache. This is pretty convenient.


The old Ingenic SoC(jz4770 for example, mips32) also has vivante gpu 
integrated.

but  they are dma non-coherent,  see more addition material at [1].

Therefore, still need to consider the support from cross(various) 
devices perspective.


[1]  https://lkml.org/lkml/2021/5/15/177

>> Nevertheless, kernel space still need to do probe work, because vivante GPU
>> IP has been integrated into various platform. Hence, this patch add runtime
>> detection code to probe if a specific gpu is DMA coherent, If the answer is
>> yes, we are going to utilize such features. On Loongson platfform, When a
>> buffer is accesed by both the GPU and the CPU, The driver should prefer
>> ETNA_BO_CACHED over ETNA_BO_WC.
> s/gpu/GPU/
> s/platfform/platform/
> s/accesed/accessed/

OK, will be fixed at next version,

I don't find this on myself. :-(

> I guess the only way to discover this coherency attribute is via the
> DT "vivante,gc" property?  Seems a little weird but I'm really not a
> DT person.

I'm not sure it is *only*, but it is very convenient to achieve such a 
thing with DT.

Just need to put the "dma-coherent;"  or "dma-noncoherent" inside the  
"vivante,gc" node.

see of_dma_is_coherent() function.

DT is flexible. But this is just used to describe the hardware, it don't 
not changing the hardware.

Put any property only has a influence to the software or driver side. 
The hardware still as it is.

Changing hardware to a different working mode probably still need the 
firmware(uefi, uboot, pmon etc) to do it


>> This patch also add a new parameter: etnaviv_param_gpu_coherent, which
>> allow userspace to know if such a feature is available. Because
>> write-combined BO is still preferred in some case, especially where don't
>> need CPU read, for example, uploading shader bin.
>> ...
>> +static struct device_node *etnaviv_of_first_available_node(void)
>> +{
>> +	struct device_node *core_node;
>> +
>> +	for_each_compatible_node(core_node, NULL, "vivante,gc") {
>> +		if (!of_device_is_available(core_node))
>> +			continue;
>> +
>> +		return core_node;
>> +	}
>> +
>> +	return NULL;
> Seems like this would be simpler as:
>
>    for_each_compatible_node(core_node, NULL, "vivante,gc") {
>      if (of_device_is_available(core_node))
>        return core_node;
>    }
>
>    return NULL;
Indeed, I don't realize this when I create this patch.
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/dma-fence.h>
>>   #include <linux/dma-mapping.h>
>> +#include <linux/dma-map-ops.h>
> It looks like this #include might not be needed?

No,

the dev_is_dma_coherent() function is declared and defined in dma-map-ops.h.


if remove it, gcc will complain:


drivers/gpu/drm/etnaviv/etnaviv_drv.c: In function 
‘etnaviv_is_dma_coherent’:
drivers/gpu/drm/etnaviv/etnaviv_drv.c:56:14: error: implicit declaration 
of function ‘dev_is_dma_coherent’; did you mean 
‘etnaviv_is_dma_coherent’? [-Werror=implicit-function-declaration]
    56 |   coherent = dev_is_dma_coherent(dev);
       |              ^~~~~~~~~~~~~~~~~~~


>   You're only adding a
> new reference to priv->dma_coherent, which looks like it was added to
> etnaviv_drv.h.
>
>>   #include <linux/module.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>> @@ -164,6 +165,10 @@ int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value)
>>   		*value = gpu->identity.eco_id;
>>   		break;
>>   
>> +	case ETNAVIV_PARAM_GPU_COHERENT:
>> +		*value = priv->dma_coherent;
>> +		break;
>> +
>>   	default:
>>   		DBG("%s: invalid param: %u", dev_name(gpu->dev), param);
>>   		return -EINVAL;
>> @@ -1861,7 +1866,7 @@ static int etnaviv_gpu_register_irq(struct etnaviv_gpu *gpu, int irq)
>>   
>>   	gpu->irq = irq;
>>   
>> -	dev_info(dev, "IRQ handler registered, irq = %d\n", irq);
>> +	dev_info(dev, "irq(%d) handler registered\n", irq);
> Looks possibly unnecessary, or at least unrelated to this patch.

Indeed, catched by you again.

>>   	return 0;
>>   }

-- 
Jingfeng

