Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774F6835B7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjAaSyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAaSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:54:36 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254CC45BD9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:54:35 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e15so19346810ybn.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I0dV/i2VXJOndJhRnYlTGCe3e0/GgtRbZNUL7pMXVXk=;
        b=T6hxpSkr6XuQS+SF7dtwiquIf4q/L5WYJJI40i2MwiZWF+wQAsNhN2NtIV3o2FGDCn
         /tH0N0nPcc5dBdSjybit/qDKKDIfyr0qLf0/BrcbtY+d19Y+XCTNLkzGujyuKfhQ+924
         8FP87sV2IDLVwLMrPyMoP+zE4v2rh5xS7tMI3Ono/duqhBHT/paSCESJbQlVlPDP9S89
         x4IxxG4/VrU2vsDVQ5+H7KPRAWzsFoZmQvJDMhqLK/VVNa9khAexDS0Wp1qx3/XBvcNr
         tE9iJF/IvcJ9Td9XChYXC9w3x3v1Fj6Z95olB7wlPKDKYSbOg4ZTVGpIBlfE2jFMf+Hr
         JWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0dV/i2VXJOndJhRnYlTGCe3e0/GgtRbZNUL7pMXVXk=;
        b=SE6+GbXqo98O5rMrdvhPp+mw/jB7oCGZYdl3HTO2Ezrdwbq0JuBLRLB9tqa47YdqjS
         svu2kXJlrUjwVLuHLrP+JObDxmoYexyaompJg/2eEvqKCM5PuEuSFmSYpXL8MggVo979
         n2pPhBOqQwLnBzBNTgudwNEaozd6HDInQdX1HAMmNapVD13AHarye4BXoVO/NefZds7W
         KQmvHbceb2UiwQCIo7bFVOB54HMeK4m12ToIyqTKPTkAq04jtdNJPhDd+gT+InTPtz2z
         e2PT6vBOYu+cI+86QVZzthxMFrwVxFDvunRqrLRbWrsZnJdTTfjSKYnW5+eGv5HEWk/W
         Oeig==
X-Gm-Message-State: AO0yUKUbzrLbL33HqU6xNyKzh8d6/MRpbNVLGcYlwMdDht5TcLO+PGfV
        gmnGGKicj/WDudVCJvc4DIb/qcZLTsHv1I0OLbSONA==
X-Google-Smtp-Source: AK7set9KhAQfY6TNVOu6iHnsuQELYYJwWAezNDPgXoNQ86fHQAdx33ZWAW529EUAQg7MMF+9FffhmB7hwgme4fqvsDw=
X-Received: by 2002:a25:2441:0:b0:80b:5988:2045 with SMTP id
 k62-20020a252441000000b0080b59882045mr7286ybk.59.1675191274010; Tue, 31 Jan
 2023 10:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20230126193752.297968-1-surenb@google.com> <20230126193752.297968-5-surenb@google.com>
 <Y9jSFFeHYZE1/yFg@hyeyoo>
