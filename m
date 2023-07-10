Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F235674CEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjGJHsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjGJHsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FFCE1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BDA160EB6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91087C433C9;
        Mon, 10 Jul 2023 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975275;
        bh=92Z66pevW+elalzHRPcF5q2TXp4Zof6H0dCZ1lsPh08=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=i4P+qdzQM8FjAv5I66MjcyeKFkZA8kjn/csJpN3q4yC1nyX/nQ8sSnIyBOe995Bs7
         KLcKxMOH6mpoy6XfBuoZUtjgPV9dM/A2T2fAw4QfIQ580FttabPI4Z6wttGkgDzRLU
         ebwdtcyC1XCj51MNv0+9HMPkXro17s6FMYl63/GapMntc9e/a77l9o81d7G3+W+G7l
         kqEAIkRKcRE05ZcT4+mAPjYzF7z8BoE/bX296bx+ull620ecL0Usr3M2tpmQSgfIyG
         wdbAPjhBeOg2dNSOhEkszPTMFTRHiEcL0VXcJocqXMtcUk8iCrHp83D7btSTXJgCl3
         jq7rcNGBz+TGg==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 10 Jul 2023 09:47:36 +0200
Subject: [PATCH 05/11] drm/tests: helpers: Create an helper to allocate a
 locking ctx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2592; i=mripard@kernel.org;
 h=from:subject:message-id; bh=92Z66pevW+elalzHRPcF5q2TXp4Zof6H0dCZ1lsPh08=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmrt894fF9O9eqDwqQD4n3qmzXunui2vKk//+CEVv+FPmLF
 53M2dJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi++UZGRojfM6uzt4wI6FEZdoRae
 EZlryr3ZuX6gROrd9d+eUSmzLDP9OT/Pk7LjR0XbBR8ngxNyXh9d2YQzbvk3/4fxGfcJ/hECsA
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

As we get more and more tests, the locking context initialisation
creates more and more boilerplate, both at creation and destruction.

Let's create a helper that will allocate, initialise a context, and
register kunit actions to clean up once the test is done.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 41 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index 38211fea9ae6..40a27c78d692 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -124,5 +124,46 @@ __drm_kunit_helper_alloc_drm_device_with_driver(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(__drm_kunit_helper_alloc_drm_device_with_driver);
 
+static void action_drm_release_context(void *ptr)
+{
+	struct drm_modeset_acquire_ctx *ctx = ptr;
+
+	drm_modeset_drop_locks(ctx);
+	drm_modeset_acquire_fini(ctx);
+}
+
+/**
+ * drm_kunit_helper_context_alloc - Allocates an acquire context
+ * @test: The test context object
+ *
+ * Allocates and initializes a modeset acquire context.
+ *
+ * The context is tied to the kunit test context, so we must not call
+ * drm_modeset_acquire_fini() on it, it will be done so automatically.
+ *
+ * Returns:
+ * An ERR_PTR on error, a pointer to the newly allocated context otherwise
+ */
+struct drm_modeset_acquire_ctx *
+drm_kunit_helper_acquire_ctx_alloc(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx *ctx;
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	drm_modeset_acquire_init(ctx, 0);
+
+	ret = kunit_add_action_or_reset(test,
+					action_drm_release_context,
+					ctx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ctx;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_acquire_ctx_alloc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index ed013fdcc1ff..4ba5e10653c6 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -87,5 +87,7 @@ __drm_kunit_helper_alloc_drm_device(struct kunit *test,
 						      sizeof(_type),		\
 						      offsetof(_type, _member),	\
 						      _feat))
+struct drm_modeset_acquire_ctx *
+drm_kunit_helper_acquire_ctx_alloc(struct kunit *test);
 
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.41.0

