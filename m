Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8996619D5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjAHVON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236294AbjAHVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:13:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51890DED7
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:13:36 -0800 (PST)
Received: from workpc.. (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D1FC6600357;
        Sun,  8 Jan 2023 21:13:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673212415;
        bh=Ez5dB/rkALjWV2HFndt9nadNf0wBhw1F0LNBdhTogSc=;
        h=From:To:Cc:Subject:Date:From;
        b=MypaMY67pkHhLAyD3gOjb89yRq+9zbVWCAR0beiNk55c/8ecTylRY9YZG9fEWdxwc
         i52uMAbxGge7m9tr/EieApG4rcid9+gUV4JKuro6Fm1rfUmINbVc6duW4ssAgpebIK
         JH/Q1LBr1SXVcweOhb/PbyweU4YmZO5T6AC/l/031w1y48WEHsOb/RMuU9V6Ah4LN5
         UPAxRdw8hionuUrriOhlytDzcNW54aa5v1a+DLuW42eGMVxrHjhkOdCqVRyFu2Y2Nz
         sJz4EfTM2D3pNSQ6bzr+lRu+hHOxMUXh6UpF0sPM2I8WqyouZ7Pg87NVSf0S7B7ztO
         +fyuyldy0wu3g==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     Rob Clark <robdclark@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/shmem-helper: Remove another errant put in error path
Date:   Mon,  9 Jan 2023 00:13:11 +0300
Message-Id: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.38.1
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

drm_gem_shmem_mmap() doesn't own reference in error code path, resulting
in the dma-buf shmem GEM object getting prematurely freed leading to a
later use-after-free.

Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f21f47737817..8b20b41497e8 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -624,11 +624,14 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 	int ret;
 
 	if (obj->import_attach) {
-		/* Drop the reference drm_gem_mmap_obj() acquired.*/
-		drm_gem_object_put(obj);
 		vma->vm_private_data = NULL;
+		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
+
+		/* Drop the reference drm_gem_mmap_obj() acquired.*/
+		if (!ret)
+			drm_gem_object_put(obj);
 
-		return dma_buf_mmap(obj->dma_buf, vma, 0);
+		return ret;
 	}
 
 	ret = drm_gem_shmem_get_pages(shmem);
-- 
2.38.1

