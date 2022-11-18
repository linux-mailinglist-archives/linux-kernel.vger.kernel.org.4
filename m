Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632362EABF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiKRBLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240833AbiKRBL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:11:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D921CFE0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668733830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bYQPkfNurDnqMfPJBlffYaCbgA2VoHiv3ENn4+XiB7o=;
        b=GlNFgJru5sNi9PMrozkmBdszzYXmYRTE8uD/m28qOcRclP/9mHAYmWitRxrVebFNNzv7c8
        ZDci0NC2/YBxZtNA56TbvJ8+Z/kLxaf69K9Ob8DOx3ThWaKzCj8pe40LHpmq1Fa/B7qysI
        68XXr5IyOdxwHjgfSUiJp6Bojc+P//U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-647-trzBEzsqNIq408A0du8Mhw-1; Thu, 17 Nov 2022 20:10:29 -0500
X-MC-Unique: trzBEzsqNIq408A0du8Mhw-1
Received: by mail-qt1-f198.google.com with SMTP id ew11-20020a05622a514b00b003a524196d31so3403769qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYQPkfNurDnqMfPJBlffYaCbgA2VoHiv3ENn4+XiB7o=;
        b=jXWJbCJn4DE8J5JSj3btxg+G50HoMmN4E4KwwJ2OLv/bMuOPFRx+9a73FRzcve60+V
         nOvPbA4gh7J8n5E4Vre5dztm3Xtso341aj5gN/oE5UhuzKeCW2O+VfB9BUEdvPlv5iX4
         ofAWOIzcK3yr+9R6amwckr07mZAyDgnWV18neXW0GsSJ+53Ii6Wn9JX1X7HbpZqN+YVj
         19zb3FZ7e0c1awWc5qSuSO2qy14+hbKp7dUwjmZtI0llrk2Da1+vlaY2xSZFWMrWGw4B
         l2hE1Y7JWMENo9nMAwHMXRpKD1X9n30ACCXoUEgM8RjDIuSI5st3AaxIQCcari9MYTcT
         EIPw==
X-Gm-Message-State: ANoB5pk+4uX2u2+96XCUjqkv7fsehrTY1LVvgj8IEtW/iCxwMdMuDp+q
        Dm5EfZ5zxQw7S6ZcxXaMt5K1vNjXtwGKhfPUX6ijgNCic60tRBI9fqivEqaRQo3+Ttz1oCZFVbw
        xrg6vl07SW1F2ZPeEH4+w61mi
X-Received: by 2002:ad4:5223:0:b0:4bb:59c1:3dec with SMTP id r3-20020ad45223000000b004bb59c13decmr4926689qvq.39.1668733829139;
        Thu, 17 Nov 2022 17:10:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6tBqdGqowiMujHJsML0L9StU8ix8zKxqShWsBrzFFmO4mXe4FZgt1bxkP0c1tgWyuzWpxagg==
X-Received: by 2002:ad4:5223:0:b0:4bb:59c1:3dec with SMTP id r3-20020ad45223000000b004bb59c13decmr4926671qvq.39.1668733828859;
        Thu, 17 Nov 2022 17:10:28 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006eed75805a2sm1491342qko.126.2022.11.17.17.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:10:28 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Rik van Riel <riel@surriel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        James Houghton <jthoughton@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH RFC v2 00/12] mm/hugetlb: Make huge_pte_offset() thread-safe for pmd unshare
Date:   Thu, 17 Nov 2022 20:10:13 -0500
Message-Id: <20221118011025.2178986-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on latest mm-unstable (96aa38b69507).

This can be seen as a follow-up series to Mike's recent hugetlb vma lock
series for pmd unsharing, so this series also depends on that one.
Hopefully this series can make it a more complete resolution for pmd
unsharing.

PS: so far no one strongly ACKed this, let me keep the RFC tag.  But I
think I'm already more confident than many of the RFCs I posted.

PS2: there're a lot of changes comparing to rfcv1, so I'm just not adding
the changelog.  The whole idea is still the same, though.

Problem
=======

huge_pte_offset() is a major helper used by hugetlb code paths to walk a
hugetlb pgtable.  It's used mostly everywhere since that's needed even
before taking the pgtable lock.

huge_pte_offset() is always called with mmap lock held with either read or
write.

