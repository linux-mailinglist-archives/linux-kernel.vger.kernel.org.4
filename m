Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42435634EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 05:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiKWE1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 23:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235673AbiKWE1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 23:27:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DA5E63F4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 20:27:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D9F11FB;
        Tue, 22 Nov 2022 20:27:48 -0800 (PST)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B0A73F587;
        Tue, 22 Nov 2022 20:27:39 -0800 (PST)
Message-ID: <3e6edbea-d5ac-1d2e-737d-ceb7c7e7d7fe@arm.com>
Date:   Wed, 23 Nov 2022 09:57:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64/mm: Intercept pfn changes in set_pte_at()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20221116031001.292236-1-anshuman.khandual@arm.com>
 <20221118141317.GF4046@willie-the-truck>
 <879e561c-e834-196c-b9c5-6e44ac2c0296@arm.com>
 <20221122095748.GA19471@willie-the-truck> <Y3yuUizzhVe+vLlL@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3yuUizzhVe+vLlL@FVFF77S0Q05N>
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



On 11/22/22 16:41, Mark Rutland wrote:
> On Tue, Nov 22, 2022 at 09:57:49AM +0000, Will Deacon wrote:
>> On Tue, Nov 22, 2022 at 01:43:17PM +0530, Anshuman Khandual wrote:
>>>
>>>
>>> On 11/18/22 19:43, Will Deacon wrote:
>>>> On Wed, Nov 16, 2022 at 08:40:01AM +0530, Anshuman Khandual wrote:
>>>>> Changing pfn on a user page table mapped entry, without first going through
>>>>> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
>>>>> to intercept such changes, via an updated pgattr_change_is_safe(). This new
>>>>> check happens via __check_racy_pte_update(), which has now been renamed as
>>>>> __check_safe_pte_update().
>>>>>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will@kernel.org>
>>>>> Cc: Mark Rutland <mark.rutland@arm.com> 
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org> 
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>> ---
>>>>> This applies on v6.1-rc4
>>>>>
>>>>>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>>>>>  arch/arm64/mm/mmu.c              | 8 +++++++-
>>>>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>>>
>>>> I remember Mark saying that BBM is sometimes violated by the core code in
>>>> cases where the pte isn't actually part of a live pgtable (e.g. if it's on
>>>> the stack or part of a newly allocated table). Won't that cause false
>>>> positives here?
>>>
>>> Could you please elaborate ? If the pte is not on a live page table, then
>>> pte_valid() will return negative on such entries. So any update there will
>>> be safe. I am wondering, how this change will cause false positives which
>>> would not have been possible earlier.
>>
>> I don't think pte_valid() will always return false for these entries.
>> Consider, for example, ptes which are valid but which live in a table that
>> is not reachable by the MMU. I think this is what Mark had in mind, but it
>> would be helpful if he could chime in with the specific example he ran into.
> 
> Yup -- that was the case I had in mind. IIRC I hit that in the past when trying
> to do something similar, but I can't recall exactly where that was. I suspect
> that was probably to do with page migration or huge page splitting/merging.
> 
> Looking around, at least __split_huge_zero_page_pmd() and
> __split_huge_pmd_locked() do something like that, creating a temporary pmd
> entry on the stack, populating a table of non-live but valid ptes, then
> plumbing it into the real pmd.

In both cases i.e __split_huge_zero_page_pmd() and __split_huge_pmd_locked(), the
entry is first asserted to be empty via pte_none(), before writing a new value in
there. set_pte_at() would still consider such updates safe because pfn_valid(old)
will return negative on such entries.

	VM_BUG_ON(!pte_none(*pte));
	set_pte_at(mm, haddr, pte, entry);

But if these entries still get updated yet again (while still being inactive) with
new pte values, then set_pte_at() would complain for the pfn update on the entry,
while being "valid". But is this a viable scenario ?

> 
> We'd need to check that there aren't other cases like that.
> 
Sure, might be some what tricky but anything in particular to be looked into ? I
guess if this change gets into a CI system which runs all memory stress tests for
long enough with CONFIG_DEBUG_VM enabled, we might get some more clue if there 
are other similar scenarios possible. 
