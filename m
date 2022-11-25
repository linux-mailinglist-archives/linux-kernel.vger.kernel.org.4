Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A9F638BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiKYN4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKYN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0D81A217
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669384538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v0Rm2rACyFv6E1mOm4SIOMpNqdoU64JxaywiSbHtE6M=;
        b=cte4WSMYG9B23fCfRYD+u3G+hEFw3JYU5BdV5gVH891OBJrf/9Zx1J3cjp9FTWLujfyGmx
        KexDhW3vvKSiwuHMSMVUMyhtWtGIn1eqH0saFMsAxtcbhN5yxtMtLaBDY1nQHQUD5PstDL
        2QYRknOZkiA+/Vm8v1wLaSdwRPD01BM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-aJ-ARrGtOZi_6IR3VskPDg-1; Fri, 25 Nov 2022 08:55:37 -0500
X-MC-Unique: aJ-ARrGtOZi_6IR3VskPDg-1
Received: by mail-qk1-f198.google.com with SMTP id br8-20020a05620a460800b006fbf8866293so5402311qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Rm2rACyFv6E1mOm4SIOMpNqdoU64JxaywiSbHtE6M=;
        b=gdlxnXegLPrcSbzymS7MkawrcjcTGv5ALKcmh9zWselTFCG1fYWzZZrPrklr1G1jQ6
         vDsyt9AJQmYyyjHU6c9ETGlWOY7e7Esnt3NsAa0nPMRNpqKmj/BmLKOI9tZQZCdDg2xe
         P0B8BcYv0itspKj4+66RHBwuuNk3+hpvCwGS2InEW3QwYQDzrUAK893kTe1WZ+Tx4aW5
         IwxjyzzBxuN8ZgPPHBOts7g6VRwewwsP2pFyzxBMdyvEwhH6k0zBugl7v5g6+XYh7HaB
         WKGDpgCvdsFuwwbQNJ1ZYF7Khw+8mpbRdOPc4sQT7mcepUmR2dTz3fQ9A60DJ9TVIf7Q
         Y5Lw==
X-Gm-Message-State: ANoB5pmFDwfUsJ29uEOTtmZ9quNkcTzhPz2pmVTeaLISKcOeoRVdvxM0
        bSIzhb4NnuE/sLNS3A8ynQTt3Mn6lIQ3GA//ap9tKtEKw/a81JiXTtroraSd0nzHVqJuMjEnnq4
        rq50kx9q23urj2o63eDRZP+/c
X-Received: by 2002:a37:8a45:0:b0:6f9:fd7a:f300 with SMTP id m66-20020a378a45000000b006f9fd7af300mr17897035qkd.257.1669384537002;
        Fri, 25 Nov 2022 05:55:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf59/yTRceIpvgcasRJR+5OX2+3EsmYQZLlOI7Ardpwc2mtQkPSOS8x5uMgPdo+oysJTAtin6g==
X-Received: by 2002:a37:8a45:0:b0:6f9:fd7a:f300 with SMTP id m66-20020a378a45000000b006f9fd7af300mr17897009qkd.257.1669384536609;
        Fri, 25 Nov 2022 05:55:36 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id l126-20020a378984000000b006cfc7f9eea0sm2739828qkd.122.2022.11.25.05.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 05:55:35 -0800 (PST)
Date:   Fri, 25 Nov 2022 08:55:34 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset()
 thread-safe for pmd unshare
Message-ID: <Y4DJVqIP4A1rS/Wk@x1n>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <70376d57-7924-8ac9-9e93-1831248115a0@redhat.com>
 <Y343kIQ9l2d8wViz@x1n>
 <21278883-46a6-5a6a-fcf5-9a6ee6f632a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21278883-46a6-5a6a-fcf5-9a6ee6f632a9@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:43:43AM +0100, David Hildenbrand wrote:
