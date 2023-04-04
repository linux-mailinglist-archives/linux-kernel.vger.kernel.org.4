Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAF6D55FA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjDDB2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjDDB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F8D3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=p2e1uu6fhEnZOUa7GJ80xTT8ad8fMkZwy1ewsfJ+2u8=;
        b=FqdivSELeGOfMMjlqzAb7TQnWzebM8CnDIF80Akn2phwREVjVihA/ppMYTVLfkgOuIHx+/
        nTe3kP9qtdOxnk0swZ+/0PEPGC7vUEATbfkJu58Sgk5OUNaKHZYW2PRdo6kwIVBG6WHbYx
        dVUihOuQR3o1YQU50YW7XFMowN35uok=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-sGCXeExWNyu-pWmEPxFRhw-1; Mon, 03 Apr 2023 21:27:48 -0400
X-MC-Unique: sGCXeExWNyu-pWmEPxFRhw-1
Received: by mail-ed1-f71.google.com with SMTP id t26-20020a50d71a000000b005003c5087caso43211768edi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2e1uu6fhEnZOUa7GJ80xTT8ad8fMkZwy1ewsfJ+2u8=;
        b=Lqce3wQy+tsSJenA5XhYg7r7PSgIv5DQrfEwvAMMIwlJ4x+3tzJIfJUDaGW/jmiiJ+
         Vnp6CSu6nv6XsDJWZ1IM4fUm6wifgW/pckRgMR4Ojx7e0+TGHZ3eILNBiw08pvvNP64l
         Sg4o+UzBNkUzcuOP4MJJ0iE4anHh4v/6uBoP88Qm8F2o4jta/WYMA4hWrcT9pGE3CniH
         JmiaKgADwVI5y1yilwxuQ68qPUs0lKDiecnSkvXRcFyVhD1I3BSwjdCrs6mnbk+2Y+Or
         ClyP0Biy9gAlPTxJ5VdNtIH3rK8HhuGvgkKMnm3iG7hcNLYT43fdlKFOZlCnInZz8Obo
         PkcQ==
X-Gm-Message-State: AAQBX9f5ZI4LJvYX/8GZvuXYJGGDV6ZK1gSUMbANjUDs49A8Ii6s7vee
        mQ40dIInEzP88LHLNbp5LRyL05k8ZJEwk7YypjSM0NYM7P/lYDxrfQqUlAcXtUbH9ujbE78vYtF
        8dWIwwSrzK3th8iVJxo7mTDuh
X-Received: by 2002:a17:906:9611:b0:8b1:3483:e3d5 with SMTP id s17-20020a170906961100b008b13483e3d5mr504190ejx.48.1680571666706;
        Mon, 03 Apr 2023 18:27:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350akyO9M11PqcWMXrINDmCl0Cuk934qa2C6ajBxTmTXHmla38g40wLwM7IYC1A1ynUWk0fyfzw==
X-Received: by 2002:a17:906:9611:b0:8b1:3483:e3d5 with SMTP id s17-20020a170906961100b008b13483e3d5mr504173ejx.48.1680571666362;
        Mon, 03 Apr 2023 18:27:46 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id jg21-20020a170907971500b00932ba722482sm5242021ejc.149.2023.04.03.18.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:27:45 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v3 00/15] [RFC] DRM GPUVA Manager & Nouveau VM_BIND UAPI
Date:   Tue,  4 Apr 2023 03:27:26 +0200
Message-Id: <20230404012741.116502-1-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides a new UAPI for the Nouveau driver in order to
support Vulkan features, such as sparse bindings and sparse residency.

Furthermore, with the DRM GPUVA manager it provides a new DRM core feature to
keep track of GPU virtual address (VA) mappings in a more generic way.

The DRM GPUVA manager is indented to help drivers implement userspace-manageable
GPU VA spaces in reference to the Vulkan API. In order to achieve this goal it
serves the following purposes in this context.

    1) Provide infrastructure to track GPU VA allocations and mappings,
       making use of the maple_tree.

    2) Generically connect GPU VA mappings to their backing buffers, in
       particular DRM GEM objects.

    3) Provide a common implementation to perform more complex mapping
       operations on the GPU VA space. In particular splitting and merging
       of GPU VA mappings, e.g. for intersecting mapping requests or partial
       unmap requests.

The new VM_BIND Nouveau UAPI build on top of the DRM GPUVA manager, itself
providing the following new interfaces.

    1) Initialize a GPU VA space via the new DRM_IOCTL_NOUVEAU_VM_INIT ioctl
       for UMDs to specify the portion of VA space managed by the kernel and
       userspace, respectively.

    2) Allocate and free a VA space region as well as bind and unbind memory
       to the GPUs VA space via the new DRM_IOCTL_NOUVEAU_VM_BIND ioctl.

    3) Execute push buffers with the new DRM_IOCTL_NOUVEAU_EXEC ioctl.

