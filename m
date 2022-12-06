Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38A7644A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiLFRoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLFRoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486DE615B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670348596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oayfLbg+4e6JFyZkj40MnFWp6cxM7nCSzst762sbKxw=;
        b=TLCBU8j9pRFzEg7u0slyFKDTC/UYarruIe4jvlamr/rLuud/H/nQNVSiCrmw+sDbO2vH0c
        tGFmC4Zlo6AuPVvkTHS9wH1d8fQIoTaT7U0HtNikill6esdZefQOOqkYnbZyOU0n6CMRRz
        7ZU6q6atJSRi38gyemfYUjH/VPOFSqw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-94-rK3UMTefPe2ju6JBMnptrQ-1; Tue, 06 Dec 2022 12:43:15 -0500
X-MC-Unique: rK3UMTefPe2ju6JBMnptrQ-1
Received: by mail-qt1-f200.google.com with SMTP id fw8-20020a05622a4a8800b003a64f82fe73so35657512qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oayfLbg+4e6JFyZkj40MnFWp6cxM7nCSzst762sbKxw=;
        b=Jkem0Opa+cOlw6a3nwgbhfsltRE/9u6VaJRi21MN+7twb2ziaggzN1mMDBPr4oR+40
         QDCbYYlLkezkoobP7ZNu4bOanUgQTrqOjt7q3kH5nVpSPExK5x3g2o/yUMkbgbHQ11RO
         WuJreANDciiCGbZT0C4PzkBSEFwqZH8w99Up9ftRH/ndqyiyv70JGf1Z2SrrHHX9iFfz
         SzZxpr69sleiM4a1f/cqOTpCMJCXJlDRT82QdFMT4WjZUw3OSjFTu5K4dede181qswGm
         Ao4+c9igB6gvbOtLbLiP7o+QBAZK1Jxq8nYJEa9ot+FTmPFEWvsh3fGYu+0xEw2yE8/J
         F8tQ==
X-Gm-Message-State: ANoB5plXW8NaHL8JKiWdviB8SMhHGxHJ0qlYwxLISBHGo9A64Jn5FnPm
        0JlLlDDNT8tlA8BunsBKLcbtiKOnwehp3UkbQTaPpmc/rqBzG7Zq5oPjv4Wz2qTfDo94QXalqdb
        5bOFs/2rwVb50GpqLSC0BGEh9
X-Received: by 2002:a05:6214:1023:b0:4c6:a1fd:9b25 with SMTP id k3-20020a056214102300b004c6a1fd9b25mr66139229qvr.128.1670348594645;
        Tue, 06 Dec 2022 09:43:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Jw0TTfKXJr084q00xTnBdn0ksQGqBzCGmdwbnxy3yvDHP1mZgwQiGiUC9lRigFIMZkPeyQg==
X-Received: by 2002:a05:6214:1023:b0:4c6:a1fd:9b25 with SMTP id k3-20020a056214102300b004c6a1fd9b25mr66139211qvr.128.1670348594361;
        Tue, 06 Dec 2022 09:43:14 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id x16-20020ac87a90000000b003a5fb681ae7sm11878656qtr.3.2022.12.06.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:43:13 -0800 (PST)
Date:   Tue, 6 Dec 2022 12:43:12 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to
 pmd unshare
Message-ID: <Y49/MPNKib6eDfqk@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <Y46EMlDLCThbrl+E@monkey>
 <Y493aNfcK7n7s1B1@monkey>
 <Y49+aYHTy/UwV7JQ@x1n>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="e5yzZCdrBMEPRle2"
