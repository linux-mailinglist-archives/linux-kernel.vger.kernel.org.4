Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115906D0886
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjC3OmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjC3OmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:42:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBC3AB2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680187329; x=1711723329;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=xB0J3/kyzFO8fJCA2S6PrbdJQ5KMvNZfUN+7pIKfYdc=;
  b=MyS7GvWHgunx8Vs1Tq/pvWzwUE+NinF6YL6gWArFovHWAjQBYIOSKE60
   eBjSauk/tYjy04M9NqC4ArWmuMU3Z4C34zvh+Wf2EKgHDnLvf19BvIArb
   vKkjKjLXV/tsmXLtB4s9nrwOQ3rHSFoCUdvjL0NgxwV8poJHcMEApqZXh
   yeQQaJdDrelJ2Cu+a9bzBWz+iIwAkEjE0C/sPIRBlaTRB15GhoLZNWawd
   zYbAuU0FXDvonGSgqCyP9dF4BpZ9InsBg3yRTeBlQla21e6Tj4NIhGhxS
   oQTwrbdgF1UGfKFgQNFacARixQrFllqd1vYRqQsI8N6eGCNCofC6AJUZf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343667726"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="343667726"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 07:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="662039139"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="662039139"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 07:35:58 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Thu, 30 Mar 2023 16:35:39 +0200
Subject: [PATCH] drm/i915/gt: Hold a wakeref for the active VM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230330-hold_wakeref_for_active_vm-v1-1-baca712692f6@intel.com>
X-B4-Tracking: v=1; b=H4sIADueJWQC/x2NUQrDIBAFrxL2u4KJgdJepRTZ6FqXNhrWYAohd
 6/p5zC8eTsUEqYC924HocqFc2rQXzpwEdOLFPvGMOjBaGO0ivnj7YZvEgo2ZLHoVq5k66yuQfcG
 x/FGwUALTFhITYLJxTPhZVYrL6dZ2pi//9vH8zh+lfN+Y4YAAAA=
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

There may be a disconnect between the GT used by the engine and the GT
used for the VM, requiring us to hold a wakeref on both while the GPU is
active with this request.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
[ahajda: removed not-yet-upstremed wakeref tracking bits]
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_context.h   | 15 +++++++++++----
 drivers/gpu/drm/i915/gt/intel_engine_pm.c |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_context.h b/drivers/gpu/drm/i915/gt/intel_context.h
index 0a8d553da3f439..48f888c3da083b 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.h
+++ b/drivers/gpu/drm/i915/gt/intel_context.h
@@ -14,6 +14,7 @@
 #include "i915_drv.h"
 #include "intel_context_types.h"
 #include "intel_engine_types.h"
+#include "intel_gt_pm.h"
 #include "intel_ring_types.h"
 #include "intel_timeline_types.h"
 #include "i915_trace.h"
@@ -207,8 +208,11 @@ void intel_context_exit_engine(struct intel_context *ce);
 static inline void intel_context_enter(struct intel_context *ce)
 {
 	lockdep_assert_held(&ce->timeline->mutex);
-	if (!ce->active_count++)
-		ce->ops->enter(ce);
+	if (ce->active_count++)
+		return;
+
+	ce->ops->enter(ce);
+	intel_gt_pm_get(ce->vm->gt);
 }
 
 static inline void intel_context_mark_active(struct intel_context *ce)
@@ -222,8 +226,11 @@ static inline void intel_context_exit(struct intel_context *ce)
 {
 	lockdep_assert_held(&ce->timeline->mutex);
 	GEM_BUG_ON(!ce->active_count);
-	if (!--ce->active_count)
-		ce->ops->exit(ce);
+	if (--ce->active_count)
+		return;
+
+	intel_gt_pm_put_async(ce->vm->gt);
+	ce->ops->exit(ce);
 }
 
 static inline struct intel_context *intel_context_get(struct intel_context *ce)
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_pm.c b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
index e971b153fda976..ac0566c5e99e17 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_pm.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_pm.c
@@ -114,6 +114,9 @@ __queue_and_release_pm(struct i915_request *rq,
 
 	ENGINE_TRACE(engine, "parking\n");
 
+	GEM_BUG_ON(rq->context->active_count != 1);
+	__intel_gt_pm_get(engine->gt);
+
 	/*
 	 * We have to serialise all potential retirement paths with our
 	 * submission, as we don't want to underflow either the

---
base-commit: 3385d6482cd60f2a0bbb0fa97b70ae7dbba4f95c
change-id: 20230330-hold_wakeref_for_active_vm-7f013a449ef3

Best regards,
-- 
Andrzej Hajda <andrzej.hajda@intel.com>
