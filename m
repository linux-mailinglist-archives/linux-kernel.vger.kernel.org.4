Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8D73DB24
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFZJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjFZJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:19:10 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60592D4A;
        Mon, 26 Jun 2023 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687770993; x=1719306993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8NHvqn83ZvFUkevP/WNZb8GNDLDy33tL9NNl4xX0eyI=;
  b=aLwyWWsX615uznWBrBPf7iuNTGpGDJFApLlhktL8YxXs6c+YwpBaLtnh
   yqQObHa7R6/FYVSYLI5KqgcYYFUkGrTwWVgR/5Micc37PphTt6lgbOgVv
   JZNSNnbrngYlw6tss+HhbbjCyioMlC7aXVVnky/akpEqkRm++AAIr8HMW
   2ovVf0MooA641iw6725vfbQ1hzgGRBRb3xlLdoereYzk4He6erzOg0VPJ
   QzoSPZGs1rHNGdLZrSckq+Dp+qFD3uu2daxJDa5J602CluME+eqpiJ0v7
   +E1dAPuEDg69AQyR73s7BjxRUutqEM9LfTgrGOYtklfwXpAbwjKXvQSzn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="345974096"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="345974096"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="781357775"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="781357775"
Received: from ettammin-mobl1.ger.corp.intel.com (HELO thellstr-mobl1.intel.com) ([10.249.254.105])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2023 02:15:05 -0700
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     intel-xe@lists.freedesktop.org
Cc:     =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Roger He <Hongbo.He@amd.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        Matthew Brost <matthew.brost@intel.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "Andi Shyti" <andi.shyti@linux.intel.com>
Subject: [PATCH v2 2/4] drm/ttm: Don't shadow the operation context
Date:   Mon, 26 Jun 2023 11:14:48 +0200
Message-Id: <20230626091450.14757-3-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
References: <20230626091450.14757-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttm_bo_swapout() shadows the ttm operation context which may cause
major confusion in driver callbacks when swapping out !TTM_PL_SYSTEM
memory. Fix this by reusing the operation context argument to
ttm_bo_swapout().

Cc: "Christian König" <christian.koenig@amd.com>
Cc: Roger He <Hongbo.He@amd.com>
Cc: <dri-devel@lists.freedesktop.org>
Cc: <intel-gfx@lists.freedesktop.org>
Cc: <stable@vger.kernel.org> # v4.16+
Fixes: dc947770cf34 ("drm/ttm: enable swapout for reserved BOs during allocation")
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bd5dae4d1624..615d30c4262d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1154,7 +1154,6 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
 	 * Move to system cached
 	 */
 	if (bo->resource->mem_type != TTM_PL_SYSTEM) {
-		struct ttm_operation_ctx ctx = { false, false };
 		struct ttm_resource *evict_mem;
 		struct ttm_place hop;
 
@@ -1164,7 +1163,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
 		if (unlikely(ret))
 			goto out;
 
-		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, &ctx, &hop);
+		ret = ttm_bo_handle_move_mem(bo, evict_mem, true, ctx, &hop);
 		if (unlikely(ret != 0)) {
 			WARN(ret == -EMULTIHOP, "Unexpected multihop in swaput - likely driver bug.\n");
 			goto out;
-- 
2.40.1

