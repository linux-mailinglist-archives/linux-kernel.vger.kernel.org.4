Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8CD725241
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240814AbjFGC5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbjFGC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:57:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C198F193
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 19:57:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8CxPusY8n9kDgEAAA--.42S3;
        Wed, 07 Jun 2023 10:57:28 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluQU8n9knq8DAA--.13597S3;
        Wed, 07 Jun 2023 10:57:24 +0800 (CST)
Message-ID: <a20794ea-856a-8197-d5b5-c3e29f6203ed@loongson.cn>
Date:   Wed, 7 Jun 2023 10:57:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] LoongArch: let pmd_present return true when splitting pmd
Content-Language: en-US
From:   "bibo, mao" <maobibo@loongson.cn>
To:     zhanghongchen@loongson.cn
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
 <46ce41a3-16bd-6d92-c8a8-764283859190@loongson.cn>
 <fbe8a1ec-cc81-d4db-8c55-31a60fb9fb58@loongson.cn>
In-Reply-To: <fbe8a1ec-cc81-d4db-8c55-31a60fb9fb58@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxluQU8n9knq8DAA--.13597S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCrW5ur47WrWxKrykuF18tFc_yoWrGryDpw
        n7CFy8CrW5KFn7C34YqFy3XryUArsrG3Wqqr98GF18AFW7X3s2qrn8Wr909ry8Xan5tFy8
        Xr45Ww15uFy3JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
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

I suggest to using bit12-bit20 since high weight bits such 63-61 are hw bits, it may
expand for  future hw use, or you had better negotiate with hw guys.

>>> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>>>   #define    _PAGE_NO_READ_SHIFT    61
>>>   #define    _PAGE_NO_EXEC_SHIFT    62
>>>   #define    _PAGE_RPLV_SHIFT    63

Regards
Bibo, Mao

在 2023/6/6 21:49, bibo, mao 写道:
> I do not object to adding sw bit for _PAGE_PRESENT_INVALID,  only that can it use
> bit12--bit20 since it is for pmd entry only?
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
>>>   arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>>>   arch/loongarch/include/asm/pgtable.h      | 3 ++-
>>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
>>> index 8b98d22a145b..a7469d28d9d0 100644
>>> --- a/arch/loongarch/include/asm/pgtable-bits.h
>>> +++ b/arch/loongarch/include/asm/pgtable-bits.h
>>> @@ -22,12 +22,14 @@
>>>   #define    _PAGE_PFN_SHIFT        12
>>>   #define    _PAGE_SWP_EXCLUSIVE_SHIFT 23
>>>   #define    _PAGE_PFN_END_SHIFT    48
>>> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>>>   #define    _PAGE_NO_READ_SHIFT    61
>>>   #define    _PAGE_NO_EXEC_SHIFT    62
>>>   #define    _PAGE_RPLV_SHIFT    63
>>>     /* Used by software */
>>>   #define _PAGE_PRESENT        (_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
>>> +#define _PAGE_PRESENT_INVALID    (_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
>>>   #define _PAGE_WRITE        (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>>>   #define _PAGE_ACCESSED        (_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>>>   #define _PAGE_MODIFIED        (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
>>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>>> index d28fb9dbec59..9a9f9ff9b709 100644
>>> --- a/arch/loongarch/include/asm/pgtable.h
>>> +++ b/arch/loongarch/include/asm/pgtable.h
>>> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>>>   static inline int pmd_present(pmd_t pmd)
>>>   {
>>>       if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
>>> -        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
>>> +        return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
>>>         return pmd_val(pmd) != (unsigned long)invalid_pte_table;
>>>   }
>>> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>>     static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>>   {
>>> +    pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
>>>       pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
>>>         return pmd;
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

