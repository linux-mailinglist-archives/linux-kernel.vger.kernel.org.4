Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86966116BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiJ1QB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJ1QAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000311FAE5F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666972685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZ6yJrsNWaZL1mSi1+tvHOq5SMXsifQHw4WS6aiyzU0=;
        b=Ya/Bijd20rDHfN11ofEH9jYNLP7V+JMaPvQcYJcZN/YaPxngGC8DjpV2sfq2gd7/P/QUDr
        U36KVtUDxdQe9HkvROz/qVta1wOonlaGQH5ZXhpqLPMi1XrPctEN3uxAltvYyPaM4JM1kZ
        LAECNDRWmugROrLKlc8DIWpg3Xo4l5Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-MbXHYBhoNqOlm64FZqx2BQ-1; Fri, 28 Oct 2022 11:58:02 -0400
X-MC-Unique: MbXHYBhoNqOlm64FZqx2BQ-1
Received: by mail-qk1-f200.google.com with SMTP id q14-20020a05620a0d8e00b006ef0350dae1so3984768qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 08:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ6yJrsNWaZL1mSi1+tvHOq5SMXsifQHw4WS6aiyzU0=;
        b=4hvnnMW7S0K2CwP3tStKw0ZRMMfhyg6vo5ynwb6amWO7EUud+N0l5oi7DtxRwR4IOZ
         NQeXkq4i28mv2Poj6GWm9LkEUlkpP8K8a44LtB3Yz4m/h60uUjsDCYhnvo2yL2fRwAxp
         w/EKJl/jp7wwtdcpa/+Clmp1UPIyF9mlb/Jfp50EyR8knjeB1DIo7OIAZkMRBaAYJ+wy
         ghZ2c1Ec0ENEP+yj7PSnLgiLKWh3E4+uuw+BL9+GOUpKJJkxUYrIlmZPeCV1KpkVbnrZ
         Bulz7bcSw+VV9XUpS/e/TFGFdRMQ1qxoOwcS1az/nfJ4zQiEc7Pw7quttA92nbP27kU6
         rguw==
X-Gm-Message-State: ACrzQf2RXXjlUEzfVbrGf09J18AlWqb/V1DhdbwJFJgtzjNAnFzkDwQ3
        UnjOySQTc0xzbrwamlunbT7SYxhikIkfa2at6CNSm89nd9o+VdFm4pe8uzYyokWMoPZ56hkLHPs
        trAFLspfc37opfT22GALaiVyj
X-Received: by 2002:a05:620a:298a:b0:6ee:e31f:6247 with SMTP id r10-20020a05620a298a00b006eee31f6247mr37888890qkp.744.1666972681959;
        Fri, 28 Oct 2022 08:58:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zikpCggckW3kZmG1QOaNP6E0NjoUZTCfDs/eJV24ipKqDVWXHGGzTxuDAUamvi+z0+bbMXQ==
X-Received: by 2002:a05:620a:298a:b0:6ee:e31f:6247 with SMTP id r10-20020a05620a298a00b006eee31f6247mr37888868qkp.744.1666972681621;
        Fri, 28 Oct 2022 08:58:01 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id e12-20020a37ac0c000000b006e9b3096482sm3096362qkm.64.2022.10.28.08.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 08:58:00 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:57:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] hugetlb: simplify hugetlb handling in follow_page_mask
Message-ID: <Y1v8B/6QYwt5hUgU@x1n>
References: <20220919021348.22151-1-mike.kravetz@oracle.com>
 <Y1mtz7dFAlhGRsAd@x1n>
 <Y1nR/KToV44GKZ5G@monkey>
 <Y1rdVLMDD4PMt3s3@x1n>
 <Y1v0/Y4Xiut2FWx4@monkey>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oZ7pR8BiPAaKWB7x"
