Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAC738923
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjFUPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjFUPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:30:24 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA805E68
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 08:30:06 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxxvB9F5NkcCwAAA--.341S3;
        Wed, 21 Jun 2023 23:30:05 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c58F5Nkd9sAAA--.5186S3;
        Wed, 21 Jun 2023 23:30:04 +0800 (CST)
Message-ID: <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
Date:   Wed, 21 Jun 2023 23:30:04 +0800
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
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <8f74f0962c8bab6c832919a5340667c54e1a7ddc.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx_c58F5Nkd9sAAA--.5186S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFyxCF4Uur4UKryrAF47Awc_yoW5Ww45pF
        WfAFyYyrWUXrWUK397Zan8Za4Fgr47W34Iyas8J3Z09w4YyF4qkF1rKFy5CFs8GryfCr1a
        qa1j9ry5XF48ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
        xGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
        I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26rWY6Fy7MI8I3I0E5I8CrV
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

On 2023/6/21 18:00, Lucas Stach wrote:
>>   		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
>>   					 etnaviv_op_to_dma_dir(op));
>>   		etnaviv_obj->last_cpu_prep_op = op;
>> @@ -408,8 +421,9 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>>   {
>>   	struct drm_device *dev = obj->dev;
>>   	struct etnaviv_gem_object *etnaviv_obj = to_etnaviv_bo(obj);
>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>   
>> -	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
>> +	if (!priv->dma_coherent && etnaviv_obj->flags & ETNA_BO_CACHED) {
>>   		/* fini without a prep is almost certainly a userspace error */
>>   		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
>>   		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> index 3524b5811682..754126992264 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
>> @@ -112,11 +112,16 @@ static const struct etnaviv_gem_ops etnaviv_gem_prime_ops = {
>>   struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_device *dev,
>>   	struct dma_buf_attachment *attach, struct sg_table *sgt)
>>   {
>> +	struct etnaviv_drm_private *priv = dev->dev_private;
>>   	struct etnaviv_gem_object *etnaviv_obj;
>>   	size_t size = PAGE_ALIGN(attach->dmabuf->size);
>> +	u32 cache_flags = ETNA_BO_WC;
>>   	int ret, npages;
>>   
>> -	ret = etnaviv_gem_new_private(dev, size, ETNA_BO_WC,
>> +	if (priv->dma_coherent)
>> +		cache_flags = ETNA_BO_CACHED;
>> +
> Drop this change. Instead etnaviv_gem_new_impl() should do the upgrade
> from WC to CACHED as necessary by adding something like this:

I understand you are a profession person in vivante GPU driver domain.

I respect you reviews and instruction.

But, I'm really reluctant to agree with this, is there any space to 
negotiate?

> /*
>   * Upgrade WC to CACHED when the device is hardware coherent and the
>   * platform doesn't allow mixing cached and writecombined mappings to
>   * the same memory area.
>   */
> if ((flags & ETNA_BO_CACHE_MASK) == ETNA_BO_WC &&
>      dev_is_dma_coherent(dev) && !drm_arch_can_wc_memory())
>          flags = (flags & ~ETNA_BO_CACHE_MASK) & ETNA_BO_CACHED;

This is policy, not a mechanism.

Using what cache property is a user-space program's choice.

While you are override the WC with CACHED mapping. This is not correct 
in the concept!

you approach forbidden any possibility to use the WC BO at anywhere.


My approach need only check once, while you approach need at least 3 
check plus

so much bit-wise logic operations,  plus a function call  (&, ==, &&,  
&, ~, &) .

and every time you create a BO. This nasty judgement happens.


Please keep our original implement, it's simple and clear, Please?


-- 
Jingfeng

