Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789455EF4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbiI2MLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235605AbiI2MLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:11:31 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496010B5BA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:11:15 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x1so1085807plv.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Z7XuW+AFa1zSdV3jkS4YCJs3LGjfYYr9+c27k89oPls=;
        b=ehoboS0QQDoxfak0jPEZuzA6PZYtVRrkQiUBPgrw1TWIXkHRVuJTacrYPNeuT0fv+f
         2SkQyOApLpapjcC5SwNjwgidU91fRWv8xo2sml/vgKFpTkc1sN9hP0qCYNo5namMrn1/
         EPWZx25C0+DTo9Pl4F2rUU9MRu8DJZkxMaAS1y1gJog9EujlF/oHXOIIJU9QQK2oZpMH
         GTESFbtkmdmDj1gQ6isyQswTXd/4AQFDyR6VnUVuJg8CaVItvENWm1Y9IzFlNbnSxeDE
         KfnUxYWLWsCmYhYArA3mi0HzpE4Gu5qtnugXtkRT9gZwENIPfRy91DyWsaM1bTstBtLu
         wJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Z7XuW+AFa1zSdV3jkS4YCJs3LGjfYYr9+c27k89oPls=;
        b=n4vAnbGPvdzCkuBR/o7nBiQYDE9329iOqjxAeQ/QBwAO9fenlsRa1OEhxq9t4jI8cI
         Cdev+9swwYJcaEmJ55PLy8I4K2oGaNCoNFuu9mfGT0YolCvrM2a5iDS5+9ZlQMLJwIi6
         Y0KwvwyDw6rAi2aggoiDyhoGlxyElbK6ezFnfrFroGaO2Oev7T6J8vr6V3uzVmIYlr99
         e8xengdl17HH7/A9bqHmK1U2/euYJEPeEC8ZGn+fod7PJk68ARG0LelJJEj/VOg4FPIk
         LLJym3mqxxxNwlZ3nbsiO5CzCRED/sw1d+gbxOScm7R/U0S3XrSft8d/l46SbXsck7IW
         h7xg==
X-Gm-Message-State: ACrzQf2A0IyS8sR+4aWl2F367AvrDlBozuSiqic4ZZAz7Rteepb1q7ga
        XOpW5wHYpILscAFRgy4DG+gdJg==
X-Google-Smtp-Source: AMsMyM7EwImswx7nxZ3yFvW+mGYZbG+faPF83VvMPRxgDAtIWY4pVSQysYvPcLUq3C9ilt8FacfQeA==
X-Received: by 2002:a17:902:e74c:b0:177:f3be:2812 with SMTP id p12-20020a170902e74c00b00177f3be2812mr3097627plf.123.1664453474898;
        Thu, 29 Sep 2022 05:11:14 -0700 (PDT)
Received: from [10.4.189.225] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n26-20020a63971a000000b0043b565cb57csm5389706pge.73.2022.09.29.05.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:11:06 -0700 (PDT)
Message-ID: <1755ade9-9333-4dc2-dd06-eb1f87d6b30d@bytedance.com>
Date:   Thu, 29 Sep 2022 20:10:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v3 2/2] LoongArch: update local TLB if PTE entry exists
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     maobibo@loongson.cn, chenhuacai@loongson.cn,
        songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        loongarch@lists.linux.dev, chris@zankel.net, jcmvbkbc@gmail.com
References: <20220929112318.32393-1-zhengqi.arch@bytedance.com>
 <20220929112318.32393-3-zhengqi.arch@bytedance.com>
 <CAAhV-H76pOCs2uAA6y1JB+-uwASDBTWk-zaheGdG+ap-4HUZxA@mail.gmail.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAAhV-H76pOCs2uAA6y1JB+-uwASDBTWk-zaheGdG+ap-4HUZxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 19:42, Huacai Chen wrote:
> Hi, all,
> 
> Should this patch go via mm tree or loongarch tree? If via mm tree, then

Both are fine for me. Hi Andrew, can you help to apply this patch
series?

> 
> Acked-by: Huacai Chen <chenhuacai@loongson.cn>

Thanks. :)

> 
> On Thu, Sep 29, 2022 at 7:23 PM Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> Currently, the implementation of update_mmu_tlb() is empty if
>> __HAVE_ARCH_UPDATE_MMU_TLB is not defined. Then if two threads
>> concurrently fault at the same page, the second thread that did
>> not win the race will give up and do nothing. In the LoongArch
>> architecture, this second thread will trigger another fault,
>> and only updates its local TLB.
>>
>> Instead of triggering another fault, it's better to implement
>> update_mmu_tlb() to directly update the local TLB of the second
>> thread. Just do it.
>>
>> Suggested-by: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/loongarch/include/asm/pgtable.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index 8ea57e2f0e04..946704bee599 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -412,6 +412,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>>          __update_tlb(vma, address, ptep);
>>   }
>>
>> +#define __HAVE_ARCH_UPDATE_MMU_TLB
>> +#define update_mmu_tlb update_mmu_cache
>> +
>>   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>>                          unsigned long address, pmd_t *pmdp)
>>   {
>> --
>> 2.20.1
>>
>>

-- 
Thanks,
Qi
