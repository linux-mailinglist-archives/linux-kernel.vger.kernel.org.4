Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA1686AFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjBAP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBAP54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514EF77503
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675267007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tBjSgCtYL9pRIH06vB5AfhXuNshNbv18W+fXQWNuIh8=;
        b=BiP0v+ziJ4fhksxgIr9F0U0I7OmTh3a/zCSH0HzrxQYScI7FvP0oBjqAWTVSvxK77m5Yjo
        ptmp9xVErxpON7mz50i+PHa3vzvpU0uwpvr6Xn9iGlpohU6hThKHH/kZQholH6Di56o2zv
        JYNhZbEaTymCGbM24Fg6ICy6V3MYNr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-441-6jFJ4rC-NsCa7cIxHlPzHw-1; Wed, 01 Feb 2023 10:56:45 -0500
X-MC-Unique: 6jFJ4rC-NsCa7cIxHlPzHw-1
Received: by mail-wr1-f70.google.com with SMTP id k12-20020a5d6d4c000000b002bff57fc7fcso1482285wri.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBjSgCtYL9pRIH06vB5AfhXuNshNbv18W+fXQWNuIh8=;
        b=7qZH1/8AkNtc/8bq1Lrz5FeOdqYjMvf/DiFXGbD5c8LlX0Axz+bZ6+uMFrf9VJaFI2
         SzqsLS1ssMEAaSdXTSrqDLZKPNB4N3wOaFSoTHcoUHJEdbg0JrR9cnipck7DBZV7xr6m
         Ar00A0ISgXoA/zSsYgWpwsXbXcJyyxIgG/Bczxg7tNA73tnUfiRZW3Fb4bk3EwBv7hUI
         0rtaZaZ2u9Wl1kO+x9SjAs+gpMTKZl3nmlf8sbwVY5Rj6bHr2x9Yc8uLseGruPMPmcf/
         EgTPWdG+7TcJJfsO9nND+aPTMVDDB98R7cWQ1OZNA3TfGNwW7eQ3PTNrkbSFeN0poPce
         n/yw==
X-Gm-Message-State: AO0yUKUghcy2zj31NEM0JlYKvZBQqBc3vDzsS8Exs+KItdF7u+1FYsoh
        wiUH9nDrSJY9P4yKtXW2jh33RiHvsUJhn+zEm7u68UGrNB4iyadMnbaHGQRyNqlQP2cFK6Ywjkx
        9NeEu4hO9MrqEf2OIqJ8gmknX
X-Received: by 2002:a5d:5147:0:b0:2bf:bd9f:23cb with SMTP id u7-20020a5d5147000000b002bfbd9f23cbmr2498529wrt.52.1675267004058;
        Wed, 01 Feb 2023 07:56:44 -0800 (PST)
X-Google-Smtp-Source: AK7set8XqaFVv4ncJA5Y7M29pRXfoqCeQ8PCSF6C1hZlw67zZMrKZ0LMDaOzcgq+aAai1tuI92rJIg==
X-Received: by 2002:a5d:5147:0:b0:2bf:bd9f:23cb with SMTP id u7-20020a5d5147000000b002bfbd9f23cbmr2498507wrt.52.1675267003788;
        Wed, 01 Feb 2023 07:56:43 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3100:e20e:4ace:6f25:6a79? (p200300cbc7053100e20e4ace6f256a79.dip0.t-ipconnect.de. [2003:cb:c705:3100:e20e:4ace:6f25:6a79])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d64c7000000b002bdfe3aca17sm19206282wri.51.2023.02.01.07.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 07:56:43 -0800 (PST)
Message-ID: <7a1bc3c5-6efe-87ab-1276-f71fc440c821@redhat.com>
Date:   Wed, 1 Feb 2023 16:56:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
To:     James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <CADrL8HV92DaNm5bUwcOxsG8Lg4yLT6F13KWSbjkySPNAsgCfpA@mail.gmail.com>
 <Y9Li93O6Ffwcr+vn@x1n>
 <CADrL8HVJb9mA3Lbz5UKJ8EudTk9sGDY-pdRqvW3TGawD_bJB0A@mail.gmail.com>
 <Y9f+jMLWy6ngpYuR@x1n>
 <CADrL8HX3sf6OO3PXS1g6b2dKf8b5phQ7oyNR0dVT=sAOdTmmqw@mail.gmail.com>
 <Y9gzOqwKcu7p/PEw@x1n>
 <CADrL8HXX9YDFUxmPPsm2s3Pno0XXgAyFB40fV1PdtP9eb-5D2A@mail.gmail.com>
 <Y9m/VVRABt0Blfjh@x1n>
 <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CADrL8HXpfTE1+eE3rNGQyOr1QRtDtG5mBp-b3xcNX22QJRvPaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.02.23 16:45, James Houghton wrote:
