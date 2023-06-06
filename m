Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EA47235E0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 05:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFFDqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 23:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFFDqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 23:46:18 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE0812D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 20:46:16 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba841216e92so6310568276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 20:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686023175; x=1688615175;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PlaL5MaaVR+UDyIKMcm/yVvL4j9So7q5GkztpswdgME=;
        b=Lh96h/lDBcM3YSyz9v0Y3hvn7WuORPJViVjZHLCN9PyefN+x22jni/n5lbS1fhDzrP
         MpfKmVOs152zYpqX3g4u6c2D3DRgfMdP0/v6bviAT2MpzbSHHzT1WdHzhjJORbV5NjXz
         jTv8PNQ5uMu1rp4+lvGDpvPAo82GPLIFe4aaBe54H7wLp25+DpCiXVidTHgAusjDQEhI
         TJFlr+5pMFQolpJxSr6enqhcJJhZ9X5gzEO7McG7JDXjJjoYrjC13MU7AkvrFgfcVyfe
         eiqkT7oQJVsvZwL6YReJ17clGDoHjRRLJvavtOawvtgSEat8w13ANyRjIWkZ8nkQaS29
         7W1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686023175; x=1688615175;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlaL5MaaVR+UDyIKMcm/yVvL4j9So7q5GkztpswdgME=;
        b=bDRCfyATWTwiFzaimQkBaKJE5kOVhIY/x+5Xt7tkryCYeTeP0qOyfwW2Jsk+v7cHOS
         C/y1zJc2qktsQAPA2MFIvrFd9AQs7xURjhFElYTU6SiKPlbNWjPknOQz+mDgEOdCKISf
         bZusngS1D5XJBCmb4x78wWfPb5VMTA5JNspHKwaKaqfjyqtRyuFeZLSz7daOVLOoeMxo
         +dD212FsjZCIWXawiPOycdnwJ/xxRHKTx+Y+9fc/F65y4uaj+lHZgS8ht8lf1cYsd6Kg
         vNVJ+sXsI7pha4cBFnOUcZTlCEYVCuTX2S+7jb4tk5qsMiiuoVwyoTT7MelUfwgMKzJG
         PVAQ==
X-Gm-Message-State: AC+VfDxl3iS0kJwZrVO6sxP6sm5zjk4e1RtKD6Wfqvb8aFblmSF17xno
        N5OHJFLUbEjrpQ9Z5WZKn8EMdw==
X-Google-Smtp-Source: ACHHUZ5ebo+2BnNCxDC86vNc4dj3ZHSCTA/lrxyp5IcLZWVSZfUvSH7wOGeKHnVgJiNuE/6SI1T17Q==
X-Received: by 2002:a81:6dc6:0:b0:569:e7cb:c1d3 with SMTP id i189-20020a816dc6000000b00569e7cbc1d3mr1004573ywc.47.1686023175399;
        Mon, 05 Jun 2023 20:46:15 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v80-20020a814853000000b0055a18d8479csm3761428ywa.21.2023.06.05.20.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 20:46:14 -0700 (PDT)
Date:   Mon, 5 Jun 2023 20:46:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Hugh Dickins <hughd@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/12] sparc: add pte_free_defer() for pgtables sharing
 page
In-Reply-To: <f8d84fb8-eb9-6649-7137-715c6010468c@google.com>
Message-ID: <ba73bd57-4bcf-e555-2a9e-a21f2e4214b@google.com>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <f8d84fb8-eb9-6649-7137-715c6010468c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023, Hugh Dickins wrote:

> Add sparc-specific pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.

sparc32 supports pagetables sharing a page, but does not support THP;
sparc64 supports THP, but does not support pagetables sharing a page.
So the sparc-specific pte_free_defer() is as simple as the generic one,
except for converting between pte_t *pgtable_t and struct page *.
The patch should be fine as posted (except its title is misleading).

> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/sparc/include/asm/pgalloc_64.h |  4 ++++
>  arch/sparc/mm/init_64.c             | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/pgalloc_64.h b/arch/sparc/include/asm/pgalloc_64.h
> index 7b5561d17ab1..caa7632be4c2 100644
> --- a/arch/sparc/include/asm/pgalloc_64.h
> +++ b/arch/sparc/include/asm/pgalloc_64.h
> @@ -65,6 +65,10 @@ pgtable_t pte_alloc_one(struct mm_struct *mm);
>  void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
>  void pte_free(struct mm_struct *mm, pgtable_t ptepage);
>  
> +/* arch use pte_free_defer() implementation in arch/sparc/mm/init_64.c */
> +#define pte_free_defer pte_free_defer
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
> +
>  #define pmd_populate_kernel(MM, PMD, PTE)	pmd_set(MM, PMD, PTE)
>  #define pmd_populate(MM, PMD, PTE)		pmd_set(MM, PMD, PTE)
>  
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 04f9db0c3111..b7c6aa085ef6 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2930,6 +2930,22 @@ void pgtable_free(void *table, bool is_page)
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static void pte_free_now(struct rcu_head *head)
> +{
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	__pte_free((pgtable_t)page_to_virt(page));
> +}
> +
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	call_rcu(&page->rcu_head, pte_free_now);
> +}
> +
>  void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
>  			  pmd_t *pmd)
>  {
> -- 
> 2.35.3
> 
> 
