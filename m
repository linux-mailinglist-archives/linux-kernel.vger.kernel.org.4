Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F966DE7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjDKW60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjDKW6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:58:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217AE4231;
        Tue, 11 Apr 2023 15:58:07 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i8so424985plt.10;
        Tue, 11 Apr 2023 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+Y9rFqb6JFNxJRIVkTus3EfCZpjMTDt8LZNCNaQpSk=;
        b=Gnjl7xlKzgOD/FJhGOxJSatQoxNL92VZh1T010f+KMpLHbiNZMjI7OWmHq276109UH
         4K8CKrZ4DPT8+9EnkvzjFKLuqWTJR53DQkzE3hdWTh1SlyJmD7d38SELk6BIrnX1brXA
         T9czLy89UglFKjNxrn0eVWxN1wjrlCFqELBa0XskKNZzlgC+ogr2fv0eq4XVr12hhuUi
         B9HQrOatX0K1+5FJRTnv3bQbV/yZfGXLpzAUGKOv60Aye+TC0bNkXJiC7H3U6A/2bS0q
         XQ4IL8tKObllfWhuXE5QlVCU0yd0nMtqs5ZpgdS4dtO6yKpHQvx90a/rzYX85bTvam7Q
         QJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+Y9rFqb6JFNxJRIVkTus3EfCZpjMTDt8LZNCNaQpSk=;
        b=QSH5laOz8AE1m39zgeUSY+yoqzKJNtv/U4SgYIxvY6S4+oC0kx++VavoOZ8rjYCGuJ
         4BzhqvIsjxSpiFF9kacgsepQm86fGtwcSE4kB6wIIpavFNSjOjfQAReQDbxoUXzzqcyG
         IJ0VHHxPtukZO91a/cYfJ2IIGcWn0zg+hY4FZGfWyZrdmroWxgo30tSyQ9ptw0DLf6Tl
         c8Q3LRzBEbyFJqFq9I3MVDHhq+owSmiiw9Egpkmll+vVTAFaV25Q7tIEwD/IsJr15iBD
         9U4rNOmPdhwOT+T0oUgEP7aPkpJ0wpXL889f2wJhcvxTehNuL8zKga722gZSbhhiOP61
         CD8Q==
X-Gm-Message-State: AAQBX9fHUT4HdpRALJ6z+tawjDXTRgu1rjZDr/YFbqBqXFZ87WtQzTA8
        aQvTjvQrLAj65GONmnpDH5c=
X-Google-Smtp-Source: AKy350ZV8ggQN6BVMgCuSSsJXeTi9lsYz/FHoIFgXYmD7SwhxOmNXUaQ+6yjVlQd6SYy9rt71Gz2yQ==
X-Received: by 2002:a17:902:e38b:b0:1a6:4689:fc79 with SMTP id g11-20020a170902e38b00b001a64689fc79mr5681467ple.20.1681253879710;
        Tue, 11 Apr 2023 15:57:59 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001a1abc93eabsm10220811plk.226.2023.04.11.15.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/7] drm: Add fdinfo memory stats
Date:   Tue, 11 Apr 2023 15:56:11 -0700
Message-Id: <20230411225725.2032862-7-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411225725.2032862-1-robdclark@gmail.com>
References: <20230411225725.2032862-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add support to dump GEM stats to fdinfo.

v2: Fix typos, change size units to match docs, use div_u64
v3: Do it in core

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Documentation/gpu/drm-usage-stats.rst | 21 ++++++++
 drivers/gpu/drm/drm_file.c            | 76 +++++++++++++++++++++++++++
 include/drm/drm_file.h                |  1 +
 include/drm/drm_gem.h                 | 19 +++++++
 4 files changed, 117 insertions(+)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index b46327356e80..b5e7802532ed 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -105,6 +105,27 @@ object belong to this client, in the respective memory region.
 Default unit shall be bytes with optional unit specifiers of 'KiB' or 'MiB'
 indicating kibi- or mebi-bytes.
 
+- drm-shared-memory: <uint> [KiB|MiB]
+
+The total size of buffers that are shared with another file (ie. have more
+than a single handle).
+
+- drm-private-memory: <uint> [KiB|MiB]
+
+The total size of buffers that are not shared with another file.
+
+- drm-resident-memory: <uint> [KiB|MiB]
+
+The total size of buffers that are resident in system memory.
+
+- drm-purgeable-memory: <uint> [KiB|MiB]
+
+The total size of buffers that are purgeable.
+
+- drm-active-memory: <uint> [KiB|MiB]
+
+The total size of buffers that are active on one or more rings.
+
 - drm-cycles-<str> <uint>
 
 Engine identifier string must be the same as the one specified in the
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 37dfaa6be560..46fdd843bb3a 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -42,6 +42,7 @@
 #include <drm/drm_client.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/drm_print.h>
 
 #include "drm_crtc_internal.h"
