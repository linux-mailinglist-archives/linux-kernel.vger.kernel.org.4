Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8B70B08B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjEUVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjEUVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 17:00:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC7DD;
        Sun, 21 May 2023 14:00:11 -0700 (PDT)
Received: from workpc.. (109-252-147-95.dynamic.spd-mgts.ru [109.252.147.95])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA93B6605901;
        Sun, 21 May 2023 22:00:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684702810;
        bh=+OAM+FuLsoM/JJ301uDl3dz9cuHMlNKF1T1FvXy0LZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G11I7dSr5BVRWz6xyJybPAD8XIvQ6rhL/dNTU+n4jm6Iw/Sp1I0aFY/pmhjK3VCKL
         wcoJzxehvfxSB8kwEN/Vaj0CaPgy6M2QLu4djPjVF2V6/mZNmwHIr1iLRvTlRVZbFS
         3b77pc+cNlbZzMxCL9uxugEKmVjVXbd1NsCLa9pIDVzyiBfiXIiO3fERemTjpFpPJK
         5BtiHWYf0KoS4cHXuhTrQx3JLw47g4zn4f8GMSqgrg6TyaKD9zJ5X/odVqi+/53UjE
         JnXuBWFtxTsw22Ko42O5pXvSU8ur0U6tg98k7iNse3eyvQxDw7Qw0dSCqNYFdWcSNr
         O+9h/KcEQnjHg==
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
Subject: [PATCH v3 3/6] udmabuf: Don't assert held reservation lock for dma-buf mmapping
Date:   Sun, 21 May 2023 23:51:09 +0300
Message-Id: <20230521205112.150206-4-dmitry.osipenko@collabora.com>
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

Don't assert held dma-buf reservation lock on memory mapping of exported
buffer.

We're going to change dma-buf mmap() locking policy such that exporters
will have to handle the lock. The previous locking policy caused deadlock
problem for DRM drivers in a case of self-imported dma-bufs once these
drivers are moved to use reservation lock universally. The problem is
solved by moving the lock down to exporters. This patch prepares udmabuf
for the locking policy update.

Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/dma-buf/udmabuf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 01f2e86f3f7c..06729cd60136 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -52,8 +52,6 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 {
 	struct udmabuf *ubuf = buf->priv;
 
-	dma_resv_assert_held(buf->resv);
-
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-- 
2.40.1

