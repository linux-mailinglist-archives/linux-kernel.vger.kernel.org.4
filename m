Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC856A1C68
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBXMrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBXMr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:47:28 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A18F42BED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:47:27 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id CDC69240003;
        Fri, 24 Feb 2023 12:47:20 +0000 (UTC)
Message-ID: <8adb9dcb-621a-0392-9ccd-0117345636ec@ghiti.fr>
Date:   Fri, 24 Feb 2023 13:47:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] RISC-V: mm: Support huge page in vmalloc_fault()
Content-Language: en-US
To:     Dylan Jhong <dylan@andestech.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     liushixin2@huawei.com, x5710999x@gmail.com, bjorn@rivosinc.com,
        abrestic@rivosinc.com, peterx@redhat.com, hanchuanhua@oppo.com,
        apopple@nvidia.com, hca@linux.ibm.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tim609@andestech.com,
        peterlin@andestech.com, ycliang@andestech.com
References: <20230224104001.2743135-1-dylan@andestech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230224104001.2743135-1-dylan@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dylan,

On 2/24/23 11:40, Dylan Jhong wrote:
> RISC-V supports ioremap() with huge page (pud/pmd) mapping, but
> vmalloc_fault() assumes that the vmalloc range is limited to pte
> mappings. Add huge page support to complete the vmalloc_fault()
> function.
>
> Fixes: 310f541a027b ("riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT")
>
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>   arch/riscv/mm/fault.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index eb0774d9c03b..4b9953b47d81 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -143,6 +143,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>   		no_context(regs, addr);
>   		return;
>   	}
> +	if (pud_leaf(*pud_k))
> +		goto flush_tlb;
>   
>   	/*
>   	 * Since the vmalloc area is global, it is unnecessary
> @@ -153,6 +155,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>   		no_context(regs, addr);
>   		return;
>   	}
> +	if (pmd_leaf(*pmd_k))
> +		goto flush_tlb;
>   
>   	/*
>   	 * Make sure the actual PTE exists as well to
> @@ -172,6 +176,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>   	 * ordering constraint, not a cache flush; it is
>   	 * necessary even after writing invalid entries.
>   	 */
> +flush_tlb:
>   	local_flush_tlb_page(addr);
>   }
>   


This looks good to me, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

One question: how did you encounter this bug?

Thanks,

Alex

