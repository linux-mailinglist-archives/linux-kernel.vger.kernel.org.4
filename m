Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A567805C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjAWPsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjAWPse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:48:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409EBEC4B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:48:33 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so14790895pjq.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79zz21d93rosXhCHk+UtsCaN0zcr+E49ORMLW7ABZQw=;
        b=IVYnhU2i0SWRMhhUGw/JcLPqKoaX9v5kgL+O6i0Anxid8V31nd+JNdqf7WGaWve+Ov
         6co3BfBCQtoxiXViNgIe17blkI9gSzEfb3aZQqgjBPfAO+xuXFTzkgMwuVPKPQufRkFE
         Enoq+oODNuk1UbSXSA4OBJU+xnXLVb0Kn7Csf0qWqLnuTteQ9NcN8sCJfGLTetwO0NsX
         ktJVjgNXBd6G4H7x+cyA+RHW1YJazqMU7gqmm4S+Jz/J2sRmMIf9IyqkTPu4E8tkXBWV
         LSICp/e0CsZPkhbpzqzLxw+q5cRiBxISSrefqB3Spesm6byOunKkgqTQvVbDGsIDtOdt
         6CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79zz21d93rosXhCHk+UtsCaN0zcr+E49ORMLW7ABZQw=;
        b=4x/ooVateN2jx86H8cdEz+8n4OjNiUSFNxS2P4vx++e+7QcB1N1iFC/Se8BVC3uJkG
         bR3RW7WiqQcoadRuUQTpMCy22cieYFKws6Jxx3h5ALvL4IvPaUpIhx9g0zf1TADBhzG2
         ALLYQYD3SW6Pn3Jyh5IAxxprBa82jhE4Alz2egfgzw1uef+JcWy1KPe64C71ngYk577d
         QlkaNnTsrpw60MYMUxy9V1c6br9VB47z1g42OAvJzqmiTqo8qGe82icPJGnj5JKchXEj
         E8ATcOuGceUIHbvpKVxOr8mNzvwsafW2Zi41R5r47Ms8rcGrX5MdVNODFySM1VsmR5Mg
         X1AA==
X-Gm-Message-State: AO0yUKUHdqGNv4UtS9cKdafQUKmOwLMt45dneuO2bOMA1EpjbcJy4NgU
        oHPbmweYkryro0Lu4QXgi6U=
X-Google-Smtp-Source: AK7set9YrXeJZMX+IyKBeKOJFuPWRH6Qpv+eq6XUyBQWUuT/GqssZsH/dtCsFGcfxh8s8dy8ti5U0A==
X-Received: by 2002:a17:902:da81:b0:196:e77:f07b with SMTP id j1-20020a170902da8100b001960e77f07bmr242552plx.39.1674488912600;
        Mon, 23 Jan 2023 07:48:32 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902bc4600b00196065e8d78sm1976697plz.50.2023.01.23.07.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:48:32 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Steven Price <steven.price@arm.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/shmem: Cleanup drm_gem_shmem_create_with_handle()
Date:   Mon, 23 Jan 2023 07:48:31 -0800
Message-Id: <20230123154831.3191821-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Once we create the handle, the handle owns the reference.  Currently
nothing was doing anything with the shmem ptr after the handle was
created, but let's change drm_gem_shmem_create_with_handle() to not
return the pointer, so-as to not encourage problematic use of this
function in the future.  As a bonus, it makes the code a bit cleaner.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f21f47737817..42c496c5f92c 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -415,7 +415,7 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_object *shmem,
 }
 EXPORT_SYMBOL(drm_gem_shmem_vunmap);
 
-static struct drm_gem_shmem_object *
+static int
 drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 				 struct drm_device *dev, size_t size,
 				 uint32_t *handle)
@@ -425,7 +425,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 
 	shmem = drm_gem_shmem_create(dev, size);
 	if (IS_ERR(shmem))
-		return shmem;
+		return PTR_ERR(shmem);
 
 	/*
 	 * Allocate an id of idr table where the obj is registered
@@ -434,10 +434,8 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 	ret = drm_gem_handle_create(file_priv, &shmem->base, handle);
 	/* drop reference from allocate - handle holds it now. */
 	drm_gem_object_put(&shmem->base);
-	if (ret)
-		return ERR_PTR(ret);
 
-	return shmem;
+	return ret;
 }
 
 /* Update madvise status, returns true if not purged, else
@@ -520,7 +518,6 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args)
 {
 	u32 min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
-	struct drm_gem_shmem_object *shmem;
 
 	if (!args->pitch || !args->size) {
 		args->pitch = min_pitch;
@@ -533,9 +530,7 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			args->size = PAGE_ALIGN(args->pitch * args->height);
 	}
 
-	shmem = drm_gem_shmem_create_with_handle(file, dev, args->size, &args->handle);
-
-	return PTR_ERR_OR_ZERO(shmem);
+	return drm_gem_shmem_create_with_handle(file, dev, args->size, &args->handle);
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_dumb_create);
 
-- 
2.38.1

