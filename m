Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C7670D94D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbjEWJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjEWJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166F119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684834888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDccK11tKb/DU0VHaHNBaId4k6b+Ap4leLuwcKO7ZrY=;
        b=are2AHHNTcW8S5G/7Ecs979ZueFIqL6HRbnXnzZ8w7vsp8+uj4dxUW5/r+a8xGEmbEwNSm
        YCwlGM2QS2OFWM6AQeHYNaRegluQDiiYycP7Qm+/nMoZPIvHrNx4GMpCSmuIcqdq3QBKzO
        1TCFYSRJeX8h0+ZmJPR4QRsibiD379w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-haAuSNErNNie7SJGqGyUeQ-1; Tue, 23 May 2023 05:41:27 -0400
X-MC-Unique: haAuSNErNNie7SJGqGyUeQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso27870945e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834886; x=1687426886;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDccK11tKb/DU0VHaHNBaId4k6b+Ap4leLuwcKO7ZrY=;
        b=LibmDHMK45ORhFFlVsq0EBPAR6wRCXUQayCgT3PBDINyZ1hQs3GYCWREoGoQO9nAMV
         oI0mxhOA4CB6nzwjhUiW8UzHf7kggKAMA9YWjrXLRH/sqwREbOPuRc+qYeTYQBlsVtOW
         tqeg0SS5Wv7H6IsE1zfMlapp4iMd4MHusVCtu97HiLAq6GRemPSvTJU5R1v9NOEzFohE
         XaTGlQjEGckeZbkc1FerTK0Yndn2ovKIY5ZDgiE/ot9rUb60bl0eqTL8kar9wWywN260
         WEH2P1+Q4yyl2OGfzRlbEZksvA+HhjPK0T0pK/O4gjfZtyGN8DW/pj6rgVsrvW3Ap1E0
         V6yA==
X-Gm-Message-State: AC+VfDxjcxf1XIiwmr+fmg3cW6beeuUctC3NR9bm3NfB3m4xW1TbRfIt
        lxbkksiUykoosBXrzPtF1VUSTuq48mEt6PJqf5cetAnz4bTJnYsAnr6Emsc4RQ0jlJiNnSGi1+u
        pM2SEUbZxhcY+c3KQGYDUqw8C
X-Received: by 2002:a05:600c:3658:b0:3f4:2438:31ca with SMTP id y24-20020a05600c365800b003f4243831camr9540357wmq.26.1684834886119;
        Tue, 23 May 2023 02:41:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6moStJZq0DXZPe8Acop7zOR1G4ELRA7FwbpGohqKxxjZg25oZi8IALChaxSaMIIYU7+03mxQ==
X-Received: by 2002:a05:600c:3658:b0:3f4:2438:31ca with SMTP id y24-20020a05600c365800b003f4243831camr9540339wmq.26.1684834885766;
        Tue, 23 May 2023 02:41:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003f50876905dsm11227542wme.6.2023.05.23.02.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:41:25 -0700 (PDT)
Message-ID: <1925d301-462d-6b33-8867-4e1646b2dbd6@redhat.com>
Date:   Tue, 23 May 2023 11:41:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522104908.3999-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 1/6] ksm: support unsharing KSM-placed zero pages
In-Reply-To: <20230522104908.3999-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.23 12:49, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> When use_zero_pages of ksm is enabled, madvise(addr, len, MADV_UNMERGEABLE)
> and other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger
> unsharing will *not* actually unshare the shared zeropage as placed by KSM
> (which is against the MADV_UNMERGEABLE documentation). As these KSM-placed
> zero pages are out of the control of KSM, the related counts of ksm pages
> don't expose how many zero pages are placed by KSM (these special zero
> pages are different from those initially mapped zero pages, because the
> zero pages mapped to MADV_UNMERGEABLE areas are expected to be a complete
> and unshared page)
> 
> To not blindly unshare all shared zero_pages in applicable VMAs, the patch
> use pte_mkdirty (related with architecture) to mark KSM-placed zero pages.
> Thus, MADV_UNMERGEABLE will only unshare those KSM-placed zero pages.
> 
> The patch will not degrade the performance of use_zero_pages as it doesn't
> change the way of merging empty pages in use_zero_pages's feature.
> 

Maybe add: "We'll reuse this mechanism to reliably identify KSM-placed 
zeropages to properly account for them (e.g., calculating the KSM profit 
that includes zeropages) next."

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   include/linux/ksm.h | 6 ++++++
>   mm/ksm.c            | 5 +++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 899a314bc487..7989200cdbb7 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -26,6 +26,9 @@ int ksm_disable(struct mm_struct *mm);
>   
>   int __ksm_enter(struct mm_struct *mm);
>   void __ksm_exit(struct mm_struct *mm);
> +/* use pte_mkdirty to track a KSM-placed zero page */
> +#define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))

If there is only a single user (which I assume), please inline it instead.

Let's add some more documentation:

/*
  * To identify zeropages that were mapped by KSM, we reuse the dirty bit
  * in the PTE. If the PTE is dirty, the zeropage was mapped by KSM when
  * deduplicating memory.
  */

> +#define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
>   
>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
> @@ -95,6 +98,9 @@ static inline void ksm_exit(struct mm_struct *mm)
>   {
>   }
>   
> +#define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
> +#define is_ksm_zero_pte(pte)	0
> +
>   #ifdef CONFIG_MEMORY_FAILURE
>   static inline void collect_procs_ksm(struct page *page,
>   				     struct list_head *to_kill, int force_early)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 0156bded3a66..9962f5962afd 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -447,7 +447,8 @@ static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long nex
>   		if (is_migration_entry(entry))
>   			page = pfn_swap_entry_to_page(entry);
>   	}
> -	ret = page && PageKsm(page);
> +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +	ret = (page && PageKsm(page)) || is_ksm_zero_pte(*pte);
>   	pte_unmap_unlock(pte, ptl);
>   	return ret;
>   }
> @@ -1220,7 +1221,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>   		page_add_anon_rmap(kpage, vma, addr, RMAP_NONE);
>   		newpte = mk_pte(kpage, vma->vm_page_prot);
>   	} else {
> -		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
> +		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
>   					       vma->vm_page_prot));
>   		/*
>   		 * We're replacing an anonymous page with a zero page, which is

Apart from that LGTM.

-- 
Thanks,

David / dhildenb

