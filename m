Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE87671967
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjARKnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjARKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C585FD70
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674035031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=to3Ev6pxhkkicKETj3Ijs1vjMQOaL5kG/kpXhC7sdRQ=;
        b=UUK5LPVzvfqI9gCHL81lpVbF831lPX6NrmcusSA1qtj+u+fVDQWcUhRAYFyefifvWPgiQ+
        iZvJYE2sFfmREvva4wEa5KXgy5u0NmhZfdYvuIOKIBJSj+yVK9ZMfrSt1lbF7J9m8Ke1SU
        eWCAX3TXbyp0X9d7tiCPJoH7kOUgb70=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-ANzoQNezPNCGP5jNnLiJNg-1; Wed, 18 Jan 2023 04:43:50 -0500
X-MC-Unique: ANzoQNezPNCGP5jNnLiJNg-1
Received: by mail-wm1-f71.google.com with SMTP id bg25-20020a05600c3c9900b003da1f6a7b2dso949513wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:43:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=to3Ev6pxhkkicKETj3Ijs1vjMQOaL5kG/kpXhC7sdRQ=;
        b=FcSIOmbd4ZHzc99XczJ8Kxya1DxR7shGxkRDg8Z0VJ1VaC0Ir/RPa5Vj7UwbfnS5Th
         lXUAIMLhYMNIdlmm6l2mV1V9mSOZzyrIRzY7osHBA62AUghFhJ4bCSCz7PGmBCQ0JV3Y
         BsqxZLu6qzzB9pkeFkJwO6pHYRuP+oa61+/wnwbjE5IoCzfcAE8s2HBU+cqEvEWolQ9L
         /OSx3dvq9fUEDdPv0Vw1G7iRFUbBDkAG8VVMkI9ZJUl4p6AiVoSAIY7ZcqfQY+w7wjLI
         VgA3TY73umJN9v1ZCIOGVryrFa368IR6bdFmSFZ/ktPkufrTL2HmtaU39dk/z6J3hYB+
         qHnQ==
X-Gm-Message-State: AFqh2kpN+mIznWs2cmP5eBdfCRqy60KXKRbX5UvlO4Oe2MmJfne7oUTl
        BvDVzW7g216JgXSDMAipN0CGBedXXVIPwNO8WU+2umhut1xIDl/6wlxIP3rZM4Qx/agH1bztjlR
        1TxF3x3/42SKXzN8i5yB10NFN
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr5859582wmc.22.1674035029479;
        Wed, 18 Jan 2023 01:43:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuENZJlT6O1r+Ky+h+0K2LFetgG9jQmypdPXNh1UiOLR0zPXaU3x8sT/5yzbZY67YnPAxHAbA==
X-Received: by 2002:a1c:7415:0:b0:3da:fd07:1e3 with SMTP id p21-20020a1c7415000000b003dafd0701e3mr5859554wmc.22.1674035029004;
        Wed, 18 Jan 2023 01:43:49 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003b4cba4ef71sm1675621wmb.41.2023.01.18.01.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 01:43:48 -0800 (PST)
Message-ID: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
Date:   Wed, 18 Jan 2023 10:43:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     James Houghton <jthoughton@google.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n>
 <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n>
 <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
 <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
In-Reply-To: <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
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

On 18.01.23 00:11, James Houghton wrote:
> On Mon, Jan 16, 2023 at 2:17 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 12.01.23 22:33, Peter Xu wrote:
>>> On Thu, Jan 12, 2023 at 04:17:52PM -0500, James Houghton wrote:
>>>> I'll look into it, but doing it this way will use _mapcount, so we
>>>> won't be able to use the vmemmap optimization. I think even if we do
>>>> use Hugh's approach, refcount is still being kept on the head page, so
>>>> there's still an overflow risk there (but maybe I am
>>>> misunderstanding).
>>>
>>> Could you remind me what's the issue if using refcount on the small pages
>>> rather than the head (assuming vmemmap still can be disabled)?
>>
>> The THP-way of doing things is refcounting on the head page. All folios
>> use a single refcount on the head.
>>
>> There has to be a pretty good reason to do it differently.
> 
> Peter and I have discussed this a lot offline. There are two main problems here:
> 
> 1. Refcount overflow
> 
> Refcount is always kept on the head page (before and after this
> series). IIUC, this means that if THPs could be 1G in size, they too
> would be susceptible to the same potential overflow. How easy is the
> overflow? [1]

Right. You'd need 8k VMAs. With 2 MiB THP you'd need 4096k VMAs. So ~64 
processes with 64k VMAs. Not impossible to achieve if one really wants 
to break the system ...

Side note: a long long time ago, we used to have sub-page refcounts for 
THP. IIRC, that was even before we had sub-page mapcounts and was used 
to make COW decisions.

