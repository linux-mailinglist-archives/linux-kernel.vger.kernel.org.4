Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DD274CF03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjGJHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjGJHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044EE115
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B57A60EC0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EA5C433CC;
        Mon, 10 Jul 2023 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975279;
        bh=yyOzLwcA8+MLX2ZufFLGFyhRNFINdgUwJ7WOz6NATOo=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Ev0++KRl7X5fDJRzgC0KAVucSZOr90RLppLhwpgBemBAj0uuGAmS64AiBnjD0BY2B
         2FwR4AWNDTstXQvI+Dgid9oYaA15ir6wStflexPmIN5QFu+qkajBJTAPazNv6i1Lxz
         b6xsXQycMFMEUUU4nMaLMhALmIvUG4gUWWk/lSB1LHA64LzwBSIl5Uf+4j/JGwgixv
         hUkPONa3CBweO0S5I/cLcDvGtWYDX/Mb8G9+5b0viXN2z30dpaY0ChdZASLqGbU6hB
         9ELLjgCoIgzmNcPhc4YJ8vs95K3nQDP8bwyuKEkI7svKD9xdgaWNrGQ3eNoOBws2Yr
         0CeRp8RNOhE2w==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 10 Jul 2023 09:47:37 +0200
Subject: [PATCH 06/11] drm/tests: helpers: Create an helper to allocate an
 atomic state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-kms-kunit-actions-rework-v1-6-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yyOzLwcA8+MLX2ZufFLGFyhRNFINdgUwJ7WOz6NATOo=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmrt8842N69JPSDNsPi6Zu3qvItcm0TqDt+kOVibJP3lbLd
 HX3rOkpZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjCR6DaGvxKPdc1f2L4P9kvNubCEn3
 PG/TUvDI9tWSTr3HXj9+Xb1VMYGXb8zG2IPMnMGsP0aM6lSU+vNJzrS+6dPqWh8q3f8b7E3TwA
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

As we gain more tests, boilerplate to allocate an atomic state and free
it starts to be there more and more as well.

In order to reduce the allocation boilerplate, we can create an helper
to create that atomic state, and call an action when the test is done.
This will also clean up the exit path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 39 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  5 ++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 40a27c78d692..3f3331bc389f 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_managed.h>
@@ -165,5 +166,43 @@ drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
 
+/**
+ * drm_kunit_helper_atomic_state_alloc - Allocates an atomic state
+ * @test: The test context object
+ * @drm: The device to alloc the state for
+ * @ctx: Locking context for that atomic update
+ *
+ * Allocates a empty atomic state.
+ *
+ * The state is tied to the kunit test context, so we must not call
+ * drm_atomic_state_put() on it, it will be done so automatically.
+ *
+ * Returns:
+ * An ERR_PTR on error, a pointer to the newly allocated state otherwise
+ */
+struct drm_atomic_state *
+drm_kunit_helper_atomic_state_alloc(struct kunit *test,
+				    struct drm_device *drm,
+				    struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_atomic_state *state;
+	int ret;
+
+	state = drm_atomic_state_alloc(drm);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+
+	ret = kunit_add_action_or_reset(test,
+					(kunit_action_t *)drm_atomic_state_put,
+					state);
+	if (ret)
+		return ERR_PTR(ret);
+
+	state->acquire_ctx = ctx;
+
+	return state;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_atomic_state_alloc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index 4ba5e10653c6..514c8a7a32f0 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -90,4 +90,9 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 struct drm_modeset_acquire_ctx *
 drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
 
+struct drm_atomic_state *
+drm_kunit_helper_atomic_state_alloc(struct kunit *test,
+				    struct drm_device *drm,
+				    struct drm_modeset_acquire_ctx *ctx);
+
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.41.0

