Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677246EF795
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbjDZPPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbjDZPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:14:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90898100
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682522090; x=1714058090;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=a3rq7E5TI8RGgUZf3JtgYbiTIUGic08SWRrQO5vrU5I=;
  b=avLRtPcjoX7KlbPB+Y+0yAe72IsUuU9MxoyTHeT89IaZpBzsXF/Est8u
   pmvNJVFyo05IN187TPqbdpHJ5ZeXAXiL9R4MOlAm/5lX1GkCNVDc0ssNQ
   HwP1pFua5m4ipDdOsmE+64A7BuD3Uylt/0YjI3OmNVc27jf3cAYvGgAtH
   DgbA3X0N2mEYkBz7xY6VktjYaoxKTIUGrvPngt1wGWMP3HKIzhJ2/rxrt
   XIB6eghvwUBKopzpSA4jjdN+nge/cnmbMqRkLmVHpXG7OmrYeoW+A+IiG
   oSCSJqWm7GXk1k9n0fPQB4m2VJT7uxReJ9YVVs7T9yMmZXypZUJXQ+1ij
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="412444681"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="412444681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:14:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="671366449"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="671366449"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:14:32 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 26 Apr 2023 17:14:11 +0200
Subject: [PATCH v7 2/2] drm/i915: Use correct huge page manager for MTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230425-hugepage-migrate-v7-2-fa6605a986c9@intel.com>
References: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
In-Reply-To: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

MTL currently uses gen8_ppgtt_insert_huge when managing huge pages.  This is because
MTL reports as not supporting 64K pages, or more accurately, the system that reports
whether a platform has 64K pages reports false for MTL.  This is only half correct,
as the 64K page support reporting system only cares about 64K page support for LMEM,
which MTL doesn't have.

MTL should be using xehpsdv_ppgtt_insert_huge.  However, simply changing over to
using that manager doesn't resolve the issue because MTL is expecting the virtual
address space for the page table to be flushed after initialization, so we must also
add a flush statement there.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
index 4daaa6f5566888..9c571185395f49 100644
--- a/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen8_ppgtt.c
@@ -570,6 +570,7 @@ xehpsdv_ppgtt_insert_huge(struct i915_address_space *vm,
 			}
 		} while (rem >= page_size && index < max);
 
+		drm_clflush_virt_range(vaddr, PAGE_SIZE);
 		vma_res->page_sizes_gtt |= page_size;
 	} while (iter->sg && sg_dma_len(iter->sg));
 }
@@ -707,7 +708,7 @@ static void gen8_ppgtt_insert(struct i915_address_space *vm,
 	struct sgt_dma iter = sgt_dma(vma_res);
 
 	if (vma_res->bi.page_sizes.sg > I915_GTT_PAGE_SIZE) {
-		if (HAS_64K_PAGES(vm->i915))
+		if (GRAPHICS_VER_FULL(vm->i915) >= IP_VER(12, 50))
 			xehpsdv_ppgtt_insert_huge(vm, vma_res, &iter, cache_level, flags);
 		else
 			gen8_ppgtt_insert_huge(vm, vma_res, &iter, cache_level, flags);

-- 
2.34.1
