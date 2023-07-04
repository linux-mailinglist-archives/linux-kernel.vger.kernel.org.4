Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D13747767
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjGDREH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGDREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:04:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0DE5B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:04:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-57722942374so70797557b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688490242; x=1691082242;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5CkhYNN16WNUQJu71BeSwdzRNxPgL/gs2UX0urk5eQ=;
        b=In/HPs//bUn+2tgW3AmtAl5dxW/ADGV2YA56prULm3E/vdfno08a8tljcsPueGrFwv
         jqarDMxpAnYo9aMI5Mb54mMD0rJ8CZohyLEima6tkL05J+cSnzXMAc1rCu3B7NnhNLQl
         ZvVWe49F0YiOX95QlRJtsrnvcRJ4qDr/z3uf8RXLQDyMLLM3K+NeYbv+E3W8yR9z4V2c
         WTkreLz7srWoSO6EVx02fhhtx9sRWBvRmIBi/UDAvsanUA+rvGltjBmFivqq6iRGLfxg
         0Is7JP64PK57hxtBi5rB3DxXAUc/nlIHjgsphR/2KftHY0traJeP5nIjkP89b4sp+32J
         RUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490242; x=1691082242;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5CkhYNN16WNUQJu71BeSwdzRNxPgL/gs2UX0urk5eQ=;
        b=CdqTSlgmzuoTPPz71X1zTIvart6Tsdm2nd3YfrSFCm4+SnyEp07YYl7V/9LPkjYupL
         y+AQzT6N7ERY4vMXhYhjq7E1DtrCjpek1p0iQGaTW4hvpX39bw1DstM8rvErblUw+QDE
         2WDNPvbocsxMP778cQqazJ1lSvjTMSPRNEPywgSyla1MaK2w6EKxXG+gJIf8+y19DSs2
         ue+ozkgXvcYoa54Fn7ydeGZwSG3x9JgYBmbQxrDgqxkgD9klowHA7pZh2jQbWO2sM/h6
         N+UJbKblLwpPm16fRcnE8OXRf7qhz96NYM8lXHkuiIWbZ+6m42KcyrYRANq7YY4jF5zN
         pPWA==
X-Gm-Message-State: ABy/qLbtPFKZzwBgegqbtmaQCf0jzwOYByR3QIQm8NQBYc6UKVDUfUHv
        q5GvXI9lqqKLDObwR+Ho6WiWkA==
X-Google-Smtp-Source: APBJJlEujSIy21mB6q57p7XiiokfNCFL+rCQls/CklTtga65bPCnY5wMW8YqJmU/LAIKTHdSHjCBvg==
X-Received: by 2002:a0d:dd02:0:b0:55a:3ce9:dc3d with SMTP id g2-20020a0ddd02000000b0055a3ce9dc3dmr13990263ywe.13.1688490242129;
        Tue, 04 Jul 2023 10:04:02 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n20-20020a819c54000000b00577632aa85esm2323151ywa.3.2023.07.04.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:04:01 -0700 (PDT)
Date:   Tue, 4 Jul 2023 10:03:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/12] s390: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <20230704171905.1263478f@thinkpad-T15>
Message-ID: <e678affb-5eee-a055-7af1-1d29a965663b@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com> <a722dbec-bd9e-1213-1edd-53cd547aa4f@google.com> <20230628211624.531cdc58@thinkpad-T15> <cd7c2851-1440-7220-6c53-16b343b1474@google.com> <ZJ2hsM5Tn+yUZ5ZV@ziepe.ca> <20230629175645.7654d0a8@thinkpad-T15>
 <edaa96f-80c1-1252-acbb-71c4f045b035@google.com> <7bef5695-fa4a-7215-7e9d-d4a83161c7ab@google.com> <20230704171905.1263478f@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,BODY_ENHANCEMENT2,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2023, Gerald Schaefer wrote:
> On Sat, 1 Jul 2023 21:32:38 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 29 Jun 2023, Hugh Dickins wrote:
> > > 
> > > I've grown to dislike the (ab)use of pt_frag_refcount even more, to the
> > > extent that I've not even tried to verify it; but I think I do get the
> > > point now, that we need further info than just PPHHAA to know whether
> > > the page is on the list or not.  But I think that if we move where the
> > > call_rcu() is done, then the page can stay on or off the list by same
> > > rules as before (but need to check HH bits along with PP when deciding
> > > whether to allocate, and whether to list_add_tail() when freeing).  
> > 
> > No, not quite the same rules as before: I came to realize that using
> > list_add_tail() for the HH pages would be liable to put a page on the
> > list which forever blocked reuse of PP list_add_tail() pages after it
> > (could be solved by a list_move() somewhere, but we have agreed to
> > prefer simplicity).
> > 
> > I've dropped the HH bits, I'm using PageActive like we did on powerpc,
> > I've dropped most of the pte_free_*() helpers, and list_del_init() is
> > an easier way of dealing with those "is it on the list" questions.
> > I expect that we shall be close to reaching agreement on...
> 
> This looks really nice, almost too good and easy to be true. I did not
> find any obvious flaw, just some comments below. It also survived LTP
> without any visible havoc, so I guess this approach is the best so far.

Phew! I'm of course glad to hear this: thanks for your efforts on it.

