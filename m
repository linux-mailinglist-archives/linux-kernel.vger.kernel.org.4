Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765FB743086
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjF2W22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjF2W2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6A3583
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688077634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDBNWdVA4hQ8PRBsFs3dd+X68qTkUgeiN1mzO/5EjB0=;
        b=efGJvE5D3CqceYv8ays+bnwKgN3OO0iouWPKPosb8k4+u4bZZCU+PM7StZzoizje+nfqi/
        rRwG1F8WNvlya3V7/swR2zpjFDw1FApD/ggx2IzK99b5Lm4Kb1GPmBF4oaMVQv360lOfQR
        C+knly2sH7ljfPms8WazulZqjbRxeR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-KxTTKoszObe9LDxaaIQJ_Q-1; Thu, 29 Jun 2023 18:27:13 -0400
X-MC-Unique: KxTTKoszObe9LDxaaIQJ_Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3140030cacfso706754f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 15:27:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688077632; x=1690669632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDBNWdVA4hQ8PRBsFs3dd+X68qTkUgeiN1mzO/5EjB0=;
        b=Wrn1sXyPdWjW5E2JBFGZEYgR7205W/k+u/AZdt/jGN+l+0qfjVHcOPMYzm+LFTPVel
         uOmVjvg8uLtl51pXPcSaamfN7IV1uqxLZnmZFehStdftBx598hLOUQSFZGlmlF9dwK6i
         C/4H//mjG9nL0rbdyLXxeDxExBmnhQL/FcBwp3MszZ6EYGsEpLe4lTGM1O6DdjCBHStk
         KIdC7hSPyIQO2ScyDWnZpIyfjxvMgS+JxJvEtgnyngFhCqzrxv847VJb7m+moVvFyeoS
         rVp6VBVop9atVf1HWce/w2e7LVSiEItzD/mbX+oaPmBpKw5LNATwXHHjPTvcmfYNEbmh
         M8uw==
X-Gm-Message-State: AC+VfDw0XY1vp621aPwIs4FwwSGQGOiUt7KZzmotwJovUbgzhK2XsVV+
        2b36dMHD47u3SUTCi7SRHGfuHznXT12IDBLnxCojEqqZXA4KNpvQCj6Et57GVlS3d9OKhpcgGHs
        BrwJ4HrI+gjCeAgMy/EUlvOxG
X-Received: by 2002:a05:600c:2148:b0:3fb:a6ee:4cec with SMTP id v8-20020a05600c214800b003fba6ee4cecmr480109wml.33.1688077632335;
        Thu, 29 Jun 2023 15:27:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45jGakkuSnbl5++tJoj+9tUgpS4o4ovKJZ/39GSa2G0gN9WmOBqMUcRyT013xu5vGi42D0MA==
X-Received: by 2002:a05:600c:2148:b0:3fb:a6ee:4cec with SMTP id v8-20020a05600c214800b003fba6ee4cecmr480101wml.33.1688077632059;
        Thu, 29 Jun 2023 15:27:12 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fbb5506e54sm4001923wmj.29.2023.06.29.15.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:27:11 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v6 03/13] drm: debugfs: provide infrastructure to dump a DRM GPU VA space
Date:   Fri, 30 Jun 2023 00:25:19 +0200
Message-ID: <20230629222651.3196-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629222651.3196-1-dakr@redhat.com>
References: <20230629222651.3196-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a function to dump a DRM GPU VA space and a macro for
drivers to register the struct drm_info_list 'gpuvas' entry.

Most likely, most drivers might maintain one DRM GPU VA space per struct
drm_file, but there might also be drivers not having a fixed relation
between DRM GPU VA spaces and a DRM core infrastructure, hence we need the
indirection via the driver iterating it's maintained DRM GPU VA spaces.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_debugfs.c | 40 +++++++++++++++++++++++++++++++++++
 include/drm/drm_debugfs.h     | 25 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4855230ba2c6..c90dbcffa0dc 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -39,6 +39,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_gpuva_mgr.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -175,6 +176,45 @@ static const struct file_operations drm_debugfs_fops = {
 	.release = single_release,
 };
 