> On 23.11.22 16:09, Peter Xu wrote:
> > Hi, David,
> > 
> > Thanks for taking a look.
> > 
> > On Wed, Nov 23, 2022 at 10:40:40AM +0100, David Hildenbrand wrote:
> > > On 18.11.22 02:10, Peter Xu wrote:
> > > > Based on latest mm-unstable (96aa38b69507).
> > > > 
> > > > This can be seen as a follow-up series to Mike's recent hugetlb vma lock
> > > > series for pmd unsharing, so this series also depends on that one.
> > > > Hopefully this series can make it a more complete resolution for pmd
> > > > unsharing.
> > > > 
> > > > PS: so far no one strongly ACKed this, let me keep the RFC tag.  But I
> > > > think I'm already more confident than many of the RFCs I posted.
> > > > 
> > > > PS2: there're a lot of changes comparing to rfcv1, so I'm just not adding
> > > > the changelog.  The whole idea is still the same, though.
> > > > 
> > > > Problem
> > > > =======
> > > > 
> > > > huge_pte_offset() is a major helper used by hugetlb code paths to walk a
> > > > hugetlb pgtable.  It's used mostly everywhere since that's needed even
> > > > before taking the pgtable lock.
> > > > 
> > > > huge_pte_offset() is always called with mmap lock held with either read or
> > > > write.
> > > > 
> > > > For normal memory types that's far enough, since any pgtable removal
> > > > requires mmap write lock (e.g. munmap or mm destructions).  However hugetlb
> > > > has the pmd unshare feature, it means not only the pgtable page can be gone
> > > > from under us when we're doing a walking, but also the pgtable page we're
> > > > walking (even after unshared, in this case it can only be the huge PUD page
> > > > which contains 512 huge pmd entries, with the vma VM_SHARED mapped).  It's
> > > > possible because even though freeing the pgtable page requires mmap write
> > > > lock, it doesn't help us when we're walking on another mm's pgtable, so
> > > > it's still on risk even if we're with the current->mm's mmap lock.
> > > > 
> > > > The recent work from Mike on vma lock can resolve most of this already.
> > > > It's achieved by forbidden pmd unsharing during the lock being taken, so no
> > > > further risk of the pgtable page being freed.  It means if we can take the
> > > > vma lock around all huge_pte_offset() callers it'll be safe.
> > 
> > [1]
> > 
> > > > 
> > > > There're already a bunch of them that we did as per the latest mm-unstable,
> > > > but also quite a few others that we didn't for various reasons.  E.g. it
> > > > may not be applicable for not-allow-to-sleep contexts like FOLL_NOWAIT.
> > > > Or, huge_pmd_share() is actually a tricky user of huge_pte_offset(),
> > 
> > [2]
> > 
> > > > because even if we took the vma lock, we're walking on another mm's vma!
> > > > Taking vma lock for all the vmas are probably not gonna work.
> > > > 
> > > > I have totally no report showing that I can trigger such a race, but from
> > > > code wise I never see anything that stops the race from happening.  This
> > > > series is trying to resolve that problem.
> > > 
> > > Let me try understand the basic problem first:
> > > 
> > > hugetlb walks page tables semi-lockless: while we hold the mmap lock, we
> > > don't grab the page table locks. That's very hugetlb specific handling and I
> > > assume hugetlb uses different mechanisms to sync against MADV_DONTNEED,
> > > concurrent page fault s... but that's no news. hugetlb is weird in many ways
> > > :)
> > > 
> > > So, IIUC, you want a mechanism to synchronize against PMD unsharing. Can't
> > > we use some very basic locking for that?
> > 
> 
> Sorry for the delay, finally found time to look into this again. :)
> 
> > Yes we can in most cases.  Please refer to above paragraph [1] where I
> > referred Mike's recent work on vma lock.  That's the basic locking we need
> > so far to protect pmd unsharing.  I'll attach the link too in the next
> > post, which is here:
> > 
> > https://lore.kernel.org/r/20220914221810.95771-1-mike.kravetz@oracle.com
> > 
> > > 
> > > Using RCU / disabling local irqs seems a bit excessive because we *are*
> > > holding the mmap lock and only care about concurrent unsharing
> > 
> > The series wanted to address where the vma lock is not easy to take.  It
> > originates from when I was reading Mike's other patch, I forgot why I did
> > that but I just noticed there's some code path that we may not want to take
> > a sleepable lock, e.g. in follow page code.
> 
> As I stated, whenever we already take the (expensive) mmap lock, the least
> thing we should have to worry about is taking another sleepable lock IMHO.
> Please correct me if I'm wrong.

