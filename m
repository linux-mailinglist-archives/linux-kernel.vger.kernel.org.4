Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DFB6251C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKKDjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:39:20 -0500
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77C2514D07;
        Thu, 10 Nov 2022 19:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8SnPH
        5Qx6ge1EtKB0f/nVg1sCMMgt2pTaFXFocUqJa8=; b=c5Zqxv7RjLUYIxVx+RVnW
        DwURkjfLUI5XBmNpLX8cpiPNSs3ueEPl19EMAeGrpTlwsJPfVknBFld3Oc4dILfB
        ppgfO/V0tg6DzqCfunszw3zq9IFS9zDZfj2GyBcD4INCR8F/ICS6AxsL9+4FdeDm
        i2hcRxAuX/Qu9K4sQcTd84=
Received: from localhost.localdomain (unknown [114.221.197.143])
        by smtp10 (Coremail) with SMTP id DsCowABH7bG4w21jBvxXMA--.32326S2;
        Fri, 11 Nov 2022 11:38:39 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        sumit.semwal@linaro.org, christian.koenig@amd.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        ChunyouTang <tangchunyou@163.com>
Subject: [PATCH v2] drm/gem-shmem: When drm_gem_object_init failed, should release object
Date:   Fri, 11 Nov 2022 11:38:17 +0800
Message-Id: <20221111033817.366-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowABH7bG4w21jBvxXMA--.32326S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4DXw1ruF43JryxZFW7XFb_yoW5Wryrpa
        nxAry7KrW8KFZFgrZ7XF4kCa43Gw40gF4xWaySq3yakr10yF1DXFn8Cr1DAFW3Jr17Xr1a
        q3sFkFySyrWjkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_6wuUUUUUU=
X-Originating-IP: [114.221.197.143]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiYwC2UVaEMNUQPwAAsc
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when goto err_free, the object had init, so it should be release when fail.

Signed-off-by: ChunyouTang <tangchunyou@163.com>
---
 drivers/gpu/drm/drm_gem.c              | 19 ++++++++++++++++---
 drivers/gpu/drm/drm_gem_shmem_helper.c |  4 +++-
 include/drm/drm_gem.h                  |  1 +
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 8b68a3c1e6ab..cba32c46bb05 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -169,6 +169,21 @@ void drm_gem_private_object_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_gem_private_object_init);
 
+/**
+ * drm_gem_private_object_fini - Finalize a failed drm_gem_object
+ * @obj: drm_gem_object
+ *
+ * Uninitialize an already allocated GEM object when it initialized failed
+ */
+void drm_gem_private_object_fini(struct drm_gem_object *obj)
+{
+	WARN_ON(obj->dma_buf);
+
+	dma_resv_fini(&obj->_resv);
+	drm_gem_lru_remove(obj);
+}
+EXPORT_SYMBOL(drm_gem_private_object_fini);
+
 /**
  * drm_gem_object_handle_free - release resources bound to userspace handles
  * @obj: GEM object to clean up.
@@ -930,14 +945,12 @@ drm_gem_release(struct drm_device *dev, struct drm_file *file_private)
 void
 drm_gem_object_release(struct drm_gem_object *obj)
 {
-	WARN_ON(obj->dma_buf);
+	drm_gem_private_object_fini(obj);
 
 	if (obj->filp)
 		fput(obj->filp);
 
-	dma_resv_fini(&obj->_resv);
 	drm_gem_free_mmap_offset(obj);
-	drm_gem_lru_remove(obj);
 }
 EXPORT_SYMBOL(drm_gem_object_release);
 
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 35138f8a375c..845e3d5d71eb 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -79,8 +79,10 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
 	} else {
 		ret = drm_gem_object_init(dev, obj, size);
 	}
-	if (ret)
+	if (ret) {
+		drm_gem_private_object_fini(obj)
 		goto err_free;
+	}
 
 	ret = drm_gem_create_mmap_offset(obj);
 	if (ret)
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index bd42f25e449c..9b1feb03069d 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -405,6 +405,7 @@ int drm_gem_object_init(struct drm_device *dev,
 			struct drm_gem_object *obj, size_t size);
 void drm_gem_private_object_init(struct drm_device *dev,
 				 struct drm_gem_object *obj, size_t size);
+void drm_gem_private_object_fini(struct drm_gem_object *obj);
 void drm_gem_vm_open(struct vm_area_struct *vma);
 void drm_gem_vm_close(struct vm_area_struct *vma);
 int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
-- 
2.25.1

