Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BE461FC65
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiKGR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiKGR6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:58:33 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88729341
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667843720; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5mAEA/+FkdzN3Ma2ZqP/XBBMcVgHH0HAXQLxvGbSpU0=;
        b=l3Lmt0YdceLN+zlv4/YzlXycceCpqax6TX+6l5d2OvDLFagqDeMLvmOEcLVvV1hoAdWqp+
        PxEq1lJ0Zqcq7bDf9QPOjtIpEaqINpOHnw/Np/t2lhf1GrVgSvYo3as1TsOjWbn6voYE8Y
        4f5F8WKGAKoJYmaGP5KsQWrr+1OJUw4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 26/26] drm/i915/gt: Remove #ifdef guards for PM related functions
Date:   Mon,  7 Nov 2022 17:55:10 +0000
Message-Id: <20221107175510.361051-3-paul@crapouillou.net>
In-Reply-To: <20221107175510.361051-1-paul@crapouillou.net>
References: <20221107175106.360578-1-paul@crapouillou.net>
 <20221107175510.361051-1-paul@crapouillou.net>
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
index 2b5f05b31187..decf892a4508 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c
@@ -164,7 +164,6 @@ sysfs_gt_attribute_r_func(struct kobject *kobj, struct attribute *attr,
 								 NULL);			\
 	INTEL_GT_ATTR_RO(_name)
 
-#ifdef CONFIG_PM
 static u32 get_residency(struct intel_gt *gt, i915_reg_t reg)
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

