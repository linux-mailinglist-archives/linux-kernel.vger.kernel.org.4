Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE055B3554
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIIKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIIKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:35:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2F6DF90
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:35:01 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898bqmN026353;
        Fri, 9 Sep 2022 10:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=77u8zhGSKn9z2dZ2Z5tgJalUw9FbQziYzMAthS7y9To=;
 b=jvQr2bg1VeYB9pIqaVzoA0VrLiu+BUzflzT1bzQdfpudFu1qulBb5601RnQn62eccGUI
 AucZxlam3MySOMg4O+TPr7vpZ/u262fvhGo8XON22Rbz9kGoAHiMM2e8ufafrcpW4CY7
 iR7iPOsUDvacvQ1JHkaocW32jzh/aO75lK98C8NX3y0ePc3P3p7iHYGG6MmWXARDluuj
 WYdOGS5cVNEl4PivQN5WmDfQ65dRgX9SQc25bAZYDjI5xTZ9MF5l70+5szKbxyok2Byk
 t0GcyWQhhmNJn2inK8znsObIdU3fwL4mr9XtNB7vdYeIXeBPRWKHq13U1qRkhdIvc7WB +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg1ss3u4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 10:33:51 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898mRBx008692;
        Fri, 9 Sep 2022 10:33:50 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jg1ss3u3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 10:33:50 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 289AL6vR016923;
        Fri, 9 Sep 2022 10:33:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3jbxj8nt0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 10:33:48 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 289AXjNx40042918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Sep 2022 10:33:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD9A4203F;
        Fri,  9 Sep 2022 10:33:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A51FA42042;
        Fri,  9 Sep 2022 10:33:44 +0000 (GMT)
Received: from [9.145.83.17] (unknown [9.145.83.17])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Sep 2022 10:33:44 +0000 (GMT)
Message-ID: <667ad41f-21af-ccc8-be7b-7e6c49930195@linux.ibm.com>
Date:   Fri, 9 Sep 2022 12:33:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [RFC PATCH RESEND 13/28] mm: conditionally mark VMA as locked in
 free_pgtables and unmap_page_range
