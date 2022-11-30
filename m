Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4706263DAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiK3Qdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiK3Qdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8976D59846
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669825974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPcvPQVr4weLKAr6q7VaroYaObRW2ngmffd73YEX68o=;
        b=QhPJf9vHw4GqdYeYjUwz24bndRi0caxQ3VHPOQYwkY/qB4gXTfuDHkW5MXCp+PNdXDP8oN
        trz0J5tWqkSpLFZuQkIKcYs+pGtHgTGuc8xGAqvTAWjtKRTEGHi80qPVI7xbbVBTQTt4R2
        seUQFuv1OCueVZt55gmNTCu6sIhkQMQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-KLI8d-YoOwSSYPmN5wY5cA-1; Wed, 30 Nov 2022 11:32:46 -0500
X-MC-Unique: KLI8d-YoOwSSYPmN5wY5cA-1
Received: by mail-qk1-f199.google.com with SMTP id bs7-20020a05620a470700b006fac7447b1cso40374184qkb.17
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPcvPQVr4weLKAr6q7VaroYaObRW2ngmffd73YEX68o=;
        b=Y7X6fY1csiAND3cUa4yHZePjYhwVg9q+m/9rtCAFfnVsCiV3fAVbi7vZsm7M320AN6
         Q021LEA722eU0qB8yDbDtw4zKvm+u2rCLwBFFIC+MxW+FpS2stctbB6trHpVzM32+zki
         qxcWPo8Ze81w7z+PuIvlcbZRrmXvkj3/YxxpkmpZIBxd1U5jBedgAaG6cT4wqongXJWJ
         QZ1YH2aacsc9xcSX7RM6bNpcfBa4EC/dzTCkrKpIHt3ticGh0JSNJ63RXFuoQNGoFmgq
         8NKmnzt1NMnzuLqUEu7cUoF5hlT2O1xhbTydwXUAiYO51Uj9lBKvffqRvGvU6TgOJsbX
         N0Ow==
X-Gm-Message-State: ANoB5pnO0awWZUkR7az1Egw82o0WNOk0UXWBSbOyzD3JhMsLj1y6Ob8e
        6eY5RrVwnt+GRs1pOiGPtG173CZe8wz1ZqHPjb95rbx3T5xWLeT0cEMBhhUsXOnMqOSsDnG4oat
        FXzPbQlZyr+Q7W9/uqYNHmauX
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id g10-20020ad457aa000000b004c6f83c4741mr18462081qvx.11.1669825965618;
        Wed, 30 Nov 2022 08:32:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OTDU7sg0vb7bB/qBN5gRbWQFZmztceG2kv0aCOtIr3ntCqKG4C9sJ/64sHha1ykbVVxPo0g==
X-Received: by 2002:ad4:57aa:0:b0:4c6:f83c:4741 with SMTP id g10-20020ad457aa000000b004c6f83c4741mr18462056qvx.11.1669825965375;
        Wed, 30 Nov 2022 08:32:45 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id j30-20020ac84c9e000000b0039467aadeb8sm1082154qtv.13.2022.11.30.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 08:32:44 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:32:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y4eFq4ZyQ2xHaISy@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <65a3a912-3534-6718-2c55-e0d4b5246f1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65a3a912-3534-6718-2c55-e0d4b5246f1e@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 05:18:45PM +0100, David Hildenbrand wrote:
> On 29.11.22 20:35, Peter Xu wrote:
> > Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> > to make sure the pgtable page will not be freed concurrently.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/rmap.h | 4 ++++
> >   mm/page_vma_mapped.c | 5 ++++-
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index bd3504d11b15..a50d18bb86aa 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -13,6 +13,7 @@
> >   #include <linux/highmem.h>
> >   #include <linux/pagemap.h>
> >   #include <linux/memremap.h>
> > +#include <linux/hugetlb.h>
> >   /*
> >    * The anon_vma heads a list of private "related" vmas, to scan if
> > @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
> >   		pte_unmap(pvmw->pte);
> >   	if (pvmw->ptl)
> >   		spin_unlock(pvmw->ptl);
> > +	/* This needs to be after unlock of the spinlock */
> > +	if (is_vm_hugetlb_page(pvmw->vma))
> > +		hugetlb_vma_unlock_read(pvmw->vma);
> >   }
> >   bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > index 93e13fc17d3c..f94ec78b54ff 100644
> > --- a/mm/page_vma_mapped.c
> > +++ b/mm/page_vma_mapped.c
> > @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >   		if (pvmw->pte)
> >   			return not_found(pvmw);
> > +		hugetlb_vma_lock_read(vma);
> >   		/* when pud is not present, pte will be NULL */
> >   		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> > -		if (!pvmw->pte)
> > +		if (!pvmw->pte) {
> > +			hugetlb_vma_unlock_read(vma);
> >   			return false;
> > +		}
> >   		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> >   		if (!check_pte(pvmw))
> 
> Looking at code like  mm/damon/paddr.c:__damon_pa_mkold() and reading the
> doc of page_vma_mapped_walk(), this might be broken.
> 
> Can't we get page_vma_mapped_walk() called multiple times?

Yes it normally can, but not for hugetlbfs?  Feel free to check:

	if (unlikely(is_vm_hugetlb_page(vma))) {
                ...
		/* The only possible mapping was handled on last iteration */
		if (pvmw->pte)
			return not_found(pvmw);
        }

> Wouldn't we have to remember that we already took the lock to not lock
> twice, and to see if we really have to unlock in
> page_vma_mapped_walk_done() ?

-- 
Peter Xu

