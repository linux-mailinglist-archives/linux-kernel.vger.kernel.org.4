Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57C36429F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 14:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiLEN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 08:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiLEN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 08:56:30 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A593B8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 05:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uZS2YlPKAGNQfivHgbSmAIM4sCwER+o4TAV8vJgXz8w=; b=HQzjLtssEbTdGTtTKrUBJwnOTz
        MiF8nXG+Hezn7PDo6Ng86NCQen4xchs8gTaWqFbsDdFlu8PvGHvbdSgl0ol3PimDCDQ3Ocqyf1EIH
        P9HoMg/vYHx3tJkDPD7iohCTszKcCixnTxgeqqa+Ere+AAKmfu6ym+82OZSMaBzQPn9m+olJywzkW
        zzvIZtAmwo1KJSJF5fAmYb3KjKRNQ1miuEF0SivIYU4Q4XcLQx8lHQKJeHPWiA93c1A7xSaxy5qGG
        9xuk+luZKmMQFkjRnFU2UlrJ2wdQK/ZbPwQJ4RlFbCJJIPmK8HZra7I/np8xCk3zbNNuZf9m+eKa+
        biuln9zA==;
Received: from [41.74.137.107] (helo=killbill.home)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1p2Bx9-00FUSn-Vl; Mon, 05 Dec 2022 14:56:16 +0100
From:   Melissa Wen <mwen@igalia.com>
To:     emma@anholt.net, mwen@igalia.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maira Canal <mcanal@igalia.com>, kernel-dev@igalia.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/v3d: replace obj lookup steps with drm_gem_objects_lookup
Date:   Mon,  5 Dec 2022 12:55:38 -0100
Message-Id: <20221205135538.3545051-3-mwen@igalia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221205135538.3545051-1-mwen@igalia.com>
References: <20221205135538.3545051-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As v3d_lookup_bos() performs the same steps as drm_gem_objects_lookup(),
replace the explicit code in v3d to simply use the DRM function.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_gem.c | 49 +++--------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 31a37572c11d..6e152ef26358 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -299,10 +299,6 @@ v3d_lookup_bos(struct drm_device *dev,
 	       u64 bo_handles,
 	       u32 bo_count)
 {
-	u32 *handles;
-	int ret = 0;
-	int i;
-
 	job->bo_count = bo_count;
 
 	if (!job->bo_count) {
@@ -313,48 +309,9 @@ v3d_lookup_bos(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	job->bo = kvmalloc_array(job->bo_count,
-				 sizeof(struct drm_gem_dma_object *),
-				 GFP_KERNEL | __GFP_ZERO);
-	if (!job->bo) {
-		DRM_DEBUG("Failed to allocate validated BO pointers\n");
-		return -ENOMEM;
-	}
-
-	handles = kvmalloc_array(job->bo_count, sizeof(u32), GFP_KERNEL);
-	if (!handles) {
-		ret = -ENOMEM;
-		DRM_DEBUG("Failed to allocate incoming GEM handles\n");
-		goto fail;
-	}
-
-	if (copy_from_user(handles,
-			   (void __user *)(uintptr_t)bo_handles,
-			   job->bo_count * sizeof(u32))) {
-		ret = -EFAULT;
-		DRM_DEBUG("Failed to copy in GEM handles\n");
-		goto fail;
-	}
-
-	spin_lock(&file_priv->table_lock);
-	for (i = 0; i < job->bo_count; i++) {
-		struct drm_gem_object *bo = idr_find(&file_priv->object_idr,
-						     handles[i]);
-		if (!bo) {
-			DRM_DEBUG("Failed to look up GEM BO %d: %d\n",
-				  i, handles[i]);
-			ret = -ENOENT;
-			spin_unlock(&file_priv->table_lock);
-			goto fail;
-		}
-		drm_gem_object_get(bo);
-		job->bo[i] = bo;
-	}
-	spin_unlock(&file_priv->table_lock);
-
-fail:
-	kvfree(handles);
-	return ret;
+	return drm_gem_objects_lookup(file_priv,
+				      (void __user *)(uintptr_t)bo_handles,
+				      job->bo_count, &job->bo);
 }
 
 static void
-- 
2.35.1

