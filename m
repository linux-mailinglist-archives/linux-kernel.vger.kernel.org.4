Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75E6DE7B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDKW6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDKW6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:58:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A15275;
        Tue, 11 Apr 2023 15:57:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-634b28df952so849561b3a.2;
        Tue, 11 Apr 2023 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61YxJCuswj9xA83srgCQq+LpDU/NdlnFqvUJ2L68W28=;
        b=fzBJIokAts+RXDDaUaHyBMUmEWyCEpqt/q5M5m29gvFIePVvslMTBmgeaXIIOR2Ac0
         IKD4FDATQxWMrcXusMnMszqhH+ZFJUzNugl40qN33DRbhpmqVksqUaVRyb3TKcBlO3ob
         vrFgnK/cyair5Bpw1M73oVX/HdIR7gu5m1gkXUM+LiCHGrgYoRPJtmhIVyBoEJFdH50m
         D/b1pQ5vvmQELw83iKDaFVd4MtyXH2KRsKoLKutQ+Sjsq7U2J3b1JT7ekBAiDG927SoX
         y9LdBEnPpvAfHEYj+KBiACoG7fYWcLUqxCYeqUa/lu67QCaTVBR+SBy2ukeZ7NGv9x9f
         pwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61YxJCuswj9xA83srgCQq+LpDU/NdlnFqvUJ2L68W28=;
        b=XkBIpOat5+Vi3fXUgBs1RrHgTPWwhhyz5xAmJDB08E0dH+9srYj7JJKySnufNxouRw
         w/yDyABj36QqedGu1+CzHfboOB8OKQFfd/gX7uFzQXfzbaRPjZIHyidtuhHgZPAQrCFy
         DuoFe5nXInQpOm3rS+fX6vFmik7yKxykEEBz1yFqWNFYf0BttqnHgJbonPwIQdFfI0ko
         HmuDVRMjMxzi9xLAhwmyZ/HzsTWjnUuUjUYQuvw4DsiqsLo04tQHF9KhwnFzzjrwdtnQ
         3hvosmAEXQ1hJJxZxtiM8oUTwNbdBQSOw8A7+of3Oyaj3R0U6I4OBZb8h/T+fjsxFH9P
         3iYA==
X-Gm-Message-State: AAQBX9fcY36fdAjeIoeMlgOmQ21wVJ9ZzJ6AeU0BEUwIDdF41CGwdAsi
        TipYSpnx1OpYZMY8YJkPrCM=
X-Google-Smtp-Source: AKy350arI+CyPmWu3SVA1SipRhUdpjuMh/HgAyHw47YA/h5KMXGlVoWtJo9Ttap9MbvO0vk1YV7H6g==
X-Received: by 2002:a62:3815:0:b0:63a:b1ab:79a5 with SMTP id f21-20020a623815000000b0063ab1ab79a5mr5543199pfa.18.1681253877854;
        Tue, 11 Apr 2023 15:57:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b005d866d184b5sm10225457pfw.46.2023.04.11.15.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 15:57:57 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/7] drm/etnaviv: Switch to fdinfo helper
Date:   Tue, 11 Apr 2023 15:56:10 -0700
Message-Id: <20230411225725.2032862-6-robdclark@gmail.com>
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
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 44ca803237a5..170000d6af94 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -476,9 +476,8 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] = {
 	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
 };
 
-static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f)
+static void etnaviv_fop_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 {
-	struct drm_file *file = f->private_data;
 	struct drm_device *dev = file->minor->dev;
 	struct etnaviv_drm_private *priv = dev->dev_private;
 	struct etnaviv_file_private *ctx = file->driver_priv;
@@ -487,8 +486,6 @@ static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f)
 	 * For a description of the text output format used here, see
 	 * Documentation/gpu/drm-usage-stats.rst.
 	 */
-	seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
-	seq_printf(m, "drm-client-id:\t%u\n", ctx->id);
 
 	for (int i = 0; i < ETNA_MAX_PIPES; i++) {
 		struct etnaviv_gpu *gpu = priv->gpu[i];
@@ -507,7 +504,7 @@ static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f)
 			cur = snprintf(engine + cur, sizeof(engine) - cur,
 				       "%sNN", cur ? "/" : "");
 
-		seq_printf(m, "drm-engine-%s:\t%llu ns\n", engine,
+		drm_printf(p, "drm-engine-%s:\t%llu ns\n", engine,
 			   ctx->sched_entity[i].elapsed_ns);
 	}
 }
@@ -515,7 +512,7 @@ static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f)
 static const struct file_operations fops = {
 	.owner = THIS_MODULE,
 	DRM_GEM_FOPS,
-	.show_fdinfo = etnaviv_fop_show_fdinfo,
+	.show_fdinfo = drm_fop_show_fdinfo,
 };
 
 static const struct drm_driver etnaviv_drm_driver = {
@@ -529,6 +526,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = etnaviv_debugfs_init,
 #endif
+	.show_fdinfo        = etnaviv_fop_show_fdinfo,
 	.ioctls             = etnaviv_ioctls,
 	.num_ioctls         = DRM_ETNAVIV_NUM_IOCTLS,
 	.fops               = &fops,
-- 
2.39.2

