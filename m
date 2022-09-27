Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F915ECC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiI0TA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI0TAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3F15E4F0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:00:21 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 8-20020a17090a0b8800b00205d8564b11so2526451pjr.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VPxbWHE5oCoBASI+IJV2mNevW1WyTdk4e8pg764ECb0=;
        b=h6b35SB/HPmt+thde5SoMzdt5qQVqdbZHxdMkZDfsjj/Cc/ORwXB6FnxKTfoQ1XhbO
         Ru/Dsk8AGYm4E8NAUEb8ZxZeuTncC6ODN+LY4hKHjnw3MYFlKN5To820ND0rPHgaElmN
         JnCpx2XB49Ehy4tQcc5lAwcvtfWWsqurb9IjLYZGxfuxREgMzIYwT/VB0qH7yc7abKYo
         +yqvbadVJIVaBno4Qkoke53LEuDixrVhNljjqS711EqO+tlprIZCHsqJxJSfWoTPI1V5
         77IiBsnnqhIesaYS+FSjCzgKwYeOdsZ9RO36+TD7dgf9m/A3rUCvInmdNInMfe3v+PHg
         VCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VPxbWHE5oCoBASI+IJV2mNevW1WyTdk4e8pg764ECb0=;
        b=xTySQW6E8+8lyVBxZ9/S10qpQaL+XUapyyEdcVo4rmJjRjxPdpgpNoY5GAYqu2aASI
         mV4c4eDQrgF8uV4Vu7JkeFtK64OHsPaP5jIA/VVzQvDhQ6oGoUJrJBDttVsWCF7367Yp
         olGjUO4Tu4j/zSCwOKyiUMrfqTFZ4BGQ+WiGL2Lqdgd2fdqr5PxJILV3Gubqst09tvsk
         S9hX9R4Wga1ORA8NGonK8sH2v5HzO+/VEgvNnbS6tMt9YNKPKJ+ZF3MWv6/iXwMCzSKR
         zrf3lyKmOiDq2RGu9NMIKXV8Oq2cCgFpbRbg1VBFpRW5n+IuANL8qQZRmNKvPuF5rBpm
         mJjw==
X-Gm-Message-State: ACrzQf1q+eFyE6qTHGfBea3H8tR9McO7W8Qxrs+aMzU/FCGfzphydNt9
        8+3w2BnGjUBaMzFboXvC7hw=
X-Google-Smtp-Source: AMsMyM4y55/IcjlbxSTPZI7uXkcejWhcpYaJK2zT1ATKi287UNNNdHfidxyd7tsnLwmdv2vhikcdhA==
X-Received: by 2002:a17:902:8a97:b0:178:1939:c721 with SMTP id p23-20020a1709028a9700b001781939c721mr28701536plo.108.1664305219879;
        Tue, 27 Sep 2022 12:00:19 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001708c4ebbaesm1856571plh.309.2022.09.27.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:00:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 03:00:12 +0800
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tong Tiangen <tongtiangen@huawei.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Li kunyu <kunyu@nfschina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <shy828301@gmail.com>, Song Liu <song@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dinglan Peng <peng301@purdue.edu>,
        Pedro Fonseca <pfonseca@purdue.edu>,
        Jim Huang <jserv@ccns.ncku.edu.tw>,
        Huichun Feng <foxhoundsk.tw@gmail.com>
Subject: Re: [RFC PATCH v2 4/9] mm: Add COW PTE fallback functions
Message-ID: <YzNIPGu+bGEWZXlM@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-5-shiyn.lin@gmail.com>
 <8041503C-D087-434D-A026-90BFD0CAF209@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8041503C-D087-434D-A026-90BFD0CAF209@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:51:19PM +0000, Nadav Amit wrote:
