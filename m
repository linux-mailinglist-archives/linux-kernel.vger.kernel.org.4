Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5176F6E2E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDOBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDOBXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:23:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268C65B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 18:23:34 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681521812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wk6tBRL4rOUhZyc8yDlJOrUexb/aW0doiLcILhv9l7I=;
        b=K3VpJIa7/dxb0WP7AvWLftrAQNOTsaZjvZmKQ6YN2nguYFLsK6AsUuyRV9uDrC6jiWGzPD
        lganGKWEcmuOvIgBuHlfalKv3fuJVLucbbyw+e9JWAQyXZ84woRWVrjWslhuXs85CfHp9c
        omAzaAOG5TzCfmfat02AeNfKJW9OCG2hOwekQ+PE6TYZMtIjsUYjIU2xXGrikg1ws+V8IS
        bdJ/57TjCAwVw/BA+SNG8YFss8jEtMXwtWg+dZqBAbssKa0td9ruPW/8anxCcbkqwD67qg
        8bfNP4vxgc3Ums3ojYGSf6fK8w0v6DukzGWb5n0z5MF+slXH5C6fP3az35hViA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681521812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wk6tBRL4rOUhZyc8yDlJOrUexb/aW0doiLcILhv9l7I=;
        b=sD8RwqQUN1CEo6InqlzRlqogbgz0MsLVKyf2S6UvbYcE7yi6nc7UxCvpXgQQkjg45mnbnl
        XS7dLzTzE7fWAlDw==
To:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH v2] drm/nouveau: fix incorrect conversion to dma_resv_wait_timeout()
Date:   Sat, 15 Apr 2023 03:27:37 +0206
Message-Id: <20230415012137.615305-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 41d351f29528 ("drm/nouveau: stop using ttm_bo_wait")
converted from ttm_bo_wait_ctx() to dma_resv_wait_timeout().
However, dma_resv_wait_timeout() returns greater than zero on
success as opposed to ttm_bo_wait_ctx(). As a result, relocs
will fail and log errors even when it was a success.

Change the return code handling to match that of
nouveau_gem_ioctl_cpu_prep(), which was already using
dma_resv_wait_timeout() correctly.

Fixes: 41d351f29528 ("drm/nouveau: stop using ttm_bo_wait")
Reported-by: Tanmay Bhushan <007047221b@gmail.com>
Link: https://lore.kernel.org/lkml/20230119225351.71657-1-007047221b@gmail.com
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 The original report was actually a patch that needed fixing.
 Since nobody has stepped up to fix this regression correctly,
 I'm posting the v2.

 This is a real regression introduced in 6.3-rc1.

 drivers/gpu/drm/nouveau/nouveau_gem.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index f77e44958037..346839c24273 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -645,8 +645,9 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 				struct drm_nouveau_gem_pushbuf_reloc *reloc,
 				struct drm_nouveau_gem_pushbuf_bo *bo)
 {
-	long ret = 0;
+	int ret = 0;
 	unsigned i;
+	long lret;
 
 	for (i = 0; i < req->nr_relocs; i++) {
 		struct drm_nouveau_gem_pushbuf_reloc *r = &reloc[i];
@@ -703,13 +704,18 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 				data |= r->vor;
 		}
 
-		ret = dma_resv_wait_timeout(nvbo->bo.base.resv,
-					    DMA_RESV_USAGE_BOOKKEEP,
-					    false, 15 * HZ);
-		if (ret == 0)
+		lret = dma_resv_wait_timeout(nvbo->bo.base.resv,
+					     DMA_RESV_USAGE_BOOKKEEP,
+					     false, 15 * HZ);
+		if (!lret)
 			ret = -EBUSY;
+		else if (lret > 0)
+			ret = 0;
+		else
+			ret = lret;
+
 		if (ret) {
-			NV_PRINTK(err, cli, "reloc wait_idle failed: %ld\n",
+			NV_PRINTK(err, cli, "reloc wait_idle failed: %d\n",
 				  ret);
 			break;
 		}

base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
-- 
2.30.2