Yes that's not a major concern.  But I still think the follow page path
should sleep as less as possible.  For example, non-hugetlb doesn't sleep
now.  If with RCU lock we may do it lockless, then why not?

The same thing to patch 3 of this patchset - I would think it beneficial to
have even without a new lock type introduced, because it still makes the
follow page path cleaner, and have the hugetlb and non-hugetlb match.

> 
> > 
> > The other one is huge_pmd_share() where we may have the mmap lock for
> > current mm but we're fundamentally walking another mm.  It'll be tricky to
> > take a sleepable lock in such condition too.
> 
> We're already grabbing the i_mmap_lock_read(mapping), and the VMAs are
> should be stable in that interval tree IIUC. So I wonder if taking VMA locks
> would really be problematic here. Anything obvious I am missing?

No, I think you're right, and I found that myself just yesterday when I was
writting a reproducer.  huge_pmd_share() is safe here, so at least that
patch in this patchset can be dropped.

> 
> > 
> > I mentioned these cases in the other paragraph above [2].  Let me try to
> > expand that in my next post too.
> 
> That would be great. I yet have to dedicate more time to understand all that
> complexity.
> 
> > 
> > It's debatable whether all the rest places can only work with either RCU or
> > irq disabled, but the idea is at least it should speed up those paths when
> > we still can.  Here, irqoff might be a bit heavy, but RCU lock should be
> > always superior to vma lock when possible, the payoff is we may still see
> > stale pgtable data (since unsharing can still happen in parallel), while
> > that can be completely avoided when we take the vma lock.
> 
> IRQ disabled is frowned upon by RT folks, that's why I'd like to understand
> if this is really required. Also, adding RCU to an already complex mechanism
> doesn't necessarily make it easier :)

I've posted it before, let me copy that over:

arch/arm64/Kconfig:     select MMU_GATHER_RCU_TABLE_FREE     
arch/x86/Kconfig:       select MMU_GATHER_RCU_TABLE_FREE        if PARAVIRT

arch/arm64/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
arch/riscv/Kconfig:     select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
arch/x86/Kconfig:       select ARCH_WANT_HUGE_PMD_SHARE

The irqoff thing is definitely unfortunate, but that's only happening with
riscv or x86 when !PARAVIRT.  I would suppose PARAVIRT a common
config.. then it's majorly for riscv only.  If someday riscv can support
rcu table free we can remove it and enforce rcu table free for pmd sharing
if wanted.

Said that, the "new lock" part is definitely not the core of the patchset
(even if it might read like that..).  The core part is to first identify
the issue on overlooked usage of huge_pte_offset() and how to make it
always safe.

Let me also update a few more things when at it.

Since it'll be very hard to reproduce the race discussed in this series, I
didn't try to write a reproducer until yesterday. I'll need some kernel
delays to trigger that, only if so I can trigger some use-after-free.  So I
think problem confirmed.  The rest is how to resolve it, and whether the
vma lock is good enough.

One other thing to mention is I overlooked one important thing on the huge
pgtable lock, which is actually not protected by RCU (as it's part of
pmd_free()).  IOW if a hugetlb walker that wants to do huge_pte_lock()
after huge_pte_offset() it won't be guarded by RCU, hence the new lock
won't easily work for them.  That's another thing very unfortunate.  I'm
not sure whether it's okay to move that part into the page free rcu
callback, but definitely needs more thoughts as pmd_free() is an arch API.

