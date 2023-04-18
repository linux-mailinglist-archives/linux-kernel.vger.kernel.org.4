Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE06E6894
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjDRPtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjDRPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:49:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CF61384D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:49:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bi21-20020a05600c3d9500b003f17a8eaedbso87817wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681832942; x=1684424942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XZsgr9HPh8Eljn7jVTyLk/JO3F53C57zrpzuRSuBx0=;
        b=BGjrtyIPdobYVVvPnyN41D+plP/T/aisRYwjujeeSF5rqDke7NOT9gOT5Jti4CpMTh
         NPe6pAipOD+L8Q8uTrRl7eyzCEQTz6dFBIAEkkZwvEml4FQfGE100ItCdJpNENZtnpzb
         mlcZlDNFN4vwM7mk4/Us9OEROS5c45tokgXFdhSroEViSDC/ecZ25rJp4NBrLf2QVJ8/
         d4Aj1Nkui/2bK3DQABqPlVNtw+QWy/KHSTrnwrCJZ5quVdgRwGrtxEkc+ijTRF2QWTt+
         lBJ4HmMMGCVNHVxlJ2vUFf7XqHBsRuJJ4zdUjkAJCV2xzTrO7Y4lRdDSjZlexHRK1CB1
         yxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832942; x=1684424942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XZsgr9HPh8Eljn7jVTyLk/JO3F53C57zrpzuRSuBx0=;
        b=OL4hNViB8irxL0KAOYlC3uHmlBuSQVhKwJ2004mR9hZFykUMiAJ8yWL3Cbfb4ItJCd
         o/JMPENgDTmUm4XmAD+DMnzrF8wGNbsL4lD4s4pSnEVPO+XfTJmIOZ/zXiHVkD39BG98
         AmbGJyM8xUT8XHBNg6qFG36CNyhqxLC0LikDW4vA0jYA3qeeCn7JObra2TuGqYOH4Mjk
         WI4fCwq5nwtCEfKgcYZd8jRigWnFgEUjHH5eoJF6jjDX9lnq7+OjnFvwwZnZrPIFB/8M
         jUn0dqa7b+rRARQq68rtJiC2m8bgpz5z1mQ1MrjbBokDoiA23fIZ/57LTD/jQj0J0TAO
         h9ng==
X-Gm-Message-State: AAQBX9ePs0M6YfKOzmgQ9qPW1pwWW8zThhfz+TdyNX2K6I+SyoUKfQQO
        6ogsMgXkcAPp+BQfKXbYHzs=
X-Google-Smtp-Source: AKy350ZMV4eTs/AXWwPaCAkTiqRSIY+VIgxE1ouWpU7lD6qlipuQ0OE84sjtpn+eoTSyu1ic3TBy0w==
X-Received: by 2002:a05:600c:253:b0:3f1:733d:f3c0 with SMTP id 19-20020a05600c025300b003f1733df3c0mr5648148wmj.14.1681832941680;
        Tue, 18 Apr 2023 08:49:01 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id i4-20020a5d55c4000000b002f74578f494sm11011481wrw.41.2023.04.18.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 08:49:00 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/6] remove the vmas parameter from GUP APIs
Date:   Tue, 18 Apr 2023 16:48:58 +0100
Message-Id: <cover.1681831798.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(pin_/get)_user_pages[_remote]() each provide an optional output parameter
for an array of VMA objects associated with each page in the input range.

These provide the means for VMAs to be returned, as long as mm->mmap_lock
is never released during the GUP operation (i.e. the internal flag
FOLL_UNLOCKABLE is not specified).

In addition, these VMAs have also to only be accessed under the mmap_lock,
and become invalidated the moment it is released.

The vast majority of invocations do not use this functionality and of those
that do, all but one retrieve a single VMA to perform checks upon.

It is not egregious in the single VMA cases to simply replace the operation
with a vma_lookup(). In these cases we duplicate the (fast) lookup on a
slow path already under the mmap_lock, abstracted to a new
get_user_page_vma_remote() inline helper function which also performs error
checking and reference count maintenance.