...
> > --- a/arch/s390/mm/pgalloc.c
> > +++ b/arch/s390/mm/pgalloc.c
> > @@ -229,6 +229,15 @@ void page_table_free_pgste(struct page *page)
> >   * logic described above. Both AA bits are set to 1 to denote a 4KB-pgtable
> >   * while the PP bits are never used, nor such a page is added to or removed
> >   * from mm_context_t::pgtable_list.
> > + *
> > + * pte_free_defer() overrides those rules: it takes the page off pgtable_list,
> > + * and prevents both 2K fragments from being reused. pte_free_defer() has to
> > + * guarantee that its pgtable cannot be reused before the RCU grace period
> > + * has elapsed (which page_table_free_rcu() does not actually guarantee).
> 
> Hmm, I think page_table_free_rcu() has to guarantee the same, i.e. not
> allow reuse before grace period elapsed. And I hope that it does so, by
> setting the PP bits, which would be noticed in page_table_alloc(), in
> case the page would be seen there.
> 
> Unlike pte_free_defer(), page_table_free_rcu() would add pages back to the
> end of the list, and so they could be seen in page_table_alloc(), but they
> should not be reused before grace period elapsed and __tlb_remove_table()
> cleared the PP bits, as far as I understand.
> 
> So what exactly do you mean with "which page_table_free_rcu() does not actually
> guarantee"?

I'll answer without locating and re-reading what Jason explained earlier,
perhaps in a separate thread, about pseudo-RCU-ness in tlb_remove_table():
he may have explained it better.  And without working out again all the
MMU_GATHER #defines, and which of them do and do not apply to s390 here.

The detail that sticks in my mind is the fallback in tlb_remove_table()
in mm/mmu_gather.c: if its __get_free_page(GFP_NOWAIT) fails, it cannot
batch the tables for freeing by RCU, and resorts instead to an immediate 
TLB flush (I think: that again involves chasing definitions) followed by
tlb_remove_table_sync_one() - which just delivers an interrupt to each CPU,
and is commented: 
/*
 * This isn't an RCU grace period and hence the page-tables cannot be
 * assumed to be actually RCU-freed.
 *
 * It is however sufficient for software page-table walkers that rely on
 * IRQ disabling.
 */

Whether that's good for your PP pages or not, I've given no thought:
I've just taken it on trust that what s390 has working today is good.

If that __get_free_page(GFP_NOWAIT) fallback instead used call_rcu(),
then I would not have written "(which page_table_free_rcu() does not
actually guarantee)".  But it cannot use call_rcu() because it does
not have an rcu_head to work with - it's in some generic code, and
there is no MMU_GATHER_CAN_USE_PAGE_RCU_HEAD for architectures to set.

And Jason would have much preferred us to address the issue from that
angle; but not only would doing so destroy my sanity, I'd also destroy
20 architectures TLB-flushing, unbuilt and untested, in the attempt.

...
> > @@ -325,10 +346,17 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
> >  		 */
> >  		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> >  		mask >>= 24;
> > -		if (mask & 0x03U)
> > +		if ((mask & 0x03U) && !PageActive(page)) {
> > +			/*
> > +			 * Other half is allocated, and neither half has had
> > +			 * its free deferred: add page to head of list, to make
> > +			 * this freed half available for immediate reuse.
> > +			 */
> >  			list_add(&page->lru, &mm->context.pgtable_list);
> > -		else
> > -			list_del(&page->lru);
> > +		} else {
> > +			/* If page is on list, now remove it. */
> > +			list_del_init(&page->lru);
> > +		}
> 
> Ok, we might end up with some unnecessary list_del_init() here, e.g. if
> other half is still allocated, when called from pte_free_defer() on a
> fully allocated page, which was not on the list (and with PageActive, and
> (mask & 0x03U) true).
> Not sure if adding an additional mask check to the else path would be
> needed, but it seems that list_del_init() should also be able to handle
> this.

list_del_init() is very cheap in the unnecessary case: the cachelines
required are already there.  You don't want a flag to say whether to
call it or not, it is already the efficient approach.

(But you were right not to use it in your pt_frag_refcount version,
because there we were still trying to do the call_rcu() per fragment
rather than per page, so page->lru could have been on the RCU queue.)

> 
> Same thought applies to the similar logic in page_table_free_rcu()
> below.
> 
> >  		spin_unlock_bh(&mm->context.lock);
> >  		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
> >  		mask >>= 24;
> > @@ -342,8 +370,10 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
> >  	}
> >  
> >  	page_table_release_check(page, table, half, mask);
> > -	pgtable_pte_page_dtor(page);
> > -	__free_page(page);
> > +	if (TestClearPageActive(page))
> > +		call_rcu(&page->rcu_head, pte_free_now);
> > +	else
> > +		pte_free_now(&page->rcu_head);
> 
> This ClearPageActive, and the similar thing in __tlb_remove_table() below,
> worries me a bit, because it is done outside the spin_lock. It "feels" like
> there could be some race with the PageActive checks inside the spin_lock,
> but when drawing some pictures, I could not find any such scenario yet.
> Also, our existing spin_lock is probably not supposed to protect against
> PageActive changes anyway, right?

Here (and similarly in __tlb_remove_table()) is where we are about to free
the page table page: both of the fragments have already been released,
there is nobody left who could be racing against us to set PageActive.

I chose PageActive for its name, not for any special behaviour of that
flag: nothing else could be setting or clearing it while we own the page.

Hugh
