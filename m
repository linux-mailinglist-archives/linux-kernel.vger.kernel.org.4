Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F306CBC31
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjC1KNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1KNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:13:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B13C1FEC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:12:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75ACEC14;
        Tue, 28 Mar 2023 03:13:40 -0700 (PDT)
Received: from [10.1.33.143] (C02CF1NRLVDN.cambridge.arm.com [10.1.33.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A6813F663;
        Tue, 28 Mar 2023 03:12:55 -0700 (PDT)
Message-ID: <7981dd12-4e56-a449-980b-52f27279df81@arm.com>
Date:   Tue, 28 Mar 2023 11:12:54 +0100
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
 <d347c5b0-0c0f-ae50-9613-2cf962d8676e@arm.com>
 <babd6fcb-0062-0450-99b3-df5a74c2f683@suse.cz>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <babd6fcb-0062-0450-99b3-df5a74c2f683@suse.cz>
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

On 27/03/2023 16:48, Vlastimil Babka wrote:
> On 3/27/23 17:30, Ryan Roberts wrote:
>> On 27/03/2023 13:41, Vlastimil Babka wrote:
>>> On 2/22/23 04:52, Matthew Wilcox wrote:
>>>> On Tue, Feb 21, 2023 at 03:05:33PM -0800, Yang Shi wrote:
>>>>
>>>>>> C. We add a new wrinkle to the LRU handling code.  When our scan of the
>>>>>>    active list examines a folio, we look to see how many of the PTEs
>>>>>>    mapping the folio have been accessed.  If it is fewer than half, and
>>>>>>    those half are all in either the first or last half of the folio, we
>>>>>>    split it.  The active half stays on the active list and the inactive
>>>>>>    half is moved to the inactive list.
>>>>>
>>>>> With contiguous PTE, every PTE still maintains its own access bit (but
>>>>> it is implementation defined, some implementations may just set access
>>>>> bit once for one PTE in the contiguous region per arm arm IIUC). But
>>>>> anyway this is definitely feasible.
>>>>
>>>> If a CPU doesn't have separate access bits for PTEs, then we should just
>>>> not use the contiguous bits.  Knowing which parts of the folio are
>>>> unused is more important than using the larger TLB entries.
>>>
>>> Hm but AFAIK the AMD aggregation is transparent, there are no bits. And IIUC
>>> the "Hardware Page Aggregation (HPA)" Ryan was talking about elsewhere in
>>> the thread, that sounds similar. So I IIUC there will be a larger TLB entry
>>> transparently, and then I don't expect the CPU to update individual bits as
>>> that would defeat the purpose. So I'd expect it will either set them all to
>>> active when forming the larger TLB entry, or set them on a single subpage
>>> and leave the rest at whatever state they were. Hm I wonder if the exact
>>> behavior is defined anywhere.
>>
>> For arm64, at least, there are 2 separate mechanisms:
>>
>> "The Contiguous Bit" (D8.6.1 in the Arm ARM) is a bit in the translation table
>> descriptor that SW can set to indicate that a set of adjacent entries are
>> contiguous and have same attributes and permissions etc. It is architectural.
>> The order of the contiguous range is fixed and depends on the base page size
>> that is in use. When in use, HW access and dirty reporting is only done at the
>> granularity of the contiguous block.
>>
>> "HPA" is a micro-architectural feature on some Arm CPUs, which aims to do a
>> similar thing, but is transparent to SW. In this case, the dirty and access bits
>> remain per-page. But when they differ, this affects the performance of the feature.
>>
>> Typically HPA can coalesce up to 4 adjacent entries, whereas for a 4KB base page
>> at least, the contiguous bit applies to 16 adjacent entries.
> 
> Hm if it's 4 entries on arm64 and presumably 8 on AMD, maybe we can only
> care about how actively accessed are the individual "subpages" above that
> size, to avoid dealing with this uncertainty whether HW tracks them. At such
> smallish sizes we shouldn't induce massive overhead?

I'm not sure I've fully understood this point. For arm64's HPA, there is no
"uncertainty [about] whether HW tracks them"; HW will always track access/dirty
individually for each base page. The problem is the inverse; if SW (or HW) sets
those bits differently in each page, then TLB coalescing performance may
decrease. Or are you actually suggesting that SW should always set the bits the
same for a 4 or 8 page run, and forgo the extra granularity?

> 
>> I'm hearing that there are workloads where being able to use the contiguous bit
>> really does make a difference, so I would like to explore solutions that can
>> work when we only have access/dirty at the folio level.
> 
> And on the higher orders where we have explicit control via bits, we could
> split the explicitly contiguous mappings once in a while to determine if the
> sub-folios are still accessed? Although maybe with 16x4kB pages limit it may
> still be not worth the trouble?

I have a bigger-picture question; why is it useful to split these large folios?
I think there are 2 potential reasons (but would like to be educated):

1. If a set of sub-pages that were pre-faulted as part of a large folio have
_never_ been accessed and we are under memory pressure, I guess we would like to
split the folio and free those pages?

2. If a set of subpages within a folio are cold (but were written in the past)
and a separate set of subpages within the same folio are hot and we are under
memory pressure, we would like to swap out the cold pages?

If the first reason is important, I guess we would want to initially map
non-contig, then only remap as contig once every subpage has been touched at
least once.

For the second reason, my intuition says that a conceptual single access and
dirty bit per folio should be sufficient, and folios could be split from
time-to-time to see if one half is cold?

Thanks,
Ryan



> 
>> Thanks,
>> Ryan
> 

