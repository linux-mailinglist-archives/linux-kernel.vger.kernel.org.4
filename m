Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B835ECCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiI0TXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiI0TXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:23:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7ADD74E7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:23:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id iw17so10000263plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=irMbtd8FZdiIboGibKNEwpTqt4Jj4yNLbVUI1gMwaPk=;
        b=e0FQ6dEVHGBnnI6HqwHOLFzljuzwHYhz+8RFJ0db4risESGFamZ+UkWBPp8hD8O4qr
         4VyJSyWkkMh8iRaCxLOZFA2R3V/It7lko9Ic4CYQYVi6wHUO7A/zCpLRexsMrFULSCH4
         L5cbdNFEbn0q08Zv5vq4ZRaNt90B4qavACQ1ZEfTAbMExzqvrr6rSJH7AKHC6r5R+Tyy
         77E9rONRP2Lk3ZVQrDVzqJgInQVokonQBKLs2S0uum07//G6kgoCBoSoe9R4QFxmI89K
         vSQcEtob0Rgd9W21dmpmg+3xKF56nL/WTSwkOajK+Edlm+bkLNz/y5P/1M2xjSHHcI1z
         2ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=irMbtd8FZdiIboGibKNEwpTqt4Jj4yNLbVUI1gMwaPk=;
        b=vYu9y0tcy4pTID22Fyqm5OwjdWOS6rFjk09mfrwYBii98icd78TUK2T8xNj6JQaBjJ
         YOhZK63c3HppXYr/1PcNWeciiceavKG2y1rGLJl37sqP6qAV+N1+0t0OzpYV98Pz5jVb
         TrsdmEMMmhirNSi2Jcj6s28TUVk+M7Lor+RVsmLr71lWDRO9YbCD2l2ORs2vXS+t+KIj
         VlGCjKEL67YCEPDKMmytjnzeBmLU1nH88rPwuWsinRZqbha+eDxZIiL5ESllhTkkFoxO
         e+nzVpj6CLzv0bE0/AV1cahJ1HRFMN2UiE9lBQ2SBV0PeF8b9bjBtrMsUGUIt7ZTykNF
         /UZQ==
X-Gm-Message-State: ACrzQf209q2BSFa4Z/7sosoeKNi+NyWipQ7x7W2bxoGm9Jo61MNsJuNl
        eptYtOI+ohGEp6znyCEma6o=
X-Google-Smtp-Source: AMsMyM4skroVhGNnqPKoINwdTfOGZ9HFN/FSTUS/QRpvxcQlBjxJf3Qj5fSFlWtyuniJaTLMZgkAcA==
X-Received: by 2002:a17:903:509:b0:179:ffcf:d275 with SMTP id jn9-20020a170903050900b00179ffcfd275mr333187plb.150.1664306600434;
        Tue, 27 Sep 2022 12:23:20 -0700 (PDT)
Received: from strix-laptop (2001-b011-20e0-1b32-d148-19d6-82fa-6094.dynamic-ip6.hinet.net. [2001:b011:20e0:1b32:d148:19d6:82fa:6094])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b0016d773aae60sm1949566plk.19.2022.09.27.12.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:23:19 -0700 (PDT)
Date:   Wed, 28 Sep 2022 03:23:13 +0800
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
Subject: Re: [RFC PATCH v2 7/9] mm: Add the break COW PTE handler
Message-ID: <YzNNoWfTDHNWDLa0@strix-laptop>
References: <20220927162957.270460-1-shiyn.lin@gmail.com>
 <20220927162957.270460-8-shiyn.lin@gmail.com>
 <8F98262B-206B-434C-88B9-9F3A6919782D@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F98262B-206B-434C-88B9-9F3A6919782D@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 06:15:34PM +0000, Nadav Amit wrote:
