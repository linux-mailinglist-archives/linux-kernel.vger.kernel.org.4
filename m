Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741C973787C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFUA7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFUA7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:59:00 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B891988
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wMbMm2LjbMgpiJqJVmk81D3jcaDM5uS/Z4Si5959JYc=; b=QIwarYKnq64Uj9A19OtKYgeo+0
        9wjl6C3e8cPUCZtOyJblrw87TDaLkhfaGSmUPDN5L1WmFKge/xUZ6oMOulQ0hMdJUN9R1ZHN8Jpy8
        ArwGpQHbNLo5pBk0FpUAzy7f07le7/QhaW6IJoeq57PZmSiNApDdVRyNArWJMQFDxueT8qSeqhQxH
        oH59LxBDhXBstxzVBld8BSn8DuMpeX3mDQPCkrfdLv5OoR5qwiudN/ZwiWSE4nLluIIERebdDlOra
        UUznXhdeONCjbE8/PWnPOS8Cw+ls49cIGXoS4jMLgUtm9FPxm6R+9F8bcmAVsid1Sbk0mRKUPQOHE
        8HF94R0g==;
Received: from [179.113.218.86] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qBmBH-0011pg-SC; Wed, 21 Jun 2023 02:58:44 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RFC PATCH v3 4/4] drm/i915: Implement DRM_IOCTL_GET_RESET
Date:   Tue, 20 Jun 2023 21:57:19 -0300
Message-ID: <20230621005719.836857-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621005719.836857-1-andrealmeid@igalia.com>
References: <20230621005719.836857-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement get_reset ioctl for i915.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c    | 18 ++++++++++++++++++
 drivers/gpu/drm/i915/gem/i915_gem_context.h    |  2 ++
 .../gpu/drm/i915/gem/i915_gem_context_types.h  |  2 ++
 drivers/gpu/drm/i915/i915_driver.c             |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 9a9ff84c90d7..fba8c9bbc7e9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1666,6 +1666,8 @@ i915_gem_create_context(struct drm_i915_private *i915,
 		ctx->uses_protected_content = true;
 	}
 
+	ctx->dev_reset_counter = i915_reset_count(&i915->gpu_error);
+
 	trace_i915_context_create(ctx);
 
 	return ctx;
@@ -2558,6 +2560,22 @@ int i915_gem_context_reset_stats_ioctl(struct drm_device *dev,
 	return 0;
 }
 
+int i915_gem_get_reset(struct drm_file *filp, struct drm_device *dev,
+		       struct drm_get_reset *reset)
+{
+	struct i915_gem_context *ctx;
+
+	ctx = i915_gem_context_lookup(file->driver_priv, reset->ctx_id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	reset->dev_reset_count = i915_reset_count(&i915->gpu_error) - ctx->dev_reset_count;
+	reset->ctx_reset_count = ctx->guilty_count;
+
+	i915_gem_context_put(ctx);
+	return 0;
+}
+
 /* GEM context-engines iterator: for_each_gem_engine() */
 struct intel_context *
 i915_gem_engines_iter_next(struct i915_gem_engines_iter *it)
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.h b/drivers/gpu/drm/i915/gem/i915_gem_context.h
index e5b0f66ea1fe..9ee119d8123f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.h
@@ -138,6 +138,8 @@ int i915_gem_context_setparam_ioctl(struct drm_device *dev, void *data,
 				    struct drm_file *file_priv);
 int i915_gem_context_reset_stats_ioctl(struct drm_device *dev, void *data,
 				       struct drm_file *file);
+int i915_gem_get_reset(struct drm_file *file_priv, struct drm_device *dev,
+		       struct drm_get_reset *reset);
 
 struct i915_gem_context *
 i915_gem_context_lookup(struct drm_i915_file_private *file_priv, u32 id);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index cb78214a7dcd..2e4cf0f0d3dc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -414,6 +414,8 @@ struct i915_gem_context {
 		/** @engines: list of stale engines */
 		struct list_head engines;
 	} stale;
+
+	uint64_t dev_reset_counter;
 };
 
 #endif /* __I915_GEM_CONTEXT_TYPES_H__ */
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 97244541ec28..640304141ada 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1805,6 +1805,8 @@ static const struct drm_driver i915_drm_driver = {
 	.postclose = i915_driver_postclose,
 	.show_fdinfo = i915_drm_client_fdinfo,
 
+	.get_reset = i915_gem_get_reset,
+
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import = i915_gem_prime_import,
-- 
2.41.0

