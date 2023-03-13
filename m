Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ACF6B7361
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjCMKC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMKCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:02:02 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE703AA5;
        Mon, 13 Mar 2023 03:01:43 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 3F0261C0019;
        Mon, 13 Mar 2023 10:01:33 +0000 (UTC)
Message-ID: <77564d46-5bca-81b8-8e14-c70624ddce5e@ghiti.fr>
Date:   Mon, 13 Mar 2023 11:01:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 3/4] arm64: Make use of memblock_isolate_memory for the
 linear mapping
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
 <20230310094539.764357-4-alexghiti@rivosinc.com>
 <20230313094306.6kslmrdixuw75iqf@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230313094306.6kslmrdixuw75iqf@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 3/13/23 10:43, Andrew Jones wrote:
> On Fri, Mar 10, 2023 at 10:45:38AM +0100, Alexandre Ghiti wrote:
>> In order to isolate the kernel text mapping, we used some sort of hack
>> to isolate the kernel text range which consisted in marking this region
>> as not mappable with memblock_mark_nomap. Simply use the newly introduced
>> memblock_isolate_memory function which does exactly the same but does not
>> uselessly mark the region as not mappable.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/arm64/mm/mmu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 6f9d8898a025..408dc852805c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -552,7 +552,7 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 * So temporarily mark them as NOMAP to skip mappings in
>>   	 * the following for-loop
>>   	 */
> The comment above doesn't apply anymore.


Yep, noticed this one after sending, thanks anyway!


>
>> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>> +	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
>>   
>>   #ifdef CONFIG_KEXEC_CORE
>>   	if (crash_mem_map) {
>> @@ -568,6 +568,7 @@ static void __init map_mem(pgd_t *pgdp)
>>   	for_each_mem_range(i, &start, &end) {
>>   		if (start >= end)
>>   			break;
>> +
> Mark nomap is also used for the crash kernel. Does the new API not work
> for it?


Seems you're right, I missed it.

Thanks,

Alex


>
> Thanks,
> drew
>
>>   		/*
>>   		 * The linear map must allow allocation tags reading/writing
>>   		 * if MTE is present. Otherwise, it has the same attributes as
>> @@ -589,7 +590,6 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 */
>>   	__map_memblock(pgdp, kernel_start, kernel_end,
>>   		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>>   
>>   	/*
>>   	 * Use page-level mappings here so that we can shrink the region
>> -- 
>> 2.37.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
