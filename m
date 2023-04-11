Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51766DE7B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDKW6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDKW57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:57:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA494C2D;
        Tue, 11 Apr 2023 15:57:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so12614377pja.2;
        Tue, 11 Apr 2023 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibZGCHCGgDbXF+wN6k9ulDgB+4n/u9g3t3I8e8YECX8=;
        b=SOoWEeih3vbn6+Nih46qhJtfcGTn0gX3CVj2lu3IxrRDEb9JISqVrewL9cxTj9oAWD
         XwE7QeceHOgop81oBrMIy7NNoTu1fPvKVXuHsKCibJyfP8B9yzipusPCOg7SB+W5NO5W
         XobaMsolMU175cDGGveMQnAPNacdrNt0L0AoVVryCvUPiZEcqgzh948ejKp6tqZecQb3
         JrX/Icj0sz078GEwUkzouk73+cL/kZscuAvgZB71HQ2pcmfvBQadkNIabMiRJ+mU2zwZ
         qM0IJPbacmQ3IfxclNAn6MWQZzp2HG60LpTV6JgoXshy8qVB1eU19ufJUNYH2eIDRoeF
         QS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibZGCHCGgDbXF+wN6k9ulDgB+4n/u9g3t3I8e8YECX8=;
        b=E8gyk3LHTZFwpaxms6xL2thmcnvs6lMdFNBULgZScRtjuLSOf2plqmjzvUpBLdAHbc
         wdOCeMGo66Bv7RXvjPiOxNdW7IuWGhMjgMGyE87QljmRop26zPSGU2Ri8DD5damcAG1b
         iyAu+2jr2zLxZTISXm53eXR2lRbx7EAfoNSnCS5umRXpW9ZWsbBlDie9f+MibjTNRe5e
         TQ9Oiil9Nl9UeoVfjgtKcqRqEFYQ0HewXPBmHAHlxYXQoQMOVublfVFP2B4ZfwhaLtBV
         XmtvuHr49MUg1wXwQkMXxJBD60n10+wEdviYJdr0T1FghoF3dhI4hidi5FQlws+9U2jC
         mTYw==
X-Gm-Message-State: AAQBX9dEi/Y13dR7TMah8/cgwqtpYqFV4EFgrfZtuA5b0MsJd9eIpTti
        dgbS2dU6rfq2LHA0y8W2b7E=
X-Google-Smtp-Source: AKy350b0zKnyM6u0Mr5B0MMULX87J0zKuKdgmuj+ocn/jghbUy7A4qoIP9IUAkNdhEi+ZZsgZ34Z9w==
X-Received: by 2002:a17:902:d08c:b0:1a6:5493:a3e8 with SMTP id v12-20020a170902d08c00b001a65493a3e8mr4197694plv.41.1681253876147;
        Tue, 11 Apr 2023 15:57:56 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id e12-20020a65478c000000b00517b7e3ef43sm6087613pgs.41.2023.04.11.15.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:55 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/7] drm/i915: Switch to fdinfo helper
Date:   Tue, 11 Apr 2023 15:56:09 -0700
Message-Id: <20230411225725.2032862-5-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/i915_driver.c     |  3 ++-
 drivers/gpu/drm/i915/i915_drm_client.c | 18 +++++-------------
 drivers/gpu/drm/i915/i915_drm_client.h |  2 +-
 3 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index db7a86def7e2..37eacaa3064b 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1696,7 +1696,7 @@ static const struct file_operations i915_driver_fops = {
 	.compat_ioctl = i915_ioc32_compat_ioctl,
 	.llseek = noop_llseek,
 #ifdef CONFIG_PROC_FS
-	.show_fdinfo = i915_drm_client_fdinfo,
+	.show_fdinfo = drm_fop_show_fdinfo,
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

