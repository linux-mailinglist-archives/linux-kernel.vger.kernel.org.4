Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553DA67471E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjASXVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjASXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:21:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C063C392AC;
        Thu, 19 Jan 2023 15:20:32 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q9so2837732pgq.5;
        Thu, 19 Jan 2023 15:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8VFYGKVQDx9YS3Bf+JaHr5ao9ClGu3C5S4SGB4QR9A=;
        b=SN+eVLi1DRWR6rpSY2PJV70czrUs98v9bI5D2abVAhBXs5JbxT/xeCGOi/5PrneIJv
         z8ts8tKo4C2kelodjYn8/A81cUlm28upoURRlm+J3SwgKIC01dXP2G9mlfR21jEHagOt
         AgdpBaAAlgbn1ztP2fKNvRA16SRAE6fd/KNyNSMEp3yG90WZUR6JdDwzIEuZ60GMMBIE
         0XW8EH0lnzwVIF2gaOHYmtuS8/6EgJrt7pM2GPYjOpyq+cVDOixiF7Uz5YrybdLgs16/
         FgdBrfm+RiuTgWcb7GVH3jUu5b05CKFys9IlL3fkrZvq7rmH07TFi4ZX/XR8GLWNyRjK
         HeGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8VFYGKVQDx9YS3Bf+JaHr5ao9ClGu3C5S4SGB4QR9A=;
        b=YMKU7iR/pVkiKulxaDcL2fwiSdG3cwEHInqNGE+cT4ClDuQvGI0tHHJH0Z1sjDGRc1
         85jGwZnGnlNdxqFCHMy/doSdnmurMZ1RApUkTVvqsAjgPoJs0iLL5ZcGp5N8NXpYShNb
         t3TM80JJNofPQ+thbGMFfHlFKkJUVEQgRdRvk6QymUCXmgi4NB3rJhsgnFulobxv36QX
         C22XZDdZ4ejuxfY8MfPEQ+0dzZkpwqFWXaLHaEwLGbA4hlR8/octloSEFAdCH6F7hSXO
         ucxU5XPzT3hS8ZpWdaS14WNJTYxCgsncnl0ZOXub+Htr9jGBVjnEkubZMjUMkJBZL0tP
         eB3A==
X-Gm-Message-State: AFqh2kpFHEhJpqFVH9mtm2/XhsVMVWVXSZSNOd41ftNSi+aga6Zj1VsD
        0pP/JsF6m6Ci1iqgeTFbGIM=
X-Google-Smtp-Source: AMrXdXurMgRBKbvVa+DeeN1KDnY9oIpSJ0B1l7OtzdgBetQn9I69jfzDhB7UqBrcd/mZIzoZShPITQ==
X-Received: by 2002:aa7:8506:0:b0:58d:966b:2f63 with SMTP id v6-20020aa78506000000b0058d966b2f63mr11421708pfn.20.1674170432247;
        Thu, 19 Jan 2023 15:20:32 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d8-20020aa797a8000000b0058837da69edsm21036005pfq.128.2023.01.19.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:20:31 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/exynos: Drop unbalanced obj unref
Date:   Thu, 19 Jan 2023 15:20:37 -0800
Message-Id: <20230119232037.2885568-1-robdclark@gmail.com>
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

In the error path, exynos_drm_gem_mmap() was dropping an obj reference
that it doesn't own.

Fixes: 832316c704fe ("drm/exynos: use drm generic mmap interface")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 3e493f48e0d4..65bca61e63a3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -363,7 +363,6 @@ int exynos_drm_gem_dumb_create(struct drm_file *file_priv,
 static int exynos_drm_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct exynos_drm_gem *exynos_gem = to_exynos_gem(obj);
-	int ret;
 
 	if (obj->import_attach)
 		return dma_buf_mmap(obj->dma_buf, vma, 0);
@@ -383,16 +382,7 @@ static int exynos_drm_gem_mmap(struct drm_gem_object *obj, struct vm_area_struct
 		vma->vm_page_prot =
 			pgprot_noncached(vm_get_page_prot(vma->vm_flags));
 
-	ret = exynos_drm_gem_mmap_buffer(exynos_gem, vma);
-	if (ret)
-		goto err_close_vm;
-
-	return ret;
-
-err_close_vm:
-	drm_gem_vm_close(vma);
-
-	return ret;
+	return exynos_drm_gem_mmap_buffer(exynos_gem, vma);
 }
 
 /* low-level interface prime helpers */
-- 
2.38.1

