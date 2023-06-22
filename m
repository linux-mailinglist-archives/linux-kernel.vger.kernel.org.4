Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53B773A996
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjFVUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFVUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:38:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1B5FD3;
        Thu, 22 Jun 2023 13:38:37 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxHMdMsZRk8IwAAA--.951S3;
        Fri, 23 Jun 2023 04:38:36 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Ax8uRKsZRkR4oCAA--.14009S3;
        Fri, 23 Jun 2023 04:38:34 +0800 (CST)
Message-ID: <02d6f220-b457-b980-8623-8da636cb495c@loongson.cn>
Date:   Fri, 23 Jun 2023 04:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm: gem: add an option for supporting the dma-coherent
 hardware.
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230607053053.345101-1-suijingfeng@loongson.cn>
 <d4378aad1cf179d308068ef6072c5c7ff2bf2502.camel@crapouillou.net>
 <6db23d14-652e-4b13-24cb-bfb92fa3faed@loongson.cn>
 <e9714a0c29b1c4268081827571ad2545b0e6d5ec.camel@crapouillou.net>
 <d5494751-0af0-42f6-bcad-f75415e4a6bd@loongson.cn>
 <2dd4c870a5605a79105fb621c97a5f59a18c8c24.camel@crapouillou.net>
 <ae085320-c93c-5d96-58ef-c5ee8b58c306@loongson.cn>
 <i2odidvev3ztxit4iv4ndxcuk4opckgs5fg4jjjfrq5nike35u@mlo7hshexe2n>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <i2odidvev3ztxit4iv4ndxcuk4opckgs5fg4jjjfrq5nike35u@mlo7hshexe2n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax8uRKsZRkR4oCAA--.14009S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyDZF4kArWfKF15JryktFc_yoWfuFyrpF
        W5KF4jkF4DXryrKw1jkw4UZFyYyayrJFy5Wr1DJ34Ik3s0yF10gr17Kr15uFyDJr10gF40
        vrWYvFyxuF1DAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
        XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
        WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
        7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
        4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/8 15:39, Maxime Ripard wrote:
> On Thu, Jun 08, 2023 at 01:18:38AM +0800, Sui Jingfeng wrote:
>> Hi,
>>
>> On 2023/6/8 00:12, Paul Cercueil wrote:
>>> Hi Sui,
>>>
>>> Le mercredi 07 juin 2023 à 22:38 +0800, Sui Jingfeng a écrit :
>>>> Hi,  welcome to discussion.
>>>>
>>>>
>>>> I have limited skills in manipulating English.
>>>>
>>>> It may not express what I'm really means in the short time.
>>>>
>>>> Part of word in the sentence may not as accurate as your.
>>>>
>>>> Well, please don't misunderstand, I'm not doing the rude to you.
>>> No problem.
>>>
>>>> I will explain it with more details.
>>>>
>>>> See below:
>>>>
>>>>
>>>> On 2023/6/7 20:09, Paul Cercueil wrote:
>>>>> Hi Sui,
>>>>>
>>>>> Le mercredi 07 juin 2023 à 18:30 +0800, Sui Jingfeng a écrit :
>>>>>> Hi,
>>>>>>
>>>>>>
>>>>>> On 2023/6/7 17:36, Paul Cercueil wrote:
>>>>>>> Hi Sui,
>>>>>>>
>>>>>>> Le mercredi 07 juin 2023 à 13:30 +0800, Sui Jingfeng a écrit :
>>>>>>>> The single map_noncoherent member of struct
>>>>>>>> drm_gem_dma_object
>>>>>>>> may
>>>>>>>> not
>>>>>>>> sufficient for describing the backing memory of the GEM
>>>>>>>> buffer
>>>>>>>> object.
>>>>>>>>
>>>>>>>> Especially on dma-coherent systems, the backing memory is
>>>>>>>> both
>>>>>>>> cached
>>>>>>>> coherent for multi-core CPUs and dma-coherent for peripheral
>>>>>>>> device.
>>>>>>>> Say architectures like X86-64, LoongArch64, Loongson Mips64,
>>>>>>>> etc.
>>>>>>>>
>>>>>>>> Whether a peripheral device is dma-coherent or not can be
>>>>>>>> implementation-dependent. The single map_noncoherent option
>>>>>>>> is
>>>>>>>> not
>>>>>>>> enough
>>>>>>>> to reflect real hardware anymore. For example, the Loongson
>>>>>>>> LS3A4000
>>>>>>>> CPU
>>>>>>>> and LS2K2000/LS2K1000 SoC, peripheral device of such hardware
>>>>>>>> platform
>>>>>>>> allways snoop CPU's cache. Doing the allocation with
>>>>>>>> dma_alloc_coherent
>>>>>>>> function is preferred. The return buffer is cached, it should
>>>>>>>> not
>>>>>>>> using
>>>>>>>> the default write-combine mapping. While with the current
>>>>>>>> implement,
>>>>>>>> there
>>>>>>>> no way to tell the drm core to reflect this.
>>>>>>>>
>>>>>>>> This patch adds cached and coherent members to struct
>>>>>>>> drm_gem_dma_object.
>>>>>>>> which allow driver implements to inform the core. Introducing
>>>>>>>> new
>>>>>>>> mappings
>>>>>>>> while keeping the original default behavior unchanged.
>>>>>>> Did you try to simply set the "dma-coherent" property to the
>>>>>>> device's
>>>>>>> node?
>>>>>> But this approach can only be applied for the device driver with
>>>>>> DT
>>>>>> support.
>>>>>>
>>>>>> X86-64, Loongson ls3a4000 mips64, Loongson ls3a5000 CPU typically
>>>>>> do
>>>>>> not
>>>>>> have DT support.
>>>>>>
>>>>>> They using ACPI to pass parameter from the firmware to Linux
>>>>>> kernel.
>>>>>>
>>>>>> You approach will lost the effectiveness on such a case.
>>>>> Well, I don't really know how ACPI handles it - but it should just
>>>>> be a
>>>>> matter of setting dev->dma_coherent. That's basically what the DT
>>>>> code
>>>>> does.
>>>>>
>>>>> Some MIPS boards set it in their setup code for instance.
>>>>>
>>>> This is a *strategy*, not a *mechanism*.
>>>>
>>>> In this case, DT is just used to describing the hardware.
>>>>
>>>> (It is actually a hardware feature describing language, the
>>>> granularity
>>>> is large)
>>>>
>>>> It does not changing the state of the hardware.
>>>>
>>>> It's your platform firmware or kernel setting up code who actually do
>>>> such a things.
>>>>
>>>>
>>>> It's just that it works on *one* platform, it does not guarantee it
>>>> will
>>>> works on others.
>>> If you add the "dma-coherent" property in a device node in DT, you
>>> effectively specify that the device is DMA-coherent; so you describe
>>> the hardware, which is what DT is for, and you are not changing the
>>> state of the hardware.
>>>
>>> Note that some MIPS platforms (arch/mips/alchemy/common/setup.c)
>>> default to DMA-coherent mapping; I believe you could do something
>>> similar with your Loongson LS3A4000 CPU and LS2K2000/LS2K1000 SoC.
>>>
>> The preblem is that device driver can have various demand.
>>
>> It probably want to create different kind of buffers for different thing
>> simultaneously.
>>
>> Say, one allocated with dma_alloc_coherent for command buffer or dma
>> descriptor
>>
>> another one allocated with  dma_alloc_wc for uploading shader etc.
>>
>> also has the third one allocated with dma_alloc_noncoherent() for doing some
>> else.
> And it will work just fine.
>
> struct device dma_coherent, or DT's dma-coherent property define that
> the device doesn't need any kind of cache maintenance, ever. If it's
> missing, we need to perform cache maintenance to keep coherency.
>
> dma_alloc_* functions provide guarantees to the driver. With
> dma_alloc_wc and dma_alloc_coherent, the buffer is coherent, and thus
> you don't need to perform cache maintenance operations by hand in the
> driver.
>
> With dma_alloc_noncoherent, the buffer is non-coherent and the driver
> needs to perform them when relevant.
>
> How those buffers are created is platform specific, but the guarantees
> provided *to the driver* are always there.
>
> A buffer allocated with dma_alloc_coherent might be provided by
> different means (at the hardware level with a coherency unit, by mapping
> it non-cacheable), but as far as the driver is concerned it's always
> going to be coherent.
>
> Similarly, a driver using dma_alloc_noncoherent will always require
> cache maintenance operations to use the API properly, even if the
> hardware provides coherency (in which case, those operations will be
> nop).
>
> So, yeah, like I was saying in the other mail, it looks like you're
> confusing a bunch of things. dma_alloc_* functions are about the driver
> expectations and guarantees. DT's dma-coherent property is about how we
> can implement them on a given platform.
>
> They don't have to match, and that's precisely how we can have drivers
> that run on any combination of platforms: the driver only cares about
> the buffer guarantees, the platform description takes care of how they
> are implemented.

