Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843536740A6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjASSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjASSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:13:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11A43921
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:13:20 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so3035802plw.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzlco0z7kyARFne6aPjn97rwGjIZC5wmHdoy935q5v8=;
        b=Em6XPAjN56DTVWK7ltE7kWrUpgn4OjY5KNM0m0CZekF/Erh5W6I0BYol/sRWj7Iv8m
         2y4DE4uEOTBLFrbViTWJwhiO698EWk1mFt4PHLKjI8nwgqj8QNmoz7AcfTIZuX2esnPc
         I59H7o/kCo0x2wW6+2EGEiGcxYk4sFsUcqrWlLYrsW+fYwBIBr7tCIojm1QCpQ1xeIRq
         DjYCudyK0HK4cdjR62ipxU1DiPs443dl3466m1BdtZ+9ah+h7R//mnLkKyihBgW9axoK
         DD75W548dMoOGRN18vbHqB8ZZqDVWsJ2VP9ttM+GhsThtHAhtnfypWOiTVjmSzx4s58s
         w9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzlco0z7kyARFne6aPjn97rwGjIZC5wmHdoy935q5v8=;
        b=zIkDkwAGheWMGVaW/xFWZ6LkEyeXyUTbTRmSJa3tv3h2nzZ9IgEadpeL0iy6gNbAlS
         lFNx6Ms+VR1aos839O/J+5/b05pDIEyHZHls85HbpncLs9rSv26RqZDsG0jqVT5GnmDA
         KaMY8oUGxgYbVO9de2NPhULXeT2mB48KOyxu+nJKhaHUMbEza+keoUErLoHMtGwNIEin
         6rIoZEZKqxe4pA2gCU0/I4No41ztgboK6CBBFztFgFAAQoWgaPH9vuyUAT7YEUj2BByS
         XW8ifxz7H4fL43qaZar2LJ6sDMDJGIxHUNuMoGZd0BDNsgcPDugct9bVPPDfCbVe6eRL
         smKQ==
X-Gm-Message-State: AFqh2kpWFB1ksCyVFeOozoXKv+BSQm5QAX7MXQFObVo5dDFbU1bXwUv4
        f4w4HoFDDiT/EkbJy/5hrrc=
X-Google-Smtp-Source: AMrXdXug0azKk/0n6wkJT+UoB4iTHWTRt5ztblvHe2juNwv12N7kECjxNTh6EWL7HBHOs6e56kcfQA==
X-Received: by 2002:a17:903:11c7:b0:194:a531:4b39 with SMTP id q7-20020a17090311c700b00194a5314b39mr15913608plh.67.1674151999425;
        Thu, 19 Jan 2023 10:13:19 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm12103841pli.309.2023.01.19.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 10:13:19 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/shmem: Cleanup drm_gem_shmem_create_with_handle()
Date:   Thu, 19 Jan 2023 10:13:25 -0800
Message-Id: <20230119181325.2834875-1-robdclark@gmail.com>
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
 drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f21f47737817..19406f4907df 100644
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
@@ -533,9 +531,7 @@ int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
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

