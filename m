Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6370D983
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbjEWJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjEWJtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DAE5C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684835280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTozs52NGQBBt66G2VZ78itBAYBuBwd2qy/f5JHxcgg=;
        b=T50ihGO4GuDGVgv6iEaW4bkPMn8EzIHwo9UC4xZ2DRlEvKp/iz6iATXW96Gt4JWom9zVE9
        2xNuPKVd+aOM0ncOZXyQ0zaiXet8s2wJBZjsgSGTl3m+/q3J9IYs53U8w9RXVl+1fvjmSp
        evJq6cfe37G86ROMLHlN/wtKdTIXq6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-0AP6TlEvM2yqYKAovmGz3g-1; Tue, 23 May 2023 05:47:58 -0400
X-MC-Unique: 0AP6TlEvM2yqYKAovmGz3g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-306362a1607so4580523f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684835277; x=1687427277;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTozs52NGQBBt66G2VZ78itBAYBuBwd2qy/f5JHxcgg=;
        b=iBX0s+Y2gFFuLkJ9dy3ZIZ+VUBz24JMOYv9y60/cdkKj9Vcc91mg7ulZlQKdD8yKRZ
         uVKommUCYBDjnO+xXUCa4lKhvu6SAeOPziizbG+aNsb5YSa2xjBieK+BMcaRRe4+JHSY
         QREcwOgJPfqHugAfIVUpyR0WTsue8+Eelvzd1+uEIY5utnS5rffICz0g7bMs67CVOoPk
         IL8wLReNpT5JrX0aHEQt3uf/rvDlLay1hDTUTKowc13SAgy8CxBYIjUwqs0ZxLVOTh+F
         Lyru7i8G9JuB4ZziKkLF2JAjALsSSgJAul9qeh7B37OcX2eDYeWBt6JHBv2VK/tAF87W
         07ew==
X-Gm-Message-State: AC+VfDxtWd2zmcnUNPr6hXpgJHUO9zyJzmBK3hcWVcxRNJF3Bu+CcIcV
        uEG4aQCah4zBv+9aXtqvgA90JM5YcM1kSm3duq5Z8XHWbvvton57wOg/9tjXk1+r9JEiMtzrQ4c
        nJu+LQVkTtUmOifDYcQPsLH4c
X-Received: by 2002:adf:fd07:0:b0:309:3b27:9baa with SMTP id e7-20020adffd07000000b003093b279baamr9962696wrr.52.1684835277605;
        Tue, 23 May 2023 02:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Cg0L8GaoEx5zA4nxlysT18P5TkZ7gbabyWFIRjsDKmtvzHzyuCCKmuqWSgjFyU8zQbfpTuA==
X-Received: by 2002:adf:fd07:0:b0:309:3b27:9baa with SMTP id e7-20020adffd07000000b003093b279baamr9962677wrr.52.1684835277243;
        Tue, 23 May 2023 02:47:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd? (p200300cbc74cb4005c8ba0b2f57ee1cd.dip0.t-ipconnect.de. [2003:cb:c74c:b400:5c8b:a0b2:f57e:e1cd])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d5390000000b00301a351a8d6sm10588479wrv.84.2023.05.23.02.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 02:47:56 -0700 (PDT)
Message-ID: <401a535a-0393-fc7c-66b0-832c061283c7@redhat.com>
Date:   Tue, 23 May 2023 11:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 2/6] ksm: count all zero pages placed by KSM
Content-Language: en-US
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305221842587200002@zte.com.cn>
 <20230522105229.4066-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230522105229.4066-1-yang.yang29@zte.com.cn>
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

On 22.05.23 12:52, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> As pages_sharing and pages_shared don't include the number of zero pages
> merged by KSM, we cannot know how many pages are zero pages placed by KSM
> when enabling use_zero_pages, which leads to KSM not being transparent with
> all actual merged pages by KSM. In the early days of use_zero_pages,
> zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
> it's hard to count how many times one of those zeropages was then unmerged.
> 
> But now, unsharing KSM-placed zero page accurately has been achieved, so we
> can easily count both how many times a page full of zeroes was merged with
> zero-page and how many times one of those pages was then unmerged. and so,
> it helps to estimate memory demands when each and every shared page could
> get unshared.
> 
> So we add ksm_zero_pages under /sys/kernel/mm/ksm/ to show the number
> of all zero pages placed by KSM.
> 
> v7->v8:
> Handle the case when khugepaged replaces a shared zeropage by a THP.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> ---
>   include/linux/ksm.h | 17 +++++++++++++++++
>   mm/khugepaged.c     |  3 +++
>   mm/ksm.c            | 12 ++++++++++++
>   mm/memory.c         |  7 ++++++-
>   4 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index 7989200cdbb7..1adcae0205e3 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -29,6 +29,16 @@ void __ksm_exit(struct mm_struct *mm);
>   /* use pte_mkdirty to track a KSM-placed zero page */
>   #define set_pte_ksm_zero(pte)	pte_mkdirty(pte_mkspecial(pte))
>   #define is_ksm_zero_pte(pte)	(is_zero_pfn(pte_pfn(pte)) && pte_dirty(pte))
> +extern unsigned long ksm_zero_pages;
> +static inline void inc_ksm_zero_pages(void)
> +{
> +	ksm_zero_pages++;
> +}
> +

