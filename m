Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5796E0218
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjDLWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:43:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AACE8A5F;
        Wed, 12 Apr 2023 15:43:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a661032878so2617885ad.2;
        Wed, 12 Apr 2023 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681339415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkssoMCH0JBHP5vQQ5/soNqQdOvnZ6jaRR6/QM733LA=;
        b=CN2Lu5bkY+MGZCbxwRhM4EnjEolwajayHfLudHbz9tBs33RQgILaEi5P6Qxw8qyguN
         xoWnK90QAZ9zgi3uJgybS58pTFgOPDC0i/Y6N/CC9/JxdBnW/Xko5eF5195pN+o96lOt
         B3t6MqVZRv401aFbp97LgzPPX3z/TcwK390iW3z2Gf8xXjmYrFOQ/B4oOjWKzqnHTa96
         GN/9Aoqri3BO7s/4Byeu1KOHWVLYt/NMY37imHJ+YbzDNqT6SjvT1Ibylkrd6+wKdab4
         3/7Ke0vXSk9PbKxS52tVBdr3grAT7reP701Rx6Wi78SSX9YiFQ/Ur9GJnzcZXFXOKmZK
         sFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681339415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkssoMCH0JBHP5vQQ5/soNqQdOvnZ6jaRR6/QM733LA=;
        b=VtFqWePPpC7CIINakTi/QzNnll6Z77fYp0A8lWbymhjR6rTrRmnk4Mbpj6uJ4PE5SZ
         LgKljiWMLm7tvMN+lxyMyOY+4oMxEWrnIeBYvWp7Y16Fh1ngC0rek3OH5yIG67j9rFjU
         hc/omUkpF7USnWluz29YKXcwRpBOc6UjaVB0coV/XEA5FOtA379vsMShDux+CRxRwYUD
         KYoJbC0aUCwAU3DBk1f2LKFmeCBLZt4qs/9BzqIeivF3MtcxPWB9Fn4RdVKj1XcWJq32
         YgZ7XEFKcKPJtcLhL8AnBlmTwq0j/9CEc4CQ67pmMbMHRWXT55BnyI5kTVR4aLDoIUWm
         ZKNw==
X-Gm-Message-State: AAQBX9enJNpRuJTZsB/pRz11V7IDj3Gd9ysKf3G2nVX9zmDDR5jNyrLL
        ScRuwV/LM8MykagKh9L1SiE=
X-Google-Smtp-Source: AKy350aYwJOvUW0JQIxdrV8N4IpK0cbzSlW+M9BgaNU7TLenuTzBVtC65d4AdjjHrJfk602WSzijeg==
X-Received: by 2002:a05:6a00:16c1:b0:636:4523:da93 with SMTP id l1-20020a056a0016c100b006364523da93mr529335pfc.12.1681339414895;
        Wed, 12 Apr 2023 15:43:34 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id w30-20020a63161e000000b00517f165d0a6sm114761pgl.4.2023.04.12.15.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:43:34 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] drm/i915: Switch to fdinfo helper
Date:   Wed, 12 Apr 2023 15:42:56 -0700
Message-Id: <20230412224311.23511-5-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412224311.23511-1-robdclark@gmail.com>
References: <20230412224311.23511-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/i915_driver.c     |  3 ++-
 drivers/gpu/drm/i915/i915_drm_client.c | 18 +++++-------------
 drivers/gpu/drm/i915/i915_drm_client.h |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index db7a86def7e2..0d91f85f8b97 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1696,7 +1696,7 @@ static const struct file_operations i915_driver_fops = {
 	.compat_ioctl = i915_ioc32_compat_ioctl,
 	.llseek = noop_llseek,
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = i915_drm_client_fdinfo,
+	.show_fdinfo = drm_show_fdinfo,
 #endif
 };
 
@@ -1796,6 +1796,7 @@ static const struct drm_driver i915_drm_driver = {
 	.open = i915_driver_open,
 	.lastclose = i915_driver_lastclose,
 	.postclose = i915_driver_postclose,
+	.show_fdinfo = i915_drm_client_fdinfo,
 
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
diff --git a/drivers/gpu/drm/i915/i915_drm_client.c b/drivers/gpu/drm/i915/i915_drm_client.c
index b09d1d386574..4a77e5e47f79 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.c
+++ b/drivers/gpu/drm/i915/i915_drm_client.c
@@ -101,7 +101,7 @@ static u64 busy_add(struct i915_gem_context *ctx, unsigned int class)
 }
 
 static void
-show_client_class(struct seq_file *m,
+show_client_class(struct drm_printer *p,
 		  struct i915_drm_client *client,
 		  unsigned int class)
 {
@@ -117,22 +117,20 @@ show_client_class(struct seq_file *m,
 	rcu_read_unlock();
 
 	if (capacity)
-		seq_printf(m, "drm-engine-%s:\t%llu ns\n",
+		drm_printf(p, "drm-engine-%s:\t%llu ns\n",
 			   uabi_class_names[class], total);
 
 	if (capacity > 1)
-		seq_printf(m, "drm-engine-capacity-%s:\t%u\n",
+		drm_printf(p, "drm-engine-capacity-%s:\t%u\n",
 			   uabi_class_names[class],
 			   capacity);
 }
 
-void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
+void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
-	struct drm_file *file = f->private_data;
 	struct drm_i915_file_private *file_priv = file->driver_priv;
 	struct drm_i915_private *i915 = file_priv->dev_priv;
 	struct i915_drm_client *client = file_priv->client;
-	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	unsigned int i;
 
 	/*
@@ -141,12 +139,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
 	 * ******************************************************************
 	 */
 
-	seq_printf(m, "drm-driver:\t%s\n", i915->drm.driver->name);
-	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n",
-		   pci_domain_nr(pdev->bus), pdev->bus->number,
-		   PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
-	seq_printf(m, "drm-client-id:\t%u\n", client->id);
-
 	/*
 	 * Temporarily skip showing client engine information with GuC submission till
 	 * fetching engine busyness is implemented in the GuC submission backend
@@ -155,6 +147,6 @@ void i915_drm_client_fdinfo(struct seq_file *m, struct file *f)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(uabi_class_names); i++)
-		show_client_class(m, client, i);
+		show_client_class(p, client, i);
 }
 #endif
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 69496af996d9..ef85fef45de5 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -60,7 +60,7 @@ static inline void i915_drm_client_put(struct i915_drm_client *client)
 struct i915_drm_client *i915_drm_client_add(struct i915_drm_clients *clients);
 
 #ifdef CONFIG_PROC_FS
-void i915_drm_client_fdinfo(struct seq_file *m, struct file *f);
+void i915_drm_client_fdinfo(struct drm_printer *p, struct drm_file *file);
 #endif
 
 void i915_drm_clients_fini(struct i915_drm_clients *clients);
-- 
2.39.2