Debatably irqoff might work if the arch needs IPI for tlb flush so irqoff
may protect both the pgtable page but also the huge_pte_lock(), but I don't
think it's wise either to enlarge the irqoff to generic archs, and also I
think "whether tlb flush requires IPI" is arch-specific, that makes this
over complicated too and not necessary.

So firstly, I think I need to rework the patchset so more places will need
to take the vma lock (where pgtable lock needed).  I tend to keep the RCU
lock because it's lighter at least to !riscv, if so it'll look like this
for the rule to use huge_pte_offset():

/*
 * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
 * Returns the pte_t* if found, or NULL if the address is not mapped.
 *
 * IMPORTANT: we should normally not directly call this function, instead
 * this is only a common interface to implement arch-specific walker.
 * Please consider using the hugetlb_walk() helper to make sure of the
 * correct locking is satisfied.
 *
 * Since this function will walk all the pgtable pages (including not only
 * high-level pgtable page, but also PUD entry that can be unshared
 * concurrently for VM_SHARED), the caller of this function should be
 * responsible of its thread safety.  One can follow this rule:
 *
 *  (1) For private mappings: pmd unsharing is not possible, so it'll
 *      always be safe if we're with the mmap sem for either read or write.
 *      This is normally always the case, IOW we don't need to do anything
 *      special.
 *
 *  (2) For shared mappings: pmd unsharing is possible (so the PUD-ranged
 *      pgtable page can go away from under us!  It can be done by a pmd
 *      unshare with a follow up munmap() on the other process), then we
 *      need either:
 *
 *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
 *           won't happen upon the range (it also makes sure the pte_t we
 *           read is the right and stable one), or,
 *
 *     (2.2) hugetlb mapping i_mmap_rwsem lock held read or write, to make
 *           sure even if unshare happened the racy unmap() will wait until
 *           i_mmap_rwsem is released, or,
 *
 *     (2.3) pgtable walker lock, to make sure even pmd unsharing happened,
 *           the old shared PUD page won't get freed from under us.  In
 *           this case, the pteval can be obsolete, but at least it's still
 *           always safe to access the page (e.g., de-referencing pte_t*
 *           would not cause use-after-free).  Note, it's not safe to
 *           access pgtable lock with this lock.  If huge_pte_lock()
 *           needed, look for (2.1) or (2.2).
 *
 * Option (2.3) is the lightest, but it means pmd unshare can still happen
 * so the pte got from pgtable walk can be stalled; also only page data is
 * safe to access not others (e.g. pgtable lock).  Option (2.1) is the
 * safest, which guarantees pte stability until the vma lock released,
 * however heavier than (2.3).
 */

Where hugetlb_walk() will be a new wrapper I'll introduce just to make sure
lock protections:

static inline pte_t *
hugetlb_walk(struct vm_area_struct *vma, unsigned long addr, unsigned long sz)
{
#ifdef CONFIG_LOCKDEP
	/* lockdep_is_held() only defined with CONFIG_LOCKDEP */
	if (vma->vm_flags & VM_MAYSHARE) {
		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;

		/*
		 * Here, taking any of the three locks will guarantee
		 * safety of hugetlb pgtable walk.
		 *
		 * For more information on the locking rules of using
		 * huge_pte_offset(), please see the comment above
		 * huge_pte_offset() in the header file.
		 */
		WARN_ON_ONCE(!hugetlb_walker_locked() &&
			     !lockdep_is_held(&vma_lock->rw_sema) &&
			     !lockdep_is_held(
				 &vma->vm_file->f_mapping->i_mmap_rwsem));
	}
#endif

	return huge_pte_offset(vma->vm_mm, addr, sz);
}

-- 
Peter Xu

