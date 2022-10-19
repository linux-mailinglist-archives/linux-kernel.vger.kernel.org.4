Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AFE603B40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiJSIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiJSIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:16:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796E631E8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:16:49 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Msk3R1K8dzmV8q;
        Wed, 19 Oct 2022 16:12:03 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 16:16:46 +0800
Subject: Re: [PATCH] hugetlb: fix memory leak associated with vma_lock
 structure
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
References: <20221018233601.282381-1-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <15890189-c3ba-4249-3c2f-674f6763415b@huawei.com>
Date:   Wed, 19 Oct 2022 16:16:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221018233601.282381-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/19 7:36, Mike Kravetz wrote:
> The hugetlb vma_lock structure hangs off the vm_private_data pointer
> of sharable hugetlb vmas.  The structure is vma specific and can not
> be shared between vmas.  At fork and various other times, vmas are
> duplicated via vm_area_dup().  When this happens, the pointer in the
> newly created vma must be cleared and the structure reallocated.  Two
> hugetlb specific routines deal with this hugetlb_dup_vma_private and
> hugetlb_vm_op_open.  Both routines are called for newly created vmas.
> hugetlb_dup_vma_private would always clear the pointer and
> hugetlb_vm_op_open would allocate the new vms_lock structure.  This did
> not work in the case of this calling sequence pointed out in [1].
>   move_vma
>     copy_vma
>       new_vma = vm_area_dup(vma);
>       new_vma->vm_ops->open(new_vma); --> new_vma has its own vma lock.
>     is_vm_hugetlb_page(vma)
>       clear_vma_resv_huge_pages
>         hugetlb_dup_vma_private --> vma->vm_private_data is set to NULL
> When clearing hugetlb_dup_vma_private we actually leak the associated
> vma_lock structure.
> 
> The vma_lock structure contains a pointer to the associated vma.  This
> information can be used in hugetlb_dup_vma_private and hugetlb_vm_op_open
> to ensure we only clear the vm_private_data of newly created (copied)
> vmas.  In such cases, the vma->vma_lock->vma field will not point to the
> vma.
> 
> Update hugetlb_dup_vma_private and hugetlb_vm_op_open to not clear
> vm_private_data if vma->vma_lock->vma == vma.  Also, log a warning if
> hugetlb_vm_op_open ever encounters the case where vma_lock has already
> been correctly allocated for the vma.
> 
> [1] https://lore.kernel.org/linux-mm/5154292a-4c55-28cd-0935-82441e512fc3@huawei.com/
> 
> Fixes: 131a79b474e9 ("hugetlb: fix vma lock handling during split vma and range unmapping")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 02f781624fce..7f74cbff6619 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1014,15 +1014,23 @@ void hugetlb_dup_vma_private(struct vm_area_struct *vma)
>  	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
>  	/*
>  	 * Clear vm_private_data
> +	 * - For shared mappings this is a per-vma semaphore that may be
> +	 *   allocated in a subsequent call to hugetlb_vm_op_open.
> +	 *   Before clearing, make sure pointer is not associated with vma
> +	 *   as this will leak the structure.  This is the case when called
> +	 *   via clear_vma_resv_huge_pages() and hugetlb_vm_op_open has already
> +	 *   been called to allocate a new structure.
>  	 * - For MAP_PRIVATE mappings, this is the reserve map which does
>  	 *   not apply to children.  Faults generated by the children are
>  	 *   not guaranteed to succeed, even if read-only.
> -	 * - For shared mappings this is a per-vma semaphore that may be
> -	 *   allocated in a subsequent call to hugetlb_vm_op_open.
>  	 */
> -	vma->vm_private_data = (void *)0;
> -	if (!(vma->vm_flags & VM_MAYSHARE))
> -		return;
> +	if (vma->vm_flags & VM_MAYSHARE) {
> +		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> +
> +		if (vma_lock && vma_lock->vma != vma)
> +			vma->vm_private_data = NULL;
> +	} else
> +		vma->vm_private_data = NULL;
>  }
>  
>  /*
> @@ -4601,6 +4609,7 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
>  	struct resv_map *resv = vma_resv_map(vma);
>  
>  	/*
> +	 * HPAGE_RESV_OWNER indicates a private mapping.
>  	 * This new VMA should share its siblings reservation map if present.
>  	 * The VMA will only ever have a valid reservation map pointer where
>  	 * it is being copied for another still existing VMA.  As that VMA
> @@ -4616,10 +4625,18 @@ static void hugetlb_vm_op_open(struct vm_area_struct *vma)
>  	/*
>  	 * vma_lock structure for sharable mappings is vma specific.
>  	 * Clear old pointer (if copied via vm_area_dup) and create new.
> +	 * Before clearing, make sure vma_lock is not for this vma.
>  	 */
>  	if (vma->vm_flags & VM_MAYSHARE) {
> -		vma->vm_private_data = NULL;
> -		hugetlb_vma_lock_alloc(vma);
> +		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
> +
> +		if (vma_lock) {

Thanks Mike. It seems the case of "vma_lock == NULL" is missed, i.e. if vma->vm_private_data == NULL,
hugetlb_vm_op_open won't allocate a new vma lock?

Others look good to me.

Thanks,
Miaohe Lin

> +			if (vma_lock->vma != vma) {
> +				vma->vm_private_data = NULL;
> +				hugetlb_vma_lock_alloc(vma);
> +			} else
> +				pr_warn("HugeTLB: vma_lock already exists in %s.\n", __func__);
> +		}
>  	}
>  }
>  
> 

