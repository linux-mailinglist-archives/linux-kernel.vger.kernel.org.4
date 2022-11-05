Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839D761DFA6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 00:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiKEX3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 19:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKEX3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 19:29:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3C10B44
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 16:29:03 -0700 (PDT)
Received: from dimapc.. (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95158660238B;
        Sat,  5 Nov 2022 23:28:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667690941;
        bh=HY3jByZOhIouY34XB68EiSAMQWVk92uiCiyD+1rVWoc=;
        h=From:To:Cc:Subject:Date:From;
        b=Hlx8GuJfaALO5LgKJC9VAc76F84DLXDaUgW1ytwSU/0+3CCpiuJbzErfB/YfRCJph
         5aEWQZweA2Z2h3c8s2Z1PMtDsotCXTYzyIjD0UQDuX8aBFzjjRsM/zVM5QcIMgg6nk
         ayzfiAtRJFl2dEyXxaRW2CS6REyU/0jp72qXH4tkx4sL7bhZUqVZ0P9bgzvx3EKKY9
         sBd+eapxhMt02ZIOlNDcrau14SGStR3qznRxBQgkfeBYXkJ1eY6vgZjSQBVrN+kMpM
         OQ4it0siEorvr0S5vvB5iA+xTbfpGRXn22v9Zvl0T5eYAHVPtPxV/7yXochXIwH35E
         xUDpObMozLH6Q==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Herring <robh@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>, kernel@collabora.com,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 0/7] Add generic memory shrinker to VirtIO-GPU and Panfrost DRM drivers
Date:   Sun,  6 Nov 2022 02:27:12 +0300
Message-Id: <20221105232719.302619-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
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

Related patches:

Mesa: https://gitlab.freedesktop.org/digetx/mesa/-/commits/virgl-madvise
igt:  https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/commits/virtio-madvise
      https://gitlab.freedesktop.org/digetx/igt-gpu-tools/-/commits/panfrost-madvise

I'll upstream Mesa and igt patches once kernel part will be merged.

Changelog:

v8: - Rebased on top of recent linux-next that now has dma-buf locking
      convention patches merged, which was blocking shmem shrinker before.

    - Shmem shrinker now uses new drm_gem_lru helper.

    - Dropped Steven Price t-b from the Panfrost patch because code
      changed significantly since v6 and should be re-tested.

v7: - dma-buf locking convention

v6: https://lore.kernel.org/dri-devel/20220526235040.678984-1-dmitry.osipenko@collabora.com/

Dmitry Osipenko (7):
  drm/msm/gem: Prevent blocking within shrinker loop
  drm/shmem-helper: Don't use vmap_use_count for dma-bufs
  drm/shmem-helper: Switch to reservation lock
  drm/shmem-helper: Add memory shrinker
  drm/gem: Add drm_gem_pin_unlocked()
  drm/virtio: Support memory shrinking
  drm/panfrost: Switch to generic memory shrinker

 drivers/gpu/drm/drm_gem.c                     |  38 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 648 ++++++++++++++----
 drivers/gpu/drm/lima/lima_gem.c               |   8 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |   8 +-
 drivers/gpu/drm/panfrost/Makefile             |   1 -
 drivers/gpu/drm/panfrost/panfrost_device.h    |   4 -
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  26 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  33 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h       |   9 -
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  | 122 ----
 drivers/gpu/drm/panfrost/panfrost_job.c       |  18 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  19 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h          |  18 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c          |  55 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |  37 +
 drivers/gpu/drm/virtio/virtgpu_kms.c          |   9 +
 drivers/gpu/drm/virtio/virtgpu_object.c       | 138 +++-
 drivers/gpu/drm/virtio/virtgpu_plane.c        |  22 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c           |  40 ++
 include/drm/drm_device.h                      |   4 +
 include/drm/drm_gem.h                         |   7 +-
 include/drm/drm_gem_shmem_helper.h            |  99 ++-
 include/uapi/drm/virtgpu_drm.h                |  14 +
 23 files changed, 1003 insertions(+), 374 deletions(-)
 delete mode 100644 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c

-- 
2.37.3

