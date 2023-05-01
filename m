Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C366F361D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjEASpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjEASpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1594FC6;
        Mon,  1 May 2023 11:45:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b70f0b320so3289207b3a.1;
        Mon, 01 May 2023 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966711; x=1685558711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkOiaACJUwTSaZnAMg3Z1LNgb8tXwVgSyta4ro1Te6g=;
        b=ehnGoMuxRDRH5aLlU2tF306g+ZD38d9HHlxR5A50he032bRpcy/KZBQXNoCjrUVhg+
         OsvU/3cuqKQDxPGYbHqci2oy3KilnhpuhiklCFsV9L11Vm1TEejJPleCQkqyD05Ukhgm
         aXAoeeCa6atrhbjBEFUAJFgnhRY17guz4D5K5Niv8QazAuzS5zI57U9yEScBkOh58Gvk
         yNZi0P/5BGSy5H3Vi3LAAQNZXBUTpgQT1WsEgCaMCrrNSWt3zlnHNz3+auAGT7b5IG+9
         sgbCoo4PdZsrkFCSw/YGMgFQX9Wc0XGd6aLUma5ZB3WjYtF4TInVwUODGneX3ry+/cyl
         CHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966711; x=1685558711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkOiaACJUwTSaZnAMg3Z1LNgb8tXwVgSyta4ro1Te6g=;
        b=hEA+kkLvQ2WMJiAkS8dW+f24JwqvT/BRYTpjG3nMMmoEEQ+ckOpAQJVKjxaU1CbEcI
         /Z2I9/hFrPUSjqpVDYZfZFbhkqr3EI5IDTF0k9a9WxV2CWJ6vMutYaGAm8Ee/Kq1aeAB
         EXkCKMgjyZjNb4bdXV69xZ6XN8+fAoO7Quz9oAuCUarC9aL/xruL8Kcp3gZPkLyObBxd
         E21EIiGwHqLjGLd4g8980mjEaOJnMVQ++MzEZ4q3sxTUCYSOHpSPpc2+dE/E/hMmOg/y
         q93e/mpBeAxs/qlvbAL4BMkSeuEXCfuwtzUrJbfaDU7Mks5oOUaiCqFvXgr3S0iLLUMh
         mqEQ==
X-Gm-Message-State: AC+VfDz+Rug1oWO4JoB8z8U+E52our8vGPDleM29zQvB4OpVz9YaUCkP
        N94WHrffC0Lg/sekA/bVDgU=
X-Google-Smtp-Source: ACHHUZ7mhldmS4hPvySjRFhjN5zTE63qGlJYrr/wJcWFWwtgMblzXR1skb/7nyqzI3zdZZnLfsmGNw==
X-Received: by 2002:a05:6a20:7d95:b0:f4:98d2:591d with SMTP id v21-20020a056a207d9500b000f498d2591dmr19290919pzj.5.1682966711341;
        Mon, 01 May 2023 11:45:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id gb9-20020a17090b060900b0024dee500736sm2994401pjb.57.2023.05.01.11.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:10 -0700 (PDT)
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
Subject: [PATCH v3 2/9] drm: Add common fdinfo helper
Date:   Mon,  1 May 2023 11:44:48 -0700
Message-Id: <20230501184502.1620335-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501184502.1620335-1-robdclark@gmail.com>
References: <20230501184502.1620335-1-robdclark@gmail.com>
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
@@ -119,14 +119,22 @@ value until a monotonic update is seen.
 
 - drm-maxfreq-<str>: <uint> [Hz|MHz|KHz]
 
 Engine identifier string must be the same as the one specified in the
 drm-engine-<str> tag and shall contain the maximum frequency for the given
 engine.  Taken together with drm-cycles-<str>, this can be used to calculate
 percentage utilization of the engine, whereas drm-engine-<str> only reflects
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
@@ -141,28 +141,31 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  *
  * This allocates a new DRM file context. It is not linked into any context and
  * can be used by the caller freely. Note that the context keeps a pointer to
  * @minor, so it must be freed before @minor is.
  *
  * RETURNS:
  * Pointer to newly allocated context, ERR_PTR on failure.
  */
 struct drm_file *drm_file_alloc(struct drm_minor *minor)
 {
+	static atomic64_t ident = ATOMIC_INIT(0);
 	struct drm_device *dev = minor->dev;
 	struct drm_file *file;
 	int ret;
 
 	file = kzalloc(sizeof(*file), GFP_KERNEL);
 	if (!file)
 		return ERR_PTR(-ENOMEM);
 
+	/* Get a unique identifier for fdinfo: */
+	file->client_id = atomic64_inc_return(&ident);
 	file->pid = get_pid(task_pid(current));
 	file->minor = minor;
 
 	/* for compatibility root is always authenticated */
 	file->authenticated = capable(CAP_SYS_ADMIN);
 
 	INIT_LIST_HEAD(&file->lhead);
 	INIT_LIST_HEAD(&file->fbs);
 	mutex_init(&file->fbs_lock);
 	INIT_LIST_HEAD(&file->blobs);
@@ -861,20 +864,52 @@ EXPORT_SYMBOL(drm_send_event_locked);
 void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
 {
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&dev->event_lock, irqflags);
 	drm_send_event_helper(dev, e, 0);
 	spin_unlock_irqrestore(&dev->event_lock, irqflags);
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
  * @flags: file creation mode (O_RDWR etc)
  *
  * This create a new struct file that wraps a DRM file context around a
  * DRM minor. This mimicks userspace opening e.g. /dev/dri/card0, but without
  * invoking userspace. The struct file may be operated on using its f_op
  * (the drm_device.driver.fops) to mimick userspace operations, or be supplied
  * to userspace facing functions as an internal/anonymous client.
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 5b86bb7603e7..5edf2a13733b 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -394,20 +394,27 @@ struct drm_driver {
 	 * Called by the user via ioctl.
 	 *
 	 * Returns:
 	 *
 	 * Zero on success, negative errno on failure.
 	 */
 	int (*dumb_map_offset)(struct drm_file *file_priv,
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
 	int minor;
 	/** @patchlevel: driver patch level */
 	int patchlevel;
 	/** @name: driver name */
 	char *name;
 	/** @desc: driver description */
 	char *desc;
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..6de6d0e9c634 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -251,20 +251,23 @@ struct drm_file {
 	 * primary nodes and authentication <drm_primary_node>`.
 	 */
 	struct drm_master *master;
 
 	/** @master_lookup_lock: Serializes @master. */
 	spinlock_t master_lookup_lock;
 
 	/** @pid: Process that opened this file. */
 	struct pid *pid;
 
+	/** @client_id: A unique id for fdinfo */
+	u64 client_id;
+
 	/** @magic: Authentication magic, see @authenticated. */
 	drm_magic_t magic;
 
 	/**
 	 * @lhead:
 	 *
 	 * List of all open files of a DRM device, linked into
 	 * &drm_device.filelist. Protected by &drm_device.filelist_mutex.
 	 */
 	struct list_head lhead;
@@ -430,14 +433,15 @@ int drm_event_reserve_init(struct drm_device *dev,
 			   struct drm_file *file_priv,
 			   struct drm_pending_event *p,
 			   struct drm_event *e);
 void drm_event_cancel_free(struct drm_device *dev,
 			   struct drm_pending_event *p);
 void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e);
 void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
 void drm_send_event_timestamp_locked(struct drm_device *dev,
 				     struct drm_pending_event *e,
 				     ktime_t timestamp);
+void drm_show_fdinfo(struct seq_file *m, struct file *f);
 
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 
 #endif /* _DRM_FILE_H_ */
-- 
2.39.2

