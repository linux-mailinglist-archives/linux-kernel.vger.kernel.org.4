Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130F6B584E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 06:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjCKFD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 00:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCKFDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 00:03:53 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37851E41F2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:03:51 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id q65-20020a17090a17c700b0023b3ad9572cso241144pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 21:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678511030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK5W9ZhDjihJ8TT9WyqtzPD/lkHpFmR7ZGzmna9WvI0=;
        b=B1+vTbitL7/WawfkCALXmwNLqu/QpXLSc1beidIBWqF/mibZhkztq1VR3AIjZT9seM
         VWwARnS8Ig0mbayomXR7qImTtB0UROiBcCnuDoxDZcXMXoUihIbqPje4b5oAgaRFCbZB
         Bvwc8MZtKUAZar/Bz5r6/cRdMyJWl5Rm8hrWWL9y0pgVUnFFAn8DHxkfHlzDrS2r0x3O
         zeXvDLsmId5o7QbkdXC3mR/l2Jh/QJjx6YXc3ItQ0Z0wm8BIzXcA2P+QD10mzND9L2Vl
         1OWdUUWzPh6QRnecubeE8KuecPPDS6m5LJD/n5e7GDzyeQ8G9QjTemxGyUKzc0Wmtze5
         do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678511030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK5W9ZhDjihJ8TT9WyqtzPD/lkHpFmR7ZGzmna9WvI0=;
        b=fK5OhNO3pSD+zBLrPlrM6H5DHxYCfY9BN06AG1KC15xBMr0J/oUMHMMK6ENe8Lyxt8
         jb07Q0F4OxLZPIzdq65z5ZEr8m7dXHEGw1IfqL7lrVj/DZmLgm27sP7YzS0yUW9a+pzy
         sLUXg2zTM2Db5ktkdjIQEpRvtK56lcq8iC+l4HfzQcpqDDGuPuyAGVBxc7KyXj2idPjj
         PuvmIjahC+lcP9js2z10kHkucJ9AS785asFPN545qv0tT0MxRwYVrF8VI6XvmghjkZNX
         YnCFFwekF8L8TSNGYFORBERk2aDublC/ZjqdC6csNC/9KZlD+J7E09klxOGJpyh9fupo
         LqjQ==
X-Gm-Message-State: AO0yUKWQ3YZ/a8MDuvhSqEra7FVQA/spQ6jiC9bw+8AqEcqwQtKGV80g
        dBhnlW8gV2bS6O1C/cUVEEimcXJGi8ej8A==
X-Google-Smtp-Source: AK7set/1z6bKYCpZLj4Nt57PGbu0/KYNtFWMcx1RvPf1okfDf0Uu8WEKCXdw98FhtqpnzaYm4dXTeA==
X-Received: by 2002:a17:902:e844:b0:19a:7d0e:ceea with SMTP id t4-20020a170902e84400b0019a7d0eceeamr4463280plg.25.1678511030546;
        Fri, 10 Mar 2023 21:03:50 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id kh15-20020a170903064f00b0019a6cce2060sm798305plb.57.2023.03.10.21.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 21:03:50 -0800 (PST)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     imbrenda@linux.ibm.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v6 2/6] ksm: support unsharing zero pages placed by KSM
Date:   Sat, 11 Mar 2023 05:03:46 +0000
Message-Id: <20230311050346.178365-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307194320.79373a26@p-imbrenda>
References: <20230307194320.79373a26@p-imbrenda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think your suggestions as follows are valuable. I will make adjustments according to the actual
situation.

Since patch series v6 have been merged into next branch, I think submitting a new patch is better
to reduce maintainers' workload.

>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
>> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
>> ---
>>  mm/ksm.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 111 insertions(+), 30 deletions(-)
>> 
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 905a79d213da..ab04b44679c8 100644