Content-Disposition: inline
In-Reply-To: <Y49+aYHTy/UwV7JQ@x1n>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5yzZCdrBMEPRle2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Dec 06, 2022 at 12:39:53PM -0500, Peter Xu wrote:
> On Tue, Dec 06, 2022 at 09:10:00AM -0800, Mike Kravetz wrote:
> > On 12/05/22 15:52, Mike Kravetz wrote:
> > > On 11/29/22 14:35, Peter Xu wrote:
> > > > Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
> > > > to make sure the pgtable page will not be freed concurrently.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/linux/rmap.h | 4 ++++
> > > >  mm/page_vma_mapped.c | 5 ++++-
> > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > > > index bd3504d11b15..a50d18bb86aa 100644
> > > > --- a/include/linux/rmap.h
> > > > +++ b/include/linux/rmap.h
> > > > @@ -13,6 +13,7 @@
> > > >  #include <linux/highmem.h>
> > > >  #include <linux/pagemap.h>
> > > >  #include <linux/memremap.h>
> > > > +#include <linux/hugetlb.h>
> > > >  
> > > >  /*
> > > >   * The anon_vma heads a list of private "related" vmas, to scan if
> > > > @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
> > > >  		pte_unmap(pvmw->pte);
> > > >  	if (pvmw->ptl)
> > > >  		spin_unlock(pvmw->ptl);
> > > > +	/* This needs to be after unlock of the spinlock */
> > > > +	if (is_vm_hugetlb_page(pvmw->vma))
> > > > +		hugetlb_vma_unlock_read(pvmw->vma);
> > > >  }
> > > >  
> > > >  bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> > > > diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> > > > index 93e13fc17d3c..f94ec78b54ff 100644
> > > > --- a/mm/page_vma_mapped.c
> > > > +++ b/mm/page_vma_mapped.c
> > > > @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> > > >  		if (pvmw->pte)
> > > >  			return not_found(pvmw);
> > > >  
> > > > +		hugetlb_vma_lock_read(vma);
> > > >  		/* when pud is not present, pte will be NULL */
> > > >  		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
> > > > -		if (!pvmw->pte)
> > > > +		if (!pvmw->pte) {
> > > > +			hugetlb_vma_unlock_read(vma);
> > > >  			return false;
> > > > +		}
> > > >  
> > > >  		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
> > > >  		if (!check_pte(pvmw))
> > > 
> > > I think this is going to cause try_to_unmap() to always fail for hugetlb
> > > shared pages.  See try_to_unmap_one:
> > > 
> > > 	while (page_vma_mapped_walk(&pvmw)) {
> > > 		...
> > > 		if (folio_test_hugetlb(folio)) {
> > > 			...
> > > 			/*
> > >                          * To call huge_pmd_unshare, i_mmap_rwsem must be
> > >                          * held in write mode.  Caller needs to explicitly
> > >                          * do this outside rmap routines.
> > >                          *
> > >                          * We also must hold hugetlb vma_lock in write mode.
> > >                          * Lock order dictates acquiring vma_lock BEFORE
> > >                          * i_mmap_rwsem.  We can only try lock here and fail
> > >                          * if unsuccessful.
> > >                          */
> > >                         if (!anon) {
> > >                                 VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> > >                                 if (!hugetlb_vma_trylock_write(vma)) {
> > >                                         page_vma_mapped_walk_done(&pvmw);
> > >                                         ret = false;
> > > 				}
> > > 
> > > 
> > > Can not think of a great solution right now.
> > 
> > Thought of this last night ...
> > 
> > Perhaps we do not need vma_lock in this code path (not sure about all
> > page_vma_mapped_walk calls).  Why?  We already hold i_mmap_rwsem.
> 
> Exactly.  The only concern is when it's not in a rmap.
> 
> I'm actually preparing something that adds a new flag to PVMW, like:
> 
> #define PVMW_HUGETLB_NEEDS_LOCK	(1 << 2)
> 
> But maybe we don't need that at all, since I had a closer look the only
> outliers of not using a rmap is:
> 
> __replace_page
> write_protect_page
> 
> I'm pretty sure ksm doesn't have hugetlb involved, then the other one is
> uprobe (uprobe_write_opcode).  I think it's the same.  If it's true, we can
> simply drop this patch.  Then we also have hugetlb_walk and the lock checks
> there guarantee that we're safe anyways.
> 
> Potentially we can document this fact, which I also attached a comment
> patch just for it to be appended to the end of the patchset.
> 
> Mike, let me know what do you think.
> 
> Andrew, if this patch to be dropped then the last patch may not cleanly
> apply.  Let me know if you want a full repost of the things.

The document patch that can be appended to the end of this series attached.
I referenced hugetlb_walk() so it needs to be the last patch.

-- 
Peter Xu

--e5yzZCdrBMEPRle2
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-hugetlb-Document-why-page_vma_mapped_walk-is-safe.patch"

From 754c2180804e9e86accf131573cbd956b8c62829 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 6 Dec 2022 12:36:04 -0500
Subject: [PATCH] mm/hugetlb: Document why page_vma_mapped_walk() is safe to
 walk
Content-type: text/plain

Taking vma lock here is not needed for now because all potential hugetlb
walkers here should have i_mmap_rwsem held.  Document the fact.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/page_vma_mapped.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index e97b2e23bd28..2e59a0419d22 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -168,8 +168,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 		/* The only possible mapping was handled on last iteration */
 		if (pvmw->pte)
 			return not_found(pvmw);
-
-		/* when pud is not present, pte will be NULL */
+		/*
+		 * NOTE: we don't need explicit lock here to walk the
+		 * hugetlb pgtable because either (1) potential callers of
+		 * hugetlb pvmw currently holds i_mmap_rwsem, or (2) the
+		 * caller will not walk a hugetlb vma (e.g. ksm or uprobe).
+		 * When one day this rule breaks, one will get a warning
+		 * in hugetlb_walk(), and then we'll figure out what to do.
+		 */
 		pvmw->pte = hugetlb_walk(vma, pvmw->address, size);
 		if (!pvmw->pte)
 			return false;
-- 
2.37.3


--e5yzZCdrBMEPRle2--

