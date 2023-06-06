Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91E7724C40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbjFFTFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbjFFTEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B52101
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686078218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bmPwhcLQLS6QAOJhnaZRrlptzdg2mUtfNMjjPY6LfS8=;
        b=AFuQrzjWZt9DInEY1lFNe2Dkl2jWUeOnZvEx5qHaeGepugKSmH3uiA6RXeZM6tL2ddVh48
        DmlcdnHCQCHqUaJaJTJi4xa7fyWwzBuf0roPU+B8OJVu5y5PjQqcZGmW0Z02eAWTJ5Qn2d
        evCVBAC6WjTzbhU7/EYtMPaLsJ+bbMg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-EnKZds2HNkKzgAAM0aaO7w-1; Tue, 06 Jun 2023 15:03:37 -0400
X-MC-Unique: EnKZds2HNkKzgAAM0aaO7w-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-75b147a2548so130958785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078216; x=1688670216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmPwhcLQLS6QAOJhnaZRrlptzdg2mUtfNMjjPY6LfS8=;
        b=ARc3L2qIBS9UPxj9i7DN76YB8LM7hQZHNukqyG78+12PfrRPQRzkPJpNZToP4oR6XD
         f6fOcH5WiIOC4fGJcGNuyJWtrysQVE/pyBlQ3l7VF/DeVFRDOJlD5JBh7Ka/38xPpaJF
         e0dv5nUIc6e/I1dXY5xqSYsVnjlhOpJ9FRWsUx4Ag2r4JitpZsn1Muei7PAvAwIMmBvp
         QioHRlxkg3dFZvDvFuU4EATSFMdJcWHId8oIryy6PFQ6HcW9TD1zIXv2SbTiOIDAHwaH
         XU/vMOh8TwPzv0QayH63vZ7lCZ7WZ6AiLZxwtPurnVx9tEH7eNfafrJZ2ASaHg1w65TG
         Fykg==
X-Gm-Message-State: AC+VfDw17alNPiAfM2ZBhbcPTF1CrmzzZ9zxDW+kN/DiumiCF+uAErrj
        rIaVutA0avAq7fplZnS8kJn9zMTTs6AxS8pg1GsSudK0GNITACcD1KEz8RUpL2J99zDyqDikMuT
        VQUqqTrVrBXLo4yGqq9m3RFH7
X-Received: by 2002:a05:620a:2b92:b0:75b:23a1:69f0 with SMTP id dz18-20020a05620a2b9200b0075b23a169f0mr3107605qkb.7.1686078216680;
        Tue, 06 Jun 2023 12:03:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C5YMccZA+iUS9RAssWOgobvDgS7+Te3WrU+7dZkM3FviCtXVqQlWbzikNWhoOiLhOPK8t2g==
X-Received: by 2002:a05:620a:2b92:b0:75b:23a1:69f0 with SMTP id dz18-20020a05620a2b9200b0075b23a169f0mr3107557qkb.7.1686078216403;
        Tue, 06 Jun 2023 12:03:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b0074636e35405sm5100311qko.65.2023.06.06.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:03:35 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:03:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
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
Message-ID: <ZH+DAxLhIYpTlIFc@x1n>
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com>
 <28eb289f-ea2c-8eb9-63bb-9f7d7b9ccc11@google.com>
 <ZHSwWgLWaEd+zi/g@casper.infradead.org>
 <ZHn6n5eVTsr4Wl8x@ziepe.ca>
 <4df4909f-f5dd-6f94-9792-8f2949f542b3@google.com>
 <ZH95oobIqN0WO5MK@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH95oobIqN0WO5MK@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 03:23:30PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 05, 2023 at 08:40:01PM -0700, Hugh Dickins wrote:
> 
> > diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> > index 20652daa1d7e..e4f58c5fc2ac 100644
> > --- a/arch/powerpc/mm/pgtable-frag.c
> > +++ b/arch/powerpc/mm/pgtable-frag.c
> > @@ -120,3 +120,54 @@ void pte_fragment_free(unsigned long *table, int kernel)
> >  		__free_page(page);
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +#define PTE_FREE_DEFERRED 0x10000 /* beyond any PTE_FRAG_NR */
> > +
> > +static void pte_free_now(struct rcu_head *head)
> > +{
> > +	struct page *page;
> > +	int refcount;
> > +
> > +	page = container_of(head, struct page, rcu_head);
> > +	refcount = atomic_sub_return(PTE_FREE_DEFERRED - 1,
> > +				     &page->pt_frag_refcount);
> > +	if (refcount < PTE_FREE_DEFERRED) {
> > +		pte_fragment_free((unsigned long *)page_address(page), 0);
> > +		return;
> > +	}
> 
> From what I can tell power doesn't recycle the sub fragment into any
> kind of free list. It just waits for the last fragment to be unused
> and then frees the whole page.
> 
> So why not simply go into pte_fragment_free() and do the call_rcu directly:
> 
> 	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> 	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> 		if (!kernel)
> 			pgtable_pte_page_dtor(page);
> 		call_rcu(&page->rcu_head, free_page_rcu)

We need to be careful on the lock being freed in pgtable_pte_page_dtor(),
in Hugh's series IIUC we need the spinlock being there for the rcu section
alongside the page itself.  So even if to do so we'll need to also rcu call 
pgtable_pte_page_dtor() when needed.

-- 
Peter Xu

