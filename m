Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0386E2FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjDOJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:06:26 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040C5B8F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:06:24 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id he13so16456889wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681549583; x=1684141583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PL6bHkr+M7EoVmkxPtD7r576pSBguHFh3HHTNrHOXq4=;
        b=WoN9ksEFuQ8QUQAyH4cmjMVVsA13VRy7nhVB36wWA09YtDQfJ5t7eDQw7S9MA2vZ4A
         UFQCR732185pXcGy4gqzxWXfYVKT/NlP0kdst5qvUkewrLsodz2Yj52epRqRwQ/ECPHq
         T2jWzaOcoKDqQgMIrLi/ue9YHqBCNW6bbKaKJb6LnzpelBdR1dHCVhxhv7bDDoAF2/Gs
         KUawhvSFuyYoquODp9d0i52jkFh8KEUrOkXVD5G9sfD/jaqvwopkU6oYg2YA7hEnLxg4
         MAkfxOb1PWSTIN8LTaLdWqrpxz3B+I2nRyhpPb+oaqRtJCs6rzI5cHnbjBzFB+F815sE
         9XDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681549583; x=1684141583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PL6bHkr+M7EoVmkxPtD7r576pSBguHFh3HHTNrHOXq4=;
        b=TPtEgjbzjqP4BGXFsXb/4QsfWhNaDucjlzT+ING+E1rWGUht2UsuC0oKqBlTQOGvlN
         cg75ZzU/9M2QUMkBrZL8taV7mta53rZBLKhrLNqPGtAKnCJgYCTd+0b1cqWf25vWW9L1
         qyu8imvvBAlG1uuYengO8enctLGJrTx+7W9JBwoC7WeIvCkoqnHEII6I6oYwOWKzyLdT
         jRJiF/f1Ymz8b7PlUwSxPvZ2xJOnSi0vC0e/M+764As7L0pnZLE2oOZt3zeb8G8vgMLS
         5XMOMOZ5sEXWPWfmVk7SX3IqyY6MmYOCmxJz8AAGE4wATDZCoODxAQbuYsrMI1A5Urq+
         xc+g==
X-Gm-Message-State: AAQBX9dFO9zabObwffpWjX1B+231zfXF1bZR0QqGz4zWLkBp25cddLP3
        Te+ZCS+nfB4FZeYkz8we6CQ=
X-Google-Smtp-Source: AKy350bI3XBjE2GChzSj/DnCLie4wBOn0bHEI1PubigwHNZvTnjy6f8yWDoTlQeIbdBcUYW4963O8Q==
X-Received: by 2002:a05:600c:221a:b0:3f0:a798:2757 with SMTP id z26-20020a05600c221a00b003f0a7982757mr6248546wml.25.1681549582966;
        Sat, 15 Apr 2023 02:06:22 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id t15-20020a05600c198f00b003f0a007b802sm8888533wmq.12.2023.04.15.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 02:06:22 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/7] remove the vmas parameter from GUP APIs
Date:   Sat, 15 Apr 2023 10:06:06 +0100
Message-Id: <cover.1681547405.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
slow path already under the mmap_lock.

The special case is io_uring, where io_pin_pages() specifically needs to
assert that all the VMAs possess the same vm->vm_file (possibly NULL) and
they are either anonymous or hugetlb pages.

To continue to provide this functionality, we introduce the FOLL_SAME_PAGE
flag which asserts that the vma->vm_file remains the same throughout,
erroring out if this is not the case.

We can then replace the io_uring case by passing FOLL_SAME_FILE and looking
up the first VMA manually and performing the required checks on this
alone. The combination of the two amount to the same checks being
performed (and avoids an allocation).

Eliminating this parameter eliminates an entire class of errors - the vmas
array used to become a set of dangling pointers if access after release of
mmap_lock was attempted, this is simply no longer possible.

In addition the API is simplified and now clearly expresses what it is for
- applying the specified GUP flags and (if pinning) returning pinned pages.

This change additionally opens the door to further potential improvements
in GUP and the possible marrying of disparate code paths.

I have run the gup_test and a simple io_uring program which exercises the
use of FOLL_SAME_PAGE with no issues.

Thanks to Matthew Wilcox for suggesting this refactoring!

v2:
- Only lookup the VMA if the pin succeeded (other than __access_remote_vm()
  which has different semantics)
- Be pedantically careful about ensuring that under no circumstances can we
  fail to unpin a page

v1:
https://lore.kernel.org/linux-mm/cover.1681508038.git.lstoakes@gmail.com/

Lorenzo Stoakes (7):
  mm/gup: remove unused vmas parameter from get_user_pages()
  mm/gup: remove unused vmas parameter from pin_user_pages_remote()
  mm/gup: remove vmas parameter from get_user_pages_remote()
  mm/gup: introduce the FOLL_SAME_FILE GUP flag
  io_uring: rsrc: use FOLL_SAME_FILE on pin_user_pages()
  mm/gup: remove vmas parameter from pin_user_pages()
  mm/gup: remove vmas array from internal GUP functions

 arch/arm64/kernel/mte.c                    |   7 +-
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
 include/linux/mm.h                         |  10 +-
 include/linux/mm_types.h                   |   2 +
 io_uring/rsrc.c                            |  39 +++----
 kernel/events/uprobes.c                    |  12 +-
 mm/gup.c                                   | 121 ++++++++-------------
 mm/gup_test.c                              |  14 +--
 mm/hugetlb.c                               |  24 ++--
 mm/memory.c                                |   9 +-
 mm/process_vm_access.c                     |   2 +-
 mm/rmap.c                                  |   2 +-
 net/xdp/xdp_umem.c                         |   2 +-
 security/tomoyo/domain.c                   |   2 +-
 virt/kvm/async_pf.c                        |   3 +-
 virt/kvm/kvm_main.c                        |   2 +-
 30 files changed, 127 insertions(+), 164 deletions(-)

--
2.40.0
