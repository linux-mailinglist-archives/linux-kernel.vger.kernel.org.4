Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4D5738CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjFURV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFURV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:21:56 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EB7FE42
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:21:47 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxS8apMZNkzDcAAA--.378S3;
        Thu, 22 Jun 2023 01:21:45 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxrM6oMZNkgPYAAA--.5641S3;
        Thu, 22 Jun 2023 01:21:44 +0800 (CST)
Message-ID: <fd5dd250-b01e-fd00-1419-88398cb13347@loongson.cn>
Date:   Thu, 22 Jun 2023 01:21:44 +0800
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
 <66fc74ae-299c-a5de-9cfb-07ae24fb3f07@loongson.cn>
 <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <8212078bd56c54ce508205eae0ed0b69e78d4c38.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxrM6oMZNkgPYAAA--.5641S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoWxuFyUCFyrCw43WF1kuw47WrX_yoW5tw1rpF
        W3AFyYyrWUXryUKw1Iv3Z8Zw1Sgr4xXFyxZasxJwn09ws0vFy7GF1rKF1UCFs8GryfCr4Y
        qFWj9ry3JF18ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
        kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
        twAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
        k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
        4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_ZF0_GFyUMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
        IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RuWPUUUU
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

Again,

this is user-space things!

this is user-space things!

this is user-space things!

I have explained several times.

made the decision for the user-space program is wrong.


> It allows
> userspace to use WC mappings that would potentially cause loss of
> coherency between CPU and GPU, which isn't acceptable.

Before made the WC works correctly,  you need the developing environment.

userspace program can tune the BO cache mapping easily.

Either environment or supply a conf file.


While with your implement, we don't have the opportunity to do debugging 
and the development.

The kernel space is writing hard-code.


> Regards,
> Lucas

-- 
Jingfeng

