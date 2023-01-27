Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7548967EF46
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjA0UHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjA0UHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:07:05 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F257280
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:05:50 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j5so5591623pjn.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 12:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lmNlTw6/hGVpApNMZq1gzzgAdrxXUdhCjEWwQxehEq8=;
        b=Q+nhlvBpWrP0fqHx3sgjPqQLGxq0tosbU3mQwlm/TZsauYDDCx8XNZyf53kYrQ3zMx
         BWPHLU1vWzPvaaXK5AJ3yTa14ZwMQmKlInPT8Ol8hXyVhNZrnZ7hNU2OkyH3gr915LxC
         SSVDPg0f+VBlpjs8ywlpRNXKXa4W3rDBx/KYQf01Fg/Q4r6FHOcuQd1oKYRYjBvroK9z
         bDAhQb+n6zbPGdWTiXTkS5qQ9tORBmn7dfmnBqkA5B46S31udvwKbbHQ2n16O52effaJ
         IBLjsScvH4CC6r/8FACqAESUM+EW27qmsYqbqE7HUscYT3r2JTjGx/XRbIuVxPNJAA/V
         R0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lmNlTw6/hGVpApNMZq1gzzgAdrxXUdhCjEWwQxehEq8=;
        b=4JuiqiEtZ4AAz+Ps/e6utehYk7XjZUGrTar0GUhlIHbWfVgo9TRAsu4NyslSvi/4AF
         oYJdN6NwKMhtbxz0KX4uLViE1ZkixptUYZNmekhmBr/FucLNW0BE0biZKM6DamYa6EId
         d16HNlWuaQp+jMOmxV0nJWOHC1ICwKG5sYn1FTXLjtZZWuNi+A+hSzzad18p3WLZ/MpW
         C091ecvEvY+iV648koGptdY+uzeSMb6/bv2jZFW7zcUidl/2/N6+PRYzUWL7Qockctph
         8JrLGMdZJCx6fwLZgryU/AoMcu3MxMZTT7eZVkYzquFnxqExgun+cbMcq+pvTEg814dX
         O7Yg==
X-Gm-Message-State: AFqh2kpTIoi+Va3x2Nbvww+MCztOOn9avdJbOweGDP+D/QBItQsmte1W
        0CW2QpxTlVWI2KlWOPlgy/4=
X-Google-Smtp-Source: AMrXdXuhrtE5oPMK7SmyRQ5hCrj8OtvVjREYjt+cwrgbWas3tcp5lOPInofTWTWUh/nkRXnRVQPqGA==
X-Received: by 2002:a17:902:a40f:b0:194:5ff8:a3b0 with SMTP id p15-20020a170902a40f00b001945ff8a3b0mr37288703plq.7.1674849950312;
        Fri, 27 Jan 2023 12:05:50 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902d64200b001961608d74bsm3223200plh.299.2023.01.27.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 12:05:49 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        pengfuyuan <pengfuyuan@kylinos.cn>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/i915: Fix potential bit_17 double-free
Date:   Fri, 27 Jan 2023 12:05:31 -0800
Message-Id: <20230127200550.3531984-1-robdclark@gmail.com>
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

A userspace with multiple threads racing I915_GEM_SET_TILING to set the
tiling to I915_TILING_NONE could trigger a double free of the bit_17
bitmask.  (Or conversely leak memory on the transition to tiled.)  Move
allocation/free'ing of the bitmask within the section protected by the
obj lock.

Fixes: e9b73c67390a ("drm/i915: Reduce memory pressure during shrinker by preallocating swizzle pages")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
index fd42b89b7162..bc21b1c2350a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_tiling.c
@@ -298,36 +298,37 @@ i915_gem_object_set_tiling(struct drm_i915_gem_object *obj,
 		vma->fence_alignment =
 			i915_gem_fence_alignment(i915,
 						 vma->size, tiling, stride);
 
 		if (vma->fence)
 			vma->fence->dirty = true;
 	}
 	spin_unlock(&obj->vma.lock);
 
 	obj->tiling_and_stride = tiling | stride;
-	i915_gem_object_unlock(obj);
-
-	/* Force the fence to be reacquired for GTT access */
-	i915_gem_object_release_mmap_gtt(obj);
 
 	/* Try to preallocate memory required to save swizzling on put-pages */
 	if (i915_gem_object_needs_bit17_swizzle(obj)) {
 		if (!obj->bit_17) {
 			obj->bit_17 = bitmap_zalloc(obj->base.size >> PAGE_SHIFT,
 						    GFP_KERNEL);
 		}
 	} else {
 		bitmap_free(obj->bit_17);
 		obj->bit_17 = NULL;
 	}
 
+	i915_gem_object_unlock(obj);
+
+	/* Force the fence to be reacquired for GTT access */
+	i915_gem_object_release_mmap_gtt(obj);
+
 	return 0;
 }
 
 /**
  * i915_gem_set_tiling_ioctl - IOCTL handler to set tiling mode
  * @dev: DRM device
  * @data: data pointer for the ioctl
  * @file: DRM file for the ioctl call
  *
  * Sets the tiling mode of an object, returning the required swizzling of
-- 
2.38.1

