Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781D66AB2C5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCEWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:11:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291913D4A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 14:11:28 -0800 (PST)
Received: from workpc.. (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DEDE6602097;
        Sun,  5 Mar 2023 22:11:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678054287;
        bh=VtlMAkBh8fY9xCWhTSNCidwaxxi7vJ8HsX8hoUdvt7A=;
        h=From:To:Cc:Subject:Date:From;
        b=WRPw6sZ8reGpJm+GDgk7+XNUy9kCbuV/JN9gd3zHRY0eDYVrEr7JzQaSA3j3EIKDp
         7WbOo1Pjlr6Cu+Wz8TU7pd2Ni0jdGcEGRxeuo/qAYxMtdgNYyVfJyAoRlc0wCnry/M
         5BE0IQb3zvm6R3WUQROVT06/GSWR0Yh2O+sLj58R2zkxN7vDD5I/iz8bHXBZUCknqv
         NSGnqeK84a/9TuOPso+HBImBC55AkJ6nHuSMJB92O2M4m6ugkiW5RwdFqi/jzuV0VQ
         c79TRjmirRP30J2y3lqwlY+w3LNBcqJU7bcJ/HhY+XM6T/kbkrzSGa1kjzoFweSp1I
         mldqGDPJY50fw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v12 00/11] Add generic memory shrinker to VirtIO-GPU and Panfrost DRM drivers
Date:   Mon,  6 Mar 2023 01:10:00 +0300
Message-Id: <20230305221011.1404672-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series:

  1. Adds common drm-shmem memory shrinker
  2. Enables shrinker for VirtIO-GPU driver
  3. Switches Panfrost driver to the common shrinker

Changelog:

v12:- Fixed the "no previous prototype for function" warning reported by
      kernel build bot for v11.

    - Fixed the missing reservation lock reported by Intel CI for VGEM
      driver. Other drivers using drm-shmem were affected similarly to
      VGEM. The problem was in the dma-buf attachment code path that led
      to drm-shmem pinning function which assumed the held reservation lock
      by drm_gem_pin(). In the past that code path was causing trouble for
      i915 driver and we've changed the locking scheme for the attachment
      code path in the dma-buf core to let exporters to handle the locking
      themselves. After a closer investigation, I realized that my assumption
      about testing of dma-buf export code path using Panfrost driver was
      incorrect. Now I created additional local test to exrecise the Panfrost
      export path. I also reproduced the issue reported by the Intel CI for
      v10. It's all fixed now by making the drm_gem_shmem_pin() to take the
      resv lock by itself.

    - Patches are based on top of drm-tip, CC'd intel-gfx CI for testing.

v11:- Rebased on a recent linux-next. Added new patch as a result:

        drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()

        It's needed by the virtio-gpu driver to swap-in/unevict shmem
        object, previously get_pages_sgt() didn't use locking.

    - Separated the "Add memory shrinker" patch into smaller parts to ease
      the reviewing, as was requested by Thomas Zimmermann:

        drm/shmem-helper: Factor out pages alloc/release from
          drm_gem_shmem_get/put_pages()
        drm/shmem-helper: Add pages_pin_count field
        drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
        drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()

    - Addessed the v10 review comments from Thomas Zimmermann: return errno
      instead of bool, sort code alphabetically, rename function and etc
      minor changes.

    - Added new patch to remove the "map->is_iomem" from drm-shmem, as
      was suggested by Thomas Zimmermann.

    - Added acks and r-b's that were given to v10.

v10:- Was partially applied to misc-fixes/next.

      https://lore.kernel.org/dri-devel/6c16f303-81df-7ebe-85e9-51bb40a8b301@collabora.com/T/

Dmitry Osipenko (11):
  drm/shmem-helper: Switch to reservation lock
  drm/shmem-helper: Factor out pages alloc/release from
    drm_gem_shmem_get/put_pages()
  drm/shmem-helper: Add pages_pin_count field
  drm/shmem-helper: Switch drm_gem_shmem_vmap/vunmap to use pin/unpin
  drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()
  drm/shmem-helper: Add memory shrinker
  drm/shmem-helper: Remove obsoleted is_iomem test
  drm/shmem-helper: Export drm_gem_shmem_get_pages_sgt_locked()
  drm/gem: Export drm_gem_pin/unpin()
  drm/virtio: Support memory shrinking
  drm/panfrost: Switch to generic memory shrinker

 drivers/gpu/drm/drm_gem.c                     |   2 +
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 613 ++++++++++++++----
 drivers/gpu/drm/drm_internal.h                |   2 -
 drivers/gpu/drm/lima/lima_gem.c               |   8 +-
 drivers/gpu/drm/panfrost/Makefile             |   1 -
 drivers/gpu/drm/panfrost/panfrost_device.h    |   4 -
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  34 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  30 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   9 -
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 122 ----
 drivers/gpu/drm/panfrost/panfrost_job.c       |  18 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  19 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  18 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c          |  52 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c          |   8 +
 drivers/gpu/drm/virtio/virtgpu_object.c       | 137 +++-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  22 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c           |  40 ++
 include/drm/drm_device.h                      |  10 +-
 include/drm/drm_gem.h                         |   3 +
 include/drm/drm_gem_shmem_helper.h            |  83 ++-
 include/uapi/drm/virtgpu_drm.h                |  14 +
 23 files changed, 917 insertions(+), 369 deletions(-)
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c

-- 
2.39.2

