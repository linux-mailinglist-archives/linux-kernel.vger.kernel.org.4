Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9396AF3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjCGTL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjCGTKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54EC859E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:22 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327GxAfo008035;
        Tue, 7 Mar 2023 18:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3Z5dDbIduLA+/aj1o4mQqPaaKR/Wtg/+4IlbJuzSaN0=;
 b=pnn0Q/iisNbPaNUZtwu2TjP1uBmKDNDkkBzG2NqpL6T9VMBeuSsCSlHrrGpDk6XhUS6Y
 tP5x/p3Elrc6Th7kRCUYNCVPzeEp9FhYAgm7bklIKaPdcYBz5O0/quiY7MXvvhXJuAFk
 2ByMeO+7xM+PnX2z1VXuX3geEguuitecI3jfv+pb+yNaw8KlqQ0x23Jv3ndxV9tGU3Y3
 WlSxLYaZjecwuiSMCIEdYWR4uj8AuZHlW0DL+aeBY6v5VSEd6RYAvvMJxLsI5V4B4TNv
 sXLczBdHQY9cBHiIvxob+JbRuZq7WTYqJAvIAfDRUrISO/ImNIIfSAWTu9cyOBtbzplj OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p666r910v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:27 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327Iol2n027164;
        Tue, 7 Mar 2023 18:54:26 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p666r9105-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327ExbtF005192;
        Tue, 7 Mar 2023 18:54:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brcpyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsMtv23921252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1115320043;
        Tue,  7 Mar 2023 18:54:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A33220040;
        Tue,  7 Mar 2023 18:54:21 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:21 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:43:20 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 2/6] ksm: support unsharing zero pages placed by KSM
