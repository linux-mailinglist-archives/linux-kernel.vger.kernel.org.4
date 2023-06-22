Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62BD73A8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjFVT03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFVT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:26:27 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B3171BC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:26:25 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8DxvsdfoJRk0IcAAA--.903S3;
        Fri, 23 Jun 2023 03:26:23 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c5eoJRksncCAA--.13556S3;
        Fri, 23 Jun 2023 03:26:22 +0800 (CST)
Message-ID: <9f3c3a81-1aca-a36e-8090-d851ea5ce9f7@loongson.cn>
Date:   Fri, 23 Jun 2023 03:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 07/11] drm/etnaviv: Add support for the dma coherent
 device
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
 <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
 <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Cx_c5eoJRksncCAA--.13556S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gry5tFWrCF48AF45ZrWfXrc_yoWxXw15pF
        WavFWYkr4DXrW8Kw1Ivw45Za4S9w4xXFy8Cw1DJwn0vws0kF1j9r4rKF15CFs8GryxWr4a
        vr4jvFyUWF4kZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Jr0_Gr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
        x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
        McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
        I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
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

On 2023/6/21 23:58, Lucas Stach wrote:
> Am Mittwoch, dem 21.06.2023 um 23:30 +0800 schrieb Sui Jingfeng:
>> Hi,
>>
>> On 2023/6/21 18:00, Lucas Stach wrote:
>>>>    		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
>>>>    					 etnaviv_op_to_dma_dir(op));
>>>>    		etnaviv_obj->last_cpu_prep_op = op;
>>>> @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>>>>    {
>>>>    	struct drm_device *dev = obj->dev;
>>>>    	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>>>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>>>    
>>>> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
>>>> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>>>>    		/* fini without a prep is almost certainly a userspace error */
>>>>    		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>>>>    		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
>>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>>>> index 3524b5811682..754126992264 100644
>>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>>>> @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>>>>    struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>>>    	struct dma_buf_attachment *attach, struct sg_table *sgt)
>>>>    {
>>>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>>>    	struct etnaviv_gem_object *etnaviv_obj;
>>>>    	size_t size = PAGE_ALIGN(attach->dmabuf->size);
>>>> +	u32 cache_flags = ETNA_BO_WC;
>>>>    	int ret, npages;
>>>>    
>>>> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
>>>> +	if (priv->dma_coherent)
>>>> +		cache_flags = ETNA_BO_CACHED;
>>>> +
>>> Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
>>> from WC to CACHED as necessary by adding something like this:
>> I understand you are a profession person in vivante GPU driver domain.
>>
>> I respect you reviews and instruction.
>>
>> But, I'm really reluctant to agree with this, is there any space to
>> negotiate?
>>
>>> /*
>>>    * Upgrade WC to CACHED when the device is hardware coherent and the
>>>    * platform doesn't allow mixing cached and writecombined mappings to
>>>    * the same memory area.
>>>    */
>>> if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
>>>       dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
>>>           flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;
>> This is policy, not a mechanism.
>>
>> Using what cache property is a user-space program's choice.
>>
>> While you are override the WC with CACHED mapping. This is not correct
>> in the concept!
>>
> Please explain why you think that this isn't correct.

This is NOT always correct because:

when etnaviv_gem_prime_import_sg_table() is called,

drm/etnaviv is importing buffer from other drivers (for example drm/loongson or drm/ingenic).

drm/etnaviv is the importer, and drm/loongson or drm/ingenic is the exporter.


While drm/etnaviv using the WC mapping by default, which may cause *cache aliasing*,


Because the imported buffer originally belong to the KMS driver side.

The KMS driver may choose cached mapping by default.


For drm/ingenic(jz4770), the BO will be cached, but their hardware can't guarantee coherency.

they have to flush the cache manually when do the frame buffer update(damage update or dirty update).

Because cached mapping is more fast than the WC mapping.




For drm/loongson, shared buffer have to pinned into GTT,

By default, we using the cached mapping for the buffers in the system RAM;

But we are lucky, our the hardware bless us,

the hardware maintain the cache coherency for us.


While drm/etnaviv choose the WC mapping for the imported buffer blindly,

when doing the import,

*drm/etnaviv know nothing about the original buffer's caching property.*

This is the problem.


Currently, I guess drm/etnaviv only works for drm/imx,

because drm/imx choose WC mapping as the cache property by default for 
the dumb buffer.

The cache property mapping match, so it works.

But their no communications between the KMS driver and RO driver.


I think, drm/etanviv will also wrong on the ARM64 platforms where cache 
coherency is maintained by the hardware.

If the KMS driver using cached mapping, while drm/etnaviv using WC mapping,

There still will have problems.

I will go to find the hardware, and do the testing for you.


> If using WC
> mappings cause a potential loss of coherency on your platform, then we
> can not allow the userspace driver to use WC mappings.

I have explained with my broken English,

The point is that loss of coherency may because KMS-RO framework have 
defect,

maybe software side bug, please don't make the conclusion too fast.


Xorg DDX driver (EXA base DDX for an example) fallback to the CPU do the 
software rendering.

It is even faster than the hardware accelerated implement,

especially in the case where the CPU is fast and the GPU is weak.

LS7A1000(GC1000) + LS3A5000@2.5Ghz X4 core is such a case.

For Discrete on-board VRAM we will using the WC mapping, it will not be 
shared with other driver,

The CPU use it themself, this is definitionally OK.

In practice, it works like a charm.

For buffers in the system RAM and GTT,

We will using cached mapping for faster CPU software rendering.

hard-coded by the driver.


We are benefited so much from the cached mapping.

While when using write-combine caching mapping for a buffer on LoongArch 
and Loongson Mips CPU,

It is OK for CPU write.

But when you want read from such buffer by the CPU, it is just boil down 
to uncached.

For our platform, uncached read serve as a kind of SYNC.

It will flush the data in the CPU's write buffer.

This cause performance drop.


But we still can use the write-combine caching mapping in the 
circumstances where do not need the CPU read.

So allow write-combine is providing one more choice to the user-space,

It is just that use it at your own risk.


> As I would like to keep the option of WC mappings,

Yeah, I know what's reason.

Because on the platform you love (imx6q, imx8q, for an example),

The hardware don't maintain the cache coherency.

So if fallback to software rendering, you will need to flush the cache frequency.

the performance will drop very much, right?


-- 
Jingfeng

