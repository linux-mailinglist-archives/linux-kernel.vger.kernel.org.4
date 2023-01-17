Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C966E3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbjAQQio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjAQQiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:38:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C643937
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:37:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8FCEB81909
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6253C433D2;
        Tue, 17 Jan 2023 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673973469;
        bh=eW6//3cViUuJfCKFm7UUOh5i0BW9IwBnC51sdT2hYj4=;
        h=From:To:Cc:Subject:Date:From;
        b=uOEqgQbh+YGTEHnq3WnnzljRLzzHKWAdHf9R8kD9AgfcQvtZcVr8dSl7NgEzcffJR
         ppjbOgDJARB8Gd6orJYPTBgDVI+30vEM0QLtW/Eh1niGNoMF+JLUc0adNFLC9KeIC/
         NXbncMuURU5FhjdtfBkcn9t55Qmfw+mUu0ZFFBsRX9Tqjt7D4Du5MWG5bDnJ3M2DaQ
         PcNP2uFNO/YNsC87NoG1lMG4Au3JeBw0nL3oEpwklhOaE1rdiEhhLAl+QjBH84CHSb
         sIMC4Cw5gfC3D59JC+OGZ2zUwQyDLjbh0UyZxgX0+6MGG3hKADBz7EKd4H78lBEzwH
         foY8mSuQ/oToQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@Intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/selftest: fix intel_selftest_modify_policy argument types
Date:   Tue, 17 Jan 2023 17:37:29 +0100
Message-Id: <20230117163743.1003219-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The definition of intel_selftest_modify_policy() does not match the
declaration, as gcc-13 points out:

drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c:29:5: error: conflicting types for 'intel_selftest_modify_policy' due to enum/integer mismatch; have 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, u32)' {aka 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, unsigned int)'} [-Werror=enum-int-mismatch]
   29 | int intel_selftest_modify_policy(struct intel_engine_cs *engine,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c:11:
drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.h:28:5: note: previous declaration of 'intel_selftest_modify_policy' with type 'int(struct intel_engine_cs *, struct intel_selftest_saved_policy *, enum selftest_scheduler_modify)'
   28 | int intel_selftest_modify_policy(struct intel_engine_cs *engine,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Change the type in the definition to match.

Fixes: 617e87c05c72 ("drm/i915/selftest: Fix hangcheck self test for GuC submission")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index 310fb83c527e..2990dd4d4a0d 100644
--- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
+++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
@@ -28,8 +28,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
 
 int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 				 struct intel_selftest_saved_policy *saved,
-				 u32 modify_type)
-
+				 enum selftest_scheduler_modify modify_type)
 {
 	int err;
 
-- 
2.39.0