You are right in overall.

Yeah, you have better understanding than me.


But let me give you an example which may made people confusing:


The the drm/ingenic and drm/etnaviv (KMS-RO) as an example:



when drm/etnaviv's etnaviv_gem_prime_import_sg_table() function get called,

drm/etnaviv is importing buffer from drm/ingenic.

drm/etnaviv is the importer, and drm/ingenic is the exporter.

drm/ingenic choose non-coherent mapping by default for JZ4770(this is 
gc800 in it).

It's cached, for fast CPU software rendering.


While drm/etnaviv import the buffer, get the SG, using the WC mapping by 
default.

Dose this cause *cache aliasing* because of different driver using 
different cache

mapping for the same backing memory ?


Because the imported buffer originally belong to the KMS driver side.

For drm/ingenic(jz4770), the BO will be cached, but their hardware can't 
guarantee coherency.

when etnaviv finished the rendering, they will do the resolve.

By using the WC mapping, the GPU will write directly to the system RAM.


1)

If CPU flush the cache back to the system RAM(framebuffer when running 
glmark-es2-drm).

then the image(resolved by GPU) in framebuffer will be overwrite by the 
stall data in the cache.


2)

Think about occasions when we need the CPU to do the read access to the 
rendered image.

(snap shoot, or using with X server fake EXA)

The CPU still think the share buffer as cached, it will read from the 
cache if hit.

while GPU write to RAM directly by using WC mapping.


Even it call dma_sync_single_for_device(), it only get SYNC-ed for the 
device.

there is no SYNC for the CPU's cached.

I think, In the end, it will lost of coherency.


3)

If the user want to use X server graphic environment,

then the case will be more complex for 3D acceleration support.


Even it hacks somewhere to call the sync for CPU,

they still may need invalid the cache frequently.

In this case, it will not get a good performance.


At any case,  such a KMS-RO combination((cached no-coherent + WC)) will 
be a misery./
/

While drm/ingenic could give up the hardware acceleration and the 3D 
acceleration in X environment.

it's OK, as its for low-ended graphic application.


But, at the other hand, it is say also why arm soc adhere to the 
write-combine.

because they have no choice.

While ingenic is the first exception, thanks Paul's patch which help us 
to understand a lot thing .


4)

While Loongson LS2K1000 SoC is DMA-coherent,

We are also prefer cached framebuffer for fast CPU software rendering.

I also get the hardware accelerated 3D works successfully,

even only for the GL client (such as glxgears and glmark2).


Therefore, on our hardware platform.

I force both the KMS driver and RO drivers to use cached mapping.

with the hardware maintained cache coherence blessing us.

It turn out that is works.


We don't need ( and don't want ) to call the dma_sync_*() series function,

not because we don't know it is no-op for DMA-coherent.

It is because that we realized that it is not needed with 100% confident.


We want to keep the code clean.

We are ZERO tolerate to the not needed function calls.


> Maxime

-- 
Jingfeng