For normal memory types that's far enough, since any pgtable removal
requires mmap write lock (e.g. munmap or mm destructions).  However hugetlb
has the pmd unshare feature, it means not only the pgtable page can be gone
from under us when we're doing a walking, but also the pgtable page we're
walking (even after unshared, in this case it can only be the huge PUD page
which contains 512 huge pmd entries, with the vma VM_SHARED mapped).  It's
possible because even though freeing the pgtable page requires mmap write
lock, it doesn't help us when we're walking on another mm's pgtable, so
it's still on risk even if we're with the current->mm's mmap lock.

The recent work from Mike on vma lock can resolve most of this already.
It's achieved by forbidden pmd unsharing during the lock being taken, so no
further risk of the pgtable page being freed.  It means if we can take the
vma lock around all huge_pte_offset() callers it'll be safe.

There're already a bunch of them that we did as per the latest mm-unstable,
but also quite a few others that we didn't for various reasons.  E.g. it
may not be applicable for not-allow-to-sleep contexts like FOLL_NOWAIT.
Or, huge_pmd_share() is actually a tricky user of huge_pte_offset(),
because even if we took the vma lock, we're walking on another mm's vma!
Taking vma lock for all the vmas are probably not gonna work.

I have totally no report showing that I can trigger such a race, but from
code wise I never see anything that stops the race from happening.  This
series is trying to resolve that problem.

Resolution
==========

What this patch proposed, besides using the vma lock, is that we can also
use other ways to protect the pgtable page from being freed from under us
in huge_pte_offset() context.  The idea is kind of similar to RCU fast-gup.
Note that fast-gup is very safe regarding pmd unsharing even before vma
lock, because fast-gup relies on RCU to protect walking any pgtable page,
including another mm's.  So fast-gup will never hit a freed page even if
pmd sharing is possible.

To apply similar same idea to huge_pte_offset(), it means with proper RCU
protection the pte_t* pointer returned from huge_pte_offset() can also be
always safe to access and de-reference, along with the pgtable lock that
was bound to the pgtable page.  Note that RCU will only work to protect
pgtables if MMU_GATHER_RCU_TABLE_FREE=y.  For the rest we need to disable
irq.  Of course, the whole locking idea is not needed if pmd sharing is not
possible at all, or, on private hugetlb mappings.

Patch Layout
============

Patch 1-3:         cleanup, or dependency of the follow up patches
Patch 4:           the core patch to introduce hugetlb walker lock
Patch 5-11:        each patch resolves one possible race condition
Patch 12:          introduce hugetlb_walk() to replace huge_pte_offset()

Tests
=====

Only lightly tested on hugetlb kselftests including uffd.

Comments welcomed, thanks.

Peter Xu (12):
  mm/hugetlb: Let vma_offset_start() to return start
  mm/hugetlb: Move swap entry handling into vma lock for fault
  mm/hugetlb: Don't wait for migration entry during follow page
  mm/hugetlb: Add pgtable walker lock
  mm/hugetlb: Make userfaultfd_huge_must_wait() safe to pmd unshare
  mm/hugetlb: Protect huge_pmd_share() with walker lock
  mm/hugetlb: Use hugetlb walker lock in hugetlb_follow_page_mask()
  mm/hugetlb: Use hugetlb walker lock in follow_hugetlb_page()
  mm/hugetlb: Use hugetlb walker lock in hugetlb_vma_maps_page()
  mm/hugetlb: Use hugetlb walker lock in walk_hugetlb_range()
  mm/hugetlb: Use hugetlb walker lock in page_vma_mapped_walk()
  mm/hugetlb: Introduce hugetlb_walk()

 arch/s390/mm/gmap.c      |   2 +
 fs/hugetlbfs/inode.c     |  41 +++++++-------
 fs/proc/task_mmu.c       |   2 +
 fs/userfaultfd.c         |  24 ++++++---
 include/linux/hugetlb.h  | 112 +++++++++++++++++++++++++++++++++++++++
 include/linux/pagewalk.h |   9 +++-
 include/linux/rmap.h     |   4 ++
 mm/hugetlb.c             |  97 +++++++++++++++++----------------
 mm/page_vma_mapped.c     |   7 ++-
 mm/pagewalk.c            |   6 +--
 10 files changed, 224 insertions(+), 80 deletions(-)

-- 
2.37.3

