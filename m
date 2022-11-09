Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20552623335
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKITKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiKITK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:10:29 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22E272C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021028; x=1699557028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsqDFyDE3Xf+Eud5zTFYaL4RaK2z0k0BfhahtubW9bI=;
  b=lQXr/GQG25ERBKZ2yqqrNKLVWY/vkbNNENKNoMB5vdzBGJ9bPKNUXVlk
   pF3eCi8X7NT0TMr15gHgeOGDmOH1So4aSso2A4Fx8tcnrutfpJK4It5IS
   hCI2UNUAbMcQU4uHlXK2FHHGZf1Othrk9cY4oXo3pP7xkghbY+GCvKtDm
   5Uelki0ID7mYgab1aW40bssQlnwARXFmTV6Y3RWNoItSGIWIIBCe8+zJ/
   l3JtX04AUX1J13uSdujIVQ7V3UNN+SqcprVDdo6dZ8JN9EJvGGRQGlrR2
   NPm9nedTuf4ohMXGZvWJ/gZ0toxVzh0VIdplhEdc3l709XBkV0zGCBk7d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311072244"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="311072244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="668105815"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="668105815"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.6.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:22 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris.p.wilson@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/i915: Fix timeout handling when retiring requests
Date:   Wed,  9 Nov 2022 20:09:35 +0100
Message-Id: <20221109190937.64155-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
References: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that intel_gt_retire_requests_timeout() should return either
-ETIME if all time designated by timeout argument has been consumed while
waiting for fences being signaled, or remaining time if there are requests
still not retired, or 0 otherwise.  In the latter case, remaining time
should be passed back via remaining_timeout argument.

Remaining time is updated with return value of each consecutive call to
dma_fence_wait_timeout().  If an error code is returned instead of
remaining time, a few potentially unexpected side effects occur:
- we no longer wait for consecutive timelines' last request fences being
  signaled before we try to retire requests from those timelines -- while
  expected in case of -ETIME, that's probably not intended in case of
  other errors that dma_fence_wait_timeout() can return,
- the error code (a negative value) is passed back as remaining time and
  if no more requests happen to be left pending despite the error, a user
  may pass that value forward as a remaining timeout -- that can
  potentially trigger a WARN or BUG,
- potentially unexpected error code is returned to user when a
  non-critical error that probably shouldn't stop the user from retrying
  occurs while active requests are still pending.
Moreover, should dma_fence_wait_timeout() ever return 0 (which should mean
timeout expiration) while we are processing requests and there are still
pending requests when we are about to return, that 0 value is returned to
user like if all requests were successfully retired.

Ignore error codes from dma_fence_wait_timeout() other than -ETIME and
don't overwrite remaining time with those error codes.  Also, convert 0
value returned by dma_fence_wait_timeout() to -ETIME.

Fixes: f33a8a51602c ("drm/i915: Merge wait_for_timelines with retire_request")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: stable@vger.kernel.org # v5.5+
---
 drivers/gpu/drm/i915/gt/intel_gt_requests.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_requests.c b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
index edb881d756309..6c3b8ac3055c3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_requests.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_requests.c
@@ -156,11 +156,22 @@ long intel_gt_retire_requests_timeout(struct intel_gt *gt, long timeout,
 
 			fence = i915_active_fence_get(&tl->last_request);
 			if (fence) {
+				signed long time_left;
+
 				mutex_unlock(&tl->mutex);
 
-				timeout = dma_fence_wait_timeout(fence,
-								 true,
-								 timeout);
+				time_left = dma_fence_wait_timeout(fence,
+								   true,
+								   timeout);
+				/*
+				 * 0 or -ETIME: timeout expired
+				 * other errors: ignore, assume no time consumed
+				 */
+				if (time_left == -ETIME || time_left == 0)
+					timeout = -ETIME;
+				else if (time_left > 0)
+					timeout = time_left;
+
 				dma_fence_put(fence);
 
 				/* Retirement is best effort */
-- 
2.25.1

