Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7464499C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiLFQqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLFQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C2DC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670345113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGJNwjSQdeRAlEiXt/3sKWgpYttrjAgrALTa09hqIwM=;
        b=ZaKXROkaY8oyDe15/cwqGrRjxqoLCWPW7rJnqf00S1dUpeKMaZS9N86oGjb91QmCkTmIfP
        J+tKM5lmLn30nSNYcrgqsgsaarne/T9NDwxGYQ0xxdSaam3c7ov0h4ZgFG4rVQRO4Yhhcg
        I+w7V4NmlCx5h0GMaoimGgBM4P1IMHE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-f8tfei9tP3uuR3BzEuetWw-1; Tue, 06 Dec 2022 11:45:11 -0500
X-MC-Unique: f8tfei9tP3uuR3BzEuetWw-1
Received: by mail-qk1-f200.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so21408805qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGJNwjSQdeRAlEiXt/3sKWgpYttrjAgrALTa09hqIwM=;
        b=PPYJ9nGEZpKJ4OJPnoe1M2/brQGwtN0GQllhMDZ5XUEts+Gdi8RZSyXuuMoO+HYtR8
         0/wwP2mBuY6QGuMyFKTR/o23CGpVNh07oscPQexgqTRtVz/B6ZCJg7a613tlF78NfGYF
         IfLAQ1/Enu6fu78CKi8CPI6bWGR+n9Jcrx6KpE+LuptU9Yz66ov5OdPddTkEfaknDcM6
         qUC8Pll+edgRRc7LaqyLKP4o/w27mTAJ1wc/GH5P3FHrml15PdOlpfarcqwqXdMsvwTl
         2Iaf03px98Rxm3Kq0VBjLNN78gf8uvYWzp6uYH3gbfrFfY/3eCgBNTAs0V1B7AZ4VbdF
         mUeg==
X-Gm-Message-State: ANoB5pkshLeIxI4kFSIeQmeJjL37mRimc8u4mdsI7tFlVWvL9v3bbF4r
        WH3MfClxaL+M1M+70Bf4E0dzSZKNUD8Hy8ZvniupiX8vaE/Yv2PngKU2OnZYwzrMrBx8pVpArLo
        d6eNmofMwisMfQ1MWmguRHvJQ
X-Received: by 2002:a05:620a:cd6:b0:6f7:65f6:aa2f with SMTP id b22-20020a05620a0cd600b006f765f6aa2fmr78311446qkj.222.1670345111220;
        Tue, 06 Dec 2022 08:45:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5DoG5RWviRB0g1HJxDXe2nwn1oXotvYwJiCC0N8Ev697tK/Ud3FJ0dCWA81BRR1fDOwRiFtw==
X-Received: by 2002:a05:620a:cd6:b0:6f7:65f6:aa2f with SMTP id b22-20020a05620a0cd600b006f765f6aa2fmr78311432qkj.222.1670345110935;
        Tue, 06 Dec 2022 08:45:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id i21-20020a05620a405500b006f8665f483fsm15824483qko.85.2022.12.06.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:45:10 -0800 (PST)
Date:   Tue, 6 Dec 2022 11:45:09 -0500
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Message-ID: <Y49xlV8I2/92Flha@x1n>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-9-peterx@redhat.com>
 <Y45/5ezH6uwn7Cfy@monkey>
 <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cAL/YfRa6VIe+3z7"