@@ -871,6 +872,79 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
 }
 EXPORT_SYMBOL(drm_send_event);
 
+static void print_size(struct drm_printer *p, const char *stat, size_t sz)
+{
+	const char *units[] = {"", " KiB", " MiB"};
+	unsigned u;
+
+	for (u = 0; u < ARRAY_SIZE(units) - 1; u++) {
+		if (sz < SZ_1K)
+			break;
+		sz = div_u64(sz, SZ_1K);
+	}
+
+	drm_printf(p, "%s:\t%zu%s\n", stat, sz, units[u]);
+}
+
+static void print_memory_stats(struct drm_printer *p, struct drm_file *file)
+{
+	struct drm_gem_object *obj;
+	struct {
+		size_t shared;
+		size_t private;
+		size_t resident;
+		size_t purgeable;
+		size_t active;
+	} size = {0};
+	bool has_status = false;
+	int id;
+
+	spin_lock(&file->table_lock);
+	idr_for_each_entry (&file->object_idr, obj, id) {
+		enum drm_gem_object_status s = 0;
+
+		if (obj->funcs && obj->funcs->status) {
+			s = obj->funcs->status(obj);
+			has_status = true;
+		}
+
+		if (obj->handle_count > 1) {
+			size.shared += obj->size;
+		} else {
+			size.private += obj->size;
+		}
+
+		if (s & DRM_GEM_OBJECT_RESIDENT) {
+			size.resident += obj->size;
+		} else {
+			/* If already purged or not yet backed by pages, don't
+			 * count it as purgeable:
+			 */
+			s &= ~DRM_GEM_OBJECT_PURGEABLE;
+		}
+
+		if (!dma_resv_test_signaled(obj->resv, dma_resv_usage_rw(true))) {
+			size.active += obj->size;
+
+			/* If still active, don't count as purgeable: */
+			s &= ~DRM_GEM_OBJECT_PURGEABLE;
+		}
+
+		if (s & DRM_GEM_OBJECT_PURGEABLE)
+			size.purgeable += obj->size;
+	}
+	spin_unlock(&file->table_lock);
+
+	print_size(p, "drm-shared-memory", size.shared);
+	print_size(p, "drm-private-memory", size.private);
+	print_size(p, "drm-active-memory", size.active);
+
+	if (has_status) {
+		print_size(p, "drm-resident-memory", size.resident);
+		print_size(p, "drm-purgeable-memory", size.purgeable);
+	}
+}
+
 /**
  * drm_fop_show_fdinfo - helper for drm file fops
  * @seq_file: output stream
@@ -904,6 +978,8 @@ void drm_fop_show_fdinfo(struct seq_file *m, struct file *f)
 
 	if (dev->driver->show_fdinfo)
 		dev->driver->show_fdinfo(&p, file);
+
+	print_memory_stats(&p, file);
 }
 EXPORT_SYMBOL(drm_fop_show_fdinfo);
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index dfa995b787e1..e5b40084538f 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -41,6 +41,7 @@
 struct dma_fence;
 struct drm_file;
 struct drm_device;
+struct drm_printer;
 struct device;
 struct file;
 
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 189fd618ca65..213917bb6b11 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -42,6 +42,14 @@
 struct iosys_map;
 struct drm_gem_object;
 
+/**
+ * enum drm_gem_object_status - bitmask of object state for fdinfo reporting
+ */
+enum drm_gem_object_status {
+	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
+	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
+};
+
 /**
  * struct drm_gem_object_funcs - GEM object functions
  */
@@ -174,6 +182,17 @@ struct drm_gem_object_funcs {
 	 */
 	int (*evict)(struct drm_gem_object *obj);
 
+	/**
+	 * @status:
+	 *
+	 * The optional status callback can return additional object state
+	 * which determines which stats the object is counted against.  The
+	 * callback is called under table_lock.  Racing against object status
+	 * change is "harmless", and the callback can expect to not race
+	 * against object destruction.
+	 */
+	enum drm_gem_object_status (*status)(struct drm_gem_object *obj);
+
 	/**
 	 * @vm_ops:
 	 *
-- 
2.39.2

