Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D3B64DA42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLOL33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 06:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 06:29:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E534B2A436;
        Thu, 15 Dec 2022 03:29:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FAD1063;
        Thu, 15 Dec 2022 03:30:05 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 381573F5A1;
        Thu, 15 Dec 2022 03:29:22 -0800 (PST)
Message-ID: <b6f61241-e436-5db1-1053-3b441080b8d6@arm.com>
Date:   Thu, 15 Dec 2022 16:59:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: errata: refer to config ARM64_ERRATUM_2645198 to
 make workaround work
Content-Language: en-US
To:     Will Deacon <will@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
 <20221215105745.GA7711@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221215105745.GA7711@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 16:27, Will Deacon wrote:
> On Thu, Dec 15, 2022 at 10:48:11AM +0100, Lukas Bulwahn wrote:
>> Commit 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715
>> [ESR|FAR]_ELx corruption") implements a workaround for arm64 erratum
>> 2645198. The arm64 cpucaps is called WORKAROUND_2645198; the kernel build
>> configuration is called ARM64_ERRATUM_2645198.
>>
>> In the functions huge_ptep_modify_prot_start() and
>> ptep_modify_prot_start(), the code accidently refers to the non-existing
>> config CONFIG_ARM64_WORKAROUND_2645198. Note that the config name uses
>> ERRATUM, not WORKAROUND. By this accidental misreference, this condition is
>> always false, the branch of the workaround is not reachable and the
>> workaround is effectively not implemented at all.
>>
>> Refer to the intended config ARM64_ERRATUM_2645198 and make the intended
>> workaround effectively work.
>>
>> Fixes: 44ecda71fd8a ("arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption")
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>> ---
>>  arch/arm64/mm/hugetlbpage.c | 2 +-
>>  arch/arm64/mm/mmu.c         | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks for the report!
> 
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index cd8d96e1fa1a..95364e8bdc19 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -562,7 +562,7 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>>  
>>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>  {
>> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
>> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>>  		/*
>>  		 * Break-before-make (BBM) is required for all user space mappings
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 12915f379c22..d77c9f56b7b4 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1633,7 +1633,7 @@ early_initcall(prevent_bootmem_remove_init);
>>  
>>  pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>  {
>> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
>> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>>  		/*
>>  		 * Break-before-make (BBM) is required for all user space mappings
> 
> Grr, this bug seems to exist in all three versions of the patch reviewed on
> the list, so I can only draw the conclusion that this code has never been

Ohh, my bad, apologies. I did not have a real system with this erratum, although
had emulated and tested this workaround path via some other debug changes (which
might have just forced the first condition to always evaluate true).

> tested. Consequently, I'm more inclined to _revert_ the change for now and
> we can bring it back as a fix once somebody has checked that it actually
> works properly.
Please do not revert this change if possible.
