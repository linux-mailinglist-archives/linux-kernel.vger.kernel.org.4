Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A9B70B086
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjEUVAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjEUVAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:00:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5361E3;
        Sun, 21 May 2023 14:00:16 -0700 (PDT)
Received: from workpc.. (109-252-147-95.dynamic.spd-mgts.ru [109.252.147.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0851F6606E66;
        Sun, 21 May 2023 22:00:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684702815;
        bh=0gUDR36aFi1An+7dulD3u+YxPIoB7pS3+8FHmbgN34M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5NSEwwvvVp+9mP99LeyUlEOXBMVzd+hxMjfPq0TG9EJev8dQ8HB/DvM4KsdRqiWb
         oD+WWOq8jkbFlGqJ3K2j9Ne5M+G8py5Xrora1kd+7Kdi2J+gcINNMMBhJlnjl9KNEV
         Y1SnI+ifWFeQSofGJon/idzwXnhwYYHaK7sNz6mWTOi+G2Mx4LzAn4G8Qr3r+ez1G+
         t9xP8j8iAxg8iI8fSsY9rHqS0LHFX1Vro2NGvt/Yo5RT88Ra5WsWdNGy5n2r8oYiPY
         zQLiCpq2nS3QxKStypE2F3W0NBJGgUxztHTuISaXeOgu7ulrHoycgy5bX0kl+3EA7Q
         GiuKRvqb3CRYQ==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
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
Subject: [PATCH v3 5/6] dma-buf: Change locking policy for mmap()
Date:   Sun, 21 May 2023 23:51:11 +0300
Message-Id: <20230521205112.150206-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230521205112.150206-1-dmitry.osipenko@collabora.com>
References: <20230521205112.150206-1-dmitry.osipenko@collabora.com>
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

Change locking policy of mmap() callback, making exporters responsible
for handling dma-buf reservation locking. Previous locking policy stated
that dma-buf is locked for both importers and exporters by the dma-buf
core, which caused a deadlock problem for DRM drivers in a case of
self-imported dma-bufs which required to take the lock from the DRM
exporter side.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/dma-buf.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index aa4ea8530cb3..21916bba77d5 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -131,7 +131,6 @@ static struct file_system_type dma_buf_fs_type = {
 static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 {
 	struct dma_buf *dmabuf;
-	int ret;
 
 	if (!is_dma_buf_file(file))
 		return -EINVAL;
@@ -147,11 +146,7 @@ static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
 	    dmabuf->size >> PAGE_SHIFT)
 		return -EINVAL;
 
-	dma_resv_lock(dmabuf->resv, NULL);
-	ret = dmabuf->ops->mmap(dmabuf, vma);
-	dma_resv_unlock(dmabuf->resv);
-
-	return ret;
+	return dmabuf->ops->mmap(dmabuf, vma);
 }
 
 static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
@@ -850,6 +845,7 @@ static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
  *     - &dma_buf_ops.release()
  *     - &dma_buf_ops.begin_cpu_access()
  *     - &dma_buf_ops.end_cpu_access()
+ *     - &dma_buf_ops.mmap()
  *
  * 2. These &dma_buf_ops callbacks are invoked with locked dma-buf
  *    reservation and exporter can't take the lock:
@@ -858,7 +854,6 @@ static struct sg_table * __map_dma_buf(struct dma_buf_attachment *attach,
  *     - &dma_buf_ops.unpin()
  *     - &dma_buf_ops.map_dma_buf()
  *     - &dma_buf_ops.unmap_dma_buf()
- *     - &dma_buf_ops.mmap()
  *     - &dma_buf_ops.vmap()
  *     - &dma_buf_ops.vunmap()
  *
@@ -1463,8 +1458,6 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BUF);
 int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 		 unsigned long pgoff)
 {
-	int ret;
-
 	if (WARN_ON(!dmabuf || !vma))
 		return -EINVAL;
 
@@ -1485,11 +1478,7 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
 	vma_set_file(vma, dmabuf->file);
 	vma->vm_pgoff = pgoff;
 
-	dma_resv_lock(dmabuf->resv, NULL);
-	ret = dmabuf->ops->mmap(dmabuf, vma);
-	dma_resv_unlock(dmabuf->resv);
-
-	return ret;
+	return dmabuf->ops->mmap(dmabuf, vma);
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
 
-- 
2.40.1

