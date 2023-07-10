Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34F74CEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjGJHsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjGJHsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F054413D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 861B560EC3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B71C433C7;
        Mon, 10 Jul 2023 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688975281;
        bh=P6AkzZmEIp/9uMOYra9+RhYe8NGkgtrmUDZAyGSGwBY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZS2qTM59an4tTDOc/lHUMdZ9YWW2KcLdikHB/RwLYbQIQxBy9AQttNMyXpYmiTRmE
         u3rLEY8OKJqGnuapdPgZIh5DyBJxyua8mSYSs+q/E2/OWAKDskriPj2RdXjU8I8vg0
         HWX8fdr0XAl2w8iDuEdWuZJbgOhUh1OKO+6aa4Nbx5xqeNh4xDnKHFjicEpg4V16jB
         PwKkz8GlYI3dfNx7J+eU1lCFkc3HMvk92le5597HdkbJST72dqbFePH5z1pGd/l46g
         AXfe8nVNIRjH2MLC3OgJwkTCc1RPddJ9cd3Y8LJFn2ofkX4HeZCsC48XcjIiVulKnQ
         QwfLGwKiSRBzA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Mon, 10 Jul 2023 09:47:38 +0200
Subject: [PATCH 07/11] drm/vc4: tests: pv-muxing: Remove call to
 drm_kunit_helper_free_device()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-kms-kunit-actions-rework-v1-7-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=mripard@kernel.org;
 h=from:subject:message-id; bh=P6AkzZmEIp/9uMOYra9+RhYe8NGkgtrmUDZAyGSGwBY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCmrt89o+CqzKlOs84+vi93Tq8Zbmjd8ql4+9dVal+01jn1H
 F3Ef6ShlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEFnxn+GdvJlsnJ/36KTObdzeblH
 jMBOOa8LgHE15u/e+/NyfvlzHDf/9vemerQ1fvuH710F274O3NHnceR1/87xT98Ge51DPHdnYA
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

Calling drm_kunit_helper_free_device() to clean up the resources
allocated by drm_kunit_helper_alloc_device() is now optional and not
needed in most cases.

Remove it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
index ae0bd0f81698..6c982e72cae8 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_test_pv_muxing.c
@@ -762,7 +762,6 @@ static void vc4_pv_muxing_test_exit(struct kunit *test)
 	drm_modeset_drop_locks(&priv->ctx);
 	drm_modeset_acquire_fini(&priv->ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static struct kunit_case vc4_pv_muxing_tests[] = {
@@ -873,7 +872,6 @@ static void drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable(struct kunit *tes
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
@@ -963,7 +961,6 @@ static void drm_test_vc5_pv_muxing_bugs_stable_fifo(struct kunit *test)
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static void
@@ -1017,7 +1014,6 @@ drm_test_vc5_pv_muxing_bugs_subsequent_crtc_enable_too_many_crtc_state(struct ku
 	drm_modeset_drop_locks(&ctx);
 	drm_modeset_acquire_fini(&ctx);
 	drm_dev_unregister(drm);
-	drm_kunit_helper_free_device(test, vc4->dev);
 }
 
 static struct kunit_case vc5_pv_muxing_bugs_tests[] = {

-- 
2.41.0

