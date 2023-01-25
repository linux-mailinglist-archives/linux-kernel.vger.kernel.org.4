Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5467C0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbjAYXgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjAYXgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:36:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4BB2916F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:35:59 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5066df312d7so2028187b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NqN2bLiUSb1ymI8eG/eIv8zLvJCLcEgdnVFKpDVDLGk=;
        b=RbwMwJ+b6j9fhzlZ1IAdL1jD5NRV7iTt+IzqMMe8iCvTCJENwmR1n5f3o0lS+JSKjF
         H+TdrgNfgkr4VyeT0CiHFabaALTt3S2XmQjvtFbLKKzdOcv7M7yseF2d3tWOm7B6ZbJ5
         p4aPQ09ns3CsutdoRWjtP35i04oTdfx3JHmTXY0hWy2imo2zUCcqoxPrY4HmJ+hqg/YD
         ftqr2vSnM2vUTaLhKYvREj1fy12BxiQ8T3bOIf2uQrw4BYKgJeYdlpTjoH2RRaxvxRUA
         RFl7sU7RUY4huRX6Jrtti40j9HesmqDeM4VaSBub+FpMHilEvWIAMTs2Ebm4fUipggdd
         5jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqN2bLiUSb1ymI8eG/eIv8zLvJCLcEgdnVFKpDVDLGk=;
        b=CcZ4tlyuBVp+N5lZWAXnmw0n5Kuk78IGFv+2APSxiG917VJy/3Yg5ywc/woZw8Gl1E
         JzTfqEnrSyGa8GDCxQkmdIGGDYkb9qkBJ52OBq7gRq/ByqioUtEBMOWDQneg4Z1wLg1n
         P0+Qg7afxdCo1Ld7bgDF3/4hvURVdEmLoBoSrdEg+zr78dan/djYz0XO36l8NocdMPdD
         mqGpXhw5XqNEE9/OAviMPzspr/Vp5+GEy59SqGQqGFdcKSmD5Ln3K2LePlJgxFR9+RFT
         rblx9itjNvMROdRxT6Vh8rmOvwN64ADSFZNO7f7/wXmUbtNIMdXawMud9k8JZWAjOkUJ
         UpnQ==
X-Gm-Message-State: AO0yUKVqpMflPuub7cmtGwac5NE3QTbM322kvysWJFEI44i/KoNwHaW9
        CUh4/MTQkJEc/koa64Dd+qGlaW+i798=
X-Google-Smtp-Source: AK7set+63CutG2et9ZbZuyKw0FszIXTAu/Eg7+GQi/bYSVlch14wD2gXCpmM/82+X+UTHdXJ/P4yCFg0YzQ=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:f7b0:20e8:ce66:f98])
 (user=surenb job=sendgmr) by 2002:a81:6946:0:b0:506:527a:5146 with SMTP id
 e67-20020a816946000000b00506527a5146mr698746ywc.178.1674689758527; Wed, 25
 Jan 2023 15:35:58 -0800 (PST)
Date:   Wed, 25 Jan 2023 15:35:47 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230125233554.153109-1-surenb@google.com>
Subject: [PATCH v3 0/7] introduce vm_flags modifier functions
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset was originally published as a part of per-VMA locking [1] and
was split after suggestion that it's viable on its own and to facilitate
the review process. It is now a preprequisite for the next version of per-VMA
lock patchset, which reuses vm_flags modifier functions to lock the VMA when
vm_flags are being updated.

VMA vm_flags modifications are usually done under exclusive mmap_lock
protection because this attrubute affects other decisions like VMA merging
or splitting and races should be prevented. Introduce vm_flags modifier
functions to enforce correct locking.

The patchset applies cleanly over mm-unstable branch of mm tree.

My apologies for an extremely large distribution list. The patch touches
lots of files and many are in arch/ and drivers/.