+/**
+ * drm_debugfs_gpuva_info - dump the given DRM GPU VA space
+ * @m: pointer to the &seq_file to write
+ * @mgr: the &drm_gpuva_manager representing the GPU VA space
+ *
+ * Dumps the GPU VA mappings of a given DRM GPU VA manager.
+ *
+ * For each DRM GPU VA space drivers should call this function from their
+ * &drm_info_list's show callback.
+ *
+ * Returns: 0 on success, -ENODEV if the &mgr is not initialized
+ */
+int drm_debugfs_gpuva_info(struct seq_file *m,
+			   struct drm_gpuva_manager *mgr)
+{
+	struct drm_gpuva *va, *kva = &mgr->kernel_alloc_node;
+
+	if (!mgr->name)
+		return -ENODEV;
+
+	seq_printf(m, "DRM GPU VA space (%s) [0x%016llx;0x%016llx]\n",
+		   mgr->name, mgr->mm_start, mgr->mm_start + mgr->mm_range);
+	seq_printf(m, "Kernel reserved node [0x%016llx;0x%016llx]\n",
+		   kva->va.addr, kva->va.addr + kva->va.range);
+	seq_puts(m, "\n");
+	seq_puts(m, " VAs | start              | range              | end                | object             | object offset\n");
+	seq_puts(m, "-------------------------------------------------------------------------------------------------------------\n");
+	drm_gpuva_for_each_va(va, mgr) {
+		if (unlikely(va == kva))
+			continue;
+
+		seq_printf(m, "     | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx\n",
+			   va->va.addr, va->va.range, va->va.addr + va->va.range,
+			   (u64)va->gem.obj, va->gem.offset);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_debugfs_gpuva_info);
 
 /**
  * drm_debugfs_create_files - Initialize a given set of debugfs files for DRM
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index 7616f457ce70..cb2c1956a214 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -34,6 +34,22 @@
 
 #include <linux/types.h>
 #include <linux/seq_file.h>
+
+#include <drm/drm_gpuva_mgr.h>
+
+/**
+ * DRM_DEBUGFS_GPUVA_INFO - &drm_info_list entry to dump a GPU VA space
+ * @show: the &drm_info_list's show callback
+ * @data: driver private data
+ *
+ * Drivers should use this macro to define a &drm_info_list entry to provide a
+ * debugfs file for dumping the GPU VA space regions and mappings.
+ *
+ * For each DRM GPU VA space drivers should call drm_debugfs_gpuva_info() from
+ * their @show callback.
+ */
+#define DRM_DEBUGFS_GPUVA_INFO(show, data) {"gpuvas", show, DRIVER_GEM_GPUVA, data}
+
 /**
  * struct drm_info_list - debugfs info list entry
  *
@@ -134,6 +150,9 @@ void drm_debugfs_add_file(struct drm_device *dev, const char *name,
 
 void drm_debugfs_add_files(struct drm_device *dev,
 			   const struct drm_debugfs_info *files, int count);
+
+int drm_debugfs_gpuva_info(struct seq_file *m,
+			   struct drm_gpuva_manager *mgr);
 #else
 static inline void drm_debugfs_create_files(const struct drm_info_list *files,
 					    int count, struct dentry *root,
@@ -155,6 +174,12 @@ static inline void drm_debugfs_add_files(struct drm_device *dev,
 					 const struct drm_debugfs_info *files,
 					 int count)
 {}
+
+static inline int drm_debugfs_gpuva_info(struct seq_file *m,
+					 struct drm_gpuva_manager *mgr)
+{
+	return 0;
+}
 #endif
 
 #endif /* _DRM_DEBUGFS_H_ */
-- 
2.41.0