The special case is io_uring, where io_pin_pages() specifically needs to
assert that all the VMAs possess the same vm->vm_file (possibly NULL) and
they are either anonymous or hugetlb pages.

We adjust this to perform its own VMA lookup, which in most cases should
consist of a single VMA, so the performance cost on an already slow path
should be minimal. By doing so, we avoid an allocation in any case.

In future it is sensible to simply restrict write pinning of file-backed
folios in which case we may be able to simply avoid this check altogether,
but for the time being we maintain it as-is.

Eliminating the vmas parameter eliminates an entire class of possible
danging pointer errors should the lock have been incorrectly released.

In addition the API is simplified and now clearly expresses what it is for
- applying the specified GUP flags and (if pinning) returning pinned pages.

This change additionally opens the door to further potential improvements
in GUP and the possible marrying of disparate code paths.

I have run the gup_test and a simple io_uring program which exercises the
use of FOLL_SAME_PAGE with no issues.

This patch series is rebased on mm-unstable as of 17th April.

Thanks to Matthew Wilcox for suggesting this refactoring!

v4:
- Drop FOLL_SAME_FILE as the complexity costs exceed the benefit of having it
  for a single case.
- Update io_pin_pages() to perform VMA lookup directly.
- Add get_user_page_vma_remote() to perform the single page/VMA lookup with
  error checks performed correctly.

v3:
- Always explicitly handle !vma cases, feeding back an error to the user if
  appropriate, indicating the operation did not completely succeed if not
  and always with a warning since these conditions should be impossible.
https://lore.kernel.org/linux-mm/cover.1681558407.git.lstoakes@gmail.com/

v2:
- Only lookup the VMA if the pin succeeded (other than __access_remote_vm()
  which has different semantics)
- Be pedantically careful about ensuring that under no circumstances can we
  fail to unpin a page
https://lore.kernel.org/linux-mm/cover.1681547405.git.lstoakes@gmail.com/

v1:
https://lore.kernel.org/linux-mm/cover.1681508038.git.lstoakes@gmail.com/

Lorenzo Stoakes (6):
  mm/gup: remove unused vmas parameter from get_user_pages()
  mm/gup: remove unused vmas parameter from pin_user_pages_remote()
  mm/gup: remove vmas parameter from get_user_pages_remote()
  io_uring: rsrc: avoid use of vmas parameter in pin_user_pages()
  mm/gup: remove vmas parameter from pin_user_pages()
  mm/gup: remove vmas array from internal GUP functions

 arch/arm64/kernel/mte.c                    |  17 ++--
 arch/powerpc/mm/book3s64/iommu_api.c       |   2 +-
 arch/s390/kvm/interrupt.c                  |   2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c            |   2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c        |   2 +-
 drivers/infiniband/hw/qib/qib_user_pages.c |   2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c   |   2 +-
 drivers/infiniband/sw/siw/siw_mem.c        |   2 +-
 drivers/iommu/iommufd/pages.c              |   4 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c  |   2 +-
 drivers/misc/sgi-gru/grufault.c            |   2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c         |   2 +-
 drivers/vfio/vfio_iommu_type1.c            |   2 +-
 drivers/vhost/vdpa.c                       |   2 +-
 fs/exec.c                                  |   2 +-
 include/linux/hugetlb.h                    |  10 +-
 include/linux/mm.h                         |  42 +++++++--
 io_uring/rsrc.c                            |  53 ++++++-----
 kernel/events/uprobes.c                    |  13 +--
 mm/gup.c                                   | 105 +++++++--------------
 mm/gup_test.c                              |  14 ++-
 mm/hugetlb.c                               |  24 ++---
 mm/memory.c                                |  14 +--
 mm/process_vm_access.c                     |   2 +-
 mm/rmap.c                                  |   2 +-
 net/xdp/xdp_umem.c                         |   2 +-
 security/tomoyo/domain.c                   |   2 +-
 virt/kvm/async_pf.c                        |   3 +-
 virt/kvm/kvm_main.c                        |   2 +-
 29 files changed, 161 insertions(+), 174 deletions(-)

--
2.40.0
