Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C182600AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJQJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJQJcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:32:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B9446632
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999164; x=1697535164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qa17WTfuPuByL/pGxqJjZfPv2fBRDy/8RHd7BwsgD1E=;
  b=AoE485pcIrMn+qUcfTmyZ55ZUcGRRjDdAIMlg6nPbId6mCkR1PMayGiX
   yA/4Y5zJ/4Ko50nVGRf6C0M3SKP3bauloEu1bOOZGxc4JbytLDEHqPg+p
   gBMQOP9+3Oi8N+UHAqoF1GgZyHnpHGS0vY6ySVHZHKUr27xmHJK4cmMoP
   3ByHnNk6/fCOW45oruW1uDTra2wTji9BxhkKWv57iDKYou7imQtZPBcno
   eIHiF2sg4otnbT8Y5UsUF1+hORorSWENHr1fzK/VvLzl3qUwRIJXvG8ys
   VsVwPgP21LGHWIx9a2oA3DW4gG9xJSylEUucX6MsDd2Tlb2eZJu8TiUsx
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741608"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741608"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431281"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431281"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:39 -0700
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
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 5/9] drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_coherency.c
Date:   Mon, 17 Oct 2022 17:37:21 +0800
Message-Id: <20221017093726.2070674-6-zhao1.liu@linux.intel.com>
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

In drm/i915/gem/selftests/i915_gem_coherency.c, functions cpu_set()
and cpu_get() mainly uses mapping to flush cache and assign the value.
There're 2 reasons why cpu_set() and cpu_get() don't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe for CPU hotplug when preemption is not
disabled. cpu_set() and cpu_get() call drm_clflush_virt_range() to use
CLFLUSHOPT or WBINVD to flush. Since CLFLUSHOPT is global on x86 and
WBINVD is called on each cpu in drm_clflush_virt_range(), the flush
operation is global and any issue with cpu's being added or removed
can be handled safely.

2. Any context switch caused by preemption or sleep (pagefault may
cause sleep) doesn't affect the validity of local mapping.

Therefore, cpu_set() and cpu_get() are functions where the use of
kmap_local_page() in place of kmap_atomic() is correctly suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Dave: Referred to his explanation about cache flush.
  Ira: Referred to his task document, review comments and explanation about
       cache flush.
  Fabio: Referred to his boiler plate commit message.
---
 .../gpu/drm/i915/gem/selftests/i915_gem_coherency.c  | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
index a666d7e610f5..b12402c74424 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_coherency.c
@@ -24,7 +24,6 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 {
 	unsigned int needs_clflush;
 	struct page *page;
-	void *map;
 	u32 *cpu;
 	int err;
 
@@ -34,8 +33,7 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 		goto out;
 
 	page = i915_gem_object_get_page(ctx->obj, offset >> PAGE_SHIFT);
-	map = kmap_atomic(page);
-	cpu = map + offset_in_page(offset);
+	cpu = kmap_local_page(page) + offset_in_page(offset);
 
 	if (needs_clflush & CLFLUSH_BEFORE)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
@@ -45,7 +43,7 @@ static int cpu_set(struct context *ctx, unsigned long offset, u32 v)
 	if (needs_clflush & CLFLUSH_AFTER)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
 
-	kunmap_atomic(map);
+	kunmap_local(cpu);
 	i915_gem_object_finish_access(ctx->obj);
 
 out:
@@ -57,7 +55,6 @@ static int cpu_get(struct context *ctx, unsigned long offset, u32 *v)
 {
 	unsigned int needs_clflush;
 	struct page *page;
-	void *map;
 	u32 *cpu;
 	int err;
 
@@ -67,15 +64,14 @@ static int cpu_get(struct context *ctx, unsigned long offset, u32 *v)
 		goto out;
 
 	page = i915_gem_object_get_page(ctx->obj, offset >> PAGE_SHIFT);
-	map = kmap_atomic(page);
-	cpu = map + offset_in_page(offset);
+	cpu = kmap_local_page(page) + offset_in_page(offset);
 
 	if (needs_clflush & CLFLUSH_BEFORE)
 		drm_clflush_virt_range(cpu, sizeof(*cpu));
 
 	*v = *cpu;
 
-	kunmap_atomic(map);
+	kunmap_local(cpu);
 	i915_gem_object_finish_access(ctx->obj);
 
 out:
-- 
2.34.1

