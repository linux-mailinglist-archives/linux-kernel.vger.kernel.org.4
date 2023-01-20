Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51423675B39
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjATRYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjATRYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:24:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEE538B75
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674235412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZXHxVXb+GewUdxs/qxAaosCo1972xxUFkU/C3kl19hw=;
        b=eEOQS+/3yurNdupqWjg+djP4lf8OqMH4j1FdtxYxlU8/+Srht19tqTJJR9SJFTLZSNAaGS
        EWwSquLFi3kvMiGriUPpKgLDMk+w3KDTZrwbvK5SLdhC1v8TxwnpMJdIWAtsURnb7reVRk
        HfhMptEGZO72euId5ZFhqP7XTimp0tg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-213-j40ElJT-ND6IzXKuistbJg-1; Fri, 20 Jan 2023 12:23:31 -0500
X-MC-Unique: j40ElJT-ND6IzXKuistbJg-1
Received: by mail-yb1-f199.google.com with SMTP id y66-20020a253245000000b007cb4f1e3e57so6403789yby.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXHxVXb+GewUdxs/qxAaosCo1972xxUFkU/C3kl19hw=;
        b=mqMmFCHtZQFslfo1+krEJVsGWfIfOOFdKjR+5LvkTIQMDkng/foOQAYfKqQEWSNsfQ
         8ctfot8nped9wlLA1EJ764HUzMPwaFq+0SaMcfKd5fbh+JQ6IotXGV23Kfjk7LqK1+Qe
         UISAxY2KrvSarJBziQQhC+kHms0YURqrAfwuIoP+W0T0kGekNw5/PUFV4PeYyOnAKBgz
         AEI604RfZy/VGuoc7fWvg0tZR0rH3Eptd99OfAahX3ju8G5FxupDfANmcxP9Oj0W2fAK
         dOFVGjuWZitMkMFCsdUNr4KJCoRkSk2HuEMZ4HsSvvQPmPkTs0qnfmFaCjcARfqy6do5
         aNIA==
X-Gm-Message-State: AFqh2kp7AVD9npK8zwnl0w65u5L63krRYm3h6W6jVtfHQ3Uwj7YkZeHB
        0An9nZsQ9JmpS1ngZnMrNtgoVSBtsCtYciv7EwIGfxwtDyT1iJwpCdjoeRpcIaMVu/dLvBLKrXz
        AYH5/TD5nckzqCBu86B+5p/uV
X-Received: by 2002:a81:395:0:b0:4fd:cd4a:e2a3 with SMTP id 143-20020a810395000000b004fdcd4ae2a3mr2940303ywd.3.1674235410681;
        Fri, 20 Jan 2023 09:23:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsojfHu69tmKvkGgMgC30m9j67xGJKyiVzr/0YUl4dSz47RxxJrZj1k6lS6SLE/mX0D+trHfQ==
X-Received: by 2002:a81:395:0:b0:4fd:cd4a:e2a3 with SMTP id 143-20020a810395000000b004fdcd4ae2a3mr2940276ywd.3.1674235410354;
        Fri, 20 Jan 2023 09:23:30 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d12-20020a05620a240c00b006fcc3858044sm27387920qkn.86.2023.01.20.09.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:23:29 -0800 (PST)
Date:   Fri, 20 Jan 2023 12:23:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
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
Subject: Re: [PATCH 21/46] hugetlb: use struct hugetlb_pte for
 walk_hugetlb_range
Message-ID: <Y8rOEKimvUi0noT6@x1n>
References: <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
 <Y8nCyqLF71g88Idv@x1n>
 <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
 <Y8nNHKW0sTnrq8hw@x1n>
 <CADrL8HUvcXn5rjaS+WNt0Gz=1YV7273VVy-o-EdQHSQObuGNkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HUvcXn5rjaS+WNt0Gz=1YV7273VVy-o-EdQHSQObuGNkA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:26:14PM -0800, James Houghton wrote:
> On Thu, Jan 19, 2023 at 3:07 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 02:35:12PM -0800, James Houghton wrote:
> > > On Thu, Jan 19, 2023 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Thu, Jan 19, 2023 at 02:00:32PM -0800, Mike Kravetz wrote:
> > > > > I do not know much about the (primary) live migration use case.  My
> > > > > guess is that page table lock contention may be an issue?  In this use
> > > > > case, HGM is only enabled for the duration the live migration operation,
> > > > > then a MADV_COLLAPSE is performed.  If contention is likely to be an
> > > > > issue during this time, then yes we would need to pass around with
> > > > > something like hugetlb_pte.
> > > >
> > > > I'm not aware of any such contention issue.  IMHO the migration problem is
> > > > majorly about being too slow transferring a page being so large.  Shrinking
> > > > the page size should resolve the major problem already here IIUC.
> > >
> > > This will be problematic if you scale up VMs to be quite large.
> >
> > Do you mean that for the postcopy use case one can leverage e.g. 2M
> > mappings (over 1G) to avoid lock contentions when VM is large I agree it
> > should be more efficient than having 512 4K page installed, but I think
> > it'll make the page fault resolution slower too if some thead is only
> > looking for a 4k portion of it.
> 
> No, that's not what I meant. Sorry. If you can use the PTL that is
> normally used for 4K PTEs, then you're right, there is no contention
> problem. However, this PTL is determined by the value of the PMD, so
> you need a pointer to the PMD to determine what the PTL should be (or
> a pointer to the PTL itself).
> 
> In hugetlb, we only ever pass around the PTE pointer, and we rely on
> huge_pte_lockptr() to find the PTL for us (and it does so
> appropriately for everything except 4K PTEs). We would need to add the
> complexity of passing around a PMD or PTL everywhere, and that's what
> hugetlb_pte does for us. So that complexity is basically unavoidable,
> unless you're ok with 4K PTEs with taking mm->page_table_lock (I'm
> not).
> 
> >
> > > Google upstreamed the "TDP MMU" for KVM/x86 that removed the need to take
> > > the MMU lock for writing in the EPT violation path. We found that this
> > > change is required for VMs >200 or so vCPUs to consistently avoid CPU
> > > soft lockups in the guest.
> >
> > After the kvm mmu rwlock convertion, it'll allow concurrent page faults
> > even if only 4K pages are used, so it seems not directly relevant to what
> > we're discussing here, no?
> 
> Right. I was just bringing it up to say that if 4K PTLs were
> mm->page_table_lock, we would have a problem.

