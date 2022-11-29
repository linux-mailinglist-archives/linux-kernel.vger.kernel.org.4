Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BB63C84E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbiK2TZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbiK2TZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:25:27 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FBE2E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1669749653; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJ8DQbIPu45uJFi2+s89p8C8So0glLs+3UhV12NFAG4=;
        b=1bld4QEX0BAnu3Z14gTXZpmFtmvXP8F67tDurl3HqD8RxcF4B8CIQ8VC5WPwwqd6Ktn/EK
        1KedmnMleBUB/U3DHVlgwJJIMabuy87w9VHSnZQvPy0xvKXHrNXFEHxq4WnlMT2wPzUTiZ
        a4WsVlCqWMxNe2ZKCZHvbzdWNBpO9Uc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v2 26/26] drm/i915/gt: Remove #ifdef guards for PM related functions
Date:   Tue, 29 Nov 2022 19:19:42 +0000
Message-Id: <20221129191942.138244-13-paul@crapouillou.net>
In-Reply-To: <20221129191942.138244-1-paul@crapouillou.net>
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191942.138244-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of defining two versions of intel_sysfs_rc6_init(), one for each
value of CONFIG_PM, add a check on !IS_ENABLED(CONFIG_PM) early in the
function. This will allow the compiler to automatically drop the dead
code when CONFIG_PM is disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
index cf71305ad586..09b9365ededd 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
@@ -164,7 +164,6 @@ sysfs_gt_attribute_r_func(struct kobject *kobj, struct attribute *attr,
 								 NULL);			\
 	INTEL_GT_ATTR_RO(_name)
 
-#ifdef CONFIG_PM
 static u32 get_residency(struct intel_gt *gt, enum intel_rc6_res_type id)
 {
 	intel_wakeref_t wakeref;
@@ -300,7 +299,7 @@ static void intel_sysfs_rc6_init(struct intel_gt *gt, struct kobject *kobj)
 {
 	int ret;
 
-	if (!HAS_RC6(gt->i915))
+	if (!IS_ENABLED(CONFIG_PM) || !HAS_RC6(gt->i915))
 		return;
 
 	ret = __intel_gt_sysfs_create_group(kobj, rc6_attr_group);
@@ -329,11 +328,6 @@ static void intel_sysfs_rc6_init(struct intel_gt *gt, struct kobject *kobj)
 				 gt->info.id, ERR_PTR(ret));
 	}
 }
-#else
-static void intel_sysfs_rc6_init(struct intel_gt *gt, struct kobject *kobj)
-{
-}
-#endif /* CONFIG_PM */
 
 static u32 __act_freq_mhz_show(struct intel_gt *gt)
 {
-- 
2.35.1

