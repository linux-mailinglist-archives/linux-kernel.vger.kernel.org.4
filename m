Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3222612CFB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 22:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3Vae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ3Vac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 17:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6065A18A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667165375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yGU8owWMZGuxGXrsN8bO4qgKTaN6U0bELfBGUQoRFws=;
        b=HEa+TNVYVS82sjikV1G1a8TOBkvIxm5zx+yHPkR9A52IgPEiFPb2TPFfI3+vyb/M/2zVmB
        3S50YadQnHsG43No4v97W/QB/XYS7Sn5kpD10GcHEHbsoRyQZolZL0Tjfde6pZr0SAvqKB
        iL8DC93ppskRgJ9JUr7w2h1LeeGlVFc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-217-H-Mini06OlufQbCPKExkYA-1; Sun, 30 Oct 2022 17:29:34 -0400
X-MC-Unique: H-Mini06OlufQbCPKExkYA-1
Received: by mail-qt1-f199.google.com with SMTP id gd8-20020a05622a5c0800b0039cb77202eeso6515443qtb.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 14:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGU8owWMZGuxGXrsN8bO4qgKTaN6U0bELfBGUQoRFws=;
        b=yNvNFJi8cV4f7MuPr7EsugpxPiN+U/pONrVS9t978UlKSpQWmGyDq7s10fnEX04q9d
         xnBpCT/kNTsVx1vE13oihqIoa4uv2JsKte0SMseUCgxkC3F/Lap6JwVKLY4XLzLALJua
         KvplORYzFTfGg0/PxdBeHP4U5ir3ma0Vdk4U3Y4FW6zh1uXI16XGvmCJYHjJowZ1xW8C
         9Jm4Brb3IIwA8lQotAAuFTTqeHlWBxcw0+PS6DkgghpLbUWEpTkFktPNXzKykaxWugdb
         pg8yEE4SNLu8TK6d1R9EkzlYZtR3US37gAtDySoHC1uXP2b6CrpVWZUoD2doVKfP2HmH
         Y0qw==
X-Gm-Message-State: ACrzQf2NaqVMMTr3PsykC19IqQGqv/ho31CvTcRGNCNs0xP6BVmw+U8G
        J/R7wqaiBLA4bkWizkQl4TjCG5VViGH4V+GJk/uZZ0noN7IPiksF8R8buY5g5oxAwzMgEwB7q0n
        6bPRD1txErpSn2qeDn9jEk5wtKVgjxbO62bV0qt0NN0tST308M2Yx5548TZpSmCaL19l/sZPM4g
        ==
X-Received: by 2002:a05:620a:28d3:b0:6ee:cffb:21ef with SMTP id l19-20020a05620a28d300b006eecffb21efmr7071693qkp.123.1667165373120;
        Sun, 30 Oct 2022 14:29:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VpOzrWwDdbUTzdAgTMoettQDq3IlJ9e+osrfrA0AlcEDzYeUQ/IFWJudGkNNmAaIjI3fHGA==
X-Received: by 2002:a05:620a:28d3:b0:6ee:cffb:21ef with SMTP id l19-20020a05620a28d300b006eecffb21efmr7071670qkp.123.1667165372751;
        Sun, 30 Oct 2022 14:29:32 -0700 (PDT)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id a1-20020ac81081000000b003a4b88b886esm2654781qtj.96.2022.10.30.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 14:29:31 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH RFC 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe for pmd unshare
Date:   Sun, 30 Oct 2022 17:29:19 -0400
Message-Id: <20221030212929.335473-1-peterx@redhat.com>
X-Mailer: git-send-email 2.37.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be seen as a follow-up series to Mike's recent hugetlb vma lock
series for pmd unsharing.  So this series also depends on that one.  But
there're some huge_pte_offset() paths that seem to be still racy on pmd
unsharing (as they don't take vma lock), more below.

Hopefully this series can make it a more complete resolution for pmd
unsharing.

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
lock, it doesn't help us from when we're walking on another mm's pgtable,
so it's still on risk even if we're with the current->mm's mmap lock.

The recent work from Mike on vma lock can resolve most of this already.
It's achieved by forbidden pmd unsharing during the lock being taken, so no
further risk of the pgtable page being freed.

But it means it'll work only if we take the vma lock for all the places
around huge_pte_offset().  There're already a bunch of them that we did as
per the latest mm-unstable, but also a lot that we didn't for various
reasons.  E.g. it may not be applicable for not-allow-to-sleep contexts
like FOLL_NOWAIT.

I have totally no report showing that I can trigger such a race, but from
code wise I never see anything that stops the race from happening.  This
series is trying to resolve that problem.

Resolution
==========

What this patch proposed is, besides using the vma lock, we can also use
RCU to protect the pgtable page from being freed from under us when
huge_pte_offset() is used.  The idea is kind of similar to RCU fast-gup.
Note that fast-gup is very safe regarding pmd unsharing even before vma
lock, because fast-gup relies on RCU to protect walking any pgtable page,
including another mm's.

To apply the same idea to huge_pte_offset(), it means with proper RCU
protection the pte_t* pointer returned from huge_pte_offset() can also be
always safe to access and de-reference, along with the pgtable lock that
was bound to the pgtable page.

Patch Layout
============

Patch 1 is a trivial cleanup that I noticed when working on this.  Please
shoot if anyone think I should just post it separately, or hopefully I can
still just carry it over.

Patch 2 is the gut of the patchset, describing how we should use the helper
huge_pte_offset() correctly. Only a comment patch but should be the most
important one, as the follow up patches are just trying to follow the rule
it setup here.

The rest patches resolve all the call sites of huge_pte_offset() to make
sure either it's with the vma lock (which is perfectly good enough for
safety in this case; the last patch commented on all those callers to make
sure we won't miss a single case, and why they're safe).  Besides, each of
the patch will add rcu protection to one caller of huge_pte_offset().

Tests
=====

Only lightly tested on hugetlb kselftests including uffd, no more errors
triggered than current mm-unstable (hugetlb-madvise fails before/after
here, with error "Unexpected number of free huge pages line 207"; haven't
really got time to look into it).

Since this is so far only discussed with Mike quickly in the other thread,
marking this as RFC for now as I could have missed something.

Comments welcomed, thanks.

Peter Xu (10):
  mm/hugetlb: Let vma_offset_start() to return start
  mm/hugetlb: Comment huge_pte_offset() for its locking requirements
  mm/hugetlb: Make hugetlb_vma_maps_page() RCU-safe
  mm/hugetlb: Make userfaultfd_huge_must_wait() RCU-safe
  mm/hugetlb: Make walk_hugetlb_range() RCU-safe
  mm/hugetlb: Make page_vma_mapped_walk() RCU-safe
  mm/hugetlb: Make hugetlb_follow_page_mask() RCU-safe
  mm/hugetlb: Make follow_hugetlb_page RCU-safe
  mm/hugetlb: Make hugetlb_fault() RCU-safe
  mm/hugetlb: Comment at rest huge_pte_offset() places

 arch/arm64/mm/hugetlbpage.c | 32 ++++++++++++++++++++++++++
 fs/hugetlbfs/inode.c        | 39 ++++++++++++++++++--------------
 fs/userfaultfd.c            |  4 ++++
 include/linux/rmap.h        |  3 +++
 mm/hugetlb.c                | 45 +++++++++++++++++++++++++++++++++++--
 mm/page_vma_mapped.c        |  7 +++++-
 mm/pagewalk.c               |  5 +++++
 7 files changed, 115 insertions(+), 20 deletions(-)

-- 
2.37.3

