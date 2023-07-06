Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F617496FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjGFICj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjGFICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:02:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97E431726
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:02:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34F832F4;
        Thu,  6 Jul 2023 01:03:16 -0700 (PDT)
Received: from [10.57.76.116] (unknown [10.57.76.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F5A53F73F;
        Thu,  6 Jul 2023 01:02:32 -0700 (PDT)
Message-ID: <4d4c45a2-0037-71de-b182-f516fee07e67@arm.com>
Date:   Thu, 6 Jul 2023 09:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/5] variable-order, large folios for anonymous memory
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <78159ed0-a233-9afb-712f-2df1a4858b22@redhat.com>
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

On 05/07/2023 20:38, David Hildenbrand wrote:
> On 03.07.23 15:53, Ryan Roberts wrote:
>> Hi All,
>>
>> This is v2 of a series to implement variable order, large folios for anonymous
>> memory. The objective of this is to improve performance by allocating larger
>> chunks of memory during anonymous page faults. See [1] for background.
>>

[...]

>> Thanks,
>> Ryan
> 
> Hi Ryan,
> 
> is page migration already working as expected (what about page compaction?), and
> do we handle migration -ENOMEM when allocating a target page: do we split an
> fallback to 4k page migration?
> 

Hi David, All,

This series aims to be the bare minimum to demonstrate allocation of large anon
folios. As such, there is a laundry list of things that need to be done for this
feature to play nicely with other features. My preferred route is to merge this
with it's Kconfig defaulted to disabled, and its Kconfig description clearly
shouting that it's EXPERIMENTAL with an explanation of why (similar to
READ_ONLY_THP_FOR_FS).

That said, I've put together a table of the items that I'm aware of that need
attention. It would be great if people can review and add any missing items.
Then we can hopefully parallelize the implementation work. David, I don't think
the items you raised are covered - would you mind providing a bit more detail so
I can add them to the list? (or just add them to the list yourself, if you prefer).

---

- item:
    mlock

  description: >-
    Large, pte-mapped folios are ignored when mlock is requested. Code comment
    for mlock_vma_folio() says "...filter out pte mappings of THPs, which
    cannot be consistently counted: a pte mapping of the THP head cannot be
    distinguished by the page alone."

  location:
    - mlock_pte_range()
    - mlock_vma_folio()

  assignee:
    Yin, Fengwei


- item:
    numa balancing

  description: >-
    Large, pte-mapped folios are ignored by numa-balancing code. Commit
    comment (e81c480): "We're going to have THP mapped with PTEs. It will
    confuse numabalancing. Let's skip them for now."

  location:
    - do_numa_page()

  assignee:
    <none>


- item:
    madvise

  description: >-
    MADV_COLD, MADV_PAGEOUT, MADV_FREE: For large folios, code assumes
    exclusive only if mapcount==1, else skips remainder of operation. For
    large, pte-mapped folios, exclusive folios can have mapcount upto nr_pages
    and still be exclusive. Even better; don't split the folio if it fits
    entirely within the range? Discussion at

https://lore.kernel.org/linux-mm/6cec6f68-248e-63b4-5615-9e0f3f819a0a@redhat.com/
    talks about changing folio mapcounting - may help determine if exclusive
    without pgtable scan?

  location:
    - madvise_cold_or_pageout_pte_range()
    - madvise_free_pte_range()

  assignee:
    <none>


- item:
    shrink_folio_list

  description: >-
    Raised by Yu Zhao; I can't see the problem in the code - need
    clarification

  location:
    - shrink_folio_list()

  assignee:
    <none>


- item:
    compaction

  description: >-
    Raised at LSFMM: Compaction skips non-order-0 pages. Already problem for
    page-cache pages today. Is my understand correct?

  location:
    - <where?>

  assignee:
    <none>
---

Thanks,
Ryan


