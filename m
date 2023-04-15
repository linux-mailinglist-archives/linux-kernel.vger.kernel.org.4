Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1106E2E77
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 04:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjDOCEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 22:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjDOCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 22:04:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8244C39
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 19:04:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681524285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvcA5HnArT0juQcF/pl/UzocaIDN3s8qO05ZD9AHBzE=;
        b=WAdGjtojvZtiEi0uFTGSkIhurdv40v6CO9/2ElIZENNMe/XpJb6QqRTo7lK+AVvZ/QSaGu
        SPGx0ndC+0A0mVsTL5HcIh77lBq3+ojEHj/h2i1mdbQwHu5g5UQonlvrLc3bzGwj/iF8Hw
        LZAU4Yl5o+nGNAQHinyQRG/Xo7Arffk53TSjXUxrl95YRoifE4rCEgk9k6PbW/RCxbK3lg
        liSjFPsFw/KfoepDZKW8S4GVazp/pNLxibZntNctNFHBpdRExSRd8LLAIr6uNSys3ETss5
        bfw+YjOoIq+xe3QCyRsDSlzi5w7Nn3SJS2plz21OPFI94G/6w4U2OgU/zVbZdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681524285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QvcA5HnArT0juQcF/pl/UzocaIDN3s8qO05ZD9AHBzE=;
        b=CwlW0QiZiaCRp7T+kaLraqtWcuxFmF7F3Nw4r2zMdjo8BTw+gg7+DNlx4B/zx+6AeXqakD
        jLgy4BY6abTjgwBQ==
To:     =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Tanmay Bhushan <007047221b@gmail.com>
Subject: [PATCH v3] drm/nouveau: fix incorrect conversion to
 dma_resv_wait_timeout()
In-Reply-To: <20230415012137.615305-1-john.ogness@linutronix.de>
References: <20230415012137.615305-1-john.ogness@linutronix.de>
Date:   Sat, 15 Apr 2023 04:08:50 +0206
Message-ID: <87edolaomt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
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
 I just realized that the nouveau driver style prefers to scope
 variables used only in loops.

 v3: Define @lret within the for-loop.

 drivers/gpu/drm/nouveau/nouveau_gem.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index f77e44958037..ab9062e50977 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -645,7 +645,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 				struct drm_nouveau_gem_pushbuf_reloc *reloc,
 				struct drm_nouveau_gem_pushbuf_bo *bo)
 {
-	long ret = 0;
+	int ret = 0;
 	unsigned i;
 
 	for (i = 0; i < req->nr_relocs; i++) {
@@ -653,6 +653,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 		struct drm_nouveau_gem_pushbuf_bo *b;
 		struct nouveau_bo *nvbo;
 		uint32_t data;
+		long lret;
 
 		if (unlikely(r->bo_index >= req->nr_buffers)) {
 			NV_PRINTK(err, cli, "reloc bo index invalid\n");
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
