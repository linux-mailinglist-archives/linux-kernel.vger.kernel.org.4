Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8636CA900
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjC0Pah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjC0Paf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:30:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 972AD3C15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:30:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B582C14;
        Mon, 27 Mar 2023 08:31:17 -0700 (PDT)
Received: from [10.57.65.10] (unknown [10.57.65.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BE0A3F6C4;
        Mon, 27 Mar 2023 08:30:32 -0700 (PDT)
Message-ID: <d347c5b0-0c0f-ae50-9613-2cf962d8676e@arm.com>
Date:   Mon, 27 Mar 2023 16:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: What size anonymous folios should we allocate?
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <Y/U8bQd15aUO97vS@casper.infradead.org>
 <CAHbLzkrkZmbVMkh-Y-bDxgy0T0ZRRd+T+o5y5-wKmjKmhN0NmA@mail.gmail.com>
 <Y/WRlX+MkmxelNbg@casper.infradead.org>
 <022e1c15-7988-9975-acbc-e661e989ca4a@suse.cz>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <022e1c15-7988-9975-acbc-e661e989ca4a@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 13:41, Vlastimil Babka wrote:
> On 2/22/23 04:52, Matthew Wilcox wrote:
>> On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
>>
>>>> C. We add a new wrinkle to the LRU handling code.  When our scan of the
>>>>    active list examines a folio, we look to see how many of the PTEs
>>>>    mapping the folio have been accessed.  If it is fewer than half, and
>>>>    those half are all in either the first or last half of the folio, we
>>>>    split it.  The active half stays on the active list and the inactive
>>>>    half is moved to the inactive list.
>>>
>>> With contiguous PTE, every PTE still maintains its own access bit (but
>>> it is implementation defined, some implementations may just set access
>>> bit once for one PTE in the contiguous region per arm arm IIUC). But
>>> anyway this is definitely feasible.
>>
>> If a CPU doesn't have separate access bits for PTEs, then we should just
>> not use the contiguous bits.  Knowing which parts of the folio are
>> unused is more important than using the larger TLB entries.
> 
> Hm but AFAIK the AMD aggregation is transparent, there are no bits. And IIUC
> the "Hardware Page Aggregation (HPA)" Ryan was talking about elsewhere in
> the thread, that sounds similar. So I IIUC there will be a larger TLB entry
> transparently, and then I don't expect the CPU to update individual bits as
> that would defeat the purpose. So I'd expect it will either set them all to
> active when forming the larger TLB entry, or set them on a single subpage
> and leave the rest at whatever state they were. Hm I wonder if the exact
> behavior is defined anywhere.

For arm64, at least, there are 2 separate mechanisms:

"The Contiguous Bit" (D8.6.1 in the Arm ARM) is a bit in the translation table
descriptor that SW can set to indicate that a set of adjacent entries are
contiguous and have same attributes and permissions etc. It is architectural.
The order of the contiguous range is fixed and depends on the base page size
that is in use. When in use, HW access and dirty reporting is only done at the
granularity of the contiguous block.

"HPA" is a micro-architectural feature on some Arm CPUs, which aims to do a
similar thing, but is transparent to SW. In this case, the dirty and access bits
remain per-page. But when they differ, this affects the performance of the feature.

Typically HPA can coalesce up to 4 adjacent entries, whereas for a 4KB base page
at least, the contiguous bit applies to 16 adjacent entries.

I'm hearing that there are workloads where being able to use the contiguous bit
really does make a difference, so I would like to explore solutions that can
work when we only have access/dirty at the folio level.

Thanks,
Ryan



> 
>>>> For the third case, in contrast, the parent had already established
>>>> an appropriate size folio to use for this VMA before calling fork().
>>>> Whether it is the parent or the child causing the COW, it should probably
>>>> inherit that choice and we should default to the same size folio that
>>>> was already found.
>>>
>>> Actually this is not what THP does now. The current THP behavior is to
>>> split the PMD then fallback to order-0 page fault. For smaller orders,
>>> we may consider allocating a large folio.
>>
>> I know it's not what THP does now.  I think that's because the gap
>> between PMD and PAGE size is too large and we end up wasting too much
>> memory.  We also have very crude mechanisms for determining when to
>> use THPs.  With the adaptive mechanism I described above, I think it's
>> time to change that.
>>
>>
> 