No need to export the inc, just inline this.

> +static inline void dec_ksm_zero_pages(void)
> +{
> +	ksm_zero_pages--;
> +}
>   
>   static inline int ksm_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>   {
> @@ -100,6 +110,13 @@ static inline void ksm_exit(struct mm_struct *mm)
>   
>   #define set_pte_ksm_zero(pte)	pte_mkspecial(pte)
>   #define is_ksm_zero_pte(pte)	0
> +static inline void inc_ksm_zero_pages(void)
> +{
> +}
> +
> +static inline void dec_ksm_zero_pages(void)
> +{
> +}
>   
>   #ifdef CONFIG_MEMORY_FAILURE
>   static inline void collect_procs_ksm(struct page *page,
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b9d39d65b73..ba0d077b6951 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -19,6 +19,7 @@
>   #include <linux/page_table_check.h>
>   #include <linux/swapops.h>
>   #include <linux/shmem_fs.h>
> +#include <linux/ksm.h>
>   
>   #include <asm/tlb.h>
>   #include <asm/pgalloc.h>
> @@ -711,6 +712,8 @@ static void __collapse_huge_page_copy_succeeded(pte_t *pte,
>   				spin_lock(ptl);
>   				ptep_clear(vma->vm_mm, address, _pte);
>   				spin_unlock(ptl);
> +				if (is_ksm_zero_pte(pteval))
> +					dec_ksm_zero_pages();
>   			}
>   		} else {
>   			src_page = pte_page(pteval);
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 9962f5962afd..2ca7e8860faa 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -278,6 +278,9 @@ static unsigned int zero_checksum __read_mostly;
>   /* Whether to merge empty (zeroed) pages with actual zero pages */
>   static bool ksm_use_zero_pages __read_mostly;
>   
> +/* The number of zero pages which is placed by KSM */
> +unsigned long ksm_zero_pages;
> +
>   #ifdef CONFIG_NUMA
>   /* Zeroed when merging across nodes is not allowed */
>   static unsigned int ksm_merge_across_nodes = 1;
> @@ -1223,6 +1226,7 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
>   	} else {
>   		newpte = set_pte_ksm_zero(pfn_pte(page_to_pfn(kpage),
>   					       vma->vm_page_prot));
> +		inc_ksm_zero_pages();
>   		/*
>   		 * We're replacing an anonymous page with a zero page, which is
>   		 * not anonymous. We need to do proper accounting otherwise we
> @@ -3350,6 +3354,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
>   }
>   KSM_ATTR_RO(pages_volatile);
>   
> +static ssize_t ksm_zero_pages_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%ld\n", ksm_zero_pages);
> +}
> +KSM_ATTR_RO(ksm_zero_pages);
> +
>   static ssize_t general_profit_show(struct kobject *kobj,
>   				   struct kobj_attribute *attr, char *buf)
>   {
> @@ -3417,6 +3428,7 @@ static struct attribute *ksm_attrs[] = {
>   	&pages_sharing_attr.attr,
>   	&pages_unshared_attr.attr,
>   	&pages_volatile_attr.attr,
> +	&ksm_zero_pages_attr.attr,
>   	&full_scans_attr.attr,
>   #ifdef CONFIG_NUMA
>   	&merge_across_nodes_attr.attr,
> diff --git a/mm/memory.c b/mm/memory.c
> index 8358f3b853f2..058b416adf24 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1415,8 +1415,11 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   			tlb_remove_tlb_entry(tlb, pte, addr);
>   			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
>   						      ptent);
> -			if (unlikely(!page))
> +			if (unlikely(!page)) {
> +				if (is_ksm_zero_pte(ptent))
> +					dec_ksm_zero_pages();
>   				continue;
> +			}
>   
>   			delay_rmap = 0;
>   			if (!PageAnon(page)) {
> @@ -3120,6 +3123,8 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>   				inc_mm_counter(mm, MM_ANONPAGES);
>   			}
>   		} else {
> +			if (is_ksm_zero_pte(vmf->orig_pte))
> +				dec_ksm_zero_pages();
>   			inc_mm_counter(mm, MM_ANONPAGES);
>   		}
>   		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));

Can we maybe avoid exporting the dec semantics and rather add a callback 
to KSM? Ideally, we'd even distill that down to a single call, and 
handle the details in ksm.h. Maybe simply:

ksm_notify_unmap_zero_page(vmf->orig_pte);

and then just have in ksm.h

static inline void ksm_notify_unmap_zero_page(pte_t pte)
{
	if (is_ksm_zero_pte(pte))
		ksm_zero_pages--;
}

-- 
Thanks,

David / dhildenb