> > +static void cow_pte_rss(struct mm_struct *mm, struct vm_area_struct *vma,
> > +			       pmd_t *pmdp, unsigned long addr,
> > +			       unsigned long end, bool inc_dec)
> > +{
> > +	int rss[NR_MM_COUNTERS];
> > +	spinlock_t *ptl;
> > +	pte_t *orig_ptep, *ptep;
> > +	struct page *page;
> > +
> > +	init_rss_vec(rss);
> > +
> > +	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
> > +	orig_ptep = ptep;
> > +	arch_enter_lazy_mmu_mode();
> > +	do {
> > +		if (pte_none(*ptep))
> > +			continue;
> > +
> > +		page = vm_normal_page(vma, addr, *ptep);
> > +		if (page) {
> > +			if (inc_dec)
> > +				rss[mm_counter(page)]++;
> > +			else
> > +				rss[mm_counter(page)]--;
> > +		}
> > +	} while (ptep++, addr += PAGE_SIZE, addr != end);
> > +	arch_leave_lazy_mmu_mode();
> > +	pte_unmap_unlock(orig_ptep, ptl);
> 
> It seems to me very fragile to separate the accounting from the actual
> operation. I do not see copying of the pages here, so why is the RSS
> updated?

Since it may have a situation like one process that doesn't do the
accounting during COW, and it would want to reuse the table. So, we
need to restore the states.
On the other hand, it will have a situation like unmap the COWed table
and wanting to remove the states.

> 
> > +	add_mm_rss_vec(mm, rss);
> > +}
> > +
> > /*
> >  * This function is called to print an error when a bad pte
> >  * is found. For example, we might have a PFN-mapped pte in
> > @@ -2817,6 +2848,68 @@ int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
> > }
> > EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
> > 
> > +/**
> > + * cow_pte_fallback - reuse the shared PTE table
> > + * @vma: vma that coever the shared PTE table
> > + * @pmd: pmd index maps to the shared PTE table
> > + * @addr: the address trigger the break COW,
> > + *
> > + * Reuse the shared (COW) PTE table when the refcount is equal to one.
> > + * @addr needs to be in the range of the shared PTE table that @vma and
> > + * @pmd mapped to it.
> > + *
> > + * COW PTE fallback to normal PTE:
> > + * - two state here
> > + *   - After break child :   [parent, rss=1, ref=1, write=NO , owner=parent]
> > + *                        to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
> > + *   - After break parent:   [child , rss=0, ref=1, write=NO , owner=NULL  ]
> > + *                        to [child , rss=1, ref=1, write=YES, owner=NULL  ]
> > + */
> > +void cow_pte_fallback(struct vm_area_struct *vma, pmd_t *pmd,
> > +		      unsigned long addr)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct vm_area_struct *prev = vma->vm_prev;
> > +	struct vm_area_struct *next = vma->vm_next;
> > +	unsigned long start, end;
> > +	pmd_t new;
> > +
> > +	VM_WARN_ON(pmd_write(*pmd));
> > +
> > +	start = addr & PMD_MASK;
> > +	end = (addr + PMD_SIZE) & PMD_MASK;
> > +
> > +	/*
> > +	 * If pmd is not owner, it needs to increase the rss.
> > +	 * Since only the owner has the RSS state for the COW PTE.
> > +	 */
> > +	if (!cow_pte_owner_is_same(pmd, pmd)) {
> > +		/* The part of address range is covered by previous. */
> > +		if (start < vma->vm_start && prev && start < prev->vm_end) {
> > +			cow_pte_rss(mm, prev, pmd,
> > +				    start, prev->vm_end, true /* inc */);
> > +			start = vma->vm_start;
> > +		}
> > +		/* The part of address range is covered by next. */
> > +		if (end > vma->vm_end && next && end > next->vm_start) {
> > +			cow_pte_rss(mm, next, pmd,
> > +				    next->vm_start, end, true /* inc */);
> > +			end = vma->vm_end;
> > +		}
> > +		cow_pte_rss(mm, vma, pmd, start, end, true /* inc */);
> > +
> > +		mm_inc_nr_ptes(mm);
> > +		/* Memory barrier here is the same as pmd_install(). */
> > +		smp_wmb();
> > +		pmd_populate(mm, pmd, pmd_page(*pmd));
> > +	}
> > +
> > +	/* Reuse the pte page */
> > +	set_cow_pte_owner(pmd, NULL);
> > +	new = pmd_mkwrite(*pmd);
> > +	set_pmd_at(mm, addr, pmd, new);
> > +}
> 
> Again, kind of hard to understand such a function without a context
> (caller). For instance, is there any lock that prevents
> cow_pte_owner_is_same() from racing with change of the owner?
> 

It is called by the refcount operation and the break COW handler
when the refcount is 1.
Also, It uses synchronization primitives (in set_cow_pte_owner() and
cow_pte_owner_is_same()) to prevent the race.

> I would expect to see first patches that always copy the PTEs without
> reusing the PTEs and only then a PTE reuse logic as an optimization.
> 

I will restructure all the commits to make the logic clear. 

Thanks,
Chih-En Lin
