Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD1E68979B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBCLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjBCLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:17:37 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104068FB6F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n6BMnRqodGEdSdHoW4ANPnBbVuiZx8SV3Fs1Jtl+/ok=; b=eRUYjM6mnRt3qbbIWi9IvXZDni
        bHX68Pan196Us9z97WLUaA0W0h7avdFSk8eTktALo+bZB7rgRUW/O1Ak/GxlS08lP3Ra/82vw+a3U
        6LMvTU58IybrXUHcv1TUQbhQCBNJS9ZjtFmbG/BZkEn15Q3mRN4SuUdJeStcuO+VWetCGEQ63H6GU
        9eZp8x6gevff74U+Fkc0o+A0E0H7ZP0Gr8vaQUCXjLM+K6iB7NVepD2fGSABUwbswWH+IvbCGSTBk
        Koo2Wc6awJ6r6Ulh04DSbStlZAf6MJn4LeAePmepmoOsbaD2Jo18LHxeHTZBNe873tRY9Pr9oYDmo
        SuqQPUnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pNu2F-005Ua9-0h;
        Fri, 03 Feb 2023 11:16:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EFC7A300446;
        Fri,  3 Feb 2023 12:15:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3AAB212BDE63; Fri,  3 Feb 2023 12:15:48 +0100 (CET)
Date:   Fri, 3 Feb 2023 12:15:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [PATCH V2 2/3] sched/numa: Enhance vma scanning logic
Message-ID: <Y9zs5A/T1WQpJTuM@hirez.programming.kicks-ass.net>
References: <cover.1675159422.git.raghavendra.kt@amd.com>
 <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0872657ddb164aa047a2231f8dc1086fe6adf6.1675159422.git.raghavendra.kt@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:32:21PM +0530, Raghavendra K T wrote:
>  During the Numa scanning make sure only relevant vmas of the
> tasks are scanned.
> 
> Before:
>  All the tasks of a process participate in scanning the vma
> even if they do not access vma in it's lifespan.
> 
> Now:
>  Except cases of first few unconditional scans, if a process do
> not touch vma (exluding false positive cases of PID collisions)
> tasks no longer scan all vma.
> 
> Logic used:
> 1) 6 bits of PID used to mark active bit in vma numab status during
>  fault to remember PIDs accessing vma. (Thanks Mel)
> 
> 2) Subsequently in scan path, vma scanning is skipped if current PID
> had not accessed vma.
> 
> 3) First two times we do allow unconditional scan to preserve earlier
>  behaviour of scanning.
> 
> Acknowledgement to Bharata B Rao <bharata@amd.com> for initial patch
> to store pid information.
> 
> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  include/linux/mm.h       | 14 ++++++++++++++
>  include/linux/mm_types.h |  1 +
>  kernel/sched/fair.c      | 15 +++++++++++++++
>  mm/huge_memory.c         |  1 +
>  mm/memory.c              |  1 +
>  5 files changed, 32 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 74d9df1d8982..489422942482 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1381,6 +1381,16 @@ static inline int xchg_page_access_time(struct page *page, int time)
>  	last_time = page_cpupid_xchg_last(page, time >> PAGE_ACCESS_TIME_BUCKETS);
>  	return last_time << PAGE_ACCESS_TIME_BUCKETS;
>  }
> +
> +static inline void vma_set_active_pid_bit(struct vm_area_struct *vma)
> +{
> +	unsigned int active_pid_bit;
> +
> +	if (vma->numab) {
> +		active_pid_bit = current->pid % BITS_PER_LONG;
> +		vma->numab->accessing_pids |= 1UL << active_pid_bit;
> +	}
> +}

Perhaps:

	if (vma->numab)
		__set_bit(current->pid % BITS_PER_LONG, &vma->numab->pids);

?

Or maybe even:

	bit = current->pid % BITS_PER_LONG;
	if (vma->numab && !__test_bit(bit, &vma->numab->pids))
		__set_bit(bit, &vma->numab->pids);


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 060b241ce3c5..3505ae57c07c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2916,6 +2916,18 @@ static void reset_ptenuma_scan(struct task_struct *p)
>  	p->mm->numa_scan_offset = 0;
>  }
>  
> +static bool vma_is_accessed(struct vm_area_struct *vma)
> +{
> +	unsigned int active_pid_bit;
> +
	/*
	 * Tell us why 2....
	 */
> +	if (READ_ONCE(current->mm->numa_scan_seq) < 2)
> +		return true;
> +
> +	active_pid_bit = current->pid % BITS_PER_LONG;
> +
> +	return vma->numab->accessing_pids & (1UL << active_pid_bit);
	return __test_bit(current->pid % BITS_PER_LONG, &vma->numab->pids)
> +}
> +
>  /*
>   * The expensive part of numa migration is done from task_work context.
>   * Triggered from task_tick_numa().
> @@ -3032,6 +3044,9 @@ static void task_numa_work(struct callback_head *work)
>  		if (mm->numa_scan_seq && time_before(jiffies, vma->numab->next_scan))
>  			continue;
>  
		/*
		 * tell us more...
		 */
> +		if (!vma_is_accessed(vma))
> +			continue;
> +
>  		do {
>  			start = max(start, vma->vm_start);
>  			end = ALIGN(start + (pages << PAGE_SHIFT), HPAGE_SIZE);


This feels wrong, specifically we track numa_scan_offset per mm, now, if
we divide the threads into two dis-joint groups each only using their
own set of vmas (in fact quite common for workloads with proper data
partitioning) it is possible to consistently sample one set of threads
and thus not scan the other set of vmas.

It seems somewhat unlikely, but not impossible to create significant
unfairness.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 811d19b5c4f6..d908aa95f3c3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1485,6 +1485,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	bool was_writable = pmd_savedwrite(oldpmd);
>  	int flags = 0;
>  
> +	vma_set_active_pid_bit(vma);
>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
>  		spin_unlock(vmf->ptl);
> diff --git a/mm/memory.c b/mm/memory.c
> index 8c8420934d60..2ec3045cb8b3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4718,6 +4718,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	bool was_writable = pte_savedwrite(vmf->orig_pte);
>  	int flags = 0;
>  
> +	vma_set_active_pid_bit(vma);
>  	/*
>  	 * The "pte" at this point cannot be used safely without
>  	 * validation through pte_unmap_same(). It's of NUMA type but

Urghh... do_*numa_page() is two near identical functions.. is there
really no sane way to de-duplicate at least some of that?

Also, is this placement right, you're marking the thread even before we
know there's even a page there. I would expect this somewhere around
where we track lastpid.

Maybe numa_migrate_prep() ?
