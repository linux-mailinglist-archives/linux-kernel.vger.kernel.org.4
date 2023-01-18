Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F1671F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjARO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjARO1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6C56EC5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674051058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sr1/LUQHwubaC/6+yigReObSaZRNqB3QQDgWoJAi3TM=;
        b=KoyTo1Jhif8HVOUxFGPqz1VlsQ1Iwj2S0//ZA8S+Qdx2k29XguUWqQ8x7wLd4AiUqsTCOQ
        /MR8XybAxnUrp7Mtt4P+6ytRr0VC23YITKZqfzD97qoYDtsD6wSUckrt8h8CFFIRC+25ha
        mRgse0/l24Cl9U+9ipD3BZ8Q5uUH/WI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-428-ThVt6ShFOXWqrgK1Jg4sRA-1; Wed, 18 Jan 2023 09:10:56 -0500
X-MC-Unique: ThVt6ShFOXWqrgK1Jg4sRA-1
Received: by mail-wm1-f69.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso1266033wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sr1/LUQHwubaC/6+yigReObSaZRNqB3QQDgWoJAi3TM=;
        b=wkvn1pVW870XJePMT416IYCu7qjRrgedV8Y7Huy1e/wba21omyVQ3ATNxEnuzFHK+S
         oE1n0JP+87f1oiitjtwi8HnJEYWBHcNLzYX2N7JcZWIIkQBEGxTMiwKLv/3AgdN1pu8J
         OLBzTV/TJf9aNbmByWW/5/ofQeea9jkH1OTmmuVOsnFVNBsLaJu6o8wet1OW3U0lm79A
         qi6Mj645pR8CLfcRojRNk2yx9UpZniDUPk0qR8SdcvCMLHbhwoGnvmtRcqcE0fvKEhlL
         QErs3EuPKNgRHIgEa89p1hADTD14lE+L9PEPkchk7NlT32tgx64KFUUfRADz0w3/iy4U
         9giA==
X-Gm-Message-State: AFqh2koo/Hy6NR60lScK2BN0Owv6iteWXgObDAYOPf55H/eJX2VeTBqv
        WesXnuG8g+bILnCKKwI3E1BuBctUrDQHtbHqm/An1aOQWK9rDzfpiGBI8d7enY5WukaR5VrzUAa
        JazlKOjXGqfsQyW1dfGiDaXbk
X-Received: by 2002:a5d:6350:0:b0:2bc:7d12:7400 with SMTP id b16-20020a5d6350000000b002bc7d127400mr6531113wrw.36.1674051055642;
        Wed, 18 Jan 2023 06:10:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsbFV5oKkK70OyPh+biK8wDKD2aSk+ulJZm3rqGI4w5U+Q9tyC10pkOd75ZN+xb/8QbhovsEQ==
X-Received: by 2002:a5d:6350:0:b0:2bc:7d12:7400 with SMTP id b16-20020a5d6350000000b002bc7d127400mr6531095wrw.36.1674051055273;
        Wed, 18 Jan 2023 06:10:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:800:1a88:f98a:d223:c454? (p200300cbc70508001a88f98ad223c454.dip0.t-ipconnect.de. [2003:cb:c705:800:1a88:f98a:d223:c454])
        by smtp.gmail.com with ESMTPSA id c6-20020adffb06000000b002423620d356sm11286393wrr.35.2023.01.18.06.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:10:54 -0800 (PST)
Message-ID: <60125c55-9ab7-7531-e124-cb676943fea6@redhat.com>
Date:   Wed, 18 Jan 2023 15:10:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202212300913573751808@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 2/6] ksm: support unsharing zero pages placed by KSM
In-Reply-To: <202212300913573751808@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.12.22 02:13, yang.yang29@zte.com.cn wrote:
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

[...]

> 
>   /* The stable and unstable tree heads */
>   static struct rb_root one_stable_tree[1] = { RB_ROOT };
> @@ -420,6 +421,11 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
> 
> +enum break_ksm_pmd_entry_return_flag {
> +	HAVE_KSM_PAGE = 1,
> +	HAVE_ZERO_PAGE
> +};

Why use flags if they both conditions are mutually exclusive?

> +
>   static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
>   			struct mm_walk *walk)
>   {
> @@ -427,6 +433,7 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>   	spinlock_t *ptl;
>   	pte_t *pte;
>   	int ret;
> +	bool is_zero_page = false;
> 
>   	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
>   		return 0;
> @@ -434,6 +441,8 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>   	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
>   	if (pte_present(*pte)) {
>   		page = vm_normal_page(walk->vma, addr, *pte);
> +		if (!page)
> +			is_zero_page = is_zero_pfn(pte_pfn(*pte));
>   	} else if (!pte_none(*pte)) {
>   		swp_entry_t entry = pte_to_swp_entry(*pte);
> 
> @@ -444,7 +453,14 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>   		if (is_migration_entry(entry))
>   			page = pfn_swap_entry_to_page(entry);
>   	}
> -	ret = page && PageKsm(page);
> +
> +	if (page && PageKsm(page))
> +		ret = HAVE_KSM_PAGE;
> +	else if (is_zero_page)
> +		ret = HAVE_ZERO_PAGE;
> +	else
> +		ret = 0;
> +
>   	pte_unmap_unlock(pte, ptl);
>   	return ret;
>   }
> @@ -466,19 +482,22 @@ static const struct mm_walk_ops break_ksm_ops = {
>    * of the process that owns 'vma'.  We also do not want to enforce
>    * protection keys here anyway.
>    */
> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
> +				     bool unshare_zero_page)
>   {
>   	vm_fault_t ret = 0;
> 
>   	do {
> -		int ksm_page;
> +		int walk_result;
> 
>   		cond_resched();
> -		ksm_page = walk_page_range_vma(vma, addr, addr + 1,
> +		walk_result = walk_page_range_vma(vma, addr, addr + 1,
>   					       &break_ksm_ops, NULL);
> -		if (WARN_ON_ONCE(ksm_page < 0))
> -			return ksm_page;
> -		if (!ksm_page)
> +		if (WARN_ON_ONCE(walk_result < 0))
> +			return walk_result;
> +		if (!walk_result)
> +			return 0;
> +		if (walk_result == HAVE_ZERO_PAGE && !unshare_zero_page)
>   			return 0;
>   		ret = handle_mm_fault(vma, addr,
>   				      FAULT_FLAG_UNSHARE | FAULT_FLAG_REMOTE,
> @@ -539,7 +558,7 @@ static void break_cow(struct ksm_rmap_item *rmap_item)
>   	mmap_read_lock(mm);
>   	vma = find_mergeable_vma(mm, addr);
>   	if (vma)
> -		break_ksm(vma, addr);
> +		break_ksm(vma, addr, false);
>   	mmap_read_unlock(mm);
>   }
> 
> @@ -764,6 +783,30 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>   	return NULL;
>   }
> 
> +/*
> + * Cleaning the rmap_item's ZERO_PAGE_FLAG
> + * This function will be called when unshare or writing on zero pages.
> + */
> +static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
> +{
> +	if (rmap_item->address & ZERO_PAGE_FLAG)
> +		rmap_item->address &= PAGE_MASK;
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
>   /*
>    * Removing rmap_item from stable or unstable tree.
>    * This function will clean the information from the stable/unstable tree.
> @@ -824,6 +867,7 @@ static void remove_trailing_rmap_items(struct ksm_rmap_item **rmap_list)
>   		struct ksm_rmap_item *rmap_item = *rmap_list;
>   		*rmap_list = rmap_item->rmap_list;
>   		remove_rmap_item_from_tree(rmap_item);
> +		unshare_zero_pages(rmap_item);
>   		free_rmap_item(rmap_item);
>   	}
>   }
> @@ -853,7 +897,7 @@ static int unmerge_ksm_pages(struct vm_area_struct *vma,
>   		if (signal_pending(current))
>   			err = -ERESTARTSYS;
>   		else
> -			err = break_ksm(vma, addr);
> +			err = break_ksm(vma, addr, false);
>   	}

MADV_UNMERGEABLE -> unmerge_ksm_pages() will never unshare the shared 
zeropage? I thought the patch description mentions that that is one of 
the goals?

-- 
Thanks,

David / dhildenb

