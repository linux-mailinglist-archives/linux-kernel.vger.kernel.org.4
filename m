Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5D611D57
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiJ1WSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJ1WSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:18:07 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB95224C967
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 15:18:06 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MzcPV0cgMzDqFC;
        Fri, 28 Oct 2022 22:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666995486; bh=o+QznyhV3hIjjr8HLNlww/g7V5QGQpu6+kYN6wHY96s=;
        h=From:To:Cc:Subject:Date:From;
        b=mcMgNT5eZO9EjynIMSq4ViVA44gocxY8FJQDv1k6zofCNXOqWwXN7puzTam+FAfv8
         NUEEGkWt7TiMRBPZTgPotOD8jW/1D6sA7bpdSmIBazi4+cFA0u7Sn/uq6K4lcTXjDo
         hnG0eGof4NbG1ugrsqjGth9gKep6D/wufIZoK3Kk=
X-Riseup-User-ID: 84B3480913F1F914D1A1C52E14951CFE0F8957CA37B981EE12A82DD8D2519D67
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MzcPQ0pflz1yZp;
        Fri, 28 Oct 2022 22:18:01 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>, andrealmeid@riseup.net,
        melissa.srw@gmail.com, Arthur Grillo <arthurgrillo@riseup.net>,
        =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>
Subject: [PATCH v5] drm/tests: Add back seed value information
Date:   Fri, 28 Oct 2022 19:17:54 -0300
Message-Id: <20221028221755.340487-1-arthurgrillo@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Michał the drm_mm and drm_buddy unit tests lost the
printk with seed value after they were refactored into KUnit.

Add kunit_info with seed value information to assure reproducibility.

Reported-by: Michał Winiarski <michal.winiarski@intel.com>
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
v1->v2: https://lore.kernel.org/all/20221026211458.68432-1-arthurgrillo@riseup.net/
- Correct compilation issues
- Change tags order
- Remove useless line change
- Write commit message in imperative form
- Remove redundant message part
- Correct some grammars nits
- Correct checkpatch issues

v2->v3: https://lore.kernel.org/all/20221027142903.200169-1-arthurgrillo@riseup.net/
- Change .init to .suite_init
- Correct some grammars nits

v3->v4: https://lore.kernel.org/all/20221028141246.280079-1-arthurgrillo@riseup.net/
- Correct compilation issues

v4->v5: https://lore.kernel.org/all/20221028141715.290903-1-arthurgrillo@riseup.net/
- Change functions names from init_suite to suite_init
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 6 ++++--
 drivers/gpu/drm/tests/drm_mm_test.c    | 8 ++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 62f69589a72d..f8ee714df396 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -726,11 +726,13 @@ static void drm_test_buddy_alloc_limit(struct kunit *test)
 	drm_buddy_fini(&mm);
 }
 
-static int drm_buddy_init_test(struct kunit *test)
+static int drm_buddy_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info(suite, "Testing DRM buddy manager, with random_seed=0x%x\n", random_seed);
+
 	return 0;
 }
 
@@ -746,7 +748,7 @@ static struct kunit_case drm_buddy_tests[] = {
 
 static struct kunit_suite drm_buddy_test_suite = {
 	.name = "drm_buddy",
-	.init = drm_buddy_init_test,
+	.suite_init = drm_buddy_suite_init,
 	.test_cases = drm_buddy_tests,
 };
 
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index c4b66eeae203..89f12d3b4a21 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -2209,11 +2209,15 @@ static void drm_test_mm_color_evict_range(struct kunit *test)
 	vfree(nodes);
 }
 
-static int drm_mm_init_test(struct kunit *test)
+static int drm_mm_suite_init(struct kunit_suite *suite)
 {
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info(suite,
+		   "Testing DRM range manager, with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+		   random_seed, max_iterations, max_prime);
+
 	return 0;
 }
 
@@ -2246,7 +2250,7 @@ static struct kunit_case drm_mm_tests[] = {
 
 static struct kunit_suite drm_mm_test_suite = {
 	.name = "drm_mm",
-	.init = drm_mm_init_test,
+	.suite_init = drm_mm_suite_init,
 	.test_cases = drm_mm_tests,
 };
 
-- 
2.37.3

