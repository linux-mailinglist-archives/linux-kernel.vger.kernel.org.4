Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95756DE79F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDKW5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDKW5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:57:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5C140D7;
        Tue, 11 Apr 2023 15:57:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so8321128plp.2;
        Tue, 11 Apr 2023 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndo7/lTZcfHCD79DpWpY2qpFEQ7Xd6kuppJxXwpF0ms=;
        b=MelNz4UYP8A57Tyb6z4hyxuO2j+c1WaLKmnMvc26DemjfOxamU6zD12VnHZGDqc3sF
         4JknlyvWJJOyzN5YxBtAvezxx7qilD7GR1KNApjm5w6EZsbjOgJGjZ/4Ba0Fzji691EF
         1Y3u1YQgRH+e7cr4XvUp3YKWJZVhGVuUBQQXdoeyZeo5IpFjDBJ5UpUSYju5WqonLxiY
         l5gtPurRXeR9im6uK0YSjH3U2DkCFTYfk6z0UQOGDdyqhHcVHMoD8oycqXJuSKE4EU6v
         lwhf+f/43tdjxsEik3bx8Ya98FAq/i5VpC6UxsGWxOykAX6edRGBz6615HG4mMwyKsoa
         4QoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndo7/lTZcfHCD79DpWpY2qpFEQ7Xd6kuppJxXwpF0ms=;
        b=nUGSYxn70D8qcscFbtgUMoJfcDKvWc7kR/UR48D/+7PQBTdRrcFryLE/RUemWH5wmk
         m6a3PgJEjgjk5PsDRiAQloUTeQ8P8iuzojFKmx8roZU80j0z0taDWo/RRum8Ab5xvKmV
         0/U6jWlT+qpyBsA/MtdXo404L9w1ejT/Fk5J4A303HPt1ATEH4lwZ6qaXY8O+CGFjb1m
         GEeqs/H8USwukjBLsQdNg56BFiYAwHbOPsHM6EJPymfaH9GgpsNh2CTskKc3dblFlGTs
         Oj9omCalXdkuXqKN16UMoK7zPe2csTG8lj5jRDyJyNQv2F2sZyOJmBVxKkvbsWsAhSfM
         dzFQ==
X-Gm-Message-State: AAQBX9dBobRpAC7Bo+MEcrfQblJa/jDsLf/BfX/un9YZL5FysZVSJV+K
        1ukGGlFVQB7tYnGSAP/RK2Y=
X-Google-Smtp-Source: AKy350YX8burQawQVvj0e8kKDtvhq+EucOeKpgDFXUOzjPZ8nmdMytz6DHh0nGTKQtDt5xjLGlyawA==
X-Received: by 2002:a17:902:ce89:b0:1a1:f70c:c81a with SMTP id f9-20020a170902ce8900b001a1f70cc81amr23063606plg.9.1681253862885;
        Tue, 11 Apr 2023 15:57:42 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709027b8100b001a664e49ebasm436209pll.304.2023.04.11.15.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:42 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/7] drm: Add common fdinfo helper
Date:   Tue, 11 Apr 2023 15:56:06 -0700
Message-Id: <20230411225725.2032862-2-robdclark@gmail.com>
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

Handle a bit of the boiler-plate in a single case, and make it easier to
add some core tracked stats.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_file.c | 39 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_drv.h      |  7 +++++++
 include/drm/drm_file.h     |  4 ++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index a51ff8cee049..37dfaa6be560 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -148,6 +148,7 @@ bool drm_dev_needs_global_mutex(struct drm_device *dev)
  */
 struct drm_file *drm_file_alloc(struct drm_minor *minor)
 {
+	static atomic_t ident = ATOMIC_INIT(0);
 	struct drm_device *dev = minor->dev;
 	struct drm_file *file;
 	int ret;
@@ -156,6 +157,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	if (!file)
 		return ERR_PTR(-ENOMEM);
 
+	/* Get a unique identifier for fdinfo: */
+	file->client_id = atomic_inc_return(&ident) - 1;
 	file->pid = get_pid(task_pid(current));
 	file->minor = minor;
 
@@ -868,6 +871,42 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
 }
 EXPORT_SYMBOL(drm_send_event);
 
+/**
+ * drm_fop_show_fdinfo - helper for drm file fops
+ * @seq_file: output stream
+ * @f: the device file instance
+ *
+ * Helper to implement fdinfo, for userspace to query usage stats, etc, of a
+ * process using the GPU.
+ */
+void drm_fop_show_fdinfo(struct seq_file *m, struct file *f)
+{
+	struct drm_file *file = f->private_data;
+	struct drm_device *dev = file->minor->dev;
+	struct drm_printer p = drm_seq_file_printer(m);
+
+	/*
+	 * ******************************************************************
+	 * For text output format description please see drm-usage-stats.rst!
+	 * ******************************************************************
+	 */
+
+	drm_printf(&p, "drm-driver:\t%s\n", dev->driver->name);
+	drm_printf(&p, "drm-client-id:\t%u\n", file->client_id);
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
+EXPORT_SYMBOL(drm_fop_show_fdinfo);
+
 /**
  * mock_drm_getfile - Create a new struct file for the drm device
  * @minor: drm minor to wrap (e.g. #drm_device.primary)
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 5b86bb7603e7..a883c6d3bcdf 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -401,6 +401,13 @@ struct drm_driver {
 			       struct drm_device *dev, uint32_t handle,
 			       uint64_t *offset);
 
+	/**
+	 * @fdinfo:
+	 *
+	 * Print device specific fdinfo.  See drm-usage-stats.rst.
+	 */
+	void (*show_fdinfo)(struct drm_printer *p, struct drm_file *f);
+
 	/** @major: driver major number */
 	int major;
 	/** @minor: driver minor number */
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 0d1f853092ab..dfa995b787e1 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -258,6 +258,9 @@ struct drm_file {
 	/** @pid: Process that opened this file. */
 	struct pid *pid;
 
+	/** @client_id: A unique id for fdinfo */
+	u32 client_id;
+
 	/** @magic: Authentication magic, see @authenticated. */
 	drm_magic_t magic;
 
@@ -437,6 +440,7 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
 void drm_send_event_timestamp_locked(struct drm_device *dev,
 				     struct drm_pending_event *e,
 				     ktime_t timestamp);
+void drm_fop_show_fdinfo(struct seq_file *m, struct file *f);
 
 struct file *mock_drm_getfile(struct drm_minor *minor, unsigned int flags);
 
-- 
2.39.2

