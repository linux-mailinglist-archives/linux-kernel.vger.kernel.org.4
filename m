Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD22670E43
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjAQX6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAQX5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:57:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B227683C9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:11:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so2829064wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5oxzAsaqIwmUuTJta5veTY5JnO9mXQ8bF85bF171uqI=;
        b=X7ZKoNFV50ipf5srZPGrdYLLR+kN2amoQcwgtzabv5tHQmqJQ0M37L4RuutFooAPav
         dtiZsKN++VT9lsvJmUSGR7a3uMC3BJE9xqFYKJ8d9maZwgnIT1HW1qcGnJst4/qCFFS7
         UDJUjQzox1LZk6heyTQw+CgD0fEKYYUfvCYPhED0vzBszQSQBQVqFNO7R97Q4yUS4x37
         BXqNDjl/ABbQTQWzE91WR6pjvGXYJBuQ74sv7a4hv2AGTcoQQlr7uTYT03DJIyglVWSa
         yDbXyHQee/elzSlC3kofhcJ2WMv8HYinLg/u59LbpygtEtNrdjedxrPVWP273RM496Xo
         PX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5oxzAsaqIwmUuTJta5veTY5JnO9mXQ8bF85bF171uqI=;
        b=detysppwDdezD702WT0xng9Np72MW6iLMX3LXJba0naMWb5SUnFrHhw5CiSqUwj1Bz
         AvLbV0dJREX5q35VycuFNAzudDH2J7y0iDXrGsXarn3E4PJWSrWCoka1XrPODUH7VOZq
         uC3XJDApwKCXMjKhLkjVU75D+USotKQ3Nr40oR5AtEMXF+4ERrTdKZXiouL27D905EUQ
         hmoFPuAvDhwhMbvRXnKzjzG2jK3GnomrfA9m15rbyXb/xtlJlL81bvNXxStI54av4Rmw
         tSsiXR3RrioNvyU3HFt0+JnLHdZQiOIUcNS5aLlboHLDRM0GUStP2J2T8lcbVYnvX8S3
         jzIw==
X-Gm-Message-State: AFqh2kpg+/oIWL8xe58XsGXP2POtyVMWW9w//RMYVU61SYQkXnPUZ4S3
        G02EFeRkcL3UABqk1Kj5JmBTkSlTx46+UCTzok9tYQ==
X-Google-Smtp-Source: AMrXdXtuD2pLS841WmKK+2UE82fwBI/ufn7wxUFHSJbh/Iwq6hrFKoOROLk6yfPTfuC11WzXzsaKeDhEopLBvB6g3u4=
X-Received: by 2002:a05:600c:4213:b0:3da:6db:b09a with SMTP id
 x19-20020a05600c421300b003da06dbb09amr292584wmh.26.1673997072694; Tue, 17 Jan
 2023 15:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
 <20230105101844.1893104-22-jthoughton@google.com> <Y78+/wleTEC3gyqu@x1n>
 <CADrL8HU-prbfx2xxXCi0RPznp5DB68-NjqqmdM+4aUeUUURhiA@mail.gmail.com>
 <Y8AnROAtMngKntnq@x1n> <CADrL8HWFfqCqbpmvv8BSpvvzJ9aEeBEN30bMLuWGancsfMXv2w@mail.gmail.com>
 <Y8BtJzBLTpw5IR+H@x1n> <CADrL8HUi-j4ais45Xq8Jpb6a7DsWiXrKNeJfsqBRMi1Lier8xA@mail.gmail.com>
 <Y8B8mW2zSWDDwp7G@x1n> <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
