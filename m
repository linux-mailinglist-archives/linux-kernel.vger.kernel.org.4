Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD477274C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjFHCMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHCMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:12:30 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3FC11984
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 19:12:28 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8AxGuoKOYFkGFIAAA--.1166S3;
        Thu, 08 Jun 2023 10:12:26 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluQJOYFkgDoGAA--.20361S3;
        Thu, 08 Jun 2023 10:12:25 +0800 (CST)
Subject: Re: [PATCH] LoongArch: let pmd_present return true when splitting pmd
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
 <CAAhV-H4CC0S7ciLCqdb_AoQ+3-24uo6TZb9Pz7H1yu+mvspFDw@mail.gmail.com>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <a8479383-a0d4-0c0a-20ef-d3c64d9ea192@loongson.cn>
Date:   Thu, 8 Jun 2023 10:12:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4CC0S7ciLCqdb_AoQ+3-24uo6TZb9Pz7H1yu+mvspFDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxluQJOYFkgDoGAA--.20361S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAQB2SAc4ELCwAAsA
X-Coremail-Antispam: 1Uk129KBj93XoWxJw48CFWUJF18CFW7Zw15ZFc_yoW5ur15p3
        Z7CF1kCrW5KFyfC34aqF13ZFyUZrsrKFn2gryqgw1UAF9xX397Xrn5Krn8AFyrXayvyFy8
        Wr4qgw15WFW3t3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
        xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
        6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
        1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
        UU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 2023/5/27 下午1:32, Huacai Chen wrote:
> Hi, Anshuman,
> 
> Excuse me, but could you please tell me something that why commit
> b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM
> semantics") needn't be backported to 5.4LTS and 4.19LTS series. The
> discussion link you referred is as early as in 2018, before 4.19
> released. I think this information is important for us because we want
> to know how to handle our 4.19-loongarch codebase.

What's your opinion about huacai's question? In my opinion,your commit
should be backported to 5.4LTS and 4.19LTS.

> 
> Huacai
> 
> On Wed, May 24, 2023 at 3:42 PM Hongchen Zhang
> <zhanghongchen@loongson.cn> wrote:
>>
>> when we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
>> return true,otherwise it would be treated as a swap pmd.
>> As arm64 does in
>> commit b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM semantics")
>> we add a _PAGE_PRESENT_INVALID bit for LoongArch.
>>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>>   arch/loongarch/include/asm/pgtable.h      | 3 ++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
>> index 8b98d22a145b..a7469d28d9d0 100644
>> --- a/arch/loongarch/include/asm/pgtable-bits.h
>> +++ b/arch/loongarch/include/asm/pgtable-bits.h
>> @@ -22,12 +22,14 @@
>>   #define        _PAGE_PFN_SHIFT         12
>>   #define        _PAGE_SWP_EXCLUSIVE_SHIFT 23
>>   #define        _PAGE_PFN_END_SHIFT     48
>> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>>   #define        _PAGE_NO_READ_SHIFT     61
>>   #define        _PAGE_NO_EXEC_SHIFT     62
>>   #define        _PAGE_RPLV_SHIFT        63
>>
>>   /* Used by software */
>>   #define _PAGE_PRESENT          (_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
>> +#define _PAGE_PRESENT_INVALID  (_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
>>   #define _PAGE_WRITE            (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>>   #define _PAGE_ACCESSED         (_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>>   #define _PAGE_MODIFIED         (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index d28fb9dbec59..9a9f9ff9b709 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>>   static inline int pmd_present(pmd_t pmd)
>>   {
>>          if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
>> -               return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
>> +               return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
>>
>>          return pmd_val(pmd) != (unsigned long)invalid_pte_table;
>>   }
>> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>
>>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>>   {
>> +       pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
>>          pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
>>
>>          return pmd;
>>
>> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
>> --
>> 2.31.1
>>
>>

Best Regards
Hongchen Zhang

