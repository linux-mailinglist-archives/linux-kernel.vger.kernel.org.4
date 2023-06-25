Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD573CE5E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFYEEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFYEEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:04:21 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55BAD118
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:04:19 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxmMXBvJdkz2sBAA--.2234S3;
        Sun, 25 Jun 2023 12:04:17 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxzM69vJdkuDcGAA--.30336S3;
        Sun, 25 Jun 2023 12:04:13 +0800 (CST)
Message-ID: <abb7dc61-75e8-3e40-f449-37e7bb835bbf@loongson.cn>
Date:   Sun, 25 Jun 2023 12:04:13 +0800
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
 <2249b895-84b9-adea-531b-bf190e9c866f@loongson.cn>
 <030d44e2753b9b2eea0107cdee6c20e2bc2d3efe.camel@pengutronix.de>
 <3911d448-5613-23a8-cfcb-5ae418677338@loongson.cn>
 <87deb46db35b028da74c94f5496b721e14db4745.camel@pengutronix.de>
 <02c16e9b-0eca-caf4-b80c-53f1c7eab4e9@loongson.cn>
 <ba41b807e3af0a1cabb9ba203a401f41254cea1e.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <ba41b807e3af0a1cabb9ba203a401f41254cea1e.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxzM69vJdkuDcGAA--.30336S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWUtryfAFyxXrWxAF4kZrc_yoW5Kr4xpF
        sYkFyayrZ5uryvqwnFqw45Zry3tr4fJay5AFn8Ja4Y9ws0vr1SgF409r4j9F1UWws3Zr1j
        q3yqvwnxZFn8AFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j22NtUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/22 01:53, Lucas Stach wrote:
> Am Donnerstag, dem 22.06.2023 um 01:31 +0800 schrieb Sui Jingfeng:
>> Hi,
>>
>> On 2023/6/22 00:07, Lucas Stach wrote:
>>> And as the HW guarantees it on your platform, your platform
>>> implementation makes this function effectively a no-op. Skipping the
>>> call to this function is breaking the DMA API abstraction, as now the
>>> driver is second guessing the DMA API implementation. I really see no
>>> reason to do this.
>> It is the same reason you chose the word 'effectively', not 'difinitely'.
>>
>> We don't want waste the CPU's time,
>>
>>
>>    to running the dma_sync_sg_for_cpu funcion() function
>>
>>
>> ```
>>
>> void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
>>               int nelems, enum dma_data_direction dir)
>> {
>>       const struct dma_map_ops *ops = get_dma_ops(dev);
>>
>>       BUG_ON(!valid_dma_direction(dir));
>>       if (dma_map_direct(dev, ops))
>>           dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
>>       else if (ops->sync_sg_for_cpu)
>>           ops->sync_sg_for_cpu(dev, sg, nelems, dir);
>>       debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
>> }
>>
>> ```
>>
>>
>>    to running the this:
>>
>>
>> ```
>>
>> int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>> {
>>       struct drm_device *dev = obj->dev;
>>       struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>>       struct etnaviv_drm_private *priv = dev->dev_private;
>>
>>       if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>>           /* fini without a prep is almost certainly a userspace error */
>>           WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>>           dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
>> etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
>>           etnaviv_obj->last_cpu_prep_op = 0;
>>       }
>>
>>       return 0;
>> }
>>
>> ```
>>
> My judgment as the maintainer of this driver is that the small CPU
> overhead of calling this function is very well worth it, if the
> alternative is breaking the DMA API abstractions.
>
>> But, this is acceptable, because we can kill the GEM_CPU_PREP and
>> GEM_CPU_FINI ioctl entirely
>>
>> at userspace for cached buffer, as this is totally not needed for cached
>> mapping on our platform.
>>
> And that statement isn't true either.

Yes, you are right here. I admit.


Because I have suffered such problem in the past when developing 
xf86-video-loongson.

The root cause, I think,  is the CPU don't know when the GPU have 
finished the rendering.

Or there still some data reside in the GPU's cache.


We have to call etna_bo_cpu_prep(etna_bo, DRM_ETNA_PREP_READ) function

to make sure the  data fetch by CPU is the latest.


I realized this knowledge(issue) five month ago in this year, see [1] 
for reference.

I  just forget this thing when doing the debate with you.


[1] 
https://gitlab.freedesktop.org/longxin2019/xf86-video-loongson/-/commit/95f9596eb19223c3109ea1f32c3e086fd1d43bd8

||


>   The CPU_PREP/FINI ioctls also
> provide fence synchronization between CPU and GPU.

You are correct here.

> There are a few very
> specific cases where skipping those ioctls is acceptable (mostly when
> the userspace driver explicitly wants unsynchronized access), but in
> most cases they are required for correctness.

OK, you are extremely correct.

> Regards,
> Lucas

-- 
Jingfeng

