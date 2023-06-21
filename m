Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323F5738A89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjFUQMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjFUQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:12:14 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB197F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:12:10 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxS8ZYIZNkTDAAAA--.339S3;
        Thu, 22 Jun 2023 00:12:08 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM5XIZNkouUAAA--.5363S3;
        Thu, 22 Jun 2023 00:12:08 +0800 (CST)
Message-ID: <1f1ab625-fa99-7f0c-6d2f-e19c88b2b43b@loongson.cn>
Date:   Thu, 22 Jun 2023 00:12:07 +0800
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
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        etnaviv@lists.freedesktop.org
References: <20230620094716.2231414-1-18949883232@163.com>
 <20230620094716.2231414-4-18949883232@163.com>
 <0daa7182d6600a24988d1c81cf8fe3c0c9487f52.camel@pengutronix.de>
 <1c7596fd-7e63-6719-2574-7d7820687832@loongson.cn>
 <6d287bbb1733814009dfeb7d48f08cb6f44dc56c.camel@pengutronix.de>
 <30d80802-2d9d-2816-1a02-240145f6dd3a@loongson.cn>
 <0f1095ef333da7ea103486a1121ca9038815e57c.camel@pengutronix.de>
 <ab17a1e6-c621-9a92-73fc-8b762fd0800e@loongson.cn>
 <6ef512179a4cc9ce24890e5ed50c6fabd86a18c1.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <6ef512179a4cc9ce24890e5ed50c6fabd86a18c1.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvM5XIZNkouUAAA--.5363S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF17XF4UuryDXryUKw4rJFc_yoWrCw1DpF
        WUtFyYkrWDCF1Ivw12qw4rXr10vw4rA34Yqr15Jryjkwn0vryfXrW7t3W5CasxtF1kta10
        vr4jvrWxCFs8AagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWrXVW3AwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m2NtUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023/6/21 23:20, Lucas Stach wrote:
> Am Mittwoch, dem 21.06.2023 um 22:35 +0800 schrieb Sui Jingfeng:
>> Hi,
>>
>> On 2023/6/21 22:00, Lucas Stach wrote:
>>> Am Mittwoch, dem 21.06.2023 um 21:31 +0800 schrieb Sui Jingfeng:
>>>> On 2023/6/21 18:23, Lucas Stach wrote:
>>>>>> While back to the question you ask, I want etnaviv_create_platform_device() to be generic,
>>>>>>
>>>>>> can be used by multiple place for multiple purpose.
>>>>>>
>>>>>> I have successfully copy this to a another drm driver by simply renaming.
>>>>>>
>>>>>> The body of the function itself does not need to change.
>>>>> But it isn't shared,
>>>> This can be shared for drm/etnaviv in the future,
>>>>
>>>> currently, we just need an opportunity to use this function.
>>>>
>>> I'm not convinced, yet.
>>>
>>>> I want to create a dummy platform device,
>>>>
>>>> let this dummy platform be bound to the single PCI GPU master.
>>>>
>>>>
>>>> etnaviv_create_platform_device("dummy", &dummy_device);
>>>>
>>>>
>>>> 1) To verify the component code path on PCI case.
>>>>
>>> My favorite option would be to just always use the component path even
>>> when the GPU is on a PCI device to keep both paths mostly aligned. One
>>> could easily image both a 3D and a 2D core being made available though
>>> the same PCI device.
>> Component is for something that is possible not available. (or something
>> is optional)
>>
>> Yes it provided flexibly, but don't forget, it rely on the DT.
> The component framework itself doesn't rely on DT in any way.

Yes I know that, for example the HDMI audio stuff.

But *your implement* do rely on the DT, this is the point

> By
> providing a appropriate match function you can make it work with any
> kind of device.
Yes, you are right.
>   In fact etnaviv supports platform devices instantiated
> via board code today.
Nice,
>   They don't need to come from DT.
What about the various clock, sir?
> If we could make the PCI stuff work the same way, that would be my
> preferred option.
>
>>
>> But for the PCIe device, it always the case that all of the hardware is
>> available at the same time
>>
>> when the device driver(kernel module) is loaded.
> That isn't the issue solved by the component framework. On the existing
> SoCs all the hardware is available when the driver is probed. The
> component framework just makes sure that we only expose the DRM device
> after all GPU cores that should be managed by a single DRM device
> instance are probed.
>
> One could easily image a PCI device that containing a 2D and a 3D
> Vivante GPU that should be made available through a single DRM device.
> In that case you'll also need to use the component framework.
>
>>
>>>> 2) Possibly for create a device for some other tiny hardware logic
>>>> come with the platform
>>>>
>>> Do you have something in mind here? Until now I assumed that only the
>>> GPU core is behind the PCI abstraction. Is there something else sharing
>>> the MMIO space?
>> A display controller, HDMI phy, vga encoder etc
>>
>>
>> I have a discrete PCIe GPU card from another vendor,
>>
>> It integrated display controller and vivante GPU and unknown VPUs.
>>
>> All of the  hardware block mentioned above sharing the MMIO space.
>>
>> There are available on the same time when you mount this discrete PCIe
>> GPU card on the mother board
>>
> But they surely should not all be made available through the etnaviv
> driver. Etnaviv deals with the Vivante GPUs. If you have a PCI device
> with multiple IP cores behind the shared MMIO space you should have a
> PCI driver instantiating platform devices so the respective drivers for
> those IP cores can bind to the platform device.

I have only one PCI device, let start from the simple case, OK?

I admire your fantastic idea.

let deal with it another patch in the future if such hardware emerged.

Accept the current implement, please ?

>   Etnaviv is not that
> driver.

Yeah, but I notice that there is chipFeatures_DC defined in common.xml.h

I don't know how does this going to used, if a hardware marked it as true.

> Regards,
> Lucas
>
>>> Regards,
>>> Lucas
>>>
>>>> 3) Revival component_compare_dev_name() function.
>>>>
>>>>> in this compilation unit this function is specific
>>>>> to the etnaviv driver and I don't see why we shouldn't have etnaviv
>>>>> specifics in there if it makes the code of this driver easier to
>>>>> follow.

-- 
Jingfeng

