Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B7E742500
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF2LcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjF2Lb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 07:31:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 714C8132;
        Thu, 29 Jun 2023 04:31:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C511DC14;
        Thu, 29 Jun 2023 04:32:39 -0700 (PDT)
Received: from [10.1.27.40] (C02Z41KALVDN.cambridge.arm.com [10.1.27.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45CFC3F64C;
        Thu, 29 Jun 2023 04:31:53 -0700 (PDT)
Message-ID: <09ef8f66-6697-d803-89ac-228a6fe2e604@arm.com>
Date:   Thu, 29 Jun 2023 12:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 08/10] mm: Kconfig hooks to determine max anon folio
 allocation order
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-9-ryan.roberts@arm.com>
 <CAHbLzkpScGq-ja2A6dRffG8qbrVuwXzkMpFvSq_Fzdqp2wUwPA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkpScGq-ja2A6dRffG8qbrVuwXzkMpFvSq_Fzdqp2wUwPA@mail.gmail.com>
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

On 29/06/2023 02:38, Yang Shi wrote:
> On Mon, Jun 26, 2023 at 10:15 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> For variable-order anonymous folios, we need to determine the order that
>> we will allocate. From a SW perspective, the higher the order we
>> allocate, the less overhead we will have; fewer faults, fewer folios in
>> lists, etc. But of course there will also be more memory wastage as the
>> order increases.
>>
>> From a HW perspective, there are memory block sizes that can be
>> beneficial to reducing TLB pressure. arm64, for example, has the ability
>> to map "contpte" sized chunks (64K for a 4K base page, 2M for 16K and
>> 64K base pages) such that one of these chunks only uses a single TLB
>> entry.
>>
>> So we let the architecture specify the order of the maximally beneficial
>> mapping unit when PTE-mapped. Furthermore, because in some cases, this
>> order may be quite big (and therefore potentially wasteful of memory),
>> allow the arch to specify 2 values; One is the max order for a mapping
>> that _would not_ use THP if all size and alignment constraints were met,
>> and the other is the max order for a mapping that _would_ use THP if all
>> those constraints were met.
>>
>> Implement this with Kconfig by introducing some new options to allow the
>> architecture to declare that it supports large anonymous folios along
>> with these 2 preferred max order values. Then introduce a user-facing
>> option, LARGE_ANON_FOLIO, which defaults to disabled and can only be
>> enabled if the architecture has declared its support. When disabled, it
>> forces the max order values, LARGE_ANON_FOLIO_NOTHP_ORDER_MAX and
>> LARGE_ANON_FOLIO_THP_ORDER_MAX to 0, meaning only a single page is ever
>> allocated.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/Kconfig  | 39 +++++++++++++++++++++++++++++++++++++++
>>  mm/memory.c |  8 ++++++++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 7672a22647b4..f4ba48c37b75 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1208,4 +1208,43 @@ config PER_VMA_LOCK
>>
>>  source "mm/damon/Kconfig"
>>
>> +config ARCH_SUPPORTS_LARGE_ANON_FOLIO
>> +       def_bool n
>> +       help
>> +         An arch should select this symbol if wants to allow LARGE_ANON_FOLIO
>> +         to be enabled. It must also set the following integer values:
>> +         - ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
>> +         - ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
>> +
>> +config ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
>> +       int
>> +       help
>> +         The maximum size of folio to allocate for an anonymous VMA PTE-mapping
>> +         that does not have the MADV_HUGEPAGE hint set.
>> +
>> +config ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
>> +       int
>> +       help
>> +         The maximum size of folio to allocate for an anonymous VMA PTE-mapping
>> +         that has the MADV_HUGEPAGE hint set.
>> +
>> +config LARGE_ANON_FOLIO
>> +       bool "Allocate large folios for anonymous memory"
>> +       depends on ARCH_SUPPORTS_LARGE_ANON_FOLIO
>> +       default n
>> +       help
>> +         Use large (bigger than order-0) folios to back anonymous memory where
>> +         possible. This reduces the number of page faults, as well as other
>> +         per-page overheads to improve performance for many workloads.
>> +
>> +config LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
>> +       int
>> +       default 0 if !LARGE_ANON_FOLIO
>> +       default ARCH_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX
>> +
>> +config LARGE_ANON_FOLIO_THP_ORDER_MAX
>> +       int
>> +       default 0 if !LARGE_ANON_FOLIO
>> +       default ARCH_LARGE_ANON_FOLIO_THP_ORDER_MAX
>> +
> 
> IMHO I don't think we need all of the new kconfigs. Ideally the large
> anon folios could be supported by all arches, although some of them
> may not benefit from larger TLB entries due to lack of hardware
> support.t
> 
> For now with a minimum implementation, I think you could define a
> macro or a function that returns the hardware preferred order.

Thanks for the feedback - that aligns with what Yu Zhao suggested. I'm
implementing it for v2.

Thanks,
Ryan


> 
>>  endmenu
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 9165ed1b9fc2..a8f7e2b28d7a 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3153,6 +3153,14 @@ static struct folio *try_vma_alloc_movable_folio(struct vm_area_struct *vma,
>>         return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
>>  }
>>
>> +static inline int max_anon_folio_order(struct vm_area_struct *vma)
>> +{
>> +       if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
>> +               return CONFIG_LARGE_ANON_FOLIO_THP_ORDER_MAX;
>> +       else
>> +               return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
>> +}
>> +
>>  /*
>>   * Handle write page faults for pages that can be reused in the current vma
>>   *
>> --
>> 2.25.1
>>
>>

