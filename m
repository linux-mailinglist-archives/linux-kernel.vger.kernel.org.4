Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3E5EEC90
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbiI2DrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiI2DrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:47:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F011D0CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:47:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so349260pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oR8kEmKepn1OxcoDnk+3+f0BMSGhXeHUAukDiRlODV8=;
        b=YzUZIxmCSK3Cc3CddDpRnQcarNDoKYyfhVUMJbPXN15NYXsk3ACA8BeNC7U1O88cJK
         uACyigsZ+waxZl7/K9rMWjqKCJECowNnHRfyKUK4z2SWmVocUWEXDz2tPR4A2k/Ao3bZ
         EvbdV+29w8bdwHzsoDo9uz1jd2AY/L520RrIyiyBW8VUkg4ghjfmWUt5rar+07g5IMlf
         Eu7jG5JipxB1D3qDYtkRYM/HmNiQnNk7TTfHMTC58ggl9TIhq9CF97P5nud+FjXc97hc
         VLVe6jS/KGKASeczLYh7q9FJ8Tg2eU3bUgr6V6ae5Tk2QJqZA03VrIYotYclq6z00wMC
         mG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oR8kEmKepn1OxcoDnk+3+f0BMSGhXeHUAukDiRlODV8=;
        b=V0tmoRJHPFPqugqI/vExOeCRyFd6YlaGkgzy5rbXoOR4/GvgwMQWY053SR2xoKZCnt
         8cHWL1NzD5bYRqeukQkngdOvKu7MPT41kMKJcp2HW6CZkmTEs9U7VG42B3hc0gL6QB6V
         X3DYHjSVObkYbANf2u//PiqLldNVzGjWmbyC4Nu84GjrKQ9nV4WWW3/M5Z9ZHN01cvwM
         vRIZbQcg8Ul1x67J0pCQzpUHkolS+QAGZKzAY9V6pKzbgWcJAXQ1dTDbFkGKoaUCtHDR
         E0eZefs/n4Gq20ljyvwQ/OqeiK43mw6hybpBDU/v0xEFvov+0ByX4pALsFyZZnEFKCxC
         9hVQ==
X-Gm-Message-State: ACrzQf1b8NaT7XvNMyLZ/jYjVDJZ07HQv5X1bOhLwvH4jhFVSFWjJgP7
        myCMnheS/5dnYXlZ+n8A/gfSxA==
X-Google-Smtp-Source: AMsMyM7xwP2/B9SzqOzc2lCojzmWu4yqCZ2w2+v6ELVU29ddC7gL1QvWI4JTNNA+Od4s8rqk3gycfA==
X-Received: by 2002:a05:6a02:30c:b0:43c:7c23:4717 with SMTP id bn12-20020a056a02030c00b0043c7c234717mr1100246pgb.412.1664423240257;
        Wed, 28 Sep 2022 20:47:20 -0700 (PDT)
Received: from [10.4.189.225] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e22-20020a63f556000000b0041c0c9c0072sm4340782pgk.64.2022.09.28.20.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 20:47:19 -0700 (PDT)
Message-ID: <d4e4a362-fbf2-7eea-e021-16ae7782e06e@bytedance.com>
Date:   Thu, 29 Sep 2022 11:47:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, muchun.song@linux.dev,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
Cc:     chris@zankel.net, jcmvbkbc@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20220926115621.13849-1-zhengqi.arch@bytedance.com>
 <b5823e18-6139-c16e-a2df-1aa3e88927fa@redhat.com>
 <c41a3cb6-aef9-d8a9-ab0b-b9c8013ee1d8@bytedance.com>
 <e5cd4c46-71fd-8edb-098c-2ac839d5c5d2@loongson.cn>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <e5cd4c46-71fd-8edb-098c-2ac839d5c5d2@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/29 11:27, maobibo wrote:
> 在 2022/9/29 11:07, Qi Zheng 写道:
>>
>>
>> On 2022/9/26 22:34, David Hildenbrand wrote:
>>> On 26.09.22 13:56, Qi Zheng wrote:
>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>> if PTE entry exists") said, we should update local TLB only on the
>>>> second thread. So in the do_anonymous_page() here, we should use
>>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>> ---
>>>> v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
>>>>
>>>> Changelog in v1 -> v2:
>>>>    - change the subject and commit message (David)
>>>>
>>>>    mm/memory.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 118e5f023597..9e11c783ba0e 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>>                &vmf->ptl);
>>>>        if (!pte_none(*vmf->pte)) {
>>>> -        update_mmu_cache(vma, vmf->address, vmf->pte);
>>>> +        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>            goto release;
>>>>        }
>>>
>>>
>>> Staring at 7df676974359, it indeed looks like an accidental use [nothing else in that patch uses update_mmu_cache].
>>>
>>> So it looks good to me, but a confirmation from Bibo Mao might be good.
>>
>> Thanks, and Hi Bibo, any comments here? :)
> 
> update_mmu_tlb is defined as empty on loongarch, maybe some lines should
> be added in file arch/loongarch/include/asm/pgtable.h like this:

Seems like a bug? Because there are many other places where
update_mmu_tlb() is called.

> 
> +#define __HAVE_ARCH_UPDATE_MMU_TLB
> +#define update_mmu_tlb  update_mmu_cache

If so, I can make the above as a separate fix patch.

Thanks,
Qi

> 
> regards
> bibo mao
>>
>>>
>>
> 

-- 
Thanks,
Qi