Ah I see what you meant.  We definitely don't want to use the
page_table_lock for sure.

So if it's about keeping hugetlb_pte I'm fine with it, no matter what the
final version will look like.

> 
> >
> > >
> > > Requiring each UFFDIO_CONTINUE (in the post-copy path) to serialize on
> > > the same PTL would be problematic in the same way.
> >
> > Pte-level pgtable lock only covers 2M range, so I think it depends on which
> > is the address that the vcpu is faulted on?  IIUC the major case should be
> > that the faulted threads are not falling upon the same 2M range.
> 
> Right. I think my comment should make more sense with the above clarification.
> 
> >
> > >
> > > >
> > > > AFAIU 4K-only solution should only reduce any lock contention because locks
> > > > will always be pte-level if VM_HUGETLB_HGM set.  When walking and creating
> > > > the intermediate pgtable entries we can use atomic ops just like generic
> > > > mm, so no lock needed at all.  With uncertainty on the size of mappings,
> > > > we'll need to take any of the multiple layers of locks.
> > > >
> > >
> > > Other than taking the HugeTLB VMA lock for reading, walking/allocating
> > > page tables won't need any additional locking.
> >
> > Actually when revisiting the locks I'm getting a bit confused on whether
> > the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
> > raised a question in the other patch of MADV_COLLAPSE, maybe they're
> > related questions so we can keep it there.
> 
> We can discuss there. :) I take both the VMA lock and mapping lock so
> that it can stay in sync with huge_pmd_unshare(), and so HGM walks
> have the same synchronization as regular hugetlb PT walks.

Sure. :)

Now after a 2nd thought I don't think it's unsafe to take the vma write
lock here, especially for VM_SHARED.  I can't think of anything that will
go wrong.  It's because we need the vma lock anywhere we'll be walking the
pgtables when having mmap_sem read I think, being afraid of having pmd
sharing being possible.

But I'm not sure whether this is the cleanest way to do it.

IMHO the major special part of hugetlb comparing to generic mm on pgtable
thread safety.  I worry that complicating this lock can potentially make
the hugetlb code even more specific, which is not good for the long term if
we still have a hope of merging more hugetlb codes with the generic paths.

Here since pmd sharing is impossible for HGM, the original vma lock is not
needed here.  Meanwhile, what we want to guard is the pgtable walkers.
They're logically being protected by either mmap lock or the mapping lock
(for rmap walkers).  Fast-gup is another thing but so far I think it's all
safe when you're following the mmu gather facilities.

Somehow I had a feeling that the hugetlb vma lock (along with the pgtable
sharing explorations in the hugetlb world keeping going..) can keep
evolving in the future, and it should be helpful to keep its semantics
simple too.

So to summarize: I wonder whether we can use mmap write lock and
i_mmap_rwsem write lock to protect collapsing for hugetlb, just like what
we do with THP collapsing (after Jann's fix).

madvise_need_mmap_write() is not easily feasible because it's before the
vma scanning so we can't take conditional write lock only for hugetlb, but
that's the next question to ask only if we can reach a consensus on the
lock scheme first for HGM in general.

> 
> >
> > >
> > > We take the PTL to allocate the next level down, but so does generic
> > > mm (look at __pud_alloc, __pmd_alloc for example). Maybe I am
> > > misunderstanding.
> >
> > Sorry you're right, please ignore that.  I don't know why I had that
> > impression that spinlocks are not needed in that process.
> >
> > Actually I am also curious why atomics won't work (by holding mmap read
> > lock, then do cmpxchg(old_entry=0, new_entry) upon the pgtable entries).  I
> > think it's possible I just missed something else.
> 
> I think there are cases where we need to make sure the value of a PTE
> isn't going to change from under us while we're doing some kind of
> other operation, and so a compare-and-swap won't really be what we
> need.

Currently the pgtable spinlock is only taken during populating the
pgtables.  If it can happen, then it can happen too right after we release
the spinlock in e.g. __pmd_alloc().

One thing I can think of is we need more things done rather than the
pgtable entry installations so atomics will stop working if so.  E.g. on
x86 we have paravirt_alloc_pmd().  But I'm not sure whether that's the only
reason.

-- 
Peter Xu

