Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1AA738721
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFUOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjFUOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:35:46 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1E4D1FCE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 07:35:26 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxHMetCpNkPykAAA--.302S3;
        Wed, 21 Jun 2023 22:35:25 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM6sCpNkC8kAAA--.4736S3;
        Wed, 21 Jun 2023 22:35:24 +0800 (CST)
Message-ID: <ab17a1e6-c621-9a92-73fc-8b762fd0800e@loongson.cn>
Date:   Wed, 21 Jun 2023 22:35:24 +0800
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
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <0f1095ef333da7ea103486a1121ca9038815e57c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvM6sCpNkC8kAAA--.4736S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tF1fJry8AFWxury8Gw1Dtwc_yoW8Kr13pF
        WjyFySyryDWa4F9w12vw4rXr1xZr4IyrWY9rn8Jryq9wn09r9YqasrKr1Yka42g3Wvya10
        vw4jqa47uFs5ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r4a6rW5MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
        6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        yCJPUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/21 22:00, Lucas Stach wrote:
> Am Mittwoch, dem 21.06.2023 um 21:31 +0800 schrieb Sui Jingfeng:
>> On 2023/6/21 18:23, Lucas Stach wrote:
>>>> While back to the question you ask, I want etnaviv_create_platform_device() to be generic,
>>>>
>>>> can be used by multiple place for multiple purpose.
>>>>
>>>> I have successfully copy this to a another drm driver by simply renaming.
>>>>
>>>> The body of the function itself does not need to change.
>>> But it isn't shared,
>> This can be shared for drm/etnaviv in the future,
>>
>> currently, we just need an opportunity to use this function.
>>
> I'm not convinced, yet.
>
>> I want to create a dummy platform device,
>>
>> let this dummy platform be bound to the single PCI GPU master.
>>
>>
>> etnaviv_create_platform_device("dummy", &dummy_device);
>>
>>
>> 1) To verify the component code path on PCI case.
>>
> My favorite option would be to just always use the component path even
> when the GPU is on a PCI device to keep both paths mostly aligned. One
> could easily image both a 3D and a 2D core being made available though
> the same PCI device.

Component is for something that is possible not available. (or something 
is optional)

Yes it provided flexibly, but don't forget, it rely on the DT.


But for the PCIe device, it always the case that all of the hardware is 
available at the same time

when the device driver(kernel module) is loaded.


>> 2) Possibly for create a device for some other tiny hardware logic
>> come with the platform
>>
> Do you have something in mind here? Until now I assumed that only the
> GPU core is behind the PCI abstraction. Is there something else sharing
> the MMIO space?

A display controller, HDMI phy, vga encoder etc


I have a discrete PCIe GPU card from another vendor,

It integrated display controller and vivante GPU and unknown VPUs.

All of the  hardware block mentioned above sharing the MMIO space.

There are available on the same time when you mount this discrete PCIe 
GPU card on the mother board

>
> Regards,
> Lucas
>
>> 3) Revival component_compare_dev_name() function.
>>
>>> in this compilation unit this function is specific
>>> to the etnaviv driver and I don't see why we shouldn't have etnaviv
>>> specifics in there if it makes the code of this driver easier to
>>> follow.

-- 
Jingfeng

