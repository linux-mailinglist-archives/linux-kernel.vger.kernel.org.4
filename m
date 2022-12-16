Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E762364F51C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLPXd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:33:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C415386
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:33:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3831513pjd.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/9xnFmVNF8HCZC2f7V1U4ifBu8+aTRtAP/p4VM2rg8=;
        b=K0b0h5pf0NqVxTezmemuH/EquW8gvl7w5uaBtTk+noyhROX3oQ9IpO9YFjIUrnKSLy
         v0XGQT0olmnQ0XeBhe1Ro8vMa3GWS5tu+DEvX//FwgsSnTtpiqua5GoPndg3ZoDWt+35
         Z/31iz25gyrOFNWwuDVyL4LOOch9q8jFL4hWFAeMOmAx5shEuVaiT1fdN7JyEdohs8xQ
         HXliGgpGNHj/WwchBy6fWEavCdM3c21rJuPNO6UB9N3CyZ6j0vWekKw7D/ADR7BL7fTP
         ZPvelc6Img0vFcE5f06q/BHiFOLRaBIdyg/YMrnYv0e+AtF6uoGKjilUZN0oB6FNIwl6
         Ajgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/9xnFmVNF8HCZC2f7V1U4ifBu8+aTRtAP/p4VM2rg8=;
        b=BMhYjgp6/Pv2YcPfiaa2h9ViubNShOvCgKNTyHDs4fNXIJMjel8y/hpsKLvQ0UTUnp
         2Wg9f4kXmr0EMhCpomJqTI30JU938US1OFtYHOgahnj+es+TwcNTBrsw/7/6s2xKJNCo
         3WjP1mMKbYwZk0twtT7iGz7mZ5A64scdgARiNJQ37KcCvKeEktoJKp3u/Im10EOvFyHl
         VgbnW2O3nsOdjFHWvQq6snsdL5BMH9PLqMzf9Jy/bSOkFISblUh6NTZMg5bWeuO5DI9V
         6wHCwDoYeIVTeU8POwTPS+5PdpjSntQ57iVNhUKUWY8A1yyuIyQ4CA+ei/q+NxCXd0Lr
         ofwQ==
X-Gm-Message-State: ANoB5pnc90rfLFfXKPMrdxF4RbDZ5A5+CYp8nQueGGlQoJ4NvdQFbB+H
        8CbSIuRVOHUj2N37JYg7Rds=
X-Google-Smtp-Source: AA0mqf79fQvrWdpp4Pu80dMKCstST1/QOcQ0XulZCdbCaj6xEt6OEWe/t+TNt4tyVpMTa5hBJ22dNg==
X-Received: by 2002:a17:902:a711:b0:189:747e:97cc with SMTP id w17-20020a170902a71100b00189747e97ccmr32117026plq.26.1671233633052;
        Fri, 16 Dec 2022 15:33:53 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b0018c7a5e052asm2137355pla.225.2022.12.16.15.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:33:52 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/panfrost: Fix GEM handle creation UAF
Date:   Fri, 16 Dec 2022 15:33:54 -0800
Message-Id: <20221216233355.542197-1-robdclark@gmail.com>
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

Relying on an unreturned handle to hold a reference to an object we
dereference is not safe.  Userspace can guess the handle and race us
by closing the handle from another thread.  The _create_with_handle()
that returns an object ptr is pretty much a pattern to avoid.  And
ideally creating the handle would be done after any needed dererencing.
But in this case creation of the mapping is tied to the handle creation.
Fortunately the mapping is refcnt'd and holds a reference to the object,
so we can drop the handle's reference once we hold a mapping reference.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c |  7 +++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c | 10 +++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 2fa5afe21288..aa5848de647c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -98,6 +98,13 @@ static int panfrost_ioctl_create_bo(struct drm_device *dev, void *data,
 		return PTR_ERR(bo);
 
 	mapping = panfrost_gem_mapping_get(bo, priv);
+
+	/*
+	 * Now that the mapping holds a reference to the bo until we no longer
+	 * need it, we can safely drop the handle's reference.
+	 */
+	drm_gem_object_put(&bo->base.base);
+
 	if (!mapping) {
 		drm_gem_object_put(&bo->base.base);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 293e799e2fe8..e3e21c500d24 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -234,6 +234,10 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
 	return &obj->base.base;
 }
 
+/*
+ * NOTE: if this succeeds, both the handle and the returned object have
+ * an outstanding reference.
+ */
 struct panfrost_gem_object *
 panfrost_gem_create_with_handle(struct drm_file *file_priv,
 				struct drm_device *dev, size_t size,
@@ -261,10 +265,10 @@ panfrost_gem_create_with_handle(struct drm_file *file_priv,
 	 * and handle has the id what user can see.
 	 */
 	ret = drm_gem_handle_create(file_priv, &shmem->base, handle);
-	/* drop reference from allocate - handle holds it now. */
-	drm_gem_object_put(&shmem->base);
-	if (ret)
+	if (ret) {
+		drm_gem_object_put(&shmem->base);
 		return ERR_PTR(ret);
+	}
 
 	return bo;
 }
-- 
2.38.1

