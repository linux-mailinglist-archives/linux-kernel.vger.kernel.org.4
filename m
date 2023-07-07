Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E640674AE6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjGGKCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjGGKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:02:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74EE82689
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:00:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26D80D75;
        Fri,  7 Jul 2023 03:01:23 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9A53F740;
        Fri,  7 Jul 2023 03:00:38 -0700 (PDT)
Message-ID: <3500d482-f319-4def-e40d-6d0ae2ada85b@arm.com>
Date:   Fri, 7 Jul 2023 11:00:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
To:     Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
 <ZKcW/Zij1HZB0tmf@casper.infradead.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZKcW/Zij1HZB0tmf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 20:33, Matthew Wilcox wrote:
> On Tue, Jul 04, 2023 at 08:07:19PM -0600, Yu Zhao wrote:
>>>  - On arm64 when the process has marked the VMA for THP (or when
>>> transparent_hugepage=always) but the VMA does not meet the requirements for a
>>> PMD-sized mapping (or we failed to allocate, ...) then I'd like to map using
>>> contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (order-7)
>>> and for 64K this is 2M (order-5). The 64K base page case is very important since
>>> the PMD size for that base page is 512MB which is almost impossible to allocate
>>> in practice.
>>
>> Which case (server or client) are you focusing on here? For our client
>> devices, I can confidently say that 64KB has to be after 16KB, if it
>> happens at all. For servers in general, I don't know of any major
>> memory-intensive workloads that are not THP-aware, i.e., I don't think
>> "VMA does not meet the requirements" is a concern.
> 
> It sounds like you've done some measurements, and I'd like to understand
> those a bit better.  There are a number of factors involved:

I'm not sure if that's a question to me or Yu? I haven't personally done any
measurements for the 64K base page case. But Arm has a partner that is pushing
for this. I'm hoping to see some test results from them posted publicly in the
coming weeks. See [1] for more explanation on the rationale.

[1]
https://lore.kernel.org/linux-mm/4d4c45a2-0037-71de-b182-f516fee07e67@arm.com/T/#m8a7c4b71f94224ec3fe6d0a407f48d74c789ba4f

> 
>  - A larger page size shrinks the length of the LRU list, so systems
>    which see heavy LRU lock contention benefit more
>  - A larger page size has more internal fragmentation, so we run out of
>    memory and have to do reclaim more often (and maybe workload which
>    used to fit in DRAM now do not)
> (probably others; i'm not at 100% right now)
> 
> I think concerns about "allocating lots of order-2 folios makes it harder
> to allocate order-4 folios" are _probably_ not warranted (without data
> to prove otherwise).  All anonymous memory is movable, so our compaction
> code should be able to create larger order folios.
> 

