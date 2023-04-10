Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459506DCC95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjDJVGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDJVGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:06:23 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370871737;
        Mon, 10 Apr 2023 14:06:22 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j8so4152087pjy.4;
        Mon, 10 Apr 2023 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681160781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJFK/82i55S3LMJhngVaMIQtHLPKCOXYIQAVhENxSX4=;
        b=iQ1YcGademZken7tt39Vxwt10Q+8aCRwzy9R1BvI2zLub/OEjldjGNyD8wjrxIK14d
         C1Nipbmugr14pmM1yuk+yn7B5j7cWCilIr/gnf95raKNcnvyxasiDe6xKvcx9zho1H31
         Dhwnxoo47lY3KdBWBTBMJjqdBeo0K1XA1dYLozfXnoheJPlfBlUy4rytViAgQ7gqBy8g
         g/EaDX8ZuCd3VDCnsaT3VJr3nfCtqHt8Fzxkaq57G234PjoOOQiIgZOPoU3blqZY50Cn
         2m5fOkdqw3WQ1j3OTvSU6Xh1YhluZNhyLcuhKDEfl5UvhWtTmAHlmGwASBkLSD5TyorI
         SJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJFK/82i55S3LMJhngVaMIQtHLPKCOXYIQAVhENxSX4=;
        b=TYinDpFDAWy0tTl5QGXLJv7C7c1Ha6XoJpbRXX63phkiHDq/j2RJS9VrUkV1bMFvuo
         npSZ6Ls6QViwQcesnsy7Ghj3OLXW6NYWbrVyxZMJd9ega6QAbTaXo2HQqJxubHb42U+Z
         nyt1EBRRvgCCx0jrZ+k81UqkJkuxFZgiVHU2tXuXAXlXmNiQxJjdVLKcqXaDJnEE3IUi
         HEedwMgu9F9aKSlK6t/7++GdBV8oRWPqICsyxRfjHdYEUx2oMjLxjZuYehjzhiQDc/iR
         L84JuG3Gnx1KgT4+JyHTXbrim4mU4Q3f1R4r6ESJdm3CMS+oFMdXvOc24wLb8izqcL7B
         KBOg==
X-Gm-Message-State: AAQBX9d1sMeTpIeIT/r1EaFH3w8PvK1w18xElOe5unJ10h/EWOx8k6QM
        E9EuIRzUTccSnZwR3sdTfmQ=
X-Google-Smtp-Source: AKy350amaaLhS95M7Dkn5QyPjiWDMhBzzAAuXASGjiYpVy3PCNTBkyN0n8dOQhViJMNf3n/OVhcRHA==
X-Received: by 2002:a17:90b:1b4c:b0:237:24eb:99d8 with SMTP id nv12-20020a17090b1b4c00b0023724eb99d8mr14642142pjb.19.1681160781506;
        Mon, 10 Apr 2023 14:06:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id iy18-20020a170903131200b001a644662ee0sm2029320plb.18.2023.04.10.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 14:06:21 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm: Add fdinfo memory stats
Date:   Mon, 10 Apr 2023 14:06:06 -0700
Message-Id: <20230410210608.1873968-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410210608.1873968-1-robdclark@gmail.com>
References: <20230410210608.1873968-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Add a helper to dump memory stats to fdinfo.  For the things the drm
core isn't aware of, use a callback.

v2: Fix typos, change size units to match docs, use div_u64

Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
---
 Documentation/gpu/drm-usage-stats.rst | 21 +++++++
 drivers/gpu/drm/drm_file.c            | 79 +++++++++++++++++++++++++++
 include/drm/drm_file.h                | 10 ++++
 3 files changed, 110 insertions(+)

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
index a51ff8cee049..085b01842a87 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -42,6 +42,7 @@
 #include <drm/drm_client.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/drm_print.h>
 
 #include "drm_crtc_internal.h"
@@ -868,6 +869,84 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
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
+/**
+ * drm_print_memory_stats - Helper to print standard fdinfo memory stats
+ * @file: the DRM file
+ * @p: the printer to print output to
+ * @status: callback to get driver tracked object status
+ *
+ * Helper to iterate over GEM objects with a handle allocated in the specified
+ * file.  The optional status callback can return additional object state which
+ * determines which stats the object is counted against.  The callback is called
+ * under table_lock.  Racing against object status change is "harmless", and the
+ * callback can expect to not race against object destruction.
+ */
+void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
+			    enum drm_gem_object_status (*status)(struct drm_gem_object *))
+{
+	struct drm_gem_object *obj;
+	struct {
+		size_t shared;
+		size_t private;
+		size_t resident;
+		size_t purgeable;
+		size_t active;
+	} size = {0};
+	int id;
+
+	spin_lock(&file->table_lock);
+	idr_for_each_entry (&file->object_idr, obj, id) {
+		enum drm_gem_object_status s = 0;
+
+		if (status)
+			s = status(obj);
+
+		if (obj->handle_count > 1) {
+			size.shared += obj->size;
+		} else {
+			size.private += obj->size;
+		}
+
+		if (s & DRM_GEM_OBJECT_RESIDENT) {
+			size.resident += obj->size;
+			s &= ~DRM_GEM_OBJECT_PURGEABLE;
+		}
+
+		if (s & DRM_GEM_OBJECT_ACTIVE) {
+			size.active += obj->size;
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
+
+	if (status) {
+		print_size(p, "drm-resident-memory", size.resident);
+		print_size(p, "drm-purgeable-memory", size.purgeable);
+		print_size(p, "drm-active-memory", size.active);
+	}
+}
+EXPORT_SYMBOL(drm_print_memory_stats);
+
 /**
  * mock_drm_getfile - Create a new struct file for the drm device
  * @minor: drm minor to wrap (e.g. #drm_device.primary)
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..7bd8a1374f39 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -41,6 +41,7 @@
 struct dma_fence;
 struct drm_file;
 struct drm_device;
+struct drm_printer;
 struct device;
 struct file;
 
@@ -438,6 +439,15 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
 				     struct drm_pending_event *e,
 				     ktime_t timestamp);
 
+enum drm_gem_object_status {
+	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
+	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
+	DRM_GEM_OBJECT_ACTIVE    = BIT(2),
+};
+
+void drm_print_memory_stats(struct drm_file *file, struct drm_printer *p,
+			    enum drm_gem_object_status (*status)(struct drm_gem_object *));
+
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 
 #endif /* _DRM_FILE_H_ */
-- 
2.39.2

