Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB58724B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbjFFSYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjFFSYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:24:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040B1FE9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:23:37 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-62884fa0e53so38156856d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1686075812; x=1688667812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRK8iTgMb5TScoKA9P/J+NjKmgAke6TT3GAMczOWAY4=;
        b=jPTtD7S91r09g5GZ5enOvX5p1h2bE1pdqCLmsV5LGnWj/qXlaFjTKr8u0jEgv/8EJa
         hY4FdwIqOIk7kTUaBc7VFbHJ+am4ZQIgpqa0l/+TL8DzoNdAIe62OPQVQ4ra11vVpelk
         DoqXX3ISlkm0edxF8e7WCTJSKm1Ipzzf3dQhhjoYWQ+naJIg49ZDRYNQH9PkIULo4N/q
         q0XGCvK12HESNzBwtCGHKf5j7mgSphBf2k76g+ZYrWGEJkNVJi15JYjsMZWJ6iplKlfX
         evTLvuaVNlMPAeqT4m1wTzu2PYZ1Ez+MjP+uRqkV2x2SNfBLoSWj6/MhrLMSfsLM4C27
         YAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686075812; x=1688667812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRK8iTgMb5TScoKA9P/J+NjKmgAke6TT3GAMczOWAY4=;
        b=PneJxD9xiqTktr4eJnyj14yHV/0zORqOS/D/zySRBmJxbokUwvO/efUSgTj+pL5AED
         9EvINygvR1uU08L+fFit9XXGsrK618158RULiej+MVyXL6JJF3aujZvjEIRpWVH2YhCg
         vAoi7Dy4g8aVGmFnIXAz+o3f5uvDLbwAy1/bVOR8dYQDJ3ig8j01fb1eWLu9KhsGJ1TW
         din/9mbRPLeklOaGS52Tjf4WFO2V16/NXvn6j1jwXqL9hOs77xrGORzbTCeszeZq/1x9
         aY4WZ7VwMP95SY1izFzoPppwvHsnVIqjxSCFRRajPlpyocV7yLJL5J23T/UCd319h8kj
         Dfrw==
X-Gm-Message-State: AC+VfDwjYtLZsRUb6y3oYi6DBMnRQ3MmNw5TngJjCyoHJWuN9KgHMCtp
        3G9IPZK4xGkjdAVD/GYUP1AXlQ==
X-Google-Smtp-Source: ACHHUZ5YVdCH5/dS9hodEJr36EZ44XO5GEyKgrVSvJAfG4M8kimdM0r3/RKcMebdOYHUsIqUASQktw==
X-Received: by 2002:a05:6214:124d:b0:62b:4e7e:8aba with SMTP id r13-20020a056214124d00b0062b4e7e8abamr366606qvv.60.1686075811887;
        Tue, 06 Jun 2023 11:23:31 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id ff24-20020a05622a4d9800b003f9baa693c7sm26279qtb.10.2023.06.06.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:23:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1q6bL8-0030Xz-9V;
        Tue, 06 Jun 2023 15:23:30 -0300
Date:   Tue, 6 Jun 2023 15:23:30 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH 05/12] powerpc: add pte_free_defer() for pgtables sharing
 page
Message-ID: <ZH95oobIqN0WO5MK@ziepe.ca>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
 <ZHSwWgLWaEd+zi/g@casper.infradead.org>
 <ZHn6n5eVTsr4Wl8x@ziepe.ca>
 <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:40:01PM -0700, Hugh Dickins wrote:

> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> index 20652daa1d7e..e4f58c5fc2ac 100644
> --- a/arch/powerpc/mm/pgtable-frag.c
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
>  		__free_page(page);
>  	}
>  }
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
> +
> +static void pte_free_now(struct rcu_head *head)
> +{
> +	struct page *page;
> +	int refcount;
> +
> +	page = container_of(head, struct page, rcu_head);
> +	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
> +				     &page->pt_frag_refcount);
> +	if (refcount < PTE_FREE_DEFERRED) {
> +		pte_fragment_free((unsigned long *)page_address(page), 0);
> +		return;
> +	}

From what I can tell power doesn't recycle the sub fragment into any
kind of free list. It just waits for the last fragment to be unused
and then frees the whole page.

So why not simply go into pte_fragment_free() and do the call_rcu directly:

	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
		if (!kernel)
			pgtable_pte_page_dtor(page);
		call_rcu(&page->rcu_head, free_page_rcu)

?

Jason
