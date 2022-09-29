Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F125EED93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiI2GJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2GI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:08:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D111162CA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:08:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MdNC7472LzpVPB;
        Thu, 29 Sep 2022 14:05:55 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 14:08:51 +0800
Subject: Re: [PATCH v2 8/9] hugetlb: use new vma_lock for pmd sharing
 synchronization
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220914221810.95771-1-mike.kravetz@oracle.com>
 <20220914221810.95771-9-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <01f10195-7088-4462-6def-909549c75ef4@huawei.com>
Date:   Thu, 29 Sep 2022 14:08:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220914221810.95771-9-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 6:18, Mike Kravetz wrote:
> The new hugetlb vma lock is used to address this race:
> 
> Faulting thread                                 Unsharing thread
> ...                                                  ...
> ptep = huge_pte_offset()
>       or
> ptep = huge_pte_alloc()
> ...
>                                                 i_mmap_lock_write
>                                                 lock page table
> ptep invalid   <------------------------        huge_pmd_unshare()
> Could be in a previously                        unlock_page_table
> sharing process or worse                        i_mmap_unlock_write
> ...
> 
> The vma_lock is used as follows:
> - During fault processing. The lock is acquired in read mode before
>   doing a page table lock and allocation (huge_pte_alloc).  The lock is
>   held until code is finished with the page table entry (ptep).
> - The lock must be held in write mode whenever huge_pmd_unshare is
>   called.
> 
> Lock ordering issues come into play when unmapping a page from all
> vmas mapping the page.  The i_mmap_rwsem must be held to search for the
> vmas, and the vma lock must be held before calling unmap which will
> call huge_pmd_unshare.  This is done today in:
> - try_to_migrate_one and try_to_unmap_ for page migration and memory
>   error handling.  In these routines we 'try' to obtain the vma lock and
>   fail to unmap if unsuccessful.  Calling routines already deal with the
>   failure of unmapping.
> - hugetlb_vmdelete_list for truncation and hole punch.  This routine
>   also tries to acquire the vma lock.  If it fails, it skips the
>   unmapping.  However, we can not have file truncation or hole punch
>   fail because of contention.  After hugetlb_vmdelete_list, truncation
>   and hole punch call remove_inode_hugepages.  remove_inode_hugepages
>   checks for mapped pages and call hugetlb_unmap_file_page to unmap them.
>   hugetlb_unmap_file_page is designed to drop locks and reacquire in the
>   correct order to guarantee unmap success.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c |  66 +++++++++++++++++++++++++++-
>  mm/hugetlb.c         | 102 +++++++++++++++++++++++++++++++++++++++----
>  mm/memory.c          |   2 +
>  mm/rmap.c            | 100 +++++++++++++++++++++++++++---------------
>  mm/userfaultfd.c     |   9 +++-
>  5 files changed, 233 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 3bb1772fce2f..009ae539b9b2 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -434,6 +434,7 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  					struct folio *folio, pgoff_t index)
>  {
>  	struct rb_root_cached *root = &mapping->i_mmap;
> +	struct hugetlb_vma_lock *vma_lock;
>  	struct page *page = &folio->page;
>  	struct vm_area_struct *vma;
>  	unsigned long v_start;
> @@ -444,7 +445,8 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  	end = (index + 1) * pages_per_huge_page(h);
>  
>  	i_mmap_lock_write(mapping);
> -
> +retry:
> +	vma_lock = NULL;
>  	vma_interval_tree_foreach(vma, root, start, end - 1) {
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
> @@ -452,11 +454,63 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
>  		if (!hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
>  			continue;
>  
> +		if (!hugetlb_vma_trylock_write(vma)) {
> +			vma_lock = vma->vm_private_data;
> +			/*
> +			 * If we can not get vma lock, we need to drop
> +			 * immap_sema and take locks in order.  First,
> +			 * take a ref on the vma_lock structure so that
> +			 * we can be guaranteed it will not go away when
> +			 * dropping immap_sema.
> +			 */
> +			kref_get(&vma_lock->refs);
> +			break;
> +		}
> +
>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>  				NULL, ZAP_FLAG_DROP_MARKER);
> +		hugetlb_vma_unlock_write(vma);
>  	}
>  
>  	i_mmap_unlock_write(mapping);
> +
> +	if (vma_lock) {
> +		/*
> +		 * Wait on vma_lock.  We know it is still valid as we have
> +		 * a reference.  We must 'open code' vma locking as we do
> +		 * not know if vma_lock is still attached to vma.
> +		 */
> +		down_write(&vma_lock->rw_sema);
> +		i_mmap_lock_write(mapping);
> +
> +		vma = vma_lock->vma;
> +		if (!vma) {

Thanks Mike. This method looks much simpler. But IIUC, this code can race with exit_mmap:

CPU 1					CPU 2
hugetlb_unmap_file_folio		exit_mmap
  kref_get(&vma_lock->refs);
  down_write(&vma_lock->rw_sema);
					  free_pgtables // i_mmap_lock_write is held inside it.
  i_mmap_lock_write(mapping);
  vma = vma_lock->vma;
					  remove_vma
					    hugetlb_vm_op_close
					      hugetlb_vma_lock_free
					        vma_lock->vma = NULL;
					    vm_area_free(vma);
  vma is used-after-free??

The root casue is free_pgtables is protected with i_mmap_lock_write while remove_vma is not.
Or am I miss something again? ;)

> +			/*
> +			 * If lock is no longer attached to vma, then just
> +			 * unlock, drop our reference and retry looking for
> +			 * other vmas.
> +			 */
> +			up_write(&vma_lock->rw_sema);
> +			kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
> +			goto retry;
> +		}
> +
> +		/*
> +		 * vma_lock is still attached to vma.  Check to see if vma
> +		 * still maps page and if so, unmap.
> +		 */
> +		v_start = vma_offset_start(vma, start);
> +		v_end = vma_offset_end(vma, end);
> +		if (hugetlb_vma_maps_page(vma, vma->vm_start + v_start, page))
> +			unmap_hugepage_range(vma, vma->vm_start + v_start,
> +						v_end, NULL,
> +						ZAP_FLAG_DROP_MARKER);
> +
> +		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
> +		hugetlb_vma_unlock_write(vma);
> +
> +		goto retry;
> +	}
>  }
>  
>  static void
> @@ -474,11 +528,21 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
>  		unsigned long v_start;
>  		unsigned long v_end;
>  
> +		if (!hugetlb_vma_trylock_write(vma))
> +			continue;
> +
>  		v_start = vma_offset_start(vma, start);
>  		v_end = vma_offset_end(vma, end);
>  
>  		unmap_hugepage_range(vma, vma->vm_start + v_start, v_end,
>  				     NULL, zap_flags);
> +
> +		/*
> +		 * Note that vma lock only exists for shared/non-private
> +		 * vmas.  Therefore, lock is not held when calling
> +		 * unmap_hugepage_range for private vmas.
> +		 */
> +		hugetlb_vma_unlock_write(vma);
>  	}
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 616be891b798..e8cbc0f7cdaa 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4795,6 +4795,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		mmu_notifier_invalidate_range_start(&range);
>  		mmap_assert_write_locked(src);
>  		raw_write_seqcount_begin(&src->write_protect_seq);
> +	} else {
> +		/*
> +		 * For shared mappings the vma lock must be held before
> +		 * calling huge_pte_offset in the src vma. Otherwise, the
> +		 * returned ptep could go away if part of a shared pmd and
> +		 * another thread calls huge_pmd_unshare.
> +		 */
> +		hugetlb_vma_lock_read(src_vma);
>  	}
>  
>  	last_addr_mask = hugetlb_mask_last_page(h);
> @@ -4941,6 +4949,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  	if (cow) {
>  		raw_write_seqcount_end(&src->write_protect_seq);
>  		mmu_notifier_invalidate_range_end(&range);
> +	} else {
> +		hugetlb_vma_unlock_read(src_vma);
>  	}
>  
>  	return ret;
> @@ -4999,6 +5009,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	mmu_notifier_invalidate_range_start(&range);
>  	last_addr_mask = hugetlb_mask_last_page(h);
>  	/* Prevent race with file truncation */
> +	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(mapping);
>  	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
>  		src_pte = huge_pte_offset(mm, old_addr, sz);
> @@ -5030,6 +5041,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  		flush_tlb_range(vma, old_end - len, old_end);
>  	mmu_notifier_invalidate_range_end(&range);
>  	i_mmap_unlock_write(mapping);
> +	hugetlb_vma_unlock_write(vma);
>  
>  	return len + old_addr - old_end;
>  }
> @@ -5349,8 +5361,29 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  		 * may get SIGKILLed if it later faults.
>  		 */
>  		if (outside_reserve) {
> +			struct address_space *mapping = vma->vm_file->f_mapping;
> +			pgoff_t idx;
> +			u32 hash;
> +
>  			put_page(old_page);
> +			/*
> +			 * Drop hugetlb_fault_mutex and vma_lock before
> +			 * unmapping.  unmapping needs to hold vma_lock
> +			 * in write mode.  Dropping vma_lock in read mode
> +			 * here is OK as COW mappings do not interact with
> +			 * PMD sharing.
> +			 *
> +			 * Reacquire both after unmap operation.
> +			 */
> +			idx = vma_hugecache_offset(h, vma, haddr);
> +			hash = hugetlb_fault_mutex_hash(mapping, idx);
> +			hugetlb_vma_unlock_read(vma);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +
>  			unmap_ref_private(mm, vma, old_page, haddr);
> +
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +			hugetlb_vma_lock_read(vma);
>  			spin_lock(ptl);
>  			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  			if (likely(ptep &&
> @@ -5499,14 +5532,16 @@ static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
>  	};
>  
>  	/*
> -	 * hugetlb_fault_mutex and i_mmap_rwsem must be
> +	 * vma_lock and hugetlb_fault_mutex must be
>  	 * dropped before handling userfault.  Reacquire
>  	 * after handling fault to make calling code simpler.
>  	 */
> +	hugetlb_vma_unlock_read(vma);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  	ret = handle_userfault(&vmf, reason);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +	hugetlb_vma_lock_read(vma);
>  
>  	return ret;
>  }
> @@ -5740,6 +5775,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
>  	if (ptep) {
> +		/*
> +		 * Since we hold no locks, ptep could be stale.  That is
> +		 * OK as we are only making decisions based on content and
> +		 * not actually modifying content here.
> +		 */
>  		entry = huge_ptep_get(ptep);
>  		if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			migration_entry_wait_huge(vma, ptep);
> @@ -5747,23 +5787,35 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	} else {
> -		ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> -		if (!ptep)
> -			return VM_FAULT_OOM;
>  	}
>  
> -	mapping = vma->vm_file->f_mapping;
> -	idx = vma_hugecache_offset(h, vma, haddr);
> -
>  	/*
>  	 * Serialize hugepage allocation and instantiation, so that we don't
>  	 * get spurious allocation failures if two CPUs race to instantiate
>  	 * the same page in the page cache.
>  	 */
> +	mapping = vma->vm_file->f_mapping;
> +	idx = vma_hugecache_offset(h, vma, haddr);
>  	hash = hugetlb_fault_mutex_hash(mapping, idx);
>  	mutex_lock(&hugetlb_fault_mutex_table[hash]);
>  
> +	/*
> +	 * Acquire vma lock before calling huge_pte_alloc and hold
> +	 * until finished with ptep.  This prevents huge_pmd_unshare from
> +	 * being called elsewhere and making the ptep no longer valid.
> +	 *
> +	 * ptep could have already be assigned via huge_pte_offset.  That
> +	 * is OK, as huge_pte_alloc will return the same value unless
> +	 * something has changed.
> +	 */
> +	hugetlb_vma_lock_read(vma);

[1] says vma_lock for each vma mapping the file provides the same type of synchronization
around i_size as provided by the fault mutex. But what if vma->vm_private_data is NULL,
i.e. hugetlb_vma_lock_alloc fails to alloc vma_lock? There won't be such synchronization
in this case.

[1] https://lore.kernel.org/lkml/Yxiv0SkMkZ0JWGGp@monkey/#t


Other parts of the patch look good to me. Thanks for your work.

Thanks,
Miaohe Lin


> +	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
> +	if (!ptep) {
> +		hugetlb_vma_unlock_read(vma);
> +		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +		return VM_FAULT_OOM;
> +	}
> +
>  	entry = huge_ptep_get(ptep);
>  	/* PTE markers should be handled the same way as none pte */
>  	if (huge_pte_none_mostly(entry)) {
> @@ -5824,6 +5876,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unlock_page(pagecache_page);
>  			put_page(pagecache_page);
>  		}
> +		hugetlb_vma_unlock_read(vma);
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  		return handle_userfault(&vmf, VM_UFFD_WP);
>  	}
> @@ -5867,6 +5920,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		put_page(pagecache_page);
>  	}
>  out_mutex:
> +	hugetlb_vma_unlock_read(vma);
>  	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  	/*
>  	 * Generally it's safe to hold refcount during waiting page lock. But
> @@ -6329,8 +6383,9 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  	flush_cache_range(vma, range.start, range.end);
>  
>  	mmu_notifier_invalidate_range_start(&range);
> -	last_addr_mask = hugetlb_mask_last_page(h);
> +	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
> +	last_addr_mask = hugetlb_mask_last_page(h);
>  	for (; address < end; address += psize) {
>  		spinlock_t *ptl;
>  		ptep = huge_pte_offset(mm, address, psize);
> @@ -6429,6 +6484,7 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  	 * See Documentation/mm/mmu_notifier.rst
>  	 */
>  	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	hugetlb_vma_unlock_write(vma);
>  	mmu_notifier_invalidate_range_end(&range);
>  
>  	return pages << h->order;
> @@ -6930,6 +6986,7 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  	pud_t *pud = pud_offset(p4d, addr);
>  
>  	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> +	hugetlb_vma_assert_locked(vma);
>  	BUG_ON(page_count(virt_to_page(ptep)) == 0);
>  	if (page_count(virt_to_page(ptep)) == 1)
>  		return 0;
> @@ -6941,6 +6998,31 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  }
>  
>  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> +void hugetlb_vma_lock_read(struct vm_area_struct *vma)
> +{
> +}
> +
> +void hugetlb_vma_unlock_read(struct vm_area_struct *vma)
> +{
> +}
> +
> +void hugetlb_vma_lock_write(struct vm_area_struct *vma)
> +{
> +}
> +
> +void hugetlb_vma_unlock_write(struct vm_area_struct *vma)
> +{
> +}
> +
> +int hugetlb_vma_trylock_write(struct vm_area_struct *vma)
> +{
> +	return 1;
> +}
> +
> +void hugetlb_vma_assert_locked(struct vm_area_struct *vma)
> +{
> +}
> +
>  static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
>  {
>  }
> @@ -7318,6 +7400,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm,
>  				start, end);
>  	mmu_notifier_invalidate_range_start(&range);
> +	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
>  	for (address = start; address < end; address += PUD_SIZE) {
>  		ptep = huge_pte_offset(mm, address, sz);
> @@ -7329,6 +7412,7 @@ void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
>  	}
>  	flush_hugetlb_tlb_range(vma, start, end);
>  	i_mmap_unlock_write(vma->vm_file->f_mapping);
> +	hugetlb_vma_unlock_write(vma);
>  	/*
>  	 * No need to call mmu_notifier_invalidate_range(), see
>  	 * Documentation/mm/mmu_notifier.rst.
> diff --git a/mm/memory.c b/mm/memory.c
> index c4c3c2fd4f45..118e5f023597 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1685,10 +1685,12 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  			if (vma->vm_file) {
>  				zap_flags_t zap_flags = details ?
>  				    details->zap_flags : 0;
> +				hugetlb_vma_lock_write(vma);
>  				i_mmap_lock_write(vma->vm_file->f_mapping);
>  				__unmap_hugepage_range_final(tlb, vma, start, end,
>  							     NULL, zap_flags);
>  				i_mmap_unlock_write(vma->vm_file->f_mapping);
> +				hugetlb_vma_unlock_write(vma);
>  			}
>  		} else
>  			unmap_page_range(tlb, vma, start, end, details);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 744faaef0489..2ec925e5fa6a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1554,24 +1554,39 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>  			 * held in write mode.  Caller needs to explicitly
>  			 * do this outside rmap routines.
> +			 *
> +			 * We also must hold hugetlb vma_lock in write mode.
> +			 * Lock order dictates acquiring vma_lock BEFORE
> +			 * i_mmap_rwsem.  We can only try lock here and fail
> +			 * if unsuccessful.
>  			 */
> -			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
> -			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> -				flush_tlb_range(vma, range.start, range.end);
> -				mmu_notifier_invalidate_range(mm, range.start,
> -							      range.end);
> -
> -				/*
> -				 * The ref count of the PMD page was dropped
> -				 * which is part of the way map counting
> -				 * is done for shared PMDs.  Return 'true'
> -				 * here.  When there is no other sharing,
> -				 * huge_pmd_unshare returns false and we will
> -				 * unmap the actual page and drop map count
> -				 * to zero.
> -				 */
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +			if (!anon) {
> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +				if (!hugetlb_vma_trylock_write(vma)) {
> +					page_vma_mapped_walk_done(&pvmw);
> +					ret = false;
> +					break;
> +				}
> +				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> +					hugetlb_vma_unlock_write(vma);
> +					flush_tlb_range(vma,
> +						range.start, range.end);
> +					mmu_notifier_invalidate_range(mm,
> +						range.start, range.end);
> +					/*
> +					 * The ref count of the PMD page was
> +					 * dropped which is part of the way map
> +					 * counting is done for shared PMDs.
> +					 * Return 'true' here.  When there is
> +					 * no other sharing, huge_pmd_unshare
> +					 * returns false and we will unmap the
> +					 * actual page and drop map count
> +					 * to zero.
> +					 */
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
> +				hugetlb_vma_unlock_write(vma);
>  			}
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  		} else {
> @@ -1929,26 +1944,41 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>  			 * held in write mode.  Caller needs to explicitly
>  			 * do this outside rmap routines.
> +			 *
> +			 * We also must hold hugetlb vma_lock in write mode.
> +			 * Lock order dictates acquiring vma_lock BEFORE
> +			 * i_mmap_rwsem.  We can only try lock here and
> +			 * fail if unsuccessful.
>  			 */
> -			VM_BUG_ON(!anon && !(flags & TTU_RMAP_LOCKED));
> -			if (!anon && huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> -				flush_tlb_range(vma, range.start, range.end);
> -				mmu_notifier_invalidate_range(mm, range.start,
> -							      range.end);
> -
> -				/*
> -				 * The ref count of the PMD page was dropped
> -				 * which is part of the way map counting
> -				 * is done for shared PMDs.  Return 'true'
> -				 * here.  When there is no other sharing,
> -				 * huge_pmd_unshare returns false and we will
> -				 * unmap the actual page and drop map count
> -				 * to zero.
> -				 */
> -				page_vma_mapped_walk_done(&pvmw);
> -				break;
> +			if (!anon) {
> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> +				if (!hugetlb_vma_trylock_write(vma)) {
> +					page_vma_mapped_walk_done(&pvmw);
> +					ret = false;
> +					break;
> +				}
> +				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> +					hugetlb_vma_unlock_write(vma);
> +					flush_tlb_range(vma,
> +						range.start, range.end);
> +					mmu_notifier_invalidate_range(mm,
> +						range.start, range.end);
> +
> +					/*
> +					 * The ref count of the PMD page was
> +					 * dropped which is part of the way map
> +					 * counting is done for shared PMDs.
> +					 * Return 'true' here.  When there is
> +					 * no other sharing, huge_pmd_unshare
> +					 * returns false and we will unmap the
> +					 * actual page and drop map count
> +					 * to zero.
> +					 */
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
> +				hugetlb_vma_unlock_write(vma);
>  			}
> -
>  			/* Nuke the hugetlb page table entry */
>  			pteval = huge_ptep_clear_flush(vma, address, pvmw.pte);
>  		} else {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 0fdbd2c05587..e24e8a47ce8a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -379,16 +379,21 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		BUG_ON(dst_addr >= dst_start + len);
>  
>  		/*
> -		 * Serialize via hugetlb_fault_mutex.
> +		 * Serialize via vma_lock and hugetlb_fault_mutex.
> +		 * vma_lock ensures the dst_pte remains valid even
> +		 * in the case of shared pmds.  fault mutex prevents
> +		 * races with other faulting threads.
>  		 */
>  		idx = linear_page_index(dst_vma, dst_addr);
>  		mapping = dst_vma->vm_file->f_mapping;
>  		hash = hugetlb_fault_mutex_hash(mapping, idx);
>  		mutex_lock(&hugetlb_fault_mutex_table[hash]);
> +		hugetlb_vma_lock_read(dst_vma);
>  
>  		err = -ENOMEM;
>  		dst_pte = huge_pte_alloc(dst_mm, dst_vma, dst_addr, vma_hpagesize);
>  		if (!dst_pte) {
> +			hugetlb_vma_unlock_read(dst_vma);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			goto out_unlock;
>  		}
> @@ -396,6 +401,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  		if (mode != MCOPY_ATOMIC_CONTINUE &&
>  		    !huge_pte_none_mostly(huge_ptep_get(dst_pte))) {
>  			err = -EEXIST;
> +			hugetlb_vma_unlock_read(dst_vma);
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  			goto out_unlock;
>  		}
> @@ -404,6 +410,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
>  					       dst_addr, src_addr, mode, &page,
>  					       wp_copy);
>  
> +		hugetlb_vma_unlock_read(dst_vma);
>  		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>  
>  		cond_resched();
> 