Both, DRM_IOCTL_NOUVEAU_VM_BIND and DRM_IOCTL_NOUVEAU_EXEC, make use of the DRM
scheduler to queue jobs and support asynchronous processing with DRM syncobjs
as synchronization mechanism.

By default DRM_IOCTL_NOUVEAU_VM_BIND does synchronous processing,
DRM_IOCTL_NOUVEAU_EXEC supports asynchronous processing only.

The new VM_BIND UAPI for Nouveau makes also use of drm_exec (execution context
for GEM buffers) by Christian König. Since the patch implementing drm_exec was
not yet merged into drm-next it is part of this series, as well as a small fix
for this patch, which was found while testing this series.

This patch series is also available at [1].

There is a Mesa NVK merge request by Dave Airlie [2] implementing the
corresponding userspace parts for this series.

The Vulkan CTS test suite passes the sparse binding and sparse residency test
cases for the new UAPI together with Dave's Mesa work.

There are also some test cases in the igt-gpu-tools project [3] for the new UAPI
and hence the DRM GPU VA manager. However, most of them are testing the DRM GPU
VA manager's logic through Nouveau's new UAPI and should be considered just as
helper for implementation.

However, I absolutely intend to change those test cases to proper kunit test
cases for the DRM GPUVA manager, once and if we agree on it's usefulness and
design.

[1] https://gitlab.freedesktop.org/nouvelles/kernel/-/tree/new-uapi-drm-next /
    https://gitlab.freedesktop.org/nouvelles/kernel/-/merge_requests/1
[2] https://gitlab.freedesktop.org/nouveau/mesa/-/merge_requests/150/
[3] https://gitlab.freedesktop.org/dakr/igt-gpu-tools/-/tree/wip_nouveau_vm_bind

Changes in V2:
==============
  Nouveau:
    - Reworked the Nouveau VM_BIND UAPI to avoid memory allocations in fence
      signalling critical sections. Updates to the VA space are split up in three
      separate stages, where only the 2. stage executes in a fence signalling
      critical section:

        1. update the VA space, allocate new structures and page tables
        2. (un-)map the requested memory bindings
        3. free structures and page tables

    - Separated generic job scheduler code from specific job implementations.
    - Separated the EXEC and VM_BIND implementation of the UAPI.
    - Reworked the locking parts of the nvkm/vmm RAW interface, such that
      (un-)map operations can be executed in fence signalling critical sections.

  GPUVA Manager:
    - made drm_gpuva_regions optional for users of the GPUVA manager
    - allow NULL GEMs for drm_gpuva entries
    - swichted from drm_mm to maple_tree for track drm_gpuva / drm_gpuva_region
      entries
    - provide callbacks for users to allocate custom drm_gpuva_op structures to
      allow inheritance
    - added user bits to drm_gpuva_flags
    - added a prefetch operation type in order to support generating prefetch
      operations in the same way other operations generated
    - hand the responsibility for mutual exclusion for a GEM's
      drm_gpuva list to the user; simplified corresponding (un-)link functions

  Maple Tree:
    - I added two maple tree patches to the series, one to support custom tree
      walk macros and one to hand the locking responsibility to the user of the
      GPUVA manager without pre-defined lockdep checks.

Changes in V3:
==============
  Nouveau:
    - Reworked the Nouveau VM_BIND UAPI to do the job cleanup (including page
      table cleanup) within a workqueue rather than the job_free() callback of
      the scheduler itself. A job_free() callback can stall the execution (run()
      callback) of the next job in the queue. Since the page table cleanup
      requires to take the same locks as need to be taken for page table
      allocation, doing it directly in the job_free() callback would still
      violate the fence signalling critical path.
    - Separated Nouveau fence allocation and emit, such that we do not violate
      the fence signalling critical path in EXEC jobs.
    - Implement "regions" (for handling sparse mappings through PDEs and dual
      page tables) within Nouveau.
    - Drop the requirement for every mapping to be contained within a region.
    - Add necassary synchronization of VM_BIND job operation sequences in order
      to work around limitations in page table handling. This will be addressed
      in a future re-work of Nouveau's page table handling.
    - Fixed a couple of race conditions found through more testing. Thanks to
      Dave for consitently trying to break it. :-)

  GPUVA Manager:
    - Implement pre-allocation capabilities for tree modifications within fence
      signalling critical sections.
    - Implement accessors to to apply tree modification while walking the GPUVA
      tree in order to actually support processing of drm_gpuva_ops through
      callbacks in fence signalling critical sections rather than through
      pre-allocated operation lists.
    - Remove merging of GPUVAs; the kernel has limited to none knowlege about
      the semantics of mapping sequences. Hence, merging is purely speculative.
      It seems that gaining a significant (or at least a measurable) performance
      increase through merging is way more likely to happen when userspace is
      responsible for merging mappings up to the next larger page size if
      possible.
    - Since merging was removed, regions pretty much loose their right to exist.
      They might still be useful for handling dual page tables or similar
      mechanisms, but since Nouveau seems to be the only driver having a need
      for this for now, regions were removed from the GPUVA manager.
    - Fixed a couple of maple_tree related issues; thanks to Liam for helping me
      out.

