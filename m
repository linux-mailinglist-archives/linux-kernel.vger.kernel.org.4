Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C426E2CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDNXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDNXZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:25:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611F54C0D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:25:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so18413278wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681514723; x=1684106723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SzMqnrR+tN/MEPcRsyL9VzoIEGZmVyA24hgPlZN4NM4=;
        b=LfX28vymWuYSrDWvAI083FFztLVxgWPmxcvfDUBNJ9rRWO03XXO2iR2mgkMGn23x9G
         NMxVYndO8CY/9P/sLU/G0UyzOmv3Y8yGxrTDR62qmCNGBWb5PLMtk/dCO8W+x7aP3N8h
         XubOGhLIutKH9SdLrGIujsD9El/E/oJa5qEaoOkEVg9vlqsPAthAXkUQzZe6b3wJsVcC
         v3lS6RFv7DxJ3t2M+6NJgWIqA2nC0/5KCN9xJYTDJYBa2zMtpz3xGRbXQpqfFI6xmqiX
         qOd/rrOyTxYuG5sM+7qliN0SvzvKXKKJZPq5DWeOkkwZ9tm3FIev1Ck+eGlYG1ZzJPO2
         0Vbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514723; x=1684106723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzMqnrR+tN/MEPcRsyL9VzoIEGZmVyA24hgPlZN4NM4=;
        b=kTnh9LhgJOeeCz0YxBaGj3v8bChX96uM38yaCI+89B+q1SouBICHH04eOK8cQOd74/
         VMw53cejxY/3pXVce3cq431e175fEq3s6rLgHqPoC20MwC1bGhPNS7HD/HwnLEC6dUWV
         q68Vc//7JywxsXu+HadUtHxoPwbinW18UgwIhLKmGFxFZt/91ECco/vPxXhb2yiMlNQe
         juaEP1tOYbNi+ZELFeCL1R/npDesfROBM2rMV7e+dj+snXkYnjyMCavfsyqmQ5BmPE21
         WKNwlYEz7UsnFbxVNSse8amM2MsQTzlmqVHXxJhPPyFiXDQSvNexknTZlamvyHcwh+59
         Owog==
X-Gm-Message-State: AAQBX9evaMpF//QCkpda4mGis6Jv5iMY/zmSonoFBGCa1hYIR1JvR8II
        Wsix6nM5lZwXp/lQ4EtR2mo=
X-Google-Smtp-Source: AKy350biPOcCW1z56yjSERudJDU7KCFOO8gOfCAnypvaFtUp0YN4dn5TtlCmrrayE9mwoKTEBO4oOA==
X-Received: by 2002:a1c:f719:0:b0:3f0:3368:5f7f with SMTP id v25-20020a1cf719000000b003f033685f7fmr5549118wmh.31.1681514722658;
        Fri, 14 Apr 2023 16:25:22 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id q9-20020a1ce909000000b003ee20b4b2dasm5230037wmc.46.2023.04.14.16.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 16:25:21 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 0/7] remove the vmas parameter from GUP APIs
Date:   Sat, 15 Apr 2023 00:25:10 +0100
Message-Id: <cover.1681508038.git.lstoakes@gmail.com>
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

Thanks to Matthew Wilcox for suggesting this refactoring!

Lorenzo Stoakes (7):
  mm/gup: remove unused vmas parameter from get_user_pages()
  mm/gup: remove unused vmas parameter from pin_user_pages_remote()
  mm/gup: remove vmas parameter from get_user_pages_remote()
  mm/gup: introduce the FOLL_SAME_FILE GUP flag
  io_uring: rsrc: use FOLL_SAME_FILE on pin_user_pages()
  mm/gup: remove vmas parameter from pin_user_pages()
  mm/gup: remove vmas array from internal GUP functions

 arch/arm64/kernel/mte.c                    |   5 +-
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
 kernel/events/uprobes.c                    |  10 +-
 mm/gup.c                                   | 121 ++++++++-------------
 mm/gup_test.c                              |  14 +--
 mm/hugetlb.c                               |  24 ++--
 mm/memory.c                                |   9 +-
 mm/process_vm_access.c                     |   2 +-
 mm/rmap.c                                  |   2 +-
 net/xdp/xdp_umem.c                         |   2 +-
 security/tomoyo/domain.c                   |   2 +-
 virt/kvm/async_pf.c                        |   3 +-
 virt/kvm/kvm_main.c                        |   4 +-
 30 files changed, 125 insertions(+), 164 deletions(-)

--
2.40.0
