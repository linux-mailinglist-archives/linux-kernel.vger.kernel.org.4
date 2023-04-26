Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A86EFC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbjDZV3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjDZV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF543A9C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682544572; x=1714080572;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=HQr3QuWfqr8HjkBvQXdQGVL0T9pRPRkx4Ddqy9aDMLw=;
  b=TsjlQHYeYt983WcttMSx1EvHnNVS2NkUVf5Da789Q8XaKXW2Q0Epz0TM
   DxteRu5d6TkodH5jJ2pyYOzVz/BqiogoYphXpLwyDkKvs04AX0SWqd1t2
   eDLFiDOuxKV10/H2RnrpbgwkG0RzEP+ZoYRH3vZtH5/iqmp6EmdQoxbQN
   fHTCVoDVtyM3JfWKv5JXkUT6JGpXo2joF43HjKeY2F20hzS7OTneMkjtD
   Cd/RN9J6nREF8p7258Gc+Y98e8weLiarFQ6oXOFqmnF2b4doFRO7OsAM+
   dwVhs3R/FAm3WOJlfakWvKw/Ip9Rj904trEc8xMh7QDXIyK7+me7/wmpu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344691051"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="344691051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805679888"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="805679888"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:30 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 26 Apr 2023 23:28:49 +0200
Subject: [PATCH v8 2/2] drm/i915: Use correct huge page manager for MTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230425-hugepage-migrate-v8-2-7868d54eaa27@intel.com>
References: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
In-Reply-To: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

MTL currently uses gen8_ppgtt_insert_huge when managing huge pages.
This is because MTL reports as not supporting 64K pages, or more
accurately, the system that reports whether a platform has 64K pages
reports false for MTL.  This is only half correct, as the 64K page support
reporting system only cares about 64K page support for LMEM, which MTL
doesn't have.

MTL should be using xehpsdv_ppgtt_insert_huge.  However, simply changing
over to using that manager doesn't resolve the issue because MTL is
expecting the virtual address space for the page table to be flushed after
initialization, so we must also add a flush statement there.

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