In-Reply-To: <06423461-c543-56fe-cc63-cabda6871104@redhat.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 17 Jan 2023 15:11:01 -0800
Message-ID: <CADrL8HUdg1Fr=tLEQRkDjeTzNzzSM6EPhvDgzURxSZSBMLgjoQ@mail.gmail.com>
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for walk_hugetlb_range
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 2:17 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.23 22:33, Peter Xu wrote:
> > On Thu, Jan 12, 2023 at 04:17:52PM -0500, James Houghton wrote:
> >> I'll look into it, but doing it this way will use _mapcount, so we
> >> won't be able to use the vmemmap optimization. I think even if we do
> >> use Hugh's approach, refcount is still being kept on the head page, so
> >> there's still an overflow risk there (but maybe I am
> >> misunderstanding).
> >
> > Could you remind me what's the issue if using refcount on the small pages
> > rather than the head (assuming vmemmap still can be disabled)?
>
> The THP-way of doing things is refcounting on the head page. All folios
> use a single refcount on the head.
>
> There has to be a pretty good reason to do it differently.

Peter and I have discussed this a lot offline. There are two main problems here:

1. Refcount overflow

Refcount is always kept on the head page (before and after this
series). IIUC, this means that if THPs could be 1G in size, they too
would be susceptible to the same potential overflow. How easy is the
overflow? [1]

To deal with this, the best solution we've been able to come up with
is to check if refcount is > INT_MAX/2 (similar to try_get_page()),
and if it is, stop the operation (UFFDIO_CONTINUE or a page fault)
from proceeding. In the UFFDIO_CONTINUE case, return ENOMEM. In the
page fault cause, return VM_FAULT_SIGBUS (not VM_FAULT_OOM; we don't
want to kill a random process).

(So David, I think this answers your question. Refcount should be
handled just like THPs.)

2. page_mapcount() API differences

In this series, page_mapcount() returns the total number of page table
references for the compound page. For example, if you have a
PTE-mapped 2M page (with no other mappings), page_mapcount() for each
4K page will be 512. This is not the same as a THP: page_mapcount()
would return 1 for each page. Because of the difference in
page_mapcount(), we have 4 problems:

i. Smaps uses page_mapcount() >= 2 to determine if hugetlb memory is
"private_hugetlb" or "shared_hugetlb".
ii. Migration with MPOL_MF_MOVE will check page_mapcount() to see if
the hugepage is shared or not. Pages that would otherwise be migrated
now require MPOL_MF_MOVE_ALL to be migrated.
[Really both of the above are checking how many VMAs are mapping our hugepage.]
iii. CoW. This isn't a problem right now because CoW is only possible
with MAP_PRIVATE VMAs and HGM can only be enabled for MAP_SHARED VMAs.
iv. The hwpoison handling code will check if it successfully unmapped
the poisoned page. This isn't a problem right now, as hwpoison will
unmap all the mappings for the hugepage, not just the 4K where the
poison was found.

Doing it this way allows HGM to remain compatible with the hugetlb
vmemmap optimization. None of the above problems strike me as
particularly major, but it's unclear to me how important it is to have
page_mapcount() have a consistent meaning for hugetlb vs non-hugetlb.

The other way page_mapcount() (let's say the "THP-like way") could be
done is like this: increment compound mapcount if we're mapping a
hugetlb page normally (e.g., 1G page with a PUD). If we're mapping at
high-granularity, increment the mapcount for each 4K page that is
getting mapped (e.g., PMD within a 1G page: increment the mapcount for
the 512 pages that are now mapped). This yields the same
page_mapcount() API we had before, but we lose the hugetlb vmemmap
optimization.

We could introduce an API like hugetlb_vma_mapcount() that would, for
hugetlb, give us the number of VMAs that map a hugepage, but I don't
think people would like this.

I'm curious what others think (Mike, Matthew?). I'm guessing the
THP-like way is probably what most people would want, though it would
be a real shame to lose the vmemmap optimization.

- James

[1] INT_MAX is 2^31. We increment the refcount once for each 4K
mapping in 1G: that's 512 * 512 (2^18). That means we only need 8192
(2^13) VMAs for the same 1G page to overflow refcount. I think it's
safe to say that if userspace is doing this, they are attempting to
overflow refcount.
