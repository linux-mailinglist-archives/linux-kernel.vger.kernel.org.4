Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51167383D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjFUMbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjFUMbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:31:40 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 137F1DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:31:36 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxlfCn7ZJkMiEAAA--.269S3;
        Wed, 21 Jun 2023 20:31:35 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX8+l7ZJkHp4AAA--.3630S3;
        Wed, 21 Jun 2023 20:31:33 +0800 (CST)
Message-ID: <06e4482e-5711-4d0f-043a-8aa78c7f0ec0@loongson.cn>
Date:   Wed, 21 Jun 2023 20:31:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 04/11] drm/etnaviv: Add helpers for private data
 construction and destruction
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
 <20230620094716.2231414-5-18949883232@163.com>
 <cba8ebe734aed53e74ddee2242526d10338cbafb.camel@pengutronix.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <cba8ebe734aed53e74ddee2242526d10338cbafb.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxX8+l7ZJkHp4AAA--.3630S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw13tFWkAw4fAFWrur43XFc_yoWxJw17pF
        s7AFyYyrWkZry0g3sFqrs8XasI9w4xWrW09asrt3Z0qwsIyr1vgFn5KryUCas3AFy5CF4S
        yw4UtrnrWF40krXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
        Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jb_-
        PUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/21 17:22, Lucas Stach wrote:
> Am Dienstag, dem 20.06.2023 um 17:47 +0800 schrieb Sui Jingfeng:
>> From: Sui Jingfeng <suijingfeng@loongson.cn>
>>
>> There are numerous members in the struct etnaviv_drm_private, which are
>> shared by all GPU core. This patch introduces two dedicated functions for
>> the construction and destruction of the instances of this structure.
>> The goal is to keep its members from leaking to the outside. The code
>> needed for error handling can also be simplified.
>>
>> Cc: Lucas Stach <l.stach@pengutronix.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.c | 73 +++++++++++++++++----------
>>   drivers/gpu/drm/etnaviv/etnaviv_drv.h |  1 +
>>   2 files changed, 47 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> index cec005035d0e..6a048be02857 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
>> @@ -24,9 +24,47 @@
>>   #include "etnaviv_perfmon.h"
>>   
>>   /*
>> - * DRM operations:
>> + * etnaviv private data construction and destructions:
>>    */
>> +static struct etnaviv_drm_private *
>> +etnaviv_alloc_private(struct device *dev, struct drm_device *drm)
>> +{
>> +	struct etnaviv_drm_private *priv;
>> +
>> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	priv->drm = drm;
> That's an unrelated change that you rely on in later patches. If this
> is needed at all it needs to be in a separate patch with a explanation
> on why it is needed.

It helps the etnaviv_drm_unbind() function fetch the pointer to the 
struct drm_device,

etnaviv_drm_unbind() became a pure function which don't need to 
reference external variables.


The real rationale is that when we made the single 3D GPU core the be 
the master device,

We no longer create the virtual master. We lost a place to store the 
pointer to

struct drm_device.

We have only one struct device across the whole driver.

There only one dev->driver_data instance in the whole driver,

The etnaviv_gpu_driver_create() function will call dev_set_drvdata(dev, gpu)

function to store the pointer to the instance(struct etnaviv_gpu).

The seat is taken, there is no where to store the pointer to struct 
drm_device.


As the drm is intended to be shared by all GPU core,

so, in the end, even for multiple GPU cores case,

this is still good thing, because the driver could fetch the pointer to 
the struct drm_device

via 'struct etnaviv_drm_private *', they are something in common, that 
is they are both

intended to be shared by the whole program.

> Regards,
> Lucas
>
>> +
>> +	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
>> +
>> +	mutex_init(&priv->gem_lock);
>> +	INIT_LIST_HEAD(&priv->gem_list);
>> +	priv->num_gpus = 0;
>> +	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>>   
>> +	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(dev);
>> +	if (IS_ERR(priv->cmdbuf_suballoc)) {
>> +		kfree(priv);
>> +		dev_err(dev, "Failed to create cmdbuf suballocator\n");
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	return priv;
>> +}
>> +
>> +static void etnaviv_free_private(struct etnaviv_drm_private *priv)
>> +{
>> +	if (!priv)
>> +		return;
>> +
>> +	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>> +
>> +	xa_destroy(&priv->active_contexts);
>> +
>> +	kfree(priv);
>> +}
>>   
>>   static void load_gpu(struct drm_device *dev)
>>   {
>> @@ -511,35 +549,21 @@ static int etnaviv_bind(struct device *dev)
>>   	if (IS_ERR(drm))
>>   		return PTR_ERR(drm);
>>   
>> -	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>> -	if (!priv) {
>> -		dev_err(dev, "failed to allocate private data\n");
>> -		ret = -ENOMEM;
>> +	priv = etnaviv_alloc_private(dev, drm);
>> +	if (IS_ERR(priv)) {
>> +		ret = PTR_ERR(priv);
>>   		goto out_put;
>>   	}
>> +
>>   	drm->dev_private = priv;
>>   
>>   	dma_set_max_seg_size(dev, SZ_2G);
>>   
>> -	xa_init_flags(&priv->active_contexts, XA_FLAGS_ALLOC);
>> -
>> -	mutex_init(&priv->gem_lock);
>> -	INIT_LIST_HEAD(&priv->gem_list);
>> -	priv->num_gpus = 0;
>> -	priv->shm_gfp_mask = GFP_HIGHUSER | __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
>> -
>> -	priv->cmdbuf_suballoc = etnaviv_cmdbuf_suballoc_new(drm->dev);
>> -	if (IS_ERR(priv->cmdbuf_suballoc)) {
>> -		dev_err(drm->dev, "Failed to create cmdbuf suballocator\n");
>> -		ret = PTR_ERR(priv->cmdbuf_suballoc);
>> -		goto out_free_priv;
>> -	}
>> -
>>   	dev_set_drvdata(dev, drm);
>>   
>>   	ret = component_bind_all(dev, drm);
>>   	if (ret < 0)
>> -		goto out_destroy_suballoc;
>> +		goto out_free_priv;
>>   
>>   	load_gpu(drm);
>>   
>> @@ -551,10 +575,8 @@ static int etnaviv_bind(struct device *dev)
>>   
>>   out_unbind:
>>   	component_unbind_all(dev, drm);
>> -out_destroy_suballoc:
>> -	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>>   out_free_priv:
>> -	kfree(priv);
>> +	etnaviv_free_private(priv);
>>   out_put:
>>   	drm_dev_put(drm);
>>   
>> @@ -570,12 +592,9 @@ static void etnaviv_unbind(struct device *dev)
>>   
>>   	component_unbind_all(dev, drm);
>>   
>> -	etnaviv_cmdbuf_suballoc_destroy(priv->cmdbuf_suballoc);
>> -
>> -	xa_destroy(&priv->active_contexts);
>> +	etnaviv_free_private(priv);
>>   
>>   	drm->dev_private = NULL;
>> -	kfree(priv);
>>   
>>   	drm_dev_put(drm);
>>   }
>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>> index b3eb1662e90c..e58f82e698de 100644
>> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
>> @@ -35,6 +35,7 @@ struct etnaviv_file_private {
>>   };
>>   
>>   struct etnaviv_drm_private {
>> +	struct drm_device *drm;
>>   	int num_gpus;
>>   	struct etnaviv_gpu *gpu[ETNA_MAX_PIPES];
>>   	gfp_t shm_gfp_mask;

-- 
Jingfeng

