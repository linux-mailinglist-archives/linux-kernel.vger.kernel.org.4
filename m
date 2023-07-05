Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B3748B2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjGESB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjGESBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:01:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62E7419A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:01:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 399E21763;
        Wed,  5 Jul 2023 11:01:55 -0700 (PDT)
Received: from [10.57.76.116] (unknown [10.57.76.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C29C3F762;
        Wed,  5 Jul 2023 11:01:11 -0700 (PDT)
Message-ID: <cc8327e9-f27e-20d1-1f96-2a3506e7707f@arm.com>
Date:   Wed, 5 Jul 2023 19:01:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
 <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com>
 <CAOUHufZypv+kLFu3r8iPYbceBh0KSE=gus-_iC1Q35_QVQdnMQ@mail.gmail.com>
 <9c5f3515-ad39-e416-902e-96e9387a3b60@arm.com>
 <CAOUHufYvRYO=x==+i1aDQHvO=fx_sa6kmi5T4CMvsYiw1wgWqw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufYvRYO=x==+i1aDQHvO=fx_sa6kmi5T4CMvsYiw1wgWqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 18:24, Yu Zhao wrote:
> On Wed, Jul 5, 2023 at 3:11 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 05/07/2023 03:07, Yu Zhao wrote:
>>> On Tue, Jul 4, 2023 at 7:20 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 03/07/2023 20:50, Yu Zhao wrote:
>>>>> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> arch_wants_pte_order() can be overridden by the arch to return the
>>>>>> preferred folio order for pte-mapped memory. This is useful as some
>>>>>> architectures (e.g. arm64) can coalesce TLB entries when the physical
>>>>>> memory is suitably contiguous.
>>>>>>
>>>>>> The first user for this hint will be FLEXIBLE_THP, which aims to
>>>>>> allocate large folios for anonymous memory to reduce page faults and
>>>>>> other per-page operation costs.
>>>>>>
>>>>>> Here we add the default implementation of the function, used when the
>>>>>> architecture does not define it, which returns the order corresponding
>>>>>> to 64K.
>>>>>
>>>>> I don't really mind a non-zero default value. But people would ask why
>>>>> non-zero and why 64KB. Probably you could argue this is the large size
>>>>> all known archs support if they have TLB coalescing. For x86, AMD CPUs
>>>>> would want to override this. I'll leave it to Fengwei to decide
>>>>> whether Intel wants a different default value.>
>>>>> Also I don't like the vma parameter because it makes
>>>>> arch_wants_pte_order() a mix of hw preference and vma policy. From my
>>>>> POV, the function should be only about the former; the latter should
>>>>> be decided by arch-independent MM code. However, I can live with it if
>>>>> ARM MM people think this is really what you want. ATM, I'm skeptical
>>>>> they do.
>>>>
>>>> Here's the big picture for what I'm tryng to achieve:
>>>>
>>>>  - In the common case, I'd like all programs to get a performance bump by
>>>> automatically and transparently using large anon folios - so no explicit
>>>> requirement on the process to opt-in.
>>>
>>> We all agree on this :)
>>>
>>>>  - On arm64, in the above case, I'd like the preferred folio size to be 64K;
>>>> from the (admittedly limitted) testing I've done that's about where the
>>>> performance knee is and it doesn't appear to increase the memory wastage very
>>>> much. It also has the benefits that for 4K base pages this is the contpte size
>>>> (order-4) so I can take full benefit of contpte mappings transparently to the
>>>> process. And for 16K this is the HPA size (order-2).
>>>
>>> My highest priority is to get 16KB proven first because it would
>>> benefit both client and server devices. So it may be different from
>>> yours but I don't see any conflict.
>>
>> Do you mean 16K folios on a 4K base page system
> 
> Yes.
> 
>> or large folios on a 16K base
>> page system? I thought your focus was on speeding up 4K base page client systems
>> but this statement has got me wondering?
> 
> Sorry, I should have said 4x4KB.

OK. Be aware that a number of Arm CPUs that support HPA don't have it enabled by
default (or at least don't have it enabled in the mode that you would want it to
see best performance with large anon folios). You would need EL3 access to
reconfigure it.

> 
>>>>  - On arm64 when the process has marked the VMA for THP (or when
>>>> transparent_hugepage=always) but the VMA does not meet the requirements for a
>>>> PMD-sized mapping (or we failed to allocate, ...) then I'd like to map using
>>>> contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (order-7)
>>>> and for 64K this is 2M (order-5). The 64K base page case is very important since
>>>> the PMD size for that base page is 512MB which is almost impossible to allocate
>>>> in practice.
>>>
>>> Which case (server or client) are you focusing on here? For our client
>>> devices, I can confidently say that 64KB has to be after 16KB, if it
>>> happens at all. For servers in general, I don't know of any major
>>> memory-intensive workloads that are not THP-aware, i.e., I don't think
>>> "VMA does not meet the requirements" is a concern.
>>
>> For the 64K base page case, the focus is server. The problem reported by our
>> partner is that the 512M huge page size is too big to reliably allocate and so
>> the fauls always fall back to 64K base pages in practice. I would also speculate
>> (happy to be proved wrong) that there are many THP-aware workloads that assume
>> the THP size is 2M. In this case, their VMAs may well be too small to fit a 512M
>> huge page when running on 64K base page system.
> 
> Interesting. When you have something ready to share, I might be able
> to try it on our ARM servers as well.

That would be really helpful. I'm currently updating my branch that collates
everything to reflect the review comments in this patch set and the contpte
patch set. I'll share it in a couple of weeks.

> 
>> But the TL;DR is that Arm has a partner for which enabling 2M THP on a 64K base
>> page system is a very real requirement. Our intent is that this will be the
>> mechanism we use to enable it.
> 
> Yes, contpte makes more sense for what you described. It'd fit in a
> lot better in the hugetlb case, but I guess your partner uses anon.

arm64 already supports contpte for hugetlb, but they need it to work with anon
memory using THP.