> On Tue, Jan 31, 2023 at 5:24 PM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Tue, Jan 31, 2023 at 04:24:15PM -0800, James Houghton wrote:
>>> On Mon, Jan 30, 2023 at 1:14 PM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Mon, Jan 30, 2023 at 10:38:41AM -0800, James Houghton wrote:
>>>>> On Mon, Jan 30, 2023 at 9:29 AM Peter Xu <peterx@redhat.com> wrote:
>>>>>>
>>>>>> On Fri, Jan 27, 2023 at 01:02:02PM -0800, James Houghton wrote:
> [snip]
>>>>>> Another way to not use thp mapcount, nor break smaps and similar calls to
>>>>>> page_mapcount() on small page, is to only increase the hpage mapcount only
>>>>>> when hstate pXd (in case of 1G it's PUD) entry being populated (no matter
>>>>>> as leaf or a non-leaf), and the mapcount can be decreased when the pXd
>>>>>> entry is removed (for leaf, it's the same as for now; for HGM, it's when
>>>>>> freeing pgtable of the PUD entry).
>>>>>
>>>>> Right, and this is doable. Also it seems like this is pretty close to
>>>>> the direction Matthew Wilcox wants to go with THPs.
>>>>
>>>> I may not be familiar with it, do you mean this one?
>>>>
>>>> https://lore.kernel.org/all/Y9Afwds%2FJl39UjEp@casper.infradead.org/
>>>
>>> Yep that's it.
>>>
>>>>
>>>> For hugetlb I think it should be easier to maintain rather than any-sized
>>>> folios, because there's the pgtable non-leaf entry to track rmap
>>>> information and the folio size being static to hpage size.
>>>>
>>>> It'll be different to folios where it can be random sized pages chunk, so
>>>> it needs to be managed by batching the ptes when install/zap.
>>>
>>> Agreed. It's probably easier for HugeTLB because they're always
>>> "naturally aligned" and yeah they can't change sizes.
>>>
>>>>
>>>>>
>>>>> Something I noticed though, from the implementation of
>>>>> folio_referenced()/folio_referenced_one(), is that folio_mapcount()
>>>>> ought to report the total number of PTEs that are pointing on the page
>>>>> (or the number of times page_vma_mapped_walk returns true). FWIW,
>>>>> folio_referenced() is never called for hugetlb folios.
>>>>
>>>> FWIU folio_mapcount is the thing it needs for now to do the rmap walks -
>>>> it'll walk every leaf page being mapped, big or small, so IIUC that number
>>>> should match with what it expects to see later, more or less.
>>>
>>> I don't fully understand what you mean here.
>>
>> I meant the rmap_walk pairing with folio_referenced_one() will walk all the
>> leaves for the folio, big or small.  I think that will match the number
>> with what got returned from folio_mapcount().
> 
> See below.
> 
>>
>>>
>>>>
>>>> But I agree the mapcount/referenced value itself is debatable to me, just
>>>> like what you raised in the other thread on page migration.  Meanwhile, I
>>>> am not certain whether the mapcount is accurate either because AFAICT the
>>>> mapcount can be modified if e.g. new page mapping established as long as
>>>> before taking the page lock later in folio_referenced().
>>>>
>>>> It's just that I don't see any severe issue either due to any of above, as
>>>> long as that information is only used as a hint for next steps, e.g., to
>>>> swap which page out.
>>>
>>> I also don't see a big problem with folio_referenced() (and you're
>>> right that folio_mapcount() can be stale by the time it takes the
>>> folio lock). It still seems like folio_mapcount() should return the
>>> total number of PTEs that map the page though. Are you saying that
>>> breaking this would be ok?
>>
>> I didn't quite follow - isn't that already doing so?
>>
>> folio_mapcount() is total_compound_mapcount() here, IIUC it is an
>> accumulated value of all possible PTEs or PMDs being mapped as long as it's
>> all or part of the folio being mapped.
> 
> We've talked about 3 ways of handling mapcount:
> 
> 1. The RFC v2 way, which is head-only, and we increment the compound
> mapcount for each PT mapping we have. So a PTE-mapped 2M page,
> compound_mapcount=512, subpage->_mapcount=0 (ignoring the -1 bias).
> 2. The THP-like way. If we are fully mapping the hugetlb page with the
> hstate-level PTE, we increment the compound mapcount, otherwise we
> increment subpage->_mapcount.
> 3. The RFC v1 way (the way you have suggested above), which is
> head-only, and we increment the compound mapcount if the hstate-level
> PTE is made present.
> 
> With #1 and #2, there is no concern with folio_mapcount(). But with
> #3, folio_mapcount() for a PTE-mapped 2M page mapped in a single VMA
> would yield 1 instead of 512 (right?). That's what I mean.

My 2 cents:

The mapcount is primarily used (in hugetlb context) to

(a) Detect if a page might be shared. mapcount > 1 implies that two 
independent page table hierarchies are mapping the page. We care about 
mapcount == 1 vs. mapcount != 1.

(b) Detect if unmapping was sucessfull. We care about mapcount == 0 vs. 
mapcount != 0.

For hugetlb, I don't see why we should care about the subpage mapcount 
at all.

For (a) it's even good to count "somehow mapped into a single page table 
structure" as "mapcount == 1" For (b), we don't care as long as "still 
mapped" implies "mapcount != 0".

-- 
Thanks,

David / dhildenb

