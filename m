Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E973F97F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjF0KAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjF0KAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:00:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F05330E4;
        Tue, 27 Jun 2023 02:57:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E20E92F4;
        Tue, 27 Jun 2023 02:58:34 -0700 (PDT)
Received: from [10.1.30.74] (C02Z41KALVDN.cambridge.arm.com [10.1.30.74])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 202713F64C;
        Tue, 27 Jun 2023 02:57:48 -0700 (PDT)
Message-ID: <0c98f854-b4e4-9a71-8e0c-1556bc79468c@arm.com>
Date:   Tue, 27 Jun 2023 10:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 10/10] mm: Allocate large folios for anonymous memory
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
 <20230626171430.3167004-11-ryan.roberts@arm.com>
 <CAOUHufarua_JmnTu5NM-W3K4Togw+24F=Pf0HU0ZOjuwbRMC0A@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufarua_JmnTu5NM-W3K4Togw+24F=Pf0HU0ZOjuwbRMC0A@mail.gmail.com>
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

On 27/06/2023 04:01, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:15 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> With all of the enabler patches in place, modify the anonymous memory
>> write allocation path so that it opportunistically attempts to allocate
>> a large folio up to `max_anon_folio_order()` size (This value is
>> ultimately configured by the architecture). This reduces the number of
>> page faults, reduces the size of (e.g. LRU) lists, and generally
>> improves performance by batching what were per-page operations into
>> per-(large)-folio operations.
>>
>> If CONFIG_LARGE_ANON_FOLIO is not enabled (the default) then
>> `max_anon_folio_order()` always returns 0, meaning we get the existing
>> allocation behaviour.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/memory.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 144 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index a8f7e2b28d7a..d23c44cc5092 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3161,6 +3161,90 @@ static inline int max_anon_folio_order(struct vm_area_struct *vma)
>>                 return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
>>  }
>>
>> +/*
>> + * Returns index of first pte that is not none, or nr if all are none.
>> + */
>> +static inline int check_ptes_none(pte_t *pte, int nr)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               if (!pte_none(ptep_get(pte++)))
>> +                       return i;
>> +       }
>> +
>> +       return nr;
>> +}
>> +
>> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)
> 
> As suggested previously in 03/10, we can leave this for later.

I disagree. This is the logic that prevents us from accidentally replacing
already set PTEs, or wandering out of the VMA bounds etc. How would you catch
all those corener cases without this?