> On Sep 27, 2022, at 9:29 AM, Chih-En Lin <shiyn.lin@gmail.com> wrote:
> 
> > To handle the COW PTE with write fault, introduce the helper function
> > handle_cow_pte(). The function provides two behaviors. One is breaking
> > COW by decreasing the refcount, pgables_bytes, and RSS. Another is
> > copying all the information in the shared PTE table by using
> > copy_pte_page() with a wrapper.
> > 
> > Also, add the wrapper functions to help us find out the COWed or
> > COW-available PTE table.
> > 
> 
> [ snip ]
> 
> > +static inline int copy_cow_pte_range(struct vm_area_struct *vma,
> > +				     pmd_t *dst_pmd, pmd_t *src_pmd,
> > +				     unsigned long start, unsigned long end)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct mmu_notifier_range range;
> > +	int ret;
> > +	bool is_cow;
> > +
> > +	is_cow = is_cow_mapping(vma->vm_flags);
> > +	if (is_cow) {
> > +		mmu_notifier_range_init(&range, MMU_NOTIFY_PROTECTION_PAGE,
> > +					0, vma, mm, start, end);
> > +		mmu_notifier_invalidate_range_start(&range);
> > +		mmap_assert_write_locked(mm);
> > +		raw_write_seqcount_begin(&mm->write_protect_seq);
> > +	}
> > +
> > +	ret = copy_pte_range(vma, vma, dst_pmd, src_pmd, start, end);
> > +
> > +	if (is_cow) {
> > +		raw_write_seqcount_end(&mm->write_protect_seq);
> > +		mmu_notifier_invalidate_range_end(&range);
> 
> Usually, I would expect mmu-notifiers and TLB flushes to be initiated at the
> same point in the code. Presumably you changed protection, so you do need a
> TLB flush, right? Is it done elsewhere?

You're right.
I will add TLB flushes here.
Thanks.

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Break COW PTE, two state here:
> > + *   - After fork :   [parent, rss=1, ref=2, write=NO , owner=parent]
> > + *                 to [parent, rss=1, ref=1, write=YES, owner=NULL  ]
> > + *                    COW PTE become [ref=1, write=NO , owner=NULL  ]
> > + *                    [child , rss=0, ref=2, write=NO , owner=parent]
> > + *                 to [child , rss=1, ref=1, write=YES, owner=NULL  ]
> > + *                    COW PTE become [ref=1, write=NO , owner=parent]
> > + *   NOTE
> > + *     - Copy the COW PTE to new PTE.
> > + *     - Clear the owner of COW PTE and set PMD entry writable when it is owner.
> > + *     - Increase RSS if it is not owner.
> > + */
> > +static int break_cow_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > +			 unsigned long addr)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	unsigned long pte_start, pte_end;
> > +	unsigned long start, end;
> > +	struct vm_area_struct *prev = vma->vm_prev;
> > +	struct vm_area_struct *next = vma->vm_next;
> > +	pmd_t cowed_entry = *pmd;
> > +
> > +	if (cow_pte_count(&cowed_entry) == 1) {
> > +		cow_pte_fallback(vma, pmd, addr);
> > +		return 1;
> > +	}
> > +
> > +	pte_start = start = addr & PMD_MASK;
> > +	pte_end = end = (addr + PMD_SIZE) & PMD_MASK;
> > +
> > +	pmd_clear(pmd);
> > +	/*
> > +	 * If the vma does not cover the entire address range of the PTE table,
> > +	 * it should check the previous and next.
> > +	 */
> > +	if (start < vma->vm_start && prev) {
> > +		/* The part of address range is covered by previous. */
> > +		if (start < prev->vm_end)
> > +			copy_cow_pte_range(prev, pmd, &cowed_entry,
> > +					   start, prev->vm_end);
> > +		start = vma->vm_start;
> > +	}
> > +	if (end > vma->vm_end && next) {
> > +		/* The part of address range is covered by next. */
> > +		if (end > next->vm_start)
> > +			copy_cow_pte_range(next, pmd, &cowed_entry,
> > +					   next->vm_start, end);
> > +		end = vma->vm_end;
> > +	}
> > +	if (copy_cow_pte_range(vma, pmd, &cowed_entry, start, end))
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * Here, it is the owner, so clear the ownership. To keep RSS state and
> > +	 * page table bytes correct, it needs to decrease them.
> > +	 * Also, handle the address range issue here.
> > +	 */
> > +	if (cow_pte_owner_is_same(&cowed_entry, pmd)) {
> > +		set_cow_pte_owner(&cowed_entry, NULL);
> 
> Presumably there is some assumption on atomicity here. Otherwise, two
> threads can run the following code, which is wrong, no? Yet, I do not see
> anything that provides such atomicity.

I may have multiple process access here. But for the thread, I assume
that they need to hold the mmap_lock. Maybe I need to add the assert
here too.

> 
> > +		if (pte_start < vma->vm_start && prev &&
> > +		    pte_start < prev->vm_end)
> > +			cow_pte_rss(mm, vma->vm_prev, pmd,
> > +				    pte_start, prev->vm_end, false /* dec */);
> > +		if (pte_end > vma->vm_end && next &&
> > +		    pte_end > next->vm_start)
> > +			cow_pte_rss(mm, vma->vm_next, pmd,
> > +				    next->vm_start, pte_end, false /* dec */);
> > +		cow_pte_rss(mm, vma, pmd, start, end, false /* dec */);
> > +		mm_dec_nr_ptes(mm);
> > +	}
> > +
> > +	/* Already handled it, don't reuse cowed table. */
> > +	pmd_put_pte(vma, &cowed_entry, addr, false);
> > +
> > +	VM_BUG_ON(cow_pte_count(pmd) != 1);
> 
> Don’t use VM_BUG_ON().

Sure. I will change it to VM_WARN_ON().

Thanks,
Chih-En Lin
