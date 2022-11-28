Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940563A9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiK1NrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiK1NrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:47:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45ADC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669643184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3HDzAsqBZ7PX3t0Ys2WvADREK4jr7JLgdDTg5ZTPBkU=;
        b=b0wFjHOMHP+dJiHxpHP0DcfhRasgCNxzqXb8+T3ifY/N0S3XiItqKj6blez0GdoAintftm
        xrnT6Kfbbs/9nZa3lXjUb54vQ5aqOnmbyozoCQy3yQgUE2LcB+FnFHFfQf8Y9T1arzZnPP
        rU2VTYXkChYKm1EEVc5IZMDvzR+GRvc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-55-FX1vl8yNNzapX4OC72fgvA-1; Mon, 28 Nov 2022 08:46:22 -0500
X-MC-Unique: FX1vl8yNNzapX4OC72fgvA-1
Received: by mail-wr1-f69.google.com with SMTP id k1-20020adfb341000000b0024215e0f486so698586wrd.21
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3HDzAsqBZ7PX3t0Ys2WvADREK4jr7JLgdDTg5ZTPBkU=;
        b=Je/AMRELuXHrsf0jVeTbD2l70f9OlIleWX5EAja87P0TAX2EdXbq5JAvYqaOb10WwC
         0H3GtU010UN2eANK3r8JhwgaHH1bUt1RHL/NJViMRp4U5rJsm9YR+6/M2W4c/wMrTE6r
         flcth9ekAyMx7ZWq9Fntw3IzzwTRiDb8lUqkJgamrsbXN6OL7RDTfijNj8MA4sBf6Yto
         ZnygcH5m3Ab3m1Q754p1xt6WmCRZYWTURwafpJ+Wc9doR/I9syA9HVNDiYHzAJ7RqfPd
         JJNrwm3Fed+FXNYfJ37u4CJdrvcRjzGTUviPWpXzZAT4CiDYoWoZzKO+djrQVH9ZcgT/
         1uiA==
X-Gm-Message-State: ANoB5png5fmysw2K59rmrmFZzTZLRTRjM15mR74Fzu/6XttpXm9L3InI
        Rj87TnWn6wkWwINwMZeo48hMLAGhrq0j4vHhLqW7QyYASOhgLISnXWCHmyPWERzqsfIEDNxukOR
        zyIngIRsPyl7v6eIv26ChwrNa
X-Received: by 2002:adf:d1ca:0:b0:242:fce:543b with SMTP id b10-20020adfd1ca000000b002420fce543bmr5919899wrd.244.1669643181443;
        Mon, 28 Nov 2022 05:46:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5d0b0bHCirMEZ9PQgiB4yBu033LT8ciePisgG8Py7+aHKQ3vBiZ5+w4wTctfHe3DjkQ7NmKw==
X-Received: by 2002:adf:d1ca:0:b0:242:fce:543b with SMTP id b10-20020adfd1ca000000b002420fce543bmr5919872wrd.244.1669643181117;
        Mon, 28 Nov 2022 05:46:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9000:3d6:e434:f8b4:80cf? (p200300cbc702900003d6e434f8b480cf.dip0.t-ipconnect.de. [2003:cb:c702:9000:3d6:e434:f8b4:80cf])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b003cfd4e6400csm16715113wmo.19.2022.11.28.05.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:46:20 -0800 (PST)
Message-ID: <ea2a2311-0a7e-cc81-0b82-5de45acba8f5@redhat.com>
Date:   Mon, 28 Nov 2022 14:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Jann Horn <jannh@google.com>, security@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20221125213714.4115729-1-jannh@google.com>
 <20221125213714.4115729-2-jannh@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 2/3] mm/khugepaged: Fix GUP-fast interaction by sending
 IPI
In-Reply-To: <20221125213714.4115729-2-jannh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.22 22:37, Jann Horn wrote:
> Since commit 70cbc3cc78a99 ("mm: gup: fix the fast GUP race against THP
> collapse"), the lockless_pages_from_mm() fastpath rechecks the pmd_t to
> ensure that the page table was not removed by khugepaged in between.
> 
> However, lockless_pages_from_mm() still requires that the page table is not
> concurrently freed.

That's an interesting point. For anon THPs, the page table won't get 
immediately freed, but instead will be deposited in the "pgtable list" 
stored alongside the THP.

 From there, it might get withdrawn (pgtable_trans_huge_withdraw()) and

a) Reused as a page table when splitting the THP. That should be fine, 
no garbage in it, simply a page table again.

b) Freed when zapping the THP (zap_deposited_table()). that would be bad.

... but I just realized that e.g., radix__pgtable_trans_huge_deposit 
uses actual page content to link the deposited page tables, which means 
we'd already storing garbage in there when depositing the page, not when 
freeing+reusing the page ....

Maybe worth adding to the description.

> Fix it by sending IPIs (if the architecture uses
> semi-RCU-style page table freeing) before freeing/reusing page tables.
> 
> Cc: stable@kernel.org
> Fixes: ba76149f47d8 ("thp: khugepaged")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> replaced the mmu_gather-based scheme with an RCU call as suggested by
> Peter Xu
> 
>   include/asm-generic/tlb.h | 4 ++++
>   mm/khugepaged.c           | 2 ++
>   mm/mmu_gather.c           | 4 +---
>   3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 492dce43236ea..cab7cfebf40bd 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -222,12 +222,16 @@ extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>   #define tlb_needs_table_invalidate() (true)
>   #endif
>   
> +void tlb_remove_table_sync_one(void);
> +
>   #else
>   
>   #ifdef tlb_needs_table_invalidate
>   #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
>   #endif
>   
> +static inline void tlb_remove_table_sync_one(void) { }
> +
>   #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>   
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 674b111a24fa7..c3d3ce596bff7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1057,6 +1057,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>   	_pmd = pmdp_collapse_flush(vma, address, pmd);
>   	spin_unlock(pmd_ptl);
>   	mmu_notifier_invalidate_range_end(&range);
> +	tlb_remove_table_sync_one();
>   
>   	spin_lock(pte_ptl);
>   	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
> @@ -1415,6 +1416,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>   		lockdep_assert_held_write(&vma->anon_vma->root->rwsem);
>   
>   	pmd = pmdp_collapse_flush(vma, addr, pmdp);
> +	tlb_remove_table_sync_one();
>   	mm_dec_nr_ptes(mm);
>   	page_table_check_pte_clear_range(mm, addr, pmd);
>   	pte_free(mm, pmd_pgtable(pmd));
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index add4244e5790d..3a2c3f8cad2fe 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -153,7 +153,7 @@ static void tlb_remove_table_smp_sync(void *arg)
>   	/* Simply deliver the interrupt */
>   }
>   
> -static void tlb_remove_table_sync_one(void)
> +void tlb_remove_table_sync_one(void)
>   {
>   	/*
>   	 * This isn't an RCU grace period and hence the page-tables cannot be
> @@ -177,8 +177,6 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   
>   #else /* !CONFIG_MMU_GATHER_RCU_TABLE_FREE */
>   
> -static void tlb_remove_table_sync_one(void) { }
> -
>   static void tlb_remove_table_free(struct mmu_table_batch *batch)
>   {
>   	__tlb_remove_table_free(batch);

With CONFIG_MMU_GATHER_RCU_TABLE_FREE this will most certainly do the 
right thing. I assume with CONFIG_MMU_GATHER_RCU_TABLE_FREE, the 
assumption is that there will be an implicit IPI.

That implicit IPI has to happen before we deposit. I assume that is 
expected to happen during pmdp_collapse_flush() ?

-- 
Thanks,

David / dhildenb

