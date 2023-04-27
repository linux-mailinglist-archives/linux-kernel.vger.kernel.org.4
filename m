Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349676F0B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbjD0RzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244535AbjD0RyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:54:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A41A3C15;
        Thu, 27 Apr 2023 10:54:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64115eef620so6797419b3a.1;
        Thu, 27 Apr 2023 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682618051; x=1685210051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGLJmibW87WAJcS5t0uIh72jCVPBIb7Gj0WXUx1P9zU=;
        b=QMXQRPIdXA5q5Km0eEBU7rKyuFO/cgMrtoDCMJdyNqAiJII2NpWeJLh5tHe70Cy232
         Sm5bFKWRn1oSSzIdYYglEqg8J6RUhcSkcWnMH7d4qgcvGCmFinBCuh81eI4k4yWHVpvx
         ZGSfIBbB+9WYYIJU6QL3JOedPPhjgrhrXsvSGBPHyj1zrMv0q578RG/AT6Ue8xSs2fL3
         VqFTs5aUbk2lfTToiCebxdTsxyY8QfQ8af5msEFx2/6VxM7sz1Mj6jn3ZRQ6NcpfhnBz
         smFVLkXfhebsJulsoQqEEQZQriQbsmux38e2ELM+/aEBKnk7Y2f+FUt5q8Q7P6pfwUeA
         1fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682618051; x=1685210051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGLJmibW87WAJcS5t0uIh72jCVPBIb7Gj0WXUx1P9zU=;
        b=cBhd0hWS4Ys++9yltsjwGNJMNB03d1QShIL5r+kwcpuVyECHY7/Jl/WWkcWoXnejoK
         djev7l/IunKyQK6Dy0Es9ZWI9Qc/POP0nTbA5gdO9WYcZqPK+I4ZcrETDGq/zmoonqon
         l//UNBv1M+LfLXVoW3ubh26ck0ENhAzyEgvbLqkzSbQWHAKGoCBSd5yfnlKWXWgIUQMD
         0k1OQ0a1H3eYyRmVaLnnhmZj9NZdP05xgs5kyK3ZFnSPF17q3NokT78QLtFwGckBxnaD
         tn9bgYfGRIcTCawR6G57s+R6unKo02+PX2LrQyPNB97froZ3kL3yBfAssbtjRpGMtOrS
         LykQ==
X-Gm-Message-State: AC+VfDxs1g5B3LSbxALWkO57THUhN9NKfsbsCw5uEL5uRmH+QfgKWD7E
        cPl7/4wtIRrII8CHfTxqhFA=
X-Google-Smtp-Source: ACHHUZ6Nn15Zn+c1Wo6Qo1HTjwDdKmVdH9HihAreo97OXBbuOLvs3ki9YVei3t6pb2Epm77vQyXY1g==
X-Received: by 2002:a05:6a20:918f:b0:f0:3fc4:744f with SMTP id v15-20020a056a20918f00b000f03fc4744fmr3333199pzd.8.1682618050907;
        Thu, 27 Apr 2023 10:54:10 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id y189-20020a62cec6000000b00640defda6d2sm6860749pfg.207.2023.04.27.10.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 10:54:10 -0700 (PDT)
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
Subject: [PATCH v2 8/9] drm/fdinfo: Add comm/cmdline override fields
Date:   Thu, 27 Apr 2023 10:53:32 -0700
Message-Id: <20230427175340.1280952-9-robdclark@gmail.com>
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

These are useful in particular for VM scenarios where the process which
has opened to drm device file is just a proxy for the real user in a VM
guest.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/gpu/drm-usage-stats.rst | 18 ++++++++++++++++++
 drivers/gpu/drm/drm_file.c            | 15 +++++++++++++++
 include/drm/drm_file.h                | 19 +++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
index 58dc0d3f8c58..e4877cf8089c 100644
--- a/Documentation/gpu/drm-usage-stats.rst
+++ b/Documentation/gpu/drm-usage-stats.rst
@@ -73,6 +73,24 @@ scope of each device, in which case `drm-pdev` shall be present as well.
 Userspace should make sure to not double account any usage statistics by using
 the above described criteria in order to associate data to individual clients.
 
+- drm-comm-override: <valstr>
+
+Returns the client executable override string.  Some drivers support letting
+userspace override this in cases where the userspace is simply a "proxy".
+Such as is the case with virglrenderer drm native context, where the host
+process is just forwarding command submission, etc, from guest userspace.
+This allows the proxy to make visible the executable name of the actual
+app in the VM guest.
+
+- drm-cmdline-override: <valstr>
+
+Returns the client cmdline override string.  Some drivers support letting
+userspace override this in cases where the userspace is simply a "proxy".
+Such as is the case with virglrenderer drm native context, where the host
+process is just forwarding command submission, etc, from guest userspace.
+This allows the proxy to make visible the cmdline of the actual app in the
+VM guest.
+
 Utilization
 ^^^^^^^^^^^
 
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 9321eb0bf020..d7514c313af1 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -178,6 +178,8 @@ struct drm_file *drm_file_alloc(struct drm_minor *minor)
 	spin_lock_init(&file->master_lookup_lock);
 	mutex_init(&file->event_read_lock);
 
+	mutex_init(&file->override_lock);
+
 	if (drm_core_check_feature(dev, DRIVER_GEM))
 		drm_gem_open(dev, file);
 
@@ -292,6 +294,8 @@ void drm_file_free(struct drm_file *file)
 	WARN_ON(!list_empty(&file->event_list));
 
 	put_pid(file->pid);
+	kfree(file->override_comm);
+	kfree(file->override_cmdline);
 	kfree(file);
 }
 
@@ -995,6 +999,17 @@ void drm_show_fdinfo(struct seq_file *m, struct file *f)
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
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 1339e925af52..604d05fa6f0c 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -370,6 +370,25 @@ struct drm_file {
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
-- 
2.39.2

