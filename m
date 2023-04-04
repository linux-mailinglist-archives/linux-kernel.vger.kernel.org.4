Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB1C6D5589
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 02:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjDDA2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 20:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjDDA2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 20:28:22 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9FFD269A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 17:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oHJPC
        R5cDiaiV1FVOQomyGkFxYiM5RTm2vP75G8m934=; b=AJwp/yjE8nyI2OIK7Covx
        bwdcNUJb/fGnr2nv6u7iimNpp4h8H0eoeIlogehKVhEDc61yMg+AuuUbi+Lc1fRN
        LHUOHSSKy/LA5j9HiC9MNnutLqHIU7ofxzCWxcCzwaPeJ5rLETit7GqN0ndGMmMh
        OtGhFGULFmCOwxZDAdHACs=
Received: from yuq-Aspire-4738G.lan (unknown [116.225.76.16])
        by zwqz-smtp-mta-g3-0 (Coremail) with SMTP id _____wBHK4Tkbitk8woAAg--.8076S5;
        Tue, 04 Apr 2023 08:27:25 +0800 (CST)
From:   yq882255@163.com
To:     dri-devel@lists.freedesktop.org
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Qiang Yu <yuq825@gmail.com>
Subject: [PATCH 3/3] Revert "drm/lima: add usage counting method to ctx_mgr"
Date:   Tue,  4 Apr 2023 08:26:01 +0800
Message-Id: <20230404002601.24136-4-yq882255@163.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404002601.24136-1-yq882255@163.com>
References: <20230404002601.24136-1-yq882255@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHK4Tkbitk8woAAg--.8076S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr48Zr47Jr43JF1rGryDWrg_yoW5Zr48pF
        sxJa12yFWxA3WUWayDJ3yDZr13twn0yas5G34kG3ZYvr9YvF40gF4rJF45ZrWYqryxA34I
        vw4UKr17Ar47t37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jd0edUUUUU=
X-Originating-IP: [116.225.76.16]
X-CM-SenderInfo: d1tymjqsvvqiywtou0bp/1tbiGBBHGlv2lhcz5AAAsu
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiang Yu <yuq825@gmail.com>

This reverts commit bccafec957a5c4b22ac29e53a39e82d0a0008348.

This is due to the depend commit has been reverted on upstream:
baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"")

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 drivers/gpu/drm/lima/lima_ctx.c | 30 +-----------------------------
 drivers/gpu/drm/lima/lima_ctx.h |  3 ---
 2 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
index e008e586fad0..891d5cd5019a 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -15,7 +15,6 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dev = dev;
-	ctx->mgr = mgr;
 	kref_init(&ctx->refcnt);
 
 	for (i = 0; i < lima_pipe_num; i++) {
@@ -43,17 +42,10 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 static void lima_ctx_do_release(struct kref *ref)
 {
 	struct lima_ctx *ctx = container_of(ref, struct lima_ctx, refcnt);
-	struct lima_ctx_mgr *mgr = ctx->mgr;
 	int i;
 
-	for (i = 0; i < lima_pipe_num; i++) {
-		struct lima_sched_context *context = &ctx->context[i];
-		struct drm_sched_entity *entity = &context->base;
-
-		mgr->elapsed_ns[i] += entity->elapsed_ns;
-
+	for (i = 0; i < lima_pipe_num; i++)
 		lima_sched_context_fini(ctx->dev->pipe + i, ctx->context + i);
-	}
 	kfree(ctx);
 }
 
@@ -107,23 +99,3 @@ void lima_ctx_mgr_fini(struct lima_ctx_mgr *mgr)
 	xa_destroy(&mgr->handles);
 	mutex_destroy(&mgr->lock);
 }
-
-void lima_ctx_mgr_usage(struct lima_ctx_mgr *mgr, u64 usage[lima_pipe_num])
-{
-	struct lima_ctx *ctx;
-	unsigned long id;
-
-	for (int i = 0; i < lima_pipe_num; i++)
-		usage[i] = mgr->elapsed_ns[i];
-
-	mutex_lock(&mgr->lock);
-	xa_for_each(&mgr->handles, id, ctx) {
-		for (int i = 0; i < lima_pipe_num; i++) {
-			struct lima_sched_context *context = &ctx->context[i];
-			struct drm_sched_entity *entity = &context->base;
-
-			usage[i] += entity->elapsed_ns;
-		}
-	}
-	mutex_unlock(&mgr->lock);
-}
diff --git a/drivers/gpu/drm/lima/lima_ctx.h b/drivers/gpu/drm/lima/lima_ctx.h
index 6068863880eb..74e2be09090f 100644
--- a/drivers/gpu/drm/lima/lima_ctx.h
+++ b/drivers/gpu/drm/lima/lima_ctx.h
@@ -12,7 +12,6 @@
 struct lima_ctx {
 	struct kref refcnt;
 	struct lima_device *dev;
-	struct lima_ctx_mgr *mgr;
 	struct lima_sched_context context[lima_pipe_num];
 	atomic_t guilty;
 
@@ -24,7 +23,6 @@ struct lima_ctx {
 struct lima_ctx_mgr {
 	struct mutex lock;
 	struct xarray handles;
-	u64 elapsed_ns[lima_pipe_num];
 };
 
 int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id);
@@ -33,6 +31,5 @@ struct lima_ctx *lima_ctx_get(struct lima_ctx_mgr *mgr, u32 id);
 void lima_ctx_put(struct lima_ctx *ctx);
 void lima_ctx_mgr_init(struct lima_ctx_mgr *mgr);
 void lima_ctx_mgr_fini(struct lima_ctx_mgr *mgr);
-void lima_ctx_mgr_usage(struct lima_ctx_mgr *mgr, u64 usage[lima_pipe_num]);
 
 #endif
-- 
2.25.1

