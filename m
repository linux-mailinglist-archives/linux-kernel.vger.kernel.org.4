Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B020718A74
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEaTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjEaTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:49:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D71BD
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:48:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso109145b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1685562534; x=1688154534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7hK4Ihr/VoqnHJzO2kR1sxTTtgLAwvIitCKGJz96Cs=;
        b=m1HfrX1d0iJrg+rPFbOc0G/EwLDsJOG4WmFnWZUC/hngBLshCk/dSjpllXkf6w5Mie
         7a+hGH7hDYlUiTFWNkP20zXoGtcdP7dBe6wS57RHTvOOxwgoyUZPfcl93kds42O3WmVp
         nosyhRzPvsymvj2A+C8B5+cUwBvyd0CG9/ZCxraPDb0KMEMwy5jEUPxu0z9L3FkU8yC9
         UBNCmi3MSdp3iKteRZowGajvH0SWJyKV5QT90Qg+h21zFe3lXODmDUuF8+ZA2FzkFH8O
         fTnASsBqcMv1hbeFKEuaheXLYbinSOf/EX1HXc5s3ZZJv/376WWovjrPsnii4owhdByS
         ROEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562534; x=1688154534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7hK4Ihr/VoqnHJzO2kR1sxTTtgLAwvIitCKGJz96Cs=;
        b=RfaGeu81kVa7xWdiDEBmJVdGr97Zps6xy4dz/Wunb4Di5RecqEvJuGrVQ118aaZCs8
         +3/yOjbWGYyVlMotK+Mf7Skn5ep/AtLQN+pQ0QhmyGI7zq7YdkEv4uEfvLlBGXeiX8zq
         M3JUACNfma/hkla7yZOtY8N8C4OH0vCSYob0uhEJJ4vfPmJRjOaReNyhz1UrtIDEuZRh
         jL8MVQaVZ3ZZYtmEPeXI8DgyHa7/GsKrvLEkQh1I0Nc7voFkKnzbM9nV08Loo2W2oL5g
         bPYNXORbaUDpI59RqlIBVneuNHSEdTczPrXgqA/U5bs0zTfNjiPY+2EdBs+dWX0ilLDd
         cCIg==
X-Gm-Message-State: AC+VfDxZysPXGQBXf3yjJhY64VN6tGFkICuEqDdY/qtEBxaIcE28klC7
        cHBjtD/agb9BAPKQ+epGvXaUgg==
X-Google-Smtp-Source: ACHHUZ6IHdLCo36F3u4uaEk/Y7Ym7GEOFEfVy22jQHGr8ZjdNvbxqGcqQPgiW3ENI9gy4GtmlFgXnA==
X-Received: by 2002:a05:6a20:a109:b0:10b:6698:769d with SMTP id q9-20020a056a20a10900b0010b6698769dmr6344322pzk.11.1685562534252;
        Wed, 31 May 2023 12:48:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001ac55a5e5eesm1782100plf.121.2023.05.31.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:48:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q4RoS-001854-Ch;
        Wed, 31 May 2023 16:48:52 -0300
Date:   Wed, 31 May 2023 16:48:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Zack Rusin <zackr@vmware.com>,
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
Subject: Re: [PATCH 08/12] mm/pgtable: add pte_free_defer() for pgtable as
 page
Message-ID: <ZHekpAKJ05cr/GLl@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <739964d-c535-4db4-90ec-2166285b4d47@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739964d-c535-4db4-90ec-2166285b4d47@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 11:23:47PM -0700, Hugh Dickins wrote:
> Add the generic pte_free_defer(), to call pte_free() via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This version
> suits all those architectures which use an unfragmented page for one page
> table (none of whose pte_free()s use the mm arg which was passed to it).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/pgtable.h |  2 ++
>  mm/pgtable-generic.c    | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8b0fc7fdc46f..62a8732d92f0 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -112,6 +112,8 @@ static inline void pte_unmap(pte_t *pte)
>  }
>  #endif
>  
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
> +
>  /* Find an entry in the second-level page table.. */
>  #ifndef pmd_offset
>  static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index d28b63386cef..471697dcb244 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -13,6 +13,7 @@
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
>  #include <linux/mm_inline.h>
> +#include <asm/pgalloc.h>
>  #include <asm/tlb.h>
>  
>  /*
> @@ -230,6 +231,25 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>  	return pmd;
>  }
>  #endif
> +
> +/* arch define pte_free_defer in asm/pgalloc.h for its own implementation */
> +#ifndef pte_free_defer
> +static void pte_free_now(struct rcu_head *head)
> +{
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	pte_free(NULL /* mm not passed and not used */, (pgtable_t)page);
> +}
> +
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	struct page *page;
> +
> +	page = pgtable;
> +	call_rcu(&page->rcu_head, pte_free_now);

People have told me that we can't use the rcu_head on the struct page
backing page table blocks. I understood it was because PPC was using
that memory for something else.

I was hoping Mathew's folio conversion would help clarify this..

On the flip side, if we are able to use rcu_head here then we should
use it everywhere and also use it mmu_gather.c instead of allocating
memory and having the smp_call_function() fallback. This would fix it
to be actual RCU.

There have been a few talks that it sure would be nice if the page
tables were always freed via RCU and every arch just turns on
CONFIG_MMU_GATHER_RCU_TABLE_FREE. It seems to me that patch 10 is kind
of half doing that by making this one path always use RCU on all
arches.

AFAIK the main reason it hasn't been done was the lack of a rcu_head..

Jason
