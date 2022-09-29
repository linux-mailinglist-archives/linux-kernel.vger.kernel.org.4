Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323575EECA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiI2EF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbiI2EFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:05:54 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AAC7CBADC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:05:51 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCNGTVjBqEjAA--.2174S3;
        Thu, 29 Sep 2022 12:05:33 +0800 (CST)
Message-ID: <24f6df23-82cc-1290-e015-cba2a284e060@loongson.cn>
Date:   Thu, 29 Sep 2022 12:05:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] mm: use update_mmu_tlb() on the second thread
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
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
 <d4e4a362-fbf2-7eea-e021-16ae7782e06e@bytedance.com>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <d4e4a362-fbf2-7eea-e021-16ae7782e06e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkOCNGTVjBqEjAA--.2174S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ary8CrWkuF4rCr48uFWfXwb_yoW8Kw1kpr
        97CF1DtFWYqr18Cr1Iqr1kuryFqw1UJa4UXry7ta4UXrnFqwn2grWUWr4q9w4UJrs5J3WU
        Xr4jqr13ZF4UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/29 11:47, Qi Zheng 写道:
> 
> 
> On 2022/9/29 11:27, maobibo wrote:
>> 在 2022/9/29 11:07, Qi Zheng 写道:
>>>
>>>
>>> On 2022/9/26 22:34, David Hildenbrand wrote:
>>>> On 26.09.22 13:56, Qi Zheng wrote:
>>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>>> if PTE entry exists") said, we should update local TLB only on the
>>>>> second thread. So in the do_anonymous_page() here, we should use
>>>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>>>> ---
>>>>> v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
>>>>>
>>>>> Changelog in v1 -> v2:
>>>>>    - change the subject and commit message (David)
>>>>>
>>>>>    mm/memory.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 118e5f023597..9e11c783ba0e 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>>>        vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>>>                &vmf->ptl);
>>>>>        if (!pte_none(*vmf->pte)) {
>>>>> -        update_mmu_cache(vma, vmf->address, vmf->pte);
>>>>> +        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>>>            goto release;
>>>>>        }
>>>>
>>>>
>>>> Staring at 7df676974359, it indeed looks like an accidental use [nothing else in that patch uses update_mmu_cache].
>>>>
>>>> So it looks good to me, but a confirmation from Bibo Mao might be good.
>>>
>>> Thanks, and Hi Bibo, any comments here? :)
>>
>> update_mmu_tlb is defined as empty on loongarch, maybe some lines should
>> be added in file arch/loongarch/include/asm/pgtable.h like this:
> 
> Seems like a bug? Because there are many other places where
> update_mmu_tlb() is called.
> 
>>
>> +#define __HAVE_ARCH_UPDATE_MMU_TLB
>> +#define update_mmu_tlb  update_mmu_cache
> 
> If so, I can make the above as a separate fix patch.
It sounds good to me.  

Huacai, do you have any comments?

regards
bibo, mao
> 
> Thanks,
> Qi
> 
>>
>> regards
>> bibo mao
>>>
>>>>
>>>
>>
> 