Changes since v2 [2]
- Add an additional patch to convert vma assignment to a memcpy.
- Change vm_flags to a union of __private and const fields,
per Peter Zijlstra and Matthew Wilcox.
- Changed vm_flags type to vm_flags_t, per Matthew Wilcox.
- Removed unnecessary BUG_ON's from ksm_madvise and hugepage_madvise,
per Michal Hocko.
- Documented mod_vm_flags_nolock usage, per Michal Hocko.

[1] https://lore.kernel.org/all/20230109205336.3665937-1-surenb@google.com/
[2] https://lore.kernel.org/lkml/20230125083851.27759-1-surenb@google.com/

Suren Baghdasaryan (7):
  kernel/fork: convert vma assignment to a memcpy
  mm: introduce vma->vm_flags wrapper functions
  mm: replace VM_LOCKED_CLEAR_MASK with VM_LOCKED_MASK
  mm: replace vma->vm_flags direct modifications with modifier calls
  mm: replace vma->vm_flags indirect modification in ksm_madvise
  mm: introduce mod_vm_flags_nolock and use it in untrack_pfn
  mm: export dump_mm()

 arch/arm/kernel/process.c                     |  2 +-
 arch/ia64/mm/init.c                           |  8 +--
 arch/loongarch/include/asm/tlb.h              |  2 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c            |  5 +-
 arch/powerpc/kvm/book3s_xive_native.c         |  2 +-
 arch/powerpc/mm/book3s64/subpage_prot.c       |  2 +-
 arch/powerpc/platforms/book3s/vas-api.c       |  2 +-
 arch/powerpc/platforms/cell/spufs/file.c      | 14 ++---
 arch/s390/mm/gmap.c                           |  8 ++-
 arch/x86/entry/vsyscall/vsyscall_64.c         |  2 +-
 arch/x86/kernel/cpu/sgx/driver.c              |  2 +-
 arch/x86/kernel/cpu/sgx/virt.c                |  2 +-
 arch/x86/mm/pat/memtype.c                     | 14 +++--
 arch/x86/um/mem_32.c                          |  2 +-
 drivers/acpi/pfr_telemetry.c                  |  2 +-
 drivers/android/binder.c                      |  3 +-
 drivers/char/mspec.c                          |  2 +-
 drivers/crypto/hisilicon/qm.c                 |  2 +-
 drivers/dax/device.c                          |  2 +-
 drivers/dma/idxd/cdev.c                       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  4 +-
 drivers/gpu/drm/drm_gem.c                     |  2 +-
 drivers/gpu/drm/drm_gem_dma_helper.c          |  3 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        |  2 +-
 drivers/gpu/drm/drm_vm.c                      |  8 +--
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_gem.c       |  4 +-
 drivers/gpu/drm/gma500/framebuffer.c          |  2 +-
 drivers/gpu/drm/i810/i810_dma.c               |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c      |  4 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c        |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                 |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c            |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |  3 +-
 drivers/gpu/drm/tegra/gem.c                   |  5 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c               |  3 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c         |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c      |  2 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c       |  3 +-
 drivers/hsi/clients/cmt_speech.c              |  2 +-
 drivers/hwtracing/intel_th/msu.c              |  2 +-
 drivers/hwtracing/stm/core.c                  |  2 +-
 drivers/infiniband/hw/hfi1/file_ops.c         |  4 +-
 drivers/infiniband/hw/mlx5/main.c             |  4 +-
 drivers/infiniband/hw/qib/qib_file_ops.c      | 13 ++---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c  |  2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |  2 +-
 .../common/videobuf2/videobuf2-dma-contig.c   |  2 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |  2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c     |  4 +-
 drivers/media/v4l2-core/videobuf-vmalloc.c    |  2 +-
 drivers/misc/cxl/context.c                    |  2 +-
 drivers/misc/habanalabs/common/memory.c       |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         |  4 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c       |  8 +--
 drivers/misc/habanalabs/goya/goya.c           |  4 +-
 drivers/misc/ocxl/context.c                   |  4 +-
 drivers/misc/ocxl/sysfs.c                     |  2 +-
 drivers/misc/open-dice.c                      |  4 +-
 drivers/misc/sgi-gru/grufile.c                |  4 +-
 drivers/misc/uacce/uacce.c                    |  2 +-
 drivers/sbus/char/oradax.c                    |  2 +-
 drivers/scsi/cxlflash/ocxl_hw.c               |  2 +-
 drivers/scsi/sg.c                             |  2 +-
 .../staging/media/atomisp/pci/hmm/hmm_bo.c    |  2 +-
 drivers/staging/media/deprecated/meye/meye.c  |  4 +-
 .../media/deprecated/stkwebcam/stk-webcam.c   |  2 +-
 drivers/target/target_core_user.c             |  2 +-
 drivers/uio/uio.c                             |  2 +-
 drivers/usb/core/devio.c                      |  3 +-
 drivers/usb/mon/mon_bin.c                     |  3 +-
 drivers/vdpa/vdpa_user/iova_domain.c          |  2 +-
 drivers/vfio/pci/vfio_pci_core.c              |  2 +-
 drivers/vhost/vdpa.c                          |  2 +-
 drivers/video/fbdev/68328fb.c                 |  2 +-
 drivers/video/fbdev/core/fb_defio.c           |  4 +-
 drivers/xen/gntalloc.c                        |  2 +-
 drivers/xen/gntdev.c                          |  4 +-
 drivers/xen/privcmd-buf.c                     |  2 +-
 drivers/xen/privcmd.c                         |  4 +-
 fs/aio.c                                      |  2 +-
 fs/cramfs/inode.c                             |  2 +-
 fs/erofs/data.c                               |  2 +-
 fs/exec.c                                     |  4 +-
 fs/ext4/file.c                                |  2 +-
 fs/fuse/dax.c                                 |  2 +-
 fs/hugetlbfs/inode.c                          |  4 +-
 fs/orangefs/file.c                            |  3 +-
 fs/proc/task_mmu.c                            |  2 +-
 fs/proc/vmcore.c                              |  3 +-
 fs/userfaultfd.c                              |  2 +-
 fs/xfs/xfs_file.c                             |  2 +-
 include/linux/mm.h                            | 55 +++++++++++++++++--
 include/linux/mm_types.h                      | 10 +++-
 include/linux/pgtable.h                       |  5 +-
 kernel/bpf/ringbuf.c                          |  4 +-
 kernel/bpf/syscall.c                          |  4 +-
 kernel/events/core.c                          |  2 +-
 kernel/fork.c                                 |  4 +-
 kernel/kcov.c                                 |  2 +-
 kernel/relay.c                                |  2 +-
 mm/debug.c                                    |  1 +
 mm/hugetlb.c                                  |  4 +-
 mm/madvise.c                                  |  2 +-
 mm/memory.c                                   | 19 ++++---
 mm/memremap.c                                 |  4 +-
 mm/mlock.c                                    | 12 ++--
 mm/mmap.c                                     | 32 ++++++-----
 mm/mprotect.c                                 |  2 +-
 mm/mremap.c                                   |  8 +--
 mm/nommu.c                                    | 11 ++--
 mm/secretmem.c                                |  2 +-
 mm/shmem.c                                    |  2 +-
 mm/vmalloc.c                                  |  2 +-
 net/ipv4/tcp.c                                |  4 +-
 security/selinux/selinuxfs.c                  |  6 +-
 sound/core/oss/pcm_oss.c                      |  2 +-
 sound/core/pcm_native.c                       |  9 +--
 sound/soc/pxa/mmp-sspa.c                      |  2 +-
 sound/usb/usx2y/us122l.c                      |  4 +-
 sound/usb/usx2y/usX2Yhwdep.c                  |  2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c               |  2 +-
 127 files changed, 295 insertions(+), 234 deletions(-)

-- 
2.39.1

