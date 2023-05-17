Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF7706BB3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjEQOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEQOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:52:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6665259
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:52:47 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4c6c4b425so6328285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684335166; x=1686927166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JUprTNR2AYUu5r4ykuSp6iVwLiXEOaF7GCdZkfyl4I=;
        b=mvPAtFy7apBepnb2BTkYGHlvdW8gzOsxkpjwMwkUvaUINN6vA6MJIgQbwok/QGlH8E
         hz+s2kr8iExnopHTUw8gL7llJFGaxST1HFeU3DvVO9ESvMAddRIW+HC3j7N42WTeU5kT
         uZD9jfR/Pe2bewmosqEXRDxYaOYyI6CGXVK8844+SddYPyX67Qpy6g+pAUY4J3rdMsrp
         NE77iiXnU8al++6TcHl6lxTCA1TFe9oGKXnNiQ/eVddXIdFIHf/md3w1N9dCAbRBrjXS
         xWnuZut8s3j43s0yWg5jT4VJgQRpIaO+nsd/OF++k3Rp0erxFbNkeiWQgiXorBrbFPE1
         nEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684335166; x=1686927166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JUprTNR2AYUu5r4ykuSp6iVwLiXEOaF7GCdZkfyl4I=;
        b=WLmKY+9BHn+hBMtBCpEJtkOZOL2T11xINfZH2GPvYRzoK7zfXdiXMxmj6Ver2PzIhC
         adrCfWlfPtXZP+SviUUAlcPY2ESkpmFjlYVFWK2m0qHGDysR+UKd5Vhyrt1wTsJfl1/j
         6SYL4fQddUm6x9yNI2Q+oYSvfPM2NUBh1SKaDFIRfOS7bDR2xutCT3swT4R7d4NF959h
         q9aXZW7dW1Hfq0TMyxgC5UKByj8W9ylftbma7FkpOXaIH0x3YbGwhguY+vUhOOd24VVm
         ug8Ex/xr2lvgri7Uy2vTWXr03x3Nht09/3KlEdiPnflcuPbfy089F16IBPqvSvwDB0nu
         pplg==
X-Gm-Message-State: AC+VfDxMKWEavCXPN42WbyIN7M28VNk4wzR65ofhPgW77FWZngfJUk3u
        gL+eLyICD8keUEWeBXCRlhi0Jg==
X-Google-Smtp-Source: ACHHUZ7uV59fB+OW0baGaDbzIBdg1HfxU+jbrYxN5WEdFry9HrBC7HW5wsz8930CXaIqsQmv/54a7g==
X-Received: by 2002:a1c:7c0f:0:b0:3f4:219f:5b7a with SMTP id x15-20020a1c7c0f000000b003f4219f5b7amr23742232wmc.30.1684335166168;
        Wed, 17 May 2023 07:52:46 -0700 (PDT)
Received: from blaptop.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d678b000000b002f7780eee10sm2979098wru.59.2023.05.17.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:52:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, jstephan@baylibre.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 2/7] drm/apu: Add memory allocator
Date:   Wed, 17 May 2023 16:52:32 +0200
Message-Id: <20230517145237.295461-3-abailon@baylibre.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517145237.295461-1-abailon@baylibre.com>
References: <20230517145237.295461-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new ioctl to allocate GEM object.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/gpu/drm/apu/Makefile       |  1 +
 drivers/gpu/drm/apu/apu_drv.c      |  2 ++
 drivers/gpu/drm/apu/apu_gem.c      | 56 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/apu/apu_internal.h | 30 ++++++++++++++++
 include/uapi/drm/apu_drm.h         | 16 ++++++++-
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/apu/apu_gem.c

diff --git a/drivers/gpu/drm/apu/Makefile b/drivers/gpu/drm/apu/Makefile
index ad85b88a8b52..91894250d4c1 100644
--- a/drivers/gpu/drm/apu/Makefile
+++ b/drivers/gpu/drm/apu/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 drm_apu-y += apu_drv.o
+drm_apu-y += apu_gem.o
 
 obj-$(CONFIG_DRM_APU) += drm_apu.o