>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -214,6 +214,7 @@ struct ksm_rmap_item {
>>  #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>>  #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
>>  #define STABLE_FLAG	0x200	/* is listed from the stable tree */
>> +#define ZERO_PAGE_FLAG 0x400 /* is zero page placed by KSM */
>> 
>>  /* The stable and unstable tree heads */
>>  static struct rb_root one_stable_tree[1] = { RB_ROOT };
>
> @@ -420,6 +421,11 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>  	return atomic_read(&mm->mm_users) == 0;
>>  }
>> 
>> +enum break_ksm_pmd_entry_return_flag {
>
>what about 0 ? I think it would look cleaner if every possible value
>was explicitly listed here
You're right. I'll fix it in a new patch.

>>> +	HAVE_KSM_PAGE = 1,
>> +	HAVE_ZERO_PAGE
>> +};
>> +
>>  static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>>  			struct mm_walk *walk)
>>  {
>> @@ -427,6 +433,7 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>>  	spinlock_t *ptl;
>>  	pte_t *pte;
>>  	int ret;
>> +	bool is_zero_page = false;
>
>this ^ should probably be moved further up in the list of variables
>(i.e. reverse christmas tree)
>
Good. Fix it in a new patch.

>> 
>>  	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
>>  		return 0;
>> @@ -434,6 +441,8 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>>  	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>>  	if (pte_present(*pte)) {
>>  		page = vm_normal_page(walk->vma, addr, *pte);
>> +		if (!page)
>> +			is_zero_page = is_zero_pfn(pte_pfn(*pte));
>>  	} else if (!pte_none(*pte)) {
>>  		swp_entry_t entry = pte_to_swp_entry(*pte);
>> 
>> @@ -444,7 +453,14 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>>  		if (is_migration_entry(entry))
>>  			page = pfn_swap_entry_to_page(entry);
>>  	}
>> -	ret = page && PageKsm(page);
>> +
>> +	if (page && PageKsm(page))
>> +		ret = HAVE_KSM_PAGE;
>> +	else if (is_zero_page)
>> +		ret = HAVE_ZERO_PAGE;
>> +	else
>> +		ret = 0;
>
>and here it would be a great place to use the enum instead of
>hardcoding 0
>
Good. Fix it in a new patch.

>> +
>>  	pte_unmap_unlock(pte, ptl);
>>  	return ret;
>>  }
>> @@ -466,19 +482,22 @@ static const struct mm_walk_ops break_ksm_ops = {
>>   * of the process that owns 'vma'.  We also do not want to enforce
>>   * protection keys here anyway.
>
>please add a (short) explanation of when and why the new
>unshare_zero_page flag should be used.
>
>>   */
>> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>> +				     bool unshare_zero_page)
>>  {
>>  	vm_fault_t ret = 0;
>> 
>>  	do {
>> -		int ksm_page;
>> +		int walk_result;
>> 
>>  		cond_resched();
>> -		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
>> +		walk_result = walk_page_range_vma(vma, addr, addr + 1,
>>  					       &break_ksm_ops, NULL);
>> -		if (WARN_ON_ONCE(ksm_page < 0))
>> -			return ksm_page;
>> -		if (!ksm_page)
>> +		if (WARN_ON_ONCE(walk_result < 0))
>> +			return walk_result;
>> +		if (!walk_result)
>
>if (walk_result == ...)
>
Fine.

>> +			return 0;
>> +		if (walk_result == HAVE_ZERO_PAGE && !unshare_zero_page)
>>  			return 0;
>>  		ret = handle_mm_fault(vma, addr,
>>  				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
>> @@ -539,7 +558,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
>>  	mmap_read_lock(mm);
>>  	vma = find_mergeable_vma(mm, addr);
>>  	if (vma)
>> -		break_ksm(vma, addr);
>> +		break_ksm(vma, addr, false);
>>  	mmap_read_unlock(mm);
>>  }
>> 
>> @@ -764,6 +783,30 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>>  	return NULL;
>>  }
>> 
>> +/*
>> + * Cleaning the rmap_item's ZERO_PAGE_FLAG
>
>this is not what you are doing, though. in case new flags are added,
>this function will cause problems.
>
>> + * This function will be called when unshare or writing on zero pages.
>> + */
>> +static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
>> +{
>> +	if (rmap_item->address & ZERO_PAGE_FLAG)
>> +		rmap_item->address &= PAGE_MASK;
>
>	... &= ~ZERO_PAGE_FLAG;
>
>this way you only clear the flag, and you won't interfere with
>potential new flags that might be introduced in the future. (I
>really hope we won't need new flags in the future because the code is
>already complex enough as it is, but you never know)

How about 'rmap_item->address &= (PAGE_MASK | ~ZERO_PAGE_FLAG);' ?

>
>> +}
>> +
>> +/* Only called when rmap_item is going to be freed */
>> +static inline void unshare_zero_pages(struct ksm_rmap_item *rmap_item)
>> +{
>> +	struct vm_area_struct *vma;
>> +
>> +	if (rmap_item->address & ZERO_PAGE_FLAG) {
>> +		vma = vma_lookup(rmap_item->mm, rmap_item->address);
>> +		if (vma && !ksm_test_exit(rmap_item->mm))
>> +			break_ksm(vma, rmap_item->address, true);
>> +	}
>> +	/* Put at last. */
>> +	clean_rmap_item_zero_flag(rmap_item);
>> +}
>> +
>>  /*
>>   * Removing rmap_item from stable or unstable tree.
>>   * This function will clean the information from the stable/unstable tree.
>> @@ -824,6 +867,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
>>  		struct ksm_rmap_item *rmap_item = *rmap_list;
>>  		*rmap_list = rmap_item->rmap_list;
>>  		remove_rmap_item_from_tree(rmap_item);
>> +		unshare_zero_pages(rmap_item);
>>  		free_rmap_item(rmap_item);
>>  	}
>>  }
>> @@ -853,7 +897,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
>>  		if (signal_pending(current))
>>  			err = -ERESTARTSYS;
>>  		else
>> -			err = break_ksm(vma, addr);
>> +			err = break_ksm(vma, addr, false);
>>  	}
>>  	return err;
>>  }
>> @@ -2044,6 +2088,39 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
>>  	rmap_item->mm->ksm_merging_pages++;
>>  }
>> 
>> +static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
>> +									struct page *page)
>
>this line is less than 100 columns, please don't break it ^
>

Fine. Fix in a new patch.
>> +{
>> +	struct mm_struct *mm = rmap_item->mm;
>> +	int err = 0;
>> +
>> +	/*
>> +	 * It should not take ZERO_PAGE_FLAG because on one hand,
>> +	 * get_next_rmap_item don't return zero pages' rmap_item.
>> +	 * On the other hand, even if zero page was writen as
>> +	 * anonymous page, rmap_item has been cleaned after
>> +	 * stable_tree_search
>> +	 */
>> +	if (!WARN_ON_ONCE(rmap_item->address & ZERO_PAGE_FLAG)) {
>> +		struct vm_area_struct *vma;
>> +
>> +		mmap_read_lock(mm);
>> +		vma = find_mergeable_vma(mm, rmap_item->address);
>> +		if (vma) {
>> +			err = try_to_merge_one_page(vma, page,
>> +						ZERO_PAGE(rmap_item->address));
>
>this line is also less than 100 columns, please don't break it ^
>
>> +			if (!err)
>> +				rmap_item->address |= ZERO_PAGE_FLAG;
>> +		} else {
>> +			/* If the vma is out of date, we do not need to continue. */
>> +			err = 0;
>> +		}
>> +		mmap_read_unlock(mm);
>> +	}
>> +
>> +	return err;
>> +}
>> +
>>  /*
>>   * cmp_and_merge_page - first see if page can be merged into the stable tree;
>>   * if not, compare checksum to previous and if it's the same, see if page can
>> @@ -2055,7 +2132,6 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
>>   */
>>  static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
>>  {
>> -	struct mm_struct *mm = rmap_item->mm;
>>  	struct ksm_rmap_item *tree_rmap_item;
>>  	struct page *tree_page = NULL;
>>  	struct ksm_stable_node *stable_node;
>> @@ -2092,6 +2168,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>  	}
>> 
>>  	remove_rmap_item_from_tree(rmap_item);
>> +	clean_rmap_item_zero_flag(rmap_item);
>> 
>>  	if (kpage) {
>>  		if (PTR_ERR(kpage) == -EBUSY)
>> @@ -2128,29 +2205,16 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>>  	 * Same checksum as an empty page. We attempt to merge it with the
>>  	 * appropriate zero page if the user enabled this via sysfs.
>>  	 */
>> -	if (ksm_use_zero_pages && (checksum == zero_checksum)) {
>
>(like here, see comment below)
>
>> -		struct vm_area_struct *vma;
>> -
>> -		mmap_read_lock(mm);
>> -		vma = find_mergeable_vma(mm, rmap_item->address);
>> -		if (vma) {
>> -			err = try_to_merge_one_page(vma, page,
>> -					ZERO_PAGE(rmap_item->address));
>> -		} else {
>> +	if (ksm_use_zero_pages) {
>> +		if (checksum == zero_checksum)
>
>if I see correctly, you end up with three ifs nested? why not just one
>if with all the conditions?
>
Yes, I thought three 'if'  would be clearer in terms of structures. But let's not modify
this here for now, because I'm going to submit a patch about using static_key instead of
ksm_use_zero_pages.

>>  			/*
>> -			 * If the vma is out of date, we do not need to
>> -			 * continue.
>> +			 * In case of failure, the page was not really empty, so we
>> +			 * need to continue. Otherwise we're done.
>>  			 */
>> -			err = 0;
>> -		}
>> -		mmap_read_unlock(mm);
>> -		/*
>> -		 * In case of failure, the page was not really empty, so we
>> -		 * need to continue. Otherwise we're done.
>> -		 */
>> -		if (!err)
>> -			return;
>> +			if (!try_to_merge_with_kernel_zero_page(rmap_item, page))
>> +				return;
>>  	}
>> +
>>  	tree_rmap_item =
>>  		unstable_tree_search_insert(rmap_item, page, &tree_page);
>>  	if (tree_rmap_item) {
>> @@ -2230,6 +2294,7 @@ static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
>>  		 * is ineligible or discarded, e.g. MADV_DONTNEED.
>>  		 */
>>  		remove_rmap_item_from_tree(rmap_item);
>> +		unshare_zero_pages(rmap_item);
>>  		free_rmap_item(rmap_item);
>>  	}
>> 
>> @@ -2352,6 +2417,22 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>>  			}
>>  			if (is_zone_device_page(*page))
>>  				goto next_page;
>> +			if (is_zero_pfn(page_to_pfn(*page))) {
>> +				/*
>> +				 * To monitor ksm zero pages which becomes non-anonymous,
>> +				 * we have to save each rmap_item of zero pages by
>> +				 * try_to_get_old_rmap_item() walking on
>> +				 * ksm_scan.rmap_list, otherwise their rmap_items will be
>> +				 * freed by the next turn of get_next_rmap_item(). The
>> +				 * function get_next_rmap_item() will free all "skipped"
>> +				 * rmap_items because it thinks its areas as UNMERGEABLE.
>> +				 */
>> +				rmap_item = try_to_get_old_rmap_item(ksm_scan.address,
>> +									ksm_scan.rmap_list);
>> +				if (rmap_item && (rmap_item->address & ZERO_PAGE_FLAG))
>> +					ksm_scan.rmap_list = &rmap_item->rmap_list;
>> +				goto next_page;
>> +			}
>>  			if (PageAnon(*page)) {
>>  				flush_anon_page(vma, *page, ksm_scan.address);
>>  				flush_dcache_page(*page);
>
