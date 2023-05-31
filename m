Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54108718D74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjEaVrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaVrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:47:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76972128
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685569598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igYFvs+c9N5WeBPgjDiciSp0VkV0okfe8MCEg9xv7Mk=;
        b=J6vf+b9YqlhROrKGpyJcQK0s14OJBFxBuYLhYaY9bJZn/9DFmDVxXX79Wppt5M/pa2WZFe
        z4gyBEU6X8Um0DV4MF5Q+5RlP8Z03haHApSMpmbCX7upV7+ircay05iaLz4W+ekC8PHNAR
        59uiQfGV+OCZfrdnNb/rMqFeK/SSp6Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Rxepog13OTGG01ismUtfRQ-1; Wed, 31 May 2023 17:46:37 -0400
X-MC-Unique: Rxepog13OTGG01ismUtfRQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62829b2aa10so400326d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685569597; x=1688161597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igYFvs+c9N5WeBPgjDiciSp0VkV0okfe8MCEg9xv7Mk=;
        b=lY++npYLvcLN2/J/ZGOGO3C0GmAWQDtAGWUHhk4ore9eAZwRyRAykcJ/CY4sRTUM2A
         ni5/1JuJENcdPP2B63wPwqC/zTt/VgP5yqsckkw9d91QiLErdrSG22JCoSXPUrHAZKHy
         XZH3TJRX1RznuaU6iUv03GCaV5ss53vHsLkDQKHtdZi3TEd0SbC5skehCiGHkJ1Yrjgx
         cxbjXpKmXd2IsCcHafsWjIklvDBZ5aDOrbhAvbCGaTRCaIKQp7pBEWsrL2at7We2utvt
         jS3NphabTbjJNR12gwCK7LLQd6lMnpAJaPnPYskYB+n3wd7Llsb35n0Rqb0shve+vgRF
         y2Kg==
X-Gm-Message-State: AC+VfDxjFJzMT3xYNvl9W9FdDRxZPKg+NDIhG9Vod8T+qfOamexzkN6E
        4HBBb5NMNKWIDZBFwMxnZuoRxUfLYrdypyYNTZk3XiSrBpwwAHiyIHmjAoEx4wJasGUQZ4dXbdN
        eusbctlyk8I6od4OeKYk6RvDh
X-Received: by 2002:a05:6214:4013:b0:626:273e:c35c with SMTP id kd19-20020a056214401300b00626273ec35cmr7808914qvb.2.1685569596871;
        Wed, 31 May 2023 14:46:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bWGqnMQLL01DCWUi2wXYQyUExSGN2qKxzwSnBwQ/iA3qijQefM33xIvhj7QAsoSK7L4uFJQ==
X-Received: by 2002:a05:6214:4013:b0:626:273e:c35c with SMTP id kd19-20020a056214401300b00626273ec35cmr7808878qvb.2.1685569596504;
        Wed, 31 May 2023 14:46:36 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id i27-20020a05620a151b00b0075932cd3ca0sm5728059qkk.69.2023.05.31.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:46:35 -0700 (PDT)
Date:   Wed, 31 May 2023 17:46:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v16 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Message-ID: <ZHfAOAKj1ZQJ+zSy@x1n>
References: <20230525085517.281529-1-usama.anjum@collabora.com>
 <20230525085517.281529-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525085517.281529-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muhammad,

Sorry, I probably can only review the non-interface part, and leave the
interface/buffer handling, etc. review for others and real potential users
of it..

On Thu, May 25, 2023 at 01:55:14PM +0500, Muhammad Usama Anjum wrote:
> +static inline void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
> +					 unsigned long addr, pte_t *ptep,
> +					 pte_t ptent)
> +{
> +	pte_t old_pte;
> +
> +	if (!huge_pte_none(ptent)) {
> +		old_pte = huge_ptep_modify_prot_start(vma, addr, ptep);
> +		ptent = huge_pte_mkuffd_wp(old_pte);
> +		ptep_modify_prot_commit(vma, addr, ptep, old_pte, ptent);

huge_ptep_modify_prot_start()?

The other thing is what if it's a pte marker already?  What if a hugetlb
migration entry?  Please check hugetlb_change_protection().

> +	} else {
> +		set_huge_pte_at(vma->vm_mm, addr, ptep,
> +				make_pte_marker(PTE_MARKER_UFFD_WP));
> +	}
> +}
> +#endif

[...]