Content-Language: fr
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-14-surenb@google.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <20220901173516.702122-14-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a0_D0Ua9_0dSm3dji7cOMpXd3OWqA5o4
X-Proofpoint-GUID: ukvTETKNM_PQpDOSGZRiCe9WfRJSdK3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_05,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090035
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/09/2022 à 19:35, Suren Baghdasaryan a écrit :
> free_pgtables and unmap_page_range functions can be called with mmap_lock
> held for write (e.g. in mmap_region), held for read (e.g in
> madvise_pageout) or not held at all (e.g in madvise_remove might
> drop mmap_lock before calling vfs_fallocate, which ends up calling
> unmap_page_range).
> Provide free_pgtables and unmap_page_range with additional argument
> indicating whether to mark the VMA as locked or not based on the usage.
> The parameter is set based on whether mmap_lock is held in write mode
> during the call. This ensures no change in behavior between mmap_lock
> and per-vma locks.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h |  2 +-
>  mm/internal.h      |  4 ++--
>  mm/memory.c        | 32 +++++++++++++++++++++-----------
>  mm/mmap.c          | 17 +++++++++--------
>  mm/oom_kill.c      |  3 ++-
>  5 files changed, 35 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 476bf936c5f0..dc72be923e5b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1874,7 +1874,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  void zap_page_range(struct vm_area_struct *vma, unsigned long address,
>  		    unsigned long size);
>  void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> -		unsigned long start, unsigned long end);
> +		unsigned long start, unsigned long end, bool lock_vma);
>  
>  struct mmu_notifier_range;
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 785409805ed7..e6c0f999e0cb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -85,14 +85,14 @@ bool __folio_end_writeback(struct folio *folio);
>  void deactivate_file_folio(struct folio *folio);
>  
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> -		unsigned long floor, unsigned long ceiling);
> +		unsigned long floor, unsigned long ceiling, bool lock_vma);
>  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
>  
>  struct zap_details;
>  void unmap_page_range(struct mmu_gather *tlb,
>  			     struct vm_area_struct *vma,
>  			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details);
> +			     struct zap_details *details, bool lock_vma);
>  
>  void page_cache_ra_order(struct readahead_control *, struct file_ra_state *,
>  		unsigned int order);
> diff --git a/mm/memory.c b/mm/memory.c
> index 4ba73f5aa8bb..9ac9944e8c62 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -403,7 +403,7 @@ void free_pgd_range(struct mmu_gather *tlb,
>  }
>  
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -		unsigned long floor, unsigned long ceiling)
> +		unsigned long floor, unsigned long ceiling, bool lock_vma)
>  {
>  	while (vma) {
>  		struct vm_area_struct *next = vma->vm_next;
> @@ -413,6 +413,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 * Hide vma from rmap and truncate_pagecache before freeing
>  		 * pgtables
>  		 */
> +		if (lock_vma)
> +			vma_mark_locked(vma);
>  		unlink_anon_vmas(vma);
>  		unlink_file_vma(vma);
>  
> @@ -427,6 +429,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
>  				next = vma->vm_next;
> +				if (lock_vma)
> +					vma_mark_locked(vma);
>  				unlink_anon_vmas(vma);
>  				unlink_file_vma(vma);
>  			}
> @@ -1631,12 +1635,16 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
>  void unmap_page_range(struct mmu_gather *tlb,
>  			     struct vm_area_struct *vma,
>  			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details)
> +			     struct zap_details *details,
> +			     bool lock_vma)
>  {
>  	pgd_t *pgd;
>  	unsigned long next;
>  
>  	BUG_ON(addr >= end);
> +	if (lock_vma)
> +		vma_mark_locked(vma);

I'm wondering if that is really needed here.
The following processing is only dealing with the page table entries.
Today, if that could be called without holding the mmap_lock, that should
be safe to not mark the VMA locked (indeed the VMA itself is not impacted).

Thus unmap_single_vma() below no need to be touched, and its callers.

In the case a locking is required, I think there is a real potential issue
in the current kernel.

> +
>  	tlb_start_vma(tlb, vma);
>  	pgd = pgd_offset(vma->vm_mm, addr);
>  	do {
> @@ -1652,7 +1660,7 @@ void unmap_page_range(struct mmu_gather *tlb,
>  static void unmap_single_vma(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long start_addr,
>  		unsigned long end_addr,
> -		struct zap_details *details)
> +		struct zap_details *details, bool lock_vma)
>  {
>  	unsigned long start = max(vma->vm_start, start_addr);
>  	unsigned long end;
> @@ -1691,7 +1699,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  				i_mmap_unlock_write(vma->vm_file->f_mapping);
>  			}
>  		} else
> -			unmap_page_range(tlb, vma, start, end, details);
> +			unmap_page_range(tlb, vma, start, end, details, lock_vma);
>  	}
>  }
>  
> @@ -1715,7 +1723,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>   */
>  void unmap_vmas(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long start_addr,
> -		unsigned long end_addr)
> +		unsigned long end_addr, bool lock_vma)
>  {
>  	struct mmu_notifier_range range;
>  	struct zap_details details = {
> @@ -1728,7 +1736,8 @@ void unmap_vmas(struct mmu_gather *tlb,
>  				start_addr, end_addr);
>  	mmu_notifier_invalidate_range_start(&range);
>  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> -		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
> +		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
> +				 lock_vma);
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> @@ -1753,7 +1762,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>  	update_hiwater_rss(vma->vm_mm);
>  	mmu_notifier_invalidate_range_start(&range);
>  	for ( ; vma && vma->vm_start < range.end; vma = vma->vm_next)
> -		unmap_single_vma(&tlb, vma, start, range.end, NULL);
> +		unmap_single_vma(&tlb, vma, start, range.end, NULL, false);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  }
> @@ -1768,7 +1777,7 @@ void zap_page_range(struct vm_area_struct *vma, unsigned long start,
>   * The range must fit into one VMA.
>   */
>  static void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> -		unsigned long size, struct zap_details *details)
> +		unsigned long size, struct zap_details *details, bool lock_vma)
>  {
>  	struct mmu_notifier_range range;
>  	struct mmu_gather tlb;
> @@ -1779,7 +1788,7 @@ static void zap_page_range_single(struct vm_area_struct *vma, unsigned long addr
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	update_hiwater_rss(vma->vm_mm);
>  	mmu_notifier_invalidate_range_start(&range);
> -	unmap_single_vma(&tlb, vma, address, range.end, details);
> +	unmap_single_vma(&tlb, vma, address, range.end, details, lock_vma);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
>  }
> @@ -1802,7 +1811,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  	    		!(vma->vm_flags & VM_PFNMAP))
>  		return;
>  
> -	zap_page_range_single(vma, address, size, NULL);
> +	zap_page_range_single(vma, address, size, NULL, true);
>  }
>  EXPORT_SYMBOL_GPL(zap_vma_ptes);
>  
> @@ -3483,7 +3492,8 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
>  		unsigned long start_addr, unsigned long end_addr,
>  		struct zap_details *details)
>  {
> -	zap_page_range_single(vma, start_addr, end_addr - start_addr, details);
> +	zap_page_range_single(vma, start_addr, end_addr - start_addr, details,
> +			      false);
>  }
>  
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 121544fd90de..094678b4434b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -79,7 +79,7 @@ core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
>  
>  static void unmap_region(struct mm_struct *mm,
>  		struct vm_area_struct *vma, struct vm_area_struct *prev,
> -		unsigned long start, unsigned long end);
> +		unsigned long start, unsigned long end, bool lock_vma);
>  
>  static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
>  {
> @@ -1866,7 +1866,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vma->vm_file = NULL;
>  
>  	/* Undo any partial mapping done by a device driver. */
> -	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
> +	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end, true);
>  	if (vm_flags & VM_SHARED)
>  		mapping_unmap_writable(file->f_mapping);
>  free_vma: 
> @@ -2626,7 +2626,7 @@ static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *vma)
>   */
>  static void unmap_region(struct mm_struct *mm,
>  		struct vm_area_struct *vma, struct vm_area_struct *prev,
> -		unsigned long start, unsigned long end)
> +		unsigned long start, unsigned long end, bool lock_vma)
>  {
>  	struct vm_area_struct *next = vma_next(mm, prev);
>  	struct mmu_gather tlb;
> @@ -2634,9 +2634,10 @@ static void unmap_region(struct mm_struct *mm,
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
>  	update_hiwater_rss(mm);
> -	unmap_vmas(&tlb, vma, start, end);
> +	unmap_vmas(&tlb, vma, start, end, lock_vma);
>  	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
> -				 next ? next->vm_start : USER_PGTABLES_CEILING);
> +				 next ? next->vm_start : USER_PGTABLES_CEILING,
> +				 lock_vma);
>  	tlb_finish_mmu(&tlb);
>  }
>  
> @@ -2849,7 +2850,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	if (downgrade)
>  		mmap_write_downgrade(mm);
>  
> -	unmap_region(mm, vma, prev, start, end);
> +	unmap_region(mm, vma, prev, start, end, !downgrade);
>  
>  	/* Fix up all other VM information */
>  	remove_vma_list(mm, vma);
> @@ -3129,8 +3130,8 @@ void exit_mmap(struct mm_struct *mm)
>  	tlb_gather_mmu_fullmm(&tlb, mm);
>  	/* update_hiwater_rss(mm) here? but nobody should be looking */
>  	/* Use -1 here to ensure all VMAs in the mm are unmapped */
> -	unmap_vmas(&tlb, vma, 0, -1);
> -	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> +	unmap_vmas(&tlb, vma, 0, -1, true);
> +	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING, true);
>  	tlb_finish_mmu(&tlb);
>  
>  	/* Walk the list again, actually closing and freeing it. */
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 3c6cf9e3cd66..6ffa7c511aa3 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -549,7 +549,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
>  				ret = false;
>  				continue;
>  			}
> -			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> +			unmap_page_range(&tlb, vma, range.start, range.end,
> +					 NULL, false);
>  			mmu_notifier_invalidate_range_end(&range);
>  			tlb_finish_mmu(&tlb);
>  		}

I'm wondering if the VMA locking should be done here instead of inside
unmap_page_range() which is not really touching the VMA's fields.

Here this would be needed because the page fault handler may check the
MMF_UNSTABLE flag and the VMA's locking before this loop is entered by
another thread.

