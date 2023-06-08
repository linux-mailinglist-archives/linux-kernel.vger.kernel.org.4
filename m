Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A211727456
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjFHBbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjFHBb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:31:29 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE6C0269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:31:27 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8DxyOltL4FkAU8AAA--.1060S3;
        Thu, 08 Jun 2023 09:31:25 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxCOVsL4Fk2SYGAA--.20258S3;
        Thu, 08 Jun 2023 09:31:24 +0800 (CST)
Subject: Re: Re: [PATCH] LoongArch: let pmd_present return true when splitting
 pmd
To:     "bibo, mao" <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
 <46ce41a3-16bd-6d92-c8a8-764283859190@loongson.cn>
 <fbe8a1ec-cc81-d4db-8c55-31a60fb9fb58@loongson.cn>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <c628c83d-424d-5c0e-24ca-702252779940@loongson.cn>
Date:   Thu, 8 Jun 2023 09:31:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fbe8a1ec-cc81-d4db-8c55-31a60fb9fb58@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxCOVsL4Fk2SYGAA--.20258S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAPB2R-IgAHlgACsj
X-Coremail-Antispam: 1Uk129KBj93XoWxuF1rAFWxJw18GrWUCw47WrX_yoWrGry3p3
        Z7CFyrCrW5KFn3C34UtFy3XryUArsrG3Wqqr98GF18JFW7X3s2qrn8Wr909ry8Xan5try8
        Xr45Ww15uFy3JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bibo & Anshuman,

On 2023/6/6 下午9:49, bibo, mao wrote:
> I do not object to adding sw bit for _PAGE_PRESENT_INVALID,  only that can it use
> bit12--bit20 since it is for pmd entry only?
If we change from bit60 to bit12, pmd_pfn will return an incorrect pfn, 
and it seems that modifying pmd_pfn accordingly is not a good idea.

Hi Anshuman,
   What's your opinion about this suggestion? I think arm64 architecture 
  has similar problems. Why do you choose bit59 instead of bit12--bit20?
> 
> Regards
> Bibo, Mao
> 
> 在 2023/6/6 19:38, Hongchen Zhang 写道:
>> Hi,
>>
>> Gentle ping.
>>
>> On 2023/5/24 pm 3:41, Hongchen Zhang wrote:
>>> when we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
>>> return true,otherwise it would be treated as a swap pmd.
>>> As arm64 does in
>>> commit b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM semantics")
>>> we add a _PAGE_PRESENT_INVALID bit for LoongArch.
>>>
>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>> ---
>>>    arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>>>    arch/loongarch/include/asm/pgtable.h      | 3 ++-
>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
>>> index 8b98d22a145b..a7469d28d9d0 100644
>>> --- a/arch/loongarch/include/asm/pgtable-bits.h
>>> +++ b/arch/loongarch/include/asm/pgtable-bits.h
>>> @@ -22,12 +22,14 @@
>>>    #define    _PAGE_PFN_SHIFT        12
>>>    #define    _PAGE_SWP_EXCLUSIVE_SHIFT 23
>>>    #define    _PAGE_PFN_END_SHIFT    48
>>> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>>>    #define    _PAGE_NO_READ_SHIFT    61
>>>    #define    _PAGE_NO_EXEC_SHIFT    62
>>>    #define    _PAGE_RPLV_SHIFT    63
>>>      /* Used by software */
>>>    #define _PAGE_PRESENT        (_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
>>> +#define _PAGE_PRESENT_INVALID    (_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
>>>    #define _PAGE_WRITE        (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>>>    #define _PAGE_ACCESSED        (_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>>>    #define _PAGE_MODIFIED        (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>>> index d28fb9dbec59..9a9f9ff9b709 100644
>>> --- a/arch/loongarch/include/asm/pgtable.h
>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>>>    static inline int pmd_present(pmd_t pmd)
>>>    {
>>>        if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
>>> -        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
>>> +        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
>>>          return pmd_val(pmd) != (unsigned long)invalid_pte_table;
>>>    }
>>> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>      static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>    {
>>> +    pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
>>>        pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
>>>          return pmd;
>>>
>>> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
>>>
>>
>> Best Regards
>> Hongchen Zhang
>>
>> _______________________________________________
>> Loongson-kernel mailing list -- loongson-kernel@lists.loongnix.cn
>> To unsubscribe send an email to loongson-kernel-leave@lists.loongnix.cn
> 
> 

