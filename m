Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D125E75CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbiIWI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiIWI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:28:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9912384B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663921668; x=1695457668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kkjxfQ7mUK/V9Lc34jug0CHMM+mOcD38YV9RoicTgI=;
  b=VVwCgRoSCc1z4x2S6ORZabGBhOxqSeP5HAyY71y+Fg9Py2RVSfhMfMi7
   1+99RyJ6sz37d0bOLjMg56P3Bb0rg+vM1CkmzniFe+ekjUCOBflbVNYyP
   yO9OtPAK1EFe+K41vW6hPXeCpMj6BFLfChKp7gL9QzzOcxmEG1K4LLTsz
   8iGc0Unb6iBb13YhfNECa9U9ZMKfCC+iGlkbMXEsw3qm8VrKKyP35vjrl
   tFfPydYomZzUbCx1JpcqjM7kGqrkc4LT++7alPzCGFxdgFYdQhIJtKKPP
   fPSILUah8rlV/x9CBc5Bhbuo87yWz18Xt1xK7EksY8SJ9dx6Yg/xCor5C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="386833597"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="386833597"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:27:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622444299"
Received: from ngoncia-mobl2.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.143.58])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:27:35 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v11 9/9] drm/i915: Remove truncation warning for large objects
Date:   Fri, 23 Sep 2022 11:26:28 +0300
Message-Id: <20220923082628.3061408-10-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220923082628.3061408-1-gwan-gyeong.mun@intel.com>
References: <20220923082628.3061408-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

Having addressed the issues surrounding incorrect types for local
variables and potential integer truncation in using the scatterlist API,
we have closed all the loop holes we had previously identified with
dangerously large object creation. As such, we can eliminate the warning
put in place to remind us to complete the review.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Brian Welty <brian.welty@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Testcase: igt@gem_create@create-massive
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/4991
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index b1f89b1cc0b2..9a77fa95e771 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -20,25 +20,10 @@
 
 enum intel_region_id;
 
-/*
- * XXX: There is a prevalence of the assumption that we fit the
- * object's page count inside a 32bit _signed_ variable. Let's document
- * this and catch if we ever need to fix it. In the meantime, if you do
- * spot such a local variable, please consider fixing!
- *
- * We can check for invalidly typed locals with typecheck(), see for example
- * i915_gem_object_get_sg().
- */
-#define GEM_CHECK_SIZE_OVERFLOW(sz) \
-	GEM_WARN_ON((sz) >> PAGE_SHIFT > INT_MAX)
-
 static inline bool i915_gem_object_size_2big(u64 size)
 {
 	struct drm_i915_gem_object *obj;
 
-	if (GEM_CHECK_SIZE_OVERFLOW(size))
-		return true;
-
 	if (overflows_type(size, obj->base.size))
 		return true;
 
-- 
2.37.1