In-Reply-To: <Y9jSFFeHYZE1/yFg@hyeyoo>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 31 Jan 2023 10:54:22 -0800
Message-ID: <CAJuCfpEzaVkgQt=C-33jAh1vLVJAjoyM8X5AD9CzyDUJnPDCkw@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:32 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Thu, Jan 26, 2023 at 11:37:49AM -0800, Suren Baghdasaryan wrote:
> > Replace direct modifications to vma->vm_flags with calls to modifier
> > functions to be able to track flag changes and to keep vma locking
> > correctness.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm/kernel/process.c                          |  2 +-
> >  arch/ia64/mm/init.c                                |  8 ++++----
> >  arch/loongarch/include/asm/tlb.h                   |  2 +-
> >  arch/powerpc/kvm/book3s_xive_native.c              |  2 +-
> >  arch/powerpc/mm/book3s64/subpage_prot.c            |  2 +-
> >  arch/powerpc/platforms/book3s/vas-api.c            |  2 +-
> >  arch/powerpc/platforms/cell/spufs/file.c           | 14 +++++++-------
> >  arch/s390/mm/gmap.c                                |  3 +--
> >  arch/x86/entry/vsyscall/vsyscall_64.c              |  2 +-
> >  arch/x86/kernel/cpu/sgx/driver.c                   |  2 +-
> >  arch/x86/kernel/cpu/sgx/virt.c                     |  2 +-
> >  arch/x86/mm/pat/memtype.c                          |  6 +++---
> >  arch/x86/um/mem_32.c                               |  2 +-
> >  drivers/acpi/pfr_telemetry.c                       |  2 +-
> >  drivers/android/binder.c                           |  3 +--
> >  drivers/char/mspec.c                               |  2 +-
> >  drivers/crypto/hisilicon/qm.c                      |  2 +-
> >  drivers/dax/device.c                               |  2 +-
> >  drivers/dma/idxd/cdev.c                            |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 ++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  4 ++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  4 ++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 ++--
> >  drivers/gpu/drm/drm_gem.c                          |  2 +-
> >  drivers/gpu/drm/drm_gem_dma_helper.c               |  3 +--
> >  drivers/gpu/drm/drm_gem_shmem_helper.c             |  2 +-
> >  drivers/gpu/drm/drm_vm.c                           |  8 ++++----
> >  drivers/gpu/drm/etnaviv/etnaviv_gem.c              |  2 +-
> >  drivers/gpu/drm/exynos/exynos_drm_gem.c            |  4 ++--
> >  drivers/gpu/drm/gma500/framebuffer.c               |  2 +-
> >  drivers/gpu/drm/i810/i810_dma.c                    |  2 +-
> >  drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  4 ++--
> >  drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  2 +-
> >  drivers/gpu/drm/msm/msm_gem.c                      |  2 +-
> >  drivers/gpu/drm/omapdrm/omap_gem.c                 |  3 +--
> >  drivers/gpu/drm/rockchip/rockchip_drm_gem.c        |  3 +--
> >  drivers/gpu/drm/tegra/gem.c                        |  5 ++---
> >  drivers/gpu/drm/ttm/ttm_bo_vm.c                    |  3 +--
> >  drivers/gpu/drm/virtio/virtgpu_vram.c              |  2 +-
> >  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c           |  2 +-
> >  drivers/gpu/drm/xen/xen_drm_front_gem.c            |  3 +--
> >  drivers/hsi/clients/cmt_speech.c                   |  2 +-
> >  drivers/hwtracing/intel_th/msu.c                   |  2 +-
> >  drivers/hwtracing/stm/core.c                       |  2 +-
> >  drivers/infiniband/hw/hfi1/file_ops.c              |  4 ++--
> >  drivers/infiniband/hw/mlx5/main.c                  |  4 ++--
> >  drivers/infiniband/hw/qib/qib_file_ops.c           | 13 ++++++-------
> >  drivers/infiniband/hw/usnic/usnic_ib_verbs.c       |  2 +-
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c    |  2 +-
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  |  2 +-
> >  drivers/media/common/videobuf2/videobuf2-vmalloc.c |  2 +-
> >  drivers/media/v4l2-core/videobuf-dma-contig.c      |  2 +-
> >  drivers/media/v4l2-core/videobuf-dma-sg.c          |  4 ++--
> >  drivers/media/v4l2-core/videobuf-vmalloc.c         |  2 +-
> >  drivers/misc/cxl/context.c                         |  2 +-
> >  drivers/misc/habanalabs/common/memory.c            |  2 +-
> >  drivers/misc/habanalabs/gaudi/gaudi.c              |  4 ++--
> >  drivers/misc/habanalabs/gaudi2/gaudi2.c            |  8 ++++----
> >  drivers/misc/habanalabs/goya/goya.c                |  4 ++--
> >  drivers/misc/ocxl/context.c                        |  4 ++--
> >  drivers/misc/ocxl/sysfs.c                          |  2 +-
> >  drivers/misc/open-dice.c                           |  4 ++--
> >  drivers/misc/sgi-gru/grufile.c                     |  4 ++--
> >  drivers/misc/uacce/uacce.c                         |  2 +-
> >  drivers/sbus/char/oradax.c                         |  2 +-
> >  drivers/scsi/cxlflash/ocxl_hw.c                    |  2 +-
> >  drivers/scsi/sg.c                                  |  2 +-
> >  drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |  2 +-
> >  drivers/staging/media/deprecated/meye/meye.c       |  4 ++--
> >  .../media/deprecated/stkwebcam/stk-webcam.c        |  2 +-
> >  drivers/target/target_core_user.c                  |  2 +-
> >  drivers/uio/uio.c                                  |  2 +-
> >  drivers/usb/core/devio.c                           |  3 +--
> >  drivers/usb/mon/mon_bin.c                          |  3 +--
> >  drivers/vdpa/vdpa_user/iova_domain.c               |  2 +-
> >  drivers/vfio/pci/vfio_pci_core.c                   |  2 +-
> >  drivers/vhost/vdpa.c                               |  2 +-
> >  drivers/video/fbdev/68328fb.c                      |  2 +-
> >  drivers/video/fbdev/core/fb_defio.c                |  4 ++--
> >  drivers/xen/gntalloc.c                             |  2 +-
> >  drivers/xen/gntdev.c                               |  4 ++--
> >  drivers/xen/privcmd-buf.c                          |  2 +-
> >  drivers/xen/privcmd.c                              |  4 ++--
> >  fs/aio.c                                           |  2 +-
> >  fs/cramfs/inode.c                                  |  2 +-
> >  fs/erofs/data.c                                    |  2 +-
> >  fs/exec.c                                          |  4 ++--
> >  fs/ext4/file.c                                     |  2 +-
> >  fs/fuse/dax.c                                      |  2 +-
> >  fs/hugetlbfs/inode.c                               |  4 ++--
> >  fs/orangefs/file.c                                 |  3 +--
> >  fs/proc/task_mmu.c                                 |  2 +-
> >  fs/proc/vmcore.c                                   |  3 +--
> >  fs/userfaultfd.c                                   |  2 +-
> >  fs/xfs/xfs_file.c                                  |  2 +-
> >  include/linux/mm.h                                 |  2 +-
> >  kernel/bpf/ringbuf.c                               |  4 ++--
> >  kernel/bpf/syscall.c                               |  4 ++--
> >  kernel/events/core.c                               |  2 +-
> >  kernel/kcov.c                                      |  2 +-
> >  kernel/relay.c                                     |  2 +-
> >  mm/madvise.c                                       |  2 +-
> >  mm/memory.c                                        |  6 +++---
> >  mm/mlock.c                                         |  6 +++---
> >  mm/mmap.c                                          | 10 +++++-----
> >  mm/mprotect.c                                      |  2 +-
> >  mm/mremap.c                                        |  6 +++---
> >  mm/nommu.c                                         | 11 ++++++-----
> >  mm/secretmem.c                                     |  2 +-
> >  mm/shmem.c                                         |  2 +-
> >  mm/vmalloc.c                                       |  2 +-
> >  net/ipv4/tcp.c                                     |  4 ++--
> >  security/selinux/selinuxfs.c                       |  6 +++---
> >  sound/core/oss/pcm_oss.c                           |  2 +-
> >  sound/core/pcm_native.c                            |  9 +++++----
> >  sound/soc/pxa/mmp-sspa.c                           |  2 +-
> >  sound/usb/usx2y/us122l.c                           |  4 ++--
> >  sound/usb/usx2y/usX2Yhwdep.c                       |  2 +-
> >  sound/usb/usx2y/usx2yhwdeppcm.c                    |  2 +-
> >  120 files changed, 188 insertions(+), 199 deletions(-)
> >
>
> Hello Suren,

