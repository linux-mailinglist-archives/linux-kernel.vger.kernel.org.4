Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205526C73DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjCWXJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWXJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:09:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA11F970
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:09:07 -0700 (PDT)
Received: from workpc.. (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC3226602065;
        Thu, 23 Mar 2023 23:09:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679612946;
        bh=rb/6RO+1PkXC/qjWWlC3SEK8oY5IpI1lDfqo7fZhXC8=;
        h=From:To:Cc:Subject:Date:From;
        b=flXYq59bkgkkKkTYoHGCXEQlUWo0Pvv0vPLZeJmdFvuuRJQoqK7AvF1zTQJ1TNZ8M
         b7CJZCRwroO7DPXepdVTe35k1JQcLD9w0p3ULAD8hiOsC0Ds/P6IeAltfkj5GqdDVN
         uZfoX5UI7i6KRfdSz1WInk5rzDIQL0Li+iuaoMuGBIpXZ3CXjyzJD1Rmh1U3CKuvAt
         d5Op8IRZ5Kb3vETetFjGsxMf7mRMCfqfcvotCIH9rDwng9MiOFBc2h3qeOjxZTq1RT
         Vl6NDgLLi6OAuFvKbeI+Kyf+qKuN4hGVnoPafb3NOa203eaJ9jRcw0zWnKyGU2ThKn
         SwKFKyePUDUXA==
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
Subject: [PATCH v4 0/2] Add sync object UAPI support to VirtIO-GPU driver
Date:   Fri, 24 Mar 2023 02:07:53 +0300
Message-Id: <20230323230755.1094832-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Dmitry Osipenko (2):
  drm/virtio: Refactor job submission code path
  drm/virtio: Support sync objects

 drivers/gpu/drm/virtio/Makefile         |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    |   3 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 182 ---------
 drivers/gpu/drm/virtio/virtgpu_submit.c | 521 ++++++++++++++++++++++++
 include/uapi/drm/virtgpu_drm.h          |  16 +-
 6 files changed, 543 insertions(+), 185 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_submit.c

-- 
2.39.2

