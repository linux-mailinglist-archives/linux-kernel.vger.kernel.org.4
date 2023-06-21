Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DC17389F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjFUPma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjFUPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:42:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE2819B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:41:50 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxZ8UhGpNkGy0AAA--.323S3;
        Wed, 21 Jun 2023 23:41:21 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxF80hGpNkvN4AAA--.2969S3;
        Wed, 21 Jun 2023 23:41:21 +0800 (CST)
Message-ID: <9c8afcb4-70c0-a920-2a78-78a9ac884c80@loongson.cn>
Date:   Wed, 21 Jun 2023 23:41:21 +0800
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
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <87c9576e6ca1b58fa94e0bc1a2f4be3847f0518c.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF80hGpNkvN4AAA--.2969S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWkuw48tF43Ww15AF1fGrX_yoW8WryDpF
        4UGFyFyrWUXr10grnFqw45XF13Kw13XFWI9wnrJwn0v3s0yryUtrn5Kr45CF9Yqw1fGr1a
        va90gFyxZF92yFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26rWY6Fy7MI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j
        6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        m0P3UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/21 23:23, Lucas Stach wrote:
> Am Mittwoch, dem 21.06.2023 um 22:44 +0800 schrieb Sui Jingfeng:
>> Hi,
>>
>> On 2023/6/21 18:00, Lucas Stach wrote:
>>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>> index 9cd72948cfad..644e5712c050 100644
>>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>>>> @@ -46,6 +46,12 @@ struct etnaviv_drm_private {
>>>>    	struct xarray active_contexts;
>>>>    	u32 next_context_id;
>>>>    
>>>> +	/*
>>>> +	 * If true, the GPU is capable of snooping cpu cache. Here, it
>>>> +	 * also means that cache coherency is enforced by the hardware.
>>>> +	 */
>>>> +	bool dma_coherent;
>>>> +
>>> No need for this, I think. Just use dev_is_dma_coherent() where you
>>> need to know this.
>>>
>> No, we want this value cached by the driver.
>>
> Why? dev_is_dma_coherent() is a header-only function with a single
> pointer chasing operation. Your cache is also a single pointer chasing
> access, just that we now need storage for this information in both
> struct device and struct etnaviv_gpu.


You don't need store it in struct etnaviv_gpu.

As this variable is shared across the device, so it is better to be put 
in the struct etnaviv_drm_private.

I don't think another 4 bytes allocation is something what we can't pay for.


My patch doesn't mentioned that it need to store it inside of struct 
etnaviv_gpu, do I?

> Regards,
> Lucas
>
>> We only need call  dev_is_dma_coherent() once!
>>
>> We need to reuse this variable on other places.
>>
-- 
Jingfeng

