Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A8D7401D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjF0RBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjF0RBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:01:17 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD17510F5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:01:13 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765579770f3so3998585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687885273; x=1690477273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGj4zIY05LUVw6x8uPMdw5L+2KzhNBDHJ+ePBOrWYt0=;
        b=fv4aOli3RZQEuSykjh0KPJosM74wknroYSqHFVHSdVChqt5dE0DVgXlrRYmt1CvOnY
         r9QI0fTgfFUWgqXHSsZNrLc1f1ayXFTJny6re162pz73LDYLIDX6x6Nul8W8uuDPtVWR
         xoZkJB0tiNVJUTKpK+B42I9Ds4Qf24HB1E8PYwh06kJrMPtStHsczNkteBBirKb849fq
         SKJQDQJ4TcsB3DjhjpUqZxyJnRgGPJeMW2bpLrpcW54Dv8Mu2lATNH6KyyDAxb5Vfuu4
         oITAc+4BgUG5kzFG16sOvZjbagDHdS79UTpKP1GYZUDMG7cnLhcr7J+U+MeYG16MZmqp
         f/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687885273; x=1690477273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGj4zIY05LUVw6x8uPMdw5L+2KzhNBDHJ+ePBOrWYt0=;
        b=Ly43kVmZbBNlKUPH3vtwQTPjtY17ihEyFR93nZhDvZOs/bN0vmSDosR9xiASUIjAwt
         RssvoVvaeKjQI/+fRC87zGz4YZDWHefiCtAkUWvGc0L4M2FGLVzaTiKCzXBT+zjMnCUN
         D/ixp9LEj5W05SYrtBENAO8RF8aKs01Qrizv28HlYXQ69a7AoqLrzAoE9afoHnUfsHNp
         YI2/cxN4A16HIsbgewM73GjOAxCR1sI6NH3m93v/KWi+UTnj7intzWUVGg9afdRNR1vm
         6eTKU6RZXqhkDzHTkVtEHh5aWJn/OCqpE9Z8fFkkyVZZAXUmhKOncFYqLbh1fKyT/tVS
         W89g==
X-Gm-Message-State: AC+VfDxspZNdEiGF5nxLB8brdRdhBz9bM5nktYd07o+cWvlbUCcFBeHJ
        J1YgXq5/Gk14yWJIt43YzTeVHg==
X-Google-Smtp-Source: ACHHUZ6oaDuFjtrZalcD7+2mNq8I8fqsW/Qlz3+39Q2yb+iaemspbajCtES18RCk5gRY5Hel+BhpGw==
X-Received: by 2002:ad4:5b81:0:b0:616:5755:ca5d with SMTP id 1-20020ad45b81000000b006165755ca5dmr37937429qvp.4.1687885272640;
        Tue, 27 Jun 2023 10:01:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w14-20020a0cef8e000000b0062df95d7ef6sm3777254qvr.115.2023.06.27.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 10:01:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qEC3z-008yOA-DP;
        Tue, 27 Jun 2023 14:01:11 -0300
Date:   Tue, 27 Jun 2023 14:01:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        "David Sc. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 05/12] powerpc: add pte_free_defer() for pgtables
 sharing page
Message-ID: <ZJsV19f41CrfkFYa@ziepe.ca>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
 <5cd9f442-61da-4c3d-eca-b7f44d22aa5f@google.com>
 <ZJGRa4zvsXfc43vB@ziepe.ca>
 <2ad8b6cf-692a-ff89-ecc-586c20c5e07f@google.com>
 <ZJI7xkXWmjrE1yY3@ziepe.ca>
 <c8284d0-91cb-b65e-4c95-bfeb627234f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8284d0-91cb-b65e-4c95-bfeb627234f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 07:36:11PM -0700, Hugh Dickins wrote:
> [PATCH v3 05/12] powerpc: add pte_free_defer() for pgtables sharing page
> 
> Add powerpc-specific pte_free_defer(), to free table page via call_rcu().
> pte_free_defer() will be called inside khugepaged's retract_page_tables()
> loop, where allocating extra memory cannot be relied upon.  This precedes
> the generic version to avoid build breakage from incompatible pgtable_t.
> 
> This is awkward because the struct page contains only one rcu_head, but
> that page may be shared between PTE_FRAG_NR pagetables, each wanting to
> use the rcu_head at the same time.  But powerpc never reuses a fragment
> once it has been freed: so mark the page Active in pte_free_defer(),
> before calling pte_fragment_free() directly; and there call_rcu() to
> pte_free_now() when last fragment is freed and the page is PageActive.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/powerpc/include/asm/pgalloc.h |  4 ++++
>  arch/powerpc/mm/pgtable-frag.c     | 29 ++++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
> index 3360cad78ace..3a971e2a8c73 100644
> --- a/arch/powerpc/include/asm/pgalloc.h
> +++ b/arch/powerpc/include/asm/pgalloc.h
> @@ -45,6 +45,10 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
>  	pte_fragment_free((unsigned long *)ptepage, 0);
>  }
>  
> +/* arch use pte_free_defer() implementation in arch/powerpc/mm/pgtable-frag.c */
> +#define pte_free_defer pte_free_defer
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
> +
>  /*
>   * Functions that deal with pagetables that could be at any level of
>   * the table need to be passed an "index_size" so they know how to
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index 20652daa1d7e..0c6b68130025 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -106,6 +106,15 @@ pte_t *pte_fragment_alloc(struct mm_struct *mm, int kernel)
>  	return __alloc_for_ptecache(mm, kernel);
>  }
>  
> +static void pte_free_now(struct rcu_head *head)
> +{
> +	struct page *page;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	pgtable_pte_page_dtor(page);
> +	__free_page(page);
> +}
> +
>  void pte_fragment_free(unsigned long *table, int kernel)
>  {
>  	struct page *page = virt_to_page(table);
> @@ -115,8 +124,22 @@ void pte_fragment_free(unsigned long *table, int kernel)
>  
>  	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
>  	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> -		if (!kernel)
> -			pgtable_pte_page_dtor(page);
> -		__free_page(page);
> +		if (kernel)
> +			__free_page(page);
> +		else if (TestClearPageActive(page))
> +			call_rcu(&page->rcu_head, pte_free_now);
> +		else
> +			pte_free_now(&page->rcu_head);
>  	}
>  }
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
> +{
> +	struct page *page;
> +
> +	page = virt_to_page(pgtable);
> +	SetPageActive(page);
> +	pte_fragment_free((unsigned long *)pgtable, 0);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */

Yes, this makes sense to me, very simple..

I always for get these details but atomic_dec_and_test() is a release?
So the SetPageActive is guarenteed to be visible in another thread
that reaches 0?

Thanks,
Jason
