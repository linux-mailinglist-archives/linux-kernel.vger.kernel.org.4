Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F727275C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 05:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjFHDfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 23:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjFHDfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:35:14 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568F26A1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 20:35:12 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so232534276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686195311; x=1688787311;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LWFiGxojoCqRYw5DhvqKACYgyLEeJJQZi2l2M3J+Fk=;
        b=xjRVZIU3cNd3d3THCIOquudwUpn0AAxldkTVxYsxXjLXYvggpi3h0F5WBD5gC1lAP3
         g8Pq9zhr0jmZ02KMWF5EvC7AkPi/0sanW+VOioWC9vMsY3Sn9uQHrBMhIIT+rTkRNKv9
         guWGoqKAcJC2R8Z+MHKklP8iLtv6+hwM0xqsIEGzs/WejB2noCujVFqbWwUt1Wqquwqp
         crWkDOvyhhX3fio1EotYq3RP1j7z3p6Zvr5J8tpBdBFmHV4pMjw379HAOFHQIGdd/DzK
         ZRXkzNmsEkEPheOlMBt7OrZ/ZbF/Hr6HENk2CMZ/sLUEbEl8D13xJYnWwiTI5kQRtxrF
         ZhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686195311; x=1688787311;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LWFiGxojoCqRYw5DhvqKACYgyLEeJJQZi2l2M3J+Fk=;
        b=WSMsxz9L0GnVF6BAhxioznG7VkVGPhSK0xrbR9BiBVEQ95pHU39IOK36oZ70yYkONE
         a/5GqQDvRfMZFBCiOUBUNOlVORHow8olbme+RvgaGKnZd+OPqAr/EhvmWez8/1LJ3N7y
         hEgXcvvDknDDNHlfZCPhZ6+T1cVDJaBxfA3rq1cRBgfkM164jYXrW3Fg9xw98hhNdhst
         Bm2CyHNdsKWhpWHOHRU7Xk/WZxZERnRTnCcpdyBQE6/++o8q5QupkAblkwRKx/jgNFhO
         Y7rS3+BnYaNYAldI3CkqkYvjoAKIhVuhf9An3O7Z/RWOuG/AnDkBRltz3q8l7AEBwJcD
         CcMQ==
X-Gm-Message-State: AC+VfDzVSDTrffRND+JbJgxh85Dm3m1GxBgyFmhklTpuF3cbRXpEzJ4x
        /WVT4LjjPINBI0jrXx9XqIm2HA==
X-Google-Smtp-Source: ACHHUZ7rBfLmNspidToJm/9DOkTUxdFMNcSyZGwWQvf+WZRSsCUsBzPT/sLiE3h7CG8HJi2hTMjLiA==
X-Received: by 2002:a25:b47:0:b0:bb3:ae54:9fde with SMTP id 68-20020a250b47000000b00bb3ae549fdemr6430690ybl.21.1686195310941;
        Wed, 07 Jun 2023 20:35:10 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id a129-20020a816687000000b00565862c5e90sm127418ywc.83.2023.06.07.20.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 20:35:10 -0700 (PDT)
Date:   Wed, 7 Jun 2023 20:35:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/12] s390: add pte_free_defer(), with use of
 mmdrop_async()
