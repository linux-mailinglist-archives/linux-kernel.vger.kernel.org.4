Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B36C0AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCTG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:59:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2718519C4A;
        Sun, 19 Mar 2023 23:59:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.133])
        by gateway (Coremail) with SMTP id _____8AxJ_BOBBhktLkOAA--.21362S3;
        Mon, 20 Mar 2023 14:59:26 +0800 (CST)
Received: from [10.20.42.133] (unknown [10.20.42.133])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxfb5MBBhkkR0HAA--.19729S3;
        Mon, 20 Mar 2023 14:59:24 +0800 (CST)
Message-ID: <ac06cfa4-e6f8-a0ca-3181-86cd53f5d1af@loongson.cn>
Date:   Mon, 20 Mar 2023 14:59:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        Li Yi <liyi@loongson.cn>
References: <20230315211550.2620818-1-15330273260@189.cn>
 <20230315211550.2620818-3-15330273260@189.cn>
 <efcc3a66-78ca-4e0a-c0fb-527da376fc06@amd.com>
From:   Sui jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <efcc3a66-78ca-4e0a-c0fb-527da376fc06@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cxfb5MBBhkkR0HAA--.19729S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxurWkCry8KryxKrWDZr48Xrb_yoWrtw4fpF
        Z5Kay3trZ8CF4kAr1DAw1UGFWYq3yrJa1DJryYyFyjk398GFnYqrWjqr1q9a47Zr4rWF1j
        yF4UXrW29F17Aw7anT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8v_M3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/16 15:18, Christian König wrote:
>
>
> Am 15.03.23 um 22:15 schrieb Sui Jingfeng:
>> From: suijingfeng <suijingfeng@loongson.cn>
>>
>> Loongson display controller IP has been integrated in both Loongson
>> North Bridge chipset(ls7a1000 and ls7a2000) and Loongson SoCs(ls2k1000
>> and ls2k2000 etc), it even has been included in Loongson BMC products.
>>
>> This display controller is a PCI device, it has two display pipe. For
>> the DC in LS7A1000 and LS2K1000 each way has a DVO output interface
>> which provide RGB888 signals, vertical & horizontal synchronisations,
>> and the pixel clock. Each CRTC is able to support 1920x1080@60Hz,
>> the maximum resolution is 2048x2048 according to the hardware spec.
>>
>> For the DC in LS7A2000, each display pipe is equipped with a built-in
>> HDMI encoder which is compliant with HDMI 1.4 specification, thus it
>> support 3840x2160@30Hz. The first display pipe is also equipped with
>> a transparent vga encoder which is parallel with the HDMI encoder.
>> The DC in LS7A2000 is more complete, besides above feature, it has
>> two hardware cursors, two hardware vblank counter and two scanout
>> position recorders.
>>
>>   v1 -> v2:
>>    1) Use hpd status reg when polling for ls7a2000
>>    2) Fix all warnings emerged when compile with W=1
>>
>>   v2 -> v3:
>>    1) Add COMPILE_TEST in Kconfig and make the driver off by default
>>    2) Alphabetical sorting headers (Thomas)
>>    3) Untangle register access functions as much as possible (Thomas)
>>    4) Switch to TTM based memory manager and prefer cached mapping
>>       for Loongson SoC (Thomas)
>>    5) Add chip id detection method, now all models are distinguishable.
>>    6) Revise builtin HDMI phy driver, nearly all main stream mode
>>       below 4K@30Hz is tested, this driver supported these mode very
>>       well including clone display mode and extend display mode.
>>
>>   v3 -> v4:
>>    1) Quickly fix a small mistake.
>>
>>   v4 -> v5:
>>    1) Drop potential support for Loongson 2K series SoC temporary,
>>       this part should be resend with the DT binding patch in the 
>> future.
>>    2) Add per display pipe debugfs support to the builtin HDMI encoder.
>>    3) Rewrite atomic_update() for hardware cursors plane(Thomas)
>>    4) Rewrite encoder and connector initialization part, untangle it
>>       according to the chip(Thomas).
>>
>>   v5 -> v6:
>>    1) Remove stray code which didn't get used, say 
>> lsdc_of_get_reserved_ram
>>    2) Fix all typos I could found, make sentences and code more readable
>>    3) Untange lsdc_hdmi*_connector_detect() function according to the 
>> pipe
>>    4) After a serious consideration, we rename this driver as loongson.
>>       Because we also have drivers toward the LoongGPU IP in LS7A2000 
>> and
>>       LS2K2000. Besides, there are also drivers about the external 
>> encoder,
>>       HDMI audio driver and vbios support etc. This patch only 
>> provide DC
>>       driver part, my teammate Li Yi believe that loongson will be more
>>       suitable for loongson graphics than lsdc in the long run.
>>
>>       loongson.ko = LSDC + LoongGPU + encoders driver + vbios/DT ...
>>
>>    v6 -> v7:
>>    1) Add prime support, self-sharing is works. sharing buffer with 
>> etnaviv
>>       is also tested, and its works with limitation.
>>    2) Implement buffer objects tracking with list_head.
>>    3) S3(sleep to RAM) is tested on ls3a5000+ls7a2000 evb and it works.
>>    4) Rewrite lsdc_bo_move, since ttm core stop allocating resources
>>       during BO creation. Patch V1 ~ V6 of this series no longer works
>>       on latest kernel. Thus, we send V7.
>>
>> Signed-off-by: Li Yi <liyi@loongson.cn>
>> Signed-off-by: suijingfeng <suijingfeng@loongson.cn>
>> Signed-off-by: Sui Jingfeng <15330273260@189.cn>
>
> [SNIP]
>
>> +u64 lsdc_bo_gpu_offset(struct ttm_buffer_object *tbo)
>> +{
>> +    struct drm_device *ddev = tbo->base.dev;
>> +    struct ttm_resource *resource = tbo->resource;
>> +
>> +    if (drm_WARN_ON(ddev, !tbo->pin_count))
>> +        return -ENODEV;
>
> Returning -ENODEV when the function return value is unsigned doesn't 
> make much sense. I would also use 0 here.
>
> Apart from that I briefly skimmed over the prime and TTM handling and 
> couldn't find anything obviously wrong.
>
> I obviously can't review the hw specific stuff, but over all looks 
> pretty good to me.
>
Yeah, this is very nice comments actually.

much better than NAK, complete NAK, big NAK or somethings like that.

Thanks a lot.

> Regards,
> Christian.

