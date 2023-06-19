Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CB735FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 01:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFSXLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 19:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSXLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 19:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F3124
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687216248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AUaeznawE2H/34P9AfcQNnXrIV7Bu4arSjeauz3YDCg=;
        b=MmwJarQudm45Z98tIryToFH5aY31N8Ehd9VrE3TNHk9mWuRhKcgeVmJXvPiu9SOn2fa6IC
        sZrlXOpbzBfMLqueEh/eFgcvIfzJB6LzelZYgXY/LxPnyhY5JahsjMQOgjPxLndVAl6UXw
        3ZOv8egF/bggPdP1DHOX14wf2mBcIds=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PNMUq2FcPuGOLyqlqHlCOg-1; Mon, 19 Jun 2023 19:10:47 -0400
X-MC-Unique: PNMUq2FcPuGOLyqlqHlCOg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76248f3057bso37225085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 16:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687216247; x=1689808247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUaeznawE2H/34P9AfcQNnXrIV7Bu4arSjeauz3YDCg=;
        b=NSzyV1DDuKPBoTCkK2U75LxUAFISSMKpjxTemQSe94IkwG/Aqa4OPQIZtBQm40SmZY
         yS1C36dgv1f1xFydXjg49/zbnHv3dcDGu6Sm94JuvQPujXI4fC2ocVBNtg38IUtqrGFF
         xU58lxi8ed4w+HzggphxmdJIGW3me84WIoKjc3Ypeq1PI61n92C04w09Aetu8zx7+uuD
         +2f6luIi3vOuTTqPbNYWJH8okR4q/4x3UBup4dAVud6+7GBweLDIHhgLpT6aGRxIM5Sc
         zkzFNpiJtsat4RcRPpY47gB1hOcw6gcV35y9V7uTkgyyLomzF/2HWqJ49LErRAqU1iYM
         xGGw==
X-Gm-Message-State: AC+VfDypWW/44MNMmYR4qEKzFPvMrjORS2kiFn74E7UqKwgvEGZ6Upmw
        EwCHGs+imynyYYxr4gdGAxaz3IaR8w3OEEEiJfzH2RNs3tYaZj6OpWz9Qr43TvNDz20nHjKWRux
        7wAPL+6N4jzb9nqAOHCj5Enfk14J//Y3X
X-Received: by 2002:a05:620a:319f:b0:760:3db8:fd60 with SMTP id bi31-20020a05620a319f00b007603db8fd60mr13281490qkb.2.1687216246751;
        Mon, 19 Jun 2023 16:10:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yLXEGioUkQ6kxFUHescmZ4/AFJ0/pLhn+Fkj0MhekOj9iGEpHY/TNfhwUEe6ENzFyXD4h2Q==
X-Received: by 2002:a05:620a:319f:b0:760:3db8:fd60 with SMTP id bi31-20020a05620a319f00b007603db8fd60mr13281472qkb.2.1687216246410;
        Mon, 19 Jun 2023 16:10:46 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id t15-20020a05620a034f00b007592f2016f4sm405864qkm.110.2023.06.19.16.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 16:10:46 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 0/8] mm/gup: Unify hugetlb, speed up thp
Date:   Mon, 19 Jun 2023 19:10:36 -0400
Message-Id: <20230619231044.112894-1-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
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

v2:
- Added R-bs
- Merged patch 2 & 4 into a single patch [David, Mike]
- Remove redundant compound_head() [Matthew]
- Still handle failure cases of try_get_folio/page() [Lorenzo]
- Modified more comments in the last removal patch [Lorenzo]
- Fixed hugetlb npages>1 longterm pin issue
- Added two testcase patches at last

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
 mm/hugetlb.c                              | 256 +++-------------------
 tools/testing/selftests/mm/run_vmtests.sh |  48 +++-
 5 files changed, 119 insertions(+), 290 deletions(-)

-- 
2.40.1

