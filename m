Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C285623339
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKITK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiKITK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:10:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4736A22B0F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668021055; x=1699557055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6LAVoH57Z67SFgpBICBCC2rV+kEpQgeJZ63fSc0PrTQ=;
  b=JRI19WQrFJqMSWfbmc1zS75DfsR8UcWaUM4uhbvQMy7YTy4xXgS3hGag
   wJBCTTOKjD1GYPHsJP88xXA4uWD0tVN3f17NPrDJjmpvaguETY+lD9g8B
   CMOoJMDLt2IAUsycjlFdCcgy9WkxamQjxXCP6Fh3oZQaMIaTlH28ZDeM8
   4btzWkgtHGtKX12sInVdvMCTFzRDTcsdKEmlrX/NLroaesLFZrhKEEBeP
   IW7IAUhl/0goHo/CkAyan/TZToLt8IZxzQgq8efEB40tmfwocpzVXAcMi
   dsKf3etMSVfRBG9ilMtUNmVfK9ZHaI3eT64Z2QOo0Ygo6fLAFwVX64PJ6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="312234715"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="312234715"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="668105979"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="668105979"
Received: from jkrzyszt-mobl1.ger.corp.intel.com ([10.213.6.201])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 11:10:30 -0800
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris.p.wilson@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/i915: Fix 0 return value from DMA fence wait on i915 requests
Date:   Wed,  9 Nov 2022 20:09:37 +0100
Message-Id: <20221109190937.64155-4-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
References: <20221109190937.64155-1-janusz.krzysztofik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the docs, dma_fence_wait_timeout() returns "0 if the wait
timed out," ... "Other error values may be returned on custom
implementations."  While it is not quite clear if a custom implementation
is allowed to return "other error" instead of 0, it is rather clear that 0
return value should always mean that the wait timed out before the fence
got signaled.

i915 implementation of dma_fence_ops.wait() used with request fences,
which is a transparent wrapper around i915_request_wait_timeout(), returns
-ETIME if the wait has timed out -- that may be considered as acceptable.
However, it can return 0 in a rare case when the fence has been found
signaled right after no more wait time was left, and that's not compatible
with expectations of dma-fence and its users.

Since other users of i915_request_wait_timeout() may interpret 0 return
value as success, don't touch it, update the i915_fence_wait() wrapper
instead.  Return 1 instead of 0, but keep -ETIME in case of timeout since
some i915 users of dma_fence_wait_timeout() may expect it.

Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index f949a9495758a..451456ab1ddef 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -102,7 +102,7 @@ static signed long i915_fence_wait(struct dma_fence *fence,
 {
 	return i915_request_wait_timeout(to_request(fence),
 					 interruptible | I915_WAIT_PRIORITY,
-					 timeout);
+					 timeout) ?: 1;
 }
 
 struct kmem_cache *i915_request_slab_cache(void)
-- 
2.25.1

