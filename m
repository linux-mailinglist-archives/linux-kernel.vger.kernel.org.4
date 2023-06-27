Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA473F5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjF0H2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjF0H1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:27:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4524D1716;
        Tue, 27 Jun 2023 00:27:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8111411FB;
        Tue, 27 Jun 2023 00:28:13 -0700 (PDT)
Received: from [10.57.76.16] (unknown [10.57.76.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 476E23F663;
        Tue, 27 Jun 2023 00:27:26 -0700 (PDT)
Message-ID: <a729a5cb-2376-869b-96dd-cb1babac04d2@arm.com>
Date:   Tue, 27 Jun 2023 08:27:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 02/10] mm: pass gfp flags and order to
 vma_alloc_zeroed_movable_folio()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
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
 <20230626171430.3167004-3-ryan.roberts@arm.com>
 <CAOUHufYWtsAU4PvKpVhzJUeQb9cd+BifY9KzgceBXHp2F2dDRg@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufYWtsAU4PvKpVhzJUeQb9cd+BifY9KzgceBXHp2F2dDRg@mail.gmail.com>
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

On 27/06/2023 03:27, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Allow allocation of large folios with vma_alloc_zeroed_movable_folio().
>> This prepares the ground for large anonymous folios. The generic
>> implementation of vma_alloc_zeroed_movable_folio() now uses
>> clear_huge_page() to zero the allocated folio since it may now be a
>> non-0 order.
>>
>> Currently the function is always called with order 0 and no extra gfp
>> flags, so no functional change intended. But a subsequent commit will
>> take advantage of the new parameters to allocate large folios. The extra
>> gfp flags will be used to control the reclaim policy.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/alpha/include/asm/page.h   |  5 +++--
>>  arch/arm64/include/asm/page.h   |  3 ++-
>>  arch/arm64/mm/fault.c           |  7 ++++---
>>  arch/ia64/include/asm/page.h    |  5 +++--
>>  arch/m68k/include/asm/page_no.h |  7 ++++---
>>  arch/s390/include/asm/page.h    |  5 +++--
>>  arch/x86/include/asm/page.h     |  5 +++--
>>  include/linux/highmem.h         | 23 +++++++++++++----------
>>  mm/memory.c                     |  5 +++--
>>  9 files changed, 38 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/alpha/include/asm/page.h b/arch/alpha/include/asm/page.h
>> index 4db1ebc0ed99..6fc7fe91b6cb 100644
>> --- a/arch/alpha/include/asm/page.h
>> +++ b/arch/alpha/include/asm/page.h
>> @@ -17,8 +17,9 @@
>>  extern void clear_page(void *page);
>>  #define clear_user_page(page, vaddr, pg)       clear_page(page)
>>
>> -#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
>> -       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, false)
>> +#define vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order) \
>> +       vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO | (gfp), \
>> +                       order, vma, vaddr, false)
> 
> I don't think we need to worry about gfp if we want to make a minimum
> series. There would be many discussion points around it, e.g., I
> already disagree with what you chose: GFP_TRANSHUGE_LIGHT would be
> more suitable than __GFP_NORETRY, and there are even better options
> than GFP_TRANSHUGE_LIGHT.

OK, but disagreeing about what the GFP flags should be is different from
disagreeing about whether we need a mechanism for specifying them. Given I need
to do the changes to add `order` I thought it was sensible to add the gfp flags
at the same time.

I'll follow your advice and remove the gfp flag addition for now.
