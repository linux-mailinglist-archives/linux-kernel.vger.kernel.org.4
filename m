Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E310C715213
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjE2WqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjE2WqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:46:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48186D2;
        Mon, 29 May 2023 15:46:11 -0700 (PDT)
Received: from workpc.. (109-252-150-34.dynamic.spd-mgts.ru [109.252.150.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 414816605992;
        Mon, 29 May 2023 23:46:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685400369;
        bh=ZiNxP0qBEhRDYC26fKFev4bnhE2oiLkLtrQkBgUqZF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fREDhA5LXqvtyL8w/hGgPvDdUlc+p/OAOYzNUvnBLtjyQukFROvCGPCjwxt2jHOM/
         mhMqg/QmeSruSQy2p0SsRIMxofG27rQMR+hf7/cuXnuhKtghaHqUroMC7a5LKp2v5O
         KjEN/jCNChB9iAYB8/qpjeyq6T3Tsmrv9Cj+EWb0AqViXPymh16TV+mYFW0zIWFift
         4JgJXNy7fe0gebBUqpcl+NkoroUsvC7Iv1IMOM3COb9VcFMlScnVIn4nFrNkZ7l12M
         gb4zv1ATRxitIeN1UVZAIQy2retzcnpQ5Js8Su6UlQD3CaBzbDbWt6Nw7QP48AMpua
         6RYbeGg+ELQkg==
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
Subject: [PATCH v4 1/6] media: videobuf2: Don't assert held reservation lock for dma-buf mmapping
Date:   Tue, 30 May 2023 01:39:30 +0300
Message-Id: <20230529223935.2672495-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
References: <20230529223935.2672495-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't assert held dma-buf reservation lock on memory mapping of exported
buffer.

We're going to change dma-buf mmap() locking policy such that exporters
will have to handle the lock. The previous locking policy caused deadlock
problem for DRM drivers in a case of self-imported dma-bufs once these
drivers are moved to use reservation lock universally. The problem is
solved by moving the lock down to exporters. This patch prepares videobuf2
for the locking policy update.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-dma-contig.c | 3 ---
 drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 3 ---
 drivers/media/common/videobuf2/videobuf2-vmalloc.c    | 3 ---
 3 files changed, 9 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index 205d3cac425c..2fa455d4a048 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -11,7 +11,6 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/dma-resv.h>
 #include <linux/module.h>
 #include <linux/refcount.h>
 #include <linux/scatterlist.h>
@@ -456,8 +455,6 @@ static int vb2_dc_dmabuf_ops_vmap(struct dma_buf *dbuf, struct iosys_map *map)
 static int vb2_dc_dmabuf_ops_mmap(struct dma_buf *dbuf,
 	struct vm_area_struct *vma)
 {
-	dma_resv_assert_held(dbuf->resv);
-
 	return vb2_dc_mmap(dbuf->priv, vma);
 }
 
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 183037fb1273..28f3fdfe23a2 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -10,7 +10,6 @@
  * the Free Software Foundation.
  */
 
-#include <linux/dma-resv.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/refcount.h>
@@ -498,8 +497,6 @@ static int vb2_dma_sg_dmabuf_ops_vmap(struct dma_buf *dbuf,
 static int vb2_dma_sg_dmabuf_ops_mmap(struct dma_buf *dbuf,
 	struct vm_area_struct *vma)
 {
-	dma_resv_assert_held(dbuf->resv);
-
 	return vb2_dma_sg_mmap(dbuf->priv, vma);
 }
 
diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
index a6c6d2fcaaa4..7c635e292106 100644
--- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
+++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
@@ -10,7 +10,6 @@
  * the Free Software Foundation.
  */
 
-#include <linux/dma-resv.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/mm.h>
@@ -319,8 +318,6 @@ static int vb2_vmalloc_dmabuf_ops_vmap(struct dma_buf *dbuf,
 static int vb2_vmalloc_dmabuf_ops_mmap(struct dma_buf *dbuf,
 	struct vm_area_struct *vma)
 {
-	dma_resv_assert_held(dbuf->resv);
-
 	return vb2_vmalloc_mmap(dbuf->priv, vma);
 }
 
-- 
2.40.1

