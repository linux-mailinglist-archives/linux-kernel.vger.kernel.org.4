Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD660EAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiJZVPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiJZVPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:15:11 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D02682859
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 14:15:10 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MyM5p2hhWzDqXT;
        Wed, 26 Oct 2022 21:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666818910; bh=APYOM4y7kgiXVNJBM6mveeMKzmAiEbIw4YkLWM5pJZo=;
        h=From:To:Cc:Subject:Date:From;
        b=Ra9lX8oCSmzSTdW7tjYozHU8DsdSPwtjywDlyTrJQd3Lm77LyEcmbd78BmJwo1lCD
         OEyLozx7JbGxsnWlxng8o1D6aB5HAf/6LuMpr+syZcjdrfrkRtGcACqbT/laEpT8cT
         c6qi8l6KbiJL7Jb/ozxtq+pSAF5NJ5k9MALtHdcQ=
X-Riseup-User-ID: B8985AC8A5ACF8A065AFF6B3A5F7E11411B5160F54633E5E622691687DA7D7C4
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MyM5k2VGXz5vS7;
        Wed, 26 Oct 2022 21:15:06 +0000 (UTC)
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
Subject: [PATCH] drm/tests: Add back seed value information
Date:   Wed, 26 Oct 2022 18:14:58 -0300
Message-Id: <20221026211458.68432-1-arthurgrillo@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Michał the drm_mm and drm_buddy unit tests lost the
printk with seed value after they being refactored into kunit. This
patch adds back this important information to assure reproducibility
converting them to use the kunit api.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Reported-by: Michał Winiarski <michal.winiarski@intel.com>
---
 drivers/gpu/drm/tests/drm_buddy_test.c | 3 +++
 drivers/gpu/drm/tests/drm_mm_test.c    | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 62f69589a72d..83c8863bc643 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -731,6 +731,9 @@ static int drm_buddy_init_test(struct kunit *test)
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info("Testing DRM buddy manager (struct drm_buddy), with random_seed=0x%x\n",
+		random_seed);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index c4b66eeae203..492347069d58 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -2214,6 +2214,9 @@ static int drm_mm_init_test(struct kunit *test)
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info("Testing DRM range manager (struct drm_mm), with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+	random_seed, max_iterations, max_prime);
+
 	return 0;
 }
 
@@ -2251,6 +2254,5 @@ static struct kunit_suite drm_mm_test_suite = {
 };
 
 kunit_test_suite(drm_mm_test_suite);
-
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL");
-- 
2.37.3

