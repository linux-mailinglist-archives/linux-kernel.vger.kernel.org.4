Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72E5738B60
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFUQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:33:58 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 465B5199D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:33:30 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Dx+8Y+JpNkyDMAAA--.375S3;
        Thu, 22 Jun 2023 00:33:02 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxvM49JpNkx+oAAA--.5470S3;
        Thu, 22 Jun 2023 00:33:01 +0800 (CST)
Message-ID: <c8b4697d-733b-f4f0-fbf0-98ee9bb6d3e8@loongson.cn>
Date:   Thu, 22 Jun 2023 00:33:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 07/11] drm/etnaviv: Add support for the dma coherent
 device
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
 <20230620094716.2231414-8-18949883232@163.com>
 <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
 <aa73348d-5ec8-4ac0-2ec0-0cce24756c63@loongson.cn>
 <87c9576e6ca1b58fa94e0bc1a2f4be3847f0518c.camel@pengutronix.de>
 <9c8afcb4-70c0-a920-2a78-78a9ac884c80@loongson.cn>
 <737b07582ef2a4b2f134a1a931b6621ff96adb77.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <737b07582ef2a4b2f134a1a931b6621ff96adb77.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxvM49JpNkx+oAAA--.5470S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr43Zw4DAw48Jr1fGFyrKrX_yoW8Kr43pF
        WDta4YyrWUXr10gw12qw15ZFy3K34fXF929rnrGwn09390yryUKFyrKF45CF90vr18Gr12
        vFs0qryxXF9ayrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_ZF0_GFyUMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/22 00:12, Lucas Stach wrote:
> Am Mittwoch, dem 21.06.2023 um 23:41 +0800 schrieb Sui Jingfeng:
>> On 2023/6/21 23:23, Lucas Stach wrote:
>>> Am Mittwoch, dem 21.06.2023 um 22:44 +0800 schrieb Sui Jingfeng:
>>>> Hi,
>>>>
>>>> On 2023/6/21 18:00, Lucas Stach wrote:
>>>>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>>>> index 9cd72948cfad..644e5712c050 100644
>>>>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>>>> @@ -46,6 +46,12 @@ struct etnaviv_drm_private {
>>>>>>     	struct xarray active_contexts;
>>>>>>     	u32 next_context_id;
>>>>>>     
>>>>>> +	/*
>>>>>> +	 * If true, the GPU is capable of snooping cpu cache. Here, it
>>>>>> +	 * also means that cache coherency is enforced by the hardware.
>>>>>> +	 */
>>>>>> +	bool dma_coherent;
>>>>>> +
>>>>> No need for this, I think. Just use dev_is_dma_coherent() where you
>>>>> need to know this.
>>>>>
>>>> No, we want this value cached by the driver.
>>>>
>>> Why? dev_is_dma_coherent() is a header-only function with a single
>>> pointer chasing operation. Your cache is also a single pointer chasing
>>> access, just that we now need storage for this information in both
>>> struct device and struct etnaviv_gpu.
>>
>> You don't need store it in struct etnaviv_gpu.
>>
>> As this variable is shared across the device, so it is better to be put
>> in the struct etnaviv_drm_private.
>>
>> I don't think another 4 bytes allocation is something what we can't pay for.
>>
>>
>> My patch doesn't mentioned that it need to store it inside of struct
>> etnaviv_gpu, do I?
> You are right, I was mistaken about the etnaviv struct this is added
> to. However there is still the fundamental question: what's the gain of
> this cache?

Clearness and short

you approach need to de-reference the pointer struct device *dev every 
time you need to fetch its value.

my name is short, typing it is less time-consuming

>   The information is already available in struct device and
> will be accessed with the same amount of loads if you care that much
> about micro-optimization.

I don't want call it everywhere, its too long.

What if the function you recommend get expanded by some programmer someday?

> Regards,
> Lucas

-- 
Jingfeng

