Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E4D701FBF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 23:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjENV0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENV0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 17:26:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFDE10DF
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:26:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3090408e09bso1434198f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 14:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684099601; x=1686691601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xI8BtlVvvSS6bzTpldJXGD+NpgtGXiB7zWUwN8KDHQ=;
        b=LgXMgy8wBVUXmrNnUxzO7BBuNMgVdurWq4HLrivFayR7tPolKEJ4dkEQAwF47vo241
         CtKAUg86vamPAhGSRDmSO3kbs/QlOjjMfP3tMdHM2mqXnwg6y0Ys13vB0Dm/L7FVXmED
         Bcsioy6QrkdcRx1U7cCoUWkxJp8QGQlqGdAClsYs15hHNRGes1wLcoqRF1ZJ+vhX1ydV
         IqS4wGsYSAGO2NxmohDbFyELRqaaW6XfTV9RESA2Y0seDcU2t+z3XObXV84yzBrsS7iJ
         tg9v+2j3H6o58yYkG22LC2gPRdlNfsthY3HF/4MtOnUDgzBX+gumO2goxuXoBGfF2Vph
         GxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684099601; x=1686691601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xI8BtlVvvSS6bzTpldJXGD+NpgtGXiB7zWUwN8KDHQ=;
        b=CQX0WcK7zPsFNQJc++Fy2H75124qnqJxiTf/iy2EXMciUHNvcyGRJyoSlBjMGIMXpC
         rujXcy4oZ7TzDvcF2oZlxh8uSigXaYoAZjbg2+MoAhWGyp0kHilRMnBxi/VsmGZppS/B
         I/RSb8YRMr3TmBJPN7gPrnGrovS850bXSR2GTKZMHzNwev4UNESl5OVe0weSHRI4LDR0
         TQ9Jj1HgAw/5nUiCCkY1+UB6kGKkNAl5DrB1cVCnW8rfhPSn1SmHFpQfeUyC7+aOTa4+
         2f+po0ATnNeCxs654wpBerHtfdHFmVGEVMywb6K5Dt+/SDbCrKj4HC5wJ81JWZMqyRzR
         Z4Ow==
X-Gm-Message-State: AC+VfDzD8i0WGE8KcMJT/YXWuEa9luHorSps2au5xcGFXz9XxS53iJFc
        gsJ/kZVDy7dmBlJCsLF/1rc=
X-Google-Smtp-Source: ACHHUZ52CH5q90BjBUE5Abhh6pfOnSlQBaf/6KkgZOD5Mc4aPvKyzCLJOHPxW1EZBW2PbACRUKojTg==
X-Received: by 2002:adf:f00a:0:b0:306:3286:69a2 with SMTP id j10-20020adff00a000000b00306328669a2mr21663335wro.48.1684099601286;
        Sun, 14 May 2023 14:26:41 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id a24-20020a5d4578000000b003063938bf7bsm30543711wrc.86.2023.05.14.14.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 14:26:40 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 0/6] remove the vmas parameter from GUP APIs
Date:   Sun, 14 May 2023 22:26:35 +0100
Message-Id: <cover.1684097001.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In addition, these VMAs can only be accessed with the mmap_lock held and
become invalidated the moment it is released.

The vast majority of invocations do not use this functionality and of those
that do, all but one case retrieve a single VMA to perform checks upon.

It is not egregious in the single VMA cases to simply replace the operation
with a vma_lookup(). In these cases we duplicate the (fast) lookup on a
slow path already under the mmap_lock, abstracted to a new
get_user_page_vma_remote() inline helper function which also performs error
checking and reference count maintenance.

The special case is io_uring, where io_pin_pages() specifically needs to
assert that the VMAs underlying the range do not result in broken long-term
GUP file-backed mappings.

As GUP now internally asserts that FOLL_LONGTERM mappings are not
file-backed in a broken fashion (i.e. requiring dirty tracking) - as
implemented in "mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to
file-backed mappings" - this logic is no longer required and so we can
simply remove it altogether from io_uring.

Eliminating the vmas parameter eliminates an entire class of danging
pointer errors that might have occured should the lock have been
incorrectly released.

In addition, the API is simplified and now clearly expresses what it is
intended for - applying the specified GUP flags and (if pinning) returning
pinned pages.

This change additionally opens the door to further potential improvements
in GUP and the possible marrying of disparate code paths.

I have run this series against gup_test with no issues.

This patch series is rebased on mm-unstable as of 12th May.

Thanks to Matthew Wilcox for suggesting this refactoring!

v5:
- Remove the io_uring open-coded VMA file-backed check, as this is now
  explicitly disallowed by GUP.
- Updated the subsequent patch to eliminate the vmas parameter accordingly.

v4:
- Drop FOLL_SAME_FILE as the complexity costs exceed the benefit of having it
  for a single case.
- Update io_pin_pages() to perform VMA lookup directly.
- Add get_user_page_vma_remote() to perform the single page/VMA lookup with
  error checks performed correctly.
https://lore.kernel.org/linux-mm/cover.1681831798.git.lstoakes@gmail.com/

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
  io_uring: rsrc: delegate VMA file-backed check to GUP
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
 io_uring/rsrc.c                            |  34 ++-----
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
 29 files changed, 138 insertions(+), 178 deletions(-)

--
2.40.1