Content-Disposition: inline
In-Reply-To: <Y1v0/Y4Xiut2FWx4@monkey>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oZ7pR8BiPAaKWB7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Oct 28, 2022 at 08:27:57AM -0700, Mike Kravetz wrote:
> On 10/27/22 15:34, Peter Xu wrote:
> > On Wed, Oct 26, 2022 at 05:34:04PM -0700, Mike Kravetz wrote:
> > > On 10/26/22 17:59, Peter Xu wrote:
> > 
> > If we want to use the vma read lock to protect here as the slow gup path,
> > then please check again with below [1] - I think we'll also need to protect
> > it with fast-gup (probably with trylock only, because fast-gup cannot
> > sleep) or it'll encounter the same race, iiuc.
> > 
> > Actually, instead of using vma lock, I really think this is another problem
> > and needs standalone fixing.  The problem is we allows huge_pte_offset() to
> > walk the process pgtable without any protection, while pmd unsharing can
> > drop a page anytime.  huge_pte_offset() is always facing use-after-free
> > when walking the PUD page.
> > 
> > We may want RCU lock to protect the pgtable pages from getting away when
> > huge_pte_offset() is walking it, it'll be safe then because pgtable pages
> > are released in RCU fashion only (e.g. in above example, process [2] will
> > munmap() and release the last ref to the "used to be shared" pmd and the
> > PUD that maps the shared pmds will be released only after a RCU grace
> > period), and afaict that's also what's protecting fast-gup from accessing
> > freed pgtable pages.
> > 
> > If with all huge_pte_offset() callers becoming RCU-safe, then IIUC we can
> > drop the vma lock in all GUP code, aka, in hugetlb_follow_page_mask() here,
> > because both slow and fast gup should be safe too in the same manner.
> > 
> > Thanks,
> > 
> > > > IIUC it's also the same as fast-gup - afaiu we don't take the read vma lock
> > > > in fast-gup too but I also think it's safe.  But I hope I didn't miss
> > > > something.
> > 
> > [1]
> 
> Thanks Peter!  I think the best thing would be to eliminate the vma_lock
> calls in this patch.  The code it is replacing/simplifying does not do any
> locking, so no real regression.

Agreed.

> 
> I think a scheme like you describe above is going to require some more
> thought/work.  It might be better as a follow on patch.

So above is only a thought, but if you think it's so far not very wrong and
worth trying, I can see what I can get from it by some upcoming patches.

It shouldn't need a lot of change, but basically looking after all
huge_pte_offset() to make sure they're safe regarding walking the PUD.  I'm
attaching an initial patch to just start to comment on the usage of
huge_pte_offset() first because that'll be the gust of the upcoming
patchset (if there'll be), further comments welcomed too.  Thanks.

-- 
Peter Xu

--oZ7pR8BiPAaKWB7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-hugetlb-Comment-huge_pte_offset-for-its-locking-r.patch"

From 186c56026ce8ccc555d3c7ebc0e7e8fd76e9e5c9 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 27 Oct 2022 17:41:11 -0400
Subject: [PATCH] mm/hugetlb: Comment huge_pte_offset() for its locking
 requirements
Content-type: text/plain

huge_pte_offset() is potentially a pgtable walker, looking up pte_t* for a
hugetlb address.

Normally, it's always safe to walk the pgtable as long as we're with the
mmap lock held for either read or write, because that guarantees the
pgtable pages will always be valid during the process.

But it's not true for hugetlbfs: hugetlbfs has the pmd sharing feature, it
means that even with mmap lock held, the PUD pgtable page can still go away
from under us if pmd unsharing is possible during the walk.

It's not always the case, e.g.:

  (1) If the mapping is private we're not prone to pmd sharing or
      unsharing, so it's okay.

  (2) If we're with the hugetlb vma lock held for either read/write, it's
      okay too because pmd unshare cannot happen at all.

Document all these explicitly for huge_pte_offset(), because it's really
not that obvious.  This also tells all the callers on what it needs to
guarantee huge_pte_offset() thread-safety.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm64/mm/hugetlbpage.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 35e9a468d13e..90f084643718 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -329,6 +329,35 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 	return ptep;
 }
 
+/*
+ * huge_pte_offset(): Walk the hugetlb pgtable until the last level PTE.
+ * Returns the pte_t* if found, or NULL if the address is not mapped.
+ *
+ * NOTE: since this function will walk all the pgtable pages (including not
+ * only normal pgtable page, but also PUD that can be unshared concurrently
+ * for VM_SHARED), the caller of this function should be responsible of its
+ * thread safety.  One can follow this rule:
+ *
+ *  (1) For private mappings: pmd unsharing is not possible, so it'll
+ *      always be safe if we're with the mmap sem for either read or write.
+ *      This is normally always the case, so IOW we don't need to do
+ *      anything special.
+ *
+ *  (2) For shared mappings: pmd unsharing is possible (so PUD page can go
+ *      away from under us!  It can be done by a pmd unshare with a follow
+ *      up munmap() on the other process), then we need either:
+ *
+ *     (2.1) hugetlb vma lock read or write held, to make sure pmd unshare
+ *           won't happen upon the range, or,
+ *
+ *     (2.2) RCU read lock, to make sure even pmd unsharing happened, the
+ *           old shared PUD page won't get freed from under us, so even of
+ *           the pte_t* can be obsolete, at least it's still always safe to
+ *           access the PUD page.
+ *
+ * PS: from the regard of (2.2), it's the same logic of fast-gup being safe
+ * for generic mm, as long as RCU is used to free any pgtable page.
+ */
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz)
 {
-- 
2.37.3


--oZ7pR8BiPAaKWB7x--

