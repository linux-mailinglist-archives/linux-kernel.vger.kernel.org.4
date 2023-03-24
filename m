Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C986C811F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjCXPXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCXPXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:23:50 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D0619F;
        Fri, 24 Mar 2023 08:23:48 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id A71C1FF814;
        Fri, 24 Mar 2023 15:23:42 +0000 (UTC)
Message-ID: <dc0ffd3c-18cf-aeb9-52f9-dfcf9c92c6e9@ghiti.fr>
Date:   Fri, 24 Mar 2023 16:23:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 3/4] arm64: Make use of memblock_isolate_memory for the
 linear mapping
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
References: <20230316131711.1284451-1-alexghiti@rivosinc.com>
 <20230316131711.1284451-4-alexghiti@rivosinc.com>
 <20230324152112.GD27199@willie-the-truck>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230324152112.GD27199@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 3/24/23 16:21, Will Deacon wrote:
> On Thu, Mar 16, 2023 at 02:17:10PM +0100, Alexandre Ghiti wrote:
>> In order to isolate the kernel text mapping and the crash kernel
>> region, we used some sort of hack to isolate thoses ranges which consisted
>> in marking them as not mappable with memblock_mark_nomap.
>>
>> Simply use the newly introduced memblock_isolate_memory function which does
>> exactly the same but does not uselessly mark the region as not mappable.
> But that's not what this patch does -- it's also adding special-case code
> for kexec and, honestly, I'm struggling to see why this is improving
> anything.
>
> Can we leave the code like it is, or is there something else going on?


Yes, the next version won't touch arm64 at all since actually, I'll 
remove this new api.

Thanks for your time,

Alex


>
> Will
>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/arm64/mm/mmu.c | 25 ++++++++++++++++---------
>>   1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 6f9d8898a025..387c2a065a09 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -548,19 +548,18 @@ static void __init map_mem(pgd_t *pgdp)
>>   
>>   	/*
>>   	 * Take care not to create a writable alias for the
>> -	 * read-only text and rodata sections of the kernel image.
>> -	 * So temporarily mark them as NOMAP to skip mappings in
>> -	 * the following for-loop
>> +	 * read-only text and rodata sections of the kernel image so isolate
>> +	 * those regions and map them after the for loop.
>>   	 */
>> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
>> +	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
>>   
>>   #ifdef CONFIG_KEXEC_CORE
>>   	if (crash_mem_map) {
>>   		if (defer_reserve_crashkernel())
>>   			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>   		else if (crashk_res.end)
>> -			memblock_mark_nomap(crashk_res.start,
>> -			    resource_size(&crashk_res));
>> +			memblock_isolate_memory(crashk_res.start,
>> +						resource_size(&crashk_res));
>>   	}
>>   #endif
>>   
>> @@ -568,6 +567,17 @@ static void __init map_mem(pgd_t *pgdp)
>>   	for_each_mem_range(i, &start, &end) {
>>   		if (start >= end)
>>   			break;
>> +
>> +		if (start == kernel_start)
>> +			continue;
>> +
>> +#ifdef CONFIG_KEXEC_CORE
>> +		if (start == crashk_res.start &&
>> +		    crash_mem_map && !defer_reserve_crashkernel() &&
>> +		    crashk_res.end)
>> +			continue;
>> +#endif
>> +
>>   		/*
>>   		 * The linear map must allow allocation tags reading/writing
>>   		 * if MTE is present. Otherwise, it has the same attributes as
>> @@ -589,7 +599,6 @@ static void __init map_mem(pgd_t *pgdp)
>>   	 */
>>   	__map_memblock(pgdp, kernel_start, kernel_end,
>>   		       PAGE_KERNEL, NO_CONT_MAPPINGS);
>> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>>   
>>   	/*
>>   	 * Use page-level mappings here so that we can shrink the region
>> @@ -603,8 +612,6 @@ static void __init map_mem(pgd_t *pgdp)
>>   				       crashk_res.end + 1,
>>   				       PAGE_KERNEL,
>>   				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
>> -			memblock_clear_nomap(crashk_res.start,
>> -					     resource_size(&crashk_res));
>>   		}
>>   	}
>>   #endif
>> -- 
>> 2.37.2
>>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