> 
> To deal with this, the best solution we've been able to come up with
> is to check if refcount is > INT_MAX/2 (similar to try_get_page()),
> and if it is, stop the operation (UFFDIO_CONTINUE or a page fault)
> from proceeding. In the UFFDIO_CONTINUE case, return ENOMEM. In the
> page fault cause, return VM_FAULT_SIGBUS (not VM_FAULT_OOM; we don't
> want to kill a random process).

You'd have to also make sure that fork() won't do the same. At least 
with uffd-wp, Peter also added page table copying during fork() for 
MAP_SHARED mappings, which would have to be handled.

Of course, one can just disallow fork() with any HGM right from the 
start and keep it all simpler to not open up a can of worms there.

Is it reasonable, to have more than one (or a handful) of VMAs mapping a 
huge page via a HGM? Restricting it to a single one, would make handling 
   much easier.

If there is ever demand for more HGM mappings, that whole problem (and 
complexity) could be dealt with later. ... but I assume it will already 
be a requirement for VMs (e.g., under QEMU) that share memory with other 
processes (virtiofsd and friends?)


> 
> (So David, I think this answers your question. Refcount should be
> handled just like THPs.)
> 
> 2. page_mapcount() API differences
> 
> In this series, page_mapcount() returns the total number of page table
> references for the compound page. For example, if you have a
> PTE-mapped 2M page (with no other mappings), page_mapcount() for each
> 4K page will be 512. This is not the same as a THP: page_mapcount()
> would return 1 for each page. Because of the difference in
> page_mapcount(), we have 4 problems:

IMHO, it would actually be great to just be able to remove the sub-page 
mapcounts for THP and make it all simpler.

Right now, the sub-page mapcount is mostly required for making COW 
decisions, but only for accounting purposes IIRC (NR_ANON_THPS, 
NR_SHMEM_PMDMAPPED, NR_FILE_PMDMAPPED) and mlock handling IIRC. See 
page_remove_rmap().

If we can avoid that complexity right from the start for hugetlb, great, ..

> 
> i. Smaps uses page_mapcount() >= 2 to determine if hugetlb memory is
> "private_hugetlb" or "shared_hugetlb".
> ii. Migration with MPOL_MF_MOVE will check page_mapcount() to see if
> the hugepage is shared or not. Pages that would otherwise be migrated
> now require MPOL_MF_MOVE_ALL to be migrated.
> [Really both of the above are checking how many VMAs are mapping our hugepage.]
> iii. CoW. This isn't a problem right now because CoW is only possible
> with MAP_PRIVATE VMAs and HGM can only be enabled for MAP_SHARED VMAs.
> iv. The hwpoison handling code will check if it successfully unmapped
> the poisoned page. This isn't a problem right now, as hwpoison will
> unmap all the mappings for the hugepage, not just the 4K where the
> poison was found.
> 
> Doing it this way allows HGM to remain compatible with the hugetlb
> vmemmap optimization. None of the above problems strike me as
> particularly major, but it's unclear to me how important it is to have
> page_mapcount() have a consistent meaning for hugetlb vs non-hugetlb.

See below, maybe we should tackle HGM from a different direction.

> 
> The other way page_mapcount() (let's say the "THP-like way") could be
> done is like this: increment compound mapcount if we're mapping a
> hugetlb page normally (e.g., 1G page with a PUD). If we're mapping at
> high-granularity, increment the mapcount for each 4K page that is
> getting mapped (e.g., PMD within a 1G page: increment the mapcount for
> the 512 pages that are now mapped). This yields the same
> page_mapcount() API we had before, but we lose the hugetlb vmemmap
> optimization.
> 
> We could introduce an API like hugetlb_vma_mapcount() that would, for
> hugetlb, give us the number of VMAs that map a hugepage, but I don't
> think people would like this.
> 
> I'm curious what others think (Mike, Matthew?). I'm guessing the
> THP-like way is probably what most people would want, though it would
> be a real shame to lose the vmemmap optimization.

Heh, not me :) Having a single mapcount is certainly much cleaner. ... 
and if we're dealing with refcount overflows already, mapcount overflows 
are not an issue.


I wonder if the following crazy idea has already been discussed: treat 
the whole mapping as a single large logical mapping. One reference and 
one mapping, no matter how the individual parts are mapped into the 
assigned page table sub-tree.

Because for hugetlb with MAP_SHARED, we know that the complete assigned 
sub-tree of page tables can only map the given hugetlb page, no 
fragments of something else. That's very different to THP in private 
mappings ...

So as soon as the first piece gets mapped, we increment 
refcount+mapcount. Other pieces in the same subtree don't do that.

Once the last piece is unmapped (or simpler: once the complete subtree 
of page tables is gone), we decrement refcount+mapcount. Might require 
some brain power to do this tracking, but I wouldn't call it impossible 
right from the start.

Would such a design violate other design aspects that are important?

-- 
Thanks,

David / dhildenb

