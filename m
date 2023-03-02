Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBF6A7C23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjCBH5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBH5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:57:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 551E934300;
        Wed,  1 Mar 2023 23:57:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24BF71FB;
        Wed,  1 Mar 2023 23:57:57 -0800 (PST)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC573F587;
        Wed,  1 Mar 2023 23:57:11 -0800 (PST)
Message-ID: <1fa898da-efdf-cf39-4be9-1d0354d3fa41@arm.com>
Date:   Thu, 2 Mar 2023 13:27:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm/debug_vm_pgtable: Replace pte_mkhuge() with
 arch_make_huge_pte()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "david@redhat.com" <david@redhat.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230302031833.360679-1-anshuman.khandual@arm.com>
 <94473cc4-f84f-d42d-2bd1-b6389d8c9ab3@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <94473cc4-f84f-d42d-2bd1-b6389d8c9ab3@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/23 12:31, Christophe Leroy wrote:
> 
> 
> Le 02/03/2023 à 04:18, Anshuman Khandual a écrit :
>> Since the following commit arch_make_huge_pte() should be used directly in
>> generic memory subsystem as a platform provided page table helper, instead
>> of pte_mkhuge(). Change hugetlb_basic_tests() to call arch_make_huge_pte()
>> directly, and update its relevant documentation entry as required.
>>
>> 'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'
>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on latest mainline.
>>
>>   Documentation/mm/arch_pgtable_helpers.rst | 2 +-
>>   mm/debug_vm_pgtable.c                     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
>> index 30d9a09f01f4..af3891f895b0 100644
>> --- a/Documentation/mm/arch_pgtable_helpers.rst
>> +++ b/Documentation/mm/arch_pgtable_helpers.rst
>> @@ -214,7 +214,7 @@ HugeTLB Page Table Helpers
>>   +---------------------------+--------------------------------------------------+
>>   | pte_huge                  | Tests a HugeTLB                                  |
>>   +---------------------------+--------------------------------------------------+
>> -| pte_mkhuge                | Creates a HugeTLB                                |
>> +| arch_make_huge_pte        | Creates a HugeTLB                                |
>>   +---------------------------+--------------------------------------------------+
>>   | huge_pte_dirty            | Tests a dirty HugeTLB                            |
>>   +---------------------------+--------------------------------------------------+
>> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
>> index af59cc7bd307..92bed5bd5879 100644
>> --- a/mm/debug_vm_pgtable.c
>> +++ b/mm/debug_vm_pgtable.c
>> @@ -934,7 +934,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
>>   #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
>>   	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
>>   
>> -	WARN_ON(!pte_huge(pte_mkhuge(pte)));
>> +	WARN_ON(!pte_huge(arch_make_huge_pte(pte)));
> 
> Did you build it ?

Ahh bad ! Built on arm64 which does not subscribe ARCH_WANT_GENERAL_HUGETLB.

> 
> arch_make_huge_pte() need 3 arguments.

Could call it with constants such as PMD_SHIFT and standard vm_flags without
involving real arg based values (as they are not initialized for HugeTLB).
But wondering if platform arch_make_huge_pte() implementation might complain.

arch_make_huge_pte(pte, PMD_SHIFT, VM_READ | VM_WRITE)
