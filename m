Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD5707205
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEQT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEQT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:26:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFA5583
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f415a90215so11804645e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351533; x=1686943533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=krdZpOePDdbE0nF/pHwU45mYku/jPnhACH422xo4dBQ=;
        b=lZ/tsD0xcExcp1uVfmzwDMzud4MC6A3GmJK9RyCtoRDYOK9zzUrgfb80Ydgb0g2l4f
         6kfqKReWuFzfexwjThTbGd9Tl7wxG2QuUneGYiVZ2hjk9QqArpW5yrqtGsVik1c6tZ7h
         +dvLDtSUhNbOg8uXGNdS33IEyEn9JA6r8eAkhyjl/whJAHlVXrSIeg5p+Wzvs9ZfHL97
         M76l+0eoGhcjPEA4DT5FILL8SXhQQ8xarlxaDe2LrgdcbRgRTFc3BY7jgdLGeDfqL9r6
         o1cu0RRnx/o7XvuqTdv8CO5uaynv3ajaFAFb6cCTVY9l83tKPrGqWfL3GistfGYrXE93
         W+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351533; x=1686943533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=krdZpOePDdbE0nF/pHwU45mYku/jPnhACH422xo4dBQ=;
        b=G0wFjCyRWucMxsjFfw4BQ0x0VI/6KkD2dIatDNwNYEFO+FH7metKDglPh90MUN7hbY
         TK2bS6V5qUkKrGaviGmQfIPJOw5vUYcT1JWa0Ax2dGEfTncQN+oRkPIG6FNrx7sP6bwP
         gWFca5XvEcSgMf2JjiWQPmv/jXvOQ3MzdCDdOCs3C6j41cSWB8qcEjgXwZ9E/7Svu/1e
         3RUoQsjr9meK3KKNX/Jt3pwt1DSSsD4DdudNgEOuGFXm3MGJLRg0GFq5W7mGI7jGK3cP
         nzQdw6Wvk4MSAevZ6j/kcgrJSQOOlib4yYg2apjDaBzZmeBdDkm1yQNLBTE6jbS/RlXn
         eqEw==
X-Gm-Message-State: AC+VfDw6y7jhPJLx03CIZsuZHZWkBR58R4/Ow+MAPRgBzG8aAK4pCspD
        c4tBIBZQYE6yzbRWwQIllniUO4L1ENeSRA==
X-Google-Smtp-Source: ACHHUZ6RCKgAiLRLWeHOHRHN4W3m2S7jL+0mVpg24O1dxpEHSUO6TGAtwZ1PB7VA7bW47TOcMTavyA==
X-Received: by 2002:a05:600c:2146:b0:3f5:60b:31 with SMTP id v6-20020a05600c214600b003f5060b0031mr9091578wml.27.1684351533046;
        Wed, 17 May 2023 12:25:33 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id 5-20020a05600c020500b003f43f82001asm3092398wmi.31.2023.05.17.12.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:25:31 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v6 0/6]  remove the vmas parameter from GUP APIs
Date:   Wed, 17 May 2023 20:25:29 +0100
Message-Id: <cover.1684350871.git.lstoakes@gmail.com>
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

v6:
- Fixed up unused variable warning under !CONFIG_HAVE_IOREMAP_PROT
  reported by Anders Roxell.
- Fixed up use of uninitialised vma parameter on error/no page found
  reported by Dan Carpenter (caused by reuse of code with helper that sets
  vma under different circumstances).
- Fixed up the missed kernel/trace/trace_events_user.c caller.

v5:
- Remove the io_uring open-coded VMA file-backed check, as this is now
  explicitly disallowed by GUP.
- Updated the subsequent patch to eliminate the vmas parameter accordingly.
https://lore.kernel/org/linux-mm/cover.1684097001.git.lstoakes@gmail.com/

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
 kernel/trace/trace_events_user.c           |   2 +-
 mm/gup.c                                   | 105 +++++++--------------
 mm/gup_test.c                              |  14 ++-
 mm/hugetlb.c                               |  24 ++---
 mm/memory.c                                |  20 ++--
 mm/process_vm_access.c                     |   2 +-
 mm/rmap.c                                  |   2 +-
 net/xdp/xdp_umem.c                         |   2 +-
 security/tomoyo/domain.c                   |   2 +-
 virt/kvm/async_pf.c                        |   3 +-
 virt/kvm/kvm_main.c                        |   2 +-
 30 files changed, 142 insertions(+), 182 deletions(-)

--
2.40.1
