Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE8C74D07D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjGJIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjGJInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:43:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1A5319A5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:41:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 219322B;
        Mon, 10 Jul 2023 01:42:02 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2505B3F740;
        Mon, 10 Jul 2023 01:41:18 -0700 (PDT)
Message-ID: <e748c1b8-9fe1-8d4b-5d4c-f7e126154768@arm.com>
Date:   Mon, 10 Jul 2023 09:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
 <ZKgZrNuxuq4ACvIb@casper.infradead.org>
 <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
 <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
 <a8fed7f8-d285-4628-da4b-0ff82c19c582@redhat.com>
 <c5eb896b-dbb4-396d-62f6-5d5dde2d7df6@arm.com>
 <b1e7c52c-cc3a-92c8-e466-3ba5ec2ba2fb@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b1e7c52c-cc3a-92c8-e466-3ba5ec2ba2fb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 20:06, David Hildenbrand wrote:
>>>> I still feel that it would be better for the thp and large anon folio controls
>>>> to be independent though - what's the argument for tying them together?
>>>
>>> Thinking about desired 2 MiB flexible THP on aarch64 (64k kernel) vs, 2 MiB PMD
>>> THP on aarch64 (4k kernel), how are they any different? Just the way they are
>>> mapped ...
>>
>> The last patch in the series shows my current approach to that:
>>
>> int arch_wants_pte_order(struct vm_area_struct *vma)
>> {
>>     if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>>         return CONFIG_ARM64_PTE_ORDER_THP; <<< always the contpte size
>>     else
>>         return CONFIG_ARM64_PTE_ORDER_NOTHP; <<< limited to 64K
>> }
>>
>> But Yu has raised concerns that this type of policy needs to be in the core mm.
>> So we could have the arch blindly return the preferred order from HW perspective
>> (which would be contpte size for arm64). Then for !hugepage_vma_check(), mm
>> could take the min of that value and some determined "acceptable" limit (which
>> in my mind is 64K ;-).
> 
> Yeah, it's really tricky. Because why should arm64 with 64k base pages *not*
> return 2MiB (which is one possible cont-pte size IIRC) ?
> 
> I share the idea that 64k might *currently* on *some platforms* be a reasonable
> choice. But that's where the "fun" begins.
> 
>>
>>>
>>> It's easy to say "64k vs. 2 MiB" is a difference and we want separate controls,
>>> but how is "2MiB vs. 2 MiB" different?
>>>
>>> Having that said, I think we have to make up our mind how much control we want
>>> to give user space. Again, the "2MiB vs. 2 MiB" case nicely shows that it's not
>>> trivial: memory waste is a real issue on some systems where we limit THP to
>>> madvise().
>>>
>>>
>>> Just throwing it out for discussing:
>>>
>>> What about keeping the "all / madvise / never" semantics (and MADV_NOHUGEPAGE
>>> ...) but having an additional config knob that specifies in which cases we
>>> *still* allow flexible THP even though the system was configured for "madvise".
>>>
>>> I can't come up with a good name for that, but something like
>>> "max_auto_size=64k" could be something reasonable to set. We could have an
>>> arch+hw specific default.
>>
>> Ahha, yes, that's essentially what I have above. I personally also like the idea
>> of the limit being an absolute value rather than an order. Although I know Yu
>> feels differently (see [1]).
> 
> Exposed to user space I think it should be a human-readable value. Inside the
> kernel, I don't particularly care.

My point was less about human-readable vs not. It was about expressing a value
that is relative to the base page size vs expressing a value that is independent
of base page size. If the concern is about limiting internal fragmentation, I
think its the absolute size that matters.

> 
> (Having databases/VMs on arch64 with 64k in mind) I think it might be
> interesting to have something like the following:
> 
> thp=madvise
> max_auto_size=64k/128k/256k
> 
> 
> So in MADV_HUGEPAGE VMAs (such as under QEMU), we'd happily take any flexible
> THP, especially ones < PMD THP (512 MiB) as well. 2 MiB or 4 MiB THP? sure, give
> them to my VM. You're barely going to find 512 MiB THP either way in practice ....
> 
> But for the remainder of my system, just do something reasonable and don't go
> crazy on the memory waste.

Yep, we're on the same page. I've got a v3 that's almost ready to go, based on
Yu's prevuous round of review. I'm going to encorporate this mechanism into it
then post hopefully later in the week. Now I just need to figure out a decent
name for the max_auto_size control...

> 
> 
> I'll try reading all the previous discussions next week.
> 