TODO
====
  Maple Tree:
    - Maple tree uses the 'unsinged long' type for node entries. While this
      works for 64bit, it's incompatible with the DRM GPUVA Manager on 32bit,
      since the DRM GPUVA Manager uses the u64 type and so do drivers using it.
      While it's questionable whether a 32bit kernel and a > 32bit GPU address
      space make any sense, it creates tons of compiler warnings when compiling
      for 32bit. Maybe it makes sense to expand the maple tree API to let users
      decide which size to pick - other ideas / proposals are welcome.

Christian König (1):
  drm: execution context for GEM buffers v3

Danilo Krummrich (14):
  drm_exec: fix double dma_resv unlock
  maple_tree: split up MA_STATE() macro
  drm: manager to keep track of GPUs VA mappings
  drm: debugfs: provide infrastructure to dump a DRM GPU VA space
  drm/nouveau: new VM_BIND uapi interfaces
  drm/nouveau: get vmm via nouveau_cli_vmm()
  drm/nouveau: bo: initialize GEM GPU VA interface
  drm/nouveau: move usercopy helpers to nouveau_drv.h
  drm/nouveau: fence: separate fence alloc and emit
  drm/nouveau: fence: fail to emit when fence context is killed
  drm/nouveau: chan: provide nouveau_channel_kill()
  drm/nouveau: nvkm/vmm: implement raw ops to manage uvmm
  drm/nouveau: implement new VM_BIND uAPI
  drm/nouveau: debugfs: implement DRM GPU VA debugfs

 Documentation/gpu/driver-uapi.rst             |   11 +
 Documentation/gpu/drm-mm.rst                  |   43 +
 drivers/gpu/drm/Kconfig                       |    6 +
 drivers/gpu/drm/Makefile                      |    3 +
 drivers/gpu/drm/drm_debugfs.c                 |   41 +
 drivers/gpu/drm/drm_exec.c                    |  248 +++
 drivers/gpu/drm/drm_gem.c                     |    3 +
 drivers/gpu/drm/drm_gpuva_mgr.c               | 1686 +++++++++++++++
 drivers/gpu/drm/nouveau/Kbuild                |    3 +
 drivers/gpu/drm/nouveau/Kconfig               |    2 +
 drivers/gpu/drm/nouveau/dispnv04/crtc.c       |    9 +-
 drivers/gpu/drm/nouveau/include/nvif/if000c.h |   26 +-
 drivers/gpu/drm/nouveau/include/nvif/vmm.h    |   19 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/mmu.h |   20 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c       |   24 +
 drivers/gpu/drm/nouveau/nouveau_abi16.h       |    1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c          |  204 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h          |    2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c        |   22 +-
 drivers/gpu/drm/nouveau/nouveau_chan.h        |    1 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |   39 +
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |    9 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   27 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h         |   94 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c        |  363 ++++
 drivers/gpu/drm/nouveau/nouveau_exec.h        |   42 +
 drivers/gpu/drm/nouveau/nouveau_fence.c       |   23 +-
 drivers/gpu/drm/nouveau/nouveau_fence.h       |    5 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c         |   62 +-
 drivers/gpu/drm/nouveau/nouveau_mem.h         |    5 +
 drivers/gpu/drm/nouveau/nouveau_prime.c       |    2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c       |  494 +++++
 drivers/gpu/drm/nouveau/nouveau_sched.h       |  116 ++
 drivers/gpu/drm/nouveau/nouveau_svm.c         |    2 +-
 drivers/gpu/drm/nouveau/nouveau_uvmm.c        | 1836 +++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_uvmm.h        |   98 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c         |    4 +-
 drivers/gpu/drm/nouveau/nvif/vmm.c            |  100 +-
 .../gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c    |  213 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  197 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h |   25 +
 .../drm/nouveau/nvkm/subdev/mmu/vmmgf100.c    |   16 +-
 .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |   16 +-
 .../gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c |   27 +-
 include/drm/drm_debugfs.h                     |   25 +
 include/drm/drm_drv.h                         |    6 +
 include/drm/drm_exec.h                        |  115 ++
 include/drm/drm_gem.h                         |   75 +
 include/drm/drm_gpuva_mgr.h                   |  681 ++++++
 include/linux/maple_tree.h                    |    7 +-
 include/uapi/drm/nouveau_drm.h                |  209 ++
 51 files changed, 7065 insertions(+), 242 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_exec.c
 create mode 100644 drivers/gpu/drm/drm_gpuva_mgr.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_exec.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_exec.h
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sched.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_sched.h
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_uvmm.c
 create mode 100644 drivers/gpu/drm/nouveau/nouveau_uvmm.h
 create mode 100644 include/drm/drm_exec.h
 create mode 100644 include/drm/drm_gpuva_mgr.h


base-commit: d36d68fd1925d33066d52468b7c7c6aca6521248
-- 
2.39.2

