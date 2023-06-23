Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0156773BA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjFWOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjFWOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA072129
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687530582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=k1Z0+FcpBLSfoRatQPF2CylpoPyQCv2lrvtlx7M/beM=;
        b=R9BL+6dpc/8tK+QXA2hCODYCl+H+mBwc67JlAPfbhDWLsL+v7dUxhKASP+gCaXHDoQD4If
        RgpCMwoP9YnAQjK7XUqA89qo2rptiQsbaP+w1DHSoWnMp95OtZhwbEcPoCwgefsvQxBj4K
        MgZlLr4IYumAYIgr3gMw+txb1rMxW4M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-SDlm48l5PzCA1mi88HNGKA-1; Fri, 23 Jun 2023 10:29:40 -0400
X-MC-Unique: SDlm48l5PzCA1mi88HNGKA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4007918c09aso2064001cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530580; x=1690122580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1Z0+FcpBLSfoRatQPF2CylpoPyQCv2lrvtlx7M/beM=;
        b=h8i3syJcmtczIAudlrHG5BTFagIUXsE+SAzIdcjduFHRBoIvofpa0PerB7ecyUoNOa
         y05m/VZTqHtbFCVox2evpIUIe+JqdiwXRoX/sIjVY83ln761sZr3E/3h0+Q+PL2n5AHF
         Yx8ae8Ur5PNFQKPUS4qp/YS/Ys2/9DfGxrDtIBJTL7cpt/+WhSp93b/VMbP51mld2nkZ
         vCNpnvnYMDhjh43cN3pbLxdM1Z6hEt6ub8yVQWy5YeEZLu9G4v9ysyn3nCD9HwVCw+yd
         VUPJBcuC9Rvqmz70GV2w3NBctPML7TLUvT1QOVuhVMRtcSIPQmWGiX7h2DB8alZw3BMp
         bRyA==
X-Gm-Message-State: AC+VfDxjLNc8Z1oqRCBC65cncRgXLSXzaoKTSxKUiizRwR7kxcwMYpbY
        C9JfeyBM0Seu6sHcwD77JAFeILOqVXAfNlUBmvsZYpnQAs2Zro1+QkPbutkm8OwnWklORq4JA/m
        GUq1WyDQf1hv13/0aiONYkREyWgnAIqdM
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr8898197qvb.1.1687530579895;
        Fri, 23 Jun 2023 07:29:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61iOgKq4TGE1+eFXklI8JtA4+EKdWL0nSblu+aHPTTyXIqpedJA43pT3tKCW+xiQEjFC+xqA==
X-Received: by 2002:a05:6214:5186:b0:62d:eceb:f7ce with SMTP id kl6-20020a056214518600b0062decebf7cemr8898182qvb.1.1687530579566;
        Fri, 23 Jun 2023 07:29:39 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cc989000000b0062821057ac7sm5104827qvk.39.2023.06.23.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:29:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        James Houghton <jthoughton@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 0/8] mm/gup: Unify hugetlb, speed up thp
Date:   Fri, 23 Jun 2023 10:29:28 -0400
Message-Id: <20230623142936.268456-1-peterx@redhat.com>
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

v1: https://lore.kernel.org/r/20230613215346.1022773-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20230619231044.112894-1-peterx@redhat.com

v3:
- Added R-bs and A-bs
- Patch 2:
  - s/huge_pte_write/pte_write/ [David]
  - Add back the WARN_ON_ONCE I used to have in v1; change retval to
    the real errno from try_grab_page(), rather than NULL
- Patch 3: make the page_mask calculation slightly prettier [David]
- Other small cosmetic changes

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
 mm/hugetlb.c                              | 263 +++-------------------
 tools/testing/selftests/mm/run_vmtests.sh |  48 +++-
 5 files changed, 124 insertions(+), 292 deletions(-)

-- 
2.40.1

