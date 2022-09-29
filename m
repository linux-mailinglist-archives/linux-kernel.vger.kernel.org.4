Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE85EEC74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 05:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiI2D2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 23:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiI2D2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 23:28:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 706E91280CC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 20:28:03 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOK6EDVjMZ0jAA--.2614S3;
        Thu, 29 Sep 2022 11:27:55 +0800 (CST)
Message-ID: <e5cd4c46-71fd-8edb-098c-2ac839d5c5d2@loongson.cn>
Date:   Thu, 29 Sep 2022 11:27:54 +0800
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
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <c41a3cb6-aef9-d8a9-ab0b-b9c8013ee1d8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxYOK6EDVjMZ0jAA--.2614S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18tr17ZF4rCry8XFy5Jwb_yoW8Zr1xpr
        97G3WqqFWjqr1kCr1IqF1Dury0qw1UWa4UXryaya40qrnIqwn2grWUW3yv9w4UZr4kJa1U
        Jr42gr13ZFWUZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/9/29 11:07, Qi Zheng 写道:
> 
> 
> On 2022/9/26 22:34, David Hildenbrand wrote:
>> On 26.09.22 13:56, Qi Zheng wrote:
>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>> if PTE entry exists") said, we should update local TLB only on the
>>> second thread. So in the do_anonymous_page() here, we should use
>>> update_mmu_tlb() instead of update_mmu_cache() on the second thread.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>> v1: https://lore.kernel.org/lkml/20220924053239.91661-1-zhengqi.arch@bytedance.com/
>>>
>>> Changelog in v1 -> v2:
>>>   - change the subject and commit message (David)
>>>
>>>   mm/memory.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 118e5f023597..9e11c783ba0e 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4122,7 +4122,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>>       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>               &vmf->ptl);
>>>       if (!pte_none(*vmf->pte)) {
>>> -        update_mmu_cache(vma, vmf->address, vmf->pte);
>>> +        update_mmu_tlb(vma, vmf->address, vmf->pte);
>>>           goto release;
>>>       }
>>
>>
>> Staring at 7df676974359, it indeed looks like an accidental use [nothing else in that patch uses update_mmu_cache].
>>
>> So it looks good to me, but a confirmation from Bibo Mao might be good.
> 
> Thanks, and Hi Bibo, any comments here? :)

update_mmu_tlb is defined as empty on loongarch, maybe some lines should
be added in file arch/loongarch/include/asm/pgtable.h like this:

+#define __HAVE_ARCH_UPDATE_MMU_TLB
+#define update_mmu_tlb  update_mmu_cache

regards
bibo mao
> 
>>
> 

