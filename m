Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552367470A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjASXOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjASXNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:13:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89142114
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674169633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3bBBNfWfdOJojqP+jjp+TX9gqoRqSR4QzF0ynIoERPA=;
        b=HNveYhQKTFOuzJKwszX0DzDgBQKWlUrc8bD6WJoXaROmUVvNgOoZiwHhPRdQycPEmppQAq
        ouI0Y34AQPp59comqVuQ6RAoC0LvwfpxmaC4Qf8cK/HMAnUecuW9/wj2wmtYcLZn3KywYi
        XKNqo2zVNvSc5P+HKrUpQhGo+kLYDAo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-YzGjEUQCPGeVHZ_6zic0Fg-1; Thu, 19 Jan 2023 18:07:11 -0500
X-MC-Unique: YzGjEUQCPGeVHZ_6zic0Fg-1
Received: by mail-qk1-f197.google.com with SMTP id bs44-20020a05620a472c00b0070673cd1b05so2286948qkb.22
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bBBNfWfdOJojqP+jjp+TX9gqoRqSR4QzF0ynIoERPA=;
        b=g/NqNnV98+yx0Hay9TjZ5j0MWD9jlOxyRIESAi0W7bBBOSkmdzwzJykY2imnCyJRBS
         dW8wPTBA5lhnVeqL6PgziC9GF9V9/1cddJLjNd/PCzplgwyVSzbS4ZvZlJ4mM6aRDqRE
         mIA2UJc6gWfzLkvQOekWYnUKYQLREqVp6fUre7OeBEZiTjgPk/BTwxYLWUhy36ryMoaN
         vJFbXPID4gV+Bj5bd3TcP/0MSEXrO3ekMK7Cvh2VQGsGZASVjIXBFkzdhhAUFE20LhSE
         ljtkqHTUYFm6qC+VXvm0MQWqXxwRCMlOFwJ7sTeHqpJA5HFBh1Zszu+djo4K2WDLgD+m
         E+CA==
X-Gm-Message-State: AFqh2kpTPC5dyCaYQHeW9wkpqOnZqk/R0VGyzpGeqm1YLPQ7ZjtaWLTw
        727HrPvckkTR6ir7780hRok5wmUhbFKtaKQb1j9HhVWcYFwMs1ig0KRfF3V0FRmUGZ3bHERHWzx
        OPfcfpdwwxw3VCW/T/Ajn4eYG
X-Received: by 2002:ac8:7ed7:0:b0:3b6:3260:fa1d with SMTP id x23-20020ac87ed7000000b003b63260fa1dmr16943263qtj.45.1674169631432;
        Thu, 19 Jan 2023 15:07:11 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuNz3WrIEGSC+WUmM66adbpLmN9mzuwPFh7nzVrtEe2Y5cC3Y0zC4cPMmT+xlLot5h/N6JKIA==
X-Received: by 2002:ac8:7ed7:0:b0:3b6:3260:fa1d with SMTP id x23-20020ac87ed7000000b003b63260fa1dmr16943241qtj.45.1674169631097;
        Thu, 19 Jan 2023 15:07:11 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006b5cc25535fsm25661835qko.99.2023.01.19.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:07:10 -0800 (PST)
Date:   Thu, 19 Jan 2023 18:07:08 -0500
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
Message-ID: <Y8nNHKW0sTnrq8hw@x1n>
References: <6548b3b3-30c9-8f64-7d28-8a434e0a0b80@redhat.com>
 <Y8gRpEonhXgqfb41@x1n>
 <CADrL8HVGMTowH4trJhS+eM_EwZKoUgu7LmfwyTGyGRnNnwL3Zg@mail.gmail.com>
 <Y8hITxr/BBMuO6WX@monkey>
 <CADrL8HUggALQET-09Zw3BhFjZdw_G9+v6CU=qtGtK=KZ_DeAsw@mail.gmail.com>
 <Y8l+f2wNp2gAjvYg@monkey>
 <CADrL8HVdL_NMdNq2mEemNCfwkYBAWnbqwyjsAYdQ2fF0iz34Hw@mail.gmail.com>
 <Y8m9gJX4PNoIrpjE@monkey>
 <Y8nCyqLF71g88Idv@x1n>
 <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADrL8HXkdxDdixWRKNw6RFdbiBX-Cb1Lk7qxg6LdeNywbMOaOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:35:12PM -0800, James Houghton wrote:
> On Thu, Jan 19, 2023 at 2:23 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2023 at 02:00:32PM -0800, Mike Kravetz wrote:
> > > I do not know much about the (primary) live migration use case.  My
> > > guess is that page table lock contention may be an issue?  In this use
> > > case, HGM is only enabled for the duration the live migration operation,
> > > then a MADV_COLLAPSE is performed.  If contention is likely to be an
> > > issue during this time, then yes we would need to pass around with
> > > something like hugetlb_pte.
> >
> > I'm not aware of any such contention issue.  IMHO the migration problem is
> > majorly about being too slow transferring a page being so large.  Shrinking
> > the page size should resolve the major problem already here IIUC.
> 
> This will be problematic if you scale up VMs to be quite large.

Do you mean that for the postcopy use case one can leverage e.g. 2M
mappings (over 1G) to avoid lock contentions when VM is large?  I agree it
should be more efficient than having 512 4K page installed, but I think
it'll make the page fault resolution slower too if some thead is only
looking for a 4k portion of it.

> Google upstreamed the "TDP MMU" for KVM/x86 that removed the need to take
> the MMU lock for writing in the EPT violation path. We found that this
> change is required for VMs >200 or so vCPUs to consistently avoid CPU
> soft lockups in the guest.

After the kvm mmu rwlock convertion, it'll allow concurrent page faults
even if only 4K pages are used, so it seems not directly relevant to what
we're discussing here, no?

> 
> Requiring each UFFDIO_CONTINUE (in the post-copy path) to serialize on
> the same PTL would be problematic in the same way.

Pte-level pgtable lock only covers 2M range, so I think it depends on which
is the address that the vcpu is faulted on?  IIUC the major case should be
that the faulted threads are not falling upon the same 2M range.

> 
> >
> > AFAIU 4K-only solution should only reduce any lock contention because locks
> > will always be pte-level if VM_HUGETLB_HGM set.  When walking and creating
> > the intermediate pgtable entries we can use atomic ops just like generic
> > mm, so no lock needed at all.  With uncertainty on the size of mappings,
> > we'll need to take any of the multiple layers of locks.
> >
> 
> Other than taking the HugeTLB VMA lock for reading, walking/allocating
> page tables won't need any additional locking.

Actually when revisiting the locks I'm getting a bit confused on whether
the vma lock is needed if pmd sharing is anyway forbidden for HGM.  I
raised a question in the other patch of MADV_COLLAPSE, maybe they're
related questions so we can keep it there.

> 
> We take the PTL to allocate the next level down, but so does generic
> mm (look at __pud_alloc, __pmd_alloc for example). Maybe I am
> misunderstanding.

Sorry you're right, please ignore that.  I don't know why I had that
impression that spinlocks are not needed in that process.

Actually I am also curious why atomics won't work (by holding mmap read
lock, then do cmpxchg(old_entry=0, new_entry) upon the pgtable entries).  I
think it's possible I just missed something else.

-- 
Peter Xu

