Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2471520B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjE2WqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjE2WqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:46:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD9EEC;
        Mon, 29 May 2023 15:46:09 -0700 (PDT)
Received: from workpc.. (109-252-150-34.dynamic.spd-mgts.ru [109.252.150.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8BD46660217A;
        Mon, 29 May 2023 23:46:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685400368;
        bh=N/iL1JRZHbQ9J5wEpHGjUIuREtcko5e+/wiJaOIi8L4=;
        h=From:To:Cc:Subject:Date:From;
        b=faMfm4XpdfToTxpu3jT424GwfpAwTcRALVJbPia7nobOTK4KdKtdeUe+SlfmvgfUZ
         QRk9lDQA1yvalx230xcPasAAqkZKbr5DtHewOxourFeUyLQ5bXDGF37PgKJ9kvDI3U
         EO7hBjoXzDiDOnEumIfe4pQazIy/Q/O06CP+k7EZT0Q6bEMjTLgQNZmIUxKRLTGQRW
         +7h25FSiVbycEBPTJGM2iKahpEpbwCIhIr072NGyAppUyrs7UK0Ju+3QR67LgYQdON
         bha23Hn57uvoGHGEUxiH/xyjLTcELOdOQAoaZA0OYjQXxxnC84UNh/pZX4NqBtlF9a
         CETKWVEJ9TUuQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v4 0/6] Move dma-buf mmap() reservation locking down to exporters
Date:   Tue, 30 May 2023 01:39:29 +0300
Message-Id: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset makes dma-buf exporters responisble for taking care of
the reservation lock. I also included patch that moves drm-shmem to use
reservation lock, to let CI test the whole set. I'm going to take all
the patches via the drm-misc tree, please give an ack.

Previous policy stated that dma-buf core takes the lock around mmap()
callback. Which meant that both importers and exporters shouldn't touch
the reservation lock in the mmap() code path. This worked well until
Intel-CI found a deadlock problem in a case of self-imported dma-buf [1].

The problem happens when userpace mmaps a self-imported dma-buf, i.e.
mmaps the dma-buf FD. DRM core treats self-imported dma-bufs as own GEMs
[2]. There is no way to differentiate a prime GEM from a normal GEM for
drm-shmem in drm_gem_shmem_mmap(), which resulted in a deadlock problem
for drm-shmem mmap() code path once it's switched to use reservation lock.

It was difficult to fix the drm-shmem problem without adjusting dma-buf
locking policy. In parctice not much changed from importers perspective
because previosly dma-buf was taking the lock in between of importers
and exporters. Now this lock is shifted down to exporters.

[1] https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_114671v2/shard-snb5/igt@prime_vgem@sync@rcs0.html
[2] https://elixir.bootlin.com/linux/v6.3-rc4/source/drivers/gpu/drm/drm_prime.c#L924

Changelog:

v4: - Added dma_resv_assert_held() to drm_gem_shmem_get_pages(), making
      assert consistent with the put() variant. Suggested by Emil Velikov.

v3: - Added r-b from Hans Verkuil to the videobuf2 patch.

    - The v2 fastrpc patch was already applied, not including it anymore.
      Though, the cover-letter says that I'd want to apply all the patches
      via the drm-misc tree to keep the proper ordering of the changes.

    - Previously Intel's CI gave a flake failure to v2, want to re-test
      it again.

v2: - Added ack from Christian König to the DRM patch.

    - Dropped "fixes" tag from the patches, like was requested by
      Christian König. The patches don't actually need a backport
      and merely improve the locking policy.

    - Dropped "reverts" from the patch titles to prevent them from
      auto-backporting by the stable bot based on the title.

    - Added r-b from Emil Velikov and placed the drm_WARN in the
      drm-shmem patch like he suggested in a comment to v1.

    - Corrected drm-shmem patch dma_resv_lock(obj->resv) inconsistently
      used with dma_resv_unlock(shmem->base.resv). Now shmem->base.resv
      variant is used for all locks/unlocks.

Dmitry Osipenko (6):
  media: videobuf2: Don't assert held reservation lock for dma-buf
    mmapping
  dma-buf/heaps: Don't assert held reservation lock for dma-buf mmapping
  udmabuf: Don't assert held reservation lock for dma-buf mmapping
  drm: Don't assert held reservation lock for dma-buf mmapping
  dma-buf: Change locking policy for mmap()
  drm/shmem-helper: Switch to reservation lock

 drivers/dma-buf/dma-buf.c                     |  17 +-
 drivers/dma-buf/heaps/cma_heap.c              |   3 -
 drivers/dma-buf/heaps/system_heap.c           |   3 -
 drivers/dma-buf/udmabuf.c                     |   2 -
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 210 ++++++++----------
 drivers/gpu/drm/drm_prime.c                   |   2 -
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c    |   2 -
 drivers/gpu/drm/lima/lima_gem.c               |   8 +-
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c     |   2 -
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   7 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |   6 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       |  19 +-
 drivers/gpu/drm/tegra/gem.c                   |   2 -
 .../common/videobuf2/videobuf2-dma-contig.c   |   3 -
 .../media/common/videobuf2/videobuf2-dma-sg.c |   3 -
 .../common/videobuf2/videobuf2-vmalloc.c      |   3 -
 include/drm/drm_gem_shmem_helper.h            |  14 +-
 17 files changed, 119 insertions(+), 187 deletions(-)

-- 
2.40.1

