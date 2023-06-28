Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB81741B31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjF1VyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF1VyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CF2102
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687989194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=h1nRhPjVUvT83glYEJmWAi7ToC2P8NKyYybxP7YvEbw=;
        b=DXZmwMbKoImucuXpNwD9+O9pGNf/ienHvPHYuZ3+F16jGkPJzhwe2oDxolImFGBZPxUb/f
        wb+DGvGy38L8BjK9/+67SdK3x7HEA6UynGnAQqihL77ga2Jl/Rxjyo1bRba+oMwrZUOdsF
        +c7e5O5Bkl2ArPCwhJEJtg2NXMjlT4Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-ekbs_2kHM0mrB3ULSZRFTg-1; Wed, 28 Jun 2023 17:53:13 -0400
X-MC-Unique: ekbs_2kHM0mrB3ULSZRFTg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40320c2d93dso60701cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687989193; x=1690581193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1nRhPjVUvT83glYEJmWAi7ToC2P8NKyYybxP7YvEbw=;
        b=U3N4XC/51SEJ9lKN+xCGtso3Lq1K8UNJEee8vhDi5/pJtXbfSJ5QP7w6WVL/7FqFxi
         eM+OHwYHZoAhFGV5bTn58uiPbwoOW0Z/gT3X2FRxhy/F0+7NPbRDs3a8UjnBFHP1k0ha
         SWNOICXvq+VaTbzLmTBGUWDnqt7jB+CXVzUnk9tVeo300ybV2i4LKl211+xWFXu+YUfw
         dpdEO6HXeDfCh8GmDe0WruvJlBb0wr/80NIjWrIxkWPwSlIZ8rKYZNGmyeKPs0dCeLMg
         /Tj8BXY69qrZXkm47OTwTqdJFw0x6lu1RfYwl0btA0+lciPENuZHFNc1RKBR82nn6qdj
         EHUw==
X-Gm-Message-State: ABy/qLatlgLxO4ur7oaKKMS3PtZzF1QANufu3sBzZRLuY70t/28eUP4t
        f5/P6qWyasjoNMgAkHdNXPN2kFY9i5+kqHqBvJMu2nPBLa2t26LlS6RpNSkBvzovtzzIlCGCTSu
        r0IsYdwlK+ZirZLcedZCu2+lX
X-Received: by 2002:a05:6214:5010:b0:635:e528:521a with SMTP id jo16-20020a056214501000b00635e528521amr946113qvb.5.1687989193088;
        Wed, 28 Jun 2023 14:53:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHoNAJWjLY8+y5RRUWEW1UMYBA8wgDHtFPDoOHjnAx+ck1QWHJujGtsSDS/6EviOoS7uEg5dA==
X-Received: by 2002:a05:6214:5010:b0:635:e528:521a with SMTP id jo16-20020a056214501000b00635e528521amr946098qvb.5.1687989192755;
        Wed, 28 Jun 2023 14:53:12 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id p3-20020a0cfac3000000b00631fea4d5bcsm6277797qvo.95.2023.06.28.14.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:53:12 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        James Houghton <jthoughton@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com
Subject: [PATCH v4 0/8] mm/gup: Unify hugetlb, speed up thp
Date:   Wed, 28 Jun 2023 17:53:02 -0400
Message-ID: <20230628215310.73782-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1: https://lore.kernel.org/r/20230613215346.1022773-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230619231044.112894-1-peterx@redhat.com
v3: https://lore.kernel.org/r/20230623142936.268456-1-peterx@redhat.com

v4:
- Patch 2: check pte write for unsharing [David]
- Added more tags, rebased to akpm/mm-unstable

Hugetlb has a special path for slow gup that follow_page_mask() is actually
skipped completely along with faultin_page().  It's not only confusing, but
also duplicating a lot of logics that generic gup already has, making
hugetlb slightly special.

This patchset tries to dedup the logic, by first touching up the slow gup
code to be able to handle hugetlb pages correctly with the current follow
page and faultin routines (where we're mostly there.. due to 10 years ago
we did try to optimize thp, but half way done; more below), then at the
last patch drop the special path, then the hugetlb gup will always go the
generic routine too via faultin_page().

Note that hugetlb is still special for gup, mostly due to the pgtable
walking (hugetlb_walk()) that we rely on which is currently per-arch.  But
this is still one small step forward, and the diffstat might be a proof
too that this might be worthwhile.

Then for the "speed up thp" side: as a side effect, when I'm looking at the
chunk of code, I found that thp support is actually partially done.  It
doesn't mean that thp won't work for gup, but as long as **pages pointer
passed over, the optimization will be skipped too.  Patch 6 should address
that, so for thp we now get full speed gup.

For a quick number, "chrt -f 1 ./gup_test -m 512 -t -L -n 1024 -r 10" gives
me 13992.50us -> 378.50us.  Gup_test is an extreme case, but just to show
how it affects thp gups.

Patch 1-5:   prepares for the switch
Patch 6:     switchover to the new code and remove the old
Patch 7-8:   added some gup test matrix into run_vmtests.sh

Please review, thanks.

Peter Xu (8):
  mm/hugetlb: Handle FOLL_DUMP well in follow_page_mask()
  mm/hugetlb: Prepare hugetlb_follow_page_mask() for FOLL_PIN
  mm/hugetlb: Add page_mask for hugetlb_follow_page_mask()
  mm/gup: Cleanup next_page handling
  mm/gup: Accelerate thp gup even for "pages != NULL"
  mm/gup: Retire follow_hugetlb_page()
  selftests/mm: Add -a to run_vmtests.sh
  selftests/mm: Add gup test matrix in run_vmtests.sh

 fs/userfaultfd.c                          |   2 +-
 include/linux/hugetlb.h                   |  20 +-
 mm/gup.c                                  |  83 ++++---
 mm/hugetlb.c                              | 265 +++-------------------
 tools/testing/selftests/mm/run_vmtests.sh |  48 +++-
 5 files changed, 126 insertions(+), 292 deletions(-)

-- 
2.41.0