diff --git a/drivers/gpu/drm/apu/apu_drv.c b/drivers/gpu/drm/apu/apu_drv.c
index b420b13a9ffd..323e267b0f53 100644
--- a/drivers/gpu/drm/apu/apu_drv.c
+++ b/drivers/gpu/drm/apu/apu_drv.c
@@ -20,6 +20,8 @@ static int ioctl_apu_state(struct drm_device *dev, void *data,
 static const struct drm_ioctl_desc ioctls[] = {
 	DRM_IOCTL_DEF_DRV(APU_STATE, ioctl_apu_state,
 			  DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(APU_GEM_NEW, ioctl_gem_new,
+			  DRM_RENDER_ALLOW),
 };
 
 DEFINE_DRM_GEM_DMA_FOPS(apu_drm_ops);
diff --git a/drivers/gpu/drm/apu/apu_gem.c b/drivers/gpu/drm/apu/apu_gem.c
new file mode 100644
index 000000000000..0e7b3b27942c
--- /dev/null
+++ b/drivers/gpu/drm/apu/apu_gem.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright 2020 BayLibre SAS
+
+#include <drm/drm_gem_dma_helper.h>
+
+#include <uapi/drm/apu_drm.h>
+
+#include "apu_internal.h"
+
+struct drm_gem_object *apu_gem_create_object(struct drm_device *dev,
+					     size_t size)
+{
+	struct drm_gem_dma_object *dma_obj;
+
+	dma_obj = drm_gem_dma_create(dev, size);
+	if (!dma_obj)
+		return NULL;
+
+	return &dma_obj->base;
+}
+
+int ioctl_gem_new(struct drm_device *dev, void *data,
+		  struct drm_file *file_priv)
+{
+	struct drm_apu_gem_new *args = data;
+	struct drm_gem_dma_object *dma_obj;
+	struct apu_gem_object *apu_obj;
+	struct drm_gem_object *gem_obj;
+	int ret;
+
+	dma_obj = drm_gem_dma_create(dev, args->size);
+	if (IS_ERR(dma_obj))
+		return PTR_ERR(dma_obj);
+
+	gem_obj = &dma_obj->base;
+	apu_obj = to_apu_bo(gem_obj);
+
+	/*
+	 * Save the size of buffer expected by application instead of the
+	 * aligned one.
+	 */
+	apu_obj->size = args->size;
+	apu_obj->offset = 0;
+	mutex_init(&apu_obj->mutex);
+
+	ret = drm_gem_handle_create(file_priv, gem_obj, &args->handle);
+	drm_gem_object_put(gem_obj);
+	if (ret) {
+		drm_gem_dma_object_free(gem_obj);
+		return ret;
+	}
+	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/apu/apu_internal.h b/drivers/gpu/drm/apu/apu_internal.h
index 58d93a16c68f..203aadc58b72 100644
--- a/drivers/gpu/drm/apu/apu_internal.h
+++ b/drivers/gpu/drm/apu/apu_internal.h
@@ -3,6 +3,14 @@
 #define __APU_INTERNAL_H__
 
 #include <drm/drm_drv.h>
+#include <drm/drm_gem_dma_helper.h>
+
+struct apu_gem_object {
+	struct drm_gem_dma_object base;
+	struct mutex mutex;
+	size_t size;
+	u32 offset;
+};
 
 struct apu_core {
 	int device_id;
@@ -54,6 +62,17 @@ struct apu_core_ops {
 	int (*is_ready)(struct apu_core *core);
 };
 
+static inline struct apu_gem_object *to_apu_bo(struct drm_gem_object *obj)
+{
+	return container_of(to_drm_gem_dma_obj(obj), struct apu_gem_object,
+			    base);
+}
+
+static inline void *apu_drm_priv(struct apu_core *apu_core)
+{
+	return apu_core->dev_priv;
+}
+
 struct apu_drm *apu_dev_alloc(struct device *dev);
 int apu_dev_register(struct apu_drm *apu);
 void apu_dev_unregister(struct apu_drm *apu);
@@ -65,4 +84,15 @@ int apu_core_register(struct device *dev, struct apu_core *core, void *priv);
 void apu_core_remove(struct apu_core *core);
 struct apu_core *apu_find_core_by_priv(void *priv);
 
+struct apu_gem_object *to_apu_bo(struct drm_gem_object *obj);
+struct drm_gem_object *apu_gem_create_object(struct drm_device *dev,
+					     size_t size);
+
+int ioctl_gem_new(struct drm_device *dev, void *data,
+		  struct drm_file *file_priv);
+int ioctl_gem_user_new(struct drm_device *dev, void *data,
+		       struct drm_file *file_priv);
+struct dma_buf *apu_gem_prime_export(struct drm_gem_object *gem,
+				     int flags);
+
 #endif /* __APU_INTERNAL_H__ */
diff --git a/include/uapi/drm/apu_drm.h b/include/uapi/drm/apu_drm.h
index d50c63d1b813..14fc478f45dc 100644
--- a/include/uapi/drm/apu_drm.h
+++ b/include/uapi/drm/apu_drm.h
@@ -9,6 +9,18 @@
 extern "C" {
 #endif
 
+/*
+ * Please note that modifications to all structs defined here are
+ * subject to backwards-compatibility constraints.
+ */
+
+struct drm_apu_gem_new {
+	__u32 size;			/* in */
+	__u32 flags;			/* in */
+	__u32 handle;			/* out */
+	__u64 offset;			/* out */
+};
+
 #define APU_ONLINE		BIT(0)
 
 struct drm_apu_state {
@@ -17,9 +29,11 @@ struct drm_apu_state {
 };
 
 #define DRM_APU_STATE			0x00
-#define DRM_APU_NUM_IOCTLS		0x01
+#define DRM_APU_GEM_NEW			0x01
+#define DRM_APU_NUM_IOCTLS		0x02
 
 #define DRM_IOCTL_APU_STATE		DRM_IOWR(DRM_COMMAND_BASE + DRM_APU_STATE, struct drm_apu_state)
+#define DRM_IOCTL_APU_GEM_NEW		DRM_IOWR(DRM_COMMAND_BASE + DRM_APU_GEM_NEW, struct drm_apu_gem_new)
 
 #if defined(__cplusplus)
 }
-- 
2.39.2

