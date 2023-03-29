Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DA6CD411
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjC2IJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjC2IJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:09:20 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6BF1FFC;
        Wed, 29 Mar 2023 01:09:18 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 54350FF808;
        Wed, 29 Mar 2023 08:09:13 +0000 (UTC)
Message-ID: <08c3a597-0950-9756-9665-c017942de81f@ghiti.fr>
Date:   Wed, 29 Mar 2023 10:09:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -fixes 2/2] riscv: Do not set initial_boot_params to the
 linear address of the dtb
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230323163347.182895-1-alexghiti@rivosinc.com>
 <20230323163347.182895-3-alexghiti@rivosinc.com>
 <831ec4a4-694b-4ace-9500-9b2189a7f16d@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <831ec4a4-694b-4ace-9500-9b2189a7f16d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/27/23 13:16, Conor Dooley wrote:
> On Thu, Mar 23, 2023 at 05:33:47PM +0100, Alexandre Ghiti wrote:
>> Now that the dtb early mapping was moved in the fixmap region, we can
>> keep using this address since it is present in swapper_pg_dir, so remove
>> the dtb relocation which was wrong anyway since early_memremap is
>> restricted to 256K whereas the maximum fdt size is 2MB.
> I feel bad making this comment since only one of us is a native speaker,
> but for the future would you mind breaking up overly long sentences like
> the above? Say:
>
> 	Now that the dtb early mapping was moved in the fixmap region, we can
> 	keep using this address since it is present in swapper_pg_dir, and
> 	remove the dtb relocation.
> 	The relocation was wrong anyway since early_memremap() is restricted to
> 	256K whereas the maximum fdt size is 2MB.


Sure!


>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/kernel/setup.c |  5 +----
>>   arch/riscv/mm/init.c      | 21 ++-------------------
>>   2 files changed, 3 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 542eed85ad2c..a059b73f4ddb 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
>>   #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>>   	unflatten_and_copy_device_tree();
>>   #else
>> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> btw, how come it is safe now to drop this? This feels like a separate
> change that should be its own commit, no?


It is safe because early_init_dt_verify is already called in parse_dtb 
and since the dtb address does not change anymore, no need to reset 
initial_boot_params. So I'll split this one, thanks.


>
> Cheers,
> Conor.
>
>> -		unflatten_device_tree();
>> -	else
>> -		pr_err("No DTB found in kernel mappings\n");
>> +	unflatten_device_tree();
>>   #endif
>>   	misc_mem_init();
>>   
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index fb78d6bbabae..0f14f4a8d179 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -249,25 +249,8 @@ static void __init setup_bootmem(void)
>>   	 * early_init_fdt_reserve_self() since __pa() does
>>   	 * not work for DTB pointers that are fixmap addresses
>>   	 */
>> -	if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
>> -		/*
>> -		 * In case the DTB is not located in a memory region we won't
>> -		 * be able to locate it later on via the linear mapping and
>> -		 * get a segfault when accessing it via __va(dtb_early_pa).
>> -		 * To avoid this situation copy DTB to a memory region.
>> -		 * Note that memblock_phys_alloc will also reserve DTB region.
>> -		 */
>> -		if (!memblock_is_memory(dtb_early_pa)) {
>> -			size_t fdt_size = fdt_totalsize(dtb_early_va);
>> -			phys_addr_t new_dtb_early_pa = memblock_phys_alloc(fdt_size, PAGE_SIZE);
>> -			void *new_dtb_early_va = early_memremap(new_dtb_early_pa, fdt_size);
>> -
>> -			memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
>> -			early_memunmap(new_dtb_early_va, fdt_size);
>> -			_dtb_early_pa = new_dtb_early_pa;
>> -		} else
>> -			memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>> -	}
>> +	if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
>> +		memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>>   
>>   	dma_contiguous_reserve(dma32_phys_limit);
>>   	if (IS_ENABLED(CONFIG_64BIT))
>> -- 
>> 2.37.2
>>
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
