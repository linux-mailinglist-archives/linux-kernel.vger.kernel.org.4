Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7924B6E37CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDPLx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDPLxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:53:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC961994
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:53:21 -0700 (PDT)
Received: from workpc.. (unknown [IPv6:2a00:1370:817e:4eb4:c5e6:4b85:1e3f:55e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDE8B660319E;
        Sun, 16 Apr 2023 12:53:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681645999;
        bh=FkYO+x/u3YVxGfLAKJJ1t4hdG2gPB6hao8IzeGN4bm8=;
        h=From:To:Cc:Subject:Date:From;
        b=YAEAIAiEcALrBf8Sl6gsXKRhl0f4i1JRkZzirnx97lBG0+LkU/OVYYDM5g0izi2BC
         CxE5jYtcSbBccKos/LpAq7gel9IyZNfzx2VmBjrlqz7hRbdFXcILuWNjhlVJSuYfPl
         SQA7pgjEEqBFak5vavkYxmi9tD3tHi3VLUSGYYlG9SYLeHAp+IuQyoUvLV7IwcAOfd
         no4pQMopU0Qzn3OMgbCI+118hjWNKqdY8wj4kx9nduc8W4myP8kBqpcBNy6g1ilSZN
         YaBP8cZD4hkZGPtA3SouNk8yVFmZWYldgWF+PwJa7zBoZOsSdqtQBliVZDB0rHlvkK
         5BoOIp49eaJlw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
Date:   Sun, 16 Apr 2023 14:52:34 +0300
Message-Id: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have multiple Vulkan context types that are awaiting for the addition
of the sync object DRM UAPI support to the VirtIO-GPU kernel driver:

 1. Venus context
 2. Native contexts (virtio-freedreno, virtio-intel, virtio-amdgpu)

Mesa core supports DRM sync object UAPI, providing Vulkan drivers with a
generic fencing implementation that we want to utilize.

This patch adds initial sync objects support. It creates fundament for a
further fencing improvements. Later on we will want to extend the VirtIO-GPU
fencing API with passing fence IDs to host for waiting, it will be a new
additional VirtIO-GPU IOCTL and more. Today we have several VirtIO-GPU context
drivers in works that require VirtIO-GPU to support sync objects UAPI.

The patch is heavily inspired by the sync object UAPI implementation of the
MSM driver.

Changelog:

v6: - Added zeroing out of syncobj_desc, as was suggested by Emil Velikov.

    - Fixed memleak in error code path which was spotted by Emil Velikov.

    - Switched to u32/u64 instead of uint_t. Previously was keeping
      uint_t style of the virtgpu_ioctl.c, in the end decided to change
      it because it's not a proper kernel coding style after all.

    - Kept single drm_virtgpu_execbuffer_syncobj struct for both in/out
      sync objects. There was a little concern about whether it would be
      worthwhile to have separate in/out descriptors, in practice it's
      unlikely that we will extend the descs in a foreseeable future.
      There is no overhead in using same struct since we want to pad it
      to 64b anyways and it shouldn't be a problem to separate the descs
      later on if we will want to do that.

    - Added r-b from Emil Velikov.

v5: - Factored out dma-fence unwrap API usage into separate patch as was
      suggested by Emil Velikov.

    - Improved and documented the job submission reorderings as was
      requested by Emil Velikov. Sync file FD is now installed after
      job is submitted to virtio to further optimize reorderings.

    - Added comment for the kvalloc, as was requested by Emil Velikov.

    - The num_in/out_syncobjs now is set only after completed parsing
      of pre/post deps, as was requested by Emil Velikov.

v4: - Added r-b from Rob Clark to the "refactoring" patch.

    - Replaced for/while(ptr && itr) with if (ptr), like was suggested by
      Rob Clark.

    - Dropped NOWARN and NORETRY GFP flags and switched syncobj patch
      to use kvmalloc.

    - Removed unused variables from syncobj patch that were borrowed by
      accident from another (upcoming) patch after one of git rebases.

v3: - Switched to use dma_fence_unwrap_for_each(), like was suggested by
      Rob Clark.

    - Fixed missing dma_fence_put() in error code path that was spotted by
      Rob Clark.

    - Removed obsoleted comment to virtio_gpu_execbuffer_ioctl(), like was
      suggested by Rob Clark.

v2: - Fixed chain-fence context matching by making use of
      dma_fence_chain_contained().

    - Fixed potential uninitialized var usage in error code patch of
      parse_post_deps(). MSM driver had a similar issue that is fixed
      already in upstream.

    - Added new patch that refactors job submission code path. I found
      that it was very difficult to add a new/upcoming host-waits feature
      because of how variables are passed around the code, the virtgpu_ioctl.c
      also was growing to unmanageable size.

Dmitry Osipenko (3):
  drm/virtio: Refactor and optimize job submission code path
  drm/virtio: Wait for each dma-fence of in-fence array individually
  drm/virtio: Support sync objects

 drivers/gpu/drm/virtio/Makefile         |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 182 --------
 drivers/gpu/drm/virtio/virtgpu_submit.c | 530 ++++++++++++++++++++++++
 include/uapi/drm/virtgpu_drm.h          |  16 +-
 6 files changed, 552 insertions(+), 185 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_submit.c

-- 
2.39.2