> +static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
> +				  unsigned long end, struct mm_walk *walk)
> +{
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long addr = end;
> +	pte_t *pte, *orig_pte;
> +	spinlock_t *ptl;
> +	bool is_written;
> +	int ret = 0;
> +
> +	arch_enter_lazy_mmu_mode();
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	ptl = pmd_trans_huge_lock(pmd, vma);
> +	if (ptl) {
> +		unsigned long n_pages = (end - start)/PAGE_SIZE;
> +
> +		if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +			n_pages = p->max_pages - p->found_pages;
> +
> +		is_written = !is_pmd_uffd_wp(*pmd);
> +
> +		/*
> +		 * Break huge page into small pages if the WP operation need to
> +		 * be performed is on a portion of the huge page.
> +		 */
> +		if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +		    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +			spin_unlock(ptl);
> +
> +			split_huge_pmd(vma, pmd, start);
> +			goto process_smaller_pages;
> +		}
> +
> +		if (IS_PM_SCAN_GET(p->flags))
> +			ret = pagemap_scan_output(is_written, vma->vm_file,
> +						  pmd_present(*pmd),
> +						  is_swap_pmd(*pmd),
> +						  p, start, n_pages);
> +
> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
> +			make_uffd_wp_pmd(vma, addr, pmd);
> +
> +		if (IS_PM_SCAN_WP(p->flags))
> +			flush_tlb_range(vma, start, end);
> +
> +		spin_unlock(ptl);
> +
> +		arch_leave_lazy_mmu_mode();
> +		return ret;
> +	}
> +
> +process_smaller_pages:
> +	if (pmd_trans_unstable(pmd)) {
> +		arch_leave_lazy_mmu_mode();
> +		return 0;

I'm not sure whether this is right..  Shouldn't you return with -EAGAIN and
let the user retry?  Returning 0 means you'll move on with the next pmd
afaict and ignoring this one.

> +	}
> +#endif
> +
> +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);

Just a heads-up that this may start to fail at some point if Hugh's work
will land earlier:

https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com/

> +	for (addr = start; addr < end && !ret; pte++, addr += PAGE_SIZE) {
> +		is_written = !is_pte_uffd_wp(*pte);
> +
> +		if (IS_PM_SCAN_GET(p->flags))
> +			ret = pagemap_scan_output(is_written, vma->vm_file,
> +						  pte_present(*pte),
> +						  is_swap_pte(*pte),
> +						  p, addr, 1);
> +
> +		if (ret >= 0 && is_written && IS_PM_SCAN_WP(p->flags))
> +			make_uffd_wp_pte(vma, addr, pte);
> +	}
> +
> +	if (IS_PM_SCAN_WP(p->flags))
> +		flush_tlb_range(vma, start, addr);
> +
> +	pte_unmap_unlock(orig_pte, ptl);
> +	arch_leave_lazy_mmu_mode();
> +
> +	cond_resched();
> +	return ret;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
> +				      unsigned long start, unsigned long end,
> +				      struct mm_walk *walk)
> +{
> +	unsigned long n_pages = (end - start)/PAGE_SIZE;
> +	struct pagemap_scan_private *p = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	struct hstate *h = hstate_vma(vma);
> +	spinlock_t *ptl;
> +	bool is_written;
> +	int ret = 0;
> +	pte_t pte;
> +
> +	arch_enter_lazy_mmu_mode();

This _seems_ to be not needed for hugetlb entries.

> +
> +	if (p->max_pages && n_pages > p->max_pages - p->found_pages)
> +		n_pages = p->max_pages - p->found_pages;
> +
> +	if (IS_PM_SCAN_WP(p->flags)) {
> +		i_mmap_lock_write(vma->vm_file->f_mapping);
> +		ptl = huge_pte_lock(h, vma->vm_mm, ptep);
> +	}
> +
> +	pte = huge_ptep_get(ptep);
> +	is_written = !is_huge_pte_uffd_wp(pte);
> +
> +	/*
> +	 * Partial hugetlb page clear isn't supported
> +	 */
> +	if (is_written && IS_PM_SCAN_WP(p->flags) &&
> +	    n_pages < HPAGE_SIZE/PAGE_SIZE) {
> +		ret = -EPERM;
> +		goto unlock_and_return;
> +	}
> +
> +	if (IS_PM_SCAN_GET(p->flags)) {
> +		ret = pagemap_scan_output(is_written, vma->vm_file,
> +					  pte_present(pte), is_swap_pte(pte),
> +					  p, start, n_pages);
> +		if (ret < 0)
> +			goto unlock_and_return;
> +	}
> +
> +	if (is_written && IS_PM_SCAN_WP(p->flags)) {
> +		make_uffd_wp_huge_pte(vma, start, ptep, pte);
> +		flush_hugetlb_tlb_range(vma, start, end);
> +	}
> +
> +unlock_and_return:
> +	if (IS_PM_SCAN_WP(p->flags)) {
> +		spin_unlock(ptl);
> +		i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	}
> +
> +	arch_leave_lazy_mmu_mode();

Same here.

> +
> +	return ret;
> +}

[...]

-- 
Peter Xu

