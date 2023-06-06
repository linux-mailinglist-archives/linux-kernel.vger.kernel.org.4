Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F8072412C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjFFLkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbjFFLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:40:23 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2DA310DE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:40:03 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.185])
        by gateway (Coremail) with SMTP id _____8CxPusIG39kliIAAA--.672S3;
        Tue, 06 Jun 2023 19:39:52 +0800 (CST)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxluQFG39kWkkCAA--.9429S3;
        Tue, 06 Jun 2023 19:39:49 +0800 (CST)
Subject: Re: [PATCH] LoongArch: let pmd_present return true when splitting pmd
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230524074132.10916-1-zhanghongchen@loongson.cn>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <46ce41a3-16bd-6d92-c8a8-764283859190@loongson.cn>
Date:   Tue, 6 Jun 2023 19:38:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230524074132.10916-1-zhanghongchen@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxluQFG39kWkkCAA--.9429S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQANB2R8fwAONwAGsT
X-Coremail-Antispam: 1Uk129KBj93XoWxXrykur4kWw15Cr1DCr47WrX_yoW5Gr17p3
        Z7CFykur45KFyIy343tF1fZry7ursrGFn2gryqgw1UAFy3X397Jrn8Kwn8ZFy8XayvyFW8
        Wrn2g3W5Way3J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
        WrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48J
        MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2pVbDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping.

On 2023/5/24 pm 3:41, Hongchen Zhang wrote:
> when we split a pmd into ptes, pmd_present() and pmd_trans_huge() should
> return true,otherwise it would be treated as a swap pmd.
> As arm64 does in
> commit b65399f6111b ("arm64/mm: Change THP helpers to comply with generic MM semantics")
> we add a _PAGE_PRESENT_INVALID bit for LoongArch.
> 
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>   arch/loongarch/include/asm/pgtable-bits.h | 2 ++
>   arch/loongarch/include/asm/pgtable.h      | 3 ++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
> index 8b98d22a145b..a7469d28d9d0 100644
> --- a/arch/loongarch/include/asm/pgtable-bits.h
> +++ b/arch/loongarch/include/asm/pgtable-bits.h
> @@ -22,12 +22,14 @@
>   #define	_PAGE_PFN_SHIFT		12
>   #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
>   #define	_PAGE_PFN_END_SHIFT	48
> +#define _PAGE_PRESENT_INVALID_SHIFT 60
>   #define	_PAGE_NO_READ_SHIFT	61
>   #define	_PAGE_NO_EXEC_SHIFT	62
>   #define	_PAGE_RPLV_SHIFT	63
>   
>   /* Used by software */
>   #define _PAGE_PRESENT		(_ULCAST_(1) << _PAGE_PRESENT_SHIFT)
> +#define _PAGE_PRESENT_INVALID	(_ULCAST_(1) << _PAGE_PRESENT_INVALID_SHIFT)
>   #define _PAGE_WRITE		(_ULCAST_(1) << _PAGE_WRITE_SHIFT)
>   #define _PAGE_ACCESSED		(_ULCAST_(1) << _PAGE_ACCESSED_SHIFT)
>   #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> index d28fb9dbec59..9a9f9ff9b709 100644
> --- a/arch/loongarch/include/asm/pgtable.h
> +++ b/arch/loongarch/include/asm/pgtable.h
> @@ -213,7 +213,7 @@ static inline int pmd_bad(pmd_t pmd)
>   static inline int pmd_present(pmd_t pmd)
>   {
>   	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
> -		return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE));
> +		return !!(pmd_val(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PRESENT_INVALID));
>   
>   	return pmd_val(pmd) != (unsigned long)invalid_pte_table;
>   }
> @@ -558,6 +558,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>   
>   static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>   {
> +	pmd_val(pmd) |= _PAGE_PRESENT_INVALID;
>   	pmd_val(pmd) &= ~(_PAGE_PRESENT | _PAGE_VALID | _PAGE_DIRTY | _PAGE_PROTNONE);
>   
>   	return pmd;
> 
> base-commit: f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> 

Best Regards
Hongchen Zhang