In-Reply-To: <20230606214037.09c6b280@thinkpad-T15>
Message-ID: <dbed4c5-1d-f278-d03a-66f5eff5e48e@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <6dd63b39-e71f-2e8b-7e0-83e02f3bcb39@google.com> <175ebec8-761-c3f-2d98-6c3bd87161c8@google.com> <20230606214037.09c6b280@thinkpad-T15>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023, Gerald Schaefer wrote:
> On Mon, 5 Jun 2023 22:11:52 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 1 Jun 2023 15:57:51 +0200
> > Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:
> > > 
> > > Yes, we have 2 pagetables in one 4K page, which could result in same
> > > rcu_head reuse. It might be possible to use the cleverness from our
> > > page_table_free() function, e.g. to only do the call_rcu() once, for
> > > the case where both 2K pagetable fragments become unused, similar to
> > > how we decide when to actually call __free_page().
> > > 
> > > However, it might be much worse, and page->rcu_head from a pagetable
> > > page cannot be used at all for s390, because we also use page->lru
> > > to keep our list of free 2K pagetable fragments. I always get confused
> > > by struct page unions, so not completely sure, but it seems to me that
> > > page->rcu_head would overlay with page->lru, right?  
> > 
> > Sigh, yes, page->rcu_head overlays page->lru.  But (please correct me if
> > I'm wrong) I think that s390 could use exactly the same technique for
> > its list of free 2K pagetable fragments as it uses for its list of THP
> > "deposited" pagetable fragments, over in arch/s390/mm/pgtable.c: use
> > the first two longs of the page table itself for threading the list.
> 
> Nice idea, I think that could actually work, since we only need the empty
> 2K halves on the list. So it should be possible to store the list_head
> inside those.

Jason quickly pointed out the flaw in my thinking there.

> 
> > 
> > And while it could use third and fourth longs instead, I don't see any
> > need for that: a deposited pagetable has been allocated, so would not
> > be on the list of free fragments.
> 
> Correct, that should not interfere.
> 
> > 
> > Below is one of the grossest patches I've ever posted: gross because
> > it's a rushed attempt to see whether that is viable, while it would take
> > me longer to understand all the s390 cleverness there (even though the
> > PP AA commentary above page_table_alloc() is excellent).
> 
> Sounds fair, this is also one of the grossest code we have, which is also
> why Alexander added the comment. I guess we could need even more comments
> inside the code, as it still confuses me more than it should.
> 
> Considering that, you did remarkably well. Your patch seems to work fine,
> at least it survived some LTP mm tests. I will also add it to our CI runs,
> to give it some more testing. Will report tomorrow when it broke something.
> See also below for some patch comments.

Many thanks for your effort on this patch.  I don't expect the testing
of it to catch Jason's point, that I'm corrupting the page table while
it's on its way through RCU to being freed, but he's right nonetheless.

I'll integrate your fixes below into what I have here, but probably
just archive it as something to refer to later in case it might play
a part; but probably it will not - sorry for wasting your time.

> 
> > 
> > I'm hoping the use of page->lru in arch/s390/mm/gmap.c is disjoint.
> > And cmma_init_nodat()? Ah, that's __init so I guess disjoint.
> 
> cmma_init_nodat() should be disjoint, not only because it is __init,
> but also because it explicitly skips pagetable pages, so it should
> never touch page->lru of those.
> 
> Not very familiar with the gmap code, it does look disjoint, and we should
> also use complete 4K pages for pagetables instead of 2K fragments there,
> but Christian or Claudio should also have a look.
> 
> > 
> > Gerald, s390 folk: would it be possible for you to give this
> > a try, suggest corrections and improvements, and then I can make it
> > a separate patch of the series; and work on avoiding concurrent use
> > of the rcu_head by pagetable fragment buddies (ideally fit in with
> > the scheme already there, maybe DD bits to go along with the PP AA).
> 
> It feels like it could be possible to not only avoid the double
> rcu_head, but also avoid passing over the mm via page->pt_mm.
> I.e. have pte_free_defer(), which has the mm, do all the checks and
> list updates that page_table_free() does, for which we need the mm.
> Then just skip the pgtable_pte_page_dtor() + __free_page() at the end,
> and do call_rcu(pte_free_now) instead. The pte_free_now() could then
> just do _dtor/__free_page similar to the generic version.

I'm not sure: I missed your suggestion there when I first skimmed
through, and today have spent more time getting deeper into how it's
done at present.  I am now feeling more confident of a way forward,
a nicely integrated way forward, than I was yesterday.
Though getting it right may not be so easy.

When Jason pointed out the existing RCU, I initially hoped that it might
already provide the necessary framework: but sadly not, because the
unbatched case (used when additional memory is not available) does not
use RCU at all, but instead the tlb_remove_table_sync_one() IRQ hack.
If I used that, it would cripple the s390 implementation unacceptably.

> 
> I must admit that I still have no good overview of the "big picture"
> here, and especially if this approach would still fit in. Probably not,
> as the to-be-freed pagetables would still be accessible, but not really
> valid, if we added them back to the list, with list_heads inside them.
> So maybe call_rcu() has to be done always, and not only for the case
> where the whole 4K page becomes free, then we probably cannot do w/o
> passing over the mm for proper list handling.

My current thinking (but may be proved wrong) is along the lines of:
why does something on its way to being freed need to be on any list
than the rcu_head list?  I expect the current answer is, that the
other half is allocated, so the page won't be freed; but I hope that
we can put it back on that list once we're through with the rcu_head.

But the less I say now, the less I shall make a fool of myself:
I need to get deeper in.

> 
> Ah, and they could also be re-used, once they are back on the list,
> which will probably not go well. Is that what you meant with DD bits,
> i.e. mark such fragments to prevent re-use? Smells a bit like the
> "pending purge"

Yes, we may not need those DD defer bits at all: the pte_free_defer()
pagetables should fit very well with "pending purge" as it is.  They
will go down an unbatched route, but should be obeying the same rules.

> 
> > 
> > Why am I even asking you to move away from page->lru: why don't I
> > thread s390's pte_free_defer() pagetables like THP's deposit does?
> > I cannot, because the deferred pagetables have to remain accessible
> > as valid pagetables, until the RCU grace period has elapsed - unless
> > all the list pointers would appear as pte_none(), which I doubt.
> 
> Yes, only empty and invalid PTEs will appear as pte_none(), i.e. entries
> that contain only 0x400.
> 
> Ok, I guess that also explains why the approach mentioned above,
> to avoid passing over the mm and do the list handling already in
> pte_free_defer(), will not be so easy or possible at all.
> 
> > 
> > (That may limit our possibilities with the deposited pagetables in
> > future: I can imagine them too wanting to remain accessible as valid
> > pagetables.  But that's not needed by this series, and s390 only uses
> > deposit/withdraw for anon THP; and some are hoping that we might be
> > able to move away from deposit/withdraw altogther - though powerpc's
> > special use will make that more difficult.)
> > 
> > Thanks!
> > Hugh
> > 
> > --- 6.4-rc5/arch/s390/mm/pgalloc.c
> > +++ linux/arch/s390/mm/pgalloc.c
> > @@ -232,6 +232,7 @@ void page_table_free_pgste(struct page *
> >   */
> >  unsigned long *page_table_alloc(struct mm_struct *mm)
> >  {
> > +	struct list_head *listed;
> >  	unsigned long *table;
> >  	struct page *page;
> >  	unsigned int mask, bit;
> > @@ -241,8 +242,8 @@ unsigned long *page_table_alloc(struct m
> >  		table = NULL;
> >  		spin_lock_bh(&mm->context.lock);
> >  		if (!list_empty(&mm->context.pgtable_list)) {
> > -			page = list_first_entry(&mm->context.pgtable_list,
> > -						struct page, lru);
> > +			listed = mm->context.pgtable_list.next;
> > +			page = virt_to_page(listed);
> >  			mask = atomic_read(&page->_refcount) >> 24;
> >  			/*
> >  			 * The pending removal bits must also be checked.
> > @@ -259,9 +260,12 @@ unsigned long *page_table_alloc(struct m
> >  				bit = mask & 1;		/* =1 -> second 2K */
> >  				if (bit)
> >  					table += PTRS_PER_PTE;
> > +				BUG_ON(table != (unsigned long *)listed);
> >  				atomic_xor_bits(&page->_refcount,
> >  							0x01U << (bit + 24));
> > -				list_del(&page->lru);
> > +				list_del(listed);
> > +				set_pte((pte_t *)&table[0], __pte(_PAGE_INVALID));
> > +				set_pte((pte_t *)&table[1], __pte(_PAGE_INVALID));
> >  			}
> >  		}
> >  		spin_unlock_bh(&mm->context.lock);
> > @@ -288,8 +292,9 @@ unsigned long *page_table_alloc(struct m
> >  		/* Return the first 2K fragment of the page */
> >  		atomic_xor_bits(&page->_refcount, 0x01U << 24);
> >  		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
> > +		listed = (struct list head *)(table + PTRS_PER_PTE);
> 
> Missing "_" in "struct list head"
> 
> >  		spin_lock_bh(&mm->context.lock);
> > -		list_add(&page->lru, &mm->context.pgtable_list);
> > +		list_add(listed, &mm->context.pgtable_list);
> >  		spin_unlock_bh(&mm->context.lock);
> >  	}
> >  	return table;
> > @@ -310,6 +315,7 @@ static void page_table_release_check(str
> >  
> >  void page_table_free(struct mm_struct *mm, unsigned long *table)
> >  {
> > +	struct list_head *listed;
> >  	unsigned int mask, bit, half;
> >  	struct page *page;
> 
> Not sure if "reverse X-mas" is still part of any style guidelines,
> but I still am a big fan of that :-). Although the other code in that
> file is also not consistently using it ...
> 
> >  
> > @@ -325,10 +331,24 @@ void page_table_free(struct mm_struct *m
> >  		 */
> >  		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> >  		mask >>= 24;
> > -		if (mask & 0x03U)
> > -			list_add(&page->lru, &mm->context.pgtable_list);
> > -		else
> > -			list_del(&page->lru);
> > +		if (mask & 0x03U) {
> > +			listed = (struct list_head *)table;
> > +			list_add(listed, &mm->context.pgtable_list);
> > +		} else {
> > +			/*
> > +			 * Get address of the other page table sharing the page.
> > +			 * There are sure to be MUCH better ways to do all this!
> > +			 * But I'm rushing, while trying to keep to the obvious.
> > +			 */
> > +			listed = (struct list_head *)(table + PTRS_PER_PTE);
> > +			if (virt_to_page(listed) != page) {
> > +				/* sizeof(*listed) is twice sizeof(*table) */
> > +				listed -= PTRS_PER_PTE;
> > +			}
> 
> Bitwise XOR with 0x800 should do the trick here, i.e. give you the address
> of the other 2K half, like this:
> 
> 			listed = (struct list_head *)((unsigned long) table ^ 0x800UL);
> 
> > +			list_del(listed);
> > +			set_pte((pte_t *)&listed->next, __pte(_PAGE_INVALID));
> > +			set_pte((pte_t *)&listed->prev, __pte(_PAGE_INVALID));
> > +		}
> >  		spin_unlock_bh(&mm->context.lock);
> >  		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
> >  		mask >>= 24;
> > @@ -349,6 +369,7 @@ void page_table_free(struct mm_struct *m
> >  void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
> >  			 unsigned long vmaddr)
> >  {
> > +	struct list_head *listed;
> >  	struct mm_struct *mm;
> >  	struct page *page;
> >  	unsigned int bit, mask;
> > @@ -370,10 +391,24 @@ void page_table_free_rcu(struct mmu_gath
> >  	 */
> >  	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
> >  	mask >>= 24;
> > -	if (mask & 0x03U)
> > -		list_add_tail(&page->lru, &mm->context.pgtable_list);
> > -	else
> > -		list_del(&page->lru);
> > +	if (mask & 0x03U) {
> > +		listed = (struct list_head *)table;
> > +		list_add_tail(listed, &mm->context.pgtable_list);
> > +	} else {
> > +		/*
> > +		 * Get address of the other page table sharing the page.
> > +		 * There are sure to be MUCH better ways to do all this!
> > +		 * But I'm rushing, and trying to keep to the obvious.
> > +		 */
> > +		listed = (struct list_head *)(table + PTRS_PER_PTE);
> > +		if (virt_to_page(listed) != page) {
> > +			/* sizeof(*listed) is twice sizeof(*table) */
> > +			listed -= PTRS_PER_PTE;
> > +		}
> 
> Same as above.
> 
> > +		list_del(listed);
> > +		set_pte((pte_t *)&listed->next, __pte(_PAGE_INVALID));
> > +		set_pte((pte_t *)&listed->prev, __pte(_PAGE_INVALID));
> > +	}
> >  	spin_unlock_bh(&mm->context.lock);
> >  	table = (unsigned long *) ((unsigned long) table | (0x01U << bit));
> >  	tlb_remove_table(tlb, table);
> 
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Thanks a lot, Gerald, sorry that it now looks like wasted effort.

I'm feeling confident enough of getting into s390 PP-AA-world now, that
I think my top priority should be posting a v2 of the two preliminary
series: get those out before focusing back on s390 mm/pgalloc.c.

Is it too early to wish you a happy reverse Xmas?

Hugh
