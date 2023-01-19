Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F9D67467B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjASW5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjASW5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:57:03 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C4059F5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:40:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e10so2754584pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNVirr7Mh55HoZPwbq9lUXgYo3JdiDpzBy8o0MLFF70=;
        b=aFrVtm751bC7Wj4QpfEcse3y80R5JKQlg6yJDGcYfJqg2vUWXjOnVuGkBhuMHVoMc9
         7k/nRUyAdZqum1UxhknqAz9ycBaiPKFJu7CqmLucaeAmSm6BxwomU6SpJAMKByRA6M/f
         yuVwoVStRilq5e6F5twMsddLu7ppayYGugLAXQxZjK51e7Vsb/JF4FgS/uIjV5plMacP
         v3+dpRBC9fBa5K6FapBglGnZuEzFsx7mZ+rjFj9awLRsCudjmZ92Jd0mMW1S8ZyDfRvk
         TztGrLmb/oVmd9wmiKG7Xf1EADYPseot/SOSBFMV4cZ3bGd8ZuBygXjxyNolq6C3a1MD
         Sr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNVirr7Mh55HoZPwbq9lUXgYo3JdiDpzBy8o0MLFF70=;
        b=NbM3w0gIStnexX0tfrM95pX/2T6eu2Slr57bpVYG/VVRBEW0zjh+6mNCsnodWRz08S
         XXYYUJcPXF6IYM3vSKkYXvf+DtSoOVYu2tJZg3SUz4MT0k70xgBMT/8SEuHmCc1yzpd3
         rrwXK5lUEousrozTr08mtDNMTdY5TxcItU8wzMoilqLXC/l+Dls3dFq9rfM2s4pjcgo8
         dOKMk3mMruvXvRZLkr5siI1xcPUSjXToKcdS9Qta9be76W/cVuKP+uQ8d4aBgdC01W+n
         DSbb2KRt9vFgTLA8XexT3fghxdu3tJJZhH7l7XmYHpeboAPBP5QmMWebi9MfW9wVB8vI
         +viw==
X-Gm-Message-State: AFqh2kp0wzcTlv+IGJOgtbo/sO8p0k+v0eSWC6RzBDJymPBpz/BnKbgR
        /5KJpNkCgwlq/9P1EPKO9dA=
X-Google-Smtp-Source: AMrXdXuTk57vqfyycosJjc83ytHzfOrTz8oBlyWzkuEA4oYwVi918dWiZhgHT9pQS5GsV8DtjUo1+g==
X-Received: by 2002:a05:6a00:188b:b0:576:de1:cd32 with SMTP id x11-20020a056a00188b00b005760de1cd32mr16243662pfh.0.1674168048178;
        Thu, 19 Jan 2023 14:40:48 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id 63-20020a621942000000b0056d98e359a5sm24553533pfz.165.2023.01.19.14.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:40:47 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (moderated list:DRM DRIVERS FOR
        MEDIATEK), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH] drm/mediatek: Remove dependency on GEM DMA helper
Date:   Thu, 19 Jan 2023 14:40:52 -0800
Message-Id: <20230119224052.2879106-1-robdclark@gmail.com>
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

It appears that the dependency on the DMA helpers was only for
drm_gem_dma_vm_ops.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/mediatek/Kconfig       | 1 -
 drivers/gpu/drm/mediatek/mtk_drm_gem.c | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 369e495d0c3e..b451dee64d34 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -7,7 +7,6 @@ config DRM_MEDIATEK
 	depends on HAVE_ARM_SMCCC
 	depends on OF
 	depends on MTK_MMSYS
-	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index 47e96b0289f9..9b3d15d3a983 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -16,13 +16,18 @@
 
 static int mtk_drm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
+static const struct vm_operations_struct vm_ops = {
+	.open = drm_gem_vm_open,
+	.close = drm_gem_vm_close,
+};
+
 static const struct drm_gem_object_funcs mtk_drm_gem_object_funcs = {
 	.free = mtk_drm_gem_free_object,
 	.get_sg_table = mtk_gem_prime_get_sg_table,
 	.vmap = mtk_drm_gem_prime_vmap,
 	.vunmap = mtk_drm_gem_prime_vunmap,
 	.mmap = mtk_drm_gem_object_mmap,
-	.vm_ops = &drm_gem_dma_vm_ops,
+	.vm_ops = &vm_ops,
 };
 
 static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
-- 
2.38.1

