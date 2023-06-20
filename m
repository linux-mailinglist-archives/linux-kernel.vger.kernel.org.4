Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AF87360CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFTAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 20:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjFTAni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 20:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544E910C7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687221769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VAsnh4By1Dlsxa7yVRPYZeW4lQVXq7K2JYovOcCMg38=;
        b=C8M1n/eyoafRoFoOQRi/q3DHqb1nrtR5SoPNNNJzNHxGu7B3hjRoXovGaTtnUMKk6bWXgO
        cCZ4EGOg9RN99iY0OyA5w6FNAsiNAHTbW9S21e2tO114paEegqRMzBAWHa9hbf140U3ik/
        JhkIVfdZSzfBtYe8zWcbLF37QY5FAGQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-uGBiafsaPumxctaSvtplFQ-1; Mon, 19 Jun 2023 20:42:45 -0400
X-MC-Unique: uGBiafsaPumxctaSvtplFQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-513f337d478so2272586a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 17:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687221764; x=1689813764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAsnh4By1Dlsxa7yVRPYZeW4lQVXq7K2JYovOcCMg38=;
        b=aT4oOT6KxBCNCrt/2DFq+CXP7QUet4AwoolepaZJ0TYrHTQu6bxORW42ehkOBX4uxv
         IM2FzAZRNoEbDBXuHbQTOnnEQ8p14QsCdsvgeQyyvGNR1yVMpLYtAyDzLysRcR9kaV68
         lWGeDpc8+lzJDDAj2d9XPbbgOpRGPPsAFN6FA/AvRVcmThQyk2dHVJxtJX0QibXdMEy4
         XkhlLiIZLuEuAY3YDvsoYLGAd4nQMiH5EEK3lwKh9+OeTKKbJJy+YP+RQ5d01uV+QjkN
         eEj96yMdwSMuBDjvD/Lx8432zODtzxAdLWdYpOHwY7zN5tYV54tFTXm9LpDKe5S0PwUj
         eUZA==
X-Gm-Message-State: AC+VfDzvnYAv+liKi00EFzfVVh1rmZwIPoepG5H+bG0VV5zs24CvbedS
        NljySoJIzt6VvvtjS30eq1TMRdmO8if6Z8xvHbLGXgPnnOSOA+mjRhpE5Om92mjfEcjF9kehXNR
        9tIg5Ew9HrRBH5JUEnwpWVftV
X-Received: by 2002:a17:907:36c3:b0:988:fa98:2e7f with SMTP id bj3-20020a17090736c300b00988fa982e7fmr1299779ejc.38.1687221764004;
        Mon, 19 Jun 2023 17:42:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7HGMiGgWF6PMVUZoQgQKDhuvm3Qm7rw1HXP9heC2ekHKnGIcfwVvW2zWncnuxi/qoMwFCVhw==
X-Received: by 2002:a17:907:36c3:b0:988:fa98:2e7f with SMTP id bj3-20020a17090736c300b00988fa982e7fmr1299766ejc.38.1687221763782;
        Mon, 19 Jun 2023 17:42:43 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906b31600b00982c0ac984asm386091ejz.176.2023.06.19.17.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 17:42:43 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v5 04/14] drm: debugfs: provide infrastructure to dump a DRM GPU VA space
Date:   Tue, 20 Jun 2023 02:42:07 +0200
Message-Id: <20230620004217.4700-5-dakr@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620004217.4700-1-dakr@redhat.com>
References: <20230620004217.4700-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_debugfs.c | 41 +++++++++++++++++++++++++++++++++++
 include/drm/drm_debugfs.h     | 25 +++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4855230ba2c6..82180fb1c200 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -39,6 +39,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_gpuva_mgr.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -175,6 +176,46 @@ static const struct file_operations drm_debugfs_fops = {
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
+	DRM_GPUVA_ITER(it, mgr, 0);
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
+	drm_gpuva_iter_for_each(va, it) {
+		if (unlikely(va == &mgr->kernel_alloc_node))
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
2.40.1

