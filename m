Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31DA64E4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiLOXbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiLOXby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:31:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 441AC511D1;
        Thu, 15 Dec 2022 15:31:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F9651063;
        Thu, 15 Dec 2022 15:32:33 -0800 (PST)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C05C43F73B;
        Thu, 15 Dec 2022 15:31:50 -0800 (PST)
Message-ID: <af294653-ae7b-7fdf-695a-5e48108e795f@arm.com>
Date:   Fri, 16 Dec 2022 05:01:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: errata: refer to config ARM64_ERRATUM_2645198 to
 make workaround work
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221215094811.23188-1-lukas.bulwahn@gmail.com>
 <20221215105745.GA7711@willie-the-truck>
 <b6f61241-e436-5db1-1053-3b441080b8d6@arm.com>
 <20221215194413.GA8094@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221215194413.GA8094@willie-the-truck>
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



On 12/16/22 01:14, Will Deacon wrote:
> On Thu, Dec 15, 2022 at 04:59:20PM +0530, Anshuman Khandual wrote:
>> On 12/15/22 16:27, Will Deacon wrote:
>>> On Thu, Dec 15, 2022 at 10:48:11AM +0100, Lukas Bulwahn wrote:
>>>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>>> index cd8d96e1fa1a..95364e8bdc19 100644
>>>> --- a/arch/arm64/mm/hugetlbpage.c
>>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>>> @@ -562,7 +562,7 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>>>>  
>>>>  pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>>>  {
>>>> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
>>>> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>>>>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>>>>  		/*
>>>>  		 * Break-before-make (BBM) is required for all user space mappings
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 12915f379c22..d77c9f56b7b4 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1633,7 +1633,7 @@ early_initcall(prevent_bootmem_remove_init);
>>>>  
>>>>  pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>>>  {
>>>> -	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
>>>> +	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_2645198) &&
>>>>  	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
>>>>  		/*
>>>>  		 * Break-before-make (BBM) is required for all user space mappings
>>>
>>> Grr, this bug seems to exist in all three versions of the patch reviewed on
>>> the list, so I can only draw the conclusion that this code has never been
>>
>> Ohh, my bad, apologies. I did not have a real system with this erratum, although
>> had emulated and tested this workaround path via some other debug changes (which
>> might have just forced the first condition to always evaluate true).
> 
> "might have"?
> 
>>> tested. Consequently, I'm more inclined to _revert_ the change for now and
>>> we can bring it back as a fix once somebody has checked that it actually
>>> works properly.
>> Please do not revert this change if possible.
> 
> I've gone ahead with the revert anyway, just because it's the easy thing to
> do and we can bring back a fixed version of the patch as a fix in the new
> year. So please send a new version with this fix folded in after you've
> tested that it doesn't cause regressions for systems without the erratum.

Sure, will resend. Again, apologies for this last minute merge window trouble.