Hi Hyeonggon,

>
> [...]
>
> Whoa, it's so long.
> Mostly looks fine but two things I'm not sure about:
>
> > diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> > index 9dda47b3fd70..7be4e6c9f120 100644
> > --- a/drivers/misc/open-dice.c
> > +++ b/drivers/misc/open-dice.c
> > @@ -95,12 +95,12 @@ static int open_dice_mmap(struct file *filp, struct vm_area_struct *vma)
> >               if (vma->vm_flags & VM_WRITE)
> >                       return -EPERM;
> >               /* Ensure userspace cannot acquire VM_WRITE later. */
> > -             vma->vm_flags &= ~VM_MAYWRITE;
> > +             vm_flags_clear(vma, VM_MAYSHARE);
> >       }
>
> I think it should be:
>         s/VM_MAYSHARE/VM_MAYWRITE/

Good eye! Yes, this is definitely a bug. Will post a next version with this fix.

>
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index 5c4fff93cd6b..ed49459e343e 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -380,7 +380,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> >        */
> >       if (newflags & VM_LOCKED)
> >               newflags |= VM_IO;
> > -     WRITE_ONCE(vma->vm_flags, newflags);
> > +     vm_flags_reset(vma, newflags);
> >
> >       lru_add_drain();
> >       walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
> > @@ -388,7 +388,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
> >
> >       if (newflags & VM_IO) {
> >               newflags &= ~VM_IO;
> > -             WRITE_ONCE(vma->vm_flags, newflags);
> > +             vm_flags_reset(vma, newflags);
> >       }
> >  }
>
> wondering the if the comment above is still true?
>
>         /*
>          * There is a slight chance that concurrent page migration,
>          * or page reclaim finding a page of this now-VM_LOCKED vma,
>          * will call mlock_vma_folio() and raise page's mlock_count:
>          * double counting, leaving the page unevictable indefinitely.
>          * Communicate this danger to mlock_vma_folio() with VM_IO,
>          * which is a VM_SPECIAL flag not allowed on VM_LOCKED vmas.
>          * mmap_lock is held in write mode here, so this weird
>          * combination should not be visible to other mmap_lock users;
>          * but WRITE_ONCE so rmap walkers must see VM_IO if VM_LOCKED.
>          */
>
> does ACCESS_PRIVATE() still guarentee that compiler cannot mysteriously
> optimize writes like WRITE_ONCE()?

I don't see ACCESS_PRIVATE() providing the same guarantees as
WRITE_ONCE(), therefore I think this also needs to be changed. I'll
need to introduce something like vm_flags_reset_once() and use it
here. vm_flags_reset_once() would do WRITE_ONCE() and otherwise would
be identical to vm_flags_reset().
I'll post a new version with the fixes later today.

Thanks for the review!
Suren.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
