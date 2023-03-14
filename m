Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4766B8897
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCNC2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCNC23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:28:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D1894F42
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:28:17 -0700 (PDT)
Received: from workpc.. (109-252-120-116.nat.spd-mgts.ru [109.252.120.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 921C86603084;
        Tue, 14 Mar 2023 02:28:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678760896;
        bh=xAjXeiazAopZ09RgQtUq/RZsVGdSUXMGWJpbnkE989I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5UldR46GSDJKIean+MrSBdfgoSERmGddNPsk74fROY9CjaVYyk95aMu4wD+peZcF
         DsesVaRnWoF91TgMvjZV2qD0akKjVDIlNRjE9lx9qPME/S0B2lBdqAl1EHnNroLYfZ
         qWfztjTkGx+5dcKUUe67WPejASjmSvoCNS0ljPR0+KPS9e37Yd1Jd3ZmOBRVVJ1gmQ
         CJbbJ+3Q4bMUa1XhJ+hdjmCFxFmWIslk3LhboX9pyhUOVBJ2zeylXE8SYVi4mE8ArY
         otZrIGjEMXLc+DHn0D9ZtqeIXldLK0SiB/0nRYtDTfsMqHglvNkpKYpHiWpBM90U/g
         RqSDNtnbCSnNQ==
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
Subject: [PATCH v13 05/10] drm/shmem-helper: Factor out unpinning part from drm_gem_shmem_purge()
Date:   Tue, 14 Mar 2023 05:26:54 +0300
Message-Id: <20230314022659.1816246-6-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
References: <20230314022659.1816246-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out pages unpinning code from drm_gem_shmem_purge() into new
drm_gem_shmem_unpin_pages(). This prepares code for addition of memory
shrinker support. The new common function will be used by shrinker for
eviction of shmem pages.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 1fcb7d850cc7..48df4e87da26 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -486,25 +486,29 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int madv)
 }
 EXPORT_SYMBOL(drm_gem_shmem_madvise);
 
-void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
+static void drm_gem_shmem_unpin_pages(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 	struct drm_device *dev = obj->dev;
 
 	dma_resv_assert_held(shmem->base.resv);
 
-	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
-
 	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
+	drm_gem_shmem_release_pages(shmem);
+	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
+
 	sg_free_table(shmem->sgt);
 	kfree(shmem->sgt);
 	shmem->sgt = NULL;
+}
 
-	drm_gem_shmem_put_pages(shmem);
+void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
+{
+	struct drm_gem_object *obj = &shmem->base;
 
-	shmem->madv = -1;
+	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
 
-	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
+	drm_gem_shmem_unpin_pages(shmem);
 	drm_gem_free_mmap_offset(obj);
 
 	/* Our goal here is to return as much of the memory as
@@ -515,6 +519,8 @@ void drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem)
 	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1);
 
 	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping, 0, (loff_t)-1);
+
+	shmem->madv = -1;
 }
 EXPORT_SYMBOL(drm_gem_shmem_purge);
 
-- 
2.39.2

