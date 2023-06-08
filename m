Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802B7274F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjFHCVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjFHCVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:21:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C60173A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:21:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8Cx_eonO4Fk81IAAA--.1172S3;
        Thu, 08 Jun 2023 10:21:27 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPMokO4FkZj8GAA--.11936S3;
        Thu, 08 Jun 2023 10:21:25 +0800 (CST)
Message-ID: <c20e0d82-0ac8-9e84-9ac5-941ef1893885@loongson.cn>
Date:   Thu, 8 Jun 2023 10:21:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] LoongArch: let pmd_present return true when splitting pmd
Content-Language: en-US
To:     zhanghongchen@loongson.cn
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        WANG Xuerui <kernel@xen0n.name>,
        David Hildenbrand <david@redhat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
 <46ce41a3-16bd-6d92-c8a8-764283859190@loongson.cn>
 <fbe8a1ec-cc81-d4db-8c55-31a60fb9fb58@loongson.cn>
 <c628c83d-424d-5c0e-24ca-702252779940@loongson.cn>
From:   "bibo, mao" <maobibo@loongson.cn>
In-Reply-To: <c628c83d-424d-5c0e-24ca-702252779940@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxPMokO4FkZj8GAA--.11936S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw1rWF4DXrWxZr4kArW3CFX_yoWrtw17pw
        n7AF18CrW5KF1xC345tr13XryjywsrJ3Wqqrn8GF1UJFZrX34vqr15Xr909ry8Jan5Kry8
        Xr43Ww13uFy3J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
        6rW5McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJPUUUU
        U==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/8 09:31, Hongchen Zhang 写道:
> Hi Bibo & Anshuman,
> 
> On 2023/6/6 下午9:49, bibo, mao wrote:
>> I do not object to adding sw bit for _PAGE_PRESENT_INVALID,  only that can it use
>> bit12--bit20 since it is for pmd entry only?
> If we change from bit60 to bit12, pmd_pfn will return an incorrect pfn, and it seems that modifying pmd_pfn accordingly is not a good idea.
Good catch. Do you test it or just doubt about it by reviewing the code? bit 12 _PAGE_HGLOBAL_SHIFT is already used by pmd entry. There should be problem also.

if you worry about it, pmd_pfn should be something like x86
static inline pmdval_t pmd_pfn_mask(pmd_t pmd)
{
        if (native_pmd_val(pmd) & _PAGE_PSE)
                return PHYSICAL_PMD_PAGE_MASK;
        else
                return PTE_PFN_MASK;
}

However I think forcefully using bit  60 is not good way. It solves one issue and brings out another problem.

Regards
Bibo, Mao

> 
> Hi Anshuman,
>   What's your opinion about this suggestion? I think arm64 architecture  has similar problems. Why do you choose bit59 instead of bit12--bit20?
>>
>> Regards
>> Bibo, Mao
>>
>> 在 2023/6/6 19:38, Hongchen Zhang 写道:
>>> Hi,
>>>
>>> Gentle ping.
>>>
>>> On 2023/5/24 pm 3:41, Hongchen Zhang wrote:
>>>> when we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
>>>> return true,otherwise it would be treated as a swap pmd.
>>>> As arm64 does in
>>>> commit b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM semantics")
>>>> we add a _PAGE_PRESENT_INVALID bit for LoongArch.
>>>>
>>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>>> ---
>>>>    arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>>>>    arch/loongarch/include/asm/pgtable.h      | 3 ++-
>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
>>>> index 8b98d22a145b..a7469d28d9d0 100644
>>>> --- a/arch/loongarch/include/asm/pgtable-bits.h
>>>> +++ b/arch/loongarch/include/asm/pgtable-bits.h
>>>> @@ -22,12 +22,14 @@
>>>>    #define    _PAGE_PFN_SHIFT        12
>>>>    #define    _PAGE_SWP_EXCLUSIVE_SHIFT 23
>>>>    #define    _PAGE_PFN_END_SHIFT    48
>>>> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>>>>    #define    _PAGE_NO_READ_SHIFT    61
>>>>    #define    _PAGE_NO_EXEC_SHIFT    62
>>>>    #define    _PAGE_RPLV_SHIFT    63
>>>>      /* Used by software */
>>>>    #define _PAGE_PRESENT        (_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
>>>> +#define _PAGE_PRESENT_INVALID    (_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
>>>>    #define _PAGE_WRITE        (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>>>>    #define _PAGE_ACCESSED        (_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>>>>    #define _PAGE_MODIFIED        (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
>>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>>>> index d28fb9dbec59..9a9f9ff9b709 100644
>>>> --- a/arch/loongarch/include/asm/pgtable.h
>>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>>> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>>>>    static inline int pmd_present(pmd_t pmd)
>>>>    {
>>>>        if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
>>>> -        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
>>>> +        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
>>>>          return pmd_val(pmd) != (unsigned long)invalid_pte_table;
>>>>    }
>>>> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>>      static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>>    {
>>>> +    pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
>>>>        pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
>>>>          return pmd;
>>>>
>>>> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
>>>>
>>>
>>> Best Regards
>>> Hongchen Zhang
>>>
>>> _______________________________________________
>>> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
>>> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
>>
>>
> 
> _______________________________________________
> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn

