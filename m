Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4CC62EB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbiKRBgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbiKRBgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:36:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE72AE9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668735308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuhgMGt5eYKxb7zJ8raKWs44aO6StvNoESpzCP1pzG4=;
        b=hxYfk6tjsg8cTgr1NjxNEjIQRHYG+wfUAQcU4z9BJVaLUeH5hNDeU9WEfhQMVEyCb83RbU
        I4vxC4fzN2ogOh9hhbrG4ZP3085baBq4KKY4hLJR5ksN/NGETKY9tO3Cv9Cp3/ekgH9yhT
        6//wme3EMYKU+BoLKUxGTXHjvuJAyS0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-Jzl2Z7fwPQOP1EyE6O8Wtg-1; Thu, 17 Nov 2022 20:35:06 -0500
X-MC-Unique: Jzl2Z7fwPQOP1EyE6O8Wtg-1
Received: by mail-qt1-f199.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso3492715qtj.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuhgMGt5eYKxb7zJ8raKWs44aO6StvNoESpzCP1pzG4=;
        b=BWAC+j5wjmT2j7vkruqcfEK7ufK8YjScgZFb1L7QYWxrWoKx8sE29Am/YhDHubcOsr
         h3dnOZ1bRTuJC9RItTTdJemgctaoVuDDQD0KDAJyTtRJNMCPL5kOBKB/1ctXpU9//wXz
         slTKyE2uX4BmQODo+886rn274vhQwUhKGslKHTPKHrsQ3fsL3ssIK100vejts7jhSeMq
         JUBJVv8xf7WMCQCmY92P9JyNuY8WpHqTi539c3mMdjre9clPXExPJhlhmzEejAWKcN4g
         2prWxV+6Yx8JwYasfxF036oli1Kd6EPSea/B157eN/QNGW+CbYcpLLKIdtKTFqHGlqi4
         VeNA==
X-Gm-Message-State: ANoB5pl+YUjovcD3nZhZKcbzAbXie9cG7c1SijDhKkLjVko65F/isn5i
        mR/RZ3qhMIaFXZQWpO8uYiKYdp9evoysLMFm6obXKrMDYcVTbcj8CdiwQx09fJIgczVVCTKFKOr
        fTy6r5fycpr4kpKxRHif7FhUO
X-Received: by 2002:a05:622a:1496:b0:3a5:7eb0:4962 with SMTP id t22-20020a05622a149600b003a57eb04962mr4712924qtx.525.1668735306372;
        Thu, 17 Nov 2022 17:35:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wFkW2f8XkH1HOv7vs0jJoE2AQxy7v0LZq0260rY80eGcGRw4N1oBy3rmx6CIWrwhmo8OG3A==
X-Received: by 2002:a05:622a:1496:b0:3a5:7eb0:4962 with SMTP id t22-20020a05622a149600b003a57eb04962mr4712906qtx.525.1668735306151;
        Thu, 17 Nov 2022 17:35:06 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id dt18-20020a05620a479200b006ea7f9d8644sm1519176qkb.96.2022.11.17.17.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:35:05 -0800 (PST)
Date:   Thu, 17 Nov 2022 20:35:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC v2 02/12] mm/hugetlb: Move swap entry handling into
 vma lock for fault
Message-ID: <Y3bhSEmhfULy+Vxo@x1n>
References: <20221118011025.2178986-1-peterx@redhat.com>
 <20221118011025.2178986-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118011025.2178986-3-peterx@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 08:10:15PM -0500, Peter Xu wrote:
> In hugetlb_fault(), there used to have a special path to handle swap entry
> at the entrance using huge_pte_offset().  That's unsafe because
> huge_pte_offset() for a pmd sharable range can access freed pgtables if
> without either the walker lock or vma lock.
> 
> Here the simplest solution for making it safe is just to move the swap
> handling to be after the vma lock being held.  We may need to take the
> fault mutex on either migration or hwpoison entries now (also the vma lock,
> but that's really needed), however neither of them is hot path so it should
> be fine.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c3aab6d5b7aa..62ff3fc51d4e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5824,22 +5824,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	int need_wait_lock = 0;
>  	unsigned long haddr = address & huge_page_mask(h);
>  
> -	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> -	if (ptep) {
> -		/*
> -		 * Since we hold no locks, ptep could be stale.  That is
> -		 * OK as we are only making decisions based on content and
> -		 * not actually modifying content here.
> -		 */
> -		entry = huge_ptep_get(ptep);
> -		if (unlikely(is_hugetlb_entry_migration(entry))) {
> -			migration_entry_wait_huge(vma, ptep);
> -			return 0;
> -		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> -			return VM_FAULT_HWPOISON_LARGE |
> -				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	}
> -
>  	/*
>  	 * Serialize hugepage allocation and instantiation, so that we don't
>  	 * get spurious allocation failures if two CPUs race to instantiate
> @@ -5886,8 +5870,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
>  	 * properly handle it.
>  	 */
> -	if (!pte_present(entry))
> +	if (!pte_present(entry)) {
> +		if (unlikely(is_hugetlb_entry_migration(entry)))
> +			migration_entry_wait_huge(vma, ptep);

Hmm no, need to release the vma lock and fault mutex.. So I remembered why
I had a note that I need to rework migration wait code..

I'll try that on next version, it would be a callback just to release the
proper locks in migration_entry_wait_huge() right after releasing the
pgtable lock, in e.g. migration_entry_wait_on_locked().

> +		else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
> +			ret = VM_FAULT_HWPOISON_LARGE |
> +			    VM_FAULT_SET_HINDEX(hstate_index(h));
>  		goto out_mutex;
> +	}
>  
>  	/*
>  	 * If we are going to COW/unshare the mapping later, we examine the
> -- 
> 2.37.3
> 

-- 
Peter Xu