Message-ID: <20230307194320.79373a26@p-imbrenda>
In-Reply-To: <202302100917515661425@zte.com.cn>
References: <202302100917515661425@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zw7ebjBQ9_wh6zM_7vITwjlFs0iAghop
X-Proofpoint-GUID: RpD2JunyuOwO-IctyK3fAAs5gJvORyrp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_14,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=894
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:17:51 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> use_zero_pages may be very useful, not just because of cache colouring
> as described in doc, but also because use_zero_pages can accelerate
> merging empty pages when there are plenty of empty pages (full of zeros)
> as the time of page-by-page comparisons (unstable_tree_search_insert) is
> saved.
> 
> But when enabling use_zero_pages, madvise(addr, len, MADV_UNMERGEABLE) and
> other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger unsharing
> will *not* actually unshare the shared zeropage as placed by KSM (which is
> against the MADV_UNMERGEABLE documentation). As these KSM-placed zero pages
> are out of the control of KSM, the related counts of ksm pages don't expose
> how many zero pages are placed by KSM (these special zero pages are different
> from those initially mapped zero pages, because the zero pages mapped to
> MADV_UNMERGEABLE areas are expected to be a complete and unshared page)
> 
> To not blindly unshare all shared zero_pages in applicable VMAs, the patch
> introduces a dedicated flag ZERO_PAGE_FLAG to mark the rmap_items of those
> shared zero_pages. and guarantee that these rmap_items will be not freed
> during the time of zero_pages not being writing, so we can only unshare
> the *KSM-placed* zero_pages.
> 
> The patch will not degrade the performance of use_zero_pages as it doesn't
> change the way of merging empty pages in use_zero_pages's feature.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reported-by: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  mm/ksm.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 111 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 905a79d213da..ab04b44679c8 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -214,6 +214,7 @@ struct ksm_rmap_item {
>  #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>  #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
>  #define STABLE_FLAG	0x200	/* is listed from the stable tree */
> +#define ZERO_PAGE_FLAG 0x400 /* is zero page placed by KSM */
> 
>  /* The stable and unstable tree heads */
>  static struct rb_root one_stable_tree[1] = { RB_ROOT };
> @@ -420,6 +421,11 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>  	return atomic_read(&mm->mm_users) == 0;
>  }
> 
> +enum break_ksm_pmd_entry_return_flag {

what about 0 ? I think it would look cleaner if every possible value
was explicitly listed here

> +	HAVE_KSM_PAGE = 1,
> +	HAVE_ZERO_PAGE
> +};
> +
>  static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>  			struct mm_walk *walk)
>  {
> @@ -427,6 +433,7 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>  	spinlock_t *ptl;
>  	pte_t *pte;
>  	int ret;
> +	bool is_zero_page = false;

this ^ should probably be moved further up in the list of variables
(i.e. reverse christmas tree)

> 
>  	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
>  		return 0;
> @@ -434,6 +441,8 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>  	if (pte_present(*pte)) {
>  		page = vm_normal_page(walk->vma, addr, *pte);
> +		if (!page)
> +			is_zero_page = is_zero_pfn(pte_pfn(*pte));
>  	} else if (!pte_none(*pte)) {
>  		swp_entry_t entry = pte_to_swp_entry(*pte);
> 
> @@ -444,7 +453,14 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>  		if (is_migration_entry(entry))
>  			page = pfn_swap_entry_to_page(entry);
>  	}
> -	ret = page && PageKsm(page);
> +
> +	if (page && PageKsm(page))
> +		ret = HAVE_KSM_PAGE;
> +	else if (is_zero_page)
> +		ret = HAVE_ZERO_PAGE;
> +	else
> +		ret = 0;

and here it would be a great place to use the enum instead of
hardcoding 0

> +
>  	pte_unmap_unlock(pte, ptl);
>  	return ret;
>  }
> @@ -466,19 +482,22 @@ static const struct mm_walk_ops break_ksm_ops = {
>   * of the process that owns 'vma'.  We also do not want to enforce
>   * protection keys here anyway.

please add a (short) explanation of when and why the new
unshare_zero_page flag should be used.

>   */
> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> +				     bool unshare_zero_page)
>  {
>  	vm_fault_t ret = 0;
> 
>  	do {
> -		int ksm_page;
> +		int walk_result;
> 
>  		cond_resched();
> -		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
> +		walk_result = walk_page_range_vma(vma, addr, addr + 1,
>  					       &break_ksm_ops, NULL);
> -		if (WARN_ON_ONCE(ksm_page < 0))
> -			return ksm_page;
> -		if (!ksm_page)
> +		if (WARN_ON_ONCE(walk_result < 0))
> +			return walk_result;
> +		if (!walk_result)

if (walk_result == ...)

> +			return 0;
> +		if (walk_result == HAVE_ZERO_PAGE && !unshare_zero_page)
>  			return 0;
>  		ret = handle_mm_fault(vma, addr,
>  				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
> @@ -539,7 +558,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
>  	mmap_read_lock(mm);
>  	vma = find_mergeable_vma(mm, addr);
>  	if (vma)
> -		break_ksm(vma, addr);
> +		break_ksm(vma, addr, false);
>  	mmap_read_unlock(mm);
>  }
> 
> @@ -764,6 +783,30 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>  	return NULL;
>  }
> 
> +/*
> + * Cleaning the rmap_item's ZERO_PAGE_FLAG

this is not what you are doing, though. in case new flags are added,
this function will cause problems.

> + * This function will be called when unshare or writing on zero pages.
> + */
> +static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
> +{
> +	if (rmap_item->address & ZERO_PAGE_FLAG)
> +		rmap_item->address &= PAGE_MASK;

	... &= ~ZERO_PAGE_FLAG;

this way you only clear the flag, and you won't interfere with
potential new flags that might be introduced in the future. (I
really hope we won't need new flags in the future because the code is
already complex enough as it is, but you never know)

> +}
> +
> +/* Only called when rmap_item is going to be freed */
> +static inline void unshare_zero_pages(struct ksm_rmap_item *rmap_item)
> +{
> +	struct vm_area_struct *vma;
> +
> +	if (rmap_item->address & ZERO_PAGE_FLAG) {
> +		vma = vma_lookup(rmap_item->mm, rmap_item->address);
> +		if (vma && !ksm_test_exit(rmap_item->mm))
> +			break_ksm(vma, rmap_item->address, true);
> +	}
> +	/* Put at last. */
> +	clean_rmap_item_zero_flag(rmap_item);
> +}
> +
>  /*
>   * Removing rmap_item from stable or unstable tree.
>   * This function will clean the information from the stable/unstable tree.
> @@ -824,6 +867,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
>  		struct ksm_rmap_item *rmap_item = *rmap_list;
>  		*rmap_list = rmap_item->rmap_list;
>  		remove_rmap_item_from_tree(rmap_item);
> +		unshare_zero_pages(rmap_item);
>  		free_rmap_item(rmap_item);
>  	}
>  }
> @@ -853,7 +897,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
>  		if (signal_pending(current))
>  			err = -ERESTARTSYS;
>  		else
> -			err = break_ksm(vma, addr);
> +			err = break_ksm(vma, addr, false);
>  	}
>  	return err;
>  }
> @@ -2044,6 +2088,39 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
>  	rmap_item->mm->ksm_merging_pages++;
>  }
> 
> +static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
> +									struct page *page)

this line is less than 100 columns, please don't break it ^

> +{
> +	struct mm_struct *mm = rmap_item->mm;
> +	int err = 0;
> +
> +	/*
> +	 * It should not take ZERO_PAGE_FLAG because on one hand,
> +	 * get_next_rmap_item don't return zero pages' rmap_item.
> +	 * On the other hand, even if zero page was writen as
> +	 * anonymous page, rmap_item has been cleaned after
> +	 * stable_tree_search
> +	 */
> +	if (!WARN_ON_ONCE(rmap_item->address & ZERO_PAGE_FLAG)) {
> +		struct vm_area_struct *vma;
> +
> +		mmap_read_lock(mm);
> +		vma = find_mergeable_vma(mm, rmap_item->address);
> +		if (vma) {
> +			err = try_to_merge_one_page(vma, page,
> +						ZERO_PAGE(rmap_item->address));

this line is also less than 100 columns, please don't break it ^

> +			if (!err)
> +				rmap_item->address |= ZERO_PAGE_FLAG;
> +		} else {
> +			/* If the vma is out of date, we do not need to continue. */
> +			err = 0;
> +		}
> +		mmap_read_unlock(mm);
> +	}
> +
> +	return err;
> +}
> +
>  /*
>   * cmp_and_merge_page - first see if page can be merged into the stable tree;
>   * if not, compare checksum to previous and if it's the same, see if page can
> @@ -2055,7 +2132,6 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
>   */
>  static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
>  {
> -	struct mm_struct *mm = rmap_item->mm;
>  	struct ksm_rmap_item *tree_rmap_item;
>  	struct page *tree_page = NULL;
>  	struct ksm_stable_node *stable_node;
> @@ -2092,6 +2168,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>  	}
> 
>  	remove_rmap_item_from_tree(rmap_item);
> +	clean_rmap_item_zero_flag(rmap_item);
> 
>  	if (kpage) {
>  		if (PTR_ERR(kpage) == -EBUSY)
> @@ -2128,29 +2205,16 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>  	 * Same checksum as an empty page. We attempt to merge it with the
>  	 * appropriate zero page if the user enabled this via sysfs.
>  	 */
> -	if (ksm_use_zero_pages && (checksum == zero_checksum)) {

(like here, see comment below)

> -		struct vm_area_struct *vma;
> -
> -		mmap_read_lock(mm);
> -		vma = find_mergeable_vma(mm, rmap_item->address);
> -		if (vma) {
> -			err = try_to_merge_one_page(vma, page,
> -					ZERO_PAGE(rmap_item->address));
> -		} else {
> +	if (ksm_use_zero_pages) {
> +		if (checksum == zero_checksum)

if I see correctly, you end up with three ifs nested? why not just one
if with all the conditions?

>  			/*
> -			 * If the vma is out of date, we do not need to
> -			 * continue.
> +			 * In case of failure, the page was not really empty, so we
> +			 * need to continue. Otherwise we're done.
>  			 */
> -			err = 0;
> -		}
> -		mmap_read_unlock(mm);
> -		/*
> -		 * In case of failure, the page was not really empty, so we
> -		 * need to continue. Otherwise we're done.
> -		 */
> -		if (!err)
> -			return;
> +			if (!try_to_merge_with_kernel_zero_page(rmap_item, page))
> +				return;
>  	}
> +
>  	tree_rmap_item =
>  		unstable_tree_search_insert(rmap_item, page, &tree_page);
>  	if (tree_rmap_item) {
> @@ -2230,6 +2294,7 @@ static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
>  		 * is ineligible or discarded, e.g. MADV_DONTNEED.
>  		 */
>  		remove_rmap_item_from_tree(rmap_item);
> +		unshare_zero_pages(rmap_item);
>  		free_rmap_item(rmap_item);
>  	}
> 
> @@ -2352,6 +2417,22 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  			}
>  			if (is_zone_device_page(*page))
>  				goto next_page;
> +			if (is_zero_pfn(page_to_pfn(*page))) {
> +				/*
> +				 * To monitor ksm zero pages which becomes non-anonymous,
> +				 * we have to save each rmap_item of zero pages by
> +				 * try_to_get_old_rmap_item() walking on
> +				 * ksm_scan.rmap_list, otherwise their rmap_items will be
> +				 * freed by the next turn of get_next_rmap_item(). The
> +				 * function get_next_rmap_item() will free all "skipped"
> +				 * rmap_items because it thinks its areas as UNMERGEABLE.
> +				 */
> +				rmap_item = try_to_get_old_rmap_item(ksm_scan.address,
> +									ksm_scan.rmap_list);
> +				if (rmap_item && (rmap_item->address & ZERO_PAGE_FLAG))
> +					ksm_scan.rmap_list = &rmap_item->rmap_list;
> +				goto next_page;
> +			}
>  			if (PageAnon(*page)) {
>  				flush_anon_page(vma, *page, ksm_scan.address);
>  				flush_dcache_page(*page);

