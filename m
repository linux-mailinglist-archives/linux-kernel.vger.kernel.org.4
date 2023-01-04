Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8958465DC3F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239893AbjADSg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbjADSgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:36:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F85717E0E;
        Wed,  4 Jan 2023 10:36:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87CEB1063;
        Wed,  4 Jan 2023 10:36:45 -0800 (PST)
Received: from [10.57.44.105] (unknown [10.57.44.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A8273F663;
        Wed,  4 Jan 2023 10:35:59 -0800 (PST)
Message-ID: <680a52a9-7493-328d-785f-66a12ee29c91@arm.com>
Date:   Wed, 4 Jan 2023 19:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/5] arch_topology: Build cacheinfo from primary CPU
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     palmer@rivosinc.com, Ionela.Voinescu@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
References: <20221209103130.572196-1-pierre.gondois@arm.com>
 <0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0f19cb3f-d6cf-4032-66d2-dedc9d09a0e3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/29/22 17:47, Krzysztof Kozlowski wrote:
> On 09/12/2022 11:31, Pierre Gondois wrote:
>> v2:
>>   - Applied renaming/formatting comments from v1.
>>   - Check CACHE_TYPE_VALID flag in pppt.c.
>> v3:
>>   - Applied Sudeep's suggestions (for patch 5/5):
>>     - Renaming allocate_cache_info() -> fecth_cache_info()
>>     - Updated error message
>>     - Extract an inline allocate_cache_info() function
>>   - Re-run checkpatch with --strict option
>>
>> Note:
>> This patchset requires the following patch to be applied first in
>> order to avoid the same bug described in the commit message:
>> https://lore.kernel.org/all/20221116094958.2141072-1-pierre.gondois@arm.com/
>>
>> [1] and [2] build the CPU topology from the cacheinfo information for
>> both DT/ACPI based systems and remove (struct cpu_topology).llc_id
>> which was used by ACPI only.
>>
>> Creating the cacheinfo for secondary CPUs is done during early boot.
>> Preemption and interrupts are disabled at this stage. On PREEMPT_RT
>> kernels, allocating memory (and parsing the PPTT table for ACPI based
>> systems) triggers a:
>>    'BUG: sleeping function called from invalid context' [4]
>>
>> To prevent this bug, allocate the cacheinfo from the primary CPU when
>> preemption and interrupts are enabled and before booting secondary
>> CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
>> only, without relying on the arm64 CLIDR_EL1 register.
>> If no cache information is found in the DT/ACPI PPTT, then fallback
>> to the current state, triggering [4] on PREEMPT_RT kernels.
>>
>> Patches to update the arm64 device trees that have incomplete cacheinfo
>> (mostly for missing the 'cache-level' or 'cache-unified' property)
>> have been sent at [3].
>>
>> Tested platforms:
>> - ACPI + PPTT: Ampere Altra, Ampere eMAG, Cavium ThunderX2,
>>    Kunpeng 920, Juno-r2
>> - DT: rb5, db845c, Juno-r2
>>
> 
> I gave the patchset a try with DTS fixes for cache topology on Qualcomm
> RB5 board (SM8250 SoC) and with KASAN it produces:
> 
> BUG: KASAN: slab-out-of-bounds in populate_cache_leaves+0x84/0x15c
> [    0.633014]  dump_backtrace.part.0+0xe0/0xf0
> [    0.633035]  show_stack+0x18/0x40
> [    0.633050]  dump_stack_lvl+0x8c/0xb8
> [    0.633085]  print_report+0x188/0x488
> [    0.633106]  kasan_report+0xac/0xf0
> [    0.633136]  __asan_store4+0x80/0xa4
> [    0.633158]  populate_cache_leaves+0x84/0x15c
> [    0.633181]  detect_cache_attributes+0xc0/0x8c4
> [    0.633213]  update_siblings_masks+0x28/0x43c
> [    0.633235]  store_cpu_topology+0x98/0xc0
> [    0.633251]  smp_prepare_cpus+0x2c/0x15c
> [    0.633281]  kernel_init_freeable+0x22c/0x424
> [    0.633310]  kernel_init+0x24/0x13c
> [    0.633328]  ret_from_fork+0x10/0x20
> [    0.633388]
> [    0.708729] Allocated by task 1:
> [    0.712078]  kasan_save_stack+0x2c/0x60
> [    0.716066]  kasan_set_track+0x2c/0x40
> [    0.719959]  kasan_save_alloc_info+0x24/0x3c
> [    0.724387]  __kasan_kmalloc+0xa0/0xbc
> [    0.728278]  __kmalloc+0x74/0x110
> [    0.731740]  fetch_cache_info+0x170/0x210
> [    0.735902]  init_cpu_topology+0x254/0x2bc
> [    0.740171]  smp_prepare_cpus+0x20/0x15c
> [    0.744272]  kernel_init_freeable+0x22c/0x424
> [    0.748791]  kernel_init+0x24/0x13c
> [    0.752420]  ret_from_fork+0x10/0x20
> 
> Best regards,
> Krzysztof

Hello Krzysztof,
Thanks for trying the patch-set and reporting the issue. Hopefully
the v4 should solve this:
https://lore.kernel.org/all/20230104183033.755668-1-pierre.gondois@arm.com/

I will also try to follow the corresponding dts modifications,

Regards,
Pierre
