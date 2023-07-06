Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF26749C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGFMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGFMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:47:34 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A82A91FCB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:47:11 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8CxNvGgt6ZkXPMAAA--.3861S3;
        Thu, 06 Jul 2023 20:46:24 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_yOPt6ZkktseAA--.51215S3;
        Thu, 06 Jul 2023 20:46:23 +0800 (CST)
Message-ID: <1784da38-52ae-668a-db2a-49d60f2be80e@loongson.cn>
Date:   Thu, 6 Jul 2023 20:46:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/mediatek: Fix potential memory leak if vmap() fail
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        loongson-kernel@lists.loongnix.cn
References: <20230626185801.684451-1-suijingfeng@loongson.cn>
 <78b023a0-ce6d-80e2-c8d0-d3d6fde1c928@gmail.com>
Content-Language: en-US
From:   suijingfeng <suijingfeng@loongson.cn>
In-Reply-To: <78b023a0-ce6d-80e2-c8d0-d3d6fde1c928@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx_yOPt6ZkktseAA--.51215S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF48tw15AF4fKF1kAryxZwc_yoW8Jw1xpF
        4ktay5CFWjkrWFqFn2y3WDZFy5G3WrWa1DGrn2qa1jvw1UJr1jqFyUZ34qgr42vr4Ikw47
        Jr1DXr9xuFy2yFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
        8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
        UUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thanks a lot!


On 2023/7/6 19:39, Matthias Brugger wrote:
>
>
> On 26/06/2023 20:58, Sui Jingfeng wrote:
>> Also return -ENOMEM if such a failure happens, the implement should take
>> responsibility for the error handling.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_gem.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c 
>> b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
>> index a25b28d3ee90..9f364df52478 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
>> @@ -247,7 +247,11 @@ int mtk_drm_gem_prime_vmap(struct drm_gem_object 
>> *obj, struct iosys_map *map)
>>         mtk_gem->kvaddr = vmap(mtk_gem->pages, npages, VM_MAP,
>>                      pgprot_writecombine(PAGE_KERNEL));
>> -
>> +    if (!mtk_gem->kvaddr) {
>> +        kfree(sgt);
>> +        kfree(mtk_gem->pages);
>> +        return -ENOMEM;
>> +    }
>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>
>>   out:
>>       kfree(sgt);
>>       iosys_map_set_vaddr(map, mtk_gem->kvaddr);

