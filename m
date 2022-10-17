Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A4A600ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiJQJdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJQJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:33:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C108F5AA16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999180; x=1697535180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JEcLb6X6ZbdiyJg/wD23ZbxE1Ia5HJhKof7dQaZ62+0=;
  b=lT5vhBu0RWIm+b3ZiSz3PqoK3NAJ9LbXO07/zGGeOyfITp6qXxlVMqHT
   tfjx7pqEZTLLq4oZpwVvuR5vmQbH2UwL1ETqCACeuZY2/QIqYBtzFEMc1
   Ac0TIbMbd9580A8rq4O1LP7dOkaOGSq0Hlh8dY4wxTCG/Q632TyxbNWBq
   rgx0tOfr/BMK9KjxX8CSZyn258clRIB37iaJzjORXNDsgoKzYPI60jX3r
   cu44bFr5sE81JMgi8VUu7S3ULEPzP6Qpi2QFqwgGWO1SjhsdY91bqZrF6
   Lxu6QfKmuaNtvtJehdmLrhIGldBeZ2i/YFxDt+d55spof+UaINeqXbTKb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741659"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741659"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431340"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431340"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:56 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 9/9] drm/i915: Use kmap_local_page() in gem/i915_gem_execbuffer.c
Date:   Mon, 17 Oct 2022 17:37:25 +0800
Message-Id: <20221017093726.2070674-10-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page()[1].

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption.

In i915_gem_execbuffer.c, eb->reloc_cache.vaddr is mapped by
kmap_atomic() in eb_relocate_entry(), and is unmapped by
kunmap_atomic() in reloc_cache_reset().

And this mapping/unmapping occurs in two places: one is in
eb_relocate_vma(), and another is in eb_relocate_vma_slow().

The function eb_relocate_vma() or eb_relocate_vma_slow() doesn't
need to disable pagefaults and preemption during the above mapping/
unmapping.

So it can simply use kmap_local_page() / kunmap_local() that can
instead do the mapping / unmapping regardless of the context.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 845023c14eb3..8263d4e6620a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1110,7 +1110,7 @@ static void reloc_cache_unmap(struct reloc_cache *cache)
 
 	vaddr = unmask_page(cache->vaddr);
 	if (cache->vaddr & KMAP)
-		kunmap_atomic(vaddr);
+		kunmap_local(vaddr);
 	else
 		io_mapping_unmap_atomic((void __iomem *)vaddr);
 }
@@ -1126,7 +1126,7 @@ static void reloc_cache_remap(struct reloc_cache *cache,
 	if (cache->vaddr & KMAP) {
 		struct page *page = i915_gem_object_get_page(obj, cache->page);
 
-		vaddr = kmap_atomic(page);
+		vaddr = kmap_local_page(page);
 		cache->vaddr = unmask_flags(cache->vaddr) |
 			(unsigned long)vaddr;
 	} else {
@@ -1156,7 +1156,7 @@ static void reloc_cache_reset(struct reloc_cache *cache, struct i915_execbuffer
 		if (cache->vaddr & CLFLUSH_AFTER)
 			mb();
 
-		kunmap_atomic(vaddr);
+		kunmap_local(vaddr);
 		i915_gem_object_finish_access(obj);
 	} else {
 		struct i915_ggtt *ggtt = cache_to_ggtt(cache);
@@ -1188,7 +1188,7 @@ static void *reloc_kmap(struct drm_i915_gem_object *obj,
 	struct page *page;
 
 	if (cache->vaddr) {
-		kunmap_atomic(unmask_page(cache->vaddr));
+		kunmap_local(unmask_page(cache->vaddr));
 	} else {
 		unsigned int flushes;
 		int err;
@@ -1210,7 +1210,7 @@ static void *reloc_kmap(struct drm_i915_gem_object *obj,
 	if (!obj->mm.dirty)
 		set_page_dirty(page);
 
-	vaddr = kmap_atomic(page);
+	vaddr = kmap_local_page(page);
 	cache->vaddr = unmask_flags(cache->vaddr) | (unsigned long)vaddr;
 	cache->page = pageno;
 
-- 
2.34.1

