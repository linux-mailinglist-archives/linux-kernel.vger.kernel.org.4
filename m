Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2B5ED770
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiI1IQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiI1IOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5775495A7;
        Wed, 28 Sep 2022 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664352878; x=1695888878;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sje3TAP90mMjJ4940AZvP8k1syPAFp/h9HzOk/O8E9U=;
  b=QQi247+rtNGN+h1CUiI4NoA5kygwLvjGRHySTnaQF+AqlnTKOFAaa4ax
   yDjpkM/2jmoTZXBnFlM1dakswlQ14ERRfsP3N9jROGwVjKAis7xwGzCqY
   DWeo/7oMrI/wluUJmb/IHsvEzkVe7AWV6DXI8RGc1cFWzUJLtbhukyl8b
   UOfD6HOrao7TZp6jcJXayHWz+XYscmGSqxSbJa34DP90ZtYoRnMtr7R8P
   L6xdjigtymmRhjfMQNJNCZ+pdAAfTlzPhfYU9Fga7zChl8nKkZ4nsShik
   RsMPwnNNIcS7SSIb3AeAOMluK8DJ23vdgJ16055cuLiPJ54ztWpKbrBgs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281910375"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281910375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:14:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621836436"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="621836436"
Received: from maciejos-mobl.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.147.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:14:28 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v13 8/9] drm/i915: Use error code as -E2BIG when the size of gem ttm object is too large
Date:   Wed, 28 Sep 2022 11:12:59 +0300
Message-Id: <20220928081300.101516-9-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ttm_bo_init_reserved() functions returns -ENOSPC if the size is too big
to add vma. The direct function that returns -ENOSPC is drm_mm_insert_node_in_range().
To handle the same error as other code returning -E2BIG when the size is
too large, it converts return value to -E2BIG.

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index d33f06b95c48..a2557f1ecbce 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1243,6 +1243,17 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	ret = ttm_bo_init_reserved(&i915->bdev, i915_gem_to_ttm(obj), bo_type,
 				   &i915_sys_placement, page_size >> PAGE_SHIFT,
 				   &ctx, NULL, NULL, i915_ttm_bo_destroy);
+
+	/*
+	 * XXX: The ttm_bo_init_reserved() functions returns -ENOSPC if the size
+	 * is too big to add vma. The direct function that returns -ENOSPC is
+	 * drm_mm_insert_node_in_range(). To handle the same error as other code
+	 * that returns -E2BIG when the size is too large, it converts -ENOSPC to
+	 * -E2BIG.
+	 */
+	if (size >> PAGE_SHIFT > INT_MAX && ret == -ENOSPC)
+		ret = -E2BIG;
+
 	if (ret)
 		return i915_ttm_err_to_gem(ret);
 
-- 
2.37.1

