Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97AA6B6C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 00:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCLXbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 19:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCLXbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 19:31:48 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D22A162
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so10809255edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678663902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug0UWV1hH6yIQRdNc6r9G/GtUMEjsZqb/YaG3qyeq7U=;
        b=i5IFouup19hffz23+1uI4jLWHgu99D6QbX66DDD5Btyk5eNuJR/EdQkH81hJKua6mn
         Z2KjCaHIMP4FMK8Z5eSwp5ihDp2pPnzTOFjWd6u9BlS/ZvJ5pM5r6/z3jmLdzK6dmXee
         2PZnD379UbhZAwXFgpb5O4zHowm8ZtpcAfB128L85XoAkchYWjkg7fD7mPCYJkPxOKjJ
         Qj1uJzaFdW4WwApYHN08ERYvaGkv9O2ZDWXsfPtxcgQ4Pkc4mIlUVDvGLYHQyJRnu9/E
         xdyRXp4rZc81dCpWyi3rT9J+bgJ5lIMc20KwcIAW7g27aSamCAeVU6dPjCiturmY9Too
         mrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678663902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug0UWV1hH6yIQRdNc6r9G/GtUMEjsZqb/YaG3qyeq7U=;
        b=XEHNfkmHaN+/dzvNaC/kt4MXcbPtkY6pA+NmSauFnk9Rwg8oJAnZt42qDvUYoN1kAy
         IR79QYiMQ4OMPpyCs/CR3aR5BNHCEJkAMxhvxBaD/gTdppnvDeFomDFp4Inc6ah3Al6u
         K1jMEBiJvKg0tj3NMjo7mquU8m8RecMusnj3jPXGlL5/KWPfRy0h/yScPAgLWEtcha5s
         1833AiFnuB9V3sJnqqFgzJAMzeTd8iW+gUbYSEIBIrZzzdh97hja8kEu4/tnHGxFyNki
         JrBvqt1iiLgZAcNYYoXT0Oc6HSpFAjhQrXMABhSdneVu1GSK5hBRtDz9lH3yI3BpS7eG
         ylNw==
X-Gm-Message-State: AO0yUKUoky+L7jGFdJW0cv6yaYAZJZyEtwpG6qJIy2dOudjRvLsYWWu+
        CxoeaSa0KVpMOc5SXoetws4=
X-Google-Smtp-Source: AK7set+bXCN4Mt45oF5XVHG28M27QQ6mDhu55XzmI+LM6RlFn0Ysif3IPDBiBk6S5gNX1T2txKQXQA==
X-Received: by 2002:a17:907:6e01:b0:8e0:4baf:59d7 with SMTP id sd1-20020a1709076e0100b008e04baf59d7mr43197922ejc.31.1678663902296;
        Sun, 12 Mar 2023 16:31:42 -0700 (PDT)
Received: from centennial.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id vv11-20020a170907a68b00b009226f644a07sm2009958ejc.139.2023.03.12.16.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 16:31:41 -0700 (PDT)
From:   Erico Nunes <nunes.erico@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 1/3] drm/lima: add usage counting method to ctx_mgr
Date:   Mon, 13 Mar 2023 00:30:50 +0100
Message-Id: <20230312233052.21095-2-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312233052.21095-1-nunes.erico@gmail.com>
References: <20230312233052.21095-1-nunes.erico@gmail.com>
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

lima maintains a context manager per drm_file, similar to amdgpu.
In order to account for the complete usage per drm_file, all of the
associated contexts need to be considered.
Previously released contexts also need to be accounted for but their
drm_sched_entity info is gone once they get released, so account for it
in the ctx_mgr.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_ctx.c | 30 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/lima/lima_ctx.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
index 891d5cd5019a..e008e586fad0 100644
--- a/drivers/gpu/drm/lima/lima_ctx.c
+++ b/drivers/gpu/drm/lima/lima_ctx.c
@@ -15,6 +15,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dev = dev;
+	ctx->mgr = mgr;
 	kref_init(&ctx->refcnt);
 
 	for (i = 0; i < lima_pipe_num; i++) {
@@ -42,10 +43,17 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
 static void lima_ctx_do_release(struct kref *ref)
 {
 	struct lima_ctx *ctx = container_of(ref, struct lima_ctx, refcnt);
+	struct lima_ctx_mgr *mgr = ctx->mgr;
 	int i;
 
-	for (i = 0; i < lima_pipe_num; i++)
+	for (i = 0; i < lima_pipe_num; i++) {
+		struct lima_sched_context *context = &ctx->context[i];
+		struct drm_sched_entity *entity = &context->base;
+
+		mgr->elapsed_ns[i] += entity->elapsed_ns;
+
 		lima_sched_context_fini(ctx->dev->pipe + i, ctx->context + i);
+	}
 	kfree(ctx);
 }
 
@@ -99,3 +107,23 @@ void lima_ctx_mgr_fini(struct lima_ctx_mgr *mgr)
 	xa_destroy(&mgr->handles);
 	mutex_destroy(&mgr->lock);
 }
+
+void lima_ctx_mgr_usage(struct lima_ctx_mgr *mgr, u64 usage[lima_pipe_num])
+{
+	struct lima_ctx *ctx;
+	unsigned long id;
+
+	for (int i = 0; i < lima_pipe_num; i++)
+		usage[i] = mgr->elapsed_ns[i];
+
+	mutex_lock(&mgr->lock);
+	xa_for_each(&mgr->handles, id, ctx) {
+		for (int i = 0; i < lima_pipe_num; i++) {
+			struct lima_sched_context *context = &ctx->context[i];
+			struct drm_sched_entity *entity = &context->base;
+
+			usage[i] += entity->elapsed_ns;
+		}
+	}
+	mutex_unlock(&mgr->lock);
+}
diff --git a/drivers/gpu/drm/lima/lima_ctx.h b/drivers/gpu/drm/lima/lima_ctx.h
index 74e2be09090f..6068863880eb 100644
--- a/drivers/gpu/drm/lima/lima_ctx.h
+++ b/drivers/gpu/drm/lima/lima_ctx.h
@@ -12,6 +12,7 @@
 struct lima_ctx {
 	struct kref refcnt;
 	struct lima_device *dev;
+	struct lima_ctx_mgr *mgr;
 	struct lima_sched_context context[lima_pipe_num];
 	atomic_t guilty;
 
@@ -23,6 +24,7 @@ struct lima_ctx {
 struct lima_ctx_mgr {
 	struct mutex lock;
 	struct xarray handles;
+	u64 elapsed_ns[lima_pipe_num];
 };
 
 int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id);
@@ -31,5 +33,6 @@ struct lima_ctx *lima_ctx_get(struct lima_ctx_mgr *mgr, u32 id);
 void lima_ctx_put(struct lima_ctx *ctx);
 void lima_ctx_mgr_init(struct lima_ctx_mgr *mgr);
 void lima_ctx_mgr_fini(struct lima_ctx_mgr *mgr);
+void lima_ctx_mgr_usage(struct lima_ctx_mgr *mgr, u64 usage[lima_pipe_num]);
 
 #endif
-- 
2.39.2

