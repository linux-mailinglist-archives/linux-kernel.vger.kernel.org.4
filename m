Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5762D245
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbiKQEYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbiKQEYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:24:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 622875BD75
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 20:24:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6872D13D5;
        Wed, 16 Nov 2022 20:24:19 -0800 (PST)
Received: from [10.162.40.18] (unknown [10.162.40.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 776373F73B;
        Wed, 16 Nov 2022 20:24:09 -0800 (PST)
Message-ID: <53c0c955-7afe-905b-468a-cd7ac81238c5@arm.com>
Date:   Thu, 17 Nov 2022 09:54:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] arm64/mm: fix incorrect file_map_count for invalid
 pmd/pud
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        David Hildenbrand <dhildenb@redhat.com>,
        Rafael Aquini <raquini@redhat.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221116083811.464678-1-liushixin2@huawei.com>
 <20221116083811.464678-3-liushixin2@huawei.com>
 <73189e81-08c2-bb18-dd4a-f717996ea819@redhat.com>
 <Y3UF87Z/a7UVThVF@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3UF87Z/a7UVThVF@FVFF77S0Q05N.cambridge.arm.com>
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



On 11/16/22 21:16, Mark Rutland wrote:
> On Wed, Nov 16, 2022 at 10:08:27AM +0100, David Hildenbrand wrote:
>> On 16.11.22 09:38, Liu Shixin wrote:
>>> The page table check trigger BUG_ON() unexpectedly when split hugepage:
>>>
>>>   ------------[ cut here ]------------
>>>   kernel BUG at mm/page_table_check.c:119!
>>>   Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>>   Dumping ftrace buffer:
>>>      (ftrace buffer empty)
>>>   Modules linked in:
>>>   CPU: 7 PID: 210 Comm: transhuge-stres Not tainted 6.1.0-rc3+ #748
>>>   Hardware name: linux,dummy-virt (DT)
>>>   pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>   pc : page_table_check_set.isra.0+0x398/0x468
>>>   lr : page_table_check_set.isra.0+0x1c0/0x468
>>> [...]
>>>   Call trace:
>>>    page_table_check_set.isra.0+0x398/0x468
>>>    __page_table_check_pte_set+0x160/0x1c0
>>>    __split_huge_pmd_locked+0x900/0x1648
>>>    __split_huge_pmd+0x28c/0x3b8
>>>    unmap_page_range+0x428/0x858
>>>    unmap_single_vma+0xf4/0x1c8
>>>    zap_page_range+0x2b0/0x410
>>>    madvise_vma_behavior+0xc44/0xe78
>>>    do_madvise+0x280/0x698
>>>    __arm64_sys_madvise+0x90/0xe8
>>>    invoke_syscall.constprop.0+0xdc/0x1d8
>>>    do_el0_svc+0xf4/0x3f8
>>>    el0_svc+0x58/0x120
>>>    el0t_64_sync_handler+0xb8/0xc0
>>>    el0t_64_sync+0x19c/0x1a0
>>> [...]
>>>
>>> On arm64, pmd_present() will return true even if the pmd is invalid.
>>
>> I assume that's because of the pmd_present_invalid() check.
>>
>> ... I wonder why that behavior was chosen. Sounds error-prone to me.
> 
> That seems to be down to commit:
> 
>   b65399f6111b03df ("arm64/mm: Change THP helpers to comply with generic MM semantics")
> 
> ... apparently because Andrea Arcangelli said this was necessary in:
> 
>   https://lore.kernel.org/lkml/20181017020930.GN30832@redhat.com/
> 
> ... but that does see to contradict what's said in:
> 
>   Documentation/mm/arch_pgtable_helpers.rst
> 
> ... which just says:
> 
>   pmd_present  Tests a valid mapped PMD

It should be as follows instead, will update. Not sure about PUD level though,
where anon THP is not supported (AFAIK).

+---------------------------+--------------------------------------------------+
| pmd_present               | Tests if pmd_page() points to valid memory page  |
+---------------------------+--------------------------------------------------+

> 
> ... and it's not clear to me why this *only* applies to the PMD level.
> 
> Anshuman?

Because THP is supported at PMD level. As Andrea had explained earlier, pmd_present()
should return positive if pmd_page() on the entry points to valid memory irrespective
of whether the entry is valid/mapped or not. That is the semantics expected in generic
THP during PMD split, collapse, migration etc and other memory code walking past such
PMD entries. That was my understanding.
