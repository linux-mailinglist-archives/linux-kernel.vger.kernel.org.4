Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7F96F0B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244461AbjD0RyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbjD0RyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:54:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31780420A;
        Thu, 27 Apr 2023 10:53:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a686260adcso91124975ad.0;
        Thu, 27 Apr 2023 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618036; x=1685210036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBhM8EV3rKHhycxSOd95UiYteeNU/7m/WGXxS7jGTSE=;
        b=Ls4jFb+IpHVK6hd4oTgRZh1XNrm/GGsmbM1MTz2AZcdHdxzQ+tGALfErG4zqPfYALQ
         4suMa75vWaO0JTm3RbPgJqDt15bxo2c8F+HfHRiPjEinqB8/NGkGbAyi7kokD/bWzTdH
         ofTixZ4kDUIr0YC1Q3BCsUPog3gZkjn+nev3RlOo3nHDuxR3S0K91wDdfGxU8thZgQkM
         DtKNgMs7XHbeRNM7d5v6f0GOCq/CGIPB1zc8DJsG4Sl5kGC4R38T0zddl6DYUwiT9nkA
         OstnBQtiQGDqTITIUpIvI35QbHJd4DaGJn+rCa0cTHbipCNf+wxE4A6pTqzHLkGz/fEE
         A7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618036; x=1685210036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBhM8EV3rKHhycxSOd95UiYteeNU/7m/WGXxS7jGTSE=;
        b=YXCb3TmegPJrB7sU+QmvbTfS/A7yRfO01dIReKkkRLg5ER2FC3usUWc3MrRftT2BiX
         /SrDAtelROYykB8vUy18uAlJWt9iv0zeGiU6me4lJj1DCkEPTvxWM/mZ15rtaCima2SH
         ofQGhqRLj9Y+f27mMLqtTu1H1y9wIBed0F79frJ67oQzmDzWmX8X5QV4dOLbSjrftiSb
         I4VVLjQCRBDNJu9lAX28KTClMr1vfSTMMQphqkd0/sIA1CuXZhrGybU/WmAmagdYAzcM
         9AWYKdwMLxwArNzVjhWlYMOx4YnWXbAiP4ELkWiHCFk42qB0VnuWbrhpNybX5rCtEUPP
         rsbA==
X-Gm-Message-State: AC+VfDzRDHKcK2CvjBrHXB0bKToOOjZkPQpAy1eCW+g/vPYNfsC47jFS
        aCMqr8IiVJcDhSgkJZbWqhE=
X-Google-Smtp-Source: ACHHUZ6IFGCsK9vNT8DizUsnkKluwvUlgTje+Wo9ShQhw/TLfGLD127nu2oMIGujHdFfqPrdp8xeeg==
X-Received: by 2002:a17:902:da90:b0:19f:188c:3e34 with SMTP id j16-20020a170902da9000b0019f188c3e34mr2843715plx.53.1682618036600;
        Thu, 27 Apr 2023 10:53:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id jl14-20020a170903134e00b001a2104d706fsm11903101plb.225.2023.04.27.10.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:53:56 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/9] drm: Add common fdinfo helper
Date:   Thu, 27 Apr 2023 10:53:26 -0700
Message-Id: <20230427175340.1280952-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427175340.1280952-1-robdclark@gmail.com>
References: <20230427175340.1280952-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Handle a bit of the boiler-plate in a single case, and make it easier to
add some core tracked stats.  This also ensures consistent behavior
across drivers for standardised fields.

v2: Update drm-usage-stats.rst, 64b client-id, rename drm_show_fdinfo

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 10 +++++++-
 drivers/gpu/drm/drm_file.c            | 35 +++++++++++++++++++++++++++
 include/drm/drm_drv.h                 |  7 ++++++
 include/drm/drm_file.h                |  4 +++
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 72d069e5dacb..552195fb1ea3 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -126,7 +126,15 @@ percentage utilization of the engine, whereas drm-engine-<str> only reflects
 time active without considering what frequency the engine is operating as a
 percentage of it's maximum frequency.
 
+Implementation Details
+======================
+
+Drivers should use drm_show_fdinfo() in their `struct file_operations`, and
+implement &drm_driver.show_fdinfo if they wish to provide any stats which
+are not provided by drm_show_fdinfo().  But even driver specific stats should
+be documented above and where possible, aligned with other drivers.
+
 Driver specific implementations
-===============================
+-------------------------------
 
 :ref:`i915-usage-stats`
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index a51ff8cee049..6d5bdd684ae2 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -148,6 +148,7 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  */
 struct drm_file *drm_file_alloc(struct drm_minor *minor)
 {
+	static atomic64_t ident = ATOMIC_INIT(0);
 	struct drm_device *dev = minor->dev;
 	struct drm_file *file;
 	int ret;
@@ -156,6 +157,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	if (!file)
 		return ERR_PTR(-ENOMEM);
 
+	/* Get a unique identifier for fdinfo: */
+	file->client_id = atomic64_inc_return(&ident);
 	file->pid = get_pid(task_pid(current));
 	file->minor = minor;
 
@@ -868,6 +871,38 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
 }
 EXPORT_SYMBOL(drm_send_event);
 
+/**
+ * drm_show_fdinfo - helper for drm file fops
+ * @seq_file: output stream
+ * @f: the device file instance
+ *
+ * Helper to implement fdinfo, for userspace to query usage stats, etc, of a
+ * process using the GPU.  See also &drm_driver.show_fdinfo.
+ *
+ * For text output format description please see Documentation/gpu/drm-usage-stats.rst
+ */
+void drm_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct drm_file *file = f->private_data;
+	struct drm_device *dev = file->minor->dev;
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
+	drm_printf(&p, "drm-client-id:\t%llu\n", file->client_id);
+
+	if (dev_is_pci(dev->dev)) {
+		struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+		drm_printf(&p, "drm-pdev:\t%04x:%02x:%02x.%d\n",
+			   pci_domain_nr(pdev->bus), pdev->bus->number,
+			   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
+	}
+
+	if (dev->driver->show_fdinfo)
+		dev->driver->show_fdinfo(&p, file);
+}
+EXPORT_SYMBOL(drm_show_fdinfo);
+
 /**
  * mock_drm_getfile - Create a new struct file for the drm device
  * @minor: drm minor to wrap (e.g. #drm_device.primary)
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 5b86bb7603e7..5edf2a13733b 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -401,6 +401,13 @@ struct drm_driver {
 			       struct drm_device *dev, uint32_t handle,
 			       uint64_t *offset);
 
+	/**
+	 * @show_fdinfo:
+	 *
+	 * Print device specific fdinfo.  See Documentation/gpu/drm-usage-stats.rst.
+	 */
+	void (*show_fdinfo)(struct drm_printer *p, struct drm_file *f);
+
 	/** @major: driver major number */
 	int major;
 	/** @minor: driver minor number */
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..6de6d0e9c634 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -258,6 +258,9 @@ struct drm_file {
 	/** @pid: Process that opened this file. */
 	struct pid *pid;
 
+	/** @client_id: A unique id for fdinfo */
+	u64 client_id;
+
 	/** @magic: Authentication magic, see @authenticated. */
 	drm_magic_t magic;
 
@@ -437,6 +440,7 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
 void drm_send_event_timestamp_locked(struct drm_device *dev,
 				     struct drm_pending_event *e,
 				     ktime_t timestamp);
+void drm_show_fdinfo(struct seq_file *m, struct file *f);
 
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 
-- 
2.39.2

