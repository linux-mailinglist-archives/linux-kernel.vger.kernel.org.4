Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4732474CEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjGJHtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjGJHsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A992
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C6E60EB9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AE0C433C8;
        Mon, 10 Jul 2023 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975287;
        bh=A/pLaw+uJXzMbunZZUuKSY2x3xf0ard7YULxacsm45Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=q2z39TMdCYZM+Q2tQJuFxEf6HqVLTv9g12+ayp23zgEZnd5/eEgS35Mdc6QNJRxi0
         +U0u0qcdztqisN0Pqe9a1tfpmO79G04THLzCryM3gKtuvYeiwKCFj8GpyfEAynK9mQ
         ycgyGYFQ+gsKFcukvesTuNQqDAdROYCq7PE6gjHeDiC3U6nnQKLQOWpB+A5fLIQ7KI
         f6cLe1mQ/MblUa3iLjB5iY1nch0S4qxaPCTo8KXl7hPAp3nM+unyRmib/Yz8Wneph/
         chKCi6ckbwywl9A+dKZl732XiBYYfZ6we1ikeRnTGkhnMV0mQ4YlK2mcBfM419lhZ9
         ia667Nv1dCMUA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 10 Jul 2023 09:47:40 +0200
Subject: [PATCH 09/11] drm/vc4: tests: pv-muxing: Switch to managed locking
 init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-kms-kunit-actions-rework-v1-9-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=6443; i=mripard@kernel.org;
 h=from:subject:message-id; bh=A/pLaw+uJXzMbunZZUuKSY2x3xf0ard7YULxacsm45Y=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmrt8+oemwbXvDae/Uz97eLHxj097/m3FhmtGLGthkx839t
 5NPq7ChlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBE7pQzMtwRd7rmz7t40XoRm19RDr
 t6dR9mczB4cb7+ER04Ue1/w2qGvwJ86z8k2PE/nCte/1w+0WKFe/bvtHUluswLd05/sb1MjBsA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper to init the locking context allows to remove some
boilerplate.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 42 ++++++++++++--------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index 776a7b01608f..ff1deaed0cab 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -20,7 +20,6 @@
 
 struct pv_muxing_priv {
 	struct vc4_dev *vc4;
-	struct drm_modeset_acquire_ctx ctx;
 	struct drm_atomic_state *state;
 };
 
@@ -725,6 +724,7 @@ static void drm_vc4_test_pv_muxing_invalid(struct kunit *test)
 static int vc4_pv_muxing_test_init(struct kunit *test)
 {
 	const struct pv_muxing_param *params = test->param_value;
+	struct drm_modeset_acquire_ctx *ctx;
 	struct drm_atomic_state *state;
 	struct pv_muxing_priv *priv;
 	struct drm_device *drm;
@@ -738,13 +738,14 @@ static int vc4_pv_muxing_test_init(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 	priv->vc4 = vc4;
 
-	drm_modeset_acquire_init(&priv->ctx, 0);
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &priv->ctx;
+	state->acquire_ctx = ctx;
 
 	priv->state = state;
 
@@ -757,8 +758,6 @@ static void vc4_pv_muxing_test_exit(struct kunit *test)
 	struct drm_atomic_state *state = priv->state;
 
 	drm_atomic_state_put(state);
-	drm_modeset_drop_locks(&priv->ctx);
-	drm_modeset_acquire_fini(&priv->ctx);
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
@@ -798,7 +797,7 @@ static struct kunit_suite vc5_pv_muxing_test_suite = {
  */
 static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx ctx;
+	struct drm_modeset_acquire_ctx *ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct vc4_hvs_state *new_hvs_state;
@@ -811,13 +810,14 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	drm_modeset_acquire_init(&ctx, 0);
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -844,7 +844,7 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -866,13 +866,11 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	KUNIT_EXPECT_NE(test, hdmi0_channel, hdmi1_channel);
 
 	drm_atomic_state_put(state);
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
 }
 
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx ctx;
+	struct drm_modeset_acquire_ctx *ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct vc4_hvs_state *new_hvs_state;
@@ -885,13 +883,14 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	drm_modeset_acquire_init(&ctx, 0);
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -929,7 +928,7 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_del_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -954,14 +953,12 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	}
 
 	drm_atomic_state_put(state);
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
 }
 
 static void
 drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct kunit *test)
 {
-	struct drm_modeset_acquire_ctx ctx;
+	struct drm_modeset_acquire_ctx *ctx;
 	struct drm_atomic_state *state;
 	struct vc4_crtc_state *new_vc4_crtc_state;
 	struct drm_device *drm;
@@ -971,13 +968,14 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	vc4 = vc5_mock_device(test);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, vc4);
 
-	drm_modeset_acquire_init(&ctx, 0);
+	ctx = drm_kunit_helper_acquire_ctx_alloc(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
 	drm = &vc4->base;
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI0);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -993,7 +991,7 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	state = drm_atomic_state_alloc(drm);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
-	state->acquire_ctx = &ctx;
+	state->acquire_ctx = ctx;
 
 	ret = vc4_mock_atomic_add_output(test, state, VC4_ENCODER_TYPE_HDMI1);
 	KUNIT_ASSERT_EQ(test, ret, 0);
@@ -1006,8 +1004,6 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	KUNIT_EXPECT_NULL(test, new_vc4_crtc_state);
 
 	drm_atomic_state_put(state);
-	drm_modeset_drop_locks(&ctx);
-	drm_modeset_acquire_fini(&ctx);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {

-- 
2.41.0