Content-Disposition: inline
In-Reply-To: <0813b9ed-3c92-088c-4fb9-45fb648c6e73@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cAL/YfRa6VIe+3z7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Dec 05, 2022 at 03:52:51PM -0800, John Hubbard wrote:
> On 12/5/22 15:33, Mike Kravetz wrote:
> > On 11/29/22 14:35, Peter Xu wrote:
> > > Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> > > to make sure the pgtable page will not be freed concurrently.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >   mm/pagewalk.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> > > index 7f1c9b274906..d98564a7be57 100644
> > > --- a/mm/pagewalk.c
> > > +++ b/mm/pagewalk.c
> > > @@ -302,6 +302,7 @@ static int walk_hugetlb_range(unsigned long addr, unsigned long end,
> > >   	const struct mm_walk_ops *ops = walk->ops;
> > >   	int err = 0;
> > > +	hugetlb_vma_lock_read(vma);
> > >   	do {
> > >   		next = hugetlb_entry_end(h, addr, end);
> > >   		pte = huge_pte_offset(walk->mm, addr & hmask, sz);
> > 
> > For each found pte, we will be calling mm_walk_ops->hugetlb_entry() with
> > the vma_lock held.  I looked into the various hugetlb_entry routines, and
> > I am not sure about hmm_vma_walk_hugetlb_entry.  It seems like it could
> > possibly call hmm_vma_fault -> handle_mm_fault -> hugetlb_fault.  If this
> > can happen, then we may have an issue as hugetlb_fault will also need to
> > acquire the vma_lock in read mode.

Thanks for spotting that, Mike.

I used to notice that path special but that's when I was still using RCU
locks who doesn't have the issue.  Then I overlooked this one when
switchover.

> > 
> > I do not know the hmm code well enough to know if this may be an actual
> > issue?
> 
> Oh, this sounds like a serious concern. If we add a new lock, and hold it
> during callbacks that also need to take it, that's not going to work out,
> right?
> 
> And yes, hmm_range_fault() and related things do a good job of revealing
> this kind of deadlock. :)

I've got a fixup attached.  John, since this got your attention please also
have a look too in case there's further issues.

Thanks,

-- 
Peter Xu

--cAL/YfRa6VIe+3z7
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-mm-hugetlb-Make-walk_hugetlb_range-safe-to-pmd.patch"

From 9ad1e65a31f51a0dc687cd9d6083b9e920d2da61 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 6 Dec 2022 11:38:47 -0500
Subject: [PATCH] fixup! mm/hugetlb: Make walk_hugetlb_range() safe to pmd
 unshare
Content-type: text/plain

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/gmap.c      | 2 ++
 fs/proc/task_mmu.c       | 2 ++
 include/linux/pagewalk.h | 8 +++++++-
 mm/hmm.c                 | 8 +++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8947451ae021..292a54c490d4 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
 	set_bit(PG_arch_1, &page->flags);
+	hugetlb_vma_unlock_read(walk->vma);
 	cond_resched();
+	hugetlb_vma_lock_read(walk->vma);
 	return 0;
 }
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 89338950afd3..d7155f3bb678 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1612,7 +1612,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
 			frame++;
 	}
 
+	hugetlb_vma_unlock_read(walk->vma);
 	cond_resched();
+	hugetlb_vma_lock_read(walk->vma);
 
 	return err;
 }
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 959f52e5867d..1f7c2011f6cb 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -21,7 +21,13 @@ struct mm_walk;
  *			depth is -1 if not known, 0:PGD, 1:P4D, 2:PUD, 3:PMD.
  *			Any folded depths (where PTRS_PER_P?D is equal to 1)
  *			are skipped.
- * @hugetlb_entry:	if set, called for each hugetlb entry
+ * @hugetlb_entry:	if set, called for each hugetlb entry.	Note that
+ *			currently the hook function is protected by hugetlb
+ *			vma lock to make sure pte_t* and the spinlock is valid
+ *			to access.  If the hook function needs to yield the
+ *			thread or retake the vma lock for some reason, it
+ *			needs to properly release the vma lock manually,
+ *			and retake it before the function returns.
  * @test_walk:		caller specific callback function to determine whether
  *			we walk over the current vma or not. Returning 0 means
  *			"do page table walk over the current vma", returning
diff --git a/mm/hmm.c b/mm/hmm.c
index 3850fb625dda..dcd624f28bcf 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -493,8 +493,14 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	required_fault =
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
+		int ret;
+
 		spin_unlock(ptl);
-		return hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_unlock_read(vma);
+		/* hmm_vma_fault() can retake the vma lock */
+		ret = hmm_vma_fault(addr, end, required_fault, walk);
+		hugetlb_vma_lock_read(vma);
+		return ret;
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
-- 
2.37.3


--cAL/YfRa6VIe+3z7--

