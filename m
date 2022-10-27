Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F267160FA68
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiJ0O3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiJ0O3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:29:20 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF91805B7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:29:20 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Myp331xP6zDqpk;
        Thu, 27 Oct 2022 14:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666880959; bh=1d9N8tRMn2an5tIHcrDyPVTUDk1W0TFjFY2XfgUzMPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ozd1KgIvSOK/zNKoguDNyFI62E/EsymmYJdlotGbrUnmc2TucXIGNHG/3IyG22/nE
         J2b/Rn7RKmP29B0AAHEJe0v8IPVa9AM5x5weu8K0WurzXuwIEEr+d9A94m81AF1pcv
         SJ5qFWCFlZY/40SvaT2wtboYHloa3Ud4F2B0CMiI=
X-Riseup-User-ID: 58AC7B8BAF276B6DB86B393FFB0EB34ED88215BC0C4A76B5DD30AB2ECC029068
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Myp2y6F0gz5vRX;
        Thu, 27 Oct 2022 14:29:14 +0000 (UTC)
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
Subject: [PATCH v2] drm/tests: Add back seed value information
Date:   Thu, 27 Oct 2022 11:29:03 -0300
Message-Id: <20221027142903.200169-1-arthurgrillo@riseup.net>
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
printk with seed value after they where refactored into KUnit. This
patch add back this important information to assure reproducibility and
convert them to the KUnit API.

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

---
 drivers/gpu/drm/tests/drm_buddy_test.c | 4 ++++
 drivers/gpu/drm/tests/drm_mm_test.c    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 62f69589a72d..258137e9c047 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -731,6 +731,10 @@ static int drm_buddy_init_test(struct kunit *test)
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info(test,
+		   "Testing DRM buddy manager, with random_seed=0x%x\n",
+		   random_seed);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index c4b66eeae203..bec006e044a4 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -2214,6 +2214,10 @@ static int drm_mm_init_test(struct kunit *test)
 	while (!random_seed)
 		random_seed = get_random_u32();
 
+	kunit_info(test,
+		   "Testing DRM range manager, with random_seed=0x%x max_iterations=%u max_prime=%u\n",
+		   random_seed, max_iterations, max_prime);
+
 	return 0;
 }
 
-- 
2.37.3

