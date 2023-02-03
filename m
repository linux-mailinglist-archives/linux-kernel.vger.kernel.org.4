Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E58E689FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjBCQuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbjBCQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:49:58 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78692A87AA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 08:49:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m2so5824084plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxBhOPG/5pySGuFA3AXJKh8shAfrqvPwNp+MdcGvCaQ=;
        b=WZNFhp4rpQwO+9vVqFuSjSxPZ6uwAcZhY2spaSy/Glnr7tddG/Ds+pZJk/u61rUpMA
         Dog6+GShxg6wkdMbc+WelJFE781uy3LkeFqQ8Zxo6dIjLkQqleZlPr+TEX+ALQjU3Yxj
         qQaghVLr/pqr3NUr7xsFS218IYrRTHMOhGJWw1nJCRIt2isP59J1nQ1tEZJUd5C9Gq4W
         4PvSQQlRIlGjglslZB9fgKH+NMgyS5Ks8L/CxLB40FKuPywbejNWSLotvnwjBoyVa9bS
         Ck/lCeKljt6xHT8goZoa7gIavcAvTN7Fl/XAlP9ue3myro7v4nZyaxokr/ZVaoV9msze
         35ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxBhOPG/5pySGuFA3AXJKh8shAfrqvPwNp+MdcGvCaQ=;
        b=fhc2Mbqx8l4tTa4tHnjOjjnci/afAsgh87cr3FQ5/rkBHx+vfuG4R7rxdJJdgll+Ef
         AH/vz1tHAmH37KMx+8NA1iB+y1+SvnHkZinEXute03IiTINpdTXPV3riYuLbcTeNicGU
         tcQ+JzsDI+vA6xnMFa9TgOooX7O7DP5p3ZZIr1XJ2KY3ihxOud7s1Tcqr1LouACCAKBH
         pPcQgX5L08/BIDQi6fIzn7zpgc1yFjVMJnC6IQvpVZOcS4G/B2w1cfHgATLvFhcs1cEs
         ladR3OZ2NDB5Nta/cT2oBDnIjKxRPim6OWrZAqO7vtq3yQlWbRLRqDw0RgwcCXiiaGo0
         BhUg==
X-Gm-Message-State: AO0yUKVXFxeIEZjmTuoCf8gQAGSri9w8EH3HRKLxGfNZ/C7ToYxmSeeu
        4Rl5y2nVoJLGAV7D2vVK2a4=
X-Google-Smtp-Source: AK7set8DxXpK2VangZwWy6FpeOmhKOqZmgxtdo0d55o8p4znij0GVVRZYJ41RQvd3X+/rIxf2jRUvg==
X-Received: by 2002:a17:902:da8c:b0:194:6f3b:3aa1 with SMTP id j12-20020a170902da8c00b001946f3b3aa1mr6590659plx.55.1675442975476;
        Fri, 03 Feb 2023 08:49:35 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902a38d00b0019602263feesm1822084pla.90.2023.02.03.08.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:49:34 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915: Move fd_install after last use of fence
Date:   Fri,  3 Feb 2023 08:49:20 -0800
Message-Id: <20230203164937.4035503-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Because eb_composite_fence_create() drops the fence_array reference
after creation of the sync_file, only the sync_file holds a ref to the
fence.  But fd_install() makes that reference visable to userspace, so
it must be the last thing we do with the fence.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index f266b68cf012..0f2e056c02dd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -3476,38 +3476,38 @@ i915_gem_do_execbuffer(struct drm_device *dev,
 
 err_request:
 	eb_requests_get(&eb);
 	err = eb_requests_add(&eb, err);
 
 	if (eb.fences)
 		signal_fence_array(&eb, eb.composite_fence ?
 				   eb.composite_fence :
 				   &eb.requests[0]->fence);
 
+	if (unlikely(eb.gem_context->syncobj)) {
+		drm_syncobj_replace_fence(eb.gem_context->syncobj,
+					  eb.composite_fence ?
+					  eb.composite_fence :
+					  &eb.requests[0]->fence);
+	}
+
 	if (out_fence) {
 		if (err == 0) {
 			fd_install(out_fence_fd, out_fence->file);
 			args->rsvd2 &= GENMASK_ULL(31, 0); /* keep in-fence */
 			args->rsvd2 |= (u64)out_fence_fd << 32;
 			out_fence_fd = -1;
 		} else {
 			fput(out_fence->file);
 		}
 	}
 
-	if (unlikely(eb.gem_context->syncobj)) {
-		drm_syncobj_replace_fence(eb.gem_context->syncobj,
-					  eb.composite_fence ?
-					  eb.composite_fence :
-					  &eb.requests[0]->fence);
-	}
-
 	if (!out_fence && eb.composite_fence)
 		dma_fence_put(eb.composite_fence);
 
 	eb_requests_put(&eb);
 
 err_vma:
 	eb_release_vmas(&eb, true);
 	WARN_ON(err == -EDEADLK);
 	i915_gem_ww_ctx_fini(&eb.ww);
 
-- 
2.38.1

