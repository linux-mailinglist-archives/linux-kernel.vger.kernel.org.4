Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCD66A95D2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCCLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCLKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:10:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7943C78A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:10:24 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so8611729edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677841823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K5FYDdc7sSLSIAMZoWc2/wxiEoRMU9hcXXxdo10gVSk=;
        b=M1WwVzl71pUp1koByS01lJBH4CNZWUVtsEH0p2/9pyX2WaimDXK53LnsRGySfWbFB6
         oKe317PXhfJw9aX1eFWzbxJQrxZp9nlC8uQtQpbfyO18Lu3bcnU67GcyBNJMoMufmeq+
         WmyXw5MeiZyDfLeBJjJBqfbiUb946Yb9YniFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677841823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5FYDdc7sSLSIAMZoWc2/wxiEoRMU9hcXXxdo10gVSk=;
        b=LGNaieAPqEPgdn/0FfC4IDqzW81xwodqoUP8j11HSqLHS3dYgTI+BgWan5NRSXcbmW
         3moox/Xm+eg8SPuoay26BXN3PdUXwwXn8ZNvxmuN/vqRI9fHKvWr25RWnTmILHIpHs3R
         C2vNmH6n7JfR1z7Z6948VOCTetv1uMmu27cMkZBFO6GOruaGNkS0ke1DNYG7HAw27ans
         MRy7FZfZ9CtMYgzCOvCuN3n9dBGUZT31+xsBVsYmuu2rn7QkKPWg4odfyQljiIbAWbsr
         k0e82ZO66nitf8qUzgqkfxRsX76A6euunNB1mosPJrCct7WGNZiPjwFkUbIw0Jn50on1
         BRlg==
X-Gm-Message-State: AO0yUKWrQAm4Au3Qo19ESsOghLQY/YUBWFWV+k/G6hUNVe8toZO8CNH5
        zFkDKk3+dfGFgxqIX/oBKop9AQ==
X-Google-Smtp-Source: AK7set9ppXBkJz3jap5jG9UKO9bbR6kX7H8NotFsQUiwE2M2PhjbGL8A3s9RVbDHopirBNfp4tDsPA==
X-Received: by 2002:a17:907:98e5:b0:8b3:e24:de0e with SMTP id ke5-20020a17090798e500b008b30e24de0emr1363476ejc.27.1677841823078;
        Fri, 03 Mar 2023 03:10:23 -0800 (PST)
Received: from mmaslanka2.c.googlers.com.com (61.134.90.34.bc.googleusercontent.com. [34.90.134.61])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906454f00b008d8f1b238fdsm842060ejq.149.2023.03.03.03.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 03:10:22 -0800 (PST)
From:   Marek Maslanka <mmaslanka@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Marek Maslanka <mmaslanka@chromium.org>,
        Dominik Behr <dbehr@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Guchun Chen <guchun.chen@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Marek Maslanka <mm@semihalf.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Tong Liu01 <Tong.Liu01@amd.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Implement mmap of imported dma-bufs
Date:   Fri,  3 Mar 2023 11:09:33 +0000
Message-Id: <20230303110951.3777850-1-mmaslanka@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmabuf mmap from exporting driver to do the mapping.

Signed-off-by: Marek Maslanka <mmaslanka@chromium.org>
Signed-off-by: Dominik Behr <dbehr@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 46 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  9 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 0c001bb8fc2b..8f22d29ba077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -37,6 +37,7 @@
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_xgmi.h"
 #include <drm/amdgpu_drm.h>
+#include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
@@ -275,6 +276,51 @@ const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
 
+int amdgpu_try_dma_buf_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct drm_file *priv = filp->private_data;
+	struct drm_device *dev = priv->minor->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct ttm_device *bdev = &adev->mman.bdev;
+	struct ttm_buffer_object *tbo = NULL;
+	struct amdgpu_bo *bo = NULL;
+	struct drm_gem_object *obj = NULL;
+	struct drm_vma_offset_node *node;
+	int ret;
+
+	if (drm_dev_is_unplugged(dev))
+		return -ENODEV;
+
+	drm_vma_offset_lock_lookup(bdev->vma_manager);
+	node = drm_vma_offset_exact_lookup_locked(bdev->vma_manager,
+						  vma->vm_pgoff,
+						  vma_pages(vma));
+
+	if (likely(node)) {
+		tbo = container_of(node, struct ttm_buffer_object,
+				   base.vma_node);
+		tbo = ttm_bo_get_unless_zero(tbo);
+	}
+	drm_vma_offset_unlock_lookup(bdev->vma_manager);
+
+	if (!tbo)
+		return -EINVAL;
+
+	bo = ttm_to_amdgpu_bo(tbo);
+	obj = &tbo->base;
+
+	if (!obj->import_attach) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	ret = dma_buf_mmap(obj->import_attach->dmabuf, vma, 0);
+
+done:
+	ttm_bo_put(tbo);
+	return ret;
+}
+
 /**
  * amdgpu_gem_prime_export - &drm_driver.gem_prime_export implementation
  * @gobj: GEM BO
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
index 3e93b9b407a9..ecf1dc32eec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -25,6 +25,8 @@
 
 #include <drm/drm_gem.h>
 
+int amdgpu_try_dma_buf_mmap(struct file *filp, struct vm_area_struct *vma);
+
 struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 					int flags);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 86fbb4138285..91e94342d48e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2737,7 +2737,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.flush = amdgpu_flush,
 	.release = drm_release,
 	.unlocked_ioctl = amdgpu_drm_ioctl,
-	.mmap = drm_gem_mmap,
+	.mmap = amdgpu_mmap,
 	.poll = drm_poll,
 	.read = drm_read,
 #ifdef CONFIG_COMPAT
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c5ef7f7bdc15..41944439cd6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -61,6 +61,7 @@
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
+#include "amdgpu_dma_buf.h"
 #include "bif/bif_4_1_d.h"
 
 MODULE_IMPORT_NS(DMA_BUF);
@@ -1994,6 +1995,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 						   DMA_RESV_USAGE_BOOKKEEP);
 }
 
+int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	if (amdgpu_try_dma_buf_mmap(filp, vma) == 0)
+		return 0;
+
+	return drm_gem_mmap(filp, vma);
+}
+
 int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e2cd5894afc9..e4cd1bda7a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -152,6 +152,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			struct dma_resv *resv,
 			struct dma_fence **fence);
 
+int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

