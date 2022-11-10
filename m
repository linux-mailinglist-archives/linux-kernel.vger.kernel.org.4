Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD9624B75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiKJUPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiKJUPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:15:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2D7450BF;
        Thu, 10 Nov 2022 12:15:03 -0800 (PST)
Received: from dimapc.. (unknown [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC6C06602A5B;
        Thu, 10 Nov 2022 20:14:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668111302;
        bh=ZEwQU+trheBVdqE6TGpypedbCXakkhcZVsK8qA6j2yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d9Oc6F3WYzPj3dGZ0Z8FGnzGG0wYRJFtxJc2Jwu4zZba66Ce7DO9bJCmxxGzdK8sH
         LmuUGE7hjzRo4MHk9K8Ca3m1dnE+hj+YOFgH2baYj2PR3Ag3vwtX5a8EIuEXFgHw3c
         oAkeKolGfN/290pp9LzmFPeXSNSgafD6LKaN53mBX2j/WwLTMaoUTPmVjTk0ngxWE4
         feWYL0fGcO/o+ri5L/quUnrCH9zfVWruOb279HQQgKSZ4/U4HpDQD+ZeICx5+y1xhs
         D/06ybLcxJH7/2ILy8VMC5ue8ubgIaXjNOX3iZyDtlyWQmSlm/VL3AaQQBbLYZ821i
         Mh2baW/JznNPQ==
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
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomba@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 6/6] fastrpc: Assert held reservation lock for dma-buf mmapping
Date:   Thu, 10 Nov 2022 23:13:49 +0300
Message-Id: <20221110201349.351294-7-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
References: <20221110201349.351294-1-dmitry.osipenko@collabora.com>
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

When userspace mmaps dma-buf's fd, the dma-buf reservation lock must be
held. Add locking sanity check to the dma-buf mmaping callback to ensure
that the locking assumption won't regress in the future.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/misc/fastrpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1ad580865525..0f467a71b069 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-resv.h>
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -682,6 +683,8 @@ static int fastrpc_mmap(struct dma_buf *dmabuf,
 	struct fastrpc_buf *buf = dmabuf->priv;
 	size_t size = vma->vm_end - vma->vm_start;
 
+	dma_resv_assert_held(dmabuf->resv);
+
 	return dma_mmap_coherent(buf->dev, vma, buf->virt,
 				 FASTRPC_PHYS(buf->phys), size);
 }
-- 
2.37.3

