Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF5A6E313A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDOMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 08:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjDOMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 08:09:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7424EDE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:19 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2efbab2d524so322275f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 05:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681560558; x=1684152558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OFJP1DEOM2hcDBxvWV93h2rtiTrUT+yDD0c0jto4Tbk=;
        b=M0DAP/83XHRXNFaFuUrIe0FPT2ywMdU7/EBmKQkTuzotA3+g/mX5EiP3BZ+gmRdcOl
         UFrBOLbbcBc2zRVa5VcBRxWVoQLbT3u4UDKUxj1j8r+KUEAcNw+jp5GMYy5Qna5WIi4n
         wCciW3dklDpS4KBECt4G0sWLch9GdrifFX0Y3oipbTaFgwH6rAobYlBjp6ZeYCChwHwu
         a93hq7U9JKqyU8tbsVUNx5Ic/yKw4fXOYjce49G0+fOVQ4A9axdGZ6eoY0Py0irGUfkF
         cTfQ/2fUz/BDqh2Z7ElN+Epnoix8a7JN3AI6y1EAcJNqOo2xQkm12U0oZBCONQAHFbKK
         eU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681560558; x=1684152558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFJP1DEOM2hcDBxvWV93h2rtiTrUT+yDD0c0jto4Tbk=;
        b=F/itvZ0CkJvA8gSGuaYWOqTzo6CrjDx/3m5kzvFVMeQ4XPiFEiXvcBqFssHxfeCTF8
         5B5QSyvt/vezGVa6DnXUThGOx4WtYpF5s4ewpkHy9soLmaJ0dpqoy1ZQpk3eGWspq8YZ
         xSYTb7ySIexlCqOzdiQYurTysnG299sGOTi8ROahvXlwTee/YksrDUSNTPImgoCj/LoZ
         DZ5h8ivnDo3o7QpwGYlmz3C3oikD36Hf371j3ku+JXFnQ59vJWjyXTXspOc4jBhk5soA
         OnX3ih84Kzaq60e8g3Q4iiB0g8SjY+24bvFcceEBmZQaEOuOFvD1yrKMO0cuycNtiaME
         /35g==
X-Gm-Message-State: AAQBX9fpZ0sfTpFi3JezpBon1s6r5ommU06wLdvZ0JoV4eWIUz934PfB
        rXJ7qquGHWbzfISF7s/fOnA=
X-Google-Smtp-Source: AKy350bdgIVIT8Ikiu4Ulq2mLTKwIF3hcqxe6rsYgcxgaWqBWXYlZO3ICi2NP+5izhbKbr9kn0X6yA==
X-Received: by 2002:adf:e802:0:b0:2d1:7ade:aac with SMTP id o2-20020adfe802000000b002d17ade0aacmr1306465wrm.0.1681560557807;
        Sat, 15 Apr 2023 05:09:17 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h12-20020adffa8c000000b002d322b9a7f5sm5657253wrr.88.2023.04.15.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 05:09:17 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 0/7] remove the vmas parameter from GUP APIs
Date:   Sat, 15 Apr 2023 13:09:14 +0100
Message-Id: <cover.1681558407.git.lstoakes@gmail.com>
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

v3:
- Always explicitly handle !vma cases, feeding back an error to the user if
  appropriate, indicating the operation did not completely succeed if not
  and always with a warning since these conditions should be impossible.

v2:
- Only lookup the VMA if the pin succeeded (other than __access_remote_vm()
  which has different semantics)
- Be pedantically careful about ensuring that under no circumstances can we
  fail to unpin a page
https://lore.kernel.org/linux-mm/cover.1681547405.git.lstoakes@gmail.com/

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
 io_uring/rsrc.c                            |  40 +++----
 kernel/events/uprobes.c                    |  14 ++-
 mm/gup.c                                   | 121 ++++++++-------------
 mm/gup_test.c                              |  14 +--
 mm/hugetlb.c                               |  24 ++--
 mm/memory.c                                |   8 +-
 mm/process_vm_access.c                     |   2 +-
 mm/rmap.c                                  |   2 +-
 net/xdp/xdp_umem.c                         |   2 +-
 security/tomoyo/domain.c                   |   2 +-
 virt/kvm/async_pf.c                        |   3 +-
 virt/kvm/kvm_main.c                        |   2 +-
 30 files changed, 132 insertions(+), 161 deletions(-)

-- 
2.40.0

