Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D7F6F361B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjEASpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjEASpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:45:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208561BFF;
        Mon,  1 May 2023 11:45:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b620188aeso3326309b3a.0;
        Mon, 01 May 2023 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682966725; x=1685558725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyZZbvnIPcy9SJ2XHAqwKtaGibd+YeoRhfLb959XYfs=;
        b=AQH/TI8t31awy2pNsHOH16n6UDJzt4czgCXQW5e0/RrlrTD75C8c76TW+NXjXFVVf5
         WmLnyOdEkSa0rU1pTCP/m/TDFEq2o957jWHrTYajYnDnC3kn8a1EE4F4E2FR3C2d4Y06
         /Ne835duRBqqUoHdtisXWhwnvIfrXmTUrhzjQb+OYko7VL+L5SuWbDXRegQ/eA6WX2kp
         GPm18LUJmf5c+9VpiYEco78gVPDvBLxwNfUFPZ9Vs3QfJ687fmXiYrdPQBuWGWmTFdjF
         l/qVfcRtBR0ZCkmTXRMouDoW5XRZcb7vGCfOrlxYSUCOukb8o/phFMSI2Xnt5BVC2wHD
         tfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682966725; x=1685558725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyZZbvnIPcy9SJ2XHAqwKtaGibd+YeoRhfLb959XYfs=;
        b=LPiB1OSnzVK0iZf9QEkbPxU110Y06cBC+jUXKvMJLL9m2n0Ac4uFZHxsbDgfwWFV69
         obcENgIr0aoPOsYqhSeiy3TWP9/KEm30opBdBpOcCZw9TwNeIOKHZHT6w8A71xXJcw0T
         PH6S7EIqWO4cf/3VthG0oYVTyDhQZcw2f7Aqzv9fstslYl5A7nSA72BNJgDn4EeDRcM6
         EjZEnX55V2kVQEZBQ2kektpvtTrxkeK5STsAkUhUFIFKOqWrqqgvQfY1NSmr+2W8j0bG
         TzRN++tvcXWOSSE97LtlSbDVCXHt/fDSZE3epACjZaymdxPfi5k7AIBz8X/nR5F9VcAq
         hMpQ==
X-Gm-Message-State: AC+VfDzYc35sDg1Daw3MNOR0P4Ow0F0g1U4vXr2wFedj7Lqoms5gcied
        UKA2hS2We94a6YhYjSbT8Vo=
X-Google-Smtp-Source: ACHHUZ67nRjak7J+u1L+vpuJQkSKVUTLHbv+8U0s5j3YKPvyWJCEaua7jxtf8bLS0fBFzFvEGGRLFg==
X-Received: by 2002:a05:6a20:938e:b0:f4:d4a8:9c82 with SMTP id x14-20020a056a20938e00b000f4d4a89c82mr18999826pzh.47.1682966725083;
        Mon, 01 May 2023 11:45:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id q7-20020a63cc47000000b0051ba4d6fe4fsm17719136pgi.56.2023.05.01.11.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:45:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 8/9] drm/fdinfo: Add comm/cmdline override fields
Date:   Mon,  1 May 2023 11:44:54 -0700
Message-Id: <20230501184502.1620335-9-robdclark@gmail.com>
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

These are useful in particular for VM scenarios where the process which
has opened to drm device file is just a proxy for the real user in a VM
guest.

v2: doc cleanups

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 10 ++++++++++
 drivers/gpu/drm/drm_file.c            | 15 +++++++++++++++
 include/drm/drm_file.h                | 19 +++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index fe35a291ff3e..03bd92b9125a 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -66,20 +66,30 @@ question.
 Unique value relating to the open DRM file descriptor used to distinguish
 duplicated and shared file descriptors. Conceptually the value should map 1:1
 to the in kernel representation of `struct drm_file` instances.
 
 Uniqueness of the value shall be either globally unique, or unique within the
 scope of each device, in which case `drm-pdev` shall be present as well.
 
 Userspace should make sure to not double account any usage statistics by using
 the above described criteria in order to associate data to individual clients.
 
+- drm-comm-override: <valstr>
+- drm-cmdline-override: <valstr>
+
+Returns the client comm (executable) or cmdline override strings.  Some drivers
+support letting userspace override this in cases where the userspace is simply a
+"proxy".  Such as is the case with virglrenderer drm native context, where the
+host process is just forwarding command submission, etc, from guest userspace.
+This allows the proxy to make visible the cmdline of the actual app in the VM
+guest.
+
 Utilization
 ^^^^^^^^^^^
 
 - drm-engine-<keystr>: <uint> ns
 
 GPUs usually contain multiple execution engines. Each shall be given a stable
 and unique name (keystr), with possible values documented in the driver specific
 documentation.
 
 Value shall be in specified time units which the respective GPU engine spent
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 9321eb0bf020..d7514c313af1 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -171,20 +171,22 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	mutex_init(&file->fbs_lock);
 	INIT_LIST_HEAD(&file->blobs);
 	INIT_LIST_HEAD(&file->pending_event_list);
 	INIT_LIST_HEAD(&file->event_list);
 	init_waitqueue_head(&file->event_wait);
 	file->event_space = 4096; /* set aside 4k for event buffer */
 
 	spin_lock_init(&file->master_lookup_lock);
 	mutex_init(&file->event_read_lock);
 
+	mutex_init(&file->override_lock);
+
 	if (drm_core_check_feature(dev, DRIVER_GEM))
 		drm_gem_open(dev, file);
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
 		drm_syncobj_open(file);
 
 	drm_prime_init_file_private(&file->prime);
 
 	if (dev->driver->open) {
 		ret = dev->driver->open(dev, file);
@@ -285,20 +287,22 @@ void drm_file_free(struct drm_file *file)
 		drm_master_release(file);
 
 	if (dev->driver->postclose)
 		dev->driver->postclose(dev, file);
 
 	drm_prime_destroy_file_private(&file->prime);
 
 	WARN_ON(!list_empty(&file->event_list));
 
 	put_pid(file->pid);
+	kfree(file->override_comm);
+	kfree(file->override_cmdline);
 	kfree(file);
 }
 
 static void drm_close_helper(struct file *filp)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev = file_priv->minor->dev;
 
 	mutex_lock(&dev->filelist_mutex);
 	list_del(&file_priv->lhead);
@@ -988,20 +992,31 @@ void drm_show_fdinfo(struct seq_file *m, struct file *f)
 	drm_printf(&p, "drm-client-id:\t%llu\n", file->client_id);
 
 	if (dev_is_pci(dev->dev)) {
 		struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 		drm_printf(&p, "drm-pdev:\t%04x:%02x:%02x.%d\n",
 			   pci_domain_nr(pdev->bus), pdev->bus->number,
 			   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
 	}
 
+	mutex_lock(&file->override_lock);
+	if (file->override_comm) {
+		drm_printf(&p, "drm-comm-override:\t%s\n",
+			   file->override_comm);
+	}
+	if (file->override_cmdline) {
+		drm_printf(&p, "drm-cmdline-override:\t%s\n",
+			   file->override_cmdline);
+	}
+	mutex_unlock(&file->override_lock);
+
 	if (dev->driver->show_fdinfo)
 		dev->driver->show_fdinfo(&p, file);
 }
 EXPORT_SYMBOL(drm_show_fdinfo);
 
 /**
  * mock_drm_getfile - Create a new struct file for the drm device
  * @minor: drm minor to wrap (e.g. #drm_device.primary)
  * @flags: file creation mode (O_RDWR etc)
  *
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index f77540b97cd0..233de3d252a8 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -363,20 +363,39 @@ struct drm_file {
 	/** @event_read_lock: Serializes drm_read(). */
 	struct mutex event_read_lock;
 
 	/**
 	 * @prime:
 	 *
 	 * Per-file buffer caches used by the PRIME buffer sharing code.
 	 */
 	struct drm_prime_file_private prime;
 
+	/**
+	 * @comm: Overridden task comm
+	 *
+	 * Accessed under override_lock
+	 */
+	char *override_comm;
+
+	/**
+	 * @cmdline: Overridden task cmdline
+	 *
+	 * Accessed under override_lock
+	 */
+	char *override_cmdline;
+
+	/**
+	 * @override_lock: Serialize access to override_comm and override_cmdline
+	 */
+	struct mutex override_lock;
+
 	/* private: */
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
 	unsigned long lock_count; /* DRI1 legacy lock count */
 #endif
 };
 
 /**
  * drm_is_primary_client - is this an open file of the primary node
  * @file_priv: DRM file
  *
-- 
2.39.2

